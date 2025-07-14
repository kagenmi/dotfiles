#!/usr/bin/env python3

import sys
import os

plugin_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
venv_path = os.path.join(plugin_dir, 'venv', 'lib', 'python3.*/site-packages')
sys.path.insert(0, venv_path)

from pane import Node, LayoutParser
from tmux_api import TmuxAPI

def main():
    tmux = TmuxAPI()
    layout_parser = LayoutParser()

    raw_layout = tmux.get_window_layout()
    node = layout_parser.parse(raw_layout)

    print(node.generate_layout_graph())


if __name__ == '__main__':
    main()
