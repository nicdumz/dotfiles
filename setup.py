# Helper to setup small redirects to versioned copies of config.
import os

files = ['.bash_profile', '.gitconfig', '.hgrc', '.tmux.conf', '.vimrc']

destination = os.path.expanduser('~')
source = os.path.dirname(os.path.realpath(__file__))

for f in files:
  full = os.path.join(source, f)
  assert os.path.exists(full), "File %s should exist" % full

todo = []
for f in files:
  full = os.path.join(destination, f)
  if os.path.exists(full):
    try:
      path =  os.readlink(full)
      if path == os.path.join(source, f):
        continue
    except:
      raise RuntimeError("%s already exist and is not a link" % full)
    os.unlink(full)
  todo.append(f)

for f in todo:
  full_source = os.path.join(source, f)
  full_destination = os.path.join(destination, f)
  os.symlink(full_source, full_destination)
