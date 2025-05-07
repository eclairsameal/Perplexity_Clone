from typing import List
from google import genai
from services.config import Settings


setting = Settings()


class LLMService:
    def __init__(self):
        self.model = genai.Client(api_key=setting.GEMINI_API_KEY)

    def only_llm_generate_response(self, query: str):
        response = self.model.models.generate_content(
            model="gemini-2.0-flash", contents=query
        )
        print(response.text)

    def generate_response(self, query: str, search_results: List[dict]):
        # response = self.model.models.generate_content(
        #     model="gemini-2.0-flash", contents=query
        # )
        # print(response.text)

        # Context from web search:
        # Source 1: <url>
        # <content>
        # Source 2: <url>
        # <content>
        # Query
        context_text = "\n\n".join(
            [
                f"Source {i + 1} ({result['url']}):\n{result['content']}"
                for i, result in enumerate(search_results)
            ]
        )
        full_prompt = f"""
                Context from web search:
                {context_text}

                Query: {query}

                Please provide a comprehensive, detailed, well-cited accurate response using the above context. 
                Think and reason deeply. Ensure it answers the query the user is asking. Do not use your knowledge until it is absolutely necessary.
        """
        response = self.model.models.generate_content(
            model="gemini-2.0-flash", contents=full_prompt
        )
        # print(response.text)
        return response.text
