# perl
#$Id$
# 01_simple.t
use Test::More qw(no_plan); # tests => 884;
use List::Compare;
use lib ("./t");
use Test::ListCompareSpecial qw(:seen);

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
    local $SIG{__WARN__} = \&_capture;
    @shared = $lc->get_shared;
}
is_deeply( \@shared, \@pred, "Got expected shared");

{
    local $SIG{__WARN__} = \&_capture;
    $shared_ref = $lc->get_shared_ref;
}
is_deeply( $shared_ref, \@pred, "Got expected shared");

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
    local $SIG{__WARN__} = \&_capture;
    @nonintersection = $lc->get_nonintersection;
}
is_deeply(\@nonintersection, \@pred, "Got expected nonintersection");

{
    local $SIG{__WARN__} = \&_capture;
    $nonintersection_ref = $lc->get_nonintersection_ref;
}
is_deeply($nonintersection_ref, \@pred, "Got expected nonintersection");

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

ok( $lc->print_subset_chart, "print_subset_chart() returned true value");
ok( $lc->print_equivalence_chart, "print_equivalence_chart() returned true value");

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
ok(ok_capture_error($@), "is_member_which() correctly generated error message");

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
ok(ok_capture_error($@), "is_member_which_ref() correctly generated error message");


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

eval { $memb_hash_ref = $lc->are_members_which( { key => 'value' } ) };
ok(ok_capture_error($@), "are_members_which correctly generated error message");

foreach my $v ( qw| abel baker camera delta edward fargo golfer hilton | ) {
    ok($lc->is_member_any( $v ), "is_member_any() returned expected value");
}

foreach my $v ( qw| icon jerky zebra | ) {
    ok(! $lc->is_member_any( $v ), "is_member_any() returned expected value");
}

eval { $lc->is_member_any('jerky', 'zebra') };
ok(ok_capture_error($@), "is_member_any() correctly generated error message");

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

eval { $memb_hash_ref = $lc->are_members_any( { key => 'value' } ) };
ok(ok_capture_error($@), "are_members_any() correctly generated error message");

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
    local $SIG{__WARN__} = \&_capture;
    @shared = $lcu->get_shared;
}
$seen{$_}++ foreach (@shared);
is_deeply(\%seen, \%pred, "unsorted:  got expected shared");
ok(unseen(\%seen, \@unpred),
    "union:  All non-expected elements correctly excluded");
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $shared_ref = $lcu->get_shared_ref;
}
$seen{$_}++ foreach (@{$shared_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected shared");
ok(unseen(\%seen, \@unpred),
    "union:  All non-expected elements correctly excluded");
%seen = ();

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
    local $SIG{__WARN__} = \&_capture;
    @nonintersection = $lcu->get_nonintersection;
}
$seen{$_}++ foreach (@nonintersection);
is_deeply(\%seen, \%pred, "unsorted:  Got expected nonintersection");
ok(unseen(\%seen, \@unpred),
    "nonintersection:  All non-expected elements correctly excluded");
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $nonintersection_ref = $lcu->get_nonintersection_ref;
}
$seen{$_}++ foreach (@{$nonintersection_ref});
is_deeply(\%seen, \%pred, "unsorted:  Got expected nonintersection");
ok(unseen(\%seen, \@unpred),
    "nonintersection:  All non-expected elements correctly excluded");
%seen = ();

__END__

@bag = $lcu->get_bag;
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);
ok($seen{'baker'} == 2);
ok($seen{'camera'} == 2);
ok($seen{'delta'} == 3);
ok($seen{'edward'} == 2);
ok($seen{'fargo'} == 2);
ok($seen{'golfer'} == 2);
ok($seen{'hilton'} == 1);
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$bag_ref = $lcu->get_bag_ref;
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);
ok($seen{'baker'} == 2);
ok($seen{'camera'} == 2);
ok($seen{'delta'} == 3);
ok($seen{'edward'} == 2);
ok($seen{'fargo'} == 2);
ok($seen{'golfer'} == 2);
ok($seen{'hilton'} == 1);
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$LR = $lcu->is_LsubsetR;
ok(! $LR);

$LR = $lcu->is_AsubsetB;
ok(! $LR);

$RL = $lcu->is_RsubsetL;
ok(! $RL);

$RL = $lcu->is_BsubsetA;
ok(! $RL);

$eqv = $lcu->is_LequivalentR;
ok(! $eqv);

$eqv = $lcu->is_LeqvlntR;
ok(! $eqv);

$disj = $lcu->is_LdisjointR;
ok(! $disj);

$return = $lcu->print_subset_chart;
ok($return);

$return = $lcu->print_equivalence_chart;
ok($return);

@memb_arr = $lcu->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0   > ] ));

@memb_arr = $lcu->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1 > ] ));

@memb_arr = $lcu->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1 > ] ));

@memb_arr = $lcu->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1 > ] ));

@memb_arr = $lcu->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1 > ] ));

@memb_arr = $lcu->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  2, [ qw< 0 1 > ] ));

@memb_arr = $lcu->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 2, [ qw< 0 1 > ] ));

