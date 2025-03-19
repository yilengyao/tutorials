from typing import List, Dict, Optional, Union, Any
from textwrap import dedent
import agentops
from crewai import Agent, Crew, Process, Task, LLM
from crewai.crews.crew_output import CrewOutput
from langchain_openai import ChatOpenAI
from langchain_community.llms import Ollama  # Add this import
from dotenv import load_dotenv
import os

load_dotenv()

os.environ["OPENAI_API_KEY"] = "ollama"
os.environ["AGENTOPS_API_KEY"] = ""

agentops.init()

llm: LLM = LLM(model="ollama/qwen2.5-coder:14b", base_url="http://localhost:11434")

print("## Welcome to the Game Crew")
print("---------------------------------")
game: input = input("What is the game you would like to build? What will be the mechanics?\n")

senior_engineer_agent: Agent = Agent(
    role="Senior Software Engineer",
    goal="Create software as needed",
    backstory=dedent(
        """
        You are a Senior Software Engineer at a leading tech think tank.
        Your expertise in programming in python. and do your best to
        produce perfect code
        """
    ),
    allow_delegation=False,
    verbose=True,
    llm=llm
)

qa_engineer_agent: Agent = Agent(
    role="Software Quality Control Engineer",
    goal="create prefect code, by analizing the code that is given for errors",
    backstory=dedent(
        """
        You are a software engineer that specializes in checking code
        for errors. You have an eye for detail and a knack for finding
        hidden bugs.
        You check for missing imports, variable declarations, mismatched
        brackets and syntax errors.
        You also check for security vulnerabilities, and logic errors
        """
    ),
    allow_delegation=False,
    verbose=True,
    llm=llm
)

chief_qa_engineer_agent: Agent = Agent(
    role="Chief Software Quality Control Engineer",
    goal="Ensure that the code does the job that it is supposed to do",
    backstory=dedent(
        """
        You are a Chief Software Quality Control Engineer at a leading
        tech think tank. You are responsible for ensuring that the code
        that is written does the job that it is supposed to do.
        You are responsible for checking the code for errors and ensuring
        that it is of the highest quality.
        """
    ),
    allow_delegation=True,
    verbose=True,
    llm=llm
)

code_task: Task = Task(
    description=f"""You will create a game using python, these are the instructions:
        Instructions
        ------------
        {game}
        You will write the code for the game using python.""",
    expected_output="Your Final answer must be the full python code, only the python code and nothing else. Failure to do so we will feed you to zombies.",
    agent=qa_engineer_agent
)

qa_task: Task = Task(
    description=f"""You are helping create a game using python, these are the instructions:
        Instructions
        ------------
        {game}
        Using the code you got, check for errors. Check for logic errors,
        syntax errors, missing imports, variable declarations, mismatched brackets,
        and security vulnerabilities.""",
    expected_output="Output a list of issues you found in the code.",
    agent=qa_engineer_agent
)

evaluate_task: Task = Task(
    description=f"""You are helping create a game using python, these are the instructions:
        Instructions
        ------------
        {game}
        You will look over the code to insure that it is complete and
        does the job that it is supposed to do. """,
    expected_output="Your Final answer must be the corrected a full python code, only the python code and nothing else.",
    agent=chief_qa_engineer_agent
)

# Instantiate your crew with a sequential process
crew: Crew = Crew(
    agents=[senior_engineer_agent, qa_engineer_agent, chief_qa_engineer_agent],
    tasks=[code_task, qa_task, evaluate_task],
    verbose=True,
    manager_llm=llm
)

# Get you crew to work!
result: CrewOutput = crew.kickoff()

print(result)
