# 03_multiple.t # as of 8/5/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;}
use Test::Simple tests =>
1175;
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

my $lcm   = List::Compare->new(\@a0, \@a1, \@a2, \@a3, \@a4);

ok($lcm);

@union = $lcm->get_union;
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

$union_ref = $lcm->get_union_ref;
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

@shared = $lcm->get_shared;
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

$shared_ref = $lcm->get_shared_ref;
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

@intersection = $lcm->get_intersection;
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

$intersection_ref = $lcm->get_intersection_ref;
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

@unique = $lcm->get_unique(2);
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

$unique_ref = $lcm->get_unique_ref(2);
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

eval { $unique_ref = $lcm->get_unique_ref('jerky') };
ok(ok_capture_error($@));

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcm->get_Lonly(2);
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcm->get_Lonly_ref(2);
}
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

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcm->get_Aonly(2);
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcm->get_Aonly_ref(2);
}
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

@unique = $lcm->get_unique;
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

$unique_ref = $lcm->get_unique_ref;
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

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcm->get_Lonly;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcm->get_Lonly_ref;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcm->get_Aonly;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcm->get_Aonly_ref;
}
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

@complement = $lcm->get_complement(1);
ok($complement[0] eq 'abel');
ok($complement[1] eq 'icon');
ok($complement[-1] eq 'jerky');

$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$complement_ref = $lcm->get_complement_ref(1);
ok(${$complement_ref}[0] eq 'abel');
ok(${$complement_ref}[1] eq 'icon');
ok(${$complement_ref}[-1] eq 'jerky');

$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

eval { $complement_ref = $lcm->get_complement_ref('jerky') };
ok(ok_capture_error($@));

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcm->get_Ronly(1);
}
ok($complement[0] eq 'abel');
ok($complement[1] eq 'icon');
ok($complement[-1] eq 'jerky');

$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcm->get_Ronly_ref(1);
}
ok(${$complement_ref}[0] eq 'abel');
ok(${$complement_ref}[1] eq 'icon');
ok(${$complement_ref}[-1] eq 'jerky');

$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcm->get_Bonly(1);
}
ok($complement[0] eq 'abel');
ok($complement[1] eq 'icon');
ok($complement[-1] eq 'jerky');

$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcm->get_Bonly_ref(1);
}
ok(${$complement_ref}[0] eq 'abel');
ok(${$complement_ref}[1] eq 'icon');
ok(${$complement_ref}[-1] eq 'jerky');

$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@complement = $lcm->get_complement;
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

$complement_ref = $lcm->get_complement_ref;
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

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcm->get_Ronly;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcm->get_Ronly_ref;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcm->get_Bonly;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcm->get_Bonly_ref;
}
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

@symmetric_difference = $lcm->get_symmetric_difference;
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

$symmetric_difference_ref = $lcm->get_symmetric_difference_ref;
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

@symmetric_difference = $lcm->get_symdiff;
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

$symmetric_difference_ref = $lcm->get_symdiff_ref;
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

{
    local $SIG{__WARN__} = \&_capture;
    @symmetric_difference = $lcm->get_LorRonly;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $symmetric_difference_ref = $lcm->get_LorRonly_ref;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    @symmetric_difference = $lcm->get_AorBonly;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $symmetric_difference_ref = $lcm->get_AorBonly_ref;
}
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

@nonintersection = $lcm->get_nonintersection;
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

$nonintersection_ref = $lcm->get_nonintersection_ref;
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

@bag = $lcm->get_bag;
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

$bag_ref = $lcm->get_bag_ref;
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

$LR = $lcm->is_LsubsetR(3,2);
ok($LR);

$LR = $lcm->is_AsubsetB(3,2);
ok($LR);

$LR = $lcm->is_LsubsetR(2,3);
ok(! $LR);

$LR = $lcm->is_AsubsetB(2,3);
ok(! $LR);

$LR = $lcm->is_LsubsetR;
ok(! $LR);

