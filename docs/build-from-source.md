# Building from Source

This repository includes a full build of the OpenCog Classic stack.
Below are the steps to reproduce the build on a fresh Ubuntu 24.04
system. Building takes roughly **60–90 minutes** on a 4-core machine.

## Prerequisites

```bash
sudo apt-get update && sudo apt-get install -y \
    git cmake build-essential g++-14 \
    libboost-all-dev libgsl-dev libzmq3-dev \
    libssl-dev libcurl4-openssl-dev \
    openjdk-11-jdk nlohmann-json3-dev \
    liblua5.3-dev lua5.3 \
    guile-3.0-dev guile-3.0 \
    libsqlite3-dev libpq-dev postgresql-client \
    libgoogle-perftools-dev

# Use GCC-14
export CC=gcc-14 CXX=g++-14
```

## Build Order

The stack must be built in dependency order:

### 1. cogutil

```bash
git clone https://github.com/opencog/cogutil.git
cd cogutil
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
sudo make install
```

### 2. atomspace

```bash
git clone https://github.com/opencog/atomspace.git
cd atomspace
git checkout master
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release \
         -DCMAKE_CXX_FLAGS="-DHAVE_GUILE" \
         -DGUILE_INCLUDE_DIRS=/usr/include/guile/3.0 \
         -DGUILE_LIBRARIES=/usr/lib/x86_64-linux-gnu/libguile-3.0.so
make -j$(nproc)
sudo make install
```

### 3. atomspace-storage (optional, for persistence)

```bash
git clone https://github.com/opencog/atomspace-storage.git
cd atomspace-storage
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
sudo make install
```

### 4. cogserver

```bash
git clone https://github.com/opencog/cogserver.git
cd cogserver
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
sudo make install
```

### 5. atomspace-viz (visualizer)

```bash
# Clone the visualizer repository
git clone https://github.com/opencog/atomspace-viz.git

# Copy static files to CogServer's web root
sudo cp -r atomspace-viz/* /usr/local/share/cogserver/visualizer/
```

## Verification

```bash
# Start the CogServer
cogserver -p 17001 -w 18080 -m 18888 &

# Test the REPL
echo '(use-modules (opencog)) (ConceptNode "test") (cog-count-atoms)' | \
    nc localhost 17001

# Open the web UI
# → http://localhost:18080/visualizer/
```

## Build Flags Reference

| Flag | Purpose |
|---|---|
| `-DHAVE_GUILE` | Enable Guile Scheme bindings |
| `-DWITH_PYTHON` | Enable Python bindings |
| `-DENABLE_STORAGE` | Include storage backends (RocksDB, PostgreSQL) |
| `-DCMAKE_BUILD_TYPE=Release` | Optimized build |
| `-DCMAKE_BUILD_TYPE=Debug` | Debug symbols, assertion checks |
