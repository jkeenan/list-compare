# 21_alt_construct_simple_sh_rev.t # as of 05/08/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
879;
use lib ("./t");
use List::Compare;
use Test::ListCompareSpecial qw(:seen);

$loaded = 1;
ok($loaded);
######################### End of black magic.

my %seen = ();
my (@unique, @complement, @intersection, @union, @symmetric_difference);
my ($unique_ref, $complement_ref, $intersection_ref, $union_ref, $symmetric_difference_ref);
my ($LR, $RL, $eqv, $disj, $return);
my (@nonintersection, @shared);
my ($nonintersection_ref, @shared_ref);
my ($memb_hash_ref, $memb_arr_ref, @memb_arr);

my %h0 = (
	abel     => 2,
	baker    => 1,
	camera   => 1,
	delta    => 1,
	edward   => 1,
	fargo    => 1,
	golfer   => 1,
);

my %h1 = (
	baker    => 1,
	camera   => 1,
	delta    => 2,
	edward   => 1,
	fargo    => 1,
	golfer   => 1,
	hilton   => 1,
);

my %h2 = (
	fargo    => 1,
	golfer   => 1,
	hilton   => 1,
	icon     => 2,
	jerky    => 1,	
);

my %h3 = (
	fargo    => 1,
	golfer   => 1,
	hilton   => 1,
	icon     => 2,
);

my %h4 = (
	fargo    => 2,
	golfer   => 1,
	hilton   => 1,
	icon     => 1,
);

my %h5 = (
	golfer   => 1,
	lambda   => 0,
);

my %h6 = (
	golfer   => 1,
	mu       => 00,
);

my %h7 = (
	golfer   => 1,
	nu       => 'nothing',
);

my %h8 = map {$_, 1} qw(kappa lambda mu);


my $lcsh  = List::Compare->new( { lists => [\%h0, \%h1] } );

ok($lcsh);

@union = $lcsh->get_union;
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

$union_ref = $lcsh->get_union_ref;
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
	@shared = $lcsh->get_shared;
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
	$shared_ref = $lcsh->get_shared_ref;
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

@intersection = $lcsh->get_intersection;
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

$intersection_ref = $lcsh->get_intersection_ref;
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

@unique = $lcsh->get_unique;
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

$unique_ref = $lcsh->get_unique_ref;
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

@unique = $lcsh->get_Lonly;
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

$unique_ref = $lcsh->get_Lonly_ref;
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

@unique = $lcsh->get_Aonly;
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

$unique_ref = $lcsh->get_Aonly_ref;
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

@complement = $lcsh->get_complement;
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

$complement_ref = $lcsh->get_complement_ref;
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

@complement = $lcsh->get_Ronly;
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

$complement_ref = $lcsh->get_Ronly_ref;
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

@complement = $lcsh->get_Bonly;
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

$complement_ref = $lcsh->get_Bonly_ref;
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

@symmetric_difference = $lcsh->get_symmetric_difference;
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

$symmetric_difference_ref = $lcsh->get_symmetric_difference_ref;
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

@symmetric_difference = $lcsh->get_symdiff;
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

$symmetric_difference_ref = $lcsh->get_symdiff_ref;
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

@symmetric_difference = $lcsh->get_LorRonly;
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

$symmetric_difference_ref = $lcsh->get_LorRonly_ref;
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

@symmetric_difference = $lcsh->get_AorBonly;
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

$symmetric_difference_ref = $lcsh->get_AorBonly_ref;
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
	@nonintersection = $lcsh->get_nonintersection;
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
	$nonintersection_ref = $lcsh->get_nonintersection_ref;
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

@bag = $lcsh->get_bag;
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

$bag_ref = $lcsh->get_bag_ref;
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

$LR = $lcsh->is_LsubsetR;
ok(! $LR);

$LR = $lcsh->is_AsubsetB;
ok(! $LR);

$RL = $lcsh->is_RsubsetL;
ok(! $RL);

$RL = $lcsh->is_BsubsetA;
ok(! $RL);

$eqv = $lcsh->is_LequivalentR;
ok(! $eqv);

$eqv = $lcsh->is_LeqvlntR;
ok(! $eqv);

