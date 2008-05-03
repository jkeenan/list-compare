# perl
#$Id$
# 01_simple.t
use Test::More qw(no_plan); # tests => 884;
use List::Compare;
use lib ("./t");
use Test::ListCompareSpecial qw( :seen :wrap );
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

my @a0 = qw(abel abel baker camera delta edward fargo golfer);
my @a1 = qw(baker camera delta delta edward fargo golfer hilton);
my @a2 = qw(fargo golfer hilton icon icon jerky);
my @a3 = qw(fargo golfer hilton icon icon);
my @a4 = qw(fargo fargo golfer hilton icon);
my @a8 = qw(kappa lambda mu);

my $lc    = List::Compare->new(\@a0, \@a1);

ok($lc, "List::Compare constructor returned true value");

@pred = qw(abel baker camera delta edward fargo golfer hilton);
@union = $lc->get_union;
is_deeply( \@union, \@pred, "Got expected union");

$union_ref = $lc->get_union_ref;
is_deeply( $union_ref, \@pred, "Got expected union");

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { @shared = $lc->get_shared; },
        \$stdout,
        \$stderr,
    );
    is_deeply( \@shared, \@pred, "Got expected shared");
    like($stderr, qr/please consider re-coding/,
        "Got expected warning");
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $shared_ref = $lc->get_shared_ref; },
        \$stdout,
        \$stderr,
    );
    is_deeply( $shared_ref, \@pred, "Got expected shared");
    like($stderr, qr/please consider re-coding/,
        "Got expected warning");
}

@pred = qw( baker camera delta edward fargo golfer );
@intersection = $lc->get_intersection;
is_deeply(\@intersection, \@pred, "Got expected intersection");

$intersection_ref = $lc->get_intersection_ref;
is_deeply($intersection_ref, \@pred, "Got expected intersection");

@pred = qw( abel );
@unique = $lc->get_unique;
is_deeply(\@unique, \@pred, "Got expected unique");

$unique_ref = $lc->get_unique_ref;
is_deeply($unique_ref, \@pred, "Got expected unique");

@unique = $lc->get_Lonly;
is_deeply(\@unique, \@pred, "Got expected unique");

$unique_ref = $lc->get_Lonly_ref;
is_deeply($unique_ref, \@pred, "Got expected unique");

@unique = $lc->get_Aonly;
is_deeply(\@unique, \@pred, "Got expected unique");

$unique_ref = $lc->get_Aonly_ref;
is_deeply($unique_ref, \@pred, "Got expected unique");

@pred = qw ( hilton );
@complement = $lc->get_complement;
is_deeply(\@complement, \@pred, "Got expected complement");

$complement_ref = $lc->get_complement_ref;
is_deeply($complement_ref, \@pred, "Got expected complement");

@complement = $lc->get_Ronly;
is_deeply(\@complement, \@pred, "Got expected complement");

$complement_ref = $lc->get_Ronly_ref;
is_deeply($complement_ref, \@pred, "Got expected complement");

@complement = $lc->get_Bonly;
is_deeply(\@complement, \@pred, "Got expected complement");

$complement_ref = $lc->get_Bonly_ref;
is_deeply($complement_ref, \@pred, "Got expected complement");

@pred = qw( abel hilton );
@symmetric_difference = $lc->get_symmetric_difference;
is_deeply(\@symmetric_difference, \@pred, "Got expected symmetric_difference");

$symmetric_difference_ref = $lc->get_symmetric_difference_ref;
is_deeply($symmetric_difference_ref, \@pred, "Got expected symmetric_difference");

@symmetric_difference = $lc->get_symdiff;
is_deeply(\@symmetric_difference, \@pred, "Got expected symmetric_difference");

$symmetric_difference_ref = $lc->get_symdiff_ref;
is_deeply($symmetric_difference_ref, \@pred, "Got expected symmetric_difference");

@symmetric_difference = $lc->get_LorRonly;
is_deeply(\@symmetric_difference, \@pred, "Got expected symmetric_difference");

$symmetric_difference_ref = $lc->get_LorRonly_ref;
is_deeply($symmetric_difference_ref, \@pred, "Got expected symmetric_difference");

@symmetric_difference = $lc->get_AorBonly;
is_deeply(\@symmetric_difference, \@pred, "Got expected symmetric_difference");

$symmetric_difference_ref = $lc->get_AorBonly_ref;
is_deeply($symmetric_difference_ref, \@pred, "Got expected symmetric_difference");

