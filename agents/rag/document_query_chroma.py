from typing import List, Dict, Optional, Union, Tuple, Any
from openai import OpenAI
from chromadb import chromadb, Client, Collection
from chromadb.api.types import QueryResult, IDs, Documents

client: OpenAI = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama"
)

def get_embedding(text: str, model: str="nomic-embed-text") -> List[float]:
    text: str = text.replace("\n", " ")
    return client.embeddings.create(
        input = [text],
        model= model
    ).data[0].embedding

# Sample documents
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

# Generate embeddings for each document
embeddings: List[List[float]] = [get_embedding(doc) for doc in documents]
ids = [f"doc_{i}" for i in range(len(documents))]

# Create Chroma dagabase client
chroma_client: Client = chromadb.Client()

# Create a collection
collection: Collection = chroma_client.create_collection(name="documents")

collection.add(
    embeddings=embeddings,
    documents=documents,
    ids=ids
)

def query_chromadb(query: str, top_n: int = 2) -> List[Tuple[IDs, List[float], Documents]]:
    """
    Returns the text of the top 2 results from the 
    ChromaDB collection
    """
    query_embedding: List[float] = get_embedding(query)
    results: QueryResult = collection.query(
        query_embeddings=[query_embedding],
        n_results=top_n
    )
    return [(id, score, text) for id, score, text in
            zip(results['ids'][0],
                results['distances'][0],
                results['documents'][0])]

# Input Loop for Search Queries
while True:
    query: str = input("Enter a search query (or 'exit' to stop): ")
    if query.lower() == 'exit':
        break
    top_n: int = int(input("How many top matches do you want to see? "))
    search_results: List[Tuple[IDs, List[float], Documents]] = query_chromadb(
        query,
        top_n=top_n
    )

    print("Top Matched Documents:")
    for id, score, text in search_results:
        print(f"- {text} (Score: {score:.4f})")

    print("\n")