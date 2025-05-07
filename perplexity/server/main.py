import uvicorn
from fastapi import FastAPI

from pydantic_models.chat_body import ChatBody
from services.search_service import SearchService
from services.sort_source_service import SortSourceService

app = FastAPI()

search_service = SearchService()
sort_service = SortSourceService()


@app.get("/")
def hello():
    return "Hello World!"


@app.post("/chat")
def chat_endpoint(body: ChatBody):
    print(body.query)
    # search the web and find appropriate sources
    search_results = search_service.web_search(body.query)
    # print(search_results)
    # sort the sources
    sorted_results = sort_service.sort_sources(body.query, search_results)
    # print(sorted_results)

    # generate the response using LLM
    return body.query


if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
