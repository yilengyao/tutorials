from typing import List, Dict, Optional, Union, Tuple, Any
import numpy as np
from numpy import ndarray
from scipy.sparse import spmatrix
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

# Sample Documents
documents: List[str] = [
    "The sky is blue and beautiful.",
    "Love this blue and beautiful sky!",
    "The quick brown fox jumps over the lazy dog.",
    "A king's breakfast has sausages, ham, bacon, eggs, toast, and beans",
    "I love green eggs, ham, sausages and bacon!",
    "The brown fox is quick and the blue dog is lazy!",
    "The sky is very blue and the sky is very beautiful today",
    "The dog is lazy but the brown fox is quick!"
]

# Step 1: Vectorize with TF-IDF Vectorizer
vectorizer: TfidfVectorizer = TfidfVectorizer()
X: spmatrix = vectorizer.fit_transform(documents)

# Step 2: Store vectores in a simple vector database (here, a list)
vector_database: ndarray = X.toarray()

# Step 3: Cosine similarity Search Function
def cosine_similarity_search(
        query: str, 
        database: ndarray, 
        vectorizer: TfidfVectorizer,
        top_n: int = 5) -> List[Tuple[int, float]]:
    query_vec: ndarray = vectorizer.transform([query]).toarray()
    similarities: ndarray = cosine_similarity(query_vec, database)[0]
    top_indices: List[int] = np.argsort(-similarities)[:top_n] # Top n indices
    return [(idx, similarities[idx]) for idx in top_indices]

# Input Loop for Search Queries
while True:
    query: str = input("Enter a search query (or 'exit' to stop): ")
    if query.lower() == 'exit':
        break
    top_n: int = int(input("How many top matches do you want to see? "))
    search_results: List[Tuple[int, float]] = cosine_similarity_search(
        query,
        vector_database,
        vectorizer,
        top_n=top_n
    )

    print("Top Matched Documents:")
    for idx, score in search_results:
        print(f"- {documents[idx]} (Score: {score:.4f})")

    print("\n")