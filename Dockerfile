FROM ziyibear/ubuntu-opencv-dlib-torch

MAINTAINER zi-yi wang <m0724001@gm.nuu.edu.tw>

RUN pip2 install wheel Cpython

# Fetch & install openface
RUN git clone https://github.com/cmusatyalab/openface.git /root/openface && \
  cd /root/openface && git submodule init && git submodule update

RUN cd /root/openface && \
    ./models/get-models.sh && \
    pip install -r requirements.txt && \
    python setup.py install && \
    pip install -r demos/web/requirements.txt && \
    pip install -r training/requirements.txt

RUN cd /root/openface && \
  ./data/download-lfw-subset.sh

# Expose the ports that are used by web demo
EXPOSE 8000 9000

CMD /bin/bash -l -c '/root/openface/demos/web/start-servers.sh'
