# Multi-stage build: full OpenCog stack (cogutil + atomspace + cogserver)
# on Ubuntu 24.04 with GCC 14.
#
# Build:
#   docker build -t opencog-demo .
#
# Run:
#   docker run -it --rm -p 17001:17001 -p 18080:18080 opencog-demo

# ── Stage 1: Build ──
FROM ubuntu:26.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive
ENV CC=gcc-14 CXX=g++-14

RUN apt-get update -qq && apt-get install -y -qq \
    git cmake build-essential g++-14 \
    libboost-all-dev libgsl-dev libzmq3-dev \
    libssl-dev libcurl4-openssl-dev \
    nlohmann-json3-dev \
    liblua5.3-dev lua5.3 \
    guile-3.0-dev guile-3.0 \
    libsqlite3-dev libgoogle-perftools-dev \
    cxxtest && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /build

# Build cogutil
RUN git clone --depth 1 https://github.com/opencog/cogutil.git && \
    mkdir cogutil/build && cd cogutil/build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make -j$(nproc) && make install

# Build atomspace
RUN git clone --depth 1 https://github.com/opencog/atomspace.git && \
    mkdir atomspace/build && cd atomspace/build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release \
        -DGUILE_INCLUDE_DIRS=/usr/include/guile/3.0 \
        -DGUILE_LIBRARIES=/usr/lib/x86_64-linux-gnu/libguile-3.0.so && \
    make -j$(nproc) && make install

# Build cogserver
RUN git clone --depth 1 https://github.com/opencog/cogserver.git && \
    mkdir cogserver/build && cd cogserver/build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make -j$(nproc) && make install

# Install visualizer
RUN git clone --depth 1 https://github.com/opencog/atomspace-viz.git && \
    mkdir -p /usr/local/share/cogserver/visualizer && \
    cp -r atomspace-viz/* /usr/local/share/cogserver/visualizer/

# ── Stage 2: Runtime ──
FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

# Runtime dependencies only
RUN apt-get update -qq && apt-get install -y -qq \
    libboost-system1.83.1 libboost-filesystem1.83.1 \
    libboost-thread1.83.1 libboost-program-options1.83.1 \
    libboost-regex1.83.1 libboost-serialization1.83.1 \
    libgsl27 libzmq5 libssl3 libcurl4 \
    liblua5.3-0 guile-3.0 libsqlite3-0 \
    libgoogle-perftools4 ncurses-bin netcat-openbsd curl && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/ /usr/local/
COPY --from=builder /build/atomspace-viz/* /usr/local/share/cogserver/visualizer/

# Repo assets
COPY docker-healthcheck.sh /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/
COPY test-integration.sh /usr/local/bin/
COPY init-cogserver.scm /usr/local/share/opencog/
COPY prelude.scm /usr/local/share/opencog/
COPY benchmark.scm /usr/local/share/opencog/
COPY demo /usr/local/share/opencog/demo
COPY scripts /usr/local/share/opencog/scripts

RUN chmod +x /usr/local/bin/docker-healthcheck.sh \
             /usr/local/bin/docker-entrypoint.sh \
             /usr/local/bin/test-integration.sh

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD /usr/local/bin/docker-healthcheck.sh

EXPOSE 17001 18080 18888

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["cogserver", "-p", "17001", "-w", "18080", "-m", "18888"]
