# 02_accelerated.t # as of 8/4/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
892;
use lib ("./t");
use List::Compare;
use Test::ListCompareSpecial qw(:seen);

$loaded = 1;
ok($loaded);

######################### End of black magic.

my %seen = ();
my (@unique, @complement, @intersection, @union, @symmetric_difference, @bag);
my ($unique_ref, $complement_ref, $intersection_ref, $union_ref, $symmetric_difference_ref, $bag_ref);
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

my $lca   = List::Compare->new('-a', \@a0, \@a1);
ok($lca);

@union = $lca->get_union;
ok($union[0] eq 'abel');
ok($union[1] eq 'baker');
ok($union[2] eq 'camera');
ok($union[3] eq 'delta');
ok($union[4] eq 'edward');
ok($union[5] eq 'fargo');
ok($union[6] eq 'golfer');
ok($union[-1] eq 'hilton');

$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$union_ref = $lca->get_union_ref;
ok(${$union_ref}[0] eq 'abel');
ok(${$union_ref}[1] eq 'baker');
ok(${$union_ref}[2] eq 'camera');
ok(${$union_ref}[3] eq 'delta');
ok(${$union_ref}[4] eq 'edward');
ok(${$union_ref}[5] eq 'fargo');
ok(${$union_ref}[6] eq 'golfer');
ok(${$union_ref}[-1] eq 'hilton');

$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @shared = $lca->get_shared;
}
ok($shared[0] eq 'abel');
ok($shared[1] eq 'baker');
ok($shared[2] eq 'camera');
ok($shared[3] eq 'delta');
ok($shared[4] eq 'edward');
ok($shared[5] eq 'fargo');
ok($shared[6] eq 'golfer');
ok($shared[-1] eq 'hilton');

$seen{$_}++ foreach (@shared);
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $shared_ref = $lca->get_shared_ref;
}
ok(${$shared_ref}[0] eq 'abel');
ok(${$shared_ref}[1] eq 'baker');
ok(${$shared_ref}[2] eq 'camera');
ok(${$shared_ref}[3] eq 'delta');
ok(${$shared_ref}[4] eq 'edward');
ok(${$shared_ref}[5] eq 'fargo');
ok(${$shared_ref}[6] eq 'golfer');
ok(${$shared_ref}[-1] eq 'hilton');

$seen{$_}++ foreach (@{$shared_ref});
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@intersection = $lca->get_intersection;
ok($intersection[0] eq 'baker');
ok($intersection[1] eq 'camera');
ok($intersection[2] eq 'delta');
ok($intersection[3] eq 'edward');
ok($intersection[4] eq 'fargo');
ok($intersection[-1] eq 'golfer');

$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$intersection_ref = $lca->get_intersection_ref;
ok(${$intersection_ref}[0] eq 'baker');
ok(${$intersection_ref}[1] eq 'camera');
ok(${$intersection_ref}[2] eq 'delta');
ok(${$intersection_ref}[3] eq 'edward');
ok(${$intersection_ref}[4] eq 'fargo');
ok(${$intersection_ref}[-1] eq 'golfer');

$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@unique = $lca->get_unique;
ok($unique[-1] eq 'abel');

$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$unique_ref = $lca->get_unique_ref;
ok(${$unique_ref}[-1] eq 'abel');

$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@unique = $lca->get_Lonly;
ok($unique[-1] eq 'abel');

$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$unique_ref = $lca->get_Lonly_ref;
ok(${$unique_ref}[-1] eq 'abel');

$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@unique = $lca->get_Aonly;
ok($unique[-1] eq 'abel');

$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$unique_ref = $lca->get_Aonly_ref;
ok(${$unique_ref}[-1] eq 'abel');