eval { $LR = $lcm->is_LsubsetR(2) };
ok(ok_capture_error($@));

eval { $LR = $lcm->is_LsubsetR(8,9) };
ok(ok_capture_error($@));

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcm->is_RsubsetL;
}
ok(! $RL);

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcm->is_BsubsetA;
}
ok(! $RL);

$eqv = $lcm->is_LequivalentR(3,4);
ok($eqv);

$eqv = $lcm->is_LeqvlntR(3,4);
ok($eqv);

$eqv = $lcm->is_LequivalentR(2,4);
ok(! $eqv);

eval { $eqv = $lcm->is_LequivalentR(2) };
ok(ok_capture_error($@));

eval { $eqv = $lcm->is_LequivalentR(8,9) };
ok(ok_capture_error($@));

$return = $lcm->print_subset_chart;
ok($return);

$return = $lcm->print_equivalence_chart;
ok($return);

@memb_arr = $lcm->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0        > ] ));

@memb_arr = $lcm->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1      > ] ));

@memb_arr = $lcm->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1      > ] ));

@memb_arr = $lcm->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1      > ] ));

@memb_arr = $lcm->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1      > ] ));

@memb_arr = $lcm->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));

@memb_arr = $lcm->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));

@memb_arr = $lcm->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 4, [ qw<   1 2 3 4 > ] ));

@memb_arr = $lcm->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   3, [ qw<     2 3 4 > ] ));

@memb_arr = $lcm->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  1, [ qw<     2     > ] ));

@memb_arr = $lcm->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<           > ] ));


$memb_arr_ref = $lcm->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0        > ] ));

$memb_arr_ref = $lcm->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1      > ] ));

$memb_arr_ref = $lcm->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1      > ] ));

$memb_arr_ref = $lcm->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1      > ] ));

$memb_arr_ref = $lcm->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1      > ] ));

$memb_arr_ref = $lcm->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));

$memb_arr_ref = $lcm->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));

$memb_arr_ref = $lcm->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));

$memb_arr_ref = $lcm->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   3, [ qw<     2 3 4 > ] ));

$memb_arr_ref = $lcm->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  1, [ qw<     2     > ] ));

$memb_arr_ref = $lcm->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<           > ] ));

eval { $memb_arr_ref = $lcm->is_member_which_ref('jerky', 'zebra') };
ok(ok_capture_error($@));


$memb_hash_ref = $lcm->are_members_which(
  [ qw| abel baker camera delta edward fargo
    golfer hilton icon jerky zebra | ]
);
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0         > ] ));
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1       > ] ));
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1       > ] ));
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1       > ] ));
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1       > ] ));
ok(ok_seen_h( $memb_hash_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'icon',   3, [ qw<     2 3 4 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'jerky',  1, [ qw<     2     > ] ));
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<           > ] ));

eval { $memb_hash_ref = $lcm->are_members_which( { key => 'value' } ) };
ok(ok_capture_error($@));


ok($lcm->is_member_any('abel'));
ok($lcm->is_member_any('baker'));
ok($lcm->is_member_any('camera'));
ok($lcm->is_member_any('delta'));
ok($lcm->is_member_any('edward'));
ok($lcm->is_member_any('fargo'));
ok($lcm->is_member_any('golfer'));
ok($lcm->is_member_any('hilton'));
ok($lcm->is_member_any('icon' ));
ok($lcm->is_member_any('jerky'));
ok(! $lcm->is_member_any('zebra'));

eval { $lcm->is_member_any('jerky', 'zebra') };
ok(ok_capture_error($@));


