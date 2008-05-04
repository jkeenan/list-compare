# perl
#$Id$
# 03_multiple.t
use Test::More tests => 212;
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
ok(wrap_are_members_any(
    $memb_hash_ref,
    $test_members_any,
), "are_members_any() returned all expected values");

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

########## BELOW:  Tests for '-u' option ##########

### new ###
my $lcmu   = List::Compare->new('-u', \@a0, \@a1, \@a2, \@a3, \@a4);
ok($lcmu, "List::Compare constructor returned true value");

%pred = map {$_, 1} qw( abel baker camera delta edward fargo golfer hilton icon jerky );
@unpred = qw| kappa |;
@union = $lcmu->get_union;
$seen{$_}++ foreach (@union);
is_deeply(\%seen, \%pred, "unsorted:  got expected union");
ok(unseen(\%seen, \@unpred),
    "union:  All non-expected elements correctly excluded");
%seen = ();

$union_ref = $lcmu->get_union_ref;
$seen{$_}++ foreach (@{$union_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected union");
ok(unseen(\%seen, \@unpred),
    "union:  All non-expected elements correctly excluded");
%seen = ();

%pred = map {$_, 1} qw( baker camera delta edward fargo golfer hilton icon );
@unpred = qw| abel jerky |;
@shared = $lcmu->get_shared;
$seen{$_}++ foreach (@shared);
is_deeply(\%seen, \%pred, "unsorted:  got expected shared");
ok(unseen(\%seen, \@unpred),
    "shared:  All non-expected elements correctly excluded");
%seen = ();

$shared_ref = $lcmu->get_shared_ref;
$seen{$_}++ foreach (@{$shared_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected shared");
ok(unseen(\%seen, \@unpred),
    "shared:  All non-expected elements correctly excluded");
%seen = ();

%pred = map {$_, 1} qw( fargo golfer );
@unpred = qw| abel baker camera delta edward hilton icon jerky |;
@intersection = $lcmu->get_intersection;
$seen{$_}++ foreach (@intersection);
is_deeply(\%seen, \%pred, "unsorted:  got expected intersection");
ok(unseen(\%seen, \@unpred),
    "intersection:  All non-expected elements correctly excluded");
%seen = ();

$intersection_ref = $lcmu->get_intersection_ref;
$seen{$_}++ foreach (@{$intersection_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected intersection");
ok(unseen(\%seen, \@unpred),
    "intersection:  All non-expected elements correctly excluded");
%seen = ();

%pred = map {$_, 1} qw( jerky );
@unpred = qw| abel baker camera delta edward fargo golfer hilton icon |;
@unique = $lcmu->get_unique(2);
$seen{$_}++ foreach (@unique);
is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
ok(unseen(\%seen, \@unpred),
    "unique:  All non-expected elements correctly excluded");
%seen = ();

$unique_ref = $lcmu->get_unique_ref(2);
$seen{$_}++ foreach (@{$unique_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
ok(unseen(\%seen, \@unpred),
    "unique:  All non-expected elements correctly excluded");
%seen = ();

{
    my ($stdout, $stderr);
    capture(
        sub { @unique = $lcmu->get_Lonly(2); },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@unique);
    is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
    ok(unseen(\%seen, \@unpred),
        "unique:  All non-expected elements correctly excluded");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Lonly or its alias defaults/,
        "Got expected warning"
    );
}
%seen = ();

{
    my ($stdout, $stderr);
    capture(
        sub { $unique_ref = $lcmu->get_Lonly_ref(2); },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@{$unique_ref});
    is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
    ok(unseen(\%seen, \@unpred),
        "unique:  All non-expected elements correctly excluded");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Lonly_ref or its alias defaults/,
        "Got expected warning"
    );
}
%seen = ();

{
    my ($stdout, $stderr);
    capture(
        sub { @unique = $lcmu->get_Aonly(2); },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@unique);
    is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
    ok(unseen(\%seen, \@unpred),
        "unique:  All non-expected elements correctly excluded");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Lonly or its alias defaults/,
        "Got expected warning"
    );
}
%seen = ();

{
    my ($stdout, $stderr);
    capture(
        sub { $unique_ref = $lcmu->get_Aonly_ref(2); },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@{$unique_ref});
    is_deeply(\%seen, \%pred, "unsorted:  got expected unique");
    ok(unseen(\%seen, \@unpred),
        "unique:  All non-expected elements correctly excluded");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Lonly_ref or its alias defaults/,
        "Got expected warning"
    );
}
%seen = ();

%pred = map {$_, 1} qw( abel icon jerky );
@unpred = qw| baker camera delta edward fargo golfer hilton |;
@complement = $lcmu->get_complement(1);
$seen{$_}++ foreach (@complement);
is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
ok(unseen(\%seen, \@unpred),
    "complement:  All non-expected elements correctly excluded");
%seen = ();

$complement_ref = $lcmu->get_complement_ref(1);
$seen{$_}++ foreach (@{$complement_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
ok(unseen(\%seen, \@unpred),
    "complement:  All non-expected elements correctly excluded");
%seen = ();

{
    my ($stdout, $stderr);
    capture(
        sub { @complement = $lcmu->get_Bonly(1); },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@complement);
    is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
    ok(unseen(\%seen, \@unpred),
        "complement:  All non-expected elements correctly excluded");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Ronly or its alias defaults/,
        "Got expected warning"
    );
}
%seen = ();

{
    my ($stdout, $stderr);
    capture(
        sub { $complement_ref = $lcmu->get_Bonly_ref(1); },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@{$complement_ref});
    is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
    ok(unseen(\%seen, \@unpred),
        "complement:  All non-expected elements correctly excluded");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Ronly_ref or its alias defaults/,
        "Got expected warning"
    );
}
%seen = ();

%pred = map {$_, 1} qw( hilton icon jerky );
@unpred = qw| abel baker camera delta edward fargo golfer |;
@complement = $lcmu->get_complement;
$seen{$_}++ foreach (@complement);
is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
ok(unseen(\%seen, \@unpred),
    "complement:  All non-expected elements correctly excluded");
%seen = ();

$complement_ref = $lcmu->get_complement_ref;
$seen{$_}++ foreach (@{$complement_ref});
is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
ok(unseen(\%seen, \@unpred),
    "complement:  All non-expected elements correctly excluded");
%seen = ();

{
    my ($stdout, $stderr);
    capture(
        sub { @complement = $lcmu->get_Ronly; },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@complement);
    is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
    ok(unseen(\%seen, \@unpred),
        "complement:  All non-expected elements correctly excluded");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Ronly or its alias defaults/,
        "Got expected warning"
    );
}
%seen = ();

{
    my ($stdout, $stderr);
    capture(
        sub { $complement_ref = $lcmu->get_Ronly_ref; },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@{$complement_ref});
    is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
    ok(unseen(\%seen, \@unpred),
        "complement:  All non-expected elements correctly excluded");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Ronly_ref or its alias defaults/,
        "Got expected warning"
    );
}
%seen = ();

{
    my ($stdout, $stderr);
    capture(
        sub { @complement = $lcmu->get_Bonly; },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@complement);
    is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
    ok(unseen(\%seen, \@unpred),
        "complement:  All non-expected elements correctly excluded");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Ronly or its alias defaults/,
        "Got expected warning"
    );
}
%seen = ();

{
    my ($stdout, $stderr);
    capture(
        sub { $complement_ref = $lcmu->get_Bonly_ref; },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@{$complement_ref});
    is_deeply(\%seen, \%pred, "unsorted:  got expected complement");
    ok(unseen(\%seen, \@unpred),
        "complement:  All non-expected elements correctly excluded");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_Ronly_ref or its alias defaults/,
        "Got expected warning"
    );
}
%seen = ();

