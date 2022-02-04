#!/usr/bin/env python3
from __future__ import with_statement

import errno

from os import makedirs, readlink, remove, symlink
from os.path import abspath, dirname, exists, expanduser, islink, join, relpath
from shutil import copyfile
from subprocess import check_call

import os

PROJECT_ROOT = abspath(dirname(__file__))
HOME = expanduser('~')
FILES_ROOT = join(PROJECT_ROOT, 'files')


def main():
    for root, directories, files in os.walk(FILES_ROOT):
        # I have at least one directory symlink for neovim and this is a way to copy it over
        # using the same mechanism I use for files
        files.extend([full_d for d in directories if islink(full_d := join(root, d))])
        for f in files:
            activate_file(relpath(join(root, f), FILES_ROOT))


def activate_file(rel_file):
    directory = dirname(rel_file)
    mkdirp(join(HOME, directory))
    src = join(FILES_ROOT, rel_file)
    dst = join(HOME, rel_file)
    if islink(src) and exists(dst):
        # Otherwise we get an exception from copyfile() when trying to create
        # a symlink while one already exists.
        remove(dst)
    copyfile(join(FILES_ROOT, rel_file), dst, follow_symlinks=False)

def mkdirp(path):
    try:
        makedirs(path)
    except OSError as e:
        if e.errno == errno.EEXIST:
            pass
        else:
            raise


if __name__ == '__main__':
    main()
