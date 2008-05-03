# perl
#$Id$
# 03_multiple.t
use Test::More qw(no_plan); # tests => 178;
use List::Compare;
use lib ("./t");
use Test::ListCompareSpecial qw( :seen :wrap );
use IO::CaptureOutput qw( capture );

my @pred = ();
my %seen = ();
my %pred = ();
my @unpred = ();
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

my $test_members_which = {
    abel        => [ 1, [ qw< 0         > ] ],
    baker       => [ 2, [ qw< 0 1       > ] ],
    camera      => [ 2, [ qw< 0 1       > ] ],
    delta       => [ 2, [ qw< 0 1       > ] ],
    edward      => [ 2, [ qw< 0 1       > ] ],
    fargo       => [ 5, [ qw< 0 1 2 3 4 > ] ],
    golfer      => [ 5, [ qw< 0 1 2 3 4 > ] ],
    hilton      => [ 4, [ qw<   1 2 3 4 > ] ],
    icon        => [ 3, [ qw<     2 3 4 > ] ],
    jerky       => [ 1, [ qw<     2     > ] ],
    zebra       => [ 0, [ qw<           > ] ],
};

### new ###
my $lcm   = List::Compare->new(\@a0, \@a1, \@a2, \@a3, \@a4);
ok($lcm, "List::Compare constructor returned true value");

@pred = qw(abel baker camera delta edward fargo golfer hilton icon jerky);
@union = $lcm->get_union;
is_deeply( \@union, \@pred, "Got expected union");

$union_ref = $lcm->get_union_ref;
is_deeply( $union_ref, \@pred, "Got expected union");

@pred = qw(baker camera delta edward fargo golfer hilton icon);
@shared = $lcm->get_shared;
is_deeply( \@shared, \@pred, "Got expected shared");

$shared_ref = $lcm->get_shared_ref;
is_deeply( $shared_ref, \@pred, "Got expected shared");

@pred = qw(fargo golfer);
@intersection = $lcm->get_intersection;
is_deeply(\@intersection, \@pred, "Got expected intersection");

$intersection_ref = $lcm->get_intersection_ref;
is_deeply($intersection_ref, \@pred, "Got expected intersection");

@pred = qw( jerky );
@unique = $lcm->get_unique(2);
is_deeply(\@unique, \@pred, "Got expected unique");

$unique_ref = $lcm->get_unique_ref(2);
is_deeply($unique_ref, \@pred, "Got expected unique");

eval { $unique_ref = $lcm->get_unique_ref('jerky') };
like($@,
    qr/Argument to method List::Compare::Multiple::get_unique_ref must be the array index/,
    "Got expected error message"
);

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { @unique = $lcm->get_Lonly(2); },
        \$stdout,
        \$stderr,
    );
    is_deeply(\@unique, \@pred, "Got expected unique");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Lonly or its alias defaults/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $unique_ref = $lcm->get_Lonly_ref(2); },
        \$stdout,
        \$stderr,
    );
    is_deeply($unique_ref, \@pred, "Got expected unique");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Lonly_ref or its alias defaults/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { @unique = $lcm->get_Aonly(2); },
        \$stdout,
        \$stderr,
    );
    is_deeply(\@unique, \@pred, "Got expected unique");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Lonly or its alias defaults/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $unique_ref = $lcm->get_Aonly_ref(2); },
        \$stdout,
        \$stderr,
    );
    is_deeply($unique_ref, \@pred, "Got expected unique");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Lonly_ref or its alias defaults/,
        "Got expected warning",
    );
}

@pred = qw( abel );
@unique = $lcm->get_unique;
is_deeply(\@unique, \@pred, "Got expected unique");

$unique_ref = $lcm->get_unique_ref;
is_deeply($unique_ref, \@pred, "Got expected unique");

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { @unique = $lcm->get_Lonly(); },
        \$stdout,
        \$stderr,
    );
    is_deeply(\@unique, \@pred, "Got expected unique");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Lonly or its alias defaults/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $unique_ref = $lcm->get_Lonly_ref(); },
        \$stdout,
        \$stderr,
    );
    is_deeply($unique_ref, \@pred, "Got expected unique");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Lonly_ref or its alias defaults/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { @unique = $lcm->get_Aonly(); },
        \$stdout,
        \$stderr,
    );
    is_deeply(\@unique, \@pred, "Got expected unique");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Lonly or its alias defaults/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $unique_ref = $lcm->get_Aonly_ref(); },
        \$stdout,
        \$stderr,
    );
    is_deeply($unique_ref, \@pred, "Got expected unique");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Lonly_ref or its alias defaults/,
        "Got expected warning",
    );
}

@pred = qw( abel icon jerky );
@complement = $lcm->get_complement(1);
is_deeply(\@complement, \@pred, "Got expected complement");

$complement_ref = $lcm->get_complement_ref(1);
is_deeply($complement_ref, \@pred, "Got expected complement");

