package MonTest;
use base qw(Test::Unit::TestCase);

use strict;
use warnings;

use YuSis::Monitor;

BEGIN {
  print "YuSis::Monitor $YuSis::Monitor::VERSION \n";
}


sub new {
  my $self = shift()->SUPER::new(@_);
  return $self;
}

sub test_montor_serivice {
  my $self = shift;
  my $s = YuSis::Monitor->new(file => 'my_config.xml',
                              output => 'plain',
                              output_cfg => 'define'
                            );

  $self->assert( $s->can('check_services'));
  $self->assert( $s->check_services() == 1);
}

1;