@pred = qw( abel hilton );
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { @nonintersection = $lc->get_nonintersection; },
        \$stdout,
        \$stderr,
    );
    is_deeply( \@nonintersection, \@pred, "Got expected nonintersection");
    like($stderr, qr/please consider re-coding/,
        "Got expected warning");
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $nonintersection_ref = $lc->get_nonintersection_ref; },
        \$stdout,
        \$stderr,
    );
    is_deeply($nonintersection_ref, \@pred, "Got expected nonintersection");
    like($stderr, qr/please consider re-coding/,
        "Got expected warning");
}

@pred = qw( abel abel baker baker camera camera delta delta delta edward
edward fargo fargo golfer golfer hilton );
@bag = $lc->get_bag;
is_deeply(\@bag, \@pred, "Got expected bag");

$bag_ref = $lc->get_bag_ref;
is_deeply($bag_ref, \@pred, "Got expected bag");

$LR = $lc->is_LsubsetR;
ok(! $LR, "Got expected subset relationship");

$LR = $lc->is_AsubsetB;
ok(! $LR, "Got expected subset relationship");

$RL = $lc->is_RsubsetL;
ok(! $RL, "Got expected subset relationship");

$RL = $lc->is_BsubsetA;
ok(! $RL, "Got expected subset relationship");

$eqv = $lc->is_LequivalentR;
ok(! $eqv, "Got expected equivalent relationship");

$eqv = $lc->is_LeqvlntR;
ok(! $eqv, "Got expected equivalent relationship");

$disj = $lc->is_LdisjointR;
ok(! $disj, "Got expected disjoint relationship");

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $rv = $lc->print_subset_chart; },
        \$stdout,
    );
    ok($rv, "print_subset_chart() returned true value");
    like($stdout, qr/Subset Relationships/,
        "Got expected chart header");
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $rv = $lc->print_equivalence_chart; },
        \$stdout,
    );
    ok($rv, "print_equivalence_chart() returned true value");
    like($stdout, qr/Equivalence Relationships/,
        "Got expected chart header");
}
     
ok(wrap_is_member_which(
    $lc,
    {
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
    },
), "is_member_which() returned all expected values");

eval { $memb_arr_ref = $lc->is_member_which('jerky', 'zebra') };
like($@, qr/Method call requires exactly 1 argument \(no references\)/,
        "is_member_which() correctly generated error message");

ok(wrap_is_member_which_ref(
    $lc,
    {
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
    },
), "is_member_which_ref() returned all expected values");

eval { $memb_arr_ref = $lc->is_member_which_ref('jerky', 'zebra') };
like($@, qr/Method call requires exactly 1 argument \(no references\)/,
        "is_member_which_ref() correctly generated error message");

$memb_hash_ref =
    $lc->are_members_which( [ qw|
        abel baker camera delta edward fargo golfer hilton icon jerky zebra
    | ] );
ok(wrap_are_members_which(
    $memb_hash_ref,
    {
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
    },
), "are_members_which() returned all expected value");

#eval { $memb_hash_ref = $lc->are_members_which( { key => 'value' } ) };
#ok(ok_capture_error($@), "are_members_which correctly generated error message");

__END__

ok(wrap_is_member_any(
    $lc,
    {
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
    },
), "is_member_any() returned all expected values");

#eval { $lc->is_member_any('jerky', 'zebra') };
#ok(ok_capture_error($@), "is_member_any() correctly generated error message");

$memb_hash_ref = $lc->are_members_any(
    [ qw| abel baker camera delta edward fargo 
          golfer hilton icon jerky zebra | ] );
ok(wrap_are_members_any(
    $memb_hash_ref,
    {
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
    },
), "are_members_any() returned all expected values");

#eval { $memb_hash_ref = $lc->are_members_any( { key => 'value' } ) };
#ok(ok_capture_error($@), "are_members_any() correctly generated error message");

$vers = $lc->get_version;
ok($vers, "get_version() returned true value");

my $lc_s  = List::Compare->new(\@a2, \@a3);

ok($lc_s, "constructor returned true value");

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

my $lc_e  = List::Compare->new(\@a3, \@a4);

ok($lc_e, "constructor returned true value");

$eqv = $lc_e->is_LequivalentR;
ok($eqv, "equivalence correctly determined");

$eqv = $lc_e->is_LeqvlntR;
ok($eqv, "equivalence correctly determined");

