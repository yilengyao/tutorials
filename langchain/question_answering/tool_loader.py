"""Utiliites for tools."""
from typing import Optional

from langchain import hub
from langchain.agents import AgentExecutor, Tool, create_self_ask_with_search_agent
from langchain.chains import LLMMathChain
from langchain_community.tools.arxiv.tool import ArxivQueryRun
from langchain_community.tools.ddg_search import DuckDuckGoSearchRun
from langchain_community.tools.google_search import GoogleSearchRun
from langchain_community.tools.wikipedia.tool import WikipediaQueryRun
from langchain_community.tools.wolfram_alpha import WolframAlphaQueryRun
from langchain_community.utilities.arxiv import ArxivAPIWrapper
from langchain_community.utilities.duckduckgo_search import DuckDuckGoSearchAPIWrapper
from langchain_community.utilities.google_search import GoogleSearchAPIWrapper
from langchain_community.utilities.wikipedia import WikipediaAPIWrapper
from langchain_community.utilities.wolfram_alpha import WolframAlphaAPIWrapper
from langchain_core.language_models import BaseLanguageModel
from langchain_core.tools import BaseTool
from langchain_experimental.tools import PythonREPLTool

python_repl = PythonREPLTool()
# You can create the tool to pass to an agent
wikipedia_api_wrapper = WikipediaAPIWrapper(lang="en", top_k_results=3)

def load_tools(
    tool_names: list[str],
    llm: Optional[BaseLanguageModel] = None,
) -> list[BaseTool]:
    prompt = hub.pull("hwcase17/self-ask-with-search")
    search_wrapper = DuckDuckGoSearchRun(api_wrapper=DuckDuckGoSearchAPIWrapper())
    search_tool = Tool(
        name="Intermediate Answer",
        func=search_wrapper.invoke,
        description="Search",
    )
    self_ask_agent = AgentExecutor(
        agent=create_self_ask_with_search_agent(
            llm=llm,
            tools=[search_tools],
            prompt=prompt,
        ),
        tools=[search_tool],
    )

    available_tools = {
        # search to use:
        "ddg-search": DuckDuckGoSearchRun(api_wrapper=DuckDuckGoSearchAPIWrapper()),
        # "wolfwram_alpha_appid"
        "wolfwram-alpha": WolframAlphaQueryRun(api_wrapper=WolframAlphaAPIWrapper()),
        # ["google_api_key", "google_cse_id"]
        "google-search": GoogleSearchRun(api_wrapper=GoogleSearchAPIWrapper()),
        # "top_k_results", "load_max_docs", "load_all_available_meta"
        "arxiv": ArxivQueryRun(api_wrapper=ArxivAPIWrapper()),
        "wikipedia": WikipediaQueryRun(api_wrapper=wikipedia_api_wrapper),
        "python_repl": Tool(
            name="python_repl",
            description="A Python shell, Use this to execute python commands."
            " Input should be a valid python command. If you want to see"
            " the output of a value, you should brint it out with `pring(...)`.",
            func=python_repl.arun,
        ),
        "llm-math": Tool(
            name="Calculator",
            description="Useful for when you need to answer questions about math.",
            func=LLMMathChain.from_llm(llm=llm).run,
            coroutine=LLMMathChain.from_llm(llm=llm).arun,
        ),
        "critical_search": Tool.from_function(
            func=self_ask_agent.invoke,
            name="Self-ask agent",
            description="A tool to answer complicated questions. . "
            "Useful for when you need to answer questions about current events. "
            "Input whould be a question.",
        ),
    }
    tools = []
    for name in tool_names:
        if name in available_tools:
            tools.append(available_tools[name])
    return tools