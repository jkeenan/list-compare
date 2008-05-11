# perl
#$Id$
# 34_func_lists_dual_unsorted.t
use strict;
use Test::More qw(no_plan); # tests =>  46;
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

%pred = map {$_, 1} qw( abel baker camera delta edward fargo golfer hilton );
@unpred = qw| icon jerky |;
@union = get_union( '-u', [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@union);
is_deeply(\%seen, \%pred, "unsorted:  got expected union");
ok(unseen(\%seen, \@unpred),
    "union:  All non-expected elements correctly excluded");
%seen = ();

$union_ref = get_union_ref( '-u', [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$union_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected union");
ok(unseen(\%seen, \@unpred),
    "union:  All non-expected elements correctly excluded");
%seen = ();

%pred = map {$_, 1} qw( baker camera delta edward fargo golfer );
@unpred = qw| abel hilton icon jerky |;
@shared = get_shared( '-u', [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@shared);
is_deeply(\%seen, \%pred, "unsorted:  got expected shared");
ok(unseen(\%seen, \@unpred),
    "shared:  All non-expected elements correctly excluded");
%seen = ();

$shared_ref = get_shared_ref( '-u', [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$shared_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected shared");
ok(unseen(\%seen, \@unpred),
    "shared:  All non-expected elements correctly excluded");
%seen = ();

%pred = map {$_, 1} qw( baker camera delta edward fargo golfer );
@unpred = qw| abel hilton icon jerky |;
@intersection = get_intersection( '-u', [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@intersection);
is_deeply(\%seen, \%pred, "unsorted:  got expected intersection");
ok(unseen(\%seen, \@unpred),
    "intersection:  All non-expected elements correctly excluded");
%seen = ();

$intersection_ref = get_intersection_ref( '-u', [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$intersection_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected intersection");
ok(unseen(\%seen, \@unpred),
    "intersection:  All non-expected elements correctly excluded");
%seen = ();

%pred = map {$_, 1} qw( abel );
@unpred = qw| baker camera delta edward fargo golfer hilton icon jerky |;
@unique = get_unique( '-u', [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@unique);
is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
ok(unseen(\%seen, \@unpred),
    "unique:  All non-expected elements correctly excluded");
%seen = ();

$unique_ref = get_unique_ref( '-u', [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$unique_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
ok(unseen(\%seen, \@unpred),
    "unique:  All non-expected elements correctly excluded");
%seen = ();

@pred = (
    [ 'abel' ],
    [ 'hilton' ],
);
$unique_all_ref = get_unique_all( '-u', [ \@a0, \@a1 ] );
is_deeply(
    make_array_seen_hash($unique_all_ref),
    make_array_seen_hash(\@pred),
    "Got expected values for get_unique_all()");

%pred = map {$_, 1} qw( hilton );
@unpred = qw| abel baker camera delta edward fargo golfer icon jerky |;
@complement = get_complement( '-u', [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@complement);
is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
ok(unseen(\%seen, \@unpred),
    "complement:  All non-expected elements correctly excluded");
%seen = ();

$complement_ref = get_complement_ref( '-u', [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$complement_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
ok(unseen(\%seen, \@unpred),
    "complement:  All non-expected elements correctly excluded");
%seen = ();

@pred = (
    [ qw( hilton ) ],
    [ qw( abel ) ],
);
$complement_all_ref = get_complement_all( '-u', [ \@a0, \@a1 ] );
is_deeply(
    make_array_seen_hash($complement_all_ref),
    make_array_seen_hash(\@pred),
    "Got expected values for get_complement_all()");

%pred = map {$_, 1} qw( abel hilton );
@unpred = qw| baker camera delta edward fargo golfer icon jerky |;
@symmetric_difference = get_symmetric_difference( '-u', [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@symmetric_difference);
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

$symmetric_difference_ref =
    get_symmetric_difference_ref( '-u', [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

@symmetric_difference = get_symdiff( '-u', [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@symmetric_difference);
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

$symmetric_difference_ref = get_symdiff_ref( '-u', [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

__END__
@pred = qw( abel hilton );
#{
#    my ($rv, $stdout, $stderr);
#    capture(
#        sub { @nonintersection = get_nonintersection; },
#        \$stdout,
#        \$stderr,
#    );
#    is_deeply( \@nonintersection, \@pred, "Got expected nonintersection");
#    like($stderr, qr/please consider re-coding/,
#        "Got expected warning");
#}
#{
#    my ($rv, $stdout, $stderr);
#    capture(
#        sub { $nonintersection_ref = get_nonintersection_ref; },
#        \$stdout,
#        \$stderr,
#    );
#    is_deeply($nonintersection_ref, \@pred, "Got expected nonintersection");
#    like($stderr, qr/please consider re-coding/,
#        "Got expected warning");
#}

@pred = qw( abel abel baker baker camera camera delta delta delta edward
edward fargo fargo golfer golfer hilton );
@bag = get_bag( '-u', [ \@a0, \@a1 ] );
is_deeply(\@bag, \@pred, "Got expected bag");

$bag_ref = get_bag_ref( '-u', [ \@a0, \@a1 ] );
is_deeply($bag_ref, \@pred, "Got expected bag");

$LR = is_LsubsetR( '-u', [ \@a0, \@a1 ] );
ok(! $LR, "Got expected subset relationship");

$RL = is_RsubsetL( '-u', [ \@a0, \@a1 ] );
ok(! $RL, "Got expected subset relationship");

$eqv = is_LequivalentR( '-u', [ \@a0, \@a1 ] );
ok(! $eqv, "Got expected equivalent relationship");

$eqv = is_LeqvlntR( '-u', [ \@a0, \@a1 ] );
ok(! $eqv, "Got expected equivalent relationship");

$disj = is_LdisjointR( '-u', [ \@a0, \@a1 ] );
ok(! $disj, "Got expected disjoint relationship");

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $rv = print_subset_chart( '-u', [ \@a0, \@a1 ] ); },
        \$stdout,
    );
    ok($rv, "print_subset_chart() returned true value");
    like($stdout, qr/Subset Relationships/,
        "Got expected chart header");
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $rv = print_equivalence_chart( '-u', [ \@a0, \@a1 ] ); },
        \$stdout,
    );
    ok($rv, "print_equivalence_chart() returned true value");
    like($stdout, qr/Equivalence Relationships/,
        "Got expected chart header");
}
     
ok(func_wrap_is_member_which(
    '-u', [ \@a0, \@a1 ],
    $test_members_which,
), "is_member_which() returned all expected values");

eval { @memb_arr = is_member_which('-u', [ \@a0 ]) };
like($@, qr/Subroutine call requires 2 references as arguments/,
        "is_member_which() correctly generated error message");

ok(func_wrap_is_member_which_ref(
    '-u', [ \@a0, \@a1 ],
    $test_members_which,
), "is_member_which_ref() returned all expected values");

eval { $memb_arr_ref = is_member_which_ref('-u', [ \@a0 ]) };
like($@, qr/Subroutine call requires 2 references as arguments/,
        "is_member_which_ref() correctly generated error message");

$memb_hash_ref =
    are_members_which(
        '-u', [ \@a0, \@a1 ] , 
        [ qw|abel baker camera delta edward fargo golfer hilton icon jerky zebra
    | ] );
ok(func_wrap_are_members_which(
    $memb_hash_ref,
    $test_members_which,
), "are_members_which() returned all expected values");

# Problem:  error message about Need to define 'lists' not helpful
#eval { $memb_hash_ref = are_members_which( { key => 'value' } ) };
#like($@,
#    qr/Method call requires exactly 1 argument which must be an array reference/,
#    "are_members_which() correctly generated error message");

ok(func_wrap_is_member_any(
    '-u', [ \@a0, \@a1 ] , 
    $test_members_any,
), "is_member_any() returned all expected values");

#eval { is_member_any('jerky', 'zebra') };
#like($@,
#    qr/Method call requires exactly 1 argument \(no references\)/,
#    "is_member_any() correctly generated error message");

$memb_hash_ref = are_members_any(
    '-u', [ \@a0, \@a1 ] , 
    [ qw| abel baker camera delta edward fargo 
          golfer hilton icon jerky zebra | ] );
ok(func_wrap_are_members_any(
    $memb_hash_ref,
    $test_members_any,
), "are_members_any() returned all expected values");

#eval { $memb_hash_ref = are_members_any( { key => 'value' } ) };
#like($@,
#    qr/Method call requires exactly 1 argument which must be an array reference/,
#    "are_members_any() correctly generated error message");

$vers = get_version;
ok($vers, "get_version() returned true value");


$LR = is_LsubsetR( '-u', [ \@a2, \@a3 ] );
ok(! $LR, "non-subset correctly determined");

$RL = is_RsubsetL( '-u', [ \@a2, \@a3 ] );
ok($RL, "subset correctly determined");

$eqv = is_LequivalentR( '-u', [ \@a2, \@a3 ] );
ok(! $eqv, "non-equivalence correctly determined");

$eqv = is_LeqvlntR( '-u', [ \@a2, \@a3 ] );
ok(! $eqv, "non-equivalence correctly determined");

$disj = is_LdisjointR( '-u', [ \@a2, \@a3 ] );
ok(! $disj, "non-disjoint correctly determined");


$eqv = is_LequivalentR( '-u', [ \@a3, \@a4 ] );
ok($eqv, "equivalence correctly determined");

$eqv = is_LeqvlntR( '-u', [ \@a3, \@a4 ] );
ok($eqv, "equivalence correctly determined");

$disj = is_LdisjointR( '-u', [ \@a3, \@a4 ] );
ok(! $disj, "non-disjoint correctly determined");


ok(0 == get_intersection( '-u', [ \@a4, \@a8 ] ), "no intersection, as expected");
ok(0 == scalar(@{get_intersection_ref( '-u', [ \@a4, \@a8 ] )}),
    "no intersection, as expected");
$disj = is_LdisjointR( '-u', [ \@a4, \@a8 ] );
ok($disj, "disjoint correctly determined");
