# 11_functional_multiple.t # as of 8/7/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
940;
use lib ("./t");
use List::Compare::Functional qw(:originals :aliases);
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

# FIRST UNION
@union = get_union( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($union[0] eq 'abel');
ok($union[1] eq 'baker');
ok($union[2] eq 'camera');
ok($union[3] eq 'delta');
ok($union[4] eq 'edward');
ok($union[5] eq 'fargo');
ok($union[6] eq 'golfer');
ok($union[7] eq 'hilton');
ok($union[8] eq 'icon');
ok($union[-1] eq 'jerky');

$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$union_ref = get_union_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(${$union_ref}[0] eq 'abel');
ok(${$union_ref}[1] eq 'baker');
ok(${$union_ref}[2] eq 'camera');
ok(${$union_ref}[3] eq 'delta');
ok(${$union_ref}[4] eq 'edward');
ok(${$union_ref}[5] eq 'fargo');
ok(${$union_ref}[6] eq 'golfer');
ok(${$union_ref}[7] eq 'hilton');
ok(${$union_ref}[8] eq 'icon');
ok(${$union_ref}[-1] eq 'jerky');

$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();
# FIRST SHARED
@shared = get_shared( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($shared[0] eq 'baker');
ok($shared[1] eq 'camera');
ok($shared[2] eq 'delta');
ok($shared[3] eq 'edward');
ok($shared[4] eq 'fargo');
ok($shared[5] eq 'golfer');
ok($shared[6] eq 'hilton');
ok($shared[-1] eq 'icon');

$seen{$_}++ foreach (@shared);
ok(! exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$shared_ref = get_shared_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(${$shared_ref}[0] eq 'baker');
ok(${$shared_ref}[1] eq 'camera');
ok(${$shared_ref}[2] eq 'delta');
ok(${$shared_ref}[3] eq 'edward');
ok(${$shared_ref}[4] eq 'fargo');
ok(${$shared_ref}[5] eq 'golfer');
ok(${$shared_ref}[6] eq 'hilton');
ok(${$shared_ref}[-1] eq 'icon');

$seen{$_}++ foreach (@{$shared_ref});
ok(! exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();
# FIRST INTERSECTION
@intersection = get_intersection( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($intersection[0] eq 'fargo');
ok($intersection[-1] eq 'golfer');

$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$intersection_ref = get_intersection_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(${$intersection_ref}[0] eq 'fargo');
ok(${$intersection_ref}[-1] eq 'golfer');

$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();
# FIRST UNIQUE
@unique = get_unique( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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

$unique_ref = get_unique_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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

@unique = get_unique( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2] );
ok($unique[-1] eq 'jerky');

$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$unique_ref = get_unique_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2] );
ok(${$unique_ref}[-1] eq 'jerky');

$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

eval { $unique_ref = get_unique_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2], [3] ) };
ok(ok_capture_error($@));

# FIRST COMPLEMENT
@complement = get_complement( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($complement[0] eq 'hilton');
ok($complement[1] eq 'icon');
ok($complement[-1] eq 'jerky');

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$complement_ref = get_complement_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(${$complement_ref}[0] eq 'hilton');
ok(${$complement_ref}[1] eq 'icon');
ok(${$complement_ref}[-1] eq 'jerky');

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@complement = get_complement( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3] );
ok($complement[0] eq 'abel');
ok($complement[1] eq 'baker');
ok($complement[2] eq 'camera');
ok($complement[3] eq 'delta');
ok($complement[4] eq 'edward');
ok($complement[-1] eq 'jerky');

$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$complement_ref = get_complement_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3] );
ok(${$complement_ref}[0] eq 'abel');
ok(${$complement_ref}[1] eq 'baker');
ok(${$complement_ref}[2] eq 'camera');
ok(${$complement_ref}[3] eq 'delta');
ok(${$complement_ref}[4] eq 'edward');
ok(${$complement_ref}[-1] eq 'jerky');

$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

