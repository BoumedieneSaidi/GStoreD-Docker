# GStoreD-Docker
A docker container for the distributed RDF database GStoreD
# First: GStoreD installation without docker
1-Créer une instance à base de l’image Ubuntu 20.04

2- Configuration du proxy:

sudo vim sudo vim /etc/apt/apt.conf.d/proxy et ajouter les lignes suivantes.

Acquire::http::Proxy "http://cache.univ-poitiers.fr:3128";Acquire::https::Proxy "http://cache.univ-poitiers.fr:3128";Acquire::ftp::Proxy "ftp://cache.univ-poitiers.fr:3128";

Remarque: si le WGET ne marche pas essaye les deux commandes suivate:

export http_proxy=http://cache.univ-poitiers.fr:3128

export https_proxy=http://cache.univ-poitiers.fr:3128

3- Installation du MPICH2 3.0.4:

sudo apt-get update

sudo apt-get install build-essential

sudo apt-get install gfortran

wget http://www.mpich.org/static/downloads/3.0.4/mpich-3.0.4.tar.gz

tar xfz mpich-3.0.4.tar.gz

cd mpich-3.0.4

export FFLAGS="-w -fallow-argument-mismatch -O2" //You need this in order to successfully config

./configure --prefix=/usr/local/

sudo make // Génére une erreur (une diff multiple d’une constante => pour résoudre le bug, j’ai enlevé la constante qui est dupliqué dans les deux fichiers

sudo make install

4- Installation du Readline

sudo apt-get install libreadline-dev

2- Clone the repo:

git clone https://github.com/bnu05pp/gStoreD.git

make //I got a compilation error, a variable  with “const” declaration who should be with constexpr declaration

sudo apt-get install default-jdk // install java

Compilation error I am gonna try this: I added -no-pie to compilations flags in makefile (vim makefile)

sudo vim /etc/hosts (in every worker) add folowing line

10.16.14.169 gstored-master

J’ai crée 4 workers

5- Remarque trés importante: le meme dossier d’installation avec la base de données et la requête doit exister au niveau des machines.

docker run -it --network mynetwork --name master-containdzer -v /home/boumi/gstored_workload:/app/gstored_workload gstored /bin/bash
