# perl
#$Id$
# 34_func_lists_dual_unsorted.t
use strict;
use Test::More tests => 76;
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

for my $unsorted ('-u', '--unsorted') {
	%pred = map {$_, 1} qw( abel baker camera delta edward fargo golfer hilton );
	@unpred = qw| icon jerky |;
	@union = get_union( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@union);
	is_deeply(\%seen, \%pred, "unsorted:  got expected union");
	ok(unseen(\%seen, \@unpred),
		"union:  All non-expected elements correctly excluded");
	%seen = ();

	$union_ref = get_union_ref( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@{$union_ref});
	is_deeply(\%seen, \%pred, "unsorted:  got expected union");
	ok(unseen(\%seen, \@unpred),
		"union:  All non-expected elements correctly excluded");
	%seen = ();

	%pred = map {$_, 1} qw( baker camera delta edward fargo golfer );
	@unpred = qw| abel hilton icon jerky |;
	@shared = get_shared( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@shared);
	is_deeply(\%seen, \%pred, "unsorted:  got expected shared");
	ok(unseen(\%seen, \@unpred),
		"shared:  All non-expected elements correctly excluded");
	%seen = ();

	$shared_ref = get_shared_ref( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@{$shared_ref});
	is_deeply(\%seen, \%pred, "unsorted:  got expected shared");
	ok(unseen(\%seen, \@unpred),
		"shared:  All non-expected elements correctly excluded");
	%seen = ();

	%pred = map {$_, 1} qw( baker camera delta edward fargo golfer );
	@unpred = qw| abel hilton icon jerky |;
	@intersection = get_intersection( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@intersection);
	is_deeply(\%seen, \%pred, "unsorted:  got expected intersection");
	ok(unseen(\%seen, \@unpred),
		"intersection:  All non-expected elements correctly excluded");
	%seen = ();

	$intersection_ref = get_intersection_ref( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@{$intersection_ref});
	is_deeply(\%seen, \%pred, "unsorted:  got expected intersection");
	ok(unseen(\%seen, \@unpred),
		"intersection:  All non-expected elements correctly excluded");
	%seen = ();

	%pred = map {$_, 1} qw( abel );
	@unpred = qw| baker camera delta edward fargo golfer hilton icon jerky |;
	@unique = get_unique( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@unique);
	is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
	ok(unseen(\%seen, \@unpred),
		"unique:  All non-expected elements correctly excluded");
	%seen = ();

	$unique_ref = get_unique_ref( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@{$unique_ref});
	is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
	ok(unseen(\%seen, \@unpred),
		"unique:  All non-expected elements correctly excluded");
	%seen = ();

	@pred = (
		[ 'abel' ],
		[ 'hilton' ],
	);
	$unique_all_ref = get_unique_all( $unsorted, [ \@a0, \@a1 ] );
	is_deeply(
		make_array_seen_hash($unique_all_ref),
		make_array_seen_hash(\@pred),
		"Got expected values for get_unique_all()");

	%pred = map {$_, 1} qw( hilton );
	@unpred = qw| abel baker camera delta edward fargo golfer icon jerky |;
	@complement = get_complement( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@complement);
	is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
	ok(unseen(\%seen, \@unpred),
		"complement:  All non-expected elements correctly excluded");
	%seen = ();

	$complement_ref = get_complement_ref( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@{$complement_ref});
	is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
	ok(unseen(\%seen, \@unpred),
		"complement:  All non-expected elements correctly excluded");
	%seen = ();

	@pred = (
		[ qw( hilton ) ],
		[ qw( abel ) ],
	);
	$complement_all_ref = get_complement_all( $unsorted, [ \@a0, \@a1 ] );
	is_deeply(
		make_array_seen_hash($complement_all_ref),
		make_array_seen_hash(\@pred),
		"Got expected values for get_complement_all()");

	%pred = map {$_, 1} qw( abel hilton );
	@unpred = qw| baker camera delta edward fargo golfer icon jerky |;
	@symmetric_difference = get_symmetric_difference( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@symmetric_difference);
	is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
	ok(unseen(\%seen, \@unpred),
		"symmetric difference:  All non-expected elements correctly excluded");
	%seen = ();

	$symmetric_difference_ref =
		get_symmetric_difference_ref( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@{$symmetric_difference_ref});
	is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
	ok(unseen(\%seen, \@unpred),
		"symmetric difference:  All non-expected elements correctly excluded");
	%seen = ();

	@symmetric_difference = get_symdiff( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@symmetric_difference);
	is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
	ok(unseen(\%seen, \@unpred),
		"symmetric difference:  All non-expected elements correctly excluded");
	%seen = ();

	$symmetric_difference_ref = get_symdiff_ref( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@{$symmetric_difference_ref});
	is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
	ok(unseen(\%seen, \@unpred),
		"symmetric difference:  All non-expected elements correctly excluded");
	%seen = ();

	%pred = map {$_, 1} qw( abel hilton );
	@unpred = qw| baker camera delta edward fargo golfer icon jerky |;
	@nonintersection = get_nonintersection( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@nonintersection);
	is_deeply(\%seen, \%pred, "unsorted:  Got expected nonintersection");
	ok(unseen(\%seen, \@unpred),
		"nonintersection:  All non-expected elements correctly excluded");
	%seen = ();

	$nonintersection_ref = get_nonintersection_ref( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@{$nonintersection_ref});
	is_deeply(\%seen, \%pred, "unsorted:  Got expected nonintersection");
	ok(unseen(\%seen, \@unpred),
		"nonintersection:  All non-expected elements correctly excluded");
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
	@bag = get_bag( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@bag);
	is_deeply(\%seen, \%pred, "Got predicted quantities in bag");
	ok(unseen(\%seen, \@unpred),
		"bag:  All non-expected elements correctly excluded");
	%seen = ();

	$bag_ref = get_bag_ref( $unsorted, [ \@a0, \@a1 ] );
	$seen{$_}++ foreach (@{$bag_ref});
	is_deeply(\%seen, \%pred, "Got predicted quantities in bag");
	ok(unseen(\%seen, \@unpred),
		"bag:  All non-expected elements correctly excluded");
	%seen = ();
}
