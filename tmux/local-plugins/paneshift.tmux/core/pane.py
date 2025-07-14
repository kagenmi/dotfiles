from __future__ import annotations

from enum import StrEnum
from typing import Literal, Self, cast
from os import kill
import re
import copy

from pydantic import BaseModel


class NodeType(StrEnum):
    LEAF = 'leaf'
    ROW = 'row'
    COL = 'col'


class BaseNode(BaseModel):
    w: int
    h: int
    x: int
    y: int

    parent: ColNode | RowNode | None = None

    def query(self, pane_id: str) -> LeafNode | None:
        if getattr(self, 'pane_id', None) == pane_id:
            return cast(LeafNode, self)

        for child in getattr(self, 'children', []):
            node = child.query(pane_id)
            if node is not None:
                return node

    def clone(self) -> Self:
        return copy.deepcopy(self)

    # for debug
    def generate_layout_graph(self, depth: int = 0) -> str:
        indent_str = '  '

        pane_id = getattr(self, 'pane_id', None)
        if pane_id:
            return f'leaf("{pane_id}")'

        # row or col
        node_type_str = str(getattr(self, 'type', 'unknown'))
        result = f'{node_type_str}(\n'

        child_strings = []
        for child in getattr(self, 'children', []):
            child_str = child.generate_layout_graph(depth+1)
            for line in child_str.split('\n'):
                child_strings.append(indent_str + line)

        result += '\n'.join(child_strings)
        result += f'\n)'

        return result


class LeafNode(BaseNode):
    type: Literal[NodeType.LEAF] = NodeType.LEAF

    pane_id: str

    @property
    def index(self) -> int:
        if self.parent is None:
            return 0

        return self.parent.children.index(self)

    @property
    def next_node(self) -> Node | None:
        if self.parent is None or self.index == len(self.parent.children) - 1:
            return None

        return self.parent.children[self.index + 1]

    @property
    def prev_node(self) -> Node | None:
        if self.parent is None or self.index == 0:
            return None

        return self.parent.children[self.index - 1]


class ColNode(BaseNode):
    type: Literal[NodeType.COL] = NodeType.COL

    children: list[Node] = []


class RowNode(BaseNode):
    type: Literal[NodeType.ROW] = NodeType.ROW

    children: list[Node] = []


Node = LeafNode | RowNode | ColNode


class LayoutParser:
    def parse(self, raw: str) -> Node:
        '''
        Format: checksum,w×h,x,y{pane_info}
        ex) 0674,187x59,0,0{93x59,0,0,46,93x59,94,0[93x29,94,0,58,93x29,94,30,59]}
        '''
        _, pane_info = raw.split(',', 1)

        node = self._parse_recursive(pane_info)
        if node is None:
            raise Exception(f'Invalid format: {raw}')

        return node

    def _parse_recursive(self, pane_info: str, parent: ColNode | RowNode | None = None) -> Node | list[Node] | None:
        pane_info = pane_info.strip()

        m = re.match(r'(\d+)x(\d+),(\d+),(\d+)(.*)$', pane_info)

        if m is None:
            return None

        w, h, x, y, rest = m.groups()
        w, h, x, y = map(int, [w, h, x, y])

        node_type = self._identify_node_type(rest)
        if node_type is None:
            raise Exception(f'Invalid format: {pane_info}')

        flat = (
            node_type is NodeType.ROW and parent and parent.type is NodeType.ROW or
            node_type is NodeType.COL and parent and parent.type is NodeType.COL
        )

        if flat:
            pass
        elif node_type is NodeType.LEAF:
            pane_id = rest.lstrip(',')
            return LeafNode(
                type=node_type,
                w=w,
                h=h,
                x=x,
                y=y,
                pane_id=pane_id,
                parent=parent,
            )
        elif node_type is NodeType.ROW:
            node = RowNode(
                type=node_type,
                w=w,
                h=h,
                x=x,
                y=y,
                parent=parent,
                children=[],
            )
        elif node_type is NodeType.COL:
            node = ColNode(
                type=node_type,
                w=w,
                h=h,
                x=x,
                y=y,
                parent=parent,
                children=[],
            )
        else:
            raise Exception(f'Unknown node type: {node_type}')

        # remove outside brackets
        children_raw = rest[1:-1]

        children = []

        for _, child_raw in enumerate(self._split_children(children_raw)):
            child = self._parse_recursive(child_raw, parent=parent if flat else node)
            if child is None:
                continue
            elif isinstance(child, list):
                for cn in child:
                    children.append(cn)
            elif isinstance(child, Node):
                children.append(child)

        if flat:
            return children
        else:
            node.children = children
            return node

    @staticmethod
    def _identify_node_type(child: str) -> NodeType | None:
        if re.search(r'\d+$', child):
            return NodeType.LEAF
        elif child.endswith(']'):
            return NodeType.COL
        elif child.endswith('}'):
            return NodeType.ROW

        return None

    def _split_children(self, content) -> list[str]:
        '''
        Returns top level children.
        '''
        children = []

        # pattern: WxH,X,Y,PANE_ID | WxH,X,Y[...] | WxH,X,Y{...}

        start_pos = 0
        while start_pos < len(content): # loop child
            # pattern: WxH,X,Y
            match = re.match(r'(\d+x\d+,\d+,\d+)', content[start_pos:])
            if not match:
                raise ValueError(f'Invalid format: {content}')

            base_part = match.group(1)
            end_pos = start_pos + len(base_part)

            if end_pos >= len(content):
                pane_info = base_part
            else:
                next_char = content[end_pos]

                if next_char == ',': # leaf
                    pane_id_m = re.match(r'(\d+)', content[end_pos + 1:])
                    if pane_id_m is None:
                        raise Exception(f'Invalid format: {base_part}')
                    pane_id = pane_id_m.group(1)

                    pane_info = content[start_pos:end_pos + 1 + len(pane_id)]
                elif next_char in '[{': # col('[') and row('{')
                    left_char = next_char
                    right_char = '}' if left_char == '{' else ']'
                    depth = 0
                    j = end_pos

                    while j < len(content):
                        if content[j] == left_char:
                            depth += 1
                        elif content[j] == right_char:
                            depth -= 1
                            if depth == 0:
                                j += 1
                                break
                        j += 1

                    pane_info = content[start_pos:j]
                else:
                    raise Exception(f'Invalid format: {content}')

            child = pane_info
            if child:
                children.append(child)

            # set next start position
            start_pos = start_pos + len(pane_info)

            # skip comma
            if start_pos < len(content) and content[start_pos] == ',':
                start_pos += 1

        return children

