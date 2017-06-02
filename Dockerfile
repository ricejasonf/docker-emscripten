FROM ricejasonf/cppdock
MAINTAINER Jason Rice

RUN apt-get update && apt-get -y install \
  python default-jre-headless curl tar xz-utils build-essential

WORKDIR /usr/local/src

# node
RUN curl -O https://nodejs.org/dist/v6.9.5/node-v6.9.5-linux-x64.tar.xz \
  && tar -xvf node-v6.9.5-linux-x64.tar.xz \
  && cp -r node-v6.9.5-linux-x64/* /usr/local/ \
  && rm -f node-v6.9.5-linux-x64.tar.xz \
  && rm -rf node-v6.9.5-linux-x64

ENV USE_EMSCRIPTEN_TAG=1.37.13

# clang w/emscripten
RUN git clone -b $USE_EMSCRIPTEN_TAG https://github.com/kripken/emscripten.git \
  && git clone -b $USE_EMSCRIPTEN_TAG https://github.com/kripken/emscripten-fastcomp.git \
  && cd emscripten-fastcomp/tools/ \
  && git clone -b $USE_EMSCRIPTEN_TAG https://github.com/kripken/emscripten-fastcomp-clang.git clang \
  && cd ../projects \
  && git clone https://github.com/llvm-mirror/libcxx.git \
  && git clone https://github.com/llvm-mirror/libcxxabi.git \
  && cd ../ && mkdir build && cd build \
  && cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DLLVM_TARGETS_TO_BUILD="X86;ARM;JSBackend" \
    -DLLVM_INCLUDE_EXAMPLES=OFF -DLLVM_INCLUDE_TESTS=OFF \
    -DCLANG_INCLUDE_EXAMPLES=OFF -DCLANG_INCLUDE_TESTS=OFF \
    .. \
  && make -j4 && make install \
  && cd /usr/local/src && rm -rf ./emscripten-fastcomp

RUN cd /usr/local/src/emscripten \
&& ./emcc -v \
&& ./embuilder.py build ALL

ENV CC=/usr/local/bin/clang \
    CXX=/usr/local/bin/clang++ \
    LD_LIBRARY_PATH=/usr/local/lib

RUN echo 'export EMCC_SKIP_SANITY_CHECK=1' >> /root/.bashrc
