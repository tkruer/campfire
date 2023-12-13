from python.python import Python
from python.object import PythonObject

fn main() raises:
    Python.add_to_path(".")
    let server = Python.import_module("utils")
    _ = server.run()
