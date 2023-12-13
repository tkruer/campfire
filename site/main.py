from wsgiref.simple_server import make_server

def simple_app(environ, start_response):
    # Set HTTP response headers
    status = '200 OK'
    headers = [('Content-type', 'text/html; charset=utf-8')]

    # Start the response
    start_response(status, headers)

    # HTML content to serve
    html = """
    <html>
        <head>
            <title>Grimoire's Tavern</title>
        </head>
        <body>
            <h1>Welcome to Grimoire's Coding Tavern</h1>
            <p>Enjoy your stay, explore coding mysteries!</p>
        </body>
    </html>
    """

    # Return the HTML content
    return [html.encode("utf-8")]

# Create a WSGI server
httpd = make_server("0.0.0.0", 8000, simple_app)

# Start listening for requests
print("Serving on http://localhost:8000...")
httpd.serve_forever()
