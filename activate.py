#!/usr/bin/env python
from __future__ import with_statement

import errno

from os import makedirs
from os.path import abspath, dirname, expanduser, join, relpath
from shutil import copyfile

import os

PROJECT_ROOT = abspath(dirname(__file__))
HOME = expanduser('~')
FILES_ROOT = join(PROJECT_ROOT, 'files')

def main():
    for root, directories, files in os.walk(FILES_ROOT):
        for f in files:
            activate_file(relpath(join(root, f), FILES_ROOT))

def activate_file(rel_file):
    directory = dirname(rel_file)
    mkdirp(join(HOME, directory))
    copyfile(join(FILES_ROOT, rel_file), join(HOME, rel_file))

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
