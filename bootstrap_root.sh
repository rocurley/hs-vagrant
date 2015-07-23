#!/usr/bin/env bash

echo "Apt-get dependencies"
apt-get update
apt-get install -y libgmp-dev zlib1g-dev python-dev python-setuptools libtinfo-dev libzmq3-dev libcairo2-dev libpango1.0-dev libmagic-dev libblas-dev liblapack-dev git daemontools ctags libcurl4-gnutls-dev


echo "Installing Ipython"
easy_install -U pip
pip install -U 'ipython[all]'

mkdir workspace
cd workspace

echo "Downloading: GHC 7.10.1"
curl -OLs https://www.haskell.org/ghc/dist/7.10.1/ghc-7.10.1-x86_64-unknown-linux-deb7.tar.xz
echo "Installing: GHC 7.10.1"
tar -xf ghc-7.10.1-x86_64-unknown-linux-deb7.tar.xz
cd ghc-7.10.1
./configure
make install
echo "Installed: GHC 7.10.1"
cd ..

echo "Downloading: Cabal 1.22.3.0"
curl -OLs https://www.haskell.org/cabal/release/cabal-1.22.3.0/Cabal-1.22.3.0.tar.gz
echo "Installing: Cabal 1.22.3.0"
tar -xf Cabal-1.22.3.0.tar.gz
cd Cabal-1.22.3.0
ghc -threaded --make Setup
./Setup configure
./Setup build
./Setup install
echo "Installed: Cabal 1.22.3.0"
cd ..

echo "Downloading: Cabal-Install 1.22.4.0"
curl -OLs https://www.haskell.org/cabal/release/cabal-install-1.22.4.0/cabal-install-1.22.4.0.tar.gz
echo "Installing: Cabal-Install 1.22.4.0"
tar -xf cabal-install-1.22.4.0.tar.gz
cd cabal-install-1.22.4.0
./bootstrap.sh
cp /root/.cabal/bin/cabal /usr/local/bin/cabal
echo "Installed: Cabal-Install 1.22.4.0"
echo "Switching to user: vagrant"
cd ..
rm -rf workspace