import os.path

SCRIPT_DIR = os.path.abspath(
    os.path.join(os.path.dirname(__file__), '..', '..'))

class ScriptError(Exception):
    """Exception thrown by command line scripts."""
