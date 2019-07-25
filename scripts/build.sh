#!/bin/bash -x

#HOTROD_CPP_RPM_URL=${HOTROD_CPP_RPM_URL:-https://downloads.jboss.org/infinispan/HotRodCPP/8.3.1.Final/infinispan-hotrod-cpp-8.3.1.Final-RHEL-x86_64.rpm}
#HOTROD_CPP_RPM_FILENAME=$(basename "$HOTROD_CPP_RPM_URL")
pushd dl
#wget -N $HOTROD_CPP_RPM_URL 
RPM_FILENAME=(*.rpm)
popd

pushd runtime
rpm2cpio ../dl/$RPM_FILENAME  | cpio -idvm 
swig -python -c++ -outcurrentdir -I../include/ ../swig/hotswig.i

/usr/bin/c++ -fPIC   -shared  hotswig_wrap.cxx ../src/hotrod.cpp  -I../include/ -I/usr/include/python2.7 -Iusr/include/ -L/home/rigazilla/git/python-client/runtime/usr/lib -Wl,-rpath,/home/rigazilla/git/python-client/runtime/usr/lib -lhotrod -o _Infinispan.so 
popd
