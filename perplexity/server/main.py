import traceback

import uvicorn
from fastapi import FastAPI, WebSocket
import anyio.to_thread
from starlette.websockets import WebSocketDisconnect

from pydantic_models.chat_body import ChatBody
from services.search_service import SearchService
from services.sort_source_service import SortSourceService
from services.llm_service import LLMService

from langchain_core.prompts import ChatPromptTemplate
from langchain_ollama import OllamaLLM

app = FastAPI()

search_service = SearchService()
sort_service = SortSourceService()
llm_service = LLMService()


@app.get("/")
def hello():
    return "Hello World!"


@app.websocket("/ws/chat")
async def websocket_chat_endpoint(websocket: WebSocket):
    await websocket.accept()

    try:
        data = await websocket.receive_json()
        query = data.get("query")

        search_results = search_service.web_search(query)
        sorted_results = sort_service.sort_sources(query, search_results)
        await websocket.send_json({"type": "search_result", "data": sorted_results})

        response = await anyio.to_thread.run_sync(
            llm_service.generate_response,
            query,
            sorted_results
        )
        await websocket.send_json({"type": "llm_response", "data": response})
    except Exception as e:
        print("Unexpected error occurred:", e)
        traceback.print_exc()
        await websocket.send_json({"type": "error", "message": str(e)})
    finally:
        await websocket.close()


@app.post("/chat")
def chat_endpoint(body: ChatBody):
    print("----------------------- Query -----------------------")
    print(body.query)
    # search the web and find appropriate sources
    print("----------------------- Only LLM Generate Response -----------------------")
    llm_service.only_llm_generate_response(body.query)
    print("----------------------- Search Results -----------------------")
    search_results = search_service.web_search(body.query)
    # print(search_results)
    # sort the sources
    sorted_results = sort_service.sort_sources(body.query, search_results)
    print(f"sorted_results len : {len(sorted_results)}")
    for res in sorted_results:
        print(res['url'])
    print("======================= LLM Generate_Response =======================")
    # print(sorted_results)
    # generate the response using LLM
    response = llm_service.generate_response(body.query, sorted_results)
    print(response)
    return response


@app.websocket("/ws/chat_llama")
async def websocket_chat_llama(websocket: WebSocket):
    await websocket.accept()
    try:
        while True:
            data = await websocket.receive_json()
            query = data.get("query")
            if not query:
                await websocket.send_json({"type": "error", "message": "Query is missing"})
                continue
            print("----------------------- Query -----------------------")
            print(query)
            template = """Question: {question}
            Answer: """
            prompt = ChatPromptTemplate.from_template(template)
            model = OllamaLLM(model="llama2")
            chain = prompt | model
            response = chain.invoke({"question": query})
            print("----------------------- response -----------------------")
            print(response)
            await websocket.send_json({
                "type": "llm_response",
                "data": response
            })
    except WebSocketDisconnect:
        print("WebSocket disconnected")
    except Exception as e:
        print("Unexpected error occurred:", e)
        traceback.print_exc()
        await websocket.send_json({"type": "error", "message": str(e)})
    finally:
        await websocket.close()


@app.post("/chat_llama")
def chat_llama(body: ChatBody):
    print("----------------------- Query -----------------------")
    print(body.query)
    template = """Question: {question}

        Answer: """
    prompt = ChatPromptTemplate.from_template(template)
    model = OllamaLLM(model="llama2")
    chain = prompt | model
    response = chain.invoke({"question": body.query})
    print("----------------------- response -----------------------")
    print(response)
    return response


if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
