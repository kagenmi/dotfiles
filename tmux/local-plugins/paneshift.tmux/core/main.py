#!/usr/bin/env python3

import sys
import os

plugin_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
venv_path = os.path.join(plugin_dir, 'venv', 'lib', 'python3.*/site-packages')
sys.path.insert(0, venv_path)

import argparse
import time
from enum import StrEnum
from typing import Literal
import traceback

from pane import (
    NodeType,
    Node,
    LeafNode,
    RowNode,
    ColNode,
    LayoutParser
)
from tmux_api import TmuxAPI

tmux = TmuxAPI()
layout_parser = LayoutParser()

class Direction(StrEnum):
    LEFT = 'left'
    RIGHT = 'right'
    UP = 'up'
    DOWN = 'down'


def main():
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument(
        'direction',
        choices=list(Direction),
        type=lambda s: Direction(s),
    )
    arg_parser.add_argument('--key-table', dest='tmux_key_table')
    arg_parser.add_argument('--target-pane')

    args = arg_parser.parse_args()

    try:
        move_pane(args.direction, args.target_pane)

        if args.tmux_key_table:
            tmux.switch_client(key_table=args.tmux_key_table)
    except Exception as e:
        traceback.print_exception(type(e), e, e.__traceback__, file=sys.stdout)


def move_pane(direction: Direction, target_pane: str | None = None):
    if target_pane:
        tmux.select_pane(target_pane)

    root = get_layout()

    active_pane_id = tmux.get_active_pane_id()
    active_node = root.query(pane_id=active_pane_id)

    if active_node is None:
        raise Exception('No active pane')

    if active_node.parent is None:
        return

    if direction in (Direction.LEFT, Direction.RIGHT):
        if active_node.parent.type is NodeType.COL:
            col_move_out(active_node, direction)
        elif active_node.parent.type is NodeType.ROW:
            next_node = active_node.prev_node if direction is Direction.LEFT else active_node.next_node
            if next_node:
                if (
                    len(active_node.parent.children) == 2 and
                    active_node.type is NodeType.LEAF and
                    next_node.type is NodeType.LEAF
                ):
                    tmux.swap_pane(
                        active_node.pane_id,
                        next_node.pane_id,
                        detached=True,
                    )
                else:
                    col_move_in(active_node, next_node)
            elif (
                active_node.parent.parent is not None and
                active_node.parent.parent.type is NodeType.COL
            ):
                col_move_out(active_node, direction, col=active_node.parent.parent)
    elif direction in (Direction.UP, Direction.DOWN):
        if active_node.parent.type is NodeType.ROW:
            row_move_out(active_node, direction)
        elif active_node.parent.type is NodeType.COL:
            next_node = active_node.prev_node if direction is Direction.UP else active_node.next_node
            if next_node:
                if (
                    len(active_node.parent.children) == 2 and
                    active_node.type is NodeType.LEAF and
                    next_node.type is NodeType.LEAF
                ):
                    tmux.swap_pane(
                        active_node.pane_id,
                        next_node.pane_id,
                        detached=True,
                    )
                else:
                    row_move_in(active_node, next_node)
            elif (
                active_node.parent.parent is not None and
                active_node.parent.parent.type is NodeType.ROW
            ):
                row_move_out(active_node, direction, row=active_node.parent.parent)

    # refresh root
    root = get_layout()
    equalize(root, root.w, root.h)


def col_move_out(
    leaf: LeafNode,
    direction: Literal[Direction.LEFT, Direction.RIGHT],
    col: ColNode | None = None
):
    if leaf.parent is None: # root node
        return

    if col is None:
        if leaf.parent.type is not NodeType.COL:
            raise Exception('Parent is not col.')
        col = leaf.parent

    new_pane_id = tmux.split_window(
        leaf.pane_id,
        horizontal=True,
        before=direction == Direction.RIGHT,
        is_dummy=True,
        detached=True,
    )

    move_col(new_pane_id, col, ignore_pane_ids=[leaf.pane_id])


