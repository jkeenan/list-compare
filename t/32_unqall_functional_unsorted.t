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
ok($loaded);                            # 1

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
ok( exists $seen[0]{'abel'} );          # 2
ok( exists $seen[1]{'hilton'} );        # 3

$complement_all_ref = get_complement_all( '-u', [ \@a0, \@a1 ] );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 4
ok( exists $seen[1]{'abel'} );          # 5

##########
## 08 equivalent

$unique_all_ref = get_unique_all( '-u', [ \%h0, \%h1 ] );
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 6
ok( exists $seen[1]{'hilton'} );        # 7

$complement_all_ref = get_complement_all( '-u', [ \%h0, \%h1 ] );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 8
ok( exists $seen[1]{'abel'} );          # 9

##########
## 11 equivalent

$unique_all_ref = get_unique_all( '-u', [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 10
ok( exists $seen[2]{'jerky'} );         # 11

$complement_all_ref = get_complement_all( '-u', [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 12
ok( exists $seen[0]{'icon'} );          # 13
ok( exists $seen[0]{'jerky'} );         # 14
ok( exists $seen[1]{'abel'} );          # 15
ok( exists $seen[1]{'icon'} );          # 16
ok( exists $seen[1]{'jerky'} );         # 17
ok( exists $seen[2]{'abel'} );          # 18
ok( exists $seen[2]{'baker'} );         # 19
ok( exists $seen[2]{'camera'} );        # 20
ok( exists $seen[2]{'delta'} );         # 21
ok( exists $seen[2]{'edward'} );        # 22
ok( exists $seen[3]{'abel'} );          # 23
ok( exists $seen[3]{'baker'} );         # 24
ok( exists $seen[3]{'camera'} );        # 25
ok( exists $seen[3]{'delta'} );         # 26
ok( exists $seen[3]{'edward'} );        # 27
ok( exists $seen[3]{'jerky'} );         # 28
ok( exists $seen[4]{'abel'} );          # 29
ok( exists $seen[4]{'baker'} );         # 30
ok( exists $seen[4]{'camera'} );        # 31
ok( exists $seen[4]{'delta'} );         # 32
ok( exists $seen[4]{'edward'} );        # 33
ok( exists $seen[4]{'jerky'} );         # 34

##########
## 12 equivalent

$unique_all_ref = get_unique_all( '-u', [ \%h0, \%h1, \%h2, \%h3, \%h4 ] );
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 35
ok( exists $seen[2]{'jerky'} );         # 36

$complement_all_ref = get_complement_all( '-u', [ \%h0, \%h1, \%h2, \%h3, \%h4 ] );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 37
ok( exists $seen[0]{'icon'} );          # 38
ok( exists $seen[0]{'jerky'} );         # 39
ok( exists $seen[1]{'abel'} );          # 40
ok( exists $seen[1]{'icon'} );          # 41
ok( exists $seen[1]{'jerky'} );         # 42
ok( exists $seen[2]{'abel'} );          # 43
ok( exists $seen[2]{'baker'} );         # 44
ok( exists $seen[2]{'camera'} );        # 45
ok( exists $seen[2]{'delta'} );         # 46
ok( exists $seen[2]{'edward'} );        # 47
ok( exists $seen[3]{'abel'} );          # 48
ok( exists $seen[3]{'baker'} );         # 49
ok( exists $seen[3]{'camera'} );        # 50
ok( exists $seen[3]{'delta'} );         # 51
ok( exists $seen[3]{'edward'} );        # 52
ok( exists $seen[3]{'jerky'} );         # 53
ok( exists $seen[4]{'abel'} );          # 54
ok( exists $seen[4]{'baker'} );         # 55
ok( exists $seen[4]{'camera'} );        # 56
ok( exists $seen[4]{'delta'} );         # 57
ok( exists $seen[4]{'edward'} );        # 58
ok( exists $seen[4]{'jerky'} );         # 59

##########
## 25 equivalent

$unique_all_ref = get_unique_all( { 
    unsorted => 1, 
    lists => [ \@a0, \@a1 ] 
} );
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 60
ok( exists $seen[1]{'hilton'} );        # 61

$complement_all_ref = get_complement_all( { 
    unsorted => 1, 
    lists => [ \@a0, \@a1 ] 
} );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 62
ok( exists $seen[1]{'abel'} );          # 63

##########
## 26 equivalent

$unique_all_ref = get_unique_all( { 
    unsorted => 1, 
    lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] 
} );
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 64
ok( exists $seen[2]{'jerky'} );         # 65

$complement_all_ref = get_complement_all( { 
    unsorted => 1, 
    lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] 
} );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 66
ok( exists $seen[0]{'icon'} );          # 67
ok( exists $seen[0]{'jerky'} );         # 68
ok( exists $seen[1]{'abel'} );          # 69
ok( exists $seen[1]{'icon'} );          # 70
ok( exists $seen[1]{'jerky'} );         # 71
ok( exists $seen[2]{'abel'} );          # 72
ok( exists $seen[2]{'baker'} );         # 73
ok( exists $seen[2]{'camera'} );        # 74
ok( exists $seen[2]{'delta'} );         # 75
ok( exists $seen[2]{'edward'} );        # 76
ok( exists $seen[3]{'abel'} );          # 77
ok( exists $seen[3]{'baker'} );         # 78
ok( exists $seen[3]{'camera'} );        # 79
ok( exists $seen[3]{'delta'} );         # 80
ok( exists $seen[3]{'edward'} );        # 81
ok( exists $seen[3]{'jerky'} );         # 82
ok( exists $seen[4]{'abel'} );          # 83
ok( exists $seen[4]{'baker'} );         # 84
ok( exists $seen[4]{'camera'} );        # 85
ok( exists $seen[4]{'delta'} );         # 86
ok( exists $seen[4]{'edward'} );        # 87
ok( exists $seen[4]{'jerky'} );         # 88

##########
## 27 equivalent

$unique_all_ref = get_unique_all( { 
    unsorted => 1, 
    lists => [ \%h0, \%h1 ] 
} );
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 89
ok( exists $seen[1]{'hilton'} );        # 90

$complement_all_ref = get_complement_all( { 
    unsorted => 1, 
    lists => [ \%h0, \%h1 ] 
} );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 91
ok( exists $seen[1]{'abel'} );          # 92

##########
## 28 equivalent

$unique_all_ref = get_unique_all( { 
    unsorted => 1, 
    lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] 
} );
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 93
ok( exists $seen[2]{'jerky'} );         # 94

$complement_all_ref = get_complement_all( { 
    unsorted => 1, 
    lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] 
} );
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 95
ok( exists $seen[0]{'icon'} );          # 96
ok( exists $seen[0]{'jerky'} );         # 97
ok( exists $seen[1]{'abel'} );          # 98
ok( exists $seen[1]{'icon'} );          # 99
ok( exists $seen[1]{'jerky'} );         # 100
ok( exists $seen[2]{'abel'} );          # 101
ok( exists $seen[2]{'baker'} );         # 102
ok( exists $seen[2]{'camera'} );        # 103
ok( exists $seen[2]{'delta'} );         # 104
ok( exists $seen[2]{'edward'} );        # 105
ok( exists $seen[3]{'abel'} );          # 106
ok( exists $seen[3]{'baker'} );         # 107
ok( exists $seen[3]{'camera'} );        # 108
ok( exists $seen[3]{'delta'} );         # 109
ok( exists $seen[3]{'edward'} );        # 110
ok( exists $seen[3]{'jerky'} );         # 111
ok( exists $seen[4]{'abel'} );          # 112
ok( exists $seen[4]{'baker'} );         # 113
ok( exists $seen[4]{'camera'} );        # 114
ok( exists $seen[4]{'delta'} );         # 115
ok( exists $seen[4]{'edward'} );        # 116
ok( exists $seen[4]{'jerky'} );         # 117

