from python import Python, PythonObject
from campfire.modules import PyModules
from campfire.startup import printAsciiArt

struct CampfireApp():
    var port: Int
    var host: String
    var pagesPath: String
    var apiPath: String
    var _modules: PyModules

    fn __init__(inout self, port: Int, host: String, pagesPath: String, apiPath: String) raises:
        self.port = port
        self.host = host
        self.apiPath = apiPath
        self.pagesPath = pagesPath
        self._modules = PyModules()

    def generate_routes(inout self) -> PythonObject:
        let html_files: PythonObject = []
        let path = self.pagesPath
        var os_files = Python.import_module("os").listdir(path)
        for file in os_files:
            if file.endswith(".html"):
                let file_string: String = str(file)
                html_files.append(file_string[:-5])
        return html_files
            
    fn starts_with(inout self, path: String, prefix: String) raises -> Bool:
        return path[:len(prefix)] == prefix

    def router(self, path: PythonObject) -> PythonObject:
        var html_files = self.generate_routes()
        var path_ = str(path)[1:] if self.starts_with(str(path), "/") else path
        for file in html_files:
            if path == file:
                return path_    
            else:
                return None
        return None
        
    def serve_GET(self, path: PythonObject):
        var os_files = Python.import_module("os")
        var subprocess = Python.import_module("subprocess")
        var http_server = Python.import_module("http.server.SimpleHTTPRequestHandler")
        # api_path = os_files.path.join(path, self.path[5:] + '.py')
        var api_path = os_files.path.join(self.apiPath, path + '.py')
        if os_files.path.isfile(api_path):
            output = subprocess.check_output(['python', api_path])
            http_server.send_response(200)
            http_server.send_header("Content-type", "application/json")
            http_server.end_headers()
            http_server.wfile.write(output)
        else:
            http_server.send_error(404, 'API Not Found: ' + self.apiPath)
    
    def serve_POST(self, path: PythonObject):
        var os_files = Python.import_module("os")
        var socketserver = Python.import_module("socketserver")
        var http_server = Python.import_module("http.server.SimpleHTTPRequestHandler")
        var jsonModule = Python.import_module("json")
        var length = int(http_server.headers.get('Content-Length'))
        var post_data = jsonModule.loads(socketserver.rfile.read(length))
        var api_path = os_files.path.join(self.apiPath, path + '.py')
        var subprocess = Python.import_module("subprocess")
        if os_files.path.isfile(api_path):
            output = subprocess.check_output(['python', api_path, jsonModule.dumps(post_data)])
            http_server.send_response(200)
            http_server.send_header("Content-type", "application/json")
            http_server.end_headers()
            http_server.wfile.write(output)
        else:
            http_server.send_error(404, 'API Not Found: ' + self.apiPath)

    
    fn POST(inout self, path: PythonObject):
        if self.apiPath

        # def serve_API(self):
    #     var os_files = Python.import_module("os")
    #     api_path = os_files.path.join(self.apiPath, self.path[5:] + '.py')
    #     if os_files.path.isfile(self.apiPath):
    #         output = subprocess.check_output(['python', api_path])
    #         self.send_response(200)
    #         self.send_header("Content-type", "application/json")
    #         self.end_headers()
    #         self.wfile.write(output)
    #     else:
    #         self.send_error(404, 'API Not Found: %s' % self.path)
            

    fn serve_page(inout self) raises:
        let handler = Python.import_module("http.server").SimpleHTTPRequestHandler
        _ = handler.send_response(200)

    fn run(inout self) raises:      
        """Print ascii art."""
        # printAsciiArt()

        """Print server starting."""
        let status = "Starting server at http://"+ String(self.host) + ":" + String(self.port)
        print(status)

        """Print generated routes."""
        let routes = self.generate_routes()
        print("Generated routes: " + str(routes))



        # let server = Python.import_module("http.server")        
        # let httpd = server.HTTPServer(('localhost', self.port), server.SimpleHTTPRequestHandler)
        # let page = self.pagePath
        # let status = "Starting server at http://localhost:" + String(self.port)
        # print(status)
        # _ = httpd.serve_forever()
    