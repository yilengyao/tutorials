from autogen import AssistantAgent, UserProxyAgent

# Define the configuration for the Code Llama model
config_list = [
    {
        "model": "qwen2.5-coder:14b",
        "base_url": "http://localhost:11434/v1",
        "api_key": "ollama"
    }
]

# Create an AssistantAgent with the Code Llama model
assistant = AssistantAgent("agent", llm_config={"config_list": config_list})

# Create a UserProxyAgent that can execute code
user_proxy = UserProxyAgent(
    "user",
    code_execution_config={
        "work_dir": "coding",
        "use_docker": False,
    },
    human_input_mode="ALWAYS",
    is_termination_msg=lambda x: x.get("content", "").rstrip().endswith("TERMINATE"),
)

user_proxy.initiate_chat(assistant, message=" a chart of NVDA and TESLA Plotstock price change YTD. Get information using yfinance.")

