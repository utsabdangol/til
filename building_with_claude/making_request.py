import os
from dotenv import load_dotenv
from google import genai
from google.genai import types

# Load environment variables from the .env file
load_dotenv()

# The client automatically detects the GEMINI_API_KEY environment variable
client = genai.Client()

response = client.models.generate_content(
    model="gemini-2.5-flash",
    contents="Explain quantum computing in detail.",
    config=types.GenerateContentConfig(
        max_output_tokens=1000,  # Caps the response at ~60-80 words
    ),
)

print(response.text)