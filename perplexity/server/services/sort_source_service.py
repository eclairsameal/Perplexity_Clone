from typing import List
from sentence_transformers import SentenceTransformer
import numpy as np

similarity_value = 0.5


class SortSourceService:
    def __init__(self):
        self.embedding_model = SentenceTransformer("all-MiniLM-L6-v2")
        # Load a pretrained Sentence Transformer model

    def sort_sources(self, query: str, search_results: List[dict]):
        relevance_docs =[]
        query_embedding = self.embedding_model.encode(query)
        # print(query_embedding)

        for res in search_results:
            res_embedding = self.embedding_model.encode(res['content'])
            similarity = np.dot(query_embedding, res_embedding) / (
                    np.linalg.norm(query_embedding) * np.linalg.norm(res_embedding)
            )  # high similarity -> good
            # print(similarity)
            res['relevance_sore'] = similarity

            if similarity > similarity_value:
                relevance_docs.append(res)

        return sorted(relevance_docs, key=lambda x: ['relevance_sore'], reverse=True)



