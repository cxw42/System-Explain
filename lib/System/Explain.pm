package System::Explain;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

# Copyright 1999-2012 by Paul Johnson (paul@pjcj.net)

# documentation at __END__

# Original author: Paul Johnson
# Created:         Fri 12 Mar 1999 10:25:51 am

use parent 'Exporter';

our @EXPORT = qw(sys dsys);

my $Command = 0;
my $Errors  = 0;
my $Verbose = 0;

sub import
{
  my $class = shift;
  my $args = "@_";
  $Command = $args =~ /\bcommand\b/i;
  $Errors  = $args =~ /\berror\b/i;
  $Verbose = $args =~ /\bverbose\b/i;
  $Command ||= $Verbose;
  $Errors  ||= $Verbose;
  $class->export_to_level(1, "sys" ) if $args =~ /\bsys\b/i;
  $class->export_to_level(1, "dsys") if $args =~ /\bdsys\b/i;
}

sub sys
{
  my (@command) = @_;
  local $| = 1;
  print "@command" if $Command;
  my $rc = 0xffff & system @command;
  print "\n" if $Command && !$rc && !$Verbose;
  ret($rc);
}

sub dsys
{
  die "@_ failed" if sys @_;
}

sub ret
{
  my ($rc) = @_;
  printf "  returned %#04x: ", $rc if $Errors && $rc;
  if ($rc == 0)
  {
    print "ran with normal exit\n" if $Verbose;
  }
  elsif ($rc == 0xff00)
  {
    print "command failed: $!\n" if $Errors;
  }
  elsif ($rc > 0x80)
  {
    $rc >>= 8;
    print "ran with non-zero exit status $rc\n" if $Errors;
  }
  else
  {
    print "ran with " if $Errors;
    if ($rc & 0x80)
    {
      $rc &= ~0x80;
      print "coredump from " if $Errors;
    }
    print "signal $rc\n" if $Errors;
  }
  $rc;
}

1;
__END__

=encoding utf-8

=head1 NAME

System::Explain - run a system command and explain the result

=head1 SYNOPSIS

    use System::Explain "command, verbose, errors";
    sys qw(ls -al);

The sys function runs a system command, checks the result, and comments on
it to STDOUT.

=head1 DESCRIPTION

System::Explain is a standalone release of L<System>, part of L<Gedcom>
v1.20 and earlier.

=head1 LICENSE

Copyright (C) 2012 Paul Johnson E<lt>pjcj@cpan.orgE<gt>

Also Copyright (C) 1999-2012 Paul Johnson; Copyright (C) 2019 Christopher White

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Paul Johnson E<lt>paul@pjcj.netE<gt>

=cut
