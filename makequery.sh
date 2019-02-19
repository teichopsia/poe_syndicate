#!/bin/bash

t=${1:-index.html}
cat $t|
perl -ne '
	if(/class="choice ([^"]+)"/){
		print "$1\n" unless substr($1,0,3)eq"div"
	}'|
perl -e '
	$/=undef;
	my @div=split(/\n/,<STDIN>);
	my @xf=(map{my $j=$_;map{$j.$_}(a..z);}(A..D));
	my $qin={};
	my $qout={};
	for(my $i=0;$i<=$#div;$i++){
		$qin->{$xf[$i]}=$div[$i];
		$qout->{$div[$i]}=$xf[$i];
	}
	print "var xlat={";
	sub pj{
		my($x)=@_;
		foreach my $k (keys %$x) {
			print $k,q@:"@,$x->{$k},q@",@;
		}
	}
	pj($qin);pj($qout);
	print "};";
'