$disj = $lcsh->is_LdisjointR;
ok(! $disj);

$return = $lcsh->print_subset_chart;
ok($return);

$return = $lcsh->print_equivalence_chart;
ok($return);

@memb_arr = $lcsh->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0   > ] ));

@memb_arr = $lcsh->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1 > ] ));

@memb_arr = $lcsh->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1 > ] ));

@memb_arr = $lcsh->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1 > ] ));

@memb_arr = $lcsh->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1 > ] ));

@memb_arr = $lcsh->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  2, [ qw< 0 1 > ] ));

@memb_arr = $lcsh->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 2, [ qw< 0 1 > ] ));

@memb_arr = $lcsh->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 1, [ qw<   1 > ] ));

@memb_arr = $lcsh->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   0, [ qw<     > ] ));

@memb_arr = $lcsh->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  0, [ qw<     > ] ));

@memb_arr = $lcsh->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<     > ] ));


$memb_arr_ref = $lcsh->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0   > ] ));

$memb_arr_ref = $lcsh->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcsh->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcsh->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcsh->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcsh->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcsh->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcsh->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 1, [ qw<   1 > ] ));

$memb_arr_ref = $lcsh->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   0, [ qw<     > ] ));

$memb_arr_ref = $lcsh->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  0, [ qw<     > ] ));

$memb_arr_ref = $lcsh->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<     > ] ));

$memb_hash_ref = $lcsh->are_members_which( [ qw| abel baker camera delta edward fargo 
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


ok($lcsh->is_member_any('abel'));
ok($lcsh->is_member_any('baker'));
ok($lcsh->is_member_any('camera'));
ok($lcsh->is_member_any('delta'));
ok($lcsh->is_member_any('edward'));
ok($lcsh->is_member_any('fargo'));
ok($lcsh->is_member_any('golfer'));
ok($lcsh->is_member_any('hilton'));
ok(! $lcsh->is_member_any('icon' ));
ok(! $lcsh->is_member_any('jerky'));
ok(! $lcsh->is_member_any('zebra'));


$memb_hash_ref = $lcsh->are_members_any( [ qw| abel baker camera delta edward fargo 
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

$vers = $lcsh->get_version;
ok($vers);

my $lcsh_s  = List::Compare->new( { lists => [\%h2, \%h3] } );
ok($lcsh_s);

$LR = $lcsh_s->is_LsubsetR;
ok(! $LR);

$LR = $lcsh_s->is_AsubsetB;
ok(! $LR);

$RL = $lcsh_s->is_RsubsetL;
ok($RL);

$RL = $lcsh_s->is_BsubsetA;
ok($RL);

$eqv = $lcsh_s->is_LequivalentR;
ok(! $eqv);

$eqv = $lcsh_s->is_LeqvlntR;
ok(! $eqv);

$disj = $lcsh_s->is_LdisjointR;
ok(! $disj);

my $lcsh_e  = List::Compare->new( { lists => [\%h3, \%h4] } );

ok($lcsh_e);

$eqv = $lcsh_e->is_LequivalentR;
ok($eqv);

$eqv = $lcsh_e->is_LeqvlntR;
ok($eqv);

$disj = $lcsh_e->is_LdisjointR;
ok(! $disj);

my $lcsh_dj  = List::Compare->new( { lists => [\%h4, \%h8] } );

ok($lcsh_dj);

ok(0 == $lcsh_dj->get_intersection);
ok(0 == scalar(@{$lcsh_dj->get_intersection_ref}));
$disj = $lcsh_dj->is_LdisjointR;
ok($disj);

########## BELOW:  Tests for '-u' option ##########

my $lcshu  = List::Compare->new( { unsorted => 1, lists => [\%h0, \%h1] } );

ok($lcshu);

@union = $lcshu->get_union;
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

$union_ref = $lcshu->get_union_ref;
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
	@shared = $lcshu->get_shared;
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
	$shared_ref = $lcshu->get_shared_ref;
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

@intersection = $lcshu->get_intersection;
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

$intersection_ref = $lcshu->get_intersection_ref;
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

@unique = $lcshu->get_unique;
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

$unique_ref = $lcshu->get_unique_ref;
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

@unique = $lcshu->get_Lonly;
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

$unique_ref = $lcshu->get_Lonly_ref;
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

@unique = $lcshu->get_Aonly;
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

$unique_ref = $lcshu->get_Aonly_ref;
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

@complement = $lcshu->get_complement;
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

$complement_ref = $lcshu->get_complement_ref;
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

@complement = $lcshu->get_Ronly;
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

$complement_ref = $lcshu->get_Ronly_ref;
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

@complement = $lcshu->get_Bonly;
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

$complement_ref = $lcshu->get_Bonly_ref;
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

@symmetric_difference = $lcshu->get_symmetric_difference;
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

$symmetric_difference_ref = $lcshu->get_symmetric_difference_ref;
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

@symmetric_difference = $lcshu->get_symdiff;
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

$symmetric_difference_ref = $lcshu->get_symdiff_ref;
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

@symmetric_difference = $lcshu->get_LorRonly;
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

$symmetric_difference_ref = $lcshu->get_LorRonly_ref;
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

@symmetric_difference = $lcshu->get_AorBonly;
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

$symmetric_difference_ref = $lcshu->get_AorBonly_ref;
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
	@nonintersection = $lcshu->get_nonintersection;
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
	$nonintersection_ref = $lcshu->get_nonintersection_ref;
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

@bag = $lcshu->get_bag;
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

$bag_ref = $lcshu->get_bag_ref;
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

$LR = $lcshu->is_LsubsetR;
ok(! $LR);

$LR = $lcshu->is_AsubsetB;
ok(! $LR);

$RL = $lcshu->is_RsubsetL;
ok(! $RL);

$RL = $lcshu->is_BsubsetA;
ok(! $RL);

$eqv = $lcshu->is_LequivalentR;
ok(! $eqv);

$eqv = $lcshu->is_LeqvlntR;
ok(! $eqv);

$disj = $lcshu->is_LdisjointR;
ok(! $disj);

$return = $lcshu->print_subset_chart;
ok($return);

$return = $lcshu->print_equivalence_chart;
ok($return);

@memb_arr = $lcshu->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0   > ] ));

@memb_arr = $lcshu->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1 > ] ));

