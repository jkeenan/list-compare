# perl
#$Id$
# 47_func_hashes_alt_mult_sorted.t
use strict;
use Test::More tests =>  43;
use List::Compare::Functional qw(:originals :aliases);
use lib ("./t");
use Test::ListCompareSpecial qw( :seen :func_wrap :hashes :results );
use Capture::Tiny q|:all|;

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
@union = get_union( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply( \@union, \@pred, "Got expected union");

$union_ref = get_union_ref( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply( $union_ref, \@pred, "Got expected union");

@pred = qw(baker camera delta edward fargo golfer hilton icon);
@shared = get_shared( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply( \@shared, \@pred, "Got expected shared");

$shared_ref = get_shared_ref( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply( $shared_ref, \@pred, "Got expected shared");

@pred = qw(fargo golfer);
@intersection = get_intersection( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply(\@intersection, \@pred, "Got expected intersection");

$intersection_ref = get_intersection_ref( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply($intersection_ref, \@pred, "Got expected intersection");

@pred = qw( jerky );
@unique = get_unique( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ], item => 2 } );
is_deeply(\@unique, \@pred, "Got expected unique");

$unique_ref = get_unique_ref( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ], item => 2 } );
is_deeply($unique_ref, \@pred, "Got expected unique");

@pred = qw( abel );
@unique = get_unique( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply(\@unique, \@pred, "Got expected unique");

$unique_ref = get_unique_ref( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply($unique_ref, \@pred, "Got expected unique");

@pred = (
    [ 'abel' ],
    [  ],
    [ 'jerky' ],
    [ ],
    [  ],
);
$unique_all_ref = get_unique_all( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply($unique_all_ref, [ @pred ],
    "Got expected values for get_unique_all()");

@pred = qw( abel icon jerky );
@complement = get_complement({ lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ], item => 1 } );
is_deeply(\@complement, \@pred, "Got expected complement");

$complement_ref = get_complement_ref({ lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ], item => 1 } );
is_deeply($complement_ref, \@pred, "Got expected complement");

@pred = qw ( hilton icon jerky );
@complement = get_complement( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply(\@complement, \@pred, "Got expected complement");

$complement_ref = get_complement_ref( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply($complement_ref, \@pred, "Got expected complement");

@pred = (
    [ qw( hilton icon jerky ) ],
    [ qw( abel icon jerky ) ],
    [ qw( abel baker camera delta edward ) ],
    [ qw( abel baker camera delta edward jerky ) ],
    [ qw( abel baker camera delta edward jerky ) ],
);
$complement_all_ref = get_complement_all( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply($complement_all_ref, [ @pred ],
    "Got expected values for get_complement_all()");

@pred = qw( abel jerky );
@symmetric_difference =
    get_symmetric_difference( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply(\@symmetric_difference, \@pred, "Got expected symmetric_difference");

$symmetric_difference_ref =
    get_symmetric_difference_ref( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply($symmetric_difference_ref, \@pred, "Got expected symmetric_difference");

@symmetric_difference = get_symdiff( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply(\@symmetric_difference, \@pred, "Got expected symmetric_difference");

$symmetric_difference_ref = get_symdiff_ref( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply($symmetric_difference_ref, \@pred, "Got expected symmetric_difference");

@pred = qw( abel baker camera delta edward hilton icon jerky );
@nonintersection = get_nonintersection( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply( \@nonintersection, \@pred, "Got expected nonintersection");

$nonintersection_ref = get_nonintersection_ref( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply($nonintersection_ref, \@pred, "Got expected nonintersection");

@pred = qw( abel abel baker baker camera camera delta delta delta edward
edward fargo fargo fargo fargo fargo fargo golfer golfer golfer golfer golfer
hilton hilton hilton hilton icon icon icon icon icon jerky );
@bag = get_bag( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply(\@bag, \@pred, "Got expected bag");

$bag_ref = get_bag_ref( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
is_deeply($bag_ref, \@pred, "Got expected bag");

$LR = is_LsubsetR( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ], pair => [ 3,2 ] } );
ok($LR, "Got expected subset relationship");

$LR = is_LsubsetR( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ], pair => [ 2,3 ] } );
ok(! $LR, "Got expected subset relationship");

$LR = is_LsubsetR( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
ok(! $LR, "Got expected subset relationship");

$eqv = is_LequivalentR( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ], pair => [ 3,4 ] } );
ok($eqv, "Got expected equivalence relationship");

$eqv = is_LeqvlntR( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ], pair => [ 3,4 ] } );
ok($eqv, "Got expected equivalence relationship");

$eqv = is_LequivalentR( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ], pair => [ 2,4 ] } );
ok(! $eqv, "Got expected equivalence relationship");

{
    my ($rv, $stdout, $stderr);
    $stdout = capture_stdout { $rv = print_subset_chart( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } ); };
    ok($rv, "print_subset_chart() returned true value");
    like($stdout, qr/Subset Relationships/,
        "Got expected chart header");
}
{
    my ($rv, $stdout, $stderr);
    $stdout = capture_stdout { $rv = print_equivalence_chart( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } ); };
    ok($rv, "print_equivalence_chart() returned true value");
    like($stdout, qr/Equivalence Relationships/,
        "Got expected chart header");
}

@args = qw( abel baker camera delta edward fargo golfer hilton icon jerky zebra );

is_deeply(func_all_is_member_which_alt( [ \%h0, \%h1, \%h2, \%h3, \%h4 ], \@args ),
    $test_member_which_mult,
    "is_member_which() returned all expected values");

is_deeply(func_all_is_member_which_ref_alt( [ \%h0, \%h1, \%h2, \%h3, \%h4 ], \@args ),
    $test_member_which_mult,
    "is_member_which_ref() returned all expected values");

$memb_hash_ref = are_members_which( {
    lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ],
    items => \@args
} );
is_deeply($memb_hash_ref, $test_members_which_mult,
   "are_members_which() returned all expected values");

is_deeply(func_all_is_member_any_alt( [ \%h0, \%h1, \%h2, \%h3, \%h4 ], \@args ),
    $test_member_any_mult,
    "is_member_any() returned all expected values");

$memb_hash_ref = are_members_any( {
    lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ],
    items => \@args,
} );
ok(func_wrap_are_members_any(
    $memb_hash_ref,
    $test_members_any_mult,
), "are_members_any() returned all expected values");

$vers = get_version;
ok($vers, "get_version() returned true value");

$disj = is_LdisjointR( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4, \%h8 ] } );
ok(! $disj, "Got expected disjoint relationship");

$disj = is_LdisjointR( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4, \%h8 ], pair
=> [ 2,3 ] } );
ok(! $disj, "Got expected disjoint relationship");

$disj = is_LdisjointR( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4, \%h8 ], pair
=> [ 4,5 ] } );
ok($disj, "Got expected disjoint relationship");

