# agent_setup.py
from langchain.agents import initialize_agent, AgentType, Tool
from langchain.memory import ConversationBufferMemory
from langchain_google_genai import GoogleGenerativeAI
from databaseconn import check_availability, make_reservation, cancel_reservation

# Instantiate LLM (Google Gemini API)
llm = GoogleGenerativeAI(model="gemini-1.5-flash")

# Initialize Memory (Chat History)
memory = ConversationBufferMemory(memory_key="chat_history", return_messages=True)

# System Prompt to Guide the Agent
system_prompt = """
You are an AI assistant that is friendly, engaging, and emotionally intelligent 😊. 
"History" user chat history to make be friendly and know the users name{chat_history}

**🌍 General Chat Mode:**  
- Respond naturally to conversations.  
- Show emotions using emojis.  
- Remember past chats to maintain context.

**🚗 Reservation Handling:**  
- If a user asks about vehicle reservations (availability, booking, or cancellations), process accordingly.  
- Otherwise, continue as a friendly chatbot.
"""

# Define Tools for the Agent
availability_tool = Tool(
    name="CheckAvailability",
    func=lambda vehicle_name, date: str(check_availability(vehicle_name, date)),
    description="Check available timeslots for a given vehicle on a specific date. Input format: vehicle_name, date (YYYY-MM-DD)."
)

reservation_tool = Tool(
    name="MakeReservation",
    func=lambda vehicle_name, date, timeslot, vehicle_id, reserver, reserver_email:
        make_reservation(vehicle_name, date, timeslot, vehicle_id, reserver, reserver_email),
    description="Make a reservation. Input format: vehicle_name, date (YYYY-MM-DD), timeslot (e.g., '14:00-15:00'), vehicle_id, reserver name, reserver_email."
)

cancel_tool = Tool(
    name="CancelReservation",
    func=lambda vehicle_name, date, timeslot, reserver_email: str(cancel_reservation(vehicle_name, date, timeslot, reserver_email)),
    description="Cancel a reservation. Input format: vehicle_name, date (YYYY-MM-DD), timeslot, reserver_email."
)

chat_tool = Tool(
    name="Chat",
    func=lambda message: llm.invoke(message),  # Uses LLM for normal chat
    description="Engage in a friendly conversation. Can discuss general topics and remember past chats."
)

# Initialize the AI Agent with Memory
agent = initialize_agent(
    tools=[availability_tool, reservation_tool, cancel_tool, chat_tool],
    llm=llm,
    agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
    verbose=True,
    memory=memory  # Attach memory to retain conversation history
)

# Live Chat Simulation (With Memory)
if __name__ == "__main__":
    print("🚀 AI Chatbot Ready! (Type 'exit' to quit)")

    while True:
        user_input = input("You: ")

        if user_input.lower() == "exit":
            print("Goodbye! 👋")
            break

        response = agent.run(user_input)
        print("AI:", response)
