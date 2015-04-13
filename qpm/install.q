install:{[pkg;args]
	if[0 = count pkg;-1 "attempting to install package in current directory...";install_local[pkg;args];:0];
	$[pkg like "[http|https]*";
		[-1 "attempting to install package from ",pkg;install_http[pkg;args]];
		[-1 "attempting to install package ",pkg;install_regular[pkg;args]]
	];
 }

install_http:{[pkg;args]
	-1 "install regular"
 }

install_regular:{[pkg;args]
	-1 "install regular";
 }

install_local:{[pkg;args]
	install_common[args]
 }

install_common:{[args]
	global:any args like "-global";
	idir:$[global;getenv[`QHOME];getenv[`QLIB]];
	if[not `qpm.json in key `:.;err_exit "current directory is not a valid qpm package"];
	if[99h <> type qpmconfig:@[readqpm;`:qpm.json;{0N}];err_exit "qpm.q is not a valid json and cannot be read"];
	
	loc:idir,"/",qpmconfig`name;

	if[`preinstall in key qpmconfig;
		-1 "preinstallation instructions found - attempting to execute";
		@[system;qpmconfig`preinstall;{err_exit "preinstallation error with error ",x}];
		-1 "preinstallation completed"];

	$[`install in key qpmconfig;
		[-1 "custom installation instructions found - attempting to execute";
		@[system;qpmconfig`install;{err_exit "error running custom script with error ",x}]
		];[
		@[system;"mkdir -p ",loc;{[loc;err] err_exit "cannot make folder ",loc}[loc]];
		@[system;"cp -r ./* ",loc;{[loc;err] err_exit "cannot install project into ",loc}[loc]];
	]];

	if[`postinstall in key qpmconfig;
		-1 "postinstallation instructions found - attempting to execute";
		@[system;qpmconfig`postinstall;{err_exit "postinstallation error with error ",x}];
		-1 "postinstallation completed";];

	if[`bin in key qpmconfig;
		-1 "binary instructions found - attempting to install binary";
		binloc:$[global;getenv[`QPREFIX];getenv[`HOME]],"/bin/",qpmconfig[`name],".q";
		@[system;"rm -f ",binloc;{err_exit "cannot remove old link - make sure that you can write into the install folder"}];
		@[system;"ln -s ",loc,"/",qpmconfig[`bin]," ",binloc;{err_exit "cannot create symlink due to ",x}];
		@[system;"chmod 755 ",binloc;{err_exit "cannot set permissions on binary with ",x}];
		@[system;"chmod 755 ",loc,"/",qpmconfig[`bin];{err_exit "cannot set permissions on reference library for binary with ",x}];
		-1 "binary installation completed";
	];
	:0
 }