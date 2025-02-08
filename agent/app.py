"Using for the backend server to handle the request from the frontend and send it to the agent for processing."
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import asyncio
from AgentBackend import agent, rewrite_prompt, chat_function, memory  # Import relevant functions and agent

app = FastAPI()

# ✅ Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow requests from any frontend
    allow_credentials=True,
    allow_methods=["*"],  # Allow all HTTP methods (POST, GET, etc.)
    allow_headers=["*"],  # Allow all headers
)

class ChatRequest(BaseModel):
    user_input: str

@app.post("/chat")
async def chat(request: ChatRequest):
    """
    Handles incoming user input and sends it to the agent for processing.
    """
    print(f"Received request: {request.user_input}")  # Log input
    try:
        # First, rewrite the prompt using the `rewrite_prompt` function
        info = await asyncio.get_event_loop().run_in_executor(
            None, rewrite_prompt, request.user_input
        )
        print(f"Rewritten prompt: {info}")  # Log the rewritten prompt
        
        # Process the input with the agent or simple chat function
        if "invoke the agent" in info:
            response = await asyncio.get_event_loop().run_in_executor(
                None, agent.run, info.replace(" require to invoke", "")
            )
        else:
            response = await asyncio.get_event_loop().run_in_executor(
                None, chat_function, request.user_input
            )

        print(f"Agent response: {response}")  # Log output
        return {"response": response}
    
    except Exception as e:
        print(f"Error: {str(e)}")  # Log errors
        return {"response": f"Error: {str(e)}"}

@app.get("/")
async def root():
    """
    Simple endpoint to verify the server is running.
    """
    return {"message": "FastAPI server is running!"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000, reload=True)