$memb_hash_ref = $lcm->are_members_any(
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

eval { $memb_hash_ref = $lcm->are_members_any( { key => 'value' } ) };
ok(ok_capture_error($@));


$vers = $lcm->get_version;
ok($vers);

my $lcm_dj   = List::Compare->new(\@a0, \@a1, \@a2, \@a3, \@a4, \@a8);

ok($lcm_dj);

$disj = $lcm_dj->is_LdisjointR;
ok(! $disj);

$disj = $lcm_dj->is_LdisjointR(2,3);
ok(! $disj);

$disj = $lcm_dj->is_LdisjointR(4,5);
ok($disj);

eval { $disj = $lcm_dj->is_LdisjointR(2) };
ok(ok_capture_error($@));

########## BELOW:  Tests for '-u' option ##########

my $lcmu   = List::Compare->new('-u', \@a0, \@a1, \@a2, \@a3, \@a4);

ok($lcmu);

@union = $lcmu->get_union;
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

$union_ref = $lcmu->get_union_ref;
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

@shared = $lcmu->get_shared;
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

$shared_ref = $lcmu->get_shared_ref;
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

@intersection = $lcmu->get_intersection;
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

$intersection_ref = $lcmu->get_intersection_ref;
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

@unique = $lcmu->get_unique(2);
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

$unique_ref = $lcmu->get_unique_ref(2);
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

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmu->get_Lonly_ref(2);
}
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

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcmu->get_Aonly(2);
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmu->get_Aonly_ref(2);
}
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

@unique = $lcmu->get_unique;
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

$unique_ref = $lcmu->get_unique_ref;
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

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcmu->get_Lonly;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmu->get_Lonly_ref;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcmu->get_Aonly;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmu->get_Aonly_ref;
}
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

@complement = $lcmu->get_complement(1);
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

$complement_ref = $lcmu->get_complement_ref(1);
$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmu->get_Ronly(1);
}
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmu->get_Ronly_ref(1);
}
$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmu->get_Bonly(1);
}
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmu->get_Bonly_ref(1);
}
$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});
ok(! exists $seen{'baker'});
ok(! exists $seen{'camera'});
ok(! exists $seen{'delta'});
ok(! exists $seen{'edward'});
ok(! exists $seen{'fargo'});
ok(! exists $seen{'golfer'});
ok(! exists $seen{'hilton'});
ok(exists $seen{'icon'});
ok(exists $seen{'jerky'});
%seen = ();

@complement = $lcmu->get_complement;
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

$complement_ref = $lcmu->get_complement_ref;
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

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmu->get_Ronly;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmu->get_Ronly_ref;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmu->get_Bonly;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmu->get_Bonly_ref;
}
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

@symmetric_difference = $lcmu->get_symmetric_difference;
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

$symmetric_difference_ref = $lcmu->get_symmetric_difference_ref;
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

@symmetric_difference = $lcmu->get_symdiff;
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

$symmetric_difference_ref = $lcmu->get_symdiff_ref;
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

{
    local $SIG{__WARN__} = \&_capture;
    @symmetric_difference = $lcmu->get_LorRonly;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $symmetric_difference_ref = $lcmu->get_LorRonly_ref;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    @symmetric_difference = $lcmu->get_AorBonly;
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $symmetric_difference_ref = $lcmu->get_AorBonly_ref;
}
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

@nonintersection = $lcmu->get_nonintersection;
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

$nonintersection_ref = $lcmu->get_nonintersection_ref;
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

@bag = $lcmu->get_bag;
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

$bag_ref = $lcmu->get_bag_ref;
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

$LR = $lcmu->is_LsubsetR(3,2);
ok($LR);

$LR = $lcmu->is_AsubsetB(3,2);
ok($LR);

$LR = $lcmu->is_LsubsetR(2,3);
ok(! $LR);

$LR = $lcmu->is_AsubsetB(2,3);
ok(! $LR);

$LR = $lcmu->is_LsubsetR;
ok(! $LR);

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcmu->is_RsubsetL;
}
ok(! $RL);

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcmu->is_BsubsetA;
}
ok(! $RL);

$eqv = $lcmu->is_LequivalentR(3,4);
ok($eqv);

$eqv = $lcmu->is_LeqvlntR(3,4);
ok($eqv);

$eqv = $lcmu->is_LequivalentR(2,4);
ok(! $eqv);

