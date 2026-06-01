# Build the full OpenCog stack (cogutil + atomspace + cogserver)
# on Ubuntu 24.04 with GCC 14.
#
# Build:
#   docker build -t opencog-demo .
#
# Run:
#   docker run -it --rm -p 17001:17001 -p 18080:18080 opencog-demo

FROM ubuntu:24.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive
ENV CC=gcc-14 CXX=g++-14

# Install build dependencies
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

# Copy demo scripts
COPY demo /usr/local/share/opencog/demo
COPY docs /usr/local/share/opencog/docs

EXPOSE 17001 18080 18888

CMD ["cogserver", "-p", "17001", "-w", "18080", "-m", "18888"]
