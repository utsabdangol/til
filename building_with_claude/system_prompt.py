from dotenv import load_dotenv
from google import genai
from google.genai import types

load_dotenv()

# Specify api_version='v1beta' to enable system_instruction
client = genai.Client(http_options=types.HttpOptions(api_version="v1beta"))
model = "gemini-3.8-flash"


def add_user_message(messages, text):
  messages.append({"role": "user", "parts": [{"text": text}]})


def add_assistant_message(messages, text):
  messages.append({"role": "model", "parts": [{"text": text}]})


def chat(messages, system=None):
  config_kwargs = {"max_output_tokens": 2000}

  if system:
    config_kwargs["system_instruction"] = system

  response = client.models.generate_content(
      model=model,
      contents=messages,
      config=types.GenerateContentConfig(**config_kwargs),
  )
  return response.text


# Example usage
messages = []
add_user_message(messages, "How do I solve 2x + 5 = 15?")

system = """
You are a patient math tutor.
Do not directly answer a student's questions.
Guide them to a solution step by step.
"""

answer = chat(messages, system=system)
print("Gemini:", answer)