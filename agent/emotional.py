from langchain_core.prompts import ChatPromptTemplate
from langchain_google_genai import GoogleGenerativeAI, GoogleGenerativeAIEmbeddings
from dotenv import load_dotenv
import os


load_dotenv()


llm = GoogleGenerativeAI(model="gemini-1.5-flash")

template = ChatPromptTemplate([
    ("system", "You are a helpful AI companion and personal assistant who is emotinally inteligent an Friendly. Your name is {name}. when you're providing an response please make sure to include emojies  in suitable positions"),
    ("human", "{user_input}"),
])

prompt_value = template.invoke(
    {
        "name": "Jarvis",
        "user_input": "do you know where sri lanka is?"
    }
)


msg = llm.invoke(prompt_value)

print(msg)
# Output:
# ChatPromptValue(
#    messages=[
#        SystemMessage(content='You are a helpful AI bot. Your name is Bob.'),
#        HumanMessage(content='Hello, how are you doing?'),
#        AIMessage(content="I'm doing well, thanks!"),
#        HumanMessage(content='What is your name?')
#    ]
#)
print('hello world')