@memb_arr = $lcu->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 1, [ qw<   1 > ] ));

@memb_arr = $lcu->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   0, [ qw<     > ] ));

@memb_arr = $lcu->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  0, [ qw<     > ] ));

@memb_arr = $lcu->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<     > ] ));

$memb_arr_ref = $lcu->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0   > ] ));

$memb_arr_ref = $lcu->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcu->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcu->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcu->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcu->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcu->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcu->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 1, [ qw<   1 > ] ));

$memb_arr_ref = $lcu->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   0, [ qw<     > ] ));

$memb_arr_ref = $lcu->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  0, [ qw<     > ] ));

$memb_arr_ref = $lcu->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<     > ] ));

$memb_hash_ref = $lcu->are_members_which(
    [ qw| abel baker camera delta edward fargo 
          golfer hilton icon jerky zebra | ] );
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0   > ] ));
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'fargo',  2, [ qw< 0 1 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'golfer', 2, [ qw< 0 1 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'hilton', 1, [ qw<   1 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'icon',   0, [ qw<     > ] ));
ok(ok_seen_h( $memb_hash_ref, 'jerky',  0, [ qw<     > ] ));
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<     > ] ));

ok($lcu->is_member_any('abel'));
ok($lcu->is_member_any('baker'));
ok($lcu->is_member_any('camera'));
ok($lcu->is_member_any('delta'));
ok($lcu->is_member_any('edward'));
ok($lcu->is_member_any('fargo'));
ok($lcu->is_member_any('golfer'));
ok($lcu->is_member_any('hilton'));
ok(! $lcu->is_member_any('icon' ));
ok(! $lcu->is_member_any('jerky'));
ok(! $lcu->is_member_any('zebra'));

$memb_hash_ref = $lcu->are_members_any(
    [ qw| abel baker camera delta edward fargo 
          golfer hilton icon jerky zebra | ] );

ok(ok_any_h( $memb_hash_ref, 'abel',   1 ));
ok(ok_any_h( $memb_hash_ref, 'baker',  1 ));
ok(ok_any_h( $memb_hash_ref, 'camera', 1 ));
ok(ok_any_h( $memb_hash_ref, 'delta',  1 ));
ok(ok_any_h( $memb_hash_ref, 'edward', 1 ));
ok(ok_any_h( $memb_hash_ref, 'fargo',  1 ));
ok(ok_any_h( $memb_hash_ref, 'golfer', 1 ));
ok(ok_any_h( $memb_hash_ref, 'hilton', 1 ));
ok(ok_any_h( $memb_hash_ref, 'icon',   0 ));
ok(ok_any_h( $memb_hash_ref, 'jerky',  0 ));
ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));

$vers = $lcu->get_version;
ok($vers);

my $lcu_s  = List::Compare->new('-u', \@a2, \@a3);

ok($lcu_s);

$LR = $lcu_s->is_LsubsetR;
ok(! $LR);

$LR = $lcu_s->is_AsubsetB;
ok(! $LR);

$RL = $lcu_s->is_RsubsetL;
ok($RL);

$RL = $lcu_s->is_BsubsetA;
ok($RL);

$eqv = $lcu_s->is_LequivalentR;
ok(! $eqv);

$eqv = $lcu_s->is_LeqvlntR;
ok(! $eqv);

$disj = $lcu_s->is_LdisjointR;
ok(! $disj);

my $lcu_e  = List::Compare->new('-u', \@a3, \@a4);

ok($lcu_e);

$eqv = $lcu_e->is_LequivalentR;
ok($eqv);

$eqv = $lcu_e->is_LeqvlntR;
ok($eqv);

$disj = $lcu_e->is_LdisjointR;
ok(! $disj);

my $lcu_dj  = List::Compare->new('-u', \@a4, \@a8);

ok($lcu_dj);

ok(0 == $lcu_dj->get_intersection);
ok(0 == scalar(@{$lcu_dj->get_intersection_ref}));
$disj = $lcu_dj->is_LdisjointR;
ok($disj);

########## BELOW:  Tests for '--unsorted' option ##########

my $lcun    = List::Compare->new('--unsorted', \@a0, \@a1);
ok($lcun);

my $lcun_s  = List::Compare->new('--unsorted', \@a2, \@a3);
ok($lcun_s);

my $lcun_e  = List::Compare->new('--unsorted', \@a3, \@a4);
ok($lcun_e);

########## BELOW:  Test for bad arguments to constructor ##########

my ($lc_bad);
my %h5 = (
    golfer   => 1,
    lambda   => 0,
);

eval { $lc_bad = List::Compare->new(\@a0, \%h5) };
ok(ok_capture_error($@));

eval { $lc_bad = List::Compare->new(\%h5, \@a0) };
ok(ok_capture_error($@));

my $scalar = 'test';
eval { $lc_bad = List::Compare->new(\$scalar, \@a0) };
ok(ok_capture_error($@));

eval { $lc_bad = List::Compare->new(\@a0) };
ok(ok_capture_error($@));

__END__

