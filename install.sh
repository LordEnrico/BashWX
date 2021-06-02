#!/bin/bash
sudo apt-get install flite alsa-utils gcc make pkg-config automake libtool libasound2-dev -y
git clone https://github.com/MycroftAI/mimic1.git
cd mimic1
./dependencies.sh --prefix="/usr/local"
./autogen.sh
./configure --prefix="/usr/local"
make
make check
cd ..
wget "https://www.filehosting.org/file/details/947019/rms.flitevox"
mv rms.flitevox mimic1/rms.flitevox
echo "Done!"
