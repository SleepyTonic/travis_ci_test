package AllMonitorTests;

use Test::Unit::TestSuite;

BEGIN {
	print "APP_ROOT is set to " . $ENV{APP_ROOT} . "\n";
}

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub suite {
    my $class = shift;
    my $suite = Test::Unit::TestSuite->empty_new("Framework Tests");
    $suite->add_test('MonServiceTest');
		$suite->add_test('MonTest');
    #$suite->add_test('MonPluginTest');
    #$suite->add_test('MonNotifyTest');
    return $suite;
}

1;

__END__

=pod

=head1 AllTest

AllMonitorTests - unit testing framework self tests for the YuSis framework

=head1 SYNOPSIS

    # command line style use
    perl TestRunner.pl AllTests

	# or for select tests
	perl TestRunner.pl EDITransactionTest EDITest

=head1 DESCRIPTION

This class is used by the unit testing framework to encapsulate all
the self tests of the YuSis framework.

=head1 SEE ALSO

=over 4

=item *

L<Test::Unit::TestCase>

=item *

L<Test::Unit::TestSuite>

=back

=cut