eval { $complement_ref = get_complement_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2], [3] ) };
ok(ok_capture_error($@));

# FIRST SYMMETRIC DIFFERENCE
@symmetric_difference = get_symmetric_difference( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($symmetric_difference[0] eq 'abel');
ok($symmetric_difference[-1] eq 'jerky');

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$symmetric_difference_ref = get_symmetric_difference_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(${$symmetric_difference_ref}[0] eq 'abel');
ok(${$symmetric_difference_ref}[-1] eq 'jerky');

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@symmetric_difference = get_symdiff( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($symmetric_difference[0] eq 'abel');
ok($symmetric_difference[-1] eq 'jerky');

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$symmetric_difference_ref = get_symdiff_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(${$symmetric_difference_ref}[0] eq 'abel');
ok(${$symmetric_difference_ref}[-1] eq 'jerky');

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();
# FIRST NONINTERSECTION 
@nonintersection = get_nonintersection( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($nonintersection[0] eq 'abel');
ok($nonintersection[1] eq 'baker');
ok($nonintersection[2] eq 'camera');
ok($nonintersection[3] eq 'delta');
ok($nonintersection[4] eq 'edward');
ok($nonintersection[5] eq 'hilton');
ok($nonintersection[6] eq 'icon');
ok($nonintersection[-1] eq 'jerky');

$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$nonintersection_ref = get_nonintersection_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(${$nonintersection_ref}[0] eq 'abel');
ok(${$nonintersection_ref}[1] eq 'baker');
ok(${$nonintersection_ref}[2] eq 'camera');
ok(${$nonintersection_ref}[3] eq 'delta');
ok(${$nonintersection_ref}[4] eq 'edward');
ok(${$nonintersection_ref}[5] eq 'hilton');
ok(${$nonintersection_ref}[6] eq 'icon');
ok(${$nonintersection_ref}[-1] eq 'jerky');

$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();
# FIRST BAG
@bag = get_bag( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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
ok($bag[13] eq 'fargo');
ok($bag[14] eq 'fargo');
ok($bag[15] eq 'fargo');
ok($bag[16] eq 'fargo');
ok($bag[17] eq 'golfer');
ok($bag[18] eq 'golfer');
ok($bag[19] eq 'golfer');
ok($bag[20] eq 'golfer');
ok($bag[21] eq 'golfer');
ok($bag[22] eq 'hilton');
ok($bag[23] eq 'hilton');
ok($bag[24] eq 'hilton');
ok($bag[25] eq 'hilton');
ok($bag[26] eq 'icon');
ok($bag[27] eq 'icon');
ok($bag[28] eq 'icon');
ok($bag[29] eq 'icon');
ok($bag[30] eq 'icon');
ok($bag[-1] eq 'jerky');

$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);
ok($seen{'baker'} == 2);
ok($seen{'camera'} == 2);
ok($seen{'delta'} == 3);
ok($seen{'edward'} == 2);
ok($seen{'fargo'} == 6);
ok($seen{'golfer'} == 5);
ok($seen{'hilton'} == 4);
ok($seen{'icon'} == 5);
ok($seen{'jerky'} == 1);
%seen = ();

$bag_ref = get_bag_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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
ok(${$bag_ref}[13] eq 'fargo');
ok(${$bag_ref}[14] eq 'fargo');
ok(${$bag_ref}[15] eq 'fargo');
ok(${$bag_ref}[16] eq 'fargo');
ok(${$bag_ref}[17] eq 'golfer');
ok(${$bag_ref}[18] eq 'golfer');
ok(${$bag_ref}[19] eq 'golfer');
ok(${$bag_ref}[20] eq 'golfer');
ok(${$bag_ref}[21] eq 'golfer');
ok(${$bag_ref}[22] eq 'hilton');
ok(${$bag_ref}[23] eq 'hilton');
ok(${$bag_ref}[24] eq 'hilton');
ok(${$bag_ref}[25] eq 'hilton');
ok(${$bag_ref}[26] eq 'icon');
ok(${$bag_ref}[27] eq 'icon');
ok(${$bag_ref}[28] eq 'icon');
ok(${$bag_ref}[29] eq 'icon');
ok(${$bag_ref}[30] eq 'icon');
ok(${$bag_ref}[-1] eq 'jerky');

$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);
ok($seen{'baker'} == 2);
ok($seen{'camera'} == 2);
ok($seen{'delta'} == 3);
ok($seen{'edward'} == 2);
ok($seen{'fargo'} == 6);
ok($seen{'golfer'} == 5);
ok($seen{'hilton'} == 4);
ok($seen{'icon'} == 5);
ok($seen{'jerky'} == 1);
%seen = ();

$LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(! $LR);

$LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3,2] );
ok($LR);
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);
ok($seen{'baker'} == 2);
ok($seen{'camera'} == 2);
ok($seen{'delta'} == 3);
ok($seen{'edward'} == 2);
ok($seen{'fargo'} == 6);
ok($seen{'golfer'} == 5);
ok($seen{'hilton'} == 4);
ok($seen{'icon'} == 5);
ok($seen{'jerky'} == 1);
%seen = ();

