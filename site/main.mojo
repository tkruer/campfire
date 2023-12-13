from python import Python
from python.object import PythonObject

struct CampfireApp:
    var port: Int
    var host: String
    var pageContent: String

    fn __init__(inout self, port: Int, host: String, pageContent: String) raises:
        self.port = port
        self.host = host
        self.pageContent = pageContent
    
    # def setup_server(inout self) -> PythonObject[]:
    #     let wsgiref = Python.import_module("wsgiref.simple_server")
    #     let status: String = '200 OK'
    #     let headers: ListLiteral[Tuple[StringLiteral, StringLiteral]] = [('Content-type', 'text/html; charset=utf-8')]
        
    #     let start_response_ = wsgiref.start_response(status, headers)
    #     let status_startup = "Starting server at " + "http://" + String(self.host) + ":" + String(self.port)
    #     print(status_startup)
    #     let html = self.pageContent

    
        
    # def setup_server(inout self):
    #     let wsgiref = Python.import_module("wsgiref.simple_server")
    #     let status: String = '200 OK'
    #     let headers: ListLiteral[Tuple[StringLiteral, StringLiteral]] = [('Content-type', 'text/html; charset=utf-8')]
    #     let start_response_ = wsgiref.start_response(status, headers)
    #     let html = self.pageContent
    #     let response = start_response_(html)
    #     return response

    # fn run_server(inout self) raises:
    #     let wsgiref = Python.import_module("wsgiref.simple_server")
    #     let server = wsgiref.make_server(self.host, self.port, self.pageContent)        
    #     let status = "Starting server at " + "http://" + String(self.host) + ":" + String(self.port)
    #     print(status)
    #     _ = server.serve_forever()

    # fn serve_page(inout self) raises:
    #     let handler = Python.import_module("http.server").SimpleHTTPRequestHandler
    #     _ = handler.send_response(200)

    # fn run(inout self) raises:        
    #     let server = Python.import_module("http.server")        
    #     let httpd = server.HTTPServer(('localhost', self.port), server.SimpleHTTPRequestHandler)
    #     let status = "Starting server at" + String(self.host) + String(self.port)
    #     print(status)
    #     _ = httpd.serve_forever()
    
# fn main() raises:
#     let pageHTML: FileHandle = open("index.html", "r")
#     var cf = CampfireApp(
#             port=8000, 
#             host="0.0.0.0",
#             pageContent=pageHTML
#         )
#     cf.run_server()




fn main() raises:
    let pageHTML: FileHandle = open("index.html", "rb")
    let vec: DynamicVector[PythonObject] = [b'pageHTML'

    let wsgiref = Python.import_module("wsgiref.simple_server")

    let status: String = '200 OK'
    let headers: ListLiteral[Tuple[StringLiteral, StringLiteral]] = [('Content-type', 'text/html; charset=utf-8')]

    # let start_response_ = wsgiref.start_response(status, headers)
    let status_startup = "Starting server at " + "http://" + "0.0.0.0" + ":" + String(8000)
    print(status_startup)

    # let response = start_response_(html)
    # print(response)

    let httpd = wsgiref.make_server("0.0.0.0", 8000, PythonObject(pageHTML.read()))
    _ = httpd.serve_forever()
