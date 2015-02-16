package List::Compare::Base::_Engine;
$VERSION = 0.44;
# Holds subroutines used within
# List::Compare::Base::Accelerated and List::Compare::Functional
use Carp;
use List::Compare::Base::_Auxiliary qw(
    _equiv_engine
    _calculate_seen_xintersection_only
    _calculate_union_seen_only
    _calculate_seen_only
);
@ISA = qw(Exporter);
@EXPORT_OK = qw|
    _unique_all_engine
    _complement_all_engine
|;
use strict;
local $^W = 1;

use Data::Dump;
sub _unique_all_engine {
    my $aref = shift;
say STDERR "ZZZ: input to _unique_all_engine";
Data::Dump::pp($aref);
    my ($seenref, $xintersectionref) =
        _calculate_seen_xintersection_only($aref);
say STDERR "AAA: seenref, xintersectionref";
Data::Dump::pp($seenref, $xintersectionref);
my $abc = _calculate_seen_only($aref);
say STDERR "BBB: abc";
Data::Dump::pp($abc);
    # dump demonstrates that $seenref and $abc are same

    # Calculate @xunique
    # Inputs:  $aref    %seen    %xintersection
    my (@xunique);
    for (my $i = 0; $i <= $#{$aref}; $i++) {
        my %seenthis = %{$seenref->{$i}};
        my (@uniquethis, %deductions, %alldeductions);
        # Get those elements of %xintersection which we'll need
        # to subtract from %seenthis
        foreach my $k (keys %{$xintersectionref}) {
            my ($left, $right) = split /_/, $k;
            if ($left == $i || $right == $i) {
                $deductions{$k} = $xintersectionref->{$k};
            }
        }
        foreach my $ded (keys %deductions) {
            foreach my $k (keys %{$deductions{$ded}}) {
                $alldeductions{$k}++;
            }
        }
        foreach my $k (keys %seenthis) {
            push(@uniquethis, $k) unless ($alldeductions{$k});
        }
        $xunique[$i] = \@uniquethis;
    }
#    return \@xunique;
my $xyz = \@xunique;
say STDERR "CCC: return from _unique_all_engine";
Data::Dump::pp($xyz);
    return $xyz;
}

sub _complement_all_engine {
    my ($aref, $unsortflag) = @_;
    my ($unionref, $seenref) = _calculate_union_seen_only($aref);
    my @union = $unsortflag ? keys %{$unionref} : sort(keys %{$unionref});

    # Calculate @xcomplement
    # Inputs:  $aref @union %seen
    my (@xcomplement);
    for (my $i = 0; $i <= $#{$aref}; $i++) {
        my @complementthis = ();
        foreach my $el (@union) {
            push(@complementthis, $el) unless (exists $seenref->{$i}->{$el});
        }
        $xcomplement[$i] = \@complementthis;
    }
    return \@xcomplement;
}

1;


__END__

=head1 NAME

List::Compare::Base::_Engine - Internal use only

=head1 VERSION

This document refers to version 0.44 of List::Compare::Base::_Engine.
This version was released February 15 2015.

=head1 SYNOPSIS

This module contains subroutines used within List::Compare and
List::Compare::Functional.  They are not intended to be publicly callable.

=head1 AUTHOR

James E. Keenan (jkeenan@cpan.org).  When sending correspondence, please
include 'List::Compare' or 'List-Compare' in your subject line.

Creation date:  May 20, 2002.  Last modification date:  February 15 2015.
Copyright (c) 2002-15 James E. Keenan.  United States.  All rights reserved.
This is free software and may be distributed under the same terms as Perl
itself.

=cut

