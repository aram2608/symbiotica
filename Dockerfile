# Official Perl base, slim to keep it lightweight
FROM perl:5.38-slim

# System deps (build tools + libs BioPerl/XS modules tend to need)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    ca-certificates \
    git \
    pkg-config \
    libexpat1-dev \
    libgd-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libffi-dev \
    libssl-dev \
    libdb5.3 libdb5.3-dev \
    # python3 \
    # python3-pip \
&& rm -rf /var/lib/apt/lists/*

# Install cpanimus
RUN curl -L https://cpanmin.us | perl - App::cpanminus

# --notest speeds up builds; comment out if its bugging and you need to see logs
ENV PERL_CPANM_OPT="--notest --quiet --skip-satisfied"

# Working directory for the app
WORKDIR /app

# --- App code ---
COPY . .

# Install Perl deps
RUN cpanm --installdeps .

# Make sure the main script is executable
RUN chmod +x /app/symbiotica/bin/symbiotica.pl \
&& ln -sf /app/symbiotica/bin/symbiotica.pl /usr/local/bin/symbiotica

# Local module
ENV PERL5LIB=/app/symbiotica/lib

# Default working dir
WORKDIR /app

# Default command shows help
ENTRYPOINT ["symbiotica"]
CMD ["--help"]