eval { $complement_ref = $lcm->get_complement_ref('jerky') };
like($@,
    qr/Argument to method List::Compare::Multiple::get_complement_ref must be the array index/,
    "Got expected error message"
);

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { @complement = $lcm->get_Ronly(1); },
        \$stdout,
        \$stderr,
    );
    is_deeply(\@complement, \@pred, "Got expected complement");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Ronly or its alias defaults/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $complement_ref = $lcm->get_Ronly_ref(1); },
        \$stdout,
        \$stderr,
    );
    is_deeply($complement_ref, \@pred, "Got expected complement");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Ronly_ref or its alias defaults/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { @complement = $lcm->get_Bonly(1); },
        \$stdout,
        \$stderr,
    );
    is_deeply(\@complement, \@pred, "Got expected complement");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Ronly or its alias defaults/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $complement_ref = $lcm->get_Bonly_ref(1); },
        \$stdout,
        \$stderr,
    );
    is_deeply($complement_ref, \@pred, "Got expected complement");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Ronly_ref or its alias defaults/,
        "Got expected warning",
    );
}

@pred = qw ( hilton icon jerky );
@complement = $lcm->get_complement;
is_deeply(\@complement, \@pred, "Got expected complement");

$complement_ref = $lcm->get_complement_ref;
is_deeply($complement_ref, \@pred, "Got expected complement");

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { @complement = $lcm->get_Ronly(); },
        \$stdout,
        \$stderr,
    );
    is_deeply(\@complement, \@pred, "Got expected complement");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Ronly or its alias defaults/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $complement_ref = $lcm->get_Ronly_ref(); },
        \$stdout,
        \$stderr,
    );
    is_deeply($complement_ref, \@pred, "Got expected complement");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Ronly_ref or its alias defaults/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { @complement = $lcm->get_Bonly(); },
        \$stdout,
        \$stderr,
    );
    is_deeply(\@complement, \@pred, "Got expected complement");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Ronly or its alias defaults/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $complement_ref = $lcm->get_Bonly_ref(); },
        \$stdout,
        \$stderr,
    );
    is_deeply($complement_ref, \@pred, "Got expected complement");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Ronly_ref or its alias defaults/,
        "Got expected warning",
    );
}

@pred = qw( abel jerky );
@symmetric_difference = $lcm->get_symmetric_difference;
is_deeply(\@symmetric_difference, \@pred, "Got expected symmetric_difference");

$symmetric_difference_ref = $lcm->get_symmetric_difference_ref;
is_deeply($symmetric_difference_ref, \@pred, "Got expected symmetric_difference");

@symmetric_difference = $lcm->get_symdiff;
is_deeply(\@symmetric_difference, \@pred, "Got expected symmetric_difference");

$symmetric_difference_ref = $lcm->get_symdiff_ref;
is_deeply($symmetric_difference_ref, \@pred, "Got expected symmetric_difference");

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { @symmetric_difference = $lcm->get_LorRonly; },
        \$stdout,
        \$stderr,
    );
    is_deeply(\@symmetric_difference, \@pred, "Got expected symmetric_difference");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_LorRonly or its alias defaults/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $symmetric_difference_ref = $lcm->get_LorRonly_ref; },
        \$stdout,
        \$stderr,
    );
    is_deeply($symmetric_difference_ref, \@pred, "Got expected symmetric_difference");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_LorRonly_ref or its alias defaults/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { @symmetric_difference = $lcm->get_AorBonly; },
        \$stdout,
        \$stderr,
    );
    is_deeply(\@symmetric_difference, \@pred, "Got expected symmetric_difference");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_LorRonly or its alias defaults/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $symmetric_difference_ref = $lcm->get_AorBonly_ref; },
        \$stdout,
        \$stderr,
    );
    is_deeply($symmetric_difference_ref, \@pred, "Got expected symmetric_difference");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_LorRonly_ref or its alias defaults/,
        "Got expected warning",
    );
}

@pred = qw( abel baker camera delta edward hilton icon jerky );
@nonintersection = $lcm->get_nonintersection;
is_deeply( \@nonintersection, \@pred, "Got expected nonintersection");

$nonintersection_ref = $lcm->get_nonintersection_ref;
is_deeply($nonintersection_ref, \@pred, "Got expected nonintersection");

@pred = qw( abel abel baker baker camera camera delta delta delta edward
edward fargo fargo fargo fargo fargo fargo golfer golfer golfer golfer golfer
hilton hilton hilton hilton icon icon icon icon icon jerky );
@bag = $lcm->get_bag;
is_deeply(\@bag, \@pred, "Got expected bag");

$bag_ref = $lcm->get_bag_ref;
is_deeply($bag_ref, \@pred, "Got expected bag");

$LR = $lcm->is_LsubsetR(3,2);
ok($LR, "Got expected subset relationship");

$LR = $lcm->is_AsubsetB(3,2);
ok($LR, "Got expected subset relationship");

$LR = $lcm->is_LsubsetR(2,3);
ok(! $LR, "Got expected subset relationship");

$LR = $lcm->is_AsubsetB(2,3);
ok(! $LR, "Got expected subset relationship");

$LR = $lcm->is_LsubsetR;
ok(! $LR, "Got expected subset relationship");

