/additional useful functions
k)ajr:{.Q.ft[{d:x_z;$[&/j:-1<i:(x#z)binr x#y;y,'d i;+.[+.Q.ff[y]d;(!+d;j);:;.+d i j:&j]]}[x,();;0!z]]y}
.q.xor:{((x&y)~:)&x|y} /xor
.j.rd:.j.k(,/)(0::)@
\d .qp

filedir:{{(last x ss "/")#x} first system "readlink -f ",string[.z.f]};

loadfile:{[p;f]if[0 = count key hsym `$p,"/",f;:0b];cwd:system"cd";system"cd ",p;system"l ",f;system"cd ",cwd;1b}

require:{[path]
	path:$[10h = type path;path;string[path]];
	$[null f:last path ss ".q";[if[(c:`$path) in cache;:1b];cache,:c];d:last path ss "/"];
	p:$[null f;(system"cd";getenv[`QLIB];getenv[`HOME],"/q";getenv[`QHOME]),\:"/",path;(,)d#path];
	f:$[null f;"index.q";(d+1)_path];
	s:{$[not y;loadfile[z;x];y]}[f]/[0b;p];
	:s;
 }

cache:();
filedir:dir[.z.f];
rundir:dir["."];

\d .