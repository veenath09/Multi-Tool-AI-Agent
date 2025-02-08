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

# Load environment variables
load_dotenv()
os.environ["TAVILY_API_KEY"] = os.getenv("TAVILY_API_KEY")

# Initialize conversation memory
memory = ConversationBufferMemory(memory_key="chat_history")

# Define system prompt
system_prompt = PromptTemplate(
    input_variables=["chat_history", "user_input"],
    template=(
        "You are Jarvis, a friendly and emotionally intelligent assistant 😊. "
        "Always use emojis in your responses and be warm and conversational.\n\n"
        "Remember details from previous interactions and use them when applicable.\n"
        "Only use the search tool when the user explicitly requests a search; otherwise, just chat.\n\n"
        "Chat history so far:\n{chat_history}\n\n"
        "User: {user_input}\n\n"
        "You are capable of making reservations, checking availability, canceling reservations, "
        "and searching the web when needed.\n\n"
        "Please respond in a friendly, emoji-rich, and conversational manner.\n\n"
        "Please stop the thought and provide the response if you were able to fetch information through actions.\n\n"
        "Assistant:"
    ),
)

# Instantiate the LLM
llm = GoogleGenerativeAI(model="gemini-1.5-flash")

# Function Wrappers
def check_availability_wrapper(query: str):
    try:
        vehicle_name, date = query.split(", ")
        return str(check_availability(vehicle_name.strip(), date.strip()))
    except ValueError:
        return "Invalid input format. Expected: vehicle_name, date (YYYY-MM-DD)."

def make_reservation_wrapper(query: str):
    try:
        vehicle_name, date, timeslot, vehicle_id, reserver, reserver_email = query.split(", ")
        memory.save_context({"user": reserver}, {"response": f"Reservation requested by {reserver}."})
        return make_reservation(vehicle_name.strip(), date.strip(), timeslot.strip(),
                                vehicle_id.strip(), reserver.strip(), reserver_email.strip())
    except ValueError:
        return "Invalid input format. Expected: vehicle_name, date (YYYY-MM-DD), timeslot, vehicle_id, reserver name, reserver_email."

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

def chat_function(user_input: str):
    prompt_text = system_prompt.format(chat_history=memory.buffer, user_input=user_input)
    response = llm.invoke(prompt_text)
    return response

# Define Tools
availability_tool = Tool(
    name="CheckAvailability",
    func=check_availability_wrapper,
    description="Check available timeslots for a given vehicle on a specific date."
)

reservation_tool = Tool(
    name="MakeReservation",
    func=make_reservation_wrapper,
    description="Make a reservation for a vehicle."
)

cancel_tool = Tool(
    name="CancelReservation",
    func=cancel_reservation_wrapper,
    description="Cancel a vehicle reservation."
)

search_tool = Tool(
    name="Search",
    func=search_function,
    description="Search for information on the web."
)

chat_tool = Tool(
    name="Chat",
    func=chat_function,
    description="Engage in a friendly chat conversation with the assistant."
)

# Initialize the Agent
agent = initialize_agent(
    tools=[availability_tool, reservation_tool, cancel_tool, search_tool, chat_tool],
    llm=llm,
    agent=AgentType.CHAT_ZERO_SHOT_REACT_DESCRIPTION,
    memory=memory,
    prompt=system_prompt,
    handle_parsing_errors=True,
    verbose=True,
    max_execution_time=60,
    early_stopping_method="force"
)
