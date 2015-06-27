# Helper to setup small redirects to versioned copies of config:
# Assuming a set of versioned skel.foo files, this will create copy skel.foo to
# ~/.foo
#
# Most skeleton files will only 'import' a versioned copy from the correct
# directory.
import os
import shutil

files = ['.gitconfig', '.hgrc', '.vimrc']
# Replace this in skeletons by dotfiles repository path.
magic_token = '__DOTFILESDIR__'

destination = os.path.expanduser('~')
source = os.path.dirname(os.path.realpath(__file__))

for f in files:
    full = os.path.join(destination, f)
    if os.path.exists(full):
        raise RuntimeError("%s already exists, can't create skeleton there." % full)

for f in files:
    full = os.path.join(source, 'skel' + f)
    assert os.path.exists(full), "Skeleton %s should exist" % full

for f in files:
    full_source = os.path.join(source, 'skel' + f)
    full_destination = os.path.join(destination, f)
    contents = ''
    with open(full_source, 'r') as handle:
        contents = handle.read()
    contents = contents.replace(magic_token, source)
    with open(full_destination, 'w') as handle:
        handle.write(contents)
    shutil.copymode(full_source, full_destination)
