from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from test6 import agent  # Import your LangChain agent
import asyncio
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

""" @app.post("/chat")
async def chat(request: ChatRequest):
    try:
        # Await the asynchronous agent.run() function directly
        response = await agent.run(request.user_input)
        return {"response": response}
    except Exception as e:
        return {"response": f"Error: {str(e)}"}
 """

@app.post("/chat")
async def chat(request: ChatRequest):
    print(f"Received request: {request.user_input}")  # Log input
    try:
        response = await asyncio.get_event_loop().run_in_executor(
            None, agent.run, request.user_input
        )
        print(f"Agent response: {response}")  # Log output
        return {"response": response}
    except Exception as e:
        print(f"Error: {str(e)}")  # Log errors
        return {"response": f"Error: {str(e)}"}

@app.get("/")
async def root():
    return {"message": "FastAPI server is running!"}


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000, reload=True)
