import subprocess


class TmuxAPI:
    def get_window_layout(self):
        return self._cmd([
            'display-message',
            '-p', '#{window_layout}'
        ])

    def get_window_size(self) -> tuple[int, int]:
        window_size = self._cmd([
            'tmux', 'display-message',
            '-p', '#{window_width} #{window_height}'
        ])

        w_text, h_text = window_size.split()

        return int(w_text), int(h_text)

    def resize_pane(self, pane_id: str, x: int | str, y: int | str):
        args = [
            'resize-pane',
            '-t', f'%{pane_id}',
            '-x', str(x),
            '-y', str(y),
        ]

        self._cmd(args)

    def get_active_pane_id(self):
        result = self._cmd([
            'display-message',
            '-p', '#{pane_id}'
        ])

        return result.lstrip('%')

    def select_pane(self, pane_id: str):
        return self._cmd([
            'select-pane',
            '-t', f'%{pane_id}'
        ])

    def swap_pane(
        self,
        source_pane_id: str,
        target_pane_id: str,
        detached: bool = False,
    ):
        args = [
            'swap-pane',
            '-s', f'%{source_pane_id}',
            '-t', f'%{target_pane_id}',
        ]

        if detached:
            args += ['-d']

        return self._cmd(args)

    def split_window(
        self,
        target_pane_id: str | None = None,
        horizontal: bool = False,
        before: bool = False,
        is_dummy: bool | None = False,
        detached: bool | None = False,
    ) -> str:
        args = [
            'split-window',
            '-c', '#{pane_current_path}',
            '-P', '-F', '#{pane_id}',
        ]

        args += ['-h'] if horizontal else ['-v']
        args += ['-b'] if before else []

        if target_pane_id:
            args += ['-t', f'%{target_pane_id}']

        if detached:
            args += ['-d']

        if is_dummy:
            args += ['cat']

        new_pane_id = self._cmd(args)
        new_pane_id = new_pane_id.lstrip('%')

        return new_pane_id

    def join_pane(
        self,
        source_pane_id: str | None = None,
        target_pane_id: str | None = None,
        horizontal: bool | None = None,
        before: bool | None = None,
        detached: bool | None = False,
    ):
        args = [
            'join-pane',
        ]

        args += ['-h'] if horizontal else ['-v']
        args += ['-b'] if before else []

        if source_pane_id:
            args += ['-s', f'%{source_pane_id}']

        if target_pane_id:
            args += ['-t', f'%{target_pane_id}']

        if detached:
            args += ['-d']

        return self._cmd(args)

    def kill_pane(self, pane_id: str):
        return self._cmd([
            'kill-pane',
            '-t', f'%{pane_id}'
        ])

    def switch_client(self, key_table: str | None = None):
        args = [
            'switch-client',
        ]

        if key_table is not None:
            args += ['-T', key_table]

        return self._cmd(args)

    def _cmd(self, args: list[str]) -> str:
        clean_args = [a for a in args if a]

        result = subprocess.run(
            ['tmux'] + clean_args,
            capture_output=True,
            text=True,
            check=True,
        )

        return result.stdout.strip()