@memb_arr = $lcshu->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1 > ] ));

@memb_arr = $lcshu->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1 > ] ));

@memb_arr = $lcshu->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1 > ] ));

@memb_arr = $lcshu->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  2, [ qw< 0 1 > ] ));

@memb_arr = $lcshu->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 2, [ qw< 0 1 > ] ));

@memb_arr = $lcshu->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 1, [ qw<   1 > ] ));

@memb_arr = $lcshu->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   0, [ qw<     > ] ));

@memb_arr = $lcshu->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  0, [ qw<     > ] ));

@memb_arr = $lcshu->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<     > ] ));


$memb_arr_ref = $lcshu->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0   > ] ));

$memb_arr_ref = $lcshu->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcshu->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcshu->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcshu->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcshu->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcshu->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 2, [ qw< 0 1 > ] ));

$memb_arr_ref = $lcshu->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 1, [ qw<   1 > ] ));

$memb_arr_ref = $lcshu->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   0, [ qw<     > ] ));

$memb_arr_ref = $lcshu->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  0, [ qw<     > ] ));

$memb_arr_ref = $lcshu->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<     > ] ));

#$memb_hash_ref = $lcshu->are_members_which(qw| abel baker camera delta edward fargo 
#	golfer hilton icon jerky zebra |);
#ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0   > ] ));
#ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1 > ] ));
#ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1 > ] ));
#ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1 > ] ));
#ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1 > ] ));
#ok(ok_seen_h( $memb_hash_ref, 'fargo',  2, [ qw< 0 1 > ] ));
#ok(ok_seen_h( $memb_hash_ref, 'golfer', 2, [ qw< 0 1 > ] ));
#ok(ok_seen_h( $memb_hash_ref, 'hilton', 1, [ qw<   1 > ] ));
#ok(ok_seen_h( $memb_hash_ref, 'icon',   0, [ qw<     > ] ));
#ok(ok_seen_h( $memb_hash_ref, 'jerky',  0, [ qw<     > ] ));
#ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<     > ] ));

