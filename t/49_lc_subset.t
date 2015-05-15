# perl
#$Id$
# 50_lcf_subset.t
use strict;
use Test::More qw(no_plan); # tests =>  51;
use List::Compare;

my @a0 = ( qw| alpha | );
my @a1 = ( qw| alpha beta | );
my @a2 = ( qw| alpha beta gamma | );

my ($lc, $LR, $RL);

$lc = List::Compare->new( \@a0, \@a1 );
$LR = $lc->is_LsubsetR();
ok($LR, "simple: left is subset of right");

$LR = $lc->is_AsubsetB();
ok($LR, "simple: left is subset of right");

$RL = $lc->is_RsubsetL();
ok(! $RL, "simple: right is not subset of left");

$RL = $lc->is_BsubsetA();
ok(! $RL, "simple: right is not subset of left");


$lc = List::Compare->new( '-u', \@a0, \@a1 );
$LR = $lc->is_LsubsetR();
ok($LR, "simple unsorted: left is subset of right");

$LR = $lc->is_AsubsetB();
ok($LR, "simple unsorted: left is subset of right");

$RL = $lc->is_RsubsetL();
ok(! $RL, "simple unsorted: right is not subset of left");

$RL = $lc->is_BsubsetA();
ok(! $RL, "simple unsorted: right is not subset of left");


$lc = List::Compare->new( '--unsorted', \@a0, \@a1 );
$LR = $lc->is_LsubsetR();
ok($LR, "simple unsorted long: left is subset of right");

$LR = $lc->is_AsubsetB();
ok($LR, "simple unsorted long: left is subset of right");

$RL = $lc->is_RsubsetL();
ok(! $RL, "simple unsorted long: right is not subset of left");

$RL = $lc->is_BsubsetA();
ok(! $RL, "simple unsorted long: right is not subset of left");


$lc = List::Compare->new( { lists => [ \@a0, \@a1 ] } );
$LR = $lc->is_LsubsetR();
ok($LR, "lists: left is subset of right");

$LR = $lc->is_AsubsetB();
ok($LR, "lists: left is subset of right");

$RL = $lc->is_RsubsetL();
ok(! $RL, "lists: right is not subset of left");

$RL = $lc->is_BsubsetA();
ok(! $RL, "lists: right is not subset of left");


$lc = List::Compare->new( { lists => [ \@a0, \@a1 ], unsorted => 1 } );
$LR = $lc->is_LsubsetR();
ok($LR, "lists: left is subset of right");

$LR = $lc->is_AsubsetB();
ok($LR, "lists: left is subset of right");

$RL = $lc->is_RsubsetL();
ok(! $RL, "lists: right is not subset of left");

$RL = $lc->is_BsubsetA();
ok(! $RL, "lists: right is not subset of left");


$lc = List::Compare->new( '-a', \@a0, \@a1 );
$LR = $lc->is_LsubsetR();
ok($LR, "simple accelerated: left is subset of right");

$LR = $lc->is_AsubsetB();
ok($LR, "simple accelerated: left is subset of right");

$RL = $lc->is_RsubsetL();
ok(! $RL, "simple accelerated: right is not subset of left");

$RL = $lc->is_BsubsetA();
ok(! $RL, "simple accelerated: right is not subset of left");


$lc = List::Compare->new( '--accelerated', \@a0, \@a1 );
$LR = $lc->is_LsubsetR();
ok($LR, "simple accelerated long: left is subset of right");

$LR = $lc->is_AsubsetB();
ok($LR, "simple accelerated long: left is subset of right");

$RL = $lc->is_RsubsetL();
ok(! $RL, "simple accelerated long: right is not subset of left");

$RL = $lc->is_BsubsetA();
ok(! $RL, "simple accelerated long: right is not subset of left");


$lc = List::Compare->new( { lists => [ \@a0, \@a1 ], accelerated => 1 } );
$LR = $lc->is_LsubsetR();
ok($LR, "lists: left is subset of right");

$LR = $lc->is_AsubsetB();
ok($LR, "lists: left is subset of right");

$RL = $lc->is_RsubsetL();
ok(! $RL, "lists: right is not subset of left");

$RL = $lc->is_BsubsetA();
ok(! $RL, "lists: right is not subset of left");


$lc = List::Compare->new( \@a0, \@a1, \@a2 );
$LR = $lc->is_LsubsetR();
ok($LR, "multiple: left is subset of right");
$LR = $lc->is_LsubsetR(0,1);
ok($LR, "multiple: left is subset of right");
$LR = $lc->is_LsubsetR(1,2);
ok($LR, "multiple: left is subset of right");
$LR = $lc->is_LsubsetR(0,2);
ok($LR, "multiple: left is subset of right");

$LR = $lc->is_AsubsetB();
ok($LR, "multiple: left is subset of right");
$LR = $lc->is_AsubsetB(0,1);
ok($LR, "multiple: left is subset of right");
$LR = $lc->is_AsubsetB(1,2);
ok($LR, "multiple: left is subset of right");
$LR = $lc->is_AsubsetB(0,2);
ok($LR, "multiple: left is subset of right");

