#!/usr/bin/env python3

import pandas as pd
import sys


class SymbioticaTools:
    """Tool chain for symbiotica_py."""

    def __init__(self, symb_tools):
        self.symb_tools = symb_tools
        self.path = symb_tools.path
        self.df = None

    def _load_table(self):
        """Load tsv file to parse for plotting."""
        try:
            df = pd.read_csv(self.path, sep="\t")
            self.df = df
        except Exception as e:
            sys.exit(f"Failed to load TSV: {e}")

    def _collapse_duplicates(self):
        """Collapses duplicate matches."""
        if self.df is None:
            self._load_table()
