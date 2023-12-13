from wsgiref.simple_server import make_server

def hello_world_app(environ, start_response):
    status = '200 OK'  # HTTP Status
    # HTTP Headers
    headers = [('Content-type', 'text/plain; charset=utf-8')]
    start_response(status, headers)

    # The returned object is going to be printed
    return [b"Hello World"]

httpd = make_server(host="0.0.0.0", port=8000, app=hello_world_app)
print("Serving on port 8000...")
# Serve until process is killed
httpd.serve_forever()