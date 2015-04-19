# qp
qp is a helper that makes installation for q more standardized and easier to use.  The following are the features of qp
- configure/make/make install to standardize installation of q
- flags in configure with the optionality to set licenses as well as 64bit q
- preset environment variables QHOME and QLIB
	- QHOME is the global install directory
	- QLIB is the user install directory
- adds the qp namespace that allows easy loading and management of packages
- qpm package to facilitate easy installation of additional q modules

## Tl;dr
- To install 32bit only: ./configure && make && sudo make install
	- configure first checks to see if you have the necessary dependencies - if not it will tell you which ones to install
- To install with 64bit: ./configure --license=/path/to/licence.lic --64bit=/path/to/64bit/binary && make && sudo make install
- To install packages, do one of the following:
	- go to the directory of the package and run qpm.q install
	- installing from git (not completed): qpm.q install https://github.com/path/to/package.git
	- installing from qpm repository (not completed): qpm.q install packagename
- To use packages, just start a q instance and type
	.qp.require "packagename"

Note: for now this is linux only

## Install
To install, run the following:
1. git clone package
2. cd qp
3. ./configure
	- to install it in a non-default location, set the --prefix=<path> argument
	- add --license=<path>/<filename> and --64bit=<path>/<filename> to add in 64 bit q to the installation
	- add --no32bit to NOT install the 32bit version
4. make && make install
If BOTH LIC and SIXFOUR are defined then the default q will be 64bit, otherwise it will use the 32bit installation

## Usage
To run q, just type q into the console.  qp will accept all arguments q has, and tries to make the experience as seamless as possible
e.g.
```
>q -p 1234 -g 1
```

## qp namespace
The qp namespace simplifies the loading of external packages and makes writing packages easier.  These are the core features
- load packages via .qp.require "PACKAGENAME"
	- The loading logic will try to find the package in current working directory, then $QLIB, then $HOME/q, and finally $QHOME.  That is, more local packages will have priority over more global packages (current working directory over $QLIB, and $QLIB over $QHOME)
	- Packages loaded this way will be cached into .qp.cache.  Once a package is cached it won't try to reload the package again, so if you want to manually reload you will need to flush the cache of that package name
- load custom scripts via .qp.require "/PATH/TO/SCRIPT.q"
	- Loads the package at the path name
	- The script name will not be cached, so reloading via .qp.require is fine

## TODO
- add ability to auto-download dependencies to qpm.json
- add direct download from git
- add central repository