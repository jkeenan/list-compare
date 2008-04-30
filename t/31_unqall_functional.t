# 31_unqall_functional.t  # as of 8/10/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
177;
use lib ("./t");
use List::Compare::Functional qw(
    get_unique_all
    get_complement_all
);
use Test::ListCompareSpecial qw(:seen);

$loaded = 1;
ok($loaded);

######################### End of black magic.

my (%seen, @seen);
my ($unique_all_ref, $complement_all_ref);

my @a0 = qw(abel abel baker camera delta edward fargo golfer);
my @a1 = qw(baker camera delta delta edward fargo golfer hilton);
my @a2 = qw(fargo golfer hilton icon icon jerky);
my @a3 = qw(fargo golfer hilton icon icon);
my @a4 = qw(fargo fargo golfer hilton icon);

my (%h0, %h1, %h2, %h3, %h4);
$h0{$_}++ for @a0;
$h1{$_}++ for @a1;
$h2{$_}++ for @a2;
$h3{$_}++ for @a3;
$h4{$_}++ for @a4;

##########
## 07 equivalent

$unique_all_ref = get_unique_all( [ \@a0, \@a1 ] );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'hilton');

$complement_all_ref = get_complement_all( [ \@a0, \@a1 ] );
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'hilton');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'abel');

##########
## 08 equivalent

$unique_all_ref = get_unique_all( [ \%h0, \%h1 ] );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'hilton');

$complement_all_ref = get_complement_all( [ \%h0, \%h1 ] );
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'hilton');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'abel');

##########
## 11 equivalent

$unique_all_ref = get_unique_all( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(! @{$seen[1]});
ok(@{$seen[2]} == 1);
ok($seen[2][0] eq 'jerky');
ok(! @{$seen[3]});
ok(! @{$seen[4]});

$complement_all_ref = get_complement_all( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);
ok($seen[0][0] eq 'hilton');
ok($seen[0][1] eq 'icon');
ok($seen[0][2] eq 'jerky');
ok(@{$seen[1]} == 3);
ok($seen[1][0] eq 'abel');
ok($seen[1][1] eq 'icon');
ok($seen[1][2] eq 'jerky');
ok(@{$seen[2]} == 5);
ok($seen[2][0] eq 'abel');
ok($seen[2][1] eq 'baker');
ok($seen[2][2] eq 'camera');
ok($seen[2][3] eq 'delta');
ok($seen[2][4] eq 'edward');
ok(@{$seen[3]} == 6);
ok($seen[3][0] eq 'abel');
ok($seen[3][1] eq 'baker');
ok($seen[3][2] eq 'camera');
ok($seen[3][3] eq 'delta');
ok($seen[3][4] eq 'edward');
ok($seen[3][5] eq 'jerky');
ok(@{$seen[4]} == 6);
ok($seen[4][0] eq 'abel');
ok($seen[4][1] eq 'baker');
ok($seen[4][2] eq 'camera');
ok($seen[4][3] eq 'delta');
ok($seen[4][4] eq 'edward');
ok($seen[4][5] eq 'jerky');

##########
## 12 equivalent

$unique_all_ref = get_unique_all( [ \%h0, \%h1, \%h2, \%h3, \%h4 ] );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(! @{$seen[1]});
ok(@{$seen[2]} == 1);
ok($seen[2][0] eq 'jerky');
ok(! @{$seen[3]});
ok(! @{$seen[4]});

$complement_all_ref = get_complement_all( [ \%h0, \%h1, \%h2, \%h3, \%h4 ] );
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);
ok($seen[0][0] eq 'hilton');
ok($seen[0][1] eq 'icon');
ok($seen[0][2] eq 'jerky');
ok(@{$seen[1]} == 3);
ok($seen[1][0] eq 'abel');
ok($seen[1][1] eq 'icon');
ok($seen[1][2] eq 'jerky');
ok(@{$seen[2]} == 5);
ok($seen[2][0] eq 'abel');
ok($seen[2][1] eq 'baker');
ok($seen[2][2] eq 'camera');
ok($seen[2][3] eq 'delta');
ok($seen[2][4] eq 'edward');
ok(@{$seen[3]} == 6);
ok($seen[3][0] eq 'abel');
ok($seen[3][1] eq 'baker');
ok($seen[3][2] eq 'camera');
ok($seen[3][3] eq 'delta');
ok($seen[3][4] eq 'edward');
ok($seen[3][5] eq 'jerky');
ok(@{$seen[4]} == 6);
ok($seen[4][0] eq 'abel');
ok($seen[4][1] eq 'baker');
ok($seen[4][2] eq 'camera');
ok($seen[4][3] eq 'delta');
ok($seen[4][4] eq 'edward');
ok($seen[4][5] eq 'jerky');

