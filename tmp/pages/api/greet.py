# pages/api/greet.py

import json

def greet(data):
    name = data.get('name', 'World')
    return {"message": f"Hello, {name}!"}

if __name__ == "__main__":
    greet()