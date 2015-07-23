#!/usr/bin/env bash

echo "Switched to user: `whoami`"
cabal update
cd ~
echo 'library-profiling: True' >> .cabal/config
echo 'documentation: True' >> .cabal/config

echo "Downloading: haskell-vim-now"
mkdir hs-vim-now
cd hs-vim-now
cabal sandbox init
git clone https://github.com/kazu-yamamoto/ghc-mod.git
sed -i 's/\(Version:\s*\)0/\15.2.1.3/' ./ghc-mod/ghc-mod.cabal
echo "Installing: haskell-vim-now"
echo PATH=\"$HOME/hs-vim-now/.cabal-sandbox/bin/:\$PATH\" >> ~/.profile
cabal install happy
cabal install hoogle
cabal install --disable-profiling ./ghc-mod
curl -OLs https://raw.githubusercontent.com/begriffs/haskell-vim-now/master/install.sh
./install.sh
echo "Installed: haskell-vim-now"
cd ~
echo "Downloading: IHaskell"
git clone https://github.com/gibiansky/IHaskell.git
echo "Installing: IHaskell"
cd IHaskell
cabal sandbox init
cabal sandbox add-source ihaskell-display/* ghc-parser ipython-kernel
cabal install happy alex cpphs gtk2hs-buildtools
./build.sh all
./.cabal-sandbox/bin/ihaskell install
echo "Installed: IHaskell"
cd ~
mkdir notebooks
echo '#!/usr/bin/env bash' > notebooks/run
echo 'ipython notebook --ip=* --port=8888 --no-browser' >> notebooks/run
chmod 700 notebooks/run
