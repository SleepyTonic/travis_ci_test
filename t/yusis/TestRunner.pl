#!/usr/bin/perl -w
#Utility to test single Test cases


use strict;
use FindBin;
use lib "$FindBin::Bin/../..";
use lib '/usr/local/sis/perl_lib/';

#if(!$ENV{APP_ROOT} && !$ENV{YUSIS_ROOT}){
#	$ENV{YUSIS_ROOT} = '/usr/local/sis/sisperl/YuSis';
#}


#use Test::Unit::Debug qw(debug_pkgs);
use Test::Unit::TestRunner;

# Uncomment and edit to debug individual packages.
#debug_pkgs(qw/Test::Unit::TestCase/);

my $testrunner = Test::Unit::TestRunner->new();
$testrunner->start(@ARGV);
