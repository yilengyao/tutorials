from typing import List, Dict, Optional, Union, Any
import streamlit as st
from openai import OpenAI
from openai.types.chat import ChatCompletion

client = OpenAI(
    base_url = "http://localhost:11434/v1",
    api_key = "ollama"
)

if "ollama_model" not in st.session_state:
    st.session_state.ollama_model = "qwen2.5-coder:14b"

if "messages" not in st.session_state:
    st.session_state["messages"] = []

for message in st.session_state["messages"]:
    print(message)
    with st.chat_message(message["role"]):
        st.markdown(message["content"])

if prompt := st.chat_input("What do you need?"):
    st.session_state.messages.append({"role": "user", "content": prompt})
    with st.chat_message("user"):
        st.markdown(prompt)

    # Use st.spinner to indicate a long-runnning process
    with st.spinner(text="The assistant is thinking..."):
        with st.chat_message("assistant"):
            response: ChatCompletion = client.chat.completions.create(
                model = st.session_state["ollama_model"],
                messages = [
                    {"role": m["role"], "content": m["content"]}
                    for m in st.session_state.messages
                ]
            )
            response_content = response.choices[0].message.content
            response = st.markdown(response_content, unsafe_allow_html=True)
    st.session_state.messages.append({"role": "assistant", "content": response_content})
