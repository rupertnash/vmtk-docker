# Taking as base image a Ubuntu Desktop container with web-based noVNC connection enabled
FROM dorowu/ubuntu-desktop-lxde-vnc
MAINTAINER Rupert Nash (r.nash@epcc.ed.ac.uk)


# Install conda
# ADD https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh /tmp/conda.sh

RUN curl -s https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh > /tmp/conda.sh && \
    bash /tmp/conda.sh -b -p /opt/conda && \
    rm /tmp/conda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /root/.bashrc && \
    echo "conda activate base" >> /root/.bashrc && \
    env PATH=/opt/conda/bin:$PATH conda install -y -q -c vmtk anaconda-client vtk itk vmtk