def row_move_out(
    leaf: LeafNode,
    direction: Literal[Direction.UP, Direction.DOWN],
    row: RowNode | None = None
):
    if leaf.parent is None: # root node
        return

    if row is None:
        if leaf.parent.type is not NodeType.ROW:
            raise Exception('Parent is not row.')
        row = leaf.parent

    new_pane_id = tmux.split_window(
        leaf.pane_id,
        before=direction == Direction.DOWN,
        is_dummy=True,
        detached=True,
    )

    move_row(new_pane_id, row, ignore_pane_ids=[leaf.pane_id])


def col_move_in(
    leaf: LeafNode,
    col: ColNode | LeafNode,
):
    if leaf.parent is None: # root node
        return

    new_pane_id = tmux.split_window(
        leaf.pane_id,
        horizontal=False,
        is_dummy=True,
        detached=True,
    )

    move_col(new_pane_id, col, ignore_pane_ids=[leaf.pane_id])


def row_move_in(
    leaf: LeafNode,
    row: RowNode | LeafNode,
):
    if leaf.parent is None: # root node
        return

    new_pane_id = tmux.split_window(
        leaf.pane_id,
        horizontal=True,
        is_dummy=True,
        detached=True,
    )

    move_row(new_pane_id, row, ignore_pane_ids=[leaf.pane_id])


def move_col(target_pane_id: str, col: ColNode | LeafNode, ignore_pane_ids: list[str] = []):
    if col.type is NodeType.LEAF:
        tmux.join_pane(
            source_pane_id=col.pane_id,
            target_pane_id=target_pane_id,
            detached=True,
        )
    elif col.type is NodeType.COL:
        for child in col.children:
            if child.type is NodeType.LEAF and child.pane_id not in ignore_pane_ids:
                tmux.join_pane(
                    source_pane_id=child.pane_id,
                    target_pane_id=target_pane_id,
                    detached=True,
                )
            elif child.type is NodeType.ROW:
                # leaf["1"] -> col[leaf["2"], leaf["1"]]
                new_pane_id = tmux.split_window(
                    target_pane_id=target_pane_id,
                    before=True,
                    is_dummy=True,
                    detached=True,
                )

                move_row(new_pane_id, child, ignore_pane_ids=ignore_pane_ids)

    tmux.kill_pane(target_pane_id)


def move_row(target_pane_id: str, row: RowNode | LeafNode, ignore_pane_ids: list[str] = []):
    if row.type is NodeType.LEAF:
        tmux.join_pane(
            source_pane_id=row.pane_id,
            target_pane_id=target_pane_id,
            detached=True,
        )
    elif row.type is NodeType.ROW:
        for child in row.children:
            if child.type is NodeType.LEAF and child.pane_id not in ignore_pane_ids:
                tmux.join_pane(
                    source_pane_id=child.pane_id,
                    target_pane_id=target_pane_id,
                    horizontal=True,
                    before=True,
                    detached=True,
                )
            elif child.type is NodeType.COL:
                # leaf["1"] -> row[leaf["2"], leaf["1"]]
                new_pane_id = tmux.split_window(
                    target_pane_id=target_pane_id,
                    horizontal=True,
                    before=True,
                    is_dummy=True,
                    detached=True,
                )

                move_col(new_pane_id, child, ignore_pane_ids=ignore_pane_ids)

    tmux.kill_pane(target_pane_id)


def equalize(
    node: LeafNode | RowNode | ColNode,
    total_width: int,
    total_height: int,
):
    if node.type is NodeType.LEAF:
        if node.type is NodeType.LEAF:
            tmux.resize_pane(node.pane_id, total_width, total_height)
    elif node.type in (NodeType.COL, NodeType.ROW):
        count = len(node.children)
        for i, child in enumerate(node.children):
            if node.type is NodeType.COL:
                h = total_height // count
                h = h + (1 if i < total_height % count else 0)
                equalize(child, total_width, h)
            elif node.type is NodeType.ROW:
                w = total_width // count
                w = w + (1 if i < total_width % count else 0)
                equalize(child, w, total_height)


def get_layout() -> Node:
    raw_layout = tmux.get_window_layout()
    node = layout_parser.parse(raw_layout)

    return node


if __name__ == '__main__':
    main()
