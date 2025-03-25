from typing import List, Dict, Optional, Union, Any
from autogen import AssistantAgent, UserProxyAgent, config_list_from_json
from autogen.agentchat.agent import Agent
from autogen.cache import Cache

# Load the configuration list from the config file.
config_list: List[Dict[str, Any]] = config_list_from_json(env_or_file="LLM_CONFIG_LIST")

# Creat the agent that represents the user in the conversation.
user_proxy: UserProxyAgent = UserProxyAgent(
    "user",
    code_execution_config={
        "work_dir": "working",
        "use_docker": False,
        "last_n_messages": 1
    },
    human_input_mode="ALWAYS",
    is_termination_msg=lambda x: x.get("content", "").rstrip().endswith("TERMINATE")
)

engineer: AssistantAgent = AssistantAgent(
    name="Engineer",
    llm_config={"config_list": config_list},
    system_message="""
    You are a professional Python engineer,  for your expertise in software development.
    You use your skills to create a software applications, tools, and games that are both functional and efficient.
    Your preference is to write clean, well-structured code that is easy to read and maintain.
    """
)

critic: AssistantAgent = AssistantAgent(
    name="Reviewer",
    llm_config={"config_list": config_list},
    system_message="""
    You are a code reviewer, known for your thoroughness and commitment to standards.
    Your task is to scrutinize code content for any harmful or substandard elements.
    You ensure that the code is secure, efficient, and adheres to best practices.
    You will identify any issues or areas for improvement in the code and output them as a list.
    """
)

def review_code(recipient: Agent, 
                messages: List[Dict[str, Any]], 
                sender: Agent, 
                config: Dict[str, Any]) -> str:
    return f"""A
              Review and critique the following code.
    
              {recipient.chat_messages_for_summary(sender)[-1]['content']}
                """
user_proxy.register_nested_chats(
    [
        {
            "recipient": critic,
            "message": review_code,
            "summary_method": "last_msg",
            "max_turns": 3
        }
    ],
    trigger=engineer # condition=my_condition
)

task = """Write a snake game using Pygame."""

with Cache.disk(cache_seed=42) as cache:
    res: Dict[str, Any] = user_proxy.initiate_chat(
        recipient=engineer,
        message=task,
        max_turns=2,
        summary_method="last_msg",
        cache=cache
    )