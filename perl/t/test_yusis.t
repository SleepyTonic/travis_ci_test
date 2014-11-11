#!/usr/bin/perl -w
#Test script for YuSis::Upref module.
use strict;
use warnings;

use FindBin;
use File::Spec::Functions qw/catdir/;


#use lib '/usr/local/sis/sisperl/perl/lib/perl/5.10.1';
#use lib '/usr/local/sis/sisperl/perl/lib/perl5';
#use lib '/usr/local/sis/sisperl/perl/lib/perl5/x86_64-linux-gnu-thread-multi';
#use lib '/usr/local/sis/sisperl/perl/share/perl/5.10.1';

use lib "$FindBin::Bin/yusis";
use lib "$FindBin::Bin/..";
#use lib '/usr/local/sis/perl_lib/';



use Test::Unit::Debug qw(debug_pkgs);
use Test::Unit::HarnessUnit;

BEGIN {
	$ENV{APP_ROOT} = catdir ($FindBin::Bin, "..");
}

my $testrunner = Test::Unit::HarnessUnit->new();
$testrunner->start("AllTests");

1;
