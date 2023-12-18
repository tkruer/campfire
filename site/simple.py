import http.server
import socketserver
import os
import subprocess
import json


class CampfireApp(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def do_API_GET(self):
        api_path = os.path.join(api_dir, self.path[5:] + '.py')
        if os.path.isfile(api_path):
            output = subprocess.check_output(['python', api_path])
            self.send_response(200)
            self.send_header("Content-type", "application/json")
            self.end_headers()
            self.wfile.write(output)
        else:
            self.send_error(404, 'API Not Found: %s' % self.path)
            
    def do_API_POST(self):
        length = int(self.headers.get('Content-Length'))
        post_data = json.loads(self.rfile.read(length))
        api_path = os.path.join(api_dir, self.path[5:] + '.py')
        if os.path.isfile(api_path):
            output = subprocess.check_output(['python', api_path, json.dumps(post_data)])
            self.send_response(200)
            self.send_header("Content-type", "application/json")
            self.end_headers()
            self.wfile.write(output)
        else:
            self.send_error(404, 'API Not Found: %s' % self.path)

    def do_POST(self):
        if self.path.startswith('/api/'):
            self.do_API_POST()
        else:
            self.send_error(405, 'Method Not Allowed')

    def get_html_files(self):
        html_files = []
        for root, dirs, files in os.walk(web_dir):
            for file in files:
                if file.endswith('.html'):
                    html_files.append(file[:-5])  # remove .html extension
        return html_files

    # TODO: Come back to this?
    def router(self, path):
        html_files = self.get_html_files()
        path = path[1:] if path.startswith('/') else path
        if path in html_files:
            return path
        else:
            return None

    def do_API(self):
        api_path = os.path.join(api_dir, self.path[5:] + '.py')
        if os.path.isfile(api_path):
            output = subprocess.check_output(['python', api_path])
            self.send_response(200)
            self.send_header("Content-type", "application/json")
            self.end_headers()
            self.wfile.write(output)
        else:
            self.send_error(404, 'API Not Found: %s' % self.path)

    def do_GET(self):
        if self.path.startswith('/api/'):
            self.do_API()
        else:
            try:
                if self.path == '/':
                    self.path = '/index.html'
                else:
                    page_name = self.router(self.path)
                    if page_name:
                        self.path = f'/{page_name}.html'
                    else:
                        self.send_error(404, 'File Not Found: %s' % self.path)
                        return

                file_to_open = os.path.join(web_dir, self.path[1:])
                if os.path.isfile(file_to_open):
                    self.send_response(200)
                    self.send_header("Content-type", "text/html")
                    self.end_headers()
                    with open(file_to_open, 'rb') as f:
                        self.wfile.write(f.read())
                else:
                    self.send_error(404, 'File Not Found: %s' % self.path)
            except Exception as e:
                self.send_error(500, 'Server Error: %s' % str(e))
    

    def run(self, server):
        print("Server started at localhost:" + str(server.server_address[1]))
        server.serve_forever()

class CampfireServer(socketserver.TCPServer):
    def __init__(self, server_address, RequestHandlerClass, bind_and_activate=True, port=None, web_dir=None, api_dir=None):
        self.port = port
        self.web_dir = web_dir
        self.api_dir = api_dir
        super().__init__(server_address, RequestHandlerClass, bind_and_activate)

    def run(self):
        print("Server started at localhost:" + str(self.server_address[1]))
        self.serve_forever()

if __name__ == "__main__":
    port = 8000
    web_dir = os.path.join(os.path.dirname(__file__), 'pages')
    api_dir = os.path.join(os.path.dirname(__file__), 'api')

    server = CampfireServer(("", port), CampfireApp, port=port, web_dir=web_dir, api_dir=api_dir)
    server.run()