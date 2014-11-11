package YuSis::Monitor::Service; #object containing information about a service.

use strict;
use warnings;

use Carp qw/croak/;

our $VERSION = sprintf("%d.%02d", q$Revision: 1.2 $ =~ /(\d+)\.(\d+)/);

sub new {
  my $class = shift;
  my $self = {
    name => undef,
    description => undef,
    id => undef, #required on init
    monitor_type => undef, #monitor type (the tag service or product )
    type => undef, #service type (value of the 'type' attribute)
    details => undef #holds the contents of product (or service) tag
  };

  if(@_){
    my %extra = ref $_[0] eq "HASH" ? %{$_[0]} : @_;
    @$self{keys %extra} = values %extra;
  }

  my $ref = bless $self, $class;
  $ref->init;
  return $ref;
}

sub init {
  my $self = shift;
  croak qq/Service must have an id/ unless(defined $self->{id});
}

sub is_product {
  my $self = shift;
  my $mt = $self->{monitor_type};
  return $mt && $mt eq 'product' ? 1 : 0;
}


#TODO: revise to make name more explict as to what it returns
sub details {
  my $self = shift;
  my $o = $self->{details};
  if(@_) { $self->{details} = shift; }
  return $o;
}

sub monitor_type { #returns the value of (product|service)
  my $self = shift;
  my $o = $self->{monitor_type};
  if(@_) { $self->{monitor_type} = shift; }
  return $o;
}

sub name {
  my $self = shift;
  my $o = $self->{name};
  if(@_) { $self->{name} = shift; }
  return $o;
}

#the service type: operational, application, general, technical
sub type {
  my $self = shift;
  my $o = $self->{type};
  if(@_) { $self->{type} = shift; }
  return $o;
}


sub id {
  my $self = shift;
  my $o = $self->{id};
  if(@_) { $self->{id} = shift; }
  return $o;
}

sub description {
  my $self = shift;
  my $o = $self->{description};
  if(@_) { $self->{description} = shift; }
  return $o;
}


1;

__END__


=head1 NAME

YuSis::Monitor::Service - Contains information about the product/service being monitored

=head1 SYNOPSIS

  use YuSis::Monitor::Service;

  my $s = YuSis::Monitor::Service->new(
  description => 'My service description',
  type => 'operational',
  monitor_type => 'product',
  name => 'ADMW',
  id => 'serv_01'
  );

  $s->type('technical');    # set type to 'technical'
  $s->is_product;           # returns 1
  $s->type;                 # returns 'technical'

  my $my_params = {
    parm1 => 'val1',
    parm2 => 'val2'
  };
  $d->details($my_params);  # set arbitrary params

=head1 DESCRIPTION

C<YuSis::Monitor::Service> provides an interface to set and retrive properties about a service. Some properties include the name of the service or product, the products version number,
a product description, etc.

Normally, the class should not be created directly. Instances are provided through other classes
such as C<YuSis::Monitor::Plugin> and C<YuSis::Monitor::Plugin::Notify>.

=head2 Methods

=over 12

=item C<new>

Creates an instance of C<YuSis::Monitor::Service>. Accepts a hasref or hash of key/value pairs.
All options are not required unless explicitly stated.

=over 12

=item C<name>

The service's name

=item C<id>

The service id (required). The string should not begin
with a number.

=item C<description>

The service description

=item C<type>

The service type which is one of: 'technical', 'general', 'application', or, 'operational'.

=item C<monitor_type>

Is the service we are monitoring a 'service' or really a 'product'. If set to 'service', then

  $service->is_product;

will return a false value;

=item C<details>

Sets additional key/value information. Expects a hashref.

=back


=item C<name>

Get/set the service's name.

  $serivce->name('My service');
  $service->name;     # returns 'My service'

=item C<id>

Get/set the service ID.

=item C<type>

Get/set the service's type. Service types are categorized into four groups: technical, operational, general, and application.
Ideally, operational service's check for things such as uptime and online availability whereas application service types provide general
stat information. See C<YuSis::Monitor> for a more detailed discussion.

=item C<monitor_type>

Get/set the service's monitor type. The type can be a 'product' or 'service'.

=item C<description>

Get/set the service description.

=item C<is_product>

Returns a true value when the service is a 'product'.

  $service->is_product;

=item C<details>

Get/set additional params. Note calling $service->details with an argument will erase any previously set
additional params.

  $service->details({myparm => 'abc'});

When an instance is provided from one of the C<YuSis::Monitor> classes and C<is_product> returns true, the following
params are available: technology, release-date, release-version, host, and fullname. Consult the XML schema C<monitor_1.0.xsd>
located under yusis/htdocs/monitor and C<YuSis::Monitor::Config> for additional information.

=back

=head1 See Also

L<YuSis::Monitor|Monitor>
L<YuSis::Monitor::Plugin|Plugin>
L<YuSis::Monitor::Notify|Notify>
L<YuSis::Monitor::Output|Output>
L<YuSis::Monitor::Config|Config>

=cut