$disj = $lc_e->is_LdisjointR;
ok(! $disj, "non-disjoint correctly determined");

my $lc_dj  = List::Compare->new(\@a4, \@a8);

ok($lc_dj, "constructor returned true value");

ok(0 == $lc_dj->get_intersection, "no intersection, as expected");
ok(0 == scalar(@{$lc_dj->get_intersection_ref}),
    "no intersection, as expected");
$disj = $lc_dj->is_LdisjointR;
ok($disj, "disjoint correctly determined");

########## BELOW:  Tests for '-u' option ##########

my $lcu    = List::Compare->new('-u', \@a0, \@a1);

ok($lcu, "constructor returned true value");

%pred = map {$_, 1} qw( abel baker camera delta edward fargo golfer hilton );
@unpred = qw| icon jerky |;
@union = $lcu->get_union;
$seen{$_}++ foreach (@union);
is_deeply(\%seen, \%pred, "unsorted:  got expected union");
ok(unseen(\%seen, \@unpred),
    "union:  All non-expected elements correctly excluded");
%seen = ();

$union_ref = $lcu->get_union_ref;
$seen{$_}++ foreach (@{$union_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected union");
ok(unseen(\%seen, \@unpred),
    "union:  All non-expected elements correctly excluded");
%seen = ();

%pred = map {$_, 1} qw( abel baker camera delta edward fargo golfer hilton );
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { @shared = $lcu->get_shared; },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@shared);
    is_deeply(\%seen, \%pred, "unsorted:  got expected shared");
    ok(unseen(\%seen, \@unpred),
        "shared:  All non-expected elements correctly excluded");
    like($stderr, qr/please consider re-coding/,
        "Got expected warning");
}
%seen = ();

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $shared_ref = $lcu->get_shared_ref; },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@{$shared_ref});
    is_deeply(\%seen, \%pred, "unsorted:  got expected shared");
    ok(unseen(\%seen, \@unpred),
        "shared:  All non-expected elements correctly excluded");
    like($stderr, qr/please consider re-coding/,
        "Got expected warning");
}
%seen = ();
__END__

%pred = map {$_, 1} qw( baker camera delta edward fargo golfer );
@unpred = qw| abel hilton icon jerky |;
@intersection = $lcu->get_intersection;
$seen{$_}++ foreach (@intersection);
is_deeply(\%seen, \%pred, "unsorted:  got expected intersection");
ok(unseen(\%seen, \@unpred),
    "intersection:  All non-expected elements correctly excluded");
%seen = ();