%pred = map {$_, 1} qw( abel jerky );
@unpred = qw| baker camera delta edward fargo golfer hilton icon |;
@symmetric_difference = $lcmu->get_symmetric_difference;
$seen{$_}++ foreach (@symmetric_difference);
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

$symmetric_difference_ref = $lcmu->get_symmetric_difference_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

@symmetric_difference = $lcmu->get_symdiff;
$seen{$_}++ foreach (@symmetric_difference);
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

$symmetric_difference_ref = $lcmu->get_symdiff_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
ok(unseen(\%seen, \@unpred),
    "symmetric difference:  All non-expected elements correctly excluded");
%seen = ();

{
    my ($stdout, $stderr);
    capture(
        sub { @symmetric_difference = $lcmu->get_LorRonly; },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@symmetric_difference);
    is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
    ok(unseen(\%seen, \@unpred),
        "symmetric difference:  All non-expected elements correctly excluded");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_LorRonly or its alias defaults/,
        "Got expected warning",
    );
}
%seen = ();

{
    my ($stdout, $stderr);
    capture(
        sub { $symmetric_difference_ref = $lcmu->get_LorRonly_ref; },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@{$symmetric_difference_ref});
    is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
    ok(unseen(\%seen, \@unpred),
        "symmetric difference:  All non-expected elements correctly excluded");
}
%seen = ();

