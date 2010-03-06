#!/usr/bin/perl

use strict;

if ($#ARGV == -1){
	print <<EOF;
Usage: $0 infile.txt > outfile.xml
EOF
	exit;
}

open IN, $ARGV[0];
my $raw_text = join '', <IN>;

my @routes = split /\n\n+/, $raw_text;

foreach my $route (@routes){
	
	print "<entry>\n";

	##### pull out rating
	$route =~ s/(\**)//;
	print "\t<rating average='$1'/>\n";

	### pull out height
	$route =~ s/((\d)+m)//;
	print "\t<dc:format>$1</dc:format>\n";

	### pull out height
	$route =~ s/((\d)+)//;
	print "\t<dc:grade>$1</dc:grade>\n";

	### pull out height
	$route =~ s/\s*(.*?)\s*\n//;
	print "\t<title>$1</title>\n";

	### pull out FA
	$route =~ s/FFA:(.*)//;
	my $fa = $1;
	my $year;
	if ($fa =~ s/(\d+)\/(\d+)//){
		$year = $2;
		if ($year < 100){ $year += 1900; }
		print "\t<dc:date>$1 / $year</dc:date>\n";
	}
	if ($fa =~ s/(\d\d\d\d)//){
		print "\t<dc:date>$1</dc:date>\n";
	}
	my @fa = split /and|\&/, $fa;

	print "\t<author>".join ("</author>\n\t<author>", @fa)."</author>\n";


	print "\t<summary>$route</summary>\n";

	print "</entry>\n";

}



