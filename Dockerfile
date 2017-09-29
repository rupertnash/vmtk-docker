FROM rupertnash/ubuntu-desktop-lxde-vnc:1.0.0
MAINTAINER Rupert Nash <r.nash@epcc.ed.ac.uk>

# Dependencies
RUN apt-get update \
    && apt-get install -y software-properties-common \
    && apt-get update \
    && apt-get install -y \
    cmake \
    git \
    build-essential \
    python-dev \
    python-tk \
    python-vtk6 \
    libvtk6-dev \
    insighttoolkit4-python \
    libinsighttoolkit4-dev

# Get and build VMTK
WORKDIR /vmtk
RUN curl -sL https://github.com/vmtk/vmtk/archive/v1.3.2.tar.gz > v1.3.2.tar.gz \
    && tar -xzf v1.3.2.tar.gz \
    && mkdir build && cd build \
    && cmake -Wno-dev \
    -DUSE_SYSTEM_ITK=ON \
    -DUSE_SYSTEM_VTK=ON \
    -DVMTK_USE_SUPERBUILD=OFF \
    -DVMTK_USE_VTK7=OFF \
    -DVTK_VMTK_BUILD_STREAMTRACER=OFF \
    -DVTK_VMTK_BUILD_TETGEN=OFF \
    -DVTK_VMTK_WRAP_JAVA=OFF \
    -DVTK_VMTK_WRAP_PYTHON=ON \
    -DVMTK_USE_RENDERING=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DVMTK_MODULE_INSTALL_LIB_DIR=/usr/local/lib/python2.7/dist-packages/vmtk \
    -DVTK_VMTK_MODULE_INSTALL_LIB_DIR=/usr/local/lib/python2.7/dist-packages/vmtk \
    -DVMTK_SCRIPTS_INSTALL_LIB_DIR=/usr/local/lib/python2.7/dist-packages/vmtk \
    -DPYPES_MODULE_INSTALL_LIB_DIR=/usr/local/lib/python2.7/dist-packages/vmtk \
    ../vmtk-1.3.2 \
    && make -j 2 install \
    && ldconfig 
