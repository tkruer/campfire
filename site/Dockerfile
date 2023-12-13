FROM ubuntu:20.04

ARG DEFAULT_TZ=America/Los_Angeles
ENV DEFAULT_TZ=$DEFAULT_TZ

RUN apt-get update \
   && DEBIAN_FRONTEND=noninteractive TZ=$DEFAULT_TZ apt-get install -y \
   tzdata \
   vim \
   nano \
   sudo \
   curl \
   wget \
   git && \
   rm -rf /var/lib/apt/lists/*

# Download the latest version of minicoda py3.8 for linux x86/x64.
RUN curl -fsSL https://repo.anaconda.com/miniconda/$( wget -O - https://repo.anaconda.com/miniconda/ 2>/dev/null | grep -o 'Miniconda3-py38_[^"]*-Linux-x86_64.sh' | head -n 1) > /tmp/miniconda.sh \
	&& chmod +x /tmp/miniconda.sh \
	&& /tmp/miniconda.sh -b -p /opt/conda

ENV PATH=/opt/conda/bin:$PATH
RUN conda init

RUN pip install \
	jupyterlab \
	ipykernel \
	matplotlib \
	ipywidgets

ARG AUTH_KEY=mut_67a47e3e8aeb45f6b12063ba19b042d7
ENV AUTH_KEY=$AUTH_KEY

RUN curl https://get.modular.com | sh - && \
    modular auth $AUTH_KEY 
RUN modular install mojo

ARG MODULAR_HOME="/root/.modular"
ENV MODULAR_HOME=$MODULAR_HOME
ENV PATH="$PATH:$MODULAR_HOME/pkg/packages.modular.com_mojo/bin"

# Change permissions to allow for Apptainer/Singularity containers
RUN chmod -R a+rwX /root

WORKDIR /
# Step 3: Copy your application files to the container
COPY . /

EXPOSE 8000

CMD ["mojo" "test.mojo"]
