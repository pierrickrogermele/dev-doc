#!/usr/bin/env perl

use Data::Dumper;

my %h = ('toto' => 'zoo');

print Data::Dumper->Dump([\%h], ['\%h']);

my $h = \%h;
print Data::Dumper->Dump([$h], ['$h']);

my $s = "blabla";
print "\$s=$s\n";
my $s_ref = \$s;
print "\$s_ref=$s_ref\n";
print "\$\$s_ref=$$s_ref\n";
