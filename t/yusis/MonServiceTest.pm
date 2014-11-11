package MonServiceTest;
use base qw(Test::Unit::TestCase);

use strict;
use warnings;

#use lib qw($ENV{APP_ROOT});
#use lib q(/usr/local/sis/perl_lib/);

use YuSis::Monitor::Service;

BEGIN {
	print "YuSis::Monitor::Service $YuSis::Monitor::Service::VERSION \n";
}


sub new {
	my $self = shift()->SUPER::new(@_);
	return $self;
}

sub test_can {
	my $self = shift;
	my $s = YuSis::Monitor::Service->new(id => 1);

	$self->assert( $s->can('description'));
	$self->assert( $s->can('id'));
	$self->assert( $s->can('is_product'));
	$self->assert( $s->can('type'));
	$self->assert( $s->can('monitor_type'));
	$self->assert( $s->can('name'));
	$self->assert( $s->can('details'));
}

sub test_init {
	my $self = shift;

	my $s = YuSis::Monitor::Service->new(id => '0');

	$self->assert($s->isa('YuSis::Monitor::Service'), 'Not a YuSis::Monitor::Service object');
	$self->assert($s->id eq '0');
	$self->assert(!$s->description);

	$s->id(4);
	$self->assert($s->id == 4, 'Cannot set id');

	$s->id(0);
	$self->assert($s->id == 0, 'Cannot set id to 0');

	$s->id(-1);
	$self->assert($s->id == -1, 'Cannot set id to -1');
}


sub test_args {
	my $self = shift;

	my $o = {
		id => 1,
		description => 'd',
		monitor_type => 'product',
		name => 'n',
		type => 'operational'
	};

	my $s = YuSis::Monitor::Service->new($o);
	$self->assert($s->id == 1);
	$self->assert($s->description eq 'd');
	$self->assert($s->monitor_type eq 'product');
	$self->assert($s->name eq 'n');
	$self->assert($s->type eq 'operational');

	$self->assert($s->is_product, 'service is not a product type');

	$s->name(undef);
	$self->assert(!$s->name, 'name is not undef');

	$s->details({ a => 'b'});

	$o = $s->details;

	$self->assert(ref $o eq 'HASH' && $o->{a} eq 'b');
}

sub test_error_conds {
	my $self = shift;

	#Service must have an id
	my $s;
	my $e;
	eval{
		$s = YuSis::Monitor::Service->new(description => 'd');
	};
	if($@){
		$e = $@;
	}

	$self->assert(qr/Service must have an id/, $e, "Did not croak on no id: $e");
}

1;
