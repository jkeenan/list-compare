# perl
#$Id$
# 33_func_lists_dual_sorted.t
use Test::More qw(no_plan); # tests =>  80;
use List::Compare::Functional qw(:originals :aliases);
use lib ("./t");
use Test::ListCompareSpecial qw( :seen :func_wrap :arrays );
use IO::CaptureOutput qw( capture );

my @pred = ();
my %seen = ();
my %pred = ();
my @unpred = ();
my (@unique, @complement, @intersection, @union, @symmetric_difference, @bag);
my ($unique_ref, $complement_ref, $intersection_ref, $union_ref,
$symmetric_difference_ref, $bag_ref);
my ($LR, $RL, $eqv, $disj, $return);
my (@nonintersection, @shared);
my ($nonintersection_ref, @shared_ref);
my ($memb_hash_ref, $memb_arr_ref, @memb_arr);
my ($unique_all_ref, $complement_all_ref);

my $test_members_which =  {
    abel      => [ 1, [ qw< 0   > ] ],
    baker     => [ 2, [ qw< 0 1 > ] ],
    camera    => [ 2, [ qw< 0 1 > ] ],
    delta     => [ 2, [ qw< 0 1 > ] ],
    edward    => [ 2, [ qw< 0 1 > ] ],
    fargo     => [ 2, [ qw< 0 1 > ] ],
    golfer    => [ 2, [ qw< 0 1 > ] ],
    hilton    => [ 1, [ qw<   1 > ] ],
    icon      => [ 0, [ qw<     > ] ],
    jerky     => [ 0, [ qw<     > ] ],
    zebra     => [ 0, [ qw<     > ] ],
};

my $test_members_any = {
    abel    => 1,
    baker   => 1,
    camera  => 1,
    delta   => 1,
    edward  => 1,
    fargo   => 1,
    golfer  => 1,
    hilton  => 1,
    icon    => 0,
    jerky   => 0,
    zebra   => 0,
};

### new ###
#my $lc  = List::Compare->new(\@a0, \@a1);
#ok($lc, "List::Compare constructor returned true value");

@pred = qw(abel baker camera delta edward fargo golfer hilton);
@union = get_union( [ \@a0, \@a1 ] );
is_deeply( \@union, \@pred, "Got expected union");

$union_ref = get_union_ref( [ \@a0, \@a1 ] );
is_deeply( $union_ref, \@pred, "Got expected union");

@pred = qw( baker camera delta edward fargo golfer );
@shared = get_shared( [ \@a0, \@a1 ] );
is_deeply( \@shared, \@pred, "Got expected shared");

$shared_ref = get_shared_ref( [ \@a0, \@a1 ] );
is_deeply( $shared_ref, \@pred, "Got expected shared");


@pred = qw( baker camera delta edward fargo golfer );
@intersection = get_intersection( [ \@a0, \@a1 ] );
is_deeply(\@intersection, \@pred, "Got expected intersection");

$intersection_ref = get_intersection_ref( [ \@a0, \@a1 ] );
is_deeply($intersection_ref, \@pred, "Got expected intersection");

@pred = qw( abel );
@unique = get_unique( [ \@a0, \@a1 ] );
is_deeply(\@unique, \@pred, "Got expected unique");

$unique_ref = get_unique_ref( [ \@a0, \@a1 ] );
is_deeply($unique_ref, \@pred, "Got expected unique");

@pred = (
    [ 'abel' ],
    [ 'hilton' ],
);
$unique_all_ref = get_unique_all( [ \@a0, \@a1 ] );
is_deeply($unique_all_ref, [ @pred ],
    "Got expected values for get_unique_all()");

@pred = qw ( hilton );
@complement = get_complement( [ \@a0, \@a1 ] );
is_deeply(\@complement, \@pred, "Got expected complement");

$complement_ref = get_complement_ref( [ \@a0, \@a1 ] );
is_deeply($complement_ref, \@pred, "Got expected complement");

@pred = (
    [ qw( hilton ) ],
    [ qw( abel ) ],
);
$complement_all_ref = get_complement_all( [ \@a0, \@a1 ] );
is_deeply($complement_all_ref, [ @pred ],
    "Got expected values for get_complement_all()");

@pred = qw( abel hilton );
@symmetric_difference = get_symmetric_difference( [ \@a0, \@a1 ] );
is_deeply(\@symmetric_difference, \@pred, "Got expected symmetric_difference");

$symmetric_difference_ref = get_symmetric_difference_ref( [ \@a0, \@a1 ] );
is_deeply($symmetric_difference_ref, \@pred, "Got expected symmetric_difference");

@symmetric_difference = get_symdiff( [ \@a0, \@a1 ] );
is_deeply(\@symmetric_difference, \@pred, "Got expected symmetric_difference");

$symmetric_difference_ref = get_symdiff_ref( [ \@a0, \@a1 ] );
is_deeply($symmetric_difference_ref, \@pred, "Got expected symmetric_difference");

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
@bag = get_bag( [ \@a0, \@a1 ] );
is_deeply(\@bag, \@pred, "Got expected bag");

$bag_ref = get_bag_ref( [ \@a0, \@a1 ] );
is_deeply($bag_ref, \@pred, "Got expected bag");

$LR = is_LsubsetR( [ \@a0, \@a1 ] );
ok(! $LR, "Got expected subset relationship");

$RL = is_RsubsetL( [ \@a0, \@a1 ] );
ok(! $RL, "Got expected subset relationship");

$eqv = is_LequivalentR( [ \@a0, \@a1 ] );
ok(! $eqv, "Got expected equivalent relationship");

