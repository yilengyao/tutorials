import gradio as gr
from autogen import AssistantAgent, UserProxyAgent

def run_assistant(message):
    # Define the configuration for the Code Llama model
    config_list = [
        {
            "model": "qwen2.5-coder:14b",
            "base_url": "http://localhost:11434/v1",
            "api_key": "ollama"
        }
    ]

    # Create an AssistantAgent with the Code Llama model
    assistant = AssistantAgent("assistant", llm_config={"config_list": config_list})

    # Create a UserProxyAgent that can execute code
    user_proxy = UserProxyAgent(
        "user_proxy",
        code_execution_config={
            "work_dir": "coding",
            "use_docker": False,
        },
        human_input_mode="NEVER",
        is_termination_msg=lambda x: x.get("content", "").rstrip().endswith("TERMINATE"),
    )

    response = user_proxy.initiate_chat(assistant, message=message)

    return response

iface = gr.Interface(fn=run_assistant, inputs="text", outputs="text", title="Code Llama Assistant")
iface.launch()