$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@complement = $lca->get_complement;
ok($complement[-1] eq 'hilton');

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$complement_ref = $lca->get_complement_ref;
ok(${$complement_ref}[-1] eq 'hilton');

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@complement = $lca->get_Ronly;
ok($complement[-1] eq 'hilton');

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$complement_ref = $lca->get_Ronly_ref;
ok(${$complement_ref}[-1] eq 'hilton');

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@complement = $lca->get_Bonly;
ok($complement[-1] eq 'hilton');

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$complement_ref = $lca->get_Bonly_ref;
ok(${$complement_ref}[-1] eq 'hilton');

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@symmetric_difference = $lca->get_symmetric_difference;
ok($symmetric_difference[0] eq 'abel');
ok($symmetric_difference[-1] eq 'hilton');

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$symmetric_difference_ref = $lca->get_symmetric_difference_ref;
ok(${$symmetric_difference_ref}[0] eq 'abel');
ok(${$symmetric_difference_ref}[-1] eq 'hilton');

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@symmetric_difference = $lca->get_symdiff;
ok($symmetric_difference[0] eq 'abel');
ok($symmetric_difference[-1] eq 'hilton');

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$symmetric_difference_ref = $lca->get_symdiff_ref;
ok(${$symmetric_difference_ref}[0] eq 'abel');
ok(${$symmetric_difference_ref}[-1] eq 'hilton');

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@symmetric_difference = $lca->get_LorRonly;
ok(${$symmetric_difference_ref}[0] eq 'abel');
ok(${$symmetric_difference_ref}[-1] eq 'hilton');

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$symmetric_difference_ref = $lca->get_LorRonly_ref;
ok(${$symmetric_difference_ref}[0] eq 'abel');
ok(${$symmetric_difference_ref}[-1] eq 'hilton');

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@symmetric_difference = $lca->get_AorBonly;
ok($symmetric_difference[0] eq 'abel');
ok($symmetric_difference[-1] eq 'hilton');

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$symmetric_difference_ref = $lca->get_AorBonly_ref;
ok(${$symmetric_difference_ref}[0] eq 'abel');
ok(${$symmetric_difference_ref}[-1] eq 'hilton');

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @nonintersection = $lca->get_nonintersection;
}
ok($nonintersection[0] eq 'abel');
ok($nonintersection[-1] eq 'hilton');

$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $nonintersection_ref = $lca->get_nonintersection_ref;
}
ok(${$nonintersection_ref}[0] eq 'abel');
ok(${$nonintersection_ref}[-1] eq 'hilton');

$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@bag = $lca->get_bag;
ok($bag[0] eq 'abel');
ok($bag[1] eq 'abel');
ok($bag[2] eq 'baker');
ok($bag[3] eq 'baker');
ok($bag[4] eq 'camera');
ok($bag[5] eq 'camera');
ok($bag[6] eq 'delta');
ok($bag[7] eq 'delta');
ok($bag[8] eq 'delta');
ok($bag[9] eq 'edward');
ok($bag[10] eq 'edward');
ok($bag[11] eq 'fargo');
ok($bag[12] eq 'fargo');
ok($bag[13] eq 'golfer');
ok($bag[14] eq 'golfer');
ok($bag[-1] eq 'hilton');

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

$bag_ref = $lca->get_bag_ref;
ok(${$bag_ref}[0] eq 'abel');
ok(${$bag_ref}[1] eq 'abel');
ok(${$bag_ref}[2] eq 'baker');
ok(${$bag_ref}[3] eq 'baker');
ok(${$bag_ref}[4] eq 'camera');
ok(${$bag_ref}[5] eq 'camera');
ok(${$bag_ref}[6] eq 'delta');
ok(${$bag_ref}[7] eq 'delta');
ok(${$bag_ref}[8] eq 'delta');
ok(${$bag_ref}[9] eq 'edward');
ok(${$bag_ref}[10] eq 'edward');
ok(${$bag_ref}[11] eq 'fargo');
ok(${$bag_ref}[12] eq 'fargo');
ok(${$bag_ref}[13] eq 'golfer');
ok(${$bag_ref}[14] eq 'golfer');
ok(${$bag_ref}[-1] eq 'hilton');

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

