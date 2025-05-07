import uvicorn
from fastapi import FastAPI

from pydantic_models.chat_body import ChatBody
from services.search_service import SearchService
from services.sort_source_service import SortSourceService
from services.llm_service import LLMService

app = FastAPI()

search_service = SearchService()
sort_service = SortSourceService()
llm_service = LLMService()


@app.get("/")
def hello():
    return "Hello World!"


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


if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
