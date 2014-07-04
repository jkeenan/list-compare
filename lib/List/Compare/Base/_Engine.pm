package List::Compare::Base::_Engine;
$VERSION = 0.39;
# Holds subroutines used within 
# List::Compare::Base::Accelerated and List::Compare::Functional
use Carp;
use List::Compare::Base::_Auxiliary qw(
    _equiv_engine 
    _calculate_seen_xintersection_only
    _calculate_union_seen_only
);
@ISA = qw(Exporter);
@EXPORT_OK = qw|
    _unique_all_engine
    _complement_all_engine
|;
use strict;
local $^W = 1;

sub _unique_all_engine {
    my $aref = shift;
    my ($seenref, $xintersectionref) = 
        _calculate_seen_xintersection_only($aref);
    my %seen = %{$seenref};
    my %xintersection = %{$xintersectionref};

    # Calculate @xunique
    # Inputs:  $aref    %seen    %xintersection
    my (@xunique);
    for (my $i = 0; $i <= $#{$aref}; $i++) {
        my %seenthis = %{$seen{$i}};
        my (@uniquethis, %deductions, %alldeductions);
        # Get those elements of %xintersection which we'll need 
        # to subtract from %seenthis
        foreach (keys %xintersection) {
            my ($left, $right) = split /_/, $_;
            if ($left == $i || $right == $i) {
                $deductions{$_} = $xintersection{$_};
            }
        }
        foreach my $ded (keys %deductions) {
            foreach (keys %{$deductions{$ded}}) {
                $alldeductions{$_}++;
            }
        }
        foreach (keys %seenthis) {
            push(@uniquethis, $_) unless ($alldeductions{$_});
        }
        $xunique[$i] = \@uniquethis;
    }
    return \@xunique;
}

sub _complement_all_engine {
    my ($aref, $unsortflag) = @_;
    my ($unionref, $seenref) = _calculate_union_seen_only($aref);
    my %seen = %{$seenref};
    my @union = $unsortflag ? keys %{$unionref} : sort(keys %{$unionref});

    # Calculate @xcomplement
    # Inputs:  $aref @union %seen
    my (@xcomplement);
    for (my $i = 0; $i <= $#{$aref}; $i++) {
        my %seenthis = %{$seen{$i}};
        my @complementthis = ();
        foreach (@union) {
            push(@complementthis, $_) unless (exists $seenthis{$_});
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

This document refers to version 0.39 of List::Compare::Base::_Engine.
This version was released July 04 2014.

=head1 SYNOPSIS

This module contains subroutines used within List::Compare and 
List::Compare::Functional.  They are not intended to be publicly callable.

=head1 AUTHOR

James E. Keenan (jkeenan@cpan.org).  When sending correspondence, please 
include 'List::Compare' or 'List-Compare' in your subject line.

Creation date:  May 20, 2002.  Last modification date:  July 04 2014. 
Copyright (c) 2002-14 James E. Keenan.  United States.  All rights reserved. 
This is free software and may be distributed under the same terms as Perl
itself.

=cut 

