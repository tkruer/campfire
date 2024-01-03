# modules/campfire.py

import mimetypes
import os
import json
import importlib
from wsgiref import simple_server, util

class CampfireApp:
    def __init__(self, host='localhost', port=3000, pages_dir='pages'):
        self.host = host
        self.port = port
        self.pages_dir = pages_dir

    def serve(self):
        httpd = simple_server.make_server(self.host, self.port, self.app)
        print(f"Serving on {self.host}:{self.port}, control-C to stop")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("Shutting down.")
            httpd.server_close()

    def app(self, environ, respond):
        if environ['PATH_INFO'].startswith('/api/'):
            return self.process_api_request(environ, respond)

        return self.process_static_request(environ, respond)

    def process_static_request(self, environ, respond):
        base_dir = os.path.join(os.path.dirname(__file__), '..', self.pages_dir)
        requested_path = environ['PATH_INFO'][1:]
        file_path = os.path.join(base_dir, requested_path)

        if os.path.isdir(file_path):
            file_path = os.path.join(file_path, 'index.html')

        mime_type = mimetypes.guess_type(file_path)[0]

        if os.path.exists(file_path) and os.path.isfile(file_path):
            respond("200 OK", [("Content-Type", mime_type)])
            return util.FileWrapper(open(file_path, "rb"))
        else:
            respond("404 Not Found", [("Content-Type", "text/plain")])
            return [b"Not Found"]

    def process_api_request(self, environ, respond):
        _, _, endpoint = environ['PATH_INFO'].rpartition('/')

        try:
            api_module = importlib.import_module(f'{self.pages_dir}.api.{endpoint}')
            
            # Handle POST request
            if environ['REQUEST_METHOD'] == 'POST':
                content_length = int(environ.get('CONTENT_LENGTH', 0))
                body = environ['wsgi.input'].read(content_length)
                data = json.loads(body)

                result = getattr(api_module, endpoint)(data)
            else:
                # For non-POST requests, you can modify this as needed
                result = getattr(api_module, endpoint)()

            respond('200 OK', [('Content-Type', 'application/json')])
            return [json.dumps(result).encode('utf-8')]

        except (ImportError, AttributeError) as e:
            respond('404 Not Found', [('Content-Type', 'text/plain')])
            return [b'API endpoint not found']