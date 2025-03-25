from typing import List, Dict, Optional, Union, Any
from openai import OpenAI
import numpy as np
from numpy import ndarray
from scipy.sparse import spmatrix
from sklearn.decomposition import PCA
import plotly.graph_objects as go
from plotly.graph_objects import Figure

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
documents: str = [
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
# print(f"embeddings: {embeddings}")

# Convrt embeddings to a numpy array for PCA
embeddings_array: ndarray = np.array(embeddings)


# Applying PCA to reduce dimentsions to 3
pca: PCA = PCA(n_components=3)
reduce_embeddings: ndarray = pca.fit_transform(embeddings_array)

# Creating a 3D plot using Plotly
fig: Figure = go.Figure(data=[go.Scatter3d(
    x=reduce_embeddings[:, 0],
    y=reduce_embeddings[:, 1],
    z=reduce_embeddings[:, 2],
    mode='markers+text',
    text=documents, # Adding socument texts for hover
    hoverinfo='text', # Shoing only the text on hover
    marker=dict(
        size=1,
        color=list(range(len(documents))), # Assigning a unique color to each document
        opacity=0.8
    )
)])

# Adding titles and labels to the plot
fig.update_layout(title='3D PCA of Document Embeddings',
                  scene=dict(
                      xaxis_title='PCA Component 1',
                      yaxis_title='PCA Component 2',
                      zaxis_title='PCA Component 3'
                  ))

fig.show()