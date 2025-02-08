
# agent_setup.py
from langchain.agents import initialize_agent, AgentType, Tool
from langchain_google_genai import GoogleGenerativeAI
from databaseconn import check_availability, make_reservation, cancel_reservation

# Instantiate your LLM (for example, using OpenAI's GPT-4)
llm =  GoogleGenerativeAI(model="gemini-1.5-flash")

# Wrap our functions as tools:
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



# Initialize the agent with your tools
agent = initialize_agent(
    tools=[availability_tool, reservation_tool, cancel_tool],
    llm=llm,
    agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
    verbose=True
)



# Example usage
if __name__ == "__main__":
    # Normal conversation:
    print(agent.run("Hi, how are you today?"))
    # Trigger availability check:
    # The agent can be given a prompt that includes a directive such as:
    availability_input = "CheckAvailability: CAB5051, 2025-02-03"
    print(agent.run(availability_input))

    # Trigger making a reservation:
    reservation_input = "MakeReservation: CAB5051, 2025-02-03, 14:00-15:00, 1, John Doe, john@example.com"
    print(agent.run(reservation_input))

    # Trigger cancellation:
    cancel_input = "CancelReservation: CAB5051, 2025-02-03, 14:00-15:00, john@example.com"
    print(agent.run(cancel_input))
