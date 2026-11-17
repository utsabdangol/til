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


# --- Interactive Conversation Loop ---

messages = []

while True:
  # 1. Get the user's message and add it to history
  user_input = input("\nYou: ")
  add_user_message(messages, user_input)

  # 2. Send the entire history to Gemini and print the reply
  answer = chat(messages)
  print(f"\nGemini: {answer}")

  # 3. Save Gemini's reply so future turns have full context
  add_assistant_message(messages, answer)

  # 4. Ask if the user wants to continue
  while True:
    choice = input("\nDo you want to continue? (y/n): ").strip().lower()
    if choice in ("y", "n"):
      break
    print("Please enter 'y' to continue or 'n' to stop.")

  if choice == "n":
    print("Chat ended.")
    break