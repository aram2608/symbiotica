#!/usr/bin/env python3

import pandas as pd
import matplotlib.pyplot as plt
import sys

class SymbioticaPlotter:
    """A class for plotting abundance of genes found from symbiotica."""

    def __init__(self, symb_tools):
        """Initialize plotting paramters."""
        self.symb_tools = symb_tools
        self.path = symb_tools.path
        self.df = None
        self.summary = None

    def _load_table(self):
        """Load tsv file to parse for plotting."""
        try:
            df = pd.read_csv(self.path, sep='\t')
            self.df = df
        except Exception as e:
            sys.exit(f"Failed to load TSV: {e}")

    def summarize(self):
        """Summarizes symbiotica tsv outputs."""
        if self.df is None:
            self._load_table()
        self.summary = self.df['match'].value_counts()
        return self.summary
    
    def plot_summary(self, outpath="summary_plot.png"):
        """Plots the summary of matches genes."""
        if self.summary is None:
            self._summarize()
            self.summary.plot(kind='bar', title='Gene Match Counts')
            plt.xlabel("Gene")
            plt.ylabel("Count")
            plt.tight_layout()
            plt.savefig(outpath)
            print(f"Plot saved to: {outpath}")