$bag_ref = get_bag_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);
ok($seen{'baker'} == 2);
ok($seen{'camera'} == 2);
ok($seen{'delta'} == 3);
ok($seen{'edward'} == 2);
ok($seen{'fargo'} == 6);
ok($seen{'golfer'} == 5);
ok($seen{'hilton'} == 4);
ok($seen{'icon'} == 5);
ok($seen{'jerky'} == 1);
%seen = ();

$LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(! $LR);

$LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3,2] );
ok($LR);

$LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [4,2] );
ok($LR);

eval { $LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [8,9] ) };
ok(ok_capture_error($@));

eval { $LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2,9] ) };
ok(ok_capture_error($@));

eval { $LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2,3,4] ) };
ok(ok_capture_error($@));

eval { $LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3,2], [2,3] ) };
ok(ok_capture_error($@));


$RL = is_RsubsetL( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(! $RL);

$RL = is_RsubsetL( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2,3] );
ok($RL);

$RL = is_RsubsetL( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2,4] );
ok($RL);

$eqv = is_LequivalentR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(! $eqv);

$eqv = is_LeqvlntR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(! $eqv);

$eqv = is_LequivalentR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3,4] );
ok($eqv);

eval { $eqv = is_LequivalentR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [8,9] ) };
ok(ok_capture_error($@));

eval { $eqv = is_LequivalentR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2,9] ) };
ok(ok_capture_error($@));

eval { $eqv = is_LequivalentR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2,3,4] ) };
ok(ok_capture_error($@));

eval { $eqv = is_LequivalentR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3,2], [2,3] ) };
ok(ok_capture_error($@));

$eqv = is_LeqvlntR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3,4] );
ok($eqv);

$return = print_subset_chart( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($return);

eval { $return = print_subset_chart( [ \@a0, \@a1, \@a2, \@a3, \@a4 ],
    [ qw| extraneous argument | ],
) };
ok(ok_capture_error($@));

$return = print_equivalence_chart( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($return);

eval { $return = print_equivalence_chart( [ \@a0, \@a1, \@a2, \@a3, \@a4 ],
    [ qw| extraneous argument | ],
) };
ok(ok_capture_error($@));

# FIRST IS MEMBER WHICH
@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'abel' ] );
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0   > ] ));

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'baker' ] );
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1 > ] ));

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'camera' ] );
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1 > ] ));

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'delta' ] );
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1 > ] ));

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'edward' ] );
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1 > ] ));

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'fargo' ] );
ok(ok_seen_a( \@memb_arr, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'golfer' ] );
ok(ok_seen_a( \@memb_arr, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'hilton' ] );
ok(ok_seen_a( \@memb_arr, 'hilton', 4, [ qw<   1 2 3 4 > ] ));

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'icon' ] );
ok(ok_seen_a( \@memb_arr, 'icon',   3, [ qw<     2 3 4 > ] ));

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'jerky' ] );
ok(ok_seen_a( \@memb_arr, 'jerky',  1, [ qw<     2 > ] ));

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'zebra' ] );
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<     > ] ));


