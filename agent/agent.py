from langchain.agents import initialize_agent, AgentType, Tool
from langchain_google_genai import GoogleGenerativeAI
from databaseconn import check_availability, make_reservation, cancel_reservation
from langchain.memory import ConversationBufferMemory
from langchain.prompts import PromptTemplate

# Initialize the memory system
memory = ConversationBufferMemory(memory_key="chat_history")

# Custom system prompt template for better responses
system_prompt = PromptTemplate(
    input_variables=["chat_history", "user_input"],
    template=(
        "You are a friendly and emotionally intelligent assistant. "
        "Always respond warmly and use appropriate emojis 😊. "
        "Remember user details from previous interactions when applicable. "
        "Chat history: {chat_history}\n"
        "User: {user_input}\n"
        "Assistant:"
    ),
)

# Instantiate your LLM
llm = GoogleGenerativeAI(model="gemini-1.5-flash")

# Wrap our functions as tools:
def check_availability_wrapper(query: str):
    try:
        vehicle_name, date = query.split(", ")
        return str(check_availability(vehicle_name.strip(), date.strip()))
    except ValueError:
        return "Invalid input format. Expected: vehicle_name, date (YYYY-MM-DD)."

def make_reservation_wrapper(query: str):
    try:
        vehicle_name, date, timeslot, vehicle_id, reserver, reserver_email = query.split(", ")
        # Save user's name in memory (if provided)
        memory.save_context({"user": reserver.strip()}, {})
        return make_reservation(vehicle_name.strip(), date.strip(), timeslot.strip(), vehicle_id.strip(), reserver.strip(), reserver_email.strip())
    except ValueError:
        return "Invalid input format. Expected: vehicle_name, date (YYYY-MM-DD), timeslot, vehicle_id, reserver name, reserver_email."

def cancel_reservation_wrapper(query: str):
    try:
        vehicle_name, date, timeslot, reserver_email = query.split(", ")
        return cancel_reservation(vehicle_name.strip(), date.strip(), timeslot.strip(), reserver_email.strip())
    except ValueError:
        return "Invalid input format. Expected: vehicle_name, date (YYYY-MM-DD), timeslot, reserver_email."

# Define tools for the agent
availability_tool = Tool(
    name="CheckAvailability",
    func=check_availability_wrapper,
    description="Check available timeslots for a given vehicle on a specific date. Input format: 'vehicle_name, date (YYYY-MM-DD)'"
)

reservation_tool = Tool(
    name="MakeReservation",
    func=make_reservation_wrapper,
    description="Make a reservation. Input format: 'vehicle_name, date (YYYY-MM-DD), timeslot (e.g., 14:00-15:00), vehicle_id, reserver name, reserver_email'."
)

cancel_tool = Tool(
    name="CancelReservation",
    func=cancel_reservation_wrapper,
    description="Cancel a reservation. Input format: 'vehicle_name, date (YYYY-MM-DD), timeslot, reserver_email'."
)

# Chat tool: For normal conversation
chat_tool = Tool(
    name="Chat",
    func=lambda x: x,  # Echo the input for chat mode
    description="Normal chat mode."
)

# Initialize the agent with tools, memory, and custom prompt
agent = initialize_agent(
    tools=[availability_tool, reservation_tool, cancel_tool, chat_tool],  # Added chat_tool here
    llm=llm,
    agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
    memory=memory,         # Conversation history is stored here
    prompt=system_prompt,  # Uses the custom chat prompt
    verbose=True
)

if __name__ == "__main__":
    print(" AI  Assistant is ready! Type 'exit' to quit.\n")
    
    # Using a for loop to keep the chat going indefinitely.
    # This loop will run until the user types an exit command.
    for _ in iter(int, 1):  # iter(int, 1) creates an infinite iterator
        user_input = input("You: ")

        # Check for exit commands
        if user_input.lower() in ["exit", "quit", "bye"]:
            print("👋 Goodbye! Have a great day!")
            break  # Exit the loop

        # Check if the user input appears to trigger an action
        if any(keyword in user_input.lower() for keyword in ["reserve", "book", "check availability", "cancel"]):
            try:
                response = agent.run(user_input, tools=[availability_tool, reservation_tool, cancel_tool])  # Action tools
            except Exception as e:
                response = f"Oops! Something went wrong: {str(e)} 😥"
        else:
            # Normal conversation mode
            try:
                response = agent.run(user_input, tools=[chat_tool])  # Chat tool is invoked for conversations
            except Exception as e:
                response = f"Oops! Something went wrong: {str(e)} 😥"

        print(f"Assistant: {response}\n")
