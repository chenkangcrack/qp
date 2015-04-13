## qp Package design
qp packages are modeled after node.js's npm package manager, and it should be relatively easy to use.  The following are some key features
- similar to npm, entry point for a package is the index.q script
- when scripts are being loaded, the current working directory temporarily becomes the root so within scripts relative packages are safe to use
- the commandline installer/uninstaller is with qpm.q, which comes packaged with install/uninstall commands
- Currently qpm.json allows for the following values
	- preinstall: any preinstall instructions
	- install: the default installation instruction is to copy the entire package content into the target directory (either QLIB or QHOME), however you can override the instructions here
	- postinstall: any postinstallation instructions here
	- bin: if this key is set, then the file this key is associated with will be symlinked into the correct bin folder

For example, if we have the following:
```json
{
	"name": "qpm",
	"bin": "qpm.q",
	"preinstall": "ls"
}
```
we are telling the installer to run ls before installation, do the default installation, run no postinstallation procedures, then install qpm.q as a binary.
If this was run as "qpm.q install" then the library would be installed into $QLIB, and the binary would be installed into $HOME/bin, however if this was run as "qpm.q install -global", then the library would be installed into $QHOME, and the binary would be installed into $PREFIX/bin (usually /usr/local/bin)

uninstall would target 