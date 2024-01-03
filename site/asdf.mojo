from python import PythonObject, Python

trait WebServer:
    fn get_mojo_lang_version(self) raises:
        ...

    fn serve_html(self, html_page: String) raises:
            ...

struct CampfireApp(WebServer):
    var port: PythonObject
    var host: PythonObject

    fn __init__(inout self, port: PythonObject, host: PythonObject) raises:
        let webserver = Python.import_module("http.server")
        self.port = port
        self.host = host

    fn get_mojo_lang_version(inout self) raises:
        import os
        let mojo_version = os.getenv("VERSION_MOJO_CAMPFIRE")
        print(mojo_version)

    fn serve_html(inout self, html_page: String) raises:
        let server_address = (self.host, self.port)

        let handler = PythonObject("webserver.SimpleHTTPRequestHandler")
        let httpd = PythonObject("webserver.HTTPServer")(server_address, handler)
        print("Serving on port", self.port)
        httpd.serve_forever()

fn main() raises:
    let port = PythonObject(8000)
    let host = PythonObject("localhost")    
    let app = CampfireApp(port, host)
    app.get_mojo_lang_version()