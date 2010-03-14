#!/usr/bin/perl

use strict;

print <<EOF;
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom" 
      xmlns:georss="http://www.georss.org/georss" 
      xmlns:gml="http://www.opengis.net/gml"
      xmlns:dc="http://purl.org/dc/elements/1.1/"
      xmlns:gd="http://schemas.google.com/g/2005">
EOF

my $header = <>;

my @header = split (',', $header);
my %col2head = ();
for(my $c=0; $c<=$#header; $c++){
	my $head = $header[$c];
	$head =~ s/\{|\}//g;
	$head =~ s/label/title/g;
#	print "colr $c = $head \n";
	$col2head{$c} = $head;
}


my $count = 0;
foreach my $line (<>){
	if ($count++ > 10){ last; }
	chomp $line;
	my @data = split(',', $line);
	my %data = ();
	for(my $col=0; $col <= $#data; $col++){
		$data{$col2head{$col}} = $data[$col];
	}
	
	print '<entry>';
	print "<title>$data{'title'}</title>";
	print "<georss:point>$data{'lat'} $data{'long'}</georss:point>";
	print "</entry>\n";
#	<georss:point$lat,$long</georss:point>

}
print "</channel>\n";



