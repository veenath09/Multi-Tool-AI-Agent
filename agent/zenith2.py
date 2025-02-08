import re
import os
from dotenv import load_dotenv

from langchain_google_genai import GoogleGenerativeAI
from langchain.memory import ConversationBufferMemory
from langchain.chains import LLMChain
from langchain.prompts import PromptTemplate

# Load API keys
load_dotenv()

# Define prompt with explicit memory usage
prompt = PromptTemplate.from_template(
    """You are a friendly and emotionally intelligent human assistant named Jarvis 😊 please make sure to add emojies when nessasary.
    
    Conversation history:
    {history}
    
    Human: {user_input}
    AI:"""
)

# Initialize LLM
llm = GoogleGenerativeAI(model="gemini-1.5-flash")

# Use ConversationBufferMemory to retain memory throughout the session
memory = ConversationBufferMemory(memory_key="history")

# Create an LLMChain that maintains memory
conversation = LLMChain(
    llm=llm,
    prompt=prompt,
    memory=memory,
    verbose=True
)

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

# Start chat loop
print("Start chatting with Jarvis. Type your message and press Enter (Ctrl+C to exit).")
while True:
    try:
        user_input = input("You: ")
        
        # Store personal details dynamically
        update_personal_info(user_input)

        # Get AI response with persistent memory
        response = conversation.predict(user_input=user_input)
        print("Jarvis:", response)

    except KeyboardInterrupt:
        print("\nExiting conversation. Goodbye!")
        break
