# symbiotica

# Overview

---

Symbiotica is a small tool that finds symbiotic genes from rhizobia species in Genbank and GFF files. The goal of this tool
is to provide a lightweight option for fast genome parsing of crucial genes involved in symbiotic establishment.

Currently the saved files do not provide the full name of the gene but it is able to extract the tag used for matching which often contains the full gene name.

This is more of a learning project than a real tool so any advice is welcome!

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

Or, run the following,

```
perl Makefile.PL
make
make install
```

Or finally, you can run the following.

```
docker build -t symbiotica:latest . -f DockerFile
```

---

# Example Usage

```
perl symbiotica/bin/symbiotica.pl \      
--input data/genomic.gbff \
--format genbank \
--outdir examples
```

If using Docker usage changes slightly

```
# You need to mount the local directories to save outputs
docker run --rm -it \
  -v "$PWD/data:/app/data" \
  -v "$PWD/examples:/app/examples" \
  symbiotica:latest \
  --input data/genomic.gbff \
  --format genbank \
  --outdir examples
```