#!/usr/bin/env q

err_exit:{[err] -2 err;exit 1}

readqpm:{
	qpm:.j.k raze read0 x;
	/Check mandatory fields
	if[not `name in key qpm;err_exit "key name missing from qpm config"];
	qpm
 }

.qp.require[.qp.filedir[],"/install.q"];
.qp.require[.qp.filedir[],"/uninstall.q"];

/Break down arguments
if[0 = count .z.x;err_exit"no command given"];
args:.z.x where .z.x like "-*";
cmd:`$.z.x[0];
input:$[.z.x[1] like "-*";"";.z.x[1]];

rc:$[`install=cmd;
		install[input;args];
	`uninstall=cmd;
		uninstall[input;args];
	err_exit "command ",(string cmd)," not recognized"];
exit $[-7 <> type rc;1;rc]

