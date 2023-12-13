from http.server import HTTPServer, SimpleHTTPRequestHandler

# Define a new do_GET method directly on SimpleHTTPRequestHandler
def custom_do_GET(self):
    self.send_response(200)
    self.send_header('Content-type', 'text/html')
    self.end_headers()
    self.wfile.write("<h1>Welcome to the Home Page</h1>".encode())

# Assign the new metahod to SimpleHTTPRequestHandler
SimpleHTTPRequestHandler.do_GET = custom_do_GET

if __name__ == "__main__":
    # Server setup
    port = 8000
    httpd = HTTPServer(("0.0.0.0", port), SimpleHTTPRequestHandler)
    print(f"Serving at port {port}")
    httpd.serve_forever()