$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'abel' ] );
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0   > ] ));

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'baker' ] );
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'camera' ] );
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'delta' ] );
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'edward' ] );
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'fargo' ] );
ok(ok_seen_a( $memb_arr_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'golfer' ] );
ok(ok_seen_a( $memb_arr_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'hilton' ] );
ok(ok_seen_a( $memb_arr_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'icon' ] );
ok(ok_seen_a( $memb_arr_ref, 'icon',   3, [ qw<     2 3 4 > ] ));

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'jerky' ] );
ok(ok_seen_a( $memb_arr_ref, 'jerky',  1, [ qw<     2 > ] ));

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'zebra' ] );
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<     > ] ));
# FIRST ARE MEMBERS WHICH
$memb_hash_ref = are_members_which(  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , 
    [ qw| abel baker camera delta edward fargo golfer hilton icon jerky zebra | ] );
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0   > ] ));
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'icon',   3, [ qw<     2 3 4 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'jerky',  1, [ qw<     2 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<     > ] ));

eval { $memb_hash_ref = are_members_which(
    [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , 
    [ qw| abel baker camera delta edward fargo golfer hilton icon jerky zebra | ],
    [ qw| extraneous argument | ]
) };
ok(ok_capture_error($@));

# FIRST IS MEMBER ANY
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'abel' ] ));
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'baker' ] ));
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'camera' ] ));
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'delta' ] ));
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'edward' ] ));
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'fargo' ] ));
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'golfer' ] ));
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'hilton' ] ));
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'icon' ] ));
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'jerky' ] ));
ok(! is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'zebra' ] ));
# FIRST ARE MEMBERS ANY
$memb_hash_ref = are_members_any(  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , 
    [ qw| abel baker camera delta edward fargo golfer hilton icon jerky zebra | ] );
ok(ok_any_h( $memb_hash_ref, 'abel',   1 ));
ok(ok_any_h( $memb_hash_ref, 'baker',  1 ));
ok(ok_any_h( $memb_hash_ref, 'camera', 1 ));
ok(ok_any_h( $memb_hash_ref, 'delta',  1 ));
ok(ok_any_h( $memb_hash_ref, 'edward', 1 ));
ok(ok_any_h( $memb_hash_ref, 'fargo',  1 ));
ok(ok_any_h( $memb_hash_ref, 'golfer', 1 ));
ok(ok_any_h( $memb_hash_ref, 'hilton', 1 ));
ok(ok_any_h( $memb_hash_ref, 'icon',   1 ));
ok(ok_any_h( $memb_hash_ref, 'jerky',  1 ));
ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));

eval { $memb_hash_ref = are_members_any(
    [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , 
    [ qw| abel baker camera delta edward fargo golfer hilton icon jerky zebra | ],
    [ qw| extraneous argument | ]
) };
ok(ok_capture_error($@));

$vers = get_version;
ok($vers);

$disj = is_LdisjointR( [ \@a0, \@a1, \@a2, \@a3, \@a4, \@a8 ] );
ok(! $disj);

$disj = is_LdisjointR( [ \@a0, \@a1, \@a2, \@a3, \@a4, \@a8 ], [2,3] );
ok(! $disj);

$disj = is_LdisjointR( [ \@a0, \@a1, \@a2, \@a3, \@a4, \@a8 ], [4,5] );
ok($disj);

eval { $disj = is_LdisjointR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [8,9] ) };
ok(ok_capture_error($@));

eval { $disj = is_LdisjointR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3,2], [2,3] ) };
ok(ok_capture_error($@));

########## BELOW:  Tests for '-u' option ##########

