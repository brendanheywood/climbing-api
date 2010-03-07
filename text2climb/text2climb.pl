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

print <<EOF;
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom" 
      xmlns:georss="http://www.georss.org/georss" 
      xmlns:gml="http://www.opengis.net/gml"
      xmlns:dc="http://purl.org/dc/elements/1.1/"
      xmlns:gd="http://schemas.google.com/g/2005">
EOF

foreach my $route (@routes){
	
	print "<entry>\n";

	##### pull out rating
	$route =~ s/(\**)//;
	my $rating = length($1);
	$rating = "\t<gd:rating min='1' max='3' average='$rating'>".('*'x$rating)."</gd:rating>\n";

	### pull out height
	$route =~ s/((\d)+m)//;
	my $grade = "\t<dc:format>$1</dc:format>\n";

	### pull out height
	$route =~ s/((\d)+)//;
	my $height = "\t<dc:grade>$1</dc:grade>\n";

	### pull out height
	$route =~ s/\s*(.*?)\s*\n//;
	print "\t<title type='xhtml'><div>$rating $1 $height $grade</div></title>\n";

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
	my @fa = split /and|\&|,/, $fa;

	print "\t<author><name>".join ("</name></author>\n\t<author><name>", @fa)."</name></author>\n";


	print "\t<content>$route</content>\n";

	print "</entry>\n";

}

print <<EOF;
</feed>

EOF


