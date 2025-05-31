#!/usr/bin/env bash

set -e

echo "Running installer via Makefile.PL..."

# Step 1: Perl sanity check
if ! command -v perl > /dev/null; then
  echo "Perl not found. Install Perl first."
  exit 1
fi

# Step 2: Run Installation
perl Makefile.PL
make
make install

echo "Symbiotica installed from source."
echo "➡️ Run it with: symbiotica.pl --input file --format genbank --outdir results/"