$eqv = is_LeqvlntR( [ \@a0, \@a1 ] );
ok(! $eqv, "Got expected equivalent relationship");

$disj = is_LdisjointR( [ \@a0, \@a1 ] );
ok(! $disj, "Got expected disjoint relationship");

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $rv = print_subset_chart( [ \@a0, \@a1 ] ); },
        \$stdout,
    );
    ok($rv, "print_subset_chart() returned true value");
    like($stdout, qr/Subset Relationships/,
        "Got expected chart header");
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $rv = print_equivalence_chart( [ \@a0, \@a1 ] ); },
        \$stdout,
    );
    ok($rv, "print_equivalence_chart() returned true value");
    like($stdout, qr/Equivalence Relationships/,
        "Got expected chart header");
}
     
ok(func_wrap_is_member_which(
    [ \@a0, \@a1 ],
    $test_members_which,
), "is_member_which() returned all expected values");

#eval { $memb_arr_ref = is_member_which('jerky', 'zebra') };
#like($@, qr/Method call requires exactly 1 argument \(no references\)/,
#        "is_member_which() correctly generated error message");

#ok(wrap_is_member_which_ref(
#    $lc,
#    $test_members_which,
#), "is_member_which_ref() returned all expected values");
#
#eval { $memb_arr_ref = is_member_which_ref('jerky', 'zebra') };
#like($@, qr/Method call requires exactly 1 argument \(no references\)/,
#        "is_member_which_ref() correctly generated error message");
#
#$memb_hash_ref =
#    are_members_which( [ qw|
#        abel baker camera delta edward fargo golfer hilton icon jerky zebra
#    | ] );
#ok(wrap_are_members_which(
#    $memb_hash_ref,
#    $test_members_which,
#), "are_members_which() returned all expected value");
#
#eval { $memb_hash_ref = are_members_which( { key => 'value' } ) };
#like($@,
#    qr/Method call requires exactly 1 argument which must be an array reference/,
#    "are_members_which() correctly generated error message");
#
#ok(wrap_is_member_any(
#    $lc,
#    $test_members_any,
#), "is_member_any() returned all expected values");
#
#eval { is_member_any('jerky', 'zebra') };
#like($@,
#    qr/Method call requires exactly 1 argument \(no references\)/,
#    "is_member_any() correctly generated error message");
#
#$memb_hash_ref = are_members_any(
#    [ qw| abel baker camera delta edward fargo 
#          golfer hilton icon jerky zebra | ] );
#ok(wrap_are_members_any(
#    $memb_hash_ref,
#    $test_members_any,
#), "are_members_any() returned all expected values");
#
#eval { $memb_hash_ref = are_members_any( { key => 'value' } ) };
#like($@,
#    qr/Method call requires exactly 1 argument which must be an array reference/,
#    "are_members_any() correctly generated error message");

$vers = get_version;
ok($vers, "get_version() returned true value");

__END__
### new ###
#my $lc_s  = List::Compare->new(\@a2, \@a3);
#ok($lc_s, "constructor returned true value");

$LR = $lc_s->is_LsubsetR;
ok(! $LR, "non-subset correctly determined");

$LR = $lc_s->is_AsubsetB;
ok(! $LR, "non-subset correctly determined");

$RL = $lc_s->is_RsubsetL;
ok($RL, "subset correctly determined");

$RL = $lc_s->is_BsubsetA;
ok($RL, "subset correctly determined");

$eqv = $lc_s->is_LequivalentR;
ok(! $eqv, "non-equivalence correctly determined");

$eqv = $lc_s->is_LeqvlntR;
ok(! $eqv, "non-equivalence correctly determined");

$disj = $lc_s->is_LdisjointR;
ok(! $disj, "non-disjoint correctly determined");

### new ###
#my $lc_e  = List::Compare->new(\@a3, \@a4);
#ok($lc_e, "constructor returned true value");

$eqv = $lc_e->is_LequivalentR;
ok($eqv, "equivalence correctly determined");

$eqv = $lc_e->is_LeqvlntR;
ok($eqv, "equivalence correctly determined");

$disj = $lc_e->is_LdisjointR;
ok(! $disj, "non-disjoint correctly determined");

### new ###
#my $lc_dj  = List::Compare->new(\@a4, \@a8);
#ok($lc_dj, "constructor returned true value");

ok(0 == $lc_dj->get_intersection, "no intersection, as expected");
ok(0 == scalar(@{$lc_dj->get_intersection_ref}),
    "no intersection, as expected");
$disj = $lc_dj->is_LdisjointR;
ok($disj, "disjoint correctly determined");

########## BELOW:  Test for bad arguments to constructor ##########

my ($lc_bad);
my %h5 = (
    golfer   => 1,
    lambda   => 0,
);

#eval { $lc_bad = List::Compare->new(\@a0, \%h5) };
#like($@, qr/Must pass all array references or all hash references/,
#    "Got expected error message from bad constructor");
#
#eval { $lc_bad = List::Compare->new(\%h5, \@a0) };
#like($@, qr/Must pass all array references or all hash references/,
#    "Got expected error message from bad constructor");
#
#my $scalar = 'test';
#eval { $lc_bad = List::Compare->new(\$scalar, \@a0) };
#like($@, qr/Must pass all array references or all hash references/,
#    "Got expected error message from bad constructor");
#
#eval { $lc_bad = List::Compare->new(\@a0) };
#like($@, qr/Must pass at least 2 references/,
#    "Got expected error message from bad constructor");
