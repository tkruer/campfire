import json

def hello_world():
    response = {
        "message": "Hello, World!"
    }
    print(json.dumps(response))

if __name__ == "__main__":
    hello_world()