$LR = $lca->is_LsubsetR;
ok(! $LR);

$LR = $lca->is_AsubsetB;
ok(! $LR);

$RL = $lca->is_RsubsetL;
ok(! $RL);

$RL = $lca->is_BsubsetA;
ok(! $RL);

$eqv = $lca->is_LequivalentR;
ok(! $eqv);

$eqv = $lca->is_LeqvlntR;
ok(! $eqv);

$disj = $lca->is_LdisjointR;
ok(! $disj);

$return = $lca->print_subset_chart;
ok($return);

$return = $lca->print_equivalence_chart;
ok($return);

@memb_arr = $lca->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0   > ] ));

@memb_arr = $lca->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1 > ] ));

@memb_arr = $lca->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1 > ] ));

@memb_arr = $lca->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1 > ] ));

@memb_arr = $lca->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1 > ] ));

@memb_arr = $lca->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  2, [ qw< 0 1 > ] ));

@memb_arr = $lca->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 2, [ qw< 0 1 > ] ));

@memb_arr = $lca->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 1, [ qw<   1 > ] ));

@memb_arr = $lca->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   0, [ qw<     > ] ));

@memb_arr = $lca->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  0, [ qw<     > ] ));

@memb_arr = $lca->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<     > ] ));

$memb_arr_ref = $lca->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0   > ] ));

$memb_arr_ref = $lca->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lca->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lca->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lca->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lca->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lca->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lca->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 1, [ qw<   1 > ] ));

$memb_arr_ref = $lca->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   0, [ qw<     > ] ));

$memb_arr_ref = $lca->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  0, [ qw<     > ] ));

$memb_arr_ref = $lca->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<     > ] ));

eval { $memb_arr_ref = $lca->is_member_which_ref('jerky', 'zebra') };
ok(ok_capture_error($@));


