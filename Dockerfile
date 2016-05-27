# Taking as base image a Ubuntu Desktop container with web-based noVNC connection enabled
FROM dorowu/ubuntu-desktop-lxde-vnc
MAINTAINER Rupert Nash (rupert.nash@ed.ac.uk)

##
# Dependencies
##
# OpenMPI in Universe
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get update

WORKDIR /tmp
ADD http://s3.amazonaws.com/vmtk-installers/1.3/vmtk-1.3.linux-x86_64.egg /tmp/
RUN easy_install vmtk-1.3.linux-x86_64.egg

ENV VMTKHOME=/usr/local/lib/python2.7/dist-packages/vmtk-1.3.linux-x86_64.egg
# These are NOT concatenated as the setting of VMTKHOME isn't visible until the end of the command.
ENV PATH=$VMTKHOME/vmtk/bin:$PATH \
    LD_LIBRARY_PATH=$VMTKHOME/vmtk/lib:$LD_LIBRARY_PATH \
    PYTHONPATH=$VMTKHOME/vmtk:$PYTHONPATH
