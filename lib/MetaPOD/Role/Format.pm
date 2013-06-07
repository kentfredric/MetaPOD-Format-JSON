
use strict;
use warnings;

package MetaPOD::Role::Format;

# ABSTRACT: Base role for common format routines

use Moo::Role;
use Carp qw( croak );
use version 0.77;

=begin MetaPOD::JSON v1.1.0

{
    "namespace": "MetaPOD::Role::Format",
    "interface": "role"
}

=end MetaPOD::JSON


=method supported_versions

Returns a list of string versions supported by this class, or the consuming role.

    my ( @versions ) = $role->supported_versions

Each B<SHOULD> be in C<dotted decimal> format, and each B<SHOULD> be preceded with a C<v>

By default, returns

    v1.0.0


=cut

sub supported_versions { return qw( v1.0.0 ) }

=p_method _supported_versions

Returns a list of C<version> objects that represent an enumeration of all supported versions

The default implementation just wraps L</supported_versions> with C<< version->parse() >>

    my (@vobs) = $role->_supported_versions;

=cut

sub _supported_versions {
  my $class = shift;
  return map { version->parse($_) } $class->supported_versions;
}

=method supports_version

Determine if the class supports the given version or not

    $class->supports_version('v1.0.0');

C<version> B<MUST> be preceded with a C<v> and B<MUST> be in dotted decimal form.

Default implementation compares values given verses the results from C<< $class->_supported_versions >>

=cut

sub supports_version {
  my ( $class, $version ) = @_;
  return [ $class->supported_versions ]->[-1] if not defined $version;
  if ( $version !~ /^v/msx ) {
    croak q{Version specification does not begin with a 'v'};
  }
  my $v = version->parse($version);
  for my $supported ( $class->supported_versions ) {
    return $supported if $supported == $v;
  }
  croak "Version $v not supported. Supported versions: " . join q{,}, $class->supported_versions;
}

requires 'add_segment';

1;

