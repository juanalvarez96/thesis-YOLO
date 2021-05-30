
#Change this base image acccording to your convenience
# for tensorflow  v1.X
#FROM nvcr.io/nvidia/tensorflow:20.09-tf1-py3

#for tensorflow v2.X
#FROM nvcr.io/nvidia/tensorflow:20.09-tf2-py3

#for pytorch 
FROM nvcr.io/nvidia/pytorch:20.10-py3

ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG u_id
ARG g_id
ARG username



RUN set -x && \
    apt update && \
    apt install -y --no-install-recommends \
        git\
        wget\
        build-essential \
        apt-utils \
        ca-certificates \
        curl \
        software-properties-common \
        libopencv-dev \ 
        python3-dev \
        python3-pip \ 
        python3-setuptools \
        cmake \
        swig \
        wget \
        unzip 

#RUN pip install moviepy
		


ENV FORCE_CUDA="1"
ENV CUDA_VISIBLE_DEVICES="0"


COPY misc/requirements.txt /tmp/
RUN pip3 install pip --upgrade
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*
#Install pytorch for CUDA 11
RUN pip install torch==1.8.1+cu111 torchvision==0.9.1+cu111 torchaudio==0.8.1 -f https://download.pytorch.org/whl/torch_stable.html

RUN groupadd --gid ${g_id} ${username}
RUN useradd --uid ${u_id} --gid ${g_id} --shell /bin/bash --create-home ${username}
USER ${username}
RUN chown -R ${u_id}:${g_id} /home/${username}
RUN chmod -R  755 /home/${username}

RUN git clone https://github.com/pjreddie/darknet.git
RUN cd darknet && make
#########################################


RUN mkdir /home/${username}/output

# RUN INFERENCE FOR DAVIS
CMD sh /home/juan.vallado/src/setup.sh