$memb_hash_ref = $lca->are_members_which(
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

eval { $memb_hash_ref = $lca->are_members_which( { key => 'value' } ) };
ok(ok_capture_error($@));


ok($lca->is_member_any('abel'));
ok($lca->is_member_any('baker'));
ok($lca->is_member_any('camera'));
ok($lca->is_member_any('delta'));
ok($lca->is_member_any('edward'));
ok($lca->is_member_any('fargo'));
ok($lca->is_member_any('golfer'));
ok($lca->is_member_any('hilton'));
ok(! $lca->is_member_any('icon' ));
ok(! $lca->is_member_any('jerky'));
ok(! $lca->is_member_any('zebra'));

eval { $lca->is_member_any('jerky', 'zebra') };
ok(ok_capture_error($@));


$memb_hash_ref = $lca->are_members_any(
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

eval { $memb_hash_ref = $lca->are_members_any( { key => 'value' } ) };
ok(ok_capture_error($@));

$vers = $lca->get_version;
ok($vers);

my $lca_s  = List::Compare->new('-a', \@a2, \@a3);
ok($lca_s);

$LR = $lca_s->is_LsubsetR;
ok(! $LR);

$LR = $lca_s->is_AsubsetB;
ok(! $LR);

$RL = $lca_s->is_RsubsetL;
ok($RL);

$RL = $lca_s->is_BsubsetA;
ok($RL);

$eqv = $lca_s->is_LequivalentR;
ok(! $eqv);

$eqv = $lca_s->is_LeqvlntR;
ok(! $eqv);

$disj = $lca_s->is_LdisjointR;
ok(! $disj);

my $lca_e  = List::Compare->new('-a', \@a3, \@a4);
ok($lca_e);

$eqv = $lca_e->is_LequivalentR;
ok($eqv);

$eqv = $lca_e->is_LeqvlntR;
ok($eqv);

$disj = $lca_e->is_LdisjointR;
ok(! $disj);

my $lca_dj  = List::Compare->new('-a', \@a4, \@a8);

ok($lca_dj);

ok(0 == $lca_dj->get_intersection);
ok(0 == scalar(@{$lca_dj->get_intersection_ref}));
$disj = $lca_dj->is_LdisjointR;
ok($disj);

########## BELOW:  Tests for '--accelerated' option ##########

my $lcacc   = List::Compare->new('--accelerated', \@a0, \@a1);
ok($lcacc);

my $lcacc_s  = List::Compare->new('--accelerated', \@a2, \@a3);
ok($lcacc_s);

my $lcacc_e  = List::Compare->new('--accelerated', \@a3, \@a4);
ok($lcacc_e);

########## BELOW:  Tests for '-u' option ##########

my $lcau   = List::Compare->new('-u', '-a', \@a0, \@a1);
ok($lcau);

@union = $lcau->get_union;
$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$union_ref = $lcau->get_union_ref;
$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @shared = $lcau->get_shared;
}
$seen{$_}++ foreach (@shared);
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $shared_ref = $lcau->get_shared_ref;
}
$seen{$_}++ foreach (@{$shared_ref});
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@intersection = $lcau->get_intersection;
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$intersection_ref = $lcau->get_intersection_ref;
$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@unique = $lcau->get_unique;
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$unique_ref = $lcau->get_unique_ref;
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@unique = $lcau->get_Lonly;
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$unique_ref = $lcau->get_Lonly_ref;
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@unique = $lcau->get_Aonly;
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$unique_ref = $lcau->get_Aonly_ref;
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@complement = $lcau->get_complement;
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$complement_ref = $lcau->get_complement_ref;
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@complement = $lcau->get_Ronly;
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$complement_ref = $lcau->get_Ronly_ref;
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@complement = $lcau->get_Bonly;
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$complement_ref = $lcau->get_Bonly_ref;
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@symmetric_difference = $lcau->get_symmetric_difference;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$symmetric_difference_ref = $lcau->get_symmetric_difference_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@symmetric_difference = $lcau->get_symdiff;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$symmetric_difference_ref = $lcau->get_symdiff_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@symmetric_difference = $lcau->get_LorRonly;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$symmetric_difference_ref = $lcau->get_LorRonly_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@symmetric_difference = $lcau->get_AorBonly;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$symmetric_difference_ref = $lcau->get_AorBonly_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @nonintersection = $lcau->get_nonintersection;
}
$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $nonintersection_ref = $lcau->get_nonintersection_ref;
}
$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@bag = $lcau->get_bag;
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

$bag_ref = $lcau->get_bag_ref;
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

$LR = $lcau->is_LsubsetR;
ok(! $LR);

$LR = $lcau->is_AsubsetB;
ok(! $LR);

$RL = $lcau->is_RsubsetL;
ok(! $RL);

$RL = $lcau->is_BsubsetA;
ok(! $RL);

$eqv = $lcau->is_LequivalentR;
ok(! $eqv);

$eqv = $lcau->is_LeqvlntR;
ok(! $eqv);

$disj = $lcau->is_LdisjointR;
ok(! $disj);

$return = $lcau->print_subset_chart;
ok($return);

$return = $lcau->print_equivalence_chart;
ok($return);

@memb_arr = $lcau->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0   > ] ));

@memb_arr = $lcau->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1 > ] ));

@memb_arr = $lcau->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1 > ] ));

@memb_arr = $lcau->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1 > ] ));

@memb_arr = $lcau->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1 > ] ));

@memb_arr = $lcau->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  2, [ qw< 0 1 > ] ));

@memb_arr = $lcau->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 2, [ qw< 0 1 > ] ));

@memb_arr = $lcau->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 1, [ qw<   1 > ] ));

@memb_arr = $lcau->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   0, [ qw<     > ] ));

@memb_arr = $lcau->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  0, [ qw<     > ] ));

@memb_arr = $lcau->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<     > ] ));

$memb_arr_ref = $lcau->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0   > ] ));

$memb_arr_ref = $lcau->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcau->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcau->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcau->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcau->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcau->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcau->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 1, [ qw<   1 > ] ));

$memb_arr_ref = $lcau->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   0, [ qw<     > ] ));

