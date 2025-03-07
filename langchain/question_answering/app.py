import streamlit as st
from langchain.callbacks import StreamlitCallbackHandler
from langchain.agents import (
 AgentExecutor, AgentType, initialize_agent, load_tools
)
from langchain_ollama import ChatOllama

from agent import load_agent


def load_agent() -> AgentExecutor:
    llm = ChatOllama(model="qwen2.5-coder:14b", temperature=0, streaming=True)
    tools = load_tools(
        tool_names=["ddg-search", "arxiv", "wikipedia"],
        llm=llm
    )

    return initialize_agent(
        tools=tools,
        llm=llm,
        agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
        verbose=True,
        handle_parsing_errors=True  # Enable parsing error handling
    )


chain = load_agent()

st_callback = StreamlitCallbackHandler(st.container())

if prompt := st.chat_input():
    st.chat_message("user").write(prompt)
    with st.chat_message("assistant"):
        st_callback = StreamlitCallbackHandler(st.container())
        response = chain.run(prompt, callbacks=[st_callback])
        st.write(response)