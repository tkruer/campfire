from python import Python

struct Campfire:
    var port: Int
    var pageContent: String

    fn __init__(inout self, port: Int, pageContent: String) raises:
        self.port = port
        self.pageContent = pageContent

    fn serve_page(self) raises:
        let handler = Python.import_module("http.server").SimpleHTTPRequestHandler
        _ = handler.send_response(200)

    fn run(self) raises:
        print("Starting server on port", self.port)
        let server = Python.import_module("http.server")
        # Set up the server with the custom handler
        let httpd = server.HTTPServer(('localhost', self.port), server.SimpleHTTPRequestHandler)
        print("Serving page")
        _ = httpd.serve_forever()
        