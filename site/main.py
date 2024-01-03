import http.server
import socketserver
import os
import subprocess
import json


class CampfireApp(http.server.SimpleHTTPRequestHandler):

    def get_html_files(self) -> list:
        html_files = []
        for files in os.walk(web_dir):
            for file in files:
                if file.endswith('.html'):
                    html_files.append(file[:-5])  # remove .html extension
        return html_files

    # TODO: Come back to this?
    def router(self, path: str) -> str or None:
        html_files = self.get_html_files()
        path = path[1:] if path.startswith('/') else path
        if path in html_files:
            return path
        else:
            return None


    def do_API(self, method):
        api_path = os.path.join(api_dir, self.path[5:] + '.py')
        if os.path.isfile(api_path):
            content_type = "application/json"
            if method == 'POST':
                length = int(self.headers.get('Content-Length'))
                post_data = json.loads(self.rfile.read(length))
                output = subprocess.check_output(['python', api_path, json.dumps(post_data)])
            else:
                output = subprocess.check_output(['python', api_path])

            self.send_response(200)
            self.send_header("Content-type", content_type)
            self.end_headers()
            self.wfile.write(output)
        else:
            self.send_error(404, f'API Not Found: {self.path}')

    def do_GET(self):
        if self.path.startswith('/api/'):
            self.do_API('GET')
        else:
            try:
                if self.path == '/':
                    self.path = '/index.html'
                else:
                    page_name = self.router(self.path)
                    if page_name:
                        self.path = f'/{page_name}.html'
                    else:
                        self.send_error(404, f'File Not Found: {self.path}')
                        return

                file_to_open = os.path.join(web_dir, self.path[1:])
                if os.path.isfile(file_to_open):
                    self.send_response(200)
                    self.send_header("Content-type", "text/html")
                    self.end_headers()
                    with open(file_to_open, 'rb') as f:
                        self.wfile.write(f.read())
                else:
                    self.send_error(404, f'File Not Found: {self.path}')
            except Exception as e:
                self.send_error(500, f'Server Error: {str(e)}')

    def do_POST(self):
        if self.path.startswith('/api/'):
            self.do_API('POST')
        else:
            self.send_error(405, 'Method Not Allowed')


if __name__ == "__main__":
    port = 8000
    web_dir = os.path.join(os.path.dirname(__file__), 'pages')
    api_dir = os.path.join(os.path.dirname(__file__), 'api')

    server = socketserver.TCPServer(("", port), CampfireApp)
    print(f"Server started at localhost:{port}")
    server.serve_forever()
