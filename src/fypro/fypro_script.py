import sys
import os
import io
import shutil
import argparse
import zipfile
import urllib.request
from typing import Dict, Optional, List
import fypp
from fypro import ScriptError, SCRIPT_DIR


def main(cmdlineargs: Optional[List] = None):
    """Main of the fypro script.

    Args:
        cmdlineargs: List of command line arguments. If not specified or None is passed, arguments
        in sys.argv will be used.
    """
    parser = _get_cmd_line_parser()
    args = parser.parse_args(cmdlineargs)
    if "func" in args:
        args.func(args)
    else:
        parser.error("Missing subcommand")


def _get_cmd_line_parser() -> argparse.ArgumentParser:
    """Parse the command line arguments"""

    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers()

    msg = "Create a new project from scratch"
    parser_create = subparsers.add_parser("new", help=msg)

    msg = "Template to use to create the project"
    parser_create.add_argument("--template", choices=["simple"], default="simple", help=msg)

    msg = "Name of the project to be created"
    parser_create.add_argument("name", help=msg)

    parser_create.set_defaults(func=_main_new)

    return parser


def _main_new(args: argparse.Namespace):
    """Main of the create subcommand"""

    env = _setup_env(args)
    _create_project_dir(env["project_name_lower"])
    templatedir = os.path.join(SCRIPT_DIR, "template", args.template)
    projectdir = os.path.join(os.getcwd(), env["project_name_lower"])
    print(f"TEMPLATE_DIR = {templatedir}")
    _copy_template_files(templatedir, projectdir, env)
    url = "https://github.com/aradi/fytest/archive/refs/heads/master.zip"
    _download_zip_archive(url, os.path.join(projectdir, "external"), "fytest-master", "fytest")


def _create_project_dir(project_name: str):
    try:
        os.makedirs(project_name)
    except OSError as exc:
        msg = f"Directory '{project_name}' can not be created ({exc})"
        raise ScriptError(msg) from exc


def _setup_env(args: argparse.Namespace) -> Dict:
    """Set up the environment for Fypp's evaluator."""

    env = {
        "project_name": args.name,
        "project_name_lower": args.name.lower(),
    }
    return env


def _copy_template_files(templatedir: str, projectdir: str, env: Dict):
    """Copies and expands template files."""

    processor = fypp.Processor(evaluator=fypp.Evaluator(env=env))
    for root, dirs, files in os.walk(templatedir):
        for fname in files:
            srcpath = os.path.join(root, fname)
            trgpath = _get_target_path(
                templatedir, projectdir,
                os.path.join(root, fname.format(**env)))
            with open(trgpath, "w") as fp:
                fp.write(processor.process_file(srcpath))
        for dirname in dirs:
            srcpath = os.path.join(root, dirname)
            trgpath = _get_target_path(templatedir, projectdir, srcpath)
            os.makedirs(trgpath)


def _download_zip_archive(url, targetdir, origname, targetname):
    with urllib.request.urlopen(url) as ff:
        archive = zipfile.ZipFile(io.BytesIO(ff.read()))
    archive.extractall(targetdir)
    shutil.move(
        os.path.join(targetdir, origname),
        os.path.join(targetdir, targetname))

    

def _get_target_path(sourcedir: str, targetdir: str, sourcepath: str) -> str:
    return os.path.join(targetdir, os.path.relpath(sourcepath, sourcedir))
