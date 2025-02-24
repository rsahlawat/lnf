import google.generativeai as genai
import os
import sys
genai.configure(api_key=sys.argv[1])
story = sys.argv[2]
model = genai.GenerativeModel(model_name='models/gemini-1.5-pro-latest')
import pathlib
import textwrap
response = model.generate_content(
  textwrap.dedent("""\
    Please return JSON describing the the people, places, things and relationships from this story using the following schema:
    Please correct spellings
    {"people": list[PERSON], "food":list[FOOD], "disease": list[DISEASE], "games": list[GAME], cars:list[CARS], school:list[SCHOOLS], places:list[PLACE], "things":list[THING], "relationships": list[RELATIONSHIP]}
    PERSON = {"name": str, "description": str}
    PLACE = {"name": str, "description": str}
    THING = {"name": str, "description": str}
    DISEASE = {"name": str, "description": str}
    GAME = {"name": str, "description": str}
    FOOD = {"name":str, "description": str}
    SCHOOLS = {"name":str, "description": str}
    RELATIONSHIP = {"person_1_name": str, "person_2_name": str, "relationship": str}
    All fields are required.
    Important: Only return a single piece of valid JSON text.
    Here is the story:
    """) +  story,
  generation_config={'response_mime_type':'application/json'}
)
Str = response.text
import json
json_object = json.loads(Str)
for name in json_object:
    length = len(json_object[name])
    if (length > 0):
        print(name, end=':')
        print(json_object[name])
            