$memb_hash_ref = $lcshu->are_members_which( [ qw| abel baker camera delta edward fargo 
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


ok($lcshu->is_member_any('abel'));
ok($lcshu->is_member_any('baker'));
ok($lcshu->is_member_any('camera'));
ok($lcshu->is_member_any('delta'));
ok($lcshu->is_member_any('edward'));
ok($lcshu->is_member_any('fargo'));
ok($lcshu->is_member_any('golfer'));
ok($lcshu->is_member_any('hilton'));
ok(! $lcshu->is_member_any('icon' ));
ok(! $lcshu->is_member_any('jerky'));
ok(! $lcshu->is_member_any('zebra'));

#$memb_hash_ref = $lcshu->are_members_any(qw| abel baker camera delta edward fargo 
#    golfer hilton icon jerky zebra |);
#
#ok(ok_any_h( $memb_hash_ref, 'abel',   1 ));
#ok(ok_any_h( $memb_hash_ref, 'baker',  1 ));
#ok(ok_any_h( $memb_hash_ref, 'camera', 1 ));
#ok(ok_any_h( $memb_hash_ref, 'delta',  1 ));
#ok(ok_any_h( $memb_hash_ref, 'edward', 1 ));
#ok(ok_any_h( $memb_hash_ref, 'fargo',  1 ));
#ok(ok_any_h( $memb_hash_ref, 'golfer', 1 ));
#ok(ok_any_h( $memb_hash_ref, 'hilton', 1 ));
#ok(ok_any_h( $memb_hash_ref, 'icon',   0 ));
#ok(ok_any_h( $memb_hash_ref, 'jerky',  0 ));
#ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));

$memb_hash_ref = $lcshu->are_members_any( [ qw| abel baker camera delta edward fargo 
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

$vers = $lcshu->get_version;
ok($vers);

my $lcshu_s  = List::Compare->new( { unsorted => 1, lists => [\%h2, \%h3] } );
ok($lcshu_s);

$LR = $lcshu_s->is_LsubsetR;
ok(! $LR);

$LR = $lcshu_s->is_AsubsetB;
ok(! $LR);

$RL = $lcshu_s->is_RsubsetL;
ok($RL);

$RL = $lcshu_s->is_BsubsetA;
ok($RL);

$eqv = $lcshu_s->is_LequivalentR;
ok(! $eqv);

$eqv = $lcshu_s->is_LeqvlntR;
ok(! $eqv);

$disj = $lcshu_s->is_LdisjointR;
ok(! $disj);

my $lcshu_e  = List::Compare->new( { unsorted => 1, lists => [\%h3, \%h4] } );

ok($lcshu_e);

$eqv = $lcshu_e->is_LequivalentR;
ok($eqv);

$eqv = $lcshu_e->is_LeqvlntR;
ok($eqv);

$disj = $lcshu_e->is_LdisjointR;
ok(! $disj);

my $lcush_dj  = List::Compare->new( { unsorted => 1, lists => [\%h4, \%h8] } );

ok($lcush_dj);

ok(0 == $lcush_dj->get_intersection);
ok(0 == scalar(@{$lcush_dj->get_intersection_ref}));
$disj = $lcush_dj->is_LdisjointR;
ok($disj);

########## BELOW:  Tests for '--unsorted' option ##########

my $lcshun  = List::Compare->new( { unsorted => 1, lists => [\%h0, \%h1] } );
ok($lcshun);

my $lcshun_s  = List::Compare->new( { unsorted => 1, lists => [\%h2, \%h3] } );
ok($lcshun_s);

my $lcshun_e  = List::Compare->new( { unsorted => 1, lists => [\%h3, \%h4] } );
ok($lcshun_e);

########## BELOW:  Tests for bad values in seen-hash ##########

my ($f5, $f6, $f7);

eval { $f5 = List::Compare->new( { lists => [\%h0, \%h5] } ) };
ok(ok_capture_error($@));

eval { $f6 = List::Compare->new( { lists => [\%h6, \%h0] } ) };
ok(ok_capture_error($@));

eval { $f7 = List::Compare->new( { lists => [\%h6, \%h7] } ) };
ok(ok_capture_error($@));