$memb_arr_ref = $lcau->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  0, [ qw<     > ] ));

$memb_arr_ref = $lcau->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<     > ] ));

$memb_hash_ref = $lcau->are_members_which(
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

ok($lcau->is_member_any('abel'));
ok($lcau->is_member_any('baker'));
ok($lcau->is_member_any('camera'));
ok($lcau->is_member_any('delta'));
ok($lcau->is_member_any('edward'));
ok($lcau->is_member_any('fargo'));
ok($lcau->is_member_any('golfer'));
ok($lcau->is_member_any('hilton'));
ok(! $lcau->is_member_any('icon' ));
ok(! $lcau->is_member_any('jerky'));
ok(! $lcau->is_member_any('zebra'));

$memb_hash_ref = $lcau->are_members_any(
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

$vers = $lcau->get_version;
ok($vers);

my $lcau_s  = List::Compare->new('-u', '-a', \@a2, \@a3);
ok($lcau_s);

$LR = $lcau_s->is_LsubsetR;
ok(! $LR);

$LR = $lcau_s->is_AsubsetB;
ok(! $LR);

$RL = $lcau_s->is_RsubsetL;
ok($RL);

$RL = $lcau_s->is_BsubsetA;
ok($RL);

$eqv = $lcau_s->is_LequivalentR;
ok(! $eqv);

$eqv = $lcau_s->is_LeqvlntR;
ok(! $eqv);

$disj = $lcau_s->is_LdisjointR;
ok(! $disj);

my $lcau_e  = List::Compare->new('-u', '-a', \@a3, \@a4);
ok($lcau_e);

$eqv = $lcau_e->is_LequivalentR;
ok($eqv);

$eqv = $lcau_e->is_LeqvlntR;
ok($eqv);

$disj = $lcau_e->is_LdisjointR;
ok(! $disj);

my $lcau_dj  = List::Compare->new('-u', \@a4, \@a8);

ok($lcau_dj);

ok(0 == $lcau_dj->get_intersection);
ok(0 == scalar(@{$lcau_dj->get_intersection_ref}));
$disj = $lcau_dj->is_LdisjointR;
ok($disj);

########## BELOW:  Tests for '--unsorted' and '--accelerated' options ##########

my $lcaun   = List::Compare->new('--unsorted', '-a', \@a0, \@a1);
ok($lcaun);

my $lcaun_s  = List::Compare->new('--unsorted', '-a', \@a2, \@a3);
ok($lcaun_s);

my $lcaun_e  = List::Compare->new('--unsorted', '-a', \@a3, \@a4);
ok($lcaun_e);

my $lcaccun   = List::Compare->new('--unsorted', '--accelerated', \@a0, \@a1);
ok($lcaccun);

my $lcaccun_s  = List::Compare->new('--unsorted', '--accelerated', \@a2, \@a3);
ok($lcaccun_s);

my $lcaccun_e  = List::Compare->new('--unsorted', '--accelerated', \@a3, \@a4);
ok($lcaccun_e);

my $lcaccu   = List::Compare->new('-u', '--accelerated', \@a0, \@a1);
ok($lcaccu);

my $lcaccu_s  = List::Compare->new('-u', '--accelerated', \@a2, \@a3);
ok($lcaccu_s);

my $lcaccu_e  = List::Compare->new('-u', '--accelerated', \@a3, \@a4);
ok($lcaccu_e);

########## BELOW:  Test for bad arguments to constructor ##########

my ($lca_bad);
my %h5 = (
    golfer   => 1,
    lambda   => 0,
);

eval { $lca_bad = List::Compare->new('-a', \@a0, \%h5) };
ok(ok_capture_error($@));

eval { $lca_bad = List::Compare->new('-a', \%h5, \@a0) };
ok(ok_capture_error($@));

my $scalar = 'test';
eval { $lca_bad = List::Compare->new('-a', \$scalar, \@a0) };
ok(ok_capture_error($@));






