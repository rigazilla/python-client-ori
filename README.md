# Python Hotrod Client #

Python client for Infinispan over the Hotrod protocol, based on the C++ client core.

## Build ##
Build prerequisites:

* Linux (Centos 7, Fedora 29)
* Bash 4.4.23
* g++ 8.3.1
* Swig 3.0.12
* Python 2.7

### Steps ###
1. Place the infinispan-hotrod-cpp\*.rpm package in the `dl` folder. Two options for this:
    1. Prebuilt rpm for Centos 7 can be downloaded from the [Infinispan Clients](https://infinispan.org/hotrod-clients/) page.
    2. For all the other distros best is to [compile](#cppbuild) it from source.
2. In the project root directory run:
    ./scripts/build.sh

## Use ##
The `runtime` folder everything to run a python shell and import the Infinispan package, this way:

    LD_LIBRARY_PATH=./usr/lib python

This is an example of code:

    import Infinispan
    conf=Infinispan.Configuration()
    conf.addServer("localhost",11222)
    conf.setProtocol("2.4")
    manager=Infinispan.RemoteCacheManager(conf)
    manager.start()
    key=Infinispan.UCharVector()
    key.push_back(56)
    value=Infinispan.UCharVector()
    value.push_back(8)
    cache=Infinispan.RemoteCache(manager)
    cache.put(key,value)
    res=cache.get(key)
    print res.pop()
    manager.stop()

<a name="cppbuild"></a>
### Build the C++ Library
This is a short list for building the needed C++ library for the client:

    git clone git@github.com:infinispan/cpp-client.git
    cd cpp-client
    mkdir build
    cd build
    cmake ..
    cmake --build . --target hotrod
    cmake --build . --target hotrod-static
    cmake --build . --target docs
    cpack -G RPM