@union = get_union('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$union_ref = get_union_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@shared = get_shared('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@shared);
ok(! exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$shared_ref = get_shared_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$shared_ref});
ok(! exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@intersection = get_intersection('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$intersection_ref = get_intersection_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@unique = get_unique('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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

$unique_ref = get_unique_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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

@unique = get_unique('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2] );
$seen{$_}++ foreach (@unique);
ok(!exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$unique_ref = get_unique_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2] );
$seen{$_}++ foreach (@{$unique_ref});
ok(!exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@complement = get_complement('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$complement_ref = get_complement_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@complement = get_complement('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3] );
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$complement_ref = get_complement_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3] );
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@symmetric_difference = get_symmetric_difference('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$symmetric_difference_ref = get_symmetric_difference_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@symmetric_difference = get_symdiff('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$symmetric_difference_ref = get_symdiff_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@nonintersection = get_nonintersection('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$nonintersection_ref = get_nonintersection_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@bag = get_bag('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);
ok($seen{'baker'} == 2);
ok($seen{'camera'} == 2);
ok($seen{'delta'} == 3);
ok($seen{'edward'} == 2);
ok($seen{'fargo'} == 6);
ok($seen{'golfer'} == 5);
ok($seen{'hilton'} == 4);
ok($seen{'icon'} == 5);
ok($seen{'jerky'} == 1);
%seen = ();

$bag_ref = get_bag_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);
ok($seen{'baker'} == 2);
ok($seen{'camera'} == 2);
ok($seen{'delta'} == 3);
ok($seen{'edward'} == 2);
ok($seen{'fargo'} == 6);
ok($seen{'golfer'} == 5);
ok($seen{'hilton'} == 4);
ok($seen{'icon'} == 5);
ok($seen{'jerky'} == 1);
%seen = ();

##### BELOW:  Tests for '--unsorted' option ##########

@union = get_union('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$union_ref = get_union_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@shared = get_shared('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@shared);
ok(! exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$shared_ref = get_shared_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$shared_ref});
ok(! exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@intersection = get_intersection('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

$intersection_ref = get_intersection_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@unique = get_unique('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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

$unique_ref = get_unique_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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

@unique = get_unique('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2] );
$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$unique_ref = get_unique_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2] );
$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});

@complement = get_complement('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$complement_ref = get_complement_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@complement = get_complement('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3] );
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$complement_ref = get_complement_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3] );
$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@symmetric_difference = get_symmetric_difference('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$symmetric_difference_ref = get_symmetric_difference_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@symmetric_difference = get_symdiff('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$symmetric_difference_ref = get_symdiff_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@nonintersection = get_nonintersection('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$nonintersection_ref = get_nonintersection_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});
ok(exists $seen{'baker'});
ok(exists $seen{'camera'});
ok(exists $seen{'delta'});
ok(exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@bag = get_bag('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);
ok($seen{'baker'} == 2);
ok($seen{'camera'} == 2);
ok($seen{'delta'} == 3);
ok($seen{'edward'} == 2);
ok($seen{'fargo'} == 6);
ok($seen{'golfer'} == 5);
ok($seen{'hilton'} == 4);
ok($seen{'icon'} == 5);
ok($seen{'jerky'} == 1);
%seen = ();

$bag_ref = get_bag_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);
ok($seen{'baker'} == 2);
ok($seen{'camera'} == 2);
ok($seen{'delta'} == 3);
ok($seen{'edward'} == 2);
ok($seen{'fargo'} == 6);
ok($seen{'golfer'} == 5);
ok($seen{'hilton'} == 4);
ok($seen{'icon'} == 5);
ok($seen{'jerky'} == 1);
%seen = ();

########## Tests of passing refs to named arrays to functions ##########

my @allarrays = (\@a0, \@a1, \@a2, \@a3, \@a4); 
@intersection = get_intersection('--unsorted', \@allarrays );
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(exists $seen{'fargo'});
ok(exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(! exists $seen{'jerky'});
%seen = ();

@unique = get_unique('--unsorted', \@allarrays, [2] );
$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(! exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();


