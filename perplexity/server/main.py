from fastapi import FastAPI
from pydantic_models.chat_body import ChatBody

app = FastAPI()


@app.get("/")
def hello():
    return "Hello World!"


@app.post("/chat")
def chat_endpoint(body: ChatBody):
    print(body.query)
    # search the web and find appropriate sources
    # sort the sources
    # generate the response using LLM
    return body.query

