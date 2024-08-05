#!/usr/bin/env python

import argparse
import importlib
import os
import platform
import sys
from collections import defaultdict
from copy import copy
from dataclasses import asdict, dataclass
from enum import Enum
from importlib import reload
from pathlib import Path
from typing import Generator


# Dummy objects
class Dummy:
    dummy_dict = {"key1": "value1", "key2": "value2"}
    dummy_list = ["item1", "item2", "item3"]
    dummy_tuple = ("item1", "item2", "item3")

    @staticmethod
    def get_dummy_dict(size=2, nested=False) -> dict:
        d = {f"key{i}": f"value{i}" for i in range(size)}
        if nested:
            d["nested"] = copy(d)
        return d

    @staticmethod
    def get_dummy_list(len=3) -> list:
        return [f"item{i}" for i in range(len)]

    @staticmethod
    def get_dummy_tuple() -> tuple:
        return ("item1", "item2", "item3")

    @staticmethod
    def get_dummy_generator(len=3) -> Generator:
        return (f"item{i}" for i in range(len))


# Custom hooks
def setup_import_hooks():
    import os

    class MatplotlibFinder:
        def find_spec(self, fullname, path, target=None):
            if fullname == "matplotlib":
                return MatplotlibLoader().find_spec(fullname, path, target)
            return None

    class MatplotlibLoader:
        def find_spec(self, fullname, path, target=None):
            import importlib.util

            spec = importlib.util.find_spec(fullname)
            spec.loader = self
            return spec

        def create_module(self, spec):
            return None

        def exec_module(self, module):
            if os.getenv("TERM") == "xterm-kitty":
                import matplotlib

                matplotlib.use("module://backend_interagg")
            import importlib

            original_matplotlib = importlib.import_module("matplotlib")
            module.__dict__.update(original_matplotlib.__dict__)

    sys.meta_path.insert(0, MatplotlibFinder())


def load_ptpython_config(repl):
    config_path = Path.home() / ".config" / "ptpython" / "config.py"
    if config_path.exists():
        config_globals = {}
        with open(config_path, "r") as f:
            code = compile(f.read(), str(config_path), "exec")
            exec(code, config_globals)
        if "configure" in config_globals:
            config_globals["configure"](repl)

    # Ensure blank lines are inserted after output
    repl.insert_blank_line_after_output = True


def print_versions():
    print(f"Python {platform.python_version()} ({sys.executable})")
    try:
        import IPython

        print(f"IPython {IPython.__version__}")
    except ImportError:
        print("IPython is not installed.")

    # Print virtual environment information if any
    venv = os.getenv("VIRTUAL_ENV")
    if venv:
        print(f"Virtualenv: {venv}")


def main():
    parser = argparse.ArgumentParser(
        description="Custom Python REPL with various configurations."
    )
    parser.add_argument(
        "--spark", action="store_true", help="Start with Spark session configured."
    )
    parser.add_argument(
        "--delta-spark",
        action="store_true",
        help="Start with Delta Lake Spark session.",
    )
    parser.add_argument(
        "--spark-connect", action="store_true", help="Use Databricks Spark Connect."
    )
    parser.add_argument(
        "--plain", action="store_true", help="Start plain ptpython REPL."
    )
    parser.add_argument(
        "--builtin", action="store_true", help="Start built-in Python REPL."
    )

    args = parser.parse_args()

    # Setup custom import hooks
    setup_import_hooks()

    # Handle REPL options
    if args.spark:
        print("Starting REPL with Spark session...")
        # Add Spark session setup here
        # Example: from pyspark.sql import SparkSession
        # spark = SparkSession.builder.appName("MyApp").getOrCreate()
    elif args.delta_spark:
        print("Starting REPL with Delta Lake Spark session...")
        # Add Delta Lake Spark session setup here
    elif args.spark_connect:
        print("Starting REPL with Spark Connect...")
        # Add Databricks Spark Connect setup here
    elif args.builtin:
        print("Starting built-in Python REPL...")
        import code

        code.interact(local=dict(globals(), **locals()))
        return
    else:
        print_versions()
        print("Starting ptpython REPL...")
        try:
            from ptpython.repl import embed

            embed(globals(), locals(), configure=load_ptpython_config)
        except ImportError:
            print("ptpython is not installed. Falling back to built-in REPL.")
            import code

            code.interact(local=dict(globals(), **locals()))
            return


if __name__ == "__main__":
    main()
