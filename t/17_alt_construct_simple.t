# 17_alt_construct_simple.t # as of 8/4/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
876;
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

my $lc    = List::Compare->new( { lists => [ \@a0, \@a1 ] } );

ok($lc);

@union = $lc->get_union;
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

$union_ref = $lc->get_union_ref;
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
    @shared = $lc->get_shared;
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
    $shared_ref = $lc->get_shared_ref;
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

@intersection = $lc->get_intersection;
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

$intersection_ref = $lc->get_intersection_ref;
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

@unique = $lc->get_unique;
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

$unique_ref = $lc->get_unique_ref;
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

@unique = $lc->get_Lonly;
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

$unique_ref = $lc->get_Lonly_ref;
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

@unique = $lc->get_Aonly;
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

$unique_ref = $lc->get_Aonly_ref;
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

@complement = $lc->get_complement;
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

$complement_ref = $lc->get_complement_ref;
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

@complement = $lc->get_Ronly;
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

$complement_ref = $lc->get_Ronly_ref;
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

@complement = $lc->get_Bonly;
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

$complement_ref = $lc->get_Bonly_ref;
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

@symmetric_difference = $lc->get_symmetric_difference;
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

$symmetric_difference_ref = $lc->get_symmetric_difference_ref;
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

@symmetric_difference = $lc->get_symdiff;
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

$symmetric_difference_ref = $lc->get_symdiff_ref;
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

@symmetric_difference = $lc->get_LorRonly;
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

$symmetric_difference_ref = $lc->get_LorRonly_ref;
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

@symmetric_difference = $lc->get_AorBonly;
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

$symmetric_difference_ref = $lc->get_AorBonly_ref;
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
    @nonintersection = $lc->get_nonintersection;
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
    $nonintersection_ref = $lc->get_nonintersection_ref;
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

@bag = $lc->get_bag;
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

$bag_ref = $lc->get_bag_ref;
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

$LR = $lc->is_LsubsetR;
ok(! $LR);

$LR = $lc->is_AsubsetB;
ok(! $LR);

$RL = $lc->is_RsubsetL;
ok(! $RL);

$RL = $lc->is_BsubsetA;
ok(! $RL);

$eqv = $lc->is_LequivalentR;
ok(! $eqv);

$eqv = $lc->is_LeqvlntR;
ok(! $eqv);

$disj = $lc->is_LdisjointR;
ok(! $disj);

$return = $lc->print_subset_chart;
ok($return);

$return = $lc->print_equivalence_chart;
ok($return);

@memb_arr = $lc->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0   > ] ));

@memb_arr = $lc->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1 > ] ));

@memb_arr = $lc->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1 > ] ));

@memb_arr = $lc->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1 > ] ));

@memb_arr = $lc->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1 > ] ));

@memb_arr = $lc->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  2, [ qw< 0 1 > ] ));

@memb_arr = $lc->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 2, [ qw< 0 1 > ] ));

@memb_arr = $lc->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 1, [ qw<   1 > ] ));

@memb_arr = $lc->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   0, [ qw<     > ] ));

@memb_arr = $lc->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  0, [ qw<     > ] ));

@memb_arr = $lc->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<     > ] ));



$memb_arr_ref = $lc->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0   > ] ));

$memb_arr_ref = $lc->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lc->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lc->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lc->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lc->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lc->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lc->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 1, [ qw<   1 > ] ));

$memb_arr_ref = $lc->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   0, [ qw<     > ] ));

$memb_arr_ref = $lc->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  0, [ qw<     > ] ));

$memb_arr_ref = $lc->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<     > ] ));


