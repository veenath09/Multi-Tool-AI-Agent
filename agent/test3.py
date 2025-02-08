import re
import os
from dotenv import load_dotenv

# Import necessary LangChain modules and tools
from langchain.agents import initialize_agent, AgentType, Tool
from langchain_google_genai import GoogleGenerativeAI
from langchain.memory import ConversationBufferMemory
from langchain.prompts import PromptTemplate
from langchain_community.tools import TavilySearchResults

# Import your custom database functions
from databaseconn import check_availability, make_reservation, cancel_reservation

# Load environment variables (make sure your .env file contains TAVILY_API_KEY, etc.)
load_dotenv()
os.environ["TAVILY_API_KEY"] = os.getenv("TAVILY_API_KEY")

# Initialize conversation memory; this stores the entire chat history under "chat_history"
memory = ConversationBufferMemory(memory_key="chat_history")

# Define a custom system prompt template that includes explicit instructions about emoji usage,
# conversation style, and how to incorporate chat history.
system_prompt = PromptTemplate(
    input_variables=["chat_history", "user_input"],
    template=(
        "You are Jarvis, a friendly and emotionally intelligent assistant 😊. "
        "Always use emojis in your responses and be warm and conversational. \n\n"
        "Remember details from previous interactions and use them when applicable. \n"
        "Only use the search tool when the user explicitly requests a search; otherwise, just chat. \n\n"
        "Chat history so far:\n{chat_history}\n\n"
        "User: {user_input}\n\n"
        "You are capable of making reservations, checking availability, canceling reservations, "
        "and searching the web when needed. \n"
        "When you make a tool call to the database, ensure the SQL data follows the format:\n"
        "TABLE VehicleReservations (\n"
        "    VehicleID INT(50) AUTO_INCREMENT PRIMARY KEY,\n"
        "    VehicleName VARCHAR(50),\n"
        "    Date DATE,\n"
        "    Timeslot VARCHAR(50),\n"
        "    Status VARCHAR(50),\n"
        "    ReservedBy VARCHAR(100),\n"
        "    Reserver_Email VARCHAR(100)\n"
        ");\n\n"
        "Please respond in a friendly, emoji-rich, and conversational manner.\n\n"
        "Please stop the thought and provide the response if you were able fetch information though actions\n\n"
        "Assistant:"
    ),
)

# Instantiate the LLM (using your preferred model)
llm = GoogleGenerativeAI(model="gemini-1.5-flash")

# -------------------------------
# Define functions for tool wrappers
# -------------------------------

def check_availability_wrapper(query: str):
    try:
        vehicle_name, date = query.split(", ")
        return str(check_availability(vehicle_name.strip(), date.strip()))
    except ValueError:
        return "Invalid input format. Expected: vehicle_name, date (YYYY-MM-DD)."

def make_reservation_wrapper(query: str):
    try:
        vehicle_name, date, timeslot, vehicle_id, reserver, reserver_email = query.split(", ")
        # Optionally update memory with the user's name
        memory.save_context({"user": reserver}, {"response": f"Reservation requested by {reserver}."})
        return make_reservation(vehicle_name.strip(), date.strip(), timeslot.strip(),
                                vehicle_id.strip(), reserver.strip(), reserver_email.strip())
    except ValueError:
        return ("Invalid input format. Expected: vehicle_name, date (YYYY-MM-DD), timeslot "
                "(e.g., 14:00-15:00), vehicle_id, reserver name, reserver_email.")

def cancel_reservation_wrapper(query: str):
    try:
        vehicle_name, date, timeslot, reserver_email = query.split(", ")
        return cancel_reservation(vehicle_name.strip(), date.strip(), timeslot.strip(), reserver_email.strip())
    except ValueError:
        return "Invalid input format. Expected: vehicle_name, date (YYYY-MM-DD), timeslot, reserver_email."

# Initialize the Tavily search tool
tavily_search = TavilySearchResults(max_results=1)

def search_function(user_input: str):
    try:
        return tavily_search.invoke({"query": user_input})
    except Exception as e:
        return f"Search error: {str(e)}"

# -------------------------------
# Define a dedicated "Chat" tool to handle pure conversation.
# This tool calls the LLM with the current conversation context.
# -------------------------------
def chat_function(user_input: str):
    # Build the prompt using the system prompt template and current memory
    prompt_text = system_prompt.format(chat_history=memory.buffer, user_input=user_input)
    # Call the LLM directly with the built prompt
    response = llm(prompt_text)
    return response

chat_tool = Tool(
    name="Chat",
    func=chat_function,
    description="Engage in a friendly chat conversation with the assistant. "
                "This tool should be used for general conversation."
)

# -------------------------------
# Define the tools available to the agent
# -------------------------------
availability_tool = Tool(
    name="CheckAvailability",
    func=check_availability_wrapper,
    description="Check available timeslots for a given vehicle on a specific date. Input format: 'vehicle_name, date (YYYY-MM-DD)'."
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

search_tool = Tool(
    name="Search",
    func=search_function,
    description="Search for information on the web. Input format: 'search_query'."
)

# Include the "Chat" tool in the list of tools. This allows the agent to decide when to just chat.
tools = [availability_tool, reservation_tool, cancel_tool, search_tool, chat_tool]

# -------------------------------
# Initialize the agent with tools, memory, and additional parameters.
# -------------------------------
agent = initialize_agent(
    tools=tools,
    llm=llm,
    agent=AgentType.CONVERSATIONAL_REACT_DESCRIPTION   ,
    memory=memory,
    prompt=system_prompt,
    handle_parsing_errors=True,
    verbose=True,
    max_execution_time=60,    # Maximum allowed execution time (in seconds)
    early_stopping_method="force"
)

# -------------------------------
# Interactive Chat Mode
# -------------------------------
if __name__ == "__main__":
    print("🚗 AI Reservation Assistant (Jarvis) is ready! Type 'exit' to quit.\n")
    
    while True:
        user_input = input("You: ")
        if user_input.lower() in ["exit", "quit", "bye"]:
            print("👋 Goodbye! Have a great day! 😊")
            break  # Exit the loop
        
        try:
            # Optionally update personal information in memory based on the input
            # For example, capture greetings or goals:
            name_match = re.search(r"(hi|hello)[, ]+I(?:'m| am)\s+(\w+)", user_input, re.IGNORECASE)
            if name_match:
                name = name_match.group(2)
                memory.save_context({"user_input": "User"}, {"response": f"User's name is {name}."})
                print(f"[Memory Update] Remembering your name: {name} 😊")
            
            goal_match = re.search(r"(my goal today is|today my goal is)\s+(.*)", user_input, re.IGNORECASE)
            if goal_match:
                goal = goal_match.group(2).strip()
                memory.save_context({"user_input": "User"}, {"response": f"User's goal for today: {goal}."})
                print(f"[Memory Update] Tracking your goal: {goal} 🎯")

            # Use the agent's run() method so that the conversation memory is injected properly.
            response = agent.run(user_input)
        except Exception as e:
            response = f"Oops! Something went wrong: {str(e)} 😥"
        
        print(f"Assistant: {response}\n")
        # Debug: Optionally print the current conversation memory for verification
        print(f"[DEBUG] Conversation Memory:\n{memory.buffer}\n")
