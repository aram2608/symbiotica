#!/usr/bin/env python3

from pathlib import Path

import typer
from typing_extensions import Annotated

from symbiotica_py.tools import SymbioticaTools
from symbiotica_py.plotter import SymbioticaPlotter

app = typer.Typer()


@app.command()
def main(
    input: Annotated[Path, typer.Argument()],
    output: Annotated[str, typer.Option()] = "summary_plot.png",
    verbose: Annotated[bool, typer.Option()] = False,
    plot: Annotated[bool, typer.Option()] = False,
):
    symb = SymbioticaTools(input)
    plotter = SymbioticaPlotter(symb)

    if verbose:
        plotter.summarize()

    if plot:
        plotter.plot_summary(outpath=output)


if __name__ == "__main__":
    main()
