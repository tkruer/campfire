from python import Python, PythonObject

struct CampfireApp:
    var port: Int
    var host: String
    var pageContent: String

    fn __init__(inout self, port: Int, host: String, pageContent: String) raises:
        self.port = port
        self.host = host
        self.pageContent = pageContent

    fn serve_page(inout self) raises:
        let handler = Python.import_module("http.server").SimpleHTTPRequestHandler
        _ = handler.send_response(200)

    fn run(inout self) raises:        
        let server = Python.import_module("http.server")        
        let httpd = server.HTTPServer(('localhost', self.port), server.SimpleHTTPRequestHandler)
        let status = "Starting server at http://localhost:" + String(self.port)
        print(status)
        _ = httpd.serve_forever()
    