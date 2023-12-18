from python import Python, PythonObject

struct PyModules:
    var py: PythonObject
    var socket: PythonObject
    var httpserver: PythonObject
    var socketserver: PythonObject
    var pythonOS: PythonObject
    var builtins: PythonObject
    var subprocess: PythonObject    
    var json: PythonObject

    fn __init__(inout self) raises -> None:
        self.py = self.__load_builtins_module()
        self.socket = self.__load_socket_module()
        self.httpserver = self.__load_httpserver_module()
        self.socketserver = self.__load_socketserver_module()
        self.pythonOS = self.__load_python_os_module()
        self.builtins = self.__load_builtins_module()
        self.subprocess = self.__load_subprocess_module()
        self.json = self.__load_json_module()

    @staticmethod
    fn __load_json_module() raises -> PythonObject:
        let json = Python.import_module("json")
        return json

    @staticmethod
    fn __load_subprocess_module() raises -> PythonObject:
        let subprocess = Python.import_module("subprocess")
        return subprocess

    @staticmethod
    fn __load_python_os_module() raises -> PythonObject:
        let pythonOS = Python.import_module("os")
        # TODO: remove this hack when we have a better way to get the current working directory!
        return pythonOS

    @staticmethod
    fn __load_socketserver_module() raises -> PythonObject:
        let socketserver = Python.import_module("socketserver")
        return socketserver

    @staticmethod
    fn __load_httpserver_module() raises -> PythonObject:
        let httpserver = Python.import_module("http.server")
        return httpserver

    @staticmethod
    fn __load_socket_module() raises -> PythonObject:
        let socket = Python.import_module("socket")
        return socket

    @staticmethod
    fn __load_builtins_module() raises -> PythonObject:
        let builtins = Python.import_module("builtins")
        return builtins
