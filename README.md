# [![BitcoinZDEX](http://www.weby.si/test/bitcoinz/dex-logo.png)](https://getbtcz.com) BitcoinZ DEX
BitcoinZ DEX Desktop

[![Discord](https://img.shields.io/discord/302123079818149888.svg?style=for-the-badge&logo=discord)](https://discord.gg/K59mxyf)
[![Website](https://img.shields.io/website?down_message=offline&style=for-the-badge&up_message=online&url=https%3A%2F%2Fgetbtcz.com%2F)](https://getbtcz.com/) <br>
[![gitstars](https://img.shields.io/github/stars/btcz/bitcoinz-dex-desktop?style=social)](https://github.com/btcz/bitcoinz-dex-desktop/stargazers)
[![twitter](https://img.shields.io/twitter/follow/BTCZOfficial?style=social)](https://twitter.com/BTCZOfficial)


## Useful links

- :link: [BitcoinZ Website](https://getbtcz.com/)
- :speech_balloon: [BitcoinZ DEX Discord](https://discord.gg/K59mxyf)
- :hammer_and_wrench: [BitcoinZ DEX Development Boards](https://github.com/btcz/bitcoinz-dex-desktop/projects)

## What is BitcoinZ DEX?

BitcoinZ DEX is a secure wallet and non-custodial decentralized exchange rolled into one application. Store your coins,
trade peer-to-peer with minimal fees and never give up control over your digital assets.

## On which platforms can I use BitcoinZ DEX Desktop?

BitcoinZ DEX Desktop has been tested on the following platforms:

- Windows 10
- Linux (Ubuntu 16.04+)
- macOS (10.14 - 11.0)

## Get Started

You can [download](https://github.com/btcz/bitcoinz-dex-desktop/releases) the pre-built <b>beta</b> binaries on
our [GitHub release page](https://github.com/btcz/bitcoinz-dex-desktop/releases).

Please join our [Discord Server](https://discord.gg/K59mxyf) discussions around BitcoinZ DEX and general UI/UX
feedback.

## License

For details please refer to our [license](https://github.com/btcz/bitcoinz-dex-desktop/blob/master/LICENSE).

This is experimental alpha software - use at your own risk!

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## How do I build it ?

### Prerequisites
- Visual Studio 2019 (Windows) with [Desktop development with C++](https://docs.microsoft.com/en-gb/cpp/build/vscpp-step-0-installation?view=vs-2019)
- Clang C++ 17 compiler (clang-12 minimum)
  - on macOS Catalina/BigSpur, Apple Clang 12.0 is picked by default
- CMake 3.18 minimum [CMake Download](https://cmake.org/download)
- Python


### Install Requirements
#### Install Qt Windows
```
# Could also be pip3 depending of your python installation
pip install aqtinstall
python -m aqt install -O C:\/Qt 5.15.2 windows desktop win64_msvc2019_64 -b https://qt-mirror.dannhauer.de/ -m qtcharts qtwidgets debug_info qtwebview qtwebengine
```

#### Install Qt Linux
```
# Could also be pip3 depending of your python installation
pip install aqtinstall
python3 -m aqt install -O $HOME/Qt 5.15.2 linux desktop -b https://qt-mirror.dannhauer.de/ -m qtcharts qtwidgets debug_info qtwebengine qtwebview
```

#### Install Qt MacOS
```
# Could also be pip3 depending of your python installation
pip install aqtinstall
python3 -m aqt install -O $HOME/Qt 5.15.2 mac desktop -b https://qt-mirror.dannhauer.de/ -m qtcharts qtwidgets debug_info qtwebview qtwebengine
```

#### Install Windows requirements
In your PowerShell (as ADMIN) execute:

```
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
scoop install llvm --global
scoop install ninja --global
scoop install cmake --global
scoop install git --global
scoop install 7zip  --global
```
- Next, add a `QT_INSTALL_CMAKE_PATH` environment variable pointing to the msvc_2019x64 location <br>
  e.g.: `$Env:QT_INSTALL_CMAKE_PATH = "C:\Qt\5.15.0\msvc2019_64"`
- Then, also add a `QT_ROOT` environment variable pointing to the Qt root folder location <br>
  e.g.: `$Env:QT_ROOT = "C:\Qt"` <br> <br>
We advice to set it permanently through the environment variable manager on windows

#### Install macOS requirements
Ensure you have [brew](https://brew.sh/) and the macOS [command line tools](https://developer.apple.com/downloads) installed.

```
brew install autoconf \
             automake \
             libtool \
             pkgconfig \
             wget \
             ninja \
             gnu-sed \
             coreutils \
             gnu-getopt
```
Installing OSX SDK's (optional if you want to build for older systems):
```
git clone https://github.com/phracker/MacOSX-SDKs.git ~/MacOSX-SDKs
```
Installing wally:
```
git clone https://github.com/KomodoPlatform/libwally-core.git
cd libwally-core
./tools/autogen.sh
./configure --disable-shared
sudo make -j2 install
```

Add the following environment variables to your `~/.bashrc` or `~/.zshrc` profile:
- `QT_INSTALL_CMAKE_PATH` wqual to the CMake QT path
- `QT_ROOT` equal to the QT root installation folder

e.g.:
```
export QT_INSTALL_CMAKE_PATH=/Users/SatoshiNakamoto/Qt/5.15.2/clang_64/lib/cmake
export QT_ROOT=/Users/SatoshiNakamoto/Qt/5.15.2
```

#### Install Linux dependencies
In your terminal (shell,...) execute:

```
sudo apt-get install build-essential \
                    libgl1-mesa-dev \
                    ninja-build \
                    curl \
                    wget \
                    zstd \
                    software-properties-common \
                    lsb-release \
                    libpulse-dev \
                    libtool \
                    autoconf \
                    unzip \
                    libssl-dev \
                    libxkbcommon-x11-0 \
                    libxcb-icccm4 \
                    libxcb-image0 \
                    libxcb1-dev \
                    libxcb-keysyms1-dev \
                    libxcb-render-util0-dev \
                    libxcb-xinerama0 \
                    libgstreamer-plugins-base1.0-dev \
                    git -y

# get llvm
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 12

# set clang version
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-12 777
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-12 777
sudo apt-get update
# if you want to use libclang
#sudo apt-get install libc++abi-12-dev libc++-12-dev -y

# Add the following environment variables to your `~/.bashrc` or `~/.zshrc` profiles:

#if you want to use libclang
#export CXXFLAGS=-stdlib=libc++
#export LDFLAGS=-stdlib=libc++
export CXX=clang++-12
export CC=clang-12

git clone https://github.com/KomodoPlatform/libwally-core.git
cd libwally-core
./tools/autogen.sh
./configure --disable-shared
sudo make -j2 install
```

Add the following environment variables to your `~/.bashrc` or `~/.zshrc` profiles:
- `QT_INSTALL_CMAKE_PATH` equal to the CMake QT path
- `QT_ROOT` equal to the QT root installation folder

e.g.:
```
export QT_INSTALL_CMAKE_PATH=~/Qt/5.15.0/gcc/lib/cmake
export QT_ROOT=~/Qt/5.15.0
```

### Build BitcoinZ DEX Desktop
Please clone with submodules initialization: `git clone --recurse-submodules https://github.com/btcz/bitcoinz-dex-desktop.git`

Install Install vcpkg from within the `ci_tools_bitcoinz_dex` folder:
```
cd vcpkg-repo
# Windows
.\bootstrap-vcpkg.bat
# Linux / OSX
./bootstrap-vcpkg.sh
```

#### Instructions
In your shell command prompt (PowerShell/Zsh/Bash), from within root (bitcoinz-dex-desktop) folder, type:
```
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ../ # add -GNinja if you are on windows or if you want to use the ninja build system.
cmake --build . --config Release --target bitcoinz-dex-desktop
```

### Bundle BitcoinT DEX Desktop
#### OSX Requirements
On MacOS some extra variables in the environment are required to be able to bundle and sign the app:
```
export PATH=$HOME/Qt/5.15.2/clang_64/bin:$PATH

## Need to be your Developer ID Application if you want to fork/rebundle the app on OSX
## This also assume your certificates is already in your MacOS Keystore
export MAC_SIGN_IDENTITY="Developer ID Application: Satoshi Nakamoto (923YHAAKNY)"

## This is app deployment password that can be generate in your apple account profile
export APPLE_ATOMICDEX_PASSWORD="foo-bar-foo-bar"

## This is your apple id email
export APPLE_ID="satoshinakamoto@bitcoin.com"
```

```
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -GNinja ../
ninja install
```


## How can I create installer ?
Comming soon!
### Prerequisites
- Qt Installer Framework 4.1
- 7Zip
- WIX Toolset