$return = $lcmu->print_subset_chart;
ok($return);

$return = $lcmu->print_equivalence_chart;
ok($return);

@memb_arr = $lcmu->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0        > ] ));

@memb_arr = $lcmu->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1      > ] ));

@memb_arr = $lcmu->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1      > ] ));

@memb_arr = $lcmu->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1      > ] ));

@memb_arr = $lcmu->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1      > ] ));

@memb_arr = $lcmu->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));

@memb_arr = $lcmu->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));

@memb_arr = $lcmu->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 4, [ qw<   1 2 3 4 > ] ));

@memb_arr = $lcmu->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   3, [ qw<     2 3 4 > ] ));

@memb_arr = $lcmu->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  1, [ qw<     2     > ] ));

@memb_arr = $lcmu->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<           > ] ));

$memb_arr_ref = $lcmu->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0        > ] ));

$memb_arr_ref = $lcmu->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1      > ] ));

$memb_arr_ref = $lcmu->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1      > ] ));

$memb_arr_ref = $lcmu->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1      > ] ));

$memb_arr_ref = $lcmu->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1      > ] ));

$memb_arr_ref = $lcmu->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));

$memb_arr_ref = $lcmu->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));

$memb_arr_ref = $lcmu->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));

$memb_arr_ref = $lcmu->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   3, [ qw<     2 3 4 > ] ));

$memb_arr_ref = $lcmu->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  1, [ qw<     2     > ] ));

$memb_arr_ref = $lcmu->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<           > ] ));

$memb_hash_ref = $lcmu->are_members_which(
    [ qw| abel baker camera delta edward fargo
          golfer hilton icon jerky zebra | ] );
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0         > ] ));
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1       > ] ));
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1       > ] ));
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1       > ] ));
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1       > ] ));
ok(ok_seen_h( $memb_hash_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'icon',   3, [ qw<     2 3 4 > ] ));
ok(ok_seen_h( $memb_hash_ref, 'jerky',  1, [ qw<     2     > ] ));
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<           > ] ));


ok($lcmu->is_member_any('abel'));
ok($lcmu->is_member_any('baker'));
ok($lcmu->is_member_any('camera'));
ok($lcmu->is_member_any('delta'));
ok($lcmu->is_member_any('edward'));
ok($lcmu->is_member_any('fargo'));
ok($lcmu->is_member_any('golfer'));
ok($lcmu->is_member_any('hilton'));
ok($lcmu->is_member_any('icon' ));
ok($lcmu->is_member_any('jerky'));
ok(! $lcmu->is_member_any('zebra'));

$memb_hash_ref = $lcmu->are_members_any(
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
ok(ok_any_h( $memb_hash_ref, 'icon',   1 ));
ok(ok_any_h( $memb_hash_ref, 'jerky',  1 ));
ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));

$vers = $lcmu->get_version;
ok($vers);

my $lcmu_dj   = List::Compare->new(\@a0, \@a1, \@a2, \@a3, \@a4, \@a8);

ok($lcmu_dj);

$disj = $lcmu_dj->is_LdisjointR;
ok(! $disj);

$disj = $lcmu_dj->is_LdisjointR(2,3);
ok(! $disj);

$disj = $lcmu_dj->is_LdisjointR(4,5);
ok($disj);

########## BELOW:  Test for '--unsorted' option ##########

my $lcmun   = List::Compare->new('--unsorted', \@a0, \@a1, \@a2, \@a3, \@a4);

ok($lcmun);

########## BELOW:  Testfor bad arguments to constructor ##########

my ($lcm_bad);
my %h5 = (
    golfer   => 1,
    lambda   => 0,
);

eval { $lcm_bad = List::Compare->new('-a', \@a0, \@a1, \@a2, \@a3, \%h5) };
ok(ok_capture_error($@));

eval { $lcm_bad = List::Compare->new('-a', \%h5, \@a0, \@a1, \@a2, \@a3) };
ok(ok_capture_error($@));





