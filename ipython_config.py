"""IPython config file."""

# get_config is injected into the global namespace whilst
# config files are loaded
c = get_config()

# Autoreload modules
# See https://github.com/ipython/ipython/issues/461
# See http://stackoverflow.com/questions/5364050/reloading-submodules-in-ipython
# See https://support.enthought.com/hc/en-us/articles/204469240
c.InteractiveShellApp.extensions = ['autoreload']
c.InteractiveShellApp.exec_lines = ['%autoreload 2']