##########
## 25 equivalent

$unique_all_ref = get_unique_all( { lists => [ \@a0, \@a1 ] } );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'hilton');

$complement_all_ref = get_complement_all( { lists => [ \@a0, \@a1 ] } );
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'hilton');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'abel');

##########
## 26 equivalent

$unique_all_ref = get_unique_all( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(! @{$seen[1]});
ok(@{$seen[2]} == 1);
ok($seen[2][0] eq 'jerky');
ok(! @{$seen[3]});
ok(! @{$seen[4]});

$complement_all_ref = get_complement_all( 
    { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] }
);
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);
ok($seen[0][0] eq 'hilton');
ok($seen[0][1] eq 'icon');
ok($seen[0][2] eq 'jerky');
ok(@{$seen[1]} == 3);
ok($seen[1][0] eq 'abel');
ok($seen[1][1] eq 'icon');
ok($seen[1][2] eq 'jerky');
ok(@{$seen[2]} == 5);
ok($seen[2][0] eq 'abel');
ok($seen[2][1] eq 'baker');
ok($seen[2][2] eq 'camera');
ok($seen[2][3] eq 'delta');
ok($seen[2][4] eq 'edward');
ok(@{$seen[3]} == 6);
ok($seen[3][0] eq 'abel');
ok($seen[3][1] eq 'baker');
ok($seen[3][2] eq 'camera');
ok($seen[3][3] eq 'delta');
ok($seen[3][4] eq 'edward');
ok($seen[3][5] eq 'jerky');
ok(@{$seen[4]} == 6);
ok($seen[4][0] eq 'abel');
ok($seen[4][1] eq 'baker');
ok($seen[4][2] eq 'camera');
ok($seen[4][3] eq 'delta');
ok($seen[4][4] eq 'edward');
ok($seen[4][5] eq 'jerky');

##########
## 27 equivalent

$unique_all_ref = get_unique_all( { lists => [ \%h0, \%h1 ] } );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'hilton');

$complement_all_ref = get_complement_all( { lists => [ \%h0, \%h1 ] } );
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'hilton');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'abel');

##########
## 28 equivalent

$unique_all_ref = get_unique_all( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(! @{$seen[1]});
ok(@{$seen[2]} == 1);
ok($seen[2][0] eq 'jerky');
ok(! @{$seen[3]});
ok(! @{$seen[4]});

$complement_all_ref = get_complement_all(
    { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] }
);
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);
ok($seen[0][0] eq 'hilton');
ok($seen[0][1] eq 'icon');
ok($seen[0][2] eq 'jerky');
ok(@{$seen[1]} == 3);
ok($seen[1][0] eq 'abel');
ok($seen[1][1] eq 'icon');
ok($seen[1][2] eq 'jerky');
ok(@{$seen[2]} == 5);
ok($seen[2][0] eq 'abel');
ok($seen[2][1] eq 'baker');
ok($seen[2][2] eq 'camera');
ok($seen[2][3] eq 'delta');
ok($seen[2][4] eq 'edward');
ok(@{$seen[3]} == 6);
ok($seen[3][0] eq 'abel');
ok($seen[3][1] eq 'baker');
ok($seen[3][2] eq 'camera');
ok($seen[3][3] eq 'delta');
ok($seen[3][4] eq 'edward');
ok($seen[3][5] eq 'jerky');
ok(@{$seen[4]} == 6);
ok($seen[4][0] eq 'abel');
ok($seen[4][1] eq 'baker');
ok($seen[4][2] eq 'camera');
ok($seen[4][3] eq 'delta');
ok($seen[4][4] eq 'edward');
ok($seen[4][5] eq 'jerky');

##########
## tests for bad arguments

eval { $unique_all_ref = get_unique_all( [ \@a0, \%h1 ] ) };
ok(ok_capture_error($@));

eval { $unique_all_ref = get_unique_all( [ \@a0, \@a1 ],
    [ qw| extraneous argument | ],
) };
ok(ok_capture_error($@));

eval { $complement_all_ref = get_complement_all( [ \@a0, \%h1 ] ) };
ok(ok_capture_error($@));

eval { $complement_all_ref = get_complement_all( [ \@a0, \@a1 ],
    [ qw| extraneous argument | ],
) };
ok(ok_capture_error($@));

