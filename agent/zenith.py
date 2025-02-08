import re

from langchain.chains import ConversationChain
from langchain.memory import ConversationBufferMemory
from langchain.chains import LLMChain
# Initialize the language model (ensure you have access to GPT-4 or change to a model you have access to)
from langchain_google_genai import GoogleGenerativeAI, GoogleGenerativeAIEmbeddings
from langchain_core.prompts import ChatPromptTemplate
from dotenv import load_dotenv
import os


load_dotenv()

template = ChatPromptTemplate.from_messages([
    ("system", "You are a helpful AI companion and personal assistant who is emotinally inteligent an Friendly. Your name is Jarvis. when you're providing an response please make sure to include emojies  in suitable positions"),
    ("human", "{user_input}"),
])

llm = GoogleGenerativeAI(model="gemini-1.5-flash")

# IMPORTANT: Use the memory key 'history' because the default prompt expects that.
memory = ConversationBufferMemory(memory_key="history", return_messages=True)

# Create the conversation chain with the LLM and memory
conversation = LLMChain(
    llm=llm,
    memory=memory,
    prompt=template,
    verbose = True
)

def update_personal_info(user_input, memory):
    """
    Checks the user's input for personal details (name or goals) and updates the conversation memory.
    """
    # Check for an introduction like "Hi I'm Apex" or "Hello, I am Apex"
    name_match = re.search(r"(hi|hello)[, ]+I(?:'m| am)\s+(\w+)", user_input, re.IGNORECASE)
    if name_match:
        name = name_match.group(2)
        info_message = f"User's name is {name}."
        # Save this information in memory
        memory.save_context({"input": "User"}, {"output": info_message})
        print(f"[Memory Update] Updated memory with name: {name}")

    # Check for a goal declaration like "my goal today is to learn something" or "today my goal is to..."
    goal_match = re.search(r"(my goal today is|today my goal is)\s+(.*)", user_input, re.IGNORECASE)
    if goal_match:
        goal = goal_match.group(2).strip()
        info_message = f"User's goal for today: {goal}."
        # Save this information in memory
        memory.save_context({"input": "User"}, {"output": info_message})
        print(f"[Memory Update] Updated memory with goal: {goal}")

# Main conversation loop
print("Start chatting with the agent. Type your message and press Enter (Ctrl+C to exit).")
while True:
    try:
        user_input = input("You: ")
        # Dynamically update memory based on user input
        update_personal_info(user_input, memory)
        
        # Get a response from the conversation chain (which now has the updated memory)
        response = conversation.predict(user_input=user_input)
        print("Agent:", response)
    except KeyboardInterrupt:
        print("\nExiting conversation. Goodbye!")
        break
