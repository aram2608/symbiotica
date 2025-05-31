import argparse
from symbiotica_py.tools import SymbioticaTools
from symbiotica_py.plotter import SymbioticaPlotter

def main():
    parser = argparse.ArgumentParser(description="Symbiotica Plotting Tool")
    parser.add_argument('--input', required=True, help="Path to symbiotica_matches.tsv")
    parser.add_argument('--plot', help="Path to save bar plot (PNG)")
    parser.add_argument('--verbose', action='store_true', help="Print summary")

    args = parser.parse_args()

    symb = SymbioticaTools(args.input)
    plotter = SymbioticaPlotter(symb)

    if args.verbose:
        plotter.summarize()

    if args.plot:
        plotter.plot_summary(args.plot)

if __name__ == '__main__':
    main()
