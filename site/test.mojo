from python.python import Python
from python.object import PythonObject

fn main() raises:
    Python.add_to_path(".")
    let server = Python.import_module("utils")
    _ = server.run()

# def simple_app() -> PythonObject:   
#     status = '200 OK'
#     headers = [('Content-type', 'text/html; charset=utf-8')]
#     startresponse = Python.import_module("wsgiref.util")
#     start_response = startresponse.start_response
#     start_response(status, headers)

#     html = """
#     <!DOCTYPE html>
#     <html lang="en">
#     <head>
#         <meta charset="UTF-8">
#         <meta name="viewport" content="width=device-width, initial-scale=1.0">
#         <title>Hello from Campfire!</title>
#         <!-- Include Tailwind CSS from CDN -->
#         <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
#     </head>
#     <body>
#         <section class="w-full h-screen flex items-center justify-center">
#             <div class="text-center">
#             <div class="text-9xl hover:text-red-500 transition-colors duration-200 ease-in-out">🔥</div>
#             <h1 class="mt-8 text-4xl font-bold">Welcome To Campfire</h1>
#             <p class="mt-4 text-gray-500 max-w-xl mx-auto">
#                 This is a simple demonstration of a landing page. Check our our docs to learn more.
#             </p>
#             <div class="mt-8 space-x-4">
#                 <button 
#                 class="inline-flex items-center justify-center rounded-md ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 border border-input bg-background hover:bg-accent hover:text-accent-foreground h-10 px-6 py-2 text-sm font-medium"
#                 >
#                 <a href="https://campfire-framework.com/" target="_blank"> 
#                     Get Started ↗️
#                 </a>              
#                 </button>
#             </div>
#             </div>
#         </section>
#     </body>
#     </html>
#     """

#     return [PythonObject(html).encode("utf-8")]

# def main():
#     # Create a WSGI server
#     server = Python.import_module("wsgiref.simple_server")
    
#     # Instantiate the server
#     httpd = server.make_server('0.0.0.0', 8000, simple_app)
#     # Wait for a single request, serve it and quit.
#     httpd.serve_forever()