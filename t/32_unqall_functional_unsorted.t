# 32_unqall_functional_unsorted.t  # as of 8/10/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
117;
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

$unique_all_ref = get_unique_all( '-u', [ \@a0, \@a1 ] );
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[1]{'hilton'} );

$complement_all_ref = get_complement_all( '-u', [ \@a0, \@a1 ] );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[1]{'abel'} );

##########
## 08 equivalent

$unique_all_ref = get_unique_all( '-u', [ \%h0, \%h1 ] );
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[1]{'hilton'} );

$complement_all_ref = get_complement_all( '-u', [ \%h0, \%h1 ] );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[1]{'abel'} );

##########
## 11 equivalent

$unique_all_ref = get_unique_all( '-u', [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[2]{'jerky'} );

$complement_all_ref = get_complement_all( '-u', [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[0]{'icon'} );
ok( exists $seen[0]{'jerky'} );
ok( exists $seen[1]{'abel'} );
ok( exists $seen[1]{'icon'} );
ok( exists $seen[1]{'jerky'} );
ok( exists $seen[2]{'abel'} );
ok( exists $seen[2]{'baker'} );
ok( exists $seen[2]{'camera'} );
ok( exists $seen[2]{'delta'} );
ok( exists $seen[2]{'edward'} );
ok( exists $seen[3]{'abel'} );
ok( exists $seen[3]{'baker'} );
ok( exists $seen[3]{'camera'} );
ok( exists $seen[3]{'delta'} );
ok( exists $seen[3]{'edward'} );
ok( exists $seen[3]{'jerky'} );
ok( exists $seen[4]{'abel'} );
ok( exists $seen[4]{'baker'} );
ok( exists $seen[4]{'camera'} );
ok( exists $seen[4]{'delta'} );
ok( exists $seen[4]{'edward'} );
ok( exists $seen[4]{'jerky'} );

##########
## 12 equivalent

$unique_all_ref = get_unique_all( '-u', [ \%h0, \%h1, \%h2, \%h3, \%h4 ] );
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[2]{'jerky'} );

$complement_all_ref = get_complement_all( '-u', [ \%h0, \%h1, \%h2, \%h3, \%h4 ] );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[0]{'icon'} );
ok( exists $seen[0]{'jerky'} );
ok( exists $seen[1]{'abel'} );
ok( exists $seen[1]{'icon'} );
ok( exists $seen[1]{'jerky'} );
ok( exists $seen[2]{'abel'} );
ok( exists $seen[2]{'baker'} );
ok( exists $seen[2]{'camera'} );
ok( exists $seen[2]{'delta'} );
ok( exists $seen[2]{'edward'} );
ok( exists $seen[3]{'abel'} );
ok( exists $seen[3]{'baker'} );
ok( exists $seen[3]{'camera'} );
ok( exists $seen[3]{'delta'} );
ok( exists $seen[3]{'edward'} );
ok( exists $seen[3]{'jerky'} );
ok( exists $seen[4]{'abel'} );
ok( exists $seen[4]{'baker'} );
ok( exists $seen[4]{'camera'} );
ok( exists $seen[4]{'delta'} );
ok( exists $seen[4]{'edward'} );
ok( exists $seen[4]{'jerky'} );

##########
## 25 equivalent

$unique_all_ref = get_unique_all( { 
    unsorted => 1, 
    lists => [ \@a0, \@a1 ] 
} );
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[1]{'hilton'} );

$complement_all_ref = get_complement_all( { 
    unsorted => 1, 
    lists => [ \@a0, \@a1 ] 
} );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[1]{'abel'} );

##########
## 26 equivalent

$unique_all_ref = get_unique_all( { 
    unsorted => 1, 
    lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] 
} );
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[2]{'jerky'} );

$complement_all_ref = get_complement_all( { 
    unsorted => 1, 
    lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] 
} );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[0]{'icon'} );
ok( exists $seen[0]{'jerky'} );
ok( exists $seen[1]{'abel'} );
ok( exists $seen[1]{'icon'} );
ok( exists $seen[1]{'jerky'} );
ok( exists $seen[2]{'abel'} );
ok( exists $seen[2]{'baker'} );
ok( exists $seen[2]{'camera'} );
ok( exists $seen[2]{'delta'} );
ok( exists $seen[2]{'edward'} );
ok( exists $seen[3]{'abel'} );
ok( exists $seen[3]{'baker'} );
ok( exists $seen[3]{'camera'} );
ok( exists $seen[3]{'delta'} );
ok( exists $seen[3]{'edward'} );
ok( exists $seen[3]{'jerky'} );
ok( exists $seen[4]{'abel'} );
ok( exists $seen[4]{'baker'} );
ok( exists $seen[4]{'camera'} );
ok( exists $seen[4]{'delta'} );
ok( exists $seen[4]{'edward'} );
ok( exists $seen[4]{'jerky'} );

##########
## 27 equivalent

$unique_all_ref = get_unique_all( { 
    unsorted => 1, 
    lists => [ \%h0, \%h1 ] 
} );
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[1]{'hilton'} );

$complement_all_ref = get_complement_all( { 
    unsorted => 1, 
    lists => [ \%h0, \%h1 ] 
} );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[1]{'abel'} );

##########
## 28 equivalent

$unique_all_ref = get_unique_all( { 
    unsorted => 1, 
    lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] 
} );
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[2]{'jerky'} );

$complement_all_ref = get_complement_all( { 
    unsorted => 1, 
    lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] 
} );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[0]{'icon'} );
ok( exists $seen[0]{'jerky'} );
ok( exists $seen[1]{'abel'} );
ok( exists $seen[1]{'icon'} );
ok( exists $seen[1]{'jerky'} );
ok( exists $seen[2]{'abel'} );
ok( exists $seen[2]{'baker'} );
ok( exists $seen[2]{'camera'} );
ok( exists $seen[2]{'delta'} );
ok( exists $seen[2]{'edward'} );
ok( exists $seen[3]{'abel'} );
ok( exists $seen[3]{'baker'} );
ok( exists $seen[3]{'camera'} );
ok( exists $seen[3]{'delta'} );
ok( exists $seen[3]{'edward'} );
ok( exists $seen[3]{'jerky'} );
ok( exists $seen[4]{'abel'} );
ok( exists $seen[4]{'baker'} );
ok( exists $seen[4]{'camera'} );
ok( exists $seen[4]{'delta'} );
ok( exists $seen[4]{'edward'} );
ok( exists $seen[4]{'jerky'} );

