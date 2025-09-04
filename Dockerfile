# This Dockerfile was created by Microsoft CoPilot.
FROM nvidia/cuda:11.4.3-cudnn8-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

# Add deadsnakes PPA for Python 3.10
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update && \
    apt-get install -y \
        python3.10 \
        python3.10-dev \
        python3.10-distutils \
        python3.10-venv \
        wget \
        build-essential \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        libxext6 \
        libgl1 && \
    rm -rf /var/lib/apt/lists/*

# Install pip for Python 3.10
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3.10 get-pip.py && \
    rm get-pip.py

# Set Python 3.10 as default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Install Python packages
RUN pip install --no-cache-dir \
    "numpy<2" \
    torch==1.12.1+cu113 \
    torchvision==0.13.1+cu113 \
    opencv-python \
    tqdm \
    tensorboard \
    tensorboardX \
    scikit-image \
    medpy \
    pillow \
    scipy \
    lmdb \
    matplotlib \
    pandas \
    pyyaml \
    --extra-index-url https://download.pytorch.org/whl/cu113

WORKDIR /workspace
CMD ["python3"]