$memb_hash_ref = $lc->are_members_which( [ qw| abel baker camera delta edward fargo 
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

ok($lc->is_member_any('abel'));
ok($lc->is_member_any('baker'));
ok($lc->is_member_any('camera'));
ok($lc->is_member_any('delta'));
ok($lc->is_member_any('edward'));
ok($lc->is_member_any('fargo'));
ok($lc->is_member_any('golfer'));
ok($lc->is_member_any('hilton'));
ok(! $lc->is_member_any('icon' ));
ok(! $lc->is_member_any('jerky'));
ok(! $lc->is_member_any('zebra'));


$memb_hash_ref = $lc->are_members_any( [ qw| abel baker camera delta edward fargo 
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

$vers = $lc->get_version;
ok($vers);

my $lc_s  = List::Compare->new( { lists => [ \@a2, \@a3 ] } );

ok($lc_s);

$LR = $lc_s->is_LsubsetR;
ok(! $LR);

$LR = $lc_s->is_AsubsetB;
ok(! $LR);

$RL = $lc_s->is_RsubsetL;
ok($RL);

$RL = $lc_s->is_BsubsetA;
ok($RL);

$eqv = $lc_s->is_LequivalentR;
ok(! $eqv);

$eqv = $lc_s->is_LeqvlntR;
ok(! $eqv);

$disj = $lc_s->is_LdisjointR;
ok(! $disj);

my $lc_e  = List::Compare->new( { lists => [ \@a3, \@a4 ] } );

ok($lc_e);

$eqv = $lc_e->is_LequivalentR;
ok($eqv);

$eqv = $lc_e->is_LeqvlntR;
ok($eqv);

$disj = $lc_e->is_LdisjointR;
ok(! $disj);

my $lc_dj  = List::Compare->new( { lists => [ \@a4, \@a8 ] } );

ok($lc_dj);

ok(0 == $lc_dj->get_intersection);
ok(0 == scalar(@{$lc_dj->get_intersection_ref}));
$disj = $lc_dj->is_LdisjointR;
ok($disj);

########## BELOW:  Tests for '-u' option ##########

my $lcu    = List::Compare->new( { unsorted => 1, lists => [ \@a0, \@a1 ] } );

ok($lcu);

@union = $lcu->get_union;
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

$union_ref = $lcu->get_union_ref;
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
    @shared = $lcu->get_shared;
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
    $shared_ref = $lcu->get_shared_ref;
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

@intersection = $lcu->get_intersection;
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

$intersection_ref = $lcu->get_intersection_ref;
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

@unique = $lcu->get_unique;
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

$unique_ref = $lcu->get_unique_ref;
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

@unique = $lcu->get_Lonly;
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

$unique_ref = $lcu->get_Lonly_ref;
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

@unique = $lcu->get_Aonly;
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

$unique_ref = $lcu->get_Aonly_ref;
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

@complement = $lcu->get_complement;
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

$complement_ref = $lcu->get_complement_ref;
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

@complement = $lcu->get_Ronly;
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

$complement_ref = $lcu->get_Ronly_ref;
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

@complement = $lcu->get_Bonly;
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

$complement_ref = $lcu->get_Bonly_ref;
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

@symmetric_difference = $lcu->get_symmetric_difference;
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

$symmetric_difference_ref = $lcu->get_symmetric_difference_ref;
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

@symmetric_difference = $lcu->get_symdiff;
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

$symmetric_difference_ref = $lcu->get_symdiff_ref;
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

@symmetric_difference = $lcu->get_LorRonly;
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

$symmetric_difference_ref = $lcu->get_LorRonly_ref;
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

@symmetric_difference = $lcu->get_AorBonly;
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

$symmetric_difference_ref = $lcu->get_AorBonly_ref;
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
    @nonintersection = $lcu->get_nonintersection;
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
    $nonintersection_ref = $lcu->get_nonintersection_ref;
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

my $lcu_s  = List::Compare->new( { unsorted => 1, lists => [ \@a2, \@a3 ] } );

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

my $lcu_e  = List::Compare->new( { unsorted => 1, lists => [ \@a3, \@a4 ] } );

ok($lcu_e);

$eqv = $lcu_e->is_LequivalentR;
ok($eqv);

$eqv = $lcu_e->is_LeqvlntR;
ok($eqv);

$disj = $lcu_e->is_LdisjointR;
ok(! $disj);

my $lcu_dj  = List::Compare->new( { unsorted => 1, lists => [ \@a4, \@a8 ] } );

ok($lcu_dj);

ok(0 == $lcu_dj->get_intersection);
ok(0 == scalar(@{$lcu_dj->get_intersection_ref}));
$disj = $lcu_dj->is_LdisjointR;
ok($disj);

########## BELOW:  Test for bad arguments to constructor ##########

my ($lc_bad);
my %h5 = (
    golfer   => 1,
    lambda   => 0,
);

eval { $lc_bad = List::Compare->new( { lists => [ \@a0, \%h5 ] } ) };
ok(ok_capture_error($@));

eval { $lc_bad = List::Compare->new( { lists => [ \%h5, \@a0 ] } ) };
ok(ok_capture_error($@));

eval { $lc_bad = List::Compare->new( { lists => { key => 'value' } } ) };
ok(ok_capture_error($@));