$intersection_ref = $lcu->get_intersection_ref;
$seen{$_}++ foreach (@{$intersection_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected intersection");
ok(unseen(\%seen, \@unpred),
    "intersection:  All non-expected elements correctly excluded");
%seen = ();

%pred = map {$_, 1} qw( abel );
@unpred = qw| baker camera delta edward fargo golfer hilton icon jerky |;
@unique = $lcu->get_unique;
$seen{$_}++ foreach (@unique);
is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
ok(unseen(\%seen, \@unpred),
    "unique:  All non-expected elements correctly excluded");
%seen = ();

$unique_ref = $lcu->get_unique_ref;
$seen{$_}++ foreach (@{$unique_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
ok(unseen(\%seen, \@unpred),
    "unique:  All non-expected elements correctly excluded");
%seen = ();

@unique = $lcu->get_Lonly;
$seen{$_}++ foreach (@unique);
is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
ok(unseen(\%seen, \@unpred),
    "unique:  All non-expected elements correctly excluded");
%seen = ();

$unique_ref = $lcu->get_Lonly_ref;
$seen{$_}++ foreach (@{$unique_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
ok(unseen(\%seen, \@unpred),
    "unique:  All non-expected elements correctly excluded");
%seen = ();

@unique = $lcu->get_Aonly;
$seen{$_}++ foreach (@unique);
is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
ok(unseen(\%seen, \@unpred),
    "unique:  All non-expected elements correctly excluded");
%seen = ();

$unique_ref = $lcu->get_Aonly_ref;
$seen{$_}++ foreach (@{$unique_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
ok(unseen(\%seen, \@unpred),
    "unique:  All non-expected elements correctly excluded");
%seen = ();

%pred = map {$_, 1} qw( hilton );
@unpred = qw| abel baker camera delta edward fargo golfer icon jerky |;
@complement = $lcu->get_complement;
$seen{$_}++ foreach (@complement);
is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
ok(unseen(\%seen, \@unpred),
    "complement:  All non-expected elements correctly excluded");
%seen = ();

$complement_ref = $lcu->get_complement_ref;
$seen{$_}++ foreach (@{$complement_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
ok(unseen(\%seen, \@unpred),
    "complement:  All non-expected elements correctly excluded");
%seen = ();

@complement = $lcu->get_Ronly;
$seen{$_}++ foreach (@complement);
is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
ok(unseen(\%seen, \@unpred),
    "complement:  All non-expected elements correctly excluded");
%seen = ();

$complement_ref = $lcu->get_Ronly_ref;
$seen{$_}++ foreach (@{$complement_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
ok(unseen(\%seen, \@unpred),
    "complement:  All non-expected elements correctly excluded");
%seen = ();

@complement = $lcu->get_Bonly;
$seen{$_}++ foreach (@complement);
is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
ok(unseen(\%seen, \@unpred),
    "complement:  All non-expected elements correctly excluded");
%seen = ();

$complement_ref = $lcu->get_Bonly_ref;
$seen{$_}++ foreach (@{$complement_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
ok(unseen(\%seen, \@unpred),
    "complement:  All non-expected elements correctly excluded");
%seen = ();

%pred = map {$_, 1} qw( abel hilton );
@unpred = qw| baker camera delta edward fargo golfer icon jerky |;
@symmetric_difference = $lcu->get_symmetric_difference;
$seen{$_}++ foreach (@symmetric_difference);
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

$symmetric_difference_ref = $lcu->get_symmetric_difference_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

@symmetric_difference = $lcu->get_symdiff;
$seen{$_}++ foreach (@symmetric_difference);
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

$symmetric_difference_ref = $lcu->get_symdiff_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

@symmetric_difference = $lcu->get_LorRonly;
$seen{$_}++ foreach (@symmetric_difference);
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

$symmetric_difference_ref = $lcu->get_LorRonly_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

@symmetric_difference = $lcu->get_AorBonly;
$seen{$_}++ foreach (@symmetric_difference);
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

$symmetric_difference_ref = $lcu->get_AorBonly_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

%pred = map {$_, 1} qw( abel hilton );
@unpred = qw| baker camera delta edward fargo golfer icon jerky |;
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { @nonintersection = $lcu->get_nonintersection; },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@nonintersection);
    is_deeply(\%seen, \%pred, "unsorted:  Got expected nonintersection");
    ok(unseen(\%seen, \@unpred),
        "nonintersection:  All non-expected elements correctly excluded");
    like($stderr, qr/please consider re-coding/,
        "Got expected warning");
}
%seen = ();
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $nonintersection_ref = $lcu->get_nonintersection_ref; },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@{$nonintersection_ref});
    is_deeply(\%seen, \%pred, "unsorted:  Got expected nonintersection");
    ok(unseen(\%seen, \@unpred),
        "nonintersection:  All non-expected elements correctly excluded");
    like($stderr, qr/please consider re-coding/,
        "Got expected warning");
}
%seen = ();

%pred = (
    abel    => 2,
    baker   => 2,
    camera  => 2,
    delta   => 3,
    edward  => 2,
    fargo   => 2,
    golfer  => 2,
    hilton  => 1,
);
@unpred = qw| icon jerky |;
@bag = $lcu->get_bag;
$seen{$_}++ foreach (@bag);
is_deeply(\%seen, \%pred, "Got predicted quantities in bag");
ok(unseen(\%seen, \@unpred),
    "bag:  All non-expected elements correctly excluded");
%seen = ();

$bag_ref = $lcu->get_bag_ref;
$seen{$_}++ foreach (@{$bag_ref});
is_deeply(\%seen, \%pred, "Got predicted quantities in bag");
ok(unseen(\%seen, \@unpred),
    "bag:  All non-expected elements correctly excluded");
%seen = ();


$LR = $lcu->is_LsubsetR;
ok(! $LR, "Got expected subset relationship");

$LR = $lcu->is_AsubsetB;
ok(! $LR, "Got expected subset relationship");

$RL = $lcu->is_RsubsetL;
ok(! $RL, "Got expected subset relationship");

$RL = $lcu->is_BsubsetA;
ok(! $RL, "Got expected subset relationship");

$eqv = $lcu->is_LequivalentR;
ok(! $eqv, "Got expected equivalent relationship");

$eqv = $lcu->is_LeqvlntR;
ok(! $eqv, "Got expected equivalent relationship");

$disj = $lcu->is_LdisjointR;
ok(! $disj, "Got expected disjoint relationship");

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $rv = $lcu->print_subset_chart; },
        \$stdout,
    );
    ok($rv, "print_subset_chart() returned true value");
    like($stdout, qr/Subset Relationships/,
        "Got expected chart header");
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $rv = $lcu->print_equivalence_chart; },
        \$stdout,
    );
    ok($rv, "print_equivalence_chart() returned true value");
    like($stdout, qr/Equivalence Relationships/,
        "Got expected chart header");
}
ok(wrap_is_member_which(
    $lcu,
    {
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
    },
), "is_member_which() returned all expected values");

ok(wrap_is_member_which_ref(
    $lcu,
    {
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
    },
), "is_member_which_ref() returned all expected values");

$memb_hash_ref = $lcu->are_members_which(
    [ qw| abel baker camera delta edward fargo 
          golfer hilton icon jerky zebra | ] );
ok(wrap_are_members_which(
    $memb_hash_ref,
    {
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
    },
), "are_members_which() returned all expected value");

ok(wrap_is_member_any(
    $lcu,
    {
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
    },
), "is_member_any() returned all expected values");

$memb_hash_ref = $lcu->are_members_any(
    [ qw| abel baker camera delta edward fargo 
          golfer hilton icon jerky zebra | ] );
ok(wrap_are_members_any(
    $memb_hash_ref,
    {
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
    },
), "are_members_any() returned all expected values");

$vers = $lcu->get_version;
ok($vers, "get_version() returned true value");

my $lcu_s  = List::Compare->new('-u', \@a2, \@a3);

ok($lcu_s, "constructor returned true value");

$LR = $lcu_s->is_LsubsetR;
ok(! $LR, "non-subset correctly determined");

$LR = $lcu_s->is_AsubsetB;
ok(! $LR, "non-subset correctly determined");

$RL = $lcu_s->is_RsubsetL;
ok($RL, "subset correctly determined");

$RL = $lcu_s->is_BsubsetA;
ok($RL, "subset correctly determined");

$eqv = $lcu_s->is_LequivalentR;
ok(! $eqv, "non-equivalence correctly determined");

$eqv = $lcu_s->is_LeqvlntR;
ok(! $eqv, "non-equivalence correctly determined");

$disj = $lcu_s->is_LdisjointR;
ok(! $disj, "non-disjoint correctly determined");

my $lcu_e  = List::Compare->new('-u', \@a3, \@a4);

ok($lcu_e, "constructor returned true value");

$eqv = $lcu_e->is_LequivalentR;
ok($eqv, "Got expected equivalent relationship");

$eqv = $lcu_e->is_LeqvlntR;
ok($eqv, "Got expected equivalent relationship");

$disj = $lcu_e->is_LdisjointR;
ok(! $disj, "Got expected disjoint relationship");

my $lcu_dj  = List::Compare->new('-u', \@a4, \@a8);

ok($lcu_dj, "constructor returned true value");

ok(0 == $lcu_dj->get_intersection, "no intersection, as expected");
ok(0 == scalar(@{$lcu_dj->get_intersection_ref}),
    "no intersection, as expected");
$disj = $lcu_dj->is_LdisjointR;
ok($disj, "disjoint correctly determined");

########## BELOW:  Tests for '--unsorted' option ##########

my $lcun    = List::Compare->new('--unsorted', \@a0, \@a1);
ok($lcun, "constructor returned true value");

my $lcun_s  = List::Compare->new('--unsorted', \@a2, \@a3);
ok($lcun_s, "constructor returned true value");

my $lcun_e  = List::Compare->new('--unsorted', \@a3, \@a4);
ok($lcun_e, "constructor returned true value");

########## BELOW:  Test for bad arguments to constructor ##########

my ($lc_bad);
my %h5 = (
    golfer   => 1,
    lambda   => 0,
);

#eval { $lc_bad = List::Compare->new(\@a0, \%h5) };
#ok(ok_capture_error($@), "error message captured");
#
#eval { $lc_bad = List::Compare->new(\%h5, \@a0) };
#ok(ok_capture_error($@), "error message captured");
#
#my $scalar = 'test';
#eval { $lc_bad = List::Compare->new(\$scalar, \@a0) };
#ok(ok_capture_error($@), "error message captured");
#
#eval { $lc_bad = List::Compare->new(\@a0) };
#ok(ok_capture_error($@), "error message captured");
