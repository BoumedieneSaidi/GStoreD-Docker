# Utilisez une image Ubuntu 20.04 en tant qu'image de base
FROM ubuntu:20.04

# Définir le répertoire de travail
WORKDIR /app

# Installation des dépendances
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    git \
    libreadline-dev \
    default-jdk \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install gfortran -y

# Installation de MPICH2
RUN wget http://www.mpich.org/static/downloads/3.0.4/mpich-3.0.4.tar.gz && \
    tar xfz mpich-3.0.4.tar.gz && \
    cd mpich-3.0.4 && \
    ./configure  && \
    make && \
    make install
# Cloner le repo gStoreD
RUN git clone https://github.com/bnu05pp/gStoreD.git /app/gStoreD && \
    cd /app/gStoreD \
    && sed -i 's/const double JUDGE_LIMIT = 0.5;/constexpr double JUDGE_LIMIT = 0.5;/' Database/Join.h \
    && sed -i 's/EXEFLAG = -O2 #-pg #-O2/EXEFLAG = -O2 -no-pie #-pg #-O2/' makefile \
    && sed -i 's/CFLAGS = -c -Wall -O2 #-pg #-O2/CFLAGS = -c -Wall -no-pie -O2 #-pg #-O2/' makefile \
    && make