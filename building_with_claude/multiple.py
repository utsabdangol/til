from dotenv import load_dotenv
from google import genai
from google.genai import types

load_dotenv()
client = genai.Client()
model = "gemini-2.5-flash"


def add_user_message(messages, text):
  user_message = {"role": "user", "parts": [{"text": text}]}
  messages.append(user_message)


def add_assistant_message(messages, text):
  assistant_message = {"role": "model", "parts": [{"text": text}]}
  messages.append(assistant_message)


def chat(messages):
  response = client.models.generate_content(
      model=model,
      contents=messages,
      config=types.GenerateContentConfig(
          max_output_tokens=1000,
      ),
  )
  return response.text


# --- Your Exact Workflow ---

# Start with an empty message list
messages = []

# Add the initial user question
add_user_message(messages, "tell me something interesting about dogs")

# Get Gemini's response
answer = chat(messages)
print("Turn 1:", answer)

# Add Gemini's response to the conversation history
add_assistant_message(messages, answer)

# Add a follow-up question
add_user_message(messages, "Write another sentence")

# Get the follow-up response with full context
final_answer = chat(messages)
print("Turn 2:", final_answer)