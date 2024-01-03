from python import Python


struct CampfireApp:
    var port: Int
    var host: String

    fn __init__(inout self, port: Int = 8080, host: String = "0.0.0.0"):
        self.port = port
        self.host = host

    # TODO: Rewrite from python objects to native types
    fn api_path(inout self) raises -> PythonObject:
        let file_path = Python.import_module("os").path.abspath("api")
        let files_in_path = Python.import_module("os").listdir(file_path)
        return files_in_path

    fn pages_path(inout self) raises -> PythonObject:
        let file_path = Python.import_module("os").path.abspath("pages")
        let files_in_path = Python.import_module("os").listdir(file_path)
        return files_in_path

    fn serve_pages(inout self, pages_path: PythonObject) raises -> PythonObject:
        let server = Python.import_module("http.server")
        let handler = server.SimpleHTTPRequestHandler
        let httpd = server.HTTPServer((self.host, self.port), handler)        
        return ""
        
        
    fn run(inout self) raises:
        let path_api = self.api_path()
        print(path_api)
        let path_pages = self.pages_path()
        print(path_pages)
        let served = self.serve_pages(pages_path=path_pages)
        print(served)

   
fn main() raises:
    var app = CampfireApp()
    app.run()