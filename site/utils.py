from typing import Callable, List, Tuple
from wsgiref.simple_server import make_server, WSGIServer
# from wsgiref.types import StartResponse, WSGIEnvironment

def simple_app(environ, start_response) -> List[bytes]:
    # Set HTTP response headers
    status: str = '200 OK'
    headers: List[Tuple[str, str]] = [('Content-type', 'text/html; charset=utf-8')]

    # Start the response
    start_response(status, headers)

    # HTML content to serve
    html: str = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hello from Campfire!</title>
        <!-- Include Tailwind CSS from CDN -->
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    </head>
    <body>
        <section class="w-full h-screen flex items-center justify-center">
            <div class="text-center">
            <div class="text-9xl hover:text-red-500 transition-colors duration-200 ease-in-out">🔥</div>
            <h1 class="mt-8 text-4xl font-bold">Welcome To Campfire</h1>
            <p class="mt-4 text-gray-500 max-w-xl mx-auto">
                This is a simple demonstration of a landing page. Check our our docs to learn more.
            </p>
            <div class="mt-8 space-x-4">
                <button 
                class="inline-flex items-center justify-center rounded-md ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 border border-input bg-background hover:bg-accent hover:text-accent-foreground h-10 px-6 py-2 text-sm font-medium"
                >
                <a href="https://campfire-framework.com/" target="_blank"> 
                    Get Started ↗️
                </a>              
                </button>
            </div>
            </div>
        </section>
    </body>
    </html>
    """

    # Return the HTML content
    return [html.encode("utf-8")]


def run():
    # Create a WSGI server
    httpd: WSGIServer = make_server("0.0.0.0", 8000, simple_app)

    # Start listening for requests
    print("Serving on http://localhost:8000...")
    httpd.serve_forever()
