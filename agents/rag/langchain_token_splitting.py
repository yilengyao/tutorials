from typing import List, Dict, Optional, Union, Tuple, Any
from langchain_community.document_loaders import UnstructuredHTMLLoader
from langchain_ollama import OllamaEmbeddings
from langchain.vectorstores import Chroma
from langchain.text_splitter import CharacterTextSplitter
from langchain_core.documents import Document

embeddings_client: OllamaEmbeddings = OllamaEmbeddings(
    base_url="http://localhost:11434",
    model="nomic-embed-text"
)

loader: UnstructuredHTMLLoader = UnstructuredHTMLLoader("sample_documents/mother_goose.html")
data: List[Document] = loader.load()

text_splitter: CharacterTextSplitter = CharacterTextSplitter.from_tiktoken_encoder(
    chunk_size=50,
    chunk_overlap=10
)

documents: List[Document] = text_splitter.split_documents(data)

# Extract page content from the documents
documents = [doc for doc in documents][8:94] # Capture just the rhymes

db: Chroma = Chroma.from_documents(documents, embeddings_client)

def query_documents(query: str, top_n: int = 2) -> List[Document]:
    return db.similarity_search(query, top_n)

# Input Loop for Search Queries
while True:
    query: str = input("Enter a search query (or 'exit' to stop): ")
    if query.lower() == 'exit':
        break
    top_n: int = int(input("How many top matches do you want to see? "))
    search_results: List[Document] = query_documents(
        query,
        top_n=top_n
    )

    print("Top Matched Documents:")
    for i, doc in enumerate(search_results):
        print(f"Document{i+1}: {doc.page_content}")

    print("\n")