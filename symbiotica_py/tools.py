#!/usr/bin/env python3

import pandas as pd

class SymbioticaTools:
    """Tool chain for symbiotica_py."""

    def __init__(self, symb_tools):
        self.symb_tools = symb_tools
        self.path = symb_tools.path

    def _collapse_duplicates(self):
        """Collapses duplicate matches."""