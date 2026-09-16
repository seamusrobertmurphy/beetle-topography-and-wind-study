#!/usr/bin/env python3
"""Delete the ._* AppleDouble files ExFAT litters the tree with, ignoring unreadable folders.

The earlier `find . -name ._* -delete` step returned 1 when it met the corrupted _tools
directory entry on 2026-09-16, and Quarto treats a failing pre-render step as fatal, so
no render could start. This walk skips any folder it cannot read and never fails.
"""
import os
import pathlib

ROOT = pathlib.Path(__file__).resolve().parents[2]
n = 0
for dirpath, dirnames, filenames in os.walk(ROOT, onerror=lambda e: None):
    for f in filenames:
        if f.startswith("._"):
            try:
                os.remove(os.path.join(dirpath, f)); n += 1
            except OSError:
                pass
print(f"  removed {n} AppleDouble file(s)")
