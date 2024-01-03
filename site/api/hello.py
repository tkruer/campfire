import json

def hello():
    response = {
        "message": "Hello, World!"
    }
    print(json.dumps(response))

if __name__ == "__main__":
    hello()