{
    my ($stdout, $stderr);
    capture(
        sub { @symmetric_difference = $lcmu->get_AorBonly; },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@symmetric_difference);
    is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
    ok(unseen(\%seen, \@unpred),
        "symmetric difference:  All non-expected elements correctly excluded");
    like($stderr,
        qr/When comparing 3 or more lists, \&get_LorRonly or its alias defaults/,
        "Got expected warning",
    );
}
%seen = ();

{
    my ($stdout, $stderr);
    capture(
        sub { $symmetric_difference_ref = $lcmu->get_AorBonly_ref; },
        \$stdout,
        \$stderr,
    );
    $seen{$_}++ foreach (@{$symmetric_difference_ref});
    is_deeply(\%seen, \%pred, "unsorted:  Got expected symmetric difference");
    ok(unseen(\%seen, \@unpred),
        "symmetric difference:  All non-expected elements correctly excluded");
}
%seen = ();

%pred = map {$_, 1} qw( abel baker camera delta edward hilton icon jerky );
@unpred = qw| fargo golfer |;
@nonintersection = $lcmu->get_nonintersection;
$seen{$_}++ foreach (@nonintersection);
is_deeply(\%seen, \%pred, "unsorted:  Got expected nonintersection");
ok(unseen(\%seen, \@unpred),
    "nonintersection:  All non-expected elements correctly excluded");
%seen = ();

$nonintersection_ref = $lcmu->get_nonintersection_ref;
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
    fargo   => 6,
    golfer  => 5,
    hilton  => 4,
    icon    => 5,
    jerky   => 1,
);
@unpred = qw| kappa |;
@bag = $lcmu->get_bag;
$seen{$_}++ foreach (@bag);
is_deeply(\%seen, \%pred, "Got predicted quantities in bag");
ok(unseen(\%seen, \@unpred),
    "bag:  All non-expected elements correctly excluded");
%seen = ();

$bag_ref = $lcmu->get_bag_ref;
$seen{$_}++ foreach (@{$bag_ref});
is_deeply(\%seen, \%pred, "Got predicted quantities in bag");
ok(unseen(\%seen, \@unpred),
    "bag:  All non-expected elements correctly excluded");
%seen = ();

$LR = $lcmu->is_LsubsetR(3,2);
ok($LR, "Got expected subset relationship");

$LR = $lcmu->is_AsubsetB(3,2);
ok($LR, "Got expected subset relationship");

$LR = $lcmu->is_LsubsetR(2,3);
ok(! $LR, "Got expected subset relationship");

$LR = $lcmu->is_AsubsetB(2,3);
ok(! $LR, "Got expected subset relationship");

