import re
from langchain.agents import initialize_agent, AgentType, Tool
from langchain_google_genai import GoogleGenerativeAI
from databaseconn import check_availability, make_reservation, cancel_reservation
from langchain.memory import ConversationBufferMemory
from langchain.prompts import PromptTemplate
from langchain_community.tools import TavilySearchResults
import os 
from dotenv import load_dotenv

# Load environment variables
load_dotenv()
os.environ["TAVILY_API_KEY"] = os.getenv("TAVILY_API_KEY")

# Initialize the conversation memory
memory = ConversationBufferMemory(memory_key="chat_history")

# Custom system prompt template for better responses
system_prompt = PromptTemplate(
    input_variables=["chat_history", "user_input"],
    template=(
        "You are a friendly and emotionally intelligent human assistant named Jarvis 😊 please make sure to add emojies when nessasary"
        "Remember user details from previous interactions when applicable. "
        "Only use the search tool when user request to search something. otherwise just chat"
        "Chat history: {chat_history}\n"
        "User: {user_input}\n"
        "You are capable of making reservations, check the availability and calcel the reservations and search in the web as well"
        """the data in the database is sotred in the following format when you're making a tool call to the database please make sure that 
        the sql data is in following format
        ensure to make the inputs be berent in the following format
        TABLE VehicleReservations (
        VehicleID INT(50) AUTO_INCREMENT PRIMARY KEY,
        VehicleName VARCHAR(50) ,
        Date DATE ,
        Timeslot VARCHAR(50) ,
        Status VARCHAR(50),
        ReservedBy VARCHAR(100),
        Reserver_Email VARCHAR(100) ;
)

        """
        "Assistant:"
        "Always ensure to provide an chat output to make it more conversational"
    ),
)

# Instantiate the LLM
llm = GoogleGenerativeAI(model="gemini-1.5-flash")


def update_personal_info(user_input):
    """
    Detects user introductions and goals, then stores them in memory.
    """
    name_match = re.search(r"(hi|hello)[, ]+I(?:'m| am)\s+(\w+)", user_input, re.IGNORECASE)
    if name_match:
        name = name_match.group(2)
        memory.save_context({"user_input": "User"}, {"response": f"User's name is {name}."})
        print(f"[Memory Update] Remembering your name: {name}")

    goal_match = re.search(r"(my goal today is|today my goal is)\s+(.*)", user_input, re.IGNORECASE)
    if goal_match:
        goal = goal_match.group(2).strip()
        memory.save_context({"user_input": "User"}, {"response": f"User's goal for today: {goal}."})
        print(f"[Memory Update] Tracking your goal: {goal}")

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
        # Save the user's name in memory (if needed)
        memory.save_context({"user": reserver}, {})
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


tavily_search = TavilySearchResults(max_results=1)


def search_function(user_input: str):
    try:
        return tavily_search.invoke({"query": user_input})
    except Exception as e:
        return f"Search error: {str(e)}"


availability_tool = Tool(
    name="CheckAvailability",
    func=check_availability_wrapper,
    description="Check available timeslots for a given vehicle on a specific date. "
                "Input format: 'vehicle_name', 'date (YYYY-MM-DD)'."
)

reservation_tool = Tool(
    name="MakeReservation",
    func=make_reservation_wrapper,
    description="Make a reservation. Input format: 'vehicle_name, date (YYYY-MM-DD), "
                "timeslot (e.g., 14:00-15:00), vehicle_id, reserver name, reserver_email'."
)

cancel_tool = Tool(
    name="CancelReservation",
    func=cancel_reservation_wrapper,
    description="Cancel a reservation. Input format: 'vehicle_name, date (YYYY-MM-DD), "
                "timeslot, reserver_email'."
)

search_tool = Tool(
    name="Search",
    func=search_function,
    description="Search for information on the web. Input format: 'search_query'."
)


agent = initialize_agent(
    tools=[availability_tool, reservation_tool, cancel_tool, search_tool],
    llm=llm,
    agent=AgentType.CHAT_ZERO_SHOT_REACT_DESCRIPTION ,
    memory=memory,            
    prompt=system_prompt, 
    handle_parsing_errors=True,    
    verbose=True,
    max_execution_time=60,    # Maximum allowed execution time (in seconds)
    early_stopping_method="force"
     
)

# Interactive Chat Mode
if __name__ == "__main__":
    print("🚗 AI Reservation Assistant is ready! Type 'exit' to quit.\n")
    
    while True:
        user_input = input("You: ")
        if user_input.lower() in ["exit", "quit", "bye"]:
            print("👋 Goodbye! Have a great day!")
            break  # Exit the loop
        
        try:
            update_personal_info(user_input)
            # Use agent.invoke() to process the user input
            response = agent.invoke(user_input)
        except Exception as e:
            response = f"Oops! Something went wrong: {str(e)} 😥"
        
        print(f"Assistant: {response}\n")
