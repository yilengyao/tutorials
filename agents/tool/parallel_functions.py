from typing import List, Iterable, Dict, Optional, Union, Any
import json
from openai._types import NotGiven
from openai.types.chat.chat_completion import ChatCompletion
from openai.types.chat.chat_completion_message import ChatCompletionMessage
from openai.types.chat.chat_completion_tool_param import ChatCompletionToolParam
from openai.types.chat.chat_completion_message_tool_call import ChatCompletionMessageToolCall
from openai.types.chat.chat_completion_message_param import ChatCompletionMessageParam

from openai.types.chat.chat_completion_message_tool_call import Function

from openai import OpenAI

client: OpenAI = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama"
)

def recommend(topic: str, rating: str="good") -> str:
    """Give a recommendation for any topic"""
    if "time travel" in topic.lower():
        return json.dumps({"topic": "time travel",
                           "recommendation": "Back to the Future",
                           "rating": rating})
    elif "recipe" in topic.lower():
        return json.dumps({"topic": "recipe",
                           "recommendation": "The best thing you ever ate.",
                           "rating": rating})
    elif "gift" in topic.lower():
        return json.dumps({"topic": "gift",
                           "recommendation": "A glorious new...",
                           "rating": rating})
    else:
        return json.dumps({"topic": topic,
                           "recommendation": "unknown"})
    
def run_conversation():
    # Step 1: send the conversation and available functions to the model
    user: str | NotGiven = """Can you please make recommendations for the following:
    1. Time travel movies
    2. Recipes
    3. Gifts"""
    messages: List[Dict[str, str]]= [{"role": "user", "content": user}]
    tools: List[Dict[str, Any]] = [
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
    response: ChatCompletion = client.chat.completions.create(
        model="qwen2.5-coder:14b",
        messages=messages,
        temperature=0.7,
        tools=tools # auto is default, but we;ll be explicit
    )

    print("response from tool call: " + response.to_json())

    response_message: ChatCompletionMessage = response.choices[0].message
    tool_calls: Optional[List[ChatCompletionMessageToolCall]] = response_message.tool_calls

    print("tool_call: " + str(tool_calls))

    # Step 2: check if the model wanted to call a function
    if tool_calls:
        # Step 3: call the function
        # Note: the JSON response may not alwasy be valid; be sure to handle errors
        available_functions: Dict[str, recommend] = {
            "recommend": recommend
        } # only one function in this example, but you can have multiple
        messages.append(response_message) # extend conversation with assistant's reply
        # Step 4: send the info for each function call andfunction response to the model
        for tool_call in tool_calls:
            function_name: str = tool_call.function.name
            function_to_call: recommend = available_functions[function_name]
            function_args: Any = json.loads(tool_call.function.arguments)
            function_response: str = function_to_call(
                topic=function_args.get("topic"),
                rating=function_args.get("rating")
            )
            messages.append(
                {
                    "tool_call_id": tool_call.id,
                    "role": "tool",
                    "name": function_name,
                    "content": function_response
                }
            )
        second_response: ChatCompletion = client.chat.completions.create(
            model="deepseek-r1:14b",
            messages=messages
        ) # get a new fromponse from the model where it can see the funciton response
        return second_response.choices[0].message.content
    
print(run_conversation())
