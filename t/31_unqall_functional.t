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

$unique_all_ref = get_unique_all( [ \@a0, \@a1 ] );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 2
ok($seen[0][0] eq 'abel');              # 3
ok(@{$seen[1]} == 1);                   # 4
ok($seen[1][0] eq 'hilton');            # 5

$complement_all_ref = get_complement_all( [ \@a0, \@a1 ] );
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);                   # 6
ok($seen[0][0] eq 'hilton');            # 7
ok(@{$seen[1]} == 1);                   # 8
ok($seen[1][0] eq 'abel');              # 9

##########
## 08 equivalent

$unique_all_ref = get_unique_all( [ \%h0, \%h1 ] );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 10
ok($seen[0][0] eq 'abel');              # 11
ok(@{$seen[1]} == 1);                   # 12
ok($seen[1][0] eq 'hilton');            # 13

$complement_all_ref = get_complement_all( [ \%h0, \%h1 ] );
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);                   # 14
ok($seen[0][0] eq 'hilton');            # 15
ok(@{$seen[1]} == 1);                   # 16
ok($seen[1][0] eq 'abel');              # 17

##########
## 11 equivalent

$unique_all_ref = get_unique_all( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 18
ok($seen[0][0] eq 'abel');              # 19
ok(! @{$seen[1]});                      # 20
ok(@{$seen[2]} == 1);                   # 21
ok($seen[2][0] eq 'jerky');             # 22
ok(! @{$seen[3]});                      # 23
ok(! @{$seen[4]});                      # 24

$complement_all_ref = get_complement_all( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);                   # 25
ok($seen[0][0] eq 'hilton');            # 26
ok($seen[0][1] eq 'icon');              # 27
ok($seen[0][2] eq 'jerky');             # 28
ok(@{$seen[1]} == 3);                   # 29
ok($seen[1][0] eq 'abel');              # 30
ok($seen[1][1] eq 'icon');              # 31
ok($seen[1][2] eq 'jerky');             # 32
ok(@{$seen[2]} == 5);                   # 33
ok($seen[2][0] eq 'abel');              # 34
ok($seen[2][1] eq 'baker');             # 35
ok($seen[2][2] eq 'camera');            # 36
ok($seen[2][3] eq 'delta');             # 37
ok($seen[2][4] eq 'edward');            # 38
ok(@{$seen[3]} == 6);                   # 39
ok($seen[3][0] eq 'abel');              # 40
ok($seen[3][1] eq 'baker');             # 41
ok($seen[3][2] eq 'camera');            # 42
ok($seen[3][3] eq 'delta');             # 43
ok($seen[3][4] eq 'edward');            # 44
ok($seen[3][5] eq 'jerky');             # 45
ok(@{$seen[4]} == 6);                   # 46
ok($seen[4][0] eq 'abel');              # 47
ok($seen[4][1] eq 'baker');             # 48
ok($seen[4][2] eq 'camera');            # 49
ok($seen[4][3] eq 'delta');             # 50
ok($seen[4][4] eq 'edward');            # 51
ok($seen[4][5] eq 'jerky');             # 52

##########
## 12 equivalent

$unique_all_ref = get_unique_all( [ \%h0, \%h1, \%h2, \%h3, \%h4 ] );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 53
ok($seen[0][0] eq 'abel');              # 54
ok(! @{$seen[1]});                      # 55
ok(@{$seen[2]} == 1);                   # 56
ok($seen[2][0] eq 'jerky');             # 57
ok(! @{$seen[3]});                      # 58
ok(! @{$seen[4]});                      # 59

$complement_all_ref = get_complement_all( [ \%h0, \%h1, \%h2, \%h3, \%h4 ] );
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);                   # 60
ok($seen[0][0] eq 'hilton');            # 61
ok($seen[0][1] eq 'icon');              # 62
ok($seen[0][2] eq 'jerky');             # 63
ok(@{$seen[1]} == 3);                   # 64
ok($seen[1][0] eq 'abel');              # 65
ok($seen[1][1] eq 'icon');              # 66
ok($seen[1][2] eq 'jerky');             # 67
ok(@{$seen[2]} == 5);                   # 68
ok($seen[2][0] eq 'abel');              # 69
ok($seen[2][1] eq 'baker');             # 70
ok($seen[2][2] eq 'camera');            # 71
ok($seen[2][3] eq 'delta');             # 72
ok($seen[2][4] eq 'edward');            # 73
ok(@{$seen[3]} == 6);                   # 74
ok($seen[3][0] eq 'abel');              # 75
ok($seen[3][1] eq 'baker');             # 76
ok($seen[3][2] eq 'camera');            # 77
ok($seen[3][3] eq 'delta');             # 78
ok($seen[3][4] eq 'edward');            # 79
ok($seen[3][5] eq 'jerky');             # 80
ok(@{$seen[4]} == 6);                   # 81
ok($seen[4][0] eq 'abel');              # 82
ok($seen[4][1] eq 'baker');             # 83
ok($seen[4][2] eq 'camera');            # 84
ok($seen[4][3] eq 'delta');             # 85
ok($seen[4][4] eq 'edward');            # 86
ok($seen[4][5] eq 'jerky');             # 87

##########
## 25 equivalent

$unique_all_ref = get_unique_all( { lists => [ \@a0, \@a1 ] } );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 88
ok($seen[0][0] eq 'abel');              # 89
ok(@{$seen[1]} == 1);                   # 90
ok($seen[1][0] eq 'hilton');            # 91

