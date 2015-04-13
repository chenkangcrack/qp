uninstall:{[pkg;args]
	-1 "attempting to uninstall ",pkg;
	global:any args like "-global";
	idir:$[global;getenv[`QHOME];getenv[`QLIB]];
	if[0=count key hsym `$loc:idir,"/",pkg;err_exit "package not found"];
	if[99h <> type qpmconfig:@[readqpm;hsym `$loc,"/qpm.json";{0N}];err_exit pkg," is not a valid package cannot uninstall"];
	@[system;"rm -rf ",loc;{err_exit "cannot remove package - did you use sudo for global?"}];
	if[`bin in key qpmconfig;
		binloc:$[global;getenv[`QPREFIX];getenv[`HOME]],"/bin/",qpmconfig[`name],".q";
		@[system;"rm -f ",binloc;{err_exit "cannot remove binary file - did you use sudo for global?"}];];
	-1 "successfully uninstalled ",pkg;
	:0
 }

