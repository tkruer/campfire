import json
import sys

def greetings(name):
    response = {
        "message": f"Hello, {name}!"
    }
    print(json.dumps(response))

if __name__ == "__main__":
    post_data = json.loads(sys.argv[1])
    greetings(post_data.get('name', 'World'))