#!/usr/bin/env python
from __future__ import with_statement

import errno

from os import makedirs, readlink, remove, symlink
from os.path import abspath, dirname, expanduser, islink, join, relpath
from shutil import copyfile

import os

PROJECT_ROOT = abspath(dirname(__file__))
HOME = expanduser('~')
FILES_ROOT = join(PROJECT_ROOT, 'files')


def copy(src, dst):
    if islink(src):
        linkto = readlink(src)
        if islink(dst):
            remove(dst)
        symlink(linkto, dst)
    else:
        copyfile(src, dst)


def main():
    for root, directories, files in os.walk(FILES_ROOT):
        def activate(f):
            activate_file(relpath(join(root, f), FILES_ROOT))
        for f in files:
            activate(f)
        if not files:
            for d in directories:
                if islink(join(root, d)):
                    activate(d)
    try:
        remove(join(HOME, '.vim', 'bundle', 'vimerl', 'syntax', 'erlang.vim'))
    except OSError as e:
        if e.errno != errno.ENOENT:
            raise

def activate_file(rel_file):
    directory = dirname(rel_file)
    mkdirp(join(HOME, directory))
    copy(join(FILES_ROOT, rel_file), join(HOME, rel_file))

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
