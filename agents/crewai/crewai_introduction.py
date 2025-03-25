from typing import List, Dict, Optional, Union, Any
from crewai import Agent, Crew, Process, Task, LLM
from crewai.crews.crew_output import CrewOutput
from dotenv import load_dotenv
import os

os.environ["OPENAI_API_KEY"] = "ollama"

llm=LLM(model="ollama/qwen2.5-coder:14b", base_url="http://localhost:11434")

# Creating a senior researcher agent with memory and verbose mode
joke_researcher: Agent = Agent(
    role="Senior Joke Researcher",
    goal="Research what make things tunny about the following {topic}",
    verbose=True,
    memory=True,
    backstory=(
        "Driven by slapstick humor, you are a seasoned joke researcher"
        "who knows what makes people laugh. You hava a knack for finding"
        "the funny in everyday situation and can turn a dull moment into"
        "a laugh riot."
    ),
    allow_delegation=True,
    llm=llm
)

# Creating a writer agent with custom tools and delegation capability
joke_writer: Agent = Agent(
    role="Joke Writer",
    goal="Write a humourous and funny joke on the following {topic}",
    verbose=True,
    memory=True,
    backstory=(
        "You are a joke writer with a flair for humor. You can turn a"
        "simple idea into a laugh riot. You have a way with words and"
        "can make people laugh with just a few lines."
    ),
    allow_delegation=False,
    llm=llm
)

# Research task
research_task: Task = Task(
    description=(
        "Identify what makes the following topic:{topic} so funny."
        "Be sure to include the kwy elements that makes it humorous."
        "Also, provide an analysis of the current social trends,"
        "and how it impacts the perception of humor."
    ),
    expected_output="A comprehensive 3 paragraphs long report on the latest jokes.",
    agent=joke_researcher,
    llm=llm
)

# Writing task with language model configuration
write_task: Task = Task(
    description=(
        "Compose an insightful, humourous and socially aware joke on {topic}."
        "Be sure to include the key elements that make it funny and"
        "relevant to the current social trends."
    ),
    expected_output="A concise and short one line joke on {topic}.",
    agent=joke_writer,
    async_esxecution=False,
    output_file="the_best_joke.md" # Example of output customization
)

# Forming the tech-focused crew with some enhanced configurations
crew: Crew = Crew(
    agents=[joke_researcher, joke_writer],
    tasks=[research_task, write_task],
    process=Process.sequential, # Optional: Sequential task execution
    memory=True,
    cache=True,
    max_rpm=100,
    share_crew=True,
    llm=llm
)

result: CrewOutput = crew.kickoff(
    inputs={
        "topic": "AI engineer jokes"
    }
)

print(result)