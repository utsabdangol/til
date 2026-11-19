from dotenv import load_dotenv
from google import genai
from google.genai import types

load_dotenv()

# Keep v1beta if passing system_instruction
client = genai.Client(http_options=types.HttpOptions(api_version="v1beta"))
model = "gemini-3.8-flash"


def add_user_message(messages, text):
  messages.append({"role": "user", "parts": [{"text": text}]})


def add_assistant_message(messages, text):
  messages.append({"role": "model", "parts": [{"text": text}]})


def chat_stream(messages, system=None, temperature=None):
  config_kwargs = {"max_output_tokens": 1000}

  if system:
    config_kwargs["system_instruction"] = system

  if temperature is not None:
    config_kwargs["temperature"] = temperature

  stream = client.models.generate_content_stream(
      model=model,
      contents=messages,
      config=types.GenerateContentConfig(**config_kwargs),
  )

  chunks = []
  for chunk in stream:
    text = chunk.text or ""
    if text:
      chunks.append(text)
      # Send or print each chunk as it arrives
      print(text, end="", flush=True)

  print()  # Newline after stream finishes

  # Full assembled text (equivalent to the final message text for DB / history)
  final_text = "".join(chunks)
  return final_text


# --- Example Usage ---

messages = []
system = "You are a concise and helpful technical assistant."

add_user_message(messages, "Explain what a streaming API response is in 3 sentences.")
final_text = chat_stream(messages, system=system, temperature=0.7)

# Save the complete response into conversation history (or your database)
add_assistant_message(messages, final_text)

# Follow-up turn with full context
add_user_message(messages, "Why is streaming useful for chat interfaces?")
final_text_2 = chat_stream(messages, system=system, temperature=0.7)
add_assistant_message(messages, final_text_2)