$LR = $lcmu->is_LsubsetR;
ok(! $LR, "Got expected subset relationship");

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $RL = $lcmu->is_RsubsetL; },
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
        sub { $RL = $lcmu->is_BsubsetA; },
        \$stdout,
        \$stderr,
    );
    ok(! $RL, "Got expected subset relationship");
    like($stderr,
        qr/When comparing 3 or more lists, \&is_RsubsetL or its alias is restricted/,
        "Got expected warning",
    );
}

$eqv = $lcmu->is_LequivalentR(3,4);
ok($eqv, "Got expected equivalence relationship");

$eqv = $lcmu->is_LeqvlntR(3,4);
ok($eqv, "Got expected equivalence relationship");

$eqv = $lcmu->is_LequivalentR(2,4);
ok(! $eqv, "Got expected equivalence relationship");

{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $rv = $lcmu->print_subset_chart; },
        \$stdout,
    );
    ok($rv, "print_subset_chart() returned true value");
    like($stdout, qr/Subset Relationships/,
        "Got expected chart header");
}
{
    my ($rv, $stdout, $stderr);
    capture(
        sub { $rv = $lcmu->print_equivalence_chart; },
        \$stdout,
    );
    ok($rv, "print_equivalence_chart() returned true value");
    like($stdout, qr/Equivalence Relationships/,
        "Got expected chart header");
}

ok(wrap_is_member_which(
    $lcmu,
    $test_members_which,
), "is_member_which() returned all expected values");

ok(wrap_is_member_which_ref(
    $lcmu,
    $test_members_which,
), "is_member_which_ref() returned all expected values");

$memb_hash_ref = $lcmu->are_members_which(
    [ qw| abel baker camera delta edward fargo
          golfer hilton icon jerky zebra | ] );
ok(wrap_are_members_which(
    $memb_hash_ref,
    $test_members_which,
), "are_members_which() returned all expected values");

ok(wrap_is_member_any(
    $lcmu,
    $test_members_any,
), "is_member_any() returned all expected values");

$memb_hash_ref = $lcmu->are_members_any(
    [ qw| abel baker camera delta edward fargo
          golfer hilton icon jerky zebra | ] );
ok(wrap_are_members_any(
    $memb_hash_ref,
    $test_members_any,
), "are_members_any() returned all expected values");

$vers = $lcmu->get_version;
ok($vers, "get_version() returned true value");

### new ###
my $lcmu_dj   = List::Compare->new(\@a0, \@a1, \@a2, \@a3, \@a4, \@a8);
ok($lcmu_dj, "List::Compare constructor returned true value");

$disj = $lcmu_dj->is_LdisjointR;
ok(! $disj, "Got expected disjoint relationship");

$disj = $lcmu_dj->is_LdisjointR(2,3);
ok(! $disj, "Got expected disjoint relationship");

$disj = $lcmu_dj->is_LdisjointR(4,5);
ok($disj, "Got expected disjoint relationship");

########## BELOW:  Test for '--unsorted' option ##########

my $lcmun   = List::Compare->new('--unsorted', \@a0, \@a1, \@a2, \@a3, \@a4);
ok($lcmu_dj, "List::Compare constructor returned true value");

########## BELOW:  Testfor bad arguments to constructor ##########

my ($lcm_bad);
my %h5 = (
    golfer   => 1,
    lambda   => 0,
);

eval { $lcm_bad = List::Compare->new('-u', \@a0, \@a1, \@a2, \@a3, \%h5) };
like($@, qr/Must pass all array references or all hash references/,
    "Got expected error message from bad constructor");

eval { $lcm_bad = List::Compare->new('-u', \%h5, \@a0, \@a1, \@a2, \@a3) };
like($@, qr/Must pass all array references or all hash references/,
    "Got expected error message from bad constructor");

my $scalar = 'test';
eval { $lcm_bad = List::Compare->new(\$scalar, \@a0, \@a1) };
like($@, qr/Must pass all array references or all hash references/,
    "Got expected error message from bad constructor");
