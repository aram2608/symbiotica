# symbiotica

# Overview

---

Symbiotica is a small tool that finds symbiotic genes from rhizobia species in Genbank and GFF files. The goal of this tool
is to provide a lightweight option for fast genome parsing of crucial genes involved in symbiotic establishment.

Currently the saved files do not provide the full name of the gene but it is able to extract the tag used for matching which
often contains the full gene name.

The tool is written in Perl so use at your own discretion.

 ---

# Installation

---

Symbiotica can be downloaded by cloning this repo.

```
git clone https://github.com/aram2608/symbiotica.git
```

There is also a lightweight installation Bash script that can be run using.

```
./installer.sh
```

As mentioned it is extremely lightweight so again, use at your own discretion.

---

# Example Usage

```
perl bin/symbiotica.pl \      
--input data/genomic.gbff \
--format genbank \
--outdir examples
```