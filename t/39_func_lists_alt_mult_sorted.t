# perl
#$Id$
# 39_func_lists_alt_mult_sorted.t
use strict;
use Test::More tests =>  43;
use List::Compare::Functional qw(:originals :aliases);
use lib ("./t");
use Test::ListCompareSpecial qw( :seen :func_wrap :arrays :results );
use IO::CaptureOutput qw( capture );

my @pred = ();
my %seen = ();
my %pred = ();
my @unpred = ();
my (@unique, @complement, @intersection, @union, @symmetric_difference, @bag);
my ($unique_ref, $complement_ref, $intersection_ref, $union_ref,
$symmetric_difference_ref, $bag_ref);
my ($LR, $RL, $eqv, $disj, $return, $vers);
my (@nonintersection, @shared);
my ($nonintersection_ref, $shared_ref);
my ($memb_hash_ref, $memb_arr_ref, @memb_arr);
my ($unique_all_ref, $complement_all_ref);
my @args;

@pred = qw(abel baker camera delta edward fargo golfer hilton icon jerky);
@union = get_union( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply( \@union, \@pred, "Got expected union");

$union_ref = get_union_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply( $union_ref, \@pred, "Got expected union");

@pred = qw(baker camera delta edward fargo golfer hilton icon);
@shared = get_shared( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply( \@shared, \@pred, "Got expected shared");

$shared_ref = get_shared_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply( $shared_ref, \@pred, "Got expected shared");

@pred = qw(fargo golfer);
@intersection = get_intersection( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply(\@intersection, \@pred, "Got expected intersection");

$intersection_ref = get_intersection_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply($intersection_ref, \@pred, "Got expected intersection");

@pred = qw( jerky );
@unique = get_unique( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 2 } );
is_deeply(\@unique, \@pred, "Got expected unique");

$unique_ref = get_unique_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 2 } );
is_deeply($unique_ref, \@pred, "Got expected unique");

@pred = qw( abel );
@unique = get_unique( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply(\@unique, \@pred, "Got expected unique");

$unique_ref = get_unique_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply($unique_ref, \@pred, "Got expected unique");

@pred = (
    [ 'abel' ],
    [  ],
    [ 'jerky' ],
    [ ],
    [  ],
);
$unique_all_ref = get_unique_all( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply($unique_all_ref, [ @pred ],
    "Got expected values for get_unique_all()");

@pred = qw( abel icon jerky );
@complement = get_complement({ lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 1 } );
is_deeply(\@complement, \@pred, "Got expected complement");

$complement_ref = get_complement_ref({ lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 1 } );
is_deeply($complement_ref, \@pred, "Got expected complement");

@pred = qw ( hilton icon jerky );
@complement = get_complement( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply(\@complement, \@pred, "Got expected complement");

$complement_ref = get_complement_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply($complement_ref, \@pred, "Got expected complement");

@pred = (
    [ qw( hilton icon jerky ) ],
    [ qw( abel icon jerky ) ],
    [ qw( abel baker camera delta edward ) ],
    [ qw( abel baker camera delta edward jerky ) ],
    [ qw( abel baker camera delta edward jerky ) ],
);
$complement_all_ref = get_complement_all( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply($complement_all_ref, [ @pred ],
    "Got expected values for get_complement_all()");

@pred = qw( abel jerky );
@symmetric_difference =
    get_symmetric_difference( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply(\@symmetric_difference, \@pred, "Got expected symmetric_difference");

$symmetric_difference_ref =
    get_symmetric_difference_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply($symmetric_difference_ref, \@pred, "Got expected symmetric_difference");

@symmetric_difference = get_symdiff( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply(\@symmetric_difference, \@pred, "Got expected symmetric_difference");

$symmetric_difference_ref = get_symdiff_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply($symmetric_difference_ref, \@pred, "Got expected symmetric_difference");

@pred = qw( abel baker camera delta edward hilton icon jerky );
@nonintersection = get_nonintersection( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply( \@nonintersection, \@pred, "Got expected nonintersection");

$nonintersection_ref = get_nonintersection_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply($nonintersection_ref, \@pred, "Got expected nonintersection");

@pred = qw( abel abel baker baker camera camera delta delta delta edward
edward fargo fargo fargo fargo fargo fargo golfer golfer golfer golfer golfer
hilton hilton hilton hilton icon icon icon icon icon jerky );
@bag = get_bag( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply(\@bag, \@pred, "Got expected bag");

$bag_ref = get_bag_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
is_deeply($bag_ref, \@pred, "Got expected bag");

$LR = is_LsubsetR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], pair => [ 3,2 ] } );
ok($LR, "Got expected subset relationship");

$LR = is_LsubsetR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], pair => [ 2,3 ] } );
ok(! $LR, "Got expected subset relationship");

$LR = is_LsubsetR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok(! $LR, "Got expected subset relationship");

$eqv = is_LequivalentR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], pair => [ 3,4 ] } );
ok($eqv, "Got expected equivalence relationship");

$eqv = is_LeqvlntR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], pair => [ 3,4 ] } );
ok($eqv, "Got expected equivalence relationship");

$eqv = is_LequivalentR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], pair => [ 2,4 ] } );
ok(! $eqv, "Got expected equivalence relationship");

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $rv = print_subset_chart( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } ); },
        \$stdout,
    );
    ok($rv, "print_subset_chart() returned true value");
    is($stdout, convert_eol(<<'...'), "Got expected chart");

Subset Relationships

   Right:    0    1    2    3    4

Left:  0:    1    0    0    0    0

       1:    0    1    0    0    0

       2:    0    0    1    0    0

       3:    0    0    1    1    1

       4:    0    0    1    1    1

...
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $rv = print_equivalence_chart( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } ); },
        \$stdout,
    );
    ok($rv, "print_equivalence_chart() returned true value");
    is($stdout, convert_eol(<<'...'), "Got expected chart");

Equivalence Relationships

   Right:    0    1    2    3    4

Left:  0:    1    0    0    0    0

       1:    0    1    0    0    0

       2:    0    0    1    0    0

       3:    0    0    0    1    1

       4:    0    0    0    1    1

...
}

@args = qw( abel baker camera delta edward fargo golfer hilton icon jerky zebra );

is_deeply(func_all_is_member_which_alt( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], \@args ),
    $test_member_which_mult,
    "is_member_which() returned all expected values");

is_deeply(func_all_is_member_which_ref_alt( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], \@args ),
    $test_member_which_mult,
    "is_member_which_ref() returned all expected values");

$memb_hash_ref = are_members_which( {
    lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ],
    items => \@args
} );
is_deeply($memb_hash_ref, $test_members_which_mult,
   "are_members_which() returned all expected values");

is_deeply(func_all_is_member_any_alt( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], \@args ),
    $test_member_any_mult,
    "is_member_any() returned all expected values");

$memb_hash_ref = are_members_any( {
    lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ],
    items => \@args,
} );
ok(func_wrap_are_members_any(
    $memb_hash_ref,
    $test_members_any_mult,
), "are_members_any() returned all expected values");

$vers = get_version;
ok($vers, "get_version() returned true value");

$disj = is_LdisjointR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4, \@a8 ] } );
ok(! $disj, "Got expected disjoint relationship");

$disj = is_LdisjointR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4, \@a8 ], pair
=> [ 2,3 ] } );
ok(! $disj, "Got expected disjoint relationship");

$disj = is_LdisjointR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4, \@a8 ], pair
=> [ 4,5 ] } );
ok($disj, "Got expected disjoint relationship");