eval { $LR = $lcm->is_LsubsetR(2) };
like($@,
    qr/Method List::Compare::Multiple::is_LsubsetR requires 2 arguments/,
    "Got expected error message"
);

eval { $LR = $lcm->is_LsubsetR(8,9) };
like($@,
    qr/Each argument to method List::Compare::Multiple::is_LsubsetR must be a valid array index /,
    "Got expected error message"
);

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $RL = $lcm->is_RsubsetL; },
        \$stdout,
        \$stderr,
    );
    ok(! $RL, "Got expected subset relationship");
    like($stderr,
        qr/When comparing 3 or more lists, \&is_RsubsetL or its alias is restricted/,
        "Got expected warning",
    );
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $RL = $lcm->is_BsubsetA; },
        \$stdout,
        \$stderr,
    );
    ok(! $RL, "Got expected subset relationship");
    like($stderr,
        qr/When comparing 3 or more lists, \&is_RsubsetL or its alias is restricted/,
        "Got expected warning",
    );
}

$eqv = $lcm->is_LequivalentR(3,4);
ok($eqv, "Got expected equivalence relationship");

$eqv = $lcm->is_LeqvlntR(3,4);
ok($eqv, "Got expected equivalence relationship");

$eqv = $lcm->is_LequivalentR(2,4);
ok(! $eqv, "Got expected equivalence relationship");

eval { $eqv = $lcm->is_LequivalentR(2) };
like($@,
    qr/Method List::Compare::Multiple::is_LequivalentR requires 2 arguments/,
    "Got expected error message",
);

eval { $eqv = $lcm->is_LequivalentR(8,9) };
like($@,
    qr/Each argument to method List::Compare::Multiple::is_LequivalentR must be a valid array index/,
    "Got expected error message",
);

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $rv = $lcm->print_subset_chart; },
        \$stdout,
    );
    ok($rv, "print_subset_chart() returned true value");
    like($stdout, qr/Subset Relationships/,
        "Got expected chart header");
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $rv = $lcm->print_equivalence_chart; },
        \$stdout,
    );
    ok($rv, "print_equivalence_chart() returned true value");
    like($stdout, qr/Equivalence Relationships/,
        "Got expected chart header");
}

ok(wrap_is_member_which(
    $lcm,
    $test_members_which,
), "is_member_which() returned all expected values");

eval { $memb_arr_ref = $lcm->is_member_which('jerky', 'zebra') };
like($@, qr/Method call requires exactly 1 argument \(no references\)/,
        "is_member_which() correctly generated error message");

ok(wrap_is_member_which_ref(
    $lcm,
    $test_members_which,
), "is_member_which_ref() returned all expected values");

eval { $memb_arr_ref = $lcm->is_member_which_ref('jerky', 'zebra') };
like($@, qr/Method call requires exactly 1 argument \(no references\)/,
        "is_member_which_ref() correctly generated error message");

$memb_hash_ref = $lcm->are_members_which(
  [ qw| abel baker camera delta edward fargo
    golfer hilton icon jerky zebra | ]
);
ok(wrap_are_members_which(
    $memb_hash_ref,
    $test_members_which,
), "are_members_which() returned all expected values");

eval { $memb_hash_ref = $lcm->are_members_which( { key => 'value' } ) };
like($@,
    qr/Method call requires exactly 1 argument which must be an array reference/,
    "are_members_which() correctly generated error message");

ok(wrap_is_member_any(
    $lcm,
    $test_members_any,
), "is_member_any() returned all expected values");

eval { $lcm->is_member_any('jerky', 'zebra') };
like($@,
    qr/Method call requires exactly 1 argument \(no references\)/,
    "is_member_any() correctly generated error message");

$memb_hash_ref = $lcm->are_members_any(
    [ qw| abel baker camera delta edward fargo golfer hilton icon jerky zebra | ] );
ok(wrap_is_member_any(
    $lcm,
    $test_members_any,
), "is_member_any() returned all expected values");

eval { $memb_hash_ref = $lcm->are_members_any( { key => 'value' } ) };
like($@,
    qr/Method call requires exactly 1 argument which must be an array reference/,
    "are_members_any() correctly generated error message");

$vers = $lcm->get_version;
ok($vers, "get_version() returned true value");

### new ###
my $lcm_dj   = List::Compare->new(\@a0, \@a1, \@a2, \@a3, \@a4, \@a8);
ok($lcm_dj, "Constructor returned true value");

$disj = $lcm_dj->is_LdisjointR;
ok(! $disj, "Got expected disjoint relationship");

$disj = $lcm_dj->is_LdisjointR(2,3);
ok(! $disj, "Got expected disjoint relationship");

$disj = $lcm_dj->is_LdisjointR(4,5);
ok($disj, "Got expected disjoint relationship");

eval { $disj = $lcm_dj->is_LdisjointR(2) };
like($@, qr/Method List::Compare::Multiple::is_LdisjointR requires 2 arguments/,
    "Got expected error message");

# __END__
########## BELOW:  Tests for '-u' option ##########

### new ###
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

### new ###
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





