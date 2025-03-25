from typing import List, Dict, Optional, Union, Tuple, Any
from openai import OpenAI
from chromadb import chromadb, Client, Collection, IDs, Documents

from langchain_community.document_loaders import UnstructuredHTMLLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_core.documents import Document

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

loader: UnstructuredHTMLLoader = UnstructuredHTMLLoader("sample_documents/mother_goose.html")
data: List[Document] = loader.load()

text_splitter: RecursiveCharacterTextSplitter = RecursiveCharacterTextSplitter(
    chunk_size=100,
    chunk_overlap=2,
    length_function=len,
    add_start_index=True
)

documents: List[Document] = text_splitter.split_documents(data)

# Extract page content from the documents
documents: List[str] = [doc.page_content for doc in documents][100:350] # only use 50 documents/chunks (cheaper and faster)

# Generate embeddings for each document
embeddings: List[List[float]] = [get_embedding(doc) for doc in documents]
ids = [f"id{i}" for i in range(len(documents))]


# Create Chroma database client
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
    Returns the text of the top 2 results from the ChromaDB collection
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
        print(f"ID:{id} Text: {text} (Score: {score:.4f})")

    print("\n")