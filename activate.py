#!/usr/bin/env python
from __future__ import with_statement

import errno

from os import makedirs, remove
from os.path import abspath, dirname, exists, expanduser, isdir, isfile, join, split
from shutil import copy, copytree, rmtree

PROJECT_ROOT = abspath(dirname(__file__))
LIST_FILE = join(PROJECT_ROOT, 'LIST')
HOME_DIRECTORY = expanduser('~')
FILES_ROOT = join(PROJECT_ROOT, 'files')

def activate_main():
    copy_all_files()

def copy_all_files():
    files = file_list()
    copy_files(files)

def file_list():
    with open(LIST_FILE) as f:
        return [line.strip() for line in f.readlines() if line and not line.startswith('#')]

def copy_files(files):
    for file in files:
        copy_file(file)

def copy_file(file):
    home_file, local_file = full_paths(file)
    if exists(local_file):
        my_copy(local_file, home_file)

def full_paths(file):
    return join(HOME_DIRECTORY, file), join(FILES_ROOT, file)

def my_copy(src, dst):
    mkdir_p(dirname(dst))
    if isdir(dst):
        rmtree(dst)

    try:
        copytree(src, dst)
    except OSError as e:
        if e.errno == errno.ENOTDIR:
            copy(src, dst)
        else:
            raise

def mkdir_p(path):
    try:
        makedirs(path)
    except OSError as e:
        if e.errno == errno.EEXIST:
            pass
        else:
            raise



if __name__ == '__main__':
    activate_main()
