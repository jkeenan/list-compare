# perl
#$Id$
# 50_lcf_subset.t
use strict;
use Test::More qw(no_plan); # tests =>  51;
use List::Compare::Functional qw(is_LsubsetR is_RsubsetL);

my @a0 = ( qw| alpha | );
my @a1 = ( qw| alpha beta | );
my @a2 = ( qw| alpha beta gamma | );

my ($LR, $RL);

$LR = is_LsubsetR( [ \@a0, \@a1 ] );
ok($LR, "simple: left is subset of right");

$RL = is_RsubsetL( [ \@a0, \@a1 ] );
ok(! $RL, "simple: right is not subset of left");

$LR = is_LsubsetR( [ \@a1, \@a0 ] );
ok(! $LR, "simple: left is not subset of right");

$RL = is_RsubsetL( [ \@a1, \@a0 ] );
ok($RL, "right is subset of left");


$LR = is_LsubsetR( { lists => [ \@a0, \@a1 ] } );
ok($LR, "hashref lists: left is subset of right");

$RL = is_RsubsetL( { lists => [ \@a0, \@a1 ] } );
ok(! $RL, "hashref lists: right is not subset of left");

$LR = is_LsubsetR( { lists => [ \@a1, \@a0 ] } );
ok(! $LR, "hashref lists: left is not subset of right");

$RL = is_RsubsetL( { lists => [ \@a1, \@a0 ] } );
ok($RL, "right is subset of left");


$LR = is_LsubsetR( [ \@a0, \@a1 ], [ 0,1 ] );
ok($LR, "2 indices arrayref: left is subset of right");

$LR = is_LsubsetR( [ \@a1, \@a0 ], [ 0,1 ] );
ok(! $LR, "2 indices arrayref: left is not subset of right");

$LR = is_LsubsetR( [ \@a0, \@a1, \@a2 ], [ 1,2 ] );
ok($LR, "3 indices arrayref: left is subset of right");

$LR = is_LsubsetR( [ \@a2, \@a1, \@a0 ], [ 1,2 ] );
ok(! $LR, "3 indices arrayref: left is not subset of right");


$LR = is_LsubsetR( { lists => [ \@a0, \@a1 ], pair => [ 0,1 ] } );
ok($LR, "lists pair 2 indices: left is subset of right");

$LR = is_LsubsetR( { lists => [ \@a1, \@a0 ], pair => [ 0,1 ] } );
ok(! $LR, "lists pair 2 indices: left is not subset of right");

$LR = is_LsubsetR( { lists => [ \@a0, \@a1, \@a2 ], pair => [ 1,2 ] } );
ok($LR, "lists pair 3 indices: left is subset of right");

$LR = is_LsubsetR( { lists => [ \@a2, \@a1, \@a0 ], pair => [ 1,2 ] } );
ok(! $LR, "lists pair 3 indices: left is not subset of right");