$complement_all_ref = get_complement_all( { lists => [ \@a0, \@a1 ] } );
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);                   # 92
ok($seen[0][0] eq 'hilton');            # 93
ok(@{$seen[1]} == 1);                   # 94
ok($seen[1][0] eq 'abel');              # 95

##########
## 26 equivalent

$unique_all_ref = get_unique_all( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 96
ok($seen[0][0] eq 'abel');              # 97
ok(! @{$seen[1]});                      # 98
ok(@{$seen[2]} == 1);                   # 99
ok($seen[2][0] eq 'jerky');             # 100
ok(! @{$seen[3]});                      # 101
ok(! @{$seen[4]});                      # 102

$complement_all_ref = get_complement_all( 
    { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] }
);
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);                   # 103
ok($seen[0][0] eq 'hilton');            # 104
ok($seen[0][1] eq 'icon');              # 105
ok($seen[0][2] eq 'jerky');             # 106
ok(@{$seen[1]} == 3);                   # 107
ok($seen[1][0] eq 'abel');              # 108
ok($seen[1][1] eq 'icon');              # 109
ok($seen[1][2] eq 'jerky');             # 110
ok(@{$seen[2]} == 5);                   # 111
ok($seen[2][0] eq 'abel');              # 112
ok($seen[2][1] eq 'baker');             # 113
ok($seen[2][2] eq 'camera');            # 114
ok($seen[2][3] eq 'delta');             # 115
ok($seen[2][4] eq 'edward');            # 116
ok(@{$seen[3]} == 6);                   # 117
ok($seen[3][0] eq 'abel');              # 118
ok($seen[3][1] eq 'baker');             # 119
ok($seen[3][2] eq 'camera');            # 120
ok($seen[3][3] eq 'delta');             # 121
ok($seen[3][4] eq 'edward');            # 122
ok($seen[3][5] eq 'jerky');             # 123
ok(@{$seen[4]} == 6);                   # 124
ok($seen[4][0] eq 'abel');              # 125
ok($seen[4][1] eq 'baker');             # 126
ok($seen[4][2] eq 'camera');            # 127
ok($seen[4][3] eq 'delta');             # 128
ok($seen[4][4] eq 'edward');            # 129
ok($seen[4][5] eq 'jerky');             # 130

##########
## 27 equivalent

$unique_all_ref = get_unique_all( { lists => [ \%h0, \%h1 ] } );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 131
ok($seen[0][0] eq 'abel');              # 132
ok(@{$seen[1]} == 1);                   # 133
ok($seen[1][0] eq 'hilton');            # 134

$complement_all_ref = get_complement_all( { lists => [ \%h0, \%h1 ] } );
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);                   # 135
ok($seen[0][0] eq 'hilton');            # 136
ok(@{$seen[1]} == 1);                   # 137
ok($seen[1][0] eq 'abel');              # 138

##########
## 28 equivalent

$unique_all_ref = get_unique_all( { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] } );
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 139
ok($seen[0][0] eq 'abel');              # 140
ok(! @{$seen[1]});                      # 141
ok(@{$seen[2]} == 1);                   # 142
ok($seen[2][0] eq 'jerky');             # 143
ok(! @{$seen[3]});                      # 144
ok(! @{$seen[4]});                      # 145

$complement_all_ref = get_complement_all(
    { lists => [ \%h0, \%h1, \%h2, \%h3, \%h4 ] }
);
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);                   # 146
ok($seen[0][0] eq 'hilton');            # 147
ok($seen[0][1] eq 'icon');              # 148
ok($seen[0][2] eq 'jerky');             # 149
ok(@{$seen[1]} == 3);                   # 150
ok($seen[1][0] eq 'abel');              # 151
ok($seen[1][1] eq 'icon');              # 152
ok($seen[1][2] eq 'jerky');             # 153
ok(@{$seen[2]} == 5);                   # 154
ok($seen[2][0] eq 'abel');              # 155
ok($seen[2][1] eq 'baker');             # 156
ok($seen[2][2] eq 'camera');            # 157
ok($seen[2][3] eq 'delta');             # 158
ok($seen[2][4] eq 'edward');            # 159
ok(@{$seen[3]} == 6);                   # 160
ok($seen[3][0] eq 'abel');              # 161
ok($seen[3][1] eq 'baker');             # 162
ok($seen[3][2] eq 'camera');            # 163
ok($seen[3][3] eq 'delta');             # 164
ok($seen[3][4] eq 'edward');            # 165
ok($seen[3][5] eq 'jerky');             # 166
ok(@{$seen[4]} == 6);                   # 167
ok($seen[4][0] eq 'abel');              # 168
ok($seen[4][1] eq 'baker');             # 169
ok($seen[4][2] eq 'camera');            # 170
ok($seen[4][3] eq 'delta');             # 171
ok($seen[4][4] eq 'edward');            # 172
ok($seen[4][5] eq 'jerky');             # 173

##########
## tests for bad arguments

eval { $unique_all_ref = get_unique_all( [ \@a0, \%h1 ] ) };
ok(ok_capture_error($@));               # 174

eval { $unique_all_ref = get_unique_all( [ \@a0, \@a1 ],
    [ qw| extraneous argument | ],
) };
ok(ok_capture_error($@));               # 175

eval { $complement_all_ref = get_complement_all( [ \@a0, \%h1 ] ) };
ok(ok_capture_error($@));               # 176

eval { $complement_all_ref = get_complement_all( [ \@a0, \@a1 ],
    [ qw| extraneous argument | ],
) };
ok(ok_capture_error($@));               # 177

