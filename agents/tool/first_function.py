from typing import List, Dict, Optional, Union, Any
from openai import OpenAI
from openai.types.chat.chat_completion import ChatCompletion
from openai.types.chat.chat_completion_message_tool_call import Function

client: OpenAI = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama"
)

# Example function to query ChatGPT
def ask_chatgpt(user_message: str) -> Function | Any:
    response: ChatCompletion = client.chat.completions.create(
        model="qwen2.5-coder:14b",
        messages=[{"role": "system", "content": "You are a helpful assistant."},
                  {"role": "user", "content": user_message}],
        temperature=0.7,
        tools=[
            {
                "type": "function",
                "function": {
                    "name": "recommend",
                    "description": "Provide a recommendation for any topic.",
                    "parameters": {
                        "type": "object",
                        "properties": {
                            "topic": {
                                "type": "string",
                                "description": "The topic, a user wants a recommendation for."
                            },
                            "rating": {
                                "type": "string",
                                "description": "The rating this recommendation is given.",
                                "enum": ["good", "bad", "terrible"]
                            }
                        },
                        "required": ["topic"]
                    }
                }
            }
        ]
    )
    return response.choices[0].message.tool_calls[0].function

# Example usage
user: str = "Can you please recommend me a time travel movie?"
response: Function | Any = ask_chatgpt(user)
print(response)

user: str = "Can you please recommend me a good time travel movel?"
response: Function | Any = ask_chatgpt(user)
print(response)