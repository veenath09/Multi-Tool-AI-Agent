# Install required packages
# pip install langchain python-dotenv

from langchain.memory import ConversationBufferMemory
from langchain_google_genai import GoogleGenerativeAI  # Replace with your local LLM
from langchain.chains import ConversationChain
from langchain.prompts import PromptTemplate
from typing import Dict, List, Any
import os
from dotenv import load_dotenv
load_dotenv()


os.environ['GOOGLE_API_KEY']= os.getenv("GOOGLE_API_KEY")

# Custom Memory Class
class DynamicEntityMemory(ConversationBufferMemory):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.entities: Dict[str, str] = {}  # Store custom entities (name/goals)

    def _extract_entities(self, input_str: str):
        # Update name
        if "i'm " in input_str.lower():
            name = input_str.split("i'm ")[-1].split()[0].strip()
            self.entities["name"] = name
        
        # Update goal
        if "my goal today is " in input_str.lower():
            goal = input_str.split("my goal today is ")[-1].strip()
            self.entities["goal"] = goal

    def save_context(self, inputs: Dict[str, Any], outputs: Dict[str, str]) -> None:
        # Extract entities before saving context
        self._extract_entities(inputs["input"])
        return super().save_context(inputs, outputs)

# Initialize Memory & LLM
memory = DynamicEntityMemory()
llm = GoogleGenerativeAI(model="gemini-1.5-flash")  # Replace with your local LLM path

# Custom Prompt Template
template = """
The following context is available:
{% if memory.entities.name %}Name: {{ memory.entities.name }}{% endif %}
{% if memory.entities.goal %}Goal: {{ memory.entities.goal }}{% endif %}

Conversation History:
{{ history }}

Human: {{ input }}
AI:
"""
prompt = PromptTemplate.from_template(template)

# Initialize Conversation Chain
conversation = ConversationChain(
    llm=llm,
    memory=memory,
    verbose=True
)

# Function to Run the Conversation
def run_conversation(input_text: str):
    response = conversation.run(
        prompt.format(
            input=input_text,
            history=memory.buffer,
            memory=memory
        )
    )
    print(f"AI: {response}")

# Example Usage
run_conversation("Hi I'm Apex")
run_conversation("My goal today is to learn about AI memory systems")
run_conversation("What's my current objective?")