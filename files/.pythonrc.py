# -*- coding: utf-8 -*-

try:
    import rlcompleter2
    rlcompleter2.setup()
    del rlcompleter2
except ImportError:
    import readline
    import rlcompleter
    readline.parse_and_bind("tab: complete")
