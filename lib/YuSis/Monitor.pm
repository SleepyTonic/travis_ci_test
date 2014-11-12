package YuSis::Monitor;

use strict;
use warnings;

use Carp qw/croak/;
use Parallel::ForkManager;
use IO::CaptureOutput;
use File::Spec;
use Time::HiRes qw/time/;
use Date::Calc;
use Data::Dumper;


our $VERSION = '0.6';
our $DEFAULT_PLUGIN_TIMEOUT = 120; # 120 seconds, 0 = disabled
our $PLUGIN_INTERRUPT_FLAG = 'INTERRUPT_MONITOR_PLUGIN';


$SIG{'ABRT'} = \&_sig_int_handler;
$SIG{'TERM'} = \&_sig_int_handler;

sub new {
	my $class = shift;
	my $self = {

		# the configuration file
		file => undef,

		# <csv|stdout|plain|xml|html|define> 'define' means to use the type of
		# <config default="true">..</config> configuration
		output => 'stdout',

		#config params for the output type or 'define'
		output_cfg => 'define',

		#turn notify on|off globally. 0 = off. 1 = on
		notify => 1,

		# A plugin's death (crash) is trapped by this module.
		# Setting this to 1 will print a warning message of the error to STDOUT
		print_fatals => 1,


		#the database handler (DBIx::Simple) used to resolve config tags <from-appl-config> (optional)
		#if the is null then the configuration cannot contain those tags
		#note: this handler is not passed to plugin, output, or notify classes
		#see YuSis::Monitor::Config
		dbh => undef,

		# the maximum time a plugin is allowed to use before
		# the monitor aborts the call. Setting to 0 will disable
		# this feature
		plugin_timeout => $DEFAULT_PLUGIN_TIMEOUT,

		#private
		_cfg => undef, #instance of YuSis::Monitor::Config
		_factory => undef, #YuSis::Monitor::ObjectFactory
		_global_notifiers => {}, #{ WARNING => [notifier1, notifier2], ALL => [notifier2]    }
		_output => undef, #YuSis::Monitor::Output object
	};

	if(@_){
		my %extra = ref $_[0] eq "HASH" ? %{$_[0]} : @_;
		@$self{keys %extra} = values %extra;
	}

	my $ref = bless $self, $class;
	$ref->_init;
	return $ref;
}

#private
sub _init {
	my $self = shift;

}

sub check_services {
	my ($self, $options) = @_;

  warn('stub');
	return 1;
}

1;

__END__

=head1 NAME

YuSis::Monitor - A monitoring and notification utility for SIS

=head1 SYNOPSIS

    use YuSis::Monitor;

    my $monitor = YuSis::Monitor->new( file => 'my_config.xml');
    $monitor->check_services;

    $monitor = YuSis::Monitor->new({ file => 'my_config.xml', notify => 0,
      output => 'xml',
      output_cfg => {
      	file      => '/var/tmp/my_output.xml',
      	overwrite => 1
      }
    });

    $monitor = YuSis::Monitor->new( file => 'my_config.xml', output => 'plain', output_cfg => 'define' );

=head1 DESCRIPTION

A monitoring and notification utility for SIS applications and services. See L<YuSis::Monitor::Manual|Manual>
for additional details about the library.

=head1 METHODS

=item C<new>

Creates an instance of this class. Accepts a hashref or hash of key/value pairs.
All options are not required unless explicitly stated.

=over 12

=item C<file> (required)

Specify the path to a valid YuSis Monitor schema (http://www.sis.yorku.ca/yusis-monitor/1.0) XML file.
See L<YuSis::Monitor::Manual|Manual/CONFIGURATION>.

=item C<output>

Specify (or override) the type of output the monitor will generate. If undef or 'define',
the monitor will use the configuration in the XML
file whose output tag has the 'default' attribute set to true or 1.

The known types are: 'xml', 'plain', 'stdout', 'csv', and 'html'.

TODO: more documentation needed here

=item C<output_cfg>

Specify (or override) the output's configuration parameters.


=item C<print_fatals>

Setting a true value will print any errors generated from plugins to STDERR.
By default, this is turned off.

=item C<notify>

Globally enable/disable notifications. By default this is turned on. Not yet implemented.

=item C<dbh>

Not yet implemented. Pass a database handler to the C<YuSis::Monitor::Config> instance.

=back

=item C<check_services>

The method is called with no arguments. It runs the configured tests and notifications (if configured) for
each service and produces an output. The return will usually be a file location where the output has been saved to.

  my $output = $monitor->check_services;

  if(ref $output eq '' && (-e $output)){
  	print ("The output is available at: $output");
  }else{
  	# some other object or string ...
  }

=item C<config>

Returns the L<YuSis::Monitor::Config|Config> instance this is attached to this monitor.

=head1 SEE ALSO

L<YuSis::Monitor::Manual|Manual>

=cut
