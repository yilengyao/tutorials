"""Defining an agent."""
from typing import Literal

from langchain import hub
from langchain.agents import AgentExecutor, create_react_agent
from langchain.chains.base import Chain
from langchain_experimental.plan_and_execute import (
    PlanAndExecute,
    load_agent_executor,
    load_chat_planner,
)
from langchain_ollama import ChatOllama

from tool_loader import load_tools
from config import set_environment

set_environment()

ReasoningStrategies = Literal["zero-shot-react", "plan-and-solve"]

def load_agent(tool_names: list[str], strategy: ReasoningStrategies = "zero-shot-react") -> Chain:
    llm = ChatOllama(model="qwen2.5-coder:14b", temperature=0, streaming=True)
    tools = load_tools(tool_names=tool_names, llm=llm)
    if strategy == "plan-and-solve":
        planner = load_chat_planner(llm)
        executor = load_agent_executor(llm, tools, verbose=True)
        return PlanAndExecute(planner=planner, executor=executor, verbose=True)

    prompt = hub.pull("hwchase17/react")
    return AgentExecutor(
        agent=create_react_agent(llm=llm, tools=tools, prompt=prompt), tools=tools
    )