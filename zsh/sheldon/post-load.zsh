# Custom post-load processing for sheldon plugins
# This file contains hooks that were previously in zinit's atload

# Unalias grv from omz-git plugin
unalias grv 2>/dev/null || true
