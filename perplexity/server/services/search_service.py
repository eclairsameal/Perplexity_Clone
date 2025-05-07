
from tavily import TavilyClient

from services.config import Settings

setting = Settings()
tavily_client = TavilyClient(api_key=setting.TAVILY_API_KEY)


class SearchService:
    def web_search(self, query: str):
        # print(Settings().TAVILY_API_KEY)
        response = tavily_client.search(query, max_results=10)
        print(response.get("results", []))
