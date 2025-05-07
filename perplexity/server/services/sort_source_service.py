from typing import List
from sentence_transformers import SentenceTransformer


class SortSourceService:
    def __init__(self):
        self.embedding_model = SentenceTransformer("all-MiniLM-L6-v2")
        # Load a pretrained Sentence Transformer model

    def sort_sources(self, query: str, search_results: List[dict]):
        query_embedding = self.embedding_model.encode(query)
        # print(query_embedding)

        for res in search_results:
            res_embedding = self.embedding_model.encode(res['content'])


