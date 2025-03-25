from typing import List, Dict, Optional, Union, Any
import plotly.graph_objects as go
from plotly.graph_objects import Figure
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from scipy.sparse import spmatrix
import numpy as np
from numpy import ndarray

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

# Vectorize using TF-IDF
vectorizer: TfidfVectorizer = TfidfVectorizer()
X: spmatrix = vectorizer.fit_transform(documents)

# Calculate Cosine Similarity
cosine_similarities: ndarray = cosine_similarity(X)

while True:
    # User input for selecting a document
    selected_document_index: str = input(f"Enter a document number (0-{len(documents)-1}) or 'exit' to quit: ").strip()

    if selected_document_index.lower() == 'exit':
        break

    if not selected_document_index.isdigit() or not 0 <= int(selected_document_index) < len(documents):
        print("Invalid input. Please enter a valid document number.")
        continue

    selected_document_index: int = int(selected_document_index)

    # Extract similarity scores for the selected document
    selected_document_similarities: ndarray = cosine_similarities[selected_document_index]
    print("selected_document_similarities: ", selected_document_similarities)

    # Truncate long document texts for x-axis labels
    x_axis_labels: List[str] = [doc[:50] + "..." if len(doc) > 50 else doc for doc in documents]

    # Plotting the consine similarity
    fig: Figure = go.Figure([go.Bar(x=x_axis_labels,
                                    y=selected_document_similarities)])

    fig.update_layout(title=f"Cosile Similarities of '{documents[selected_document_index][:50] + '...' if len(documents[selected_document_index]) > 50 else documents[selected_document_index]}' with Others")

    fig.show()