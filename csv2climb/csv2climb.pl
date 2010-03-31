#!/usr/bin/perl

use strict;

print <<EOF;
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom" 
      xmlns:georss="http://www.georss.org/georss" 
      xmlns:gml="http://www.opengis.net/gml"
      xmlns:dc="http://purl.org/dc/elements/1.1/"
      xmlns:gd="http://schemas.google.com/g/2005"
      xmlns:media="http://search.yahoo.com/mrss/"
      xmlns:x="http://schemas.google.com/g/2005"
>
<author><name>Brendan Heywood</name></author>
<id>http://nothing.com/notsure</id>
<title>cvs dump</title>
EOF


my $idPrefix = 'http://www.test.com/';

my $header = <>;

my @header = split (',', $header);
my %col2head = ();
for(my $c=0; $c<=$#header; $c++){
	my $head = $header[$c];
	$head =~ s/\{|\}//g;
	$head =~ s/\[.*\]//g;
	$head =~ s/:.*$//g;
	$head =~ s/label/title/g;
	$head =~ s/desc/content/g;
	chomp $head;
#	print "colr $c = $head \n";
	$col2head{$c} = $head;
}


my $count = 0;
foreach my $line (<>){
	#if ($count++ > 1){ last; }
	chomp $line;

	my @data = ();

	if ($line =~ /^\s*$/){ last; }

	while ($line){

		if ($line =~ s/^"(.*?)",//){
			push @data, $1;
			next;
		}
		if ($line =~ s/^(.*?),//){
			push @data, $1;
			next;
		}
		push @data, $line;
		$line = '';
	}

	my %data = ();
	for(my $col=0; $col <= $#data; $col++){
		$data{$col2head{$col}} = $data[$col];
	}
	
	print '<entry>';
	print field('id',             $idPrefix.$data{'id'});

	print field('title',          $data{'title'});
	print field('content',        $data{'content'});

	print '<author>';
	print field('name',           $data{'fa'});
	print '</author>';
	print field('dc:date',        $data{'faYear'});

	print field('x:area',         $data{'area'});
	print field('x:subarea',      $data{'subarea'});
	print field('x:bolts',        $data{'bolts'});

	print field('gd:rating',      $data{'rating'});

	print field('dc:type',        $data{'system'});
	print field('dc:format',      $data{'grade'});
	print field('dc:extent',      $data{'height'});


	print field('media:content',  $data{'imageUrl'}, 'url');



	print field('georss:point',  $data{'lat'} .' '.$data{'long'});
	print field('x:direction',   $data{'direction'} );
	print field('xelevation',    $data{'elevation'} );

	foreach my $key (keys %data){
#		print $key.' => '.$data{$key}." \n";
	}

	print "</entry>\n";
}


print "</feed>\n";

exit;

sub field {
	my ($elem, $value, $attr) = (@_);
	if (!$value || $value =~ /^\s*$/){
		return "";
	}
	if ($attr){
		$value =~ s/&/&amp;/g;
		$value =~ s/</&lt;/g;
		$value =~ s/>/&gt;/g;
		return "\t<$elem $attr=\"$value\" />\n";
	}
	$value =~ s/&/&amp;/g;
	$value =~ s/</&lt;/g;
	$value =~ s/>/&gt;/g;
	return "\t<$elem>$value</$elem>\n";

}


