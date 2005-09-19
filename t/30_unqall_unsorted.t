# 30_unqall_unsorted.t  # as of 8/8/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
249;
use lib ("./t");
use List::Compare;
use Test::ListCompareSpecial qw(:seen);

$loaded = 1;
ok($loaded);                            # 1

######################### End of black magic.

my (%seen, @seen, $seenref);
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

my ($lc, $lca, $lcm, $lcsh, $lcsha, $lcmsh, $lcmash  );

##########
## 01 equivalent

$lc   = List::Compare->new('-u', \@a0, \@a1);
ok($lc);                                # 2

$unique_all_ref = $lc->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 3
ok( exists $seen[1]{'hilton'} );        # 4

$complement_all_ref = $lc->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 5
ok( exists $seen[1]{'abel'} );          # 6

##########
## 02 equivalent

$lca   = List::Compare->new('-u', '-a', \@a0, \@a1);
ok($lca);                               # 7

$unique_all_ref = $lca->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 8
ok( exists $seen[1]{'hilton'} );        # 9

$complement_all_ref = $lca->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 10
ok( exists $seen[1]{'abel'} );          # 11

##########
## 03 equivalent

$lcm   = List::Compare->new('-u', \@a0, \@a1, \@a2, \@a3, \@a4);
ok($lcm);                               # 12

$unique_all_ref = $lcm->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 13
ok( exists $seen[2]{'jerky'} );         # 14

$complement_all_ref = $lcm->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 15
ok( exists $seen[0]{'icon'} );          # 16
ok( exists $seen[0]{'jerky'} );         # 17
ok( exists $seen[1]{'abel'} );          # 18
ok( exists $seen[1]{'icon'} );          # 19
ok( exists $seen[1]{'jerky'} );         # 20
ok( exists $seen[2]{'abel'} );          # 21
ok( exists $seen[2]{'baker'} );         # 22
ok( exists $seen[2]{'camera'} );        # 23
ok( exists $seen[2]{'delta'} );         # 24
ok( exists $seen[2]{'edward'} );        # 25
ok( exists $seen[3]{'abel'} );          # 26
ok( exists $seen[3]{'baker'} );         # 27
ok( exists $seen[3]{'camera'} );        # 28
ok( exists $seen[3]{'delta'} );         # 29
ok( exists $seen[3]{'edward'} );        # 30
ok( exists $seen[3]{'jerky'} );         # 31
ok( exists $seen[4]{'abel'} );          # 32
ok( exists $seen[4]{'baker'} );         # 33
ok( exists $seen[4]{'camera'} );        # 34
ok( exists $seen[4]{'delta'} );         # 35
ok( exists $seen[4]{'edward'} );        # 36
ok( exists $seen[4]{'jerky'} );         # 37

##########
## 09 equivalent

$lcma   = List::Compare->new('-u', '-a', \@a0, \@a1, \@a2, \@a3, \@a4);
ok($lcma);                              # 38

$unique_all_ref = $lcma->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 39
ok( exists $seen[2]{'jerky'} );         # 40

$complement_all_ref = $lcma->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 41
ok( exists $seen[0]{'icon'} );          # 42
ok( exists $seen[0]{'jerky'} );         # 43
ok( exists $seen[1]{'abel'} );          # 44
ok( exists $seen[1]{'icon'} );          # 45
ok( exists $seen[1]{'jerky'} );         # 46
ok( exists $seen[2]{'abel'} );          # 47
ok( exists $seen[2]{'baker'} );         # 48
ok( exists $seen[2]{'camera'} );        # 49
ok( exists $seen[2]{'delta'} );         # 50
ok( exists $seen[2]{'edward'} );        # 51
ok( exists $seen[3]{'abel'} );          # 52
ok( exists $seen[3]{'baker'} );         # 53
ok( exists $seen[3]{'camera'} );        # 54
ok( exists $seen[3]{'delta'} );         # 55
ok( exists $seen[3]{'edward'} );        # 56
ok( exists $seen[3]{'jerky'} );         # 57
ok( exists $seen[4]{'abel'} );          # 58
ok( exists $seen[4]{'baker'} );         # 59
ok( exists $seen[4]{'camera'} );        # 60
ok( exists $seen[4]{'delta'} );         # 61
ok( exists $seen[4]{'edward'} );        # 62
ok( exists $seen[4]{'jerky'} );         # 63

##########
## 13 equivalent

$lcsh  = List::Compare->new('-u', \%h0, \%h1);
ok($lcsh);                              # 64

$unique_all_ref = $lcsh->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 65
ok( exists $seen[1]{'hilton'} );        # 66

$complement_all_ref = $lcsh->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 67
ok( exists $seen[1]{'abel'} );          # 68

##########
## 14 equivalent

$lcsha   = List::Compare->new('-u', '-a', \%h0, \%h1);
ok($lcsha);                             # 69

$unique_all_ref = $lcsha->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 70
ok( exists $seen[1]{'hilton'} );        # 71

$complement_all_ref = $lcsha->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 72
ok( exists $seen[1]{'abel'} );          # 73

##########
## 15 equivalent

$lcmsh   = List::Compare->new('-u', \%h0, \%h1, \%h2, \%h3, \%h4);
ok($lcmsh);                             # 74

$unique_all_ref = $lcmsh->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 75
ok( exists $seen[2]{'jerky'} );         # 76

$complement_all_ref = $lcmsh->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 77
ok( exists $seen[0]{'icon'} );          # 78
ok( exists $seen[0]{'jerky'} );         # 79
ok( exists $seen[1]{'abel'} );          # 80
ok( exists $seen[1]{'icon'} );          # 81
ok( exists $seen[1]{'jerky'} );         # 82
ok( exists $seen[2]{'abel'} );          # 83
ok( exists $seen[2]{'baker'} );         # 84
ok( exists $seen[2]{'camera'} );        # 85
ok( exists $seen[2]{'delta'} );         # 86
ok( exists $seen[2]{'edward'} );        # 87
ok( exists $seen[3]{'abel'} );          # 88
ok( exists $seen[3]{'baker'} );         # 89
ok( exists $seen[3]{'camera'} );        # 90
ok( exists $seen[3]{'delta'} );         # 91
ok( exists $seen[3]{'edward'} );        # 92
ok( exists $seen[3]{'jerky'} );         # 93
ok( exists $seen[4]{'abel'} );          # 94
ok( exists $seen[4]{'baker'} );         # 95
ok( exists $seen[4]{'camera'} );        # 96
ok( exists $seen[4]{'delta'} );         # 97
ok( exists $seen[4]{'edward'} );        # 98
ok( exists $seen[4]{'jerky'} );         # 99

##########
## 16 equivalent

$lcmash   = List::Compare->new('-u', '-a', \%h0, \%h1, \%h2, \%h3, \%h4);
ok($lcmash);                            # 100

$unique_all_ref = $lcmash->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 101
ok( exists $seen[2]{'jerky'} );         # 102

$complement_all_ref = $lcmash->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 103
ok( exists $seen[0]{'icon'} );          # 104
ok( exists $seen[0]{'jerky'} );         # 105
ok( exists $seen[1]{'abel'} );          # 106
ok( exists $seen[1]{'icon'} );          # 107
ok( exists $seen[1]{'jerky'} );         # 108
ok( exists $seen[2]{'abel'} );          # 109
ok( exists $seen[2]{'baker'} );         # 110
ok( exists $seen[2]{'camera'} );        # 111
ok( exists $seen[2]{'delta'} );         # 112
ok( exists $seen[2]{'edward'} );        # 113
ok( exists $seen[3]{'abel'} );          # 114
ok( exists $seen[3]{'baker'} );         # 115
ok( exists $seen[3]{'camera'} );        # 116
ok( exists $seen[3]{'delta'} );         # 117
ok( exists $seen[3]{'edward'} );        # 118
ok( exists $seen[3]{'jerky'} );         # 119
ok( exists $seen[4]{'abel'} );          # 120
ok( exists $seen[4]{'baker'} );         # 121
ok( exists $seen[4]{'camera'} );        # 122
ok( exists $seen[4]{'delta'} );         # 123
ok( exists $seen[4]{'edward'} );        # 124
ok( exists $seen[4]{'jerky'} );         # 125

##########
## 17 equivalent

$lc    = List::Compare->new( { unsorted => 1,  lists => [ \@a0, \@a1 ] } );
ok($lc);                                # 126

$unique_all_ref = $lc->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 127
ok( exists $seen[1]{'hilton'} );        # 128

$complement_all_ref = $lc->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 129
ok( exists $seen[1]{'abel'} );          # 130

##########
## 18 equivalent

$lca   = List::Compare->new( { unsorted => 1,  accelerated => 1, lists => [\@a0, \@a1] } );
ok($lca);                               # 131

$unique_all_ref = $lca->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 132
ok( exists $seen[1]{'hilton'} );        # 133

$complement_all_ref = $lca->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 134
ok( exists $seen[1]{'abel'} );          # 135

##########
## 19 equivalent

$lcm   = List::Compare->new( { unsorted => 1,  lists => [\@a0, \@a1, \@a2, \@a3, \@a4] } );
ok($lcm);                               # 136

$unique_all_ref = $lcm->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 137
ok( exists $seen[2]{'jerky'} );         # 138

$complement_all_ref = $lcm->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 139
ok( exists $seen[0]{'icon'} );          # 140
ok( exists $seen[0]{'jerky'} );         # 141
ok( exists $seen[1]{'abel'} );          # 142
ok( exists $seen[1]{'icon'} );          # 143
ok( exists $seen[1]{'jerky'} );         # 144
ok( exists $seen[2]{'abel'} );          # 145
ok( exists $seen[2]{'baker'} );         # 146
ok( exists $seen[2]{'camera'} );        # 147
ok( exists $seen[2]{'delta'} );         # 148
ok( exists $seen[2]{'edward'} );        # 149
ok( exists $seen[3]{'abel'} );          # 150
ok( exists $seen[3]{'baker'} );         # 151
ok( exists $seen[3]{'camera'} );        # 152
ok( exists $seen[3]{'delta'} );         # 153
ok( exists $seen[3]{'edward'} );        # 154
ok( exists $seen[3]{'jerky'} );         # 155
ok( exists $seen[4]{'abel'} );          # 156
ok( exists $seen[4]{'baker'} );         # 157
ok( exists $seen[4]{'camera'} );        # 158
ok( exists $seen[4]{'delta'} );         # 159
ok( exists $seen[4]{'edward'} );        # 160
ok( exists $seen[4]{'jerky'} );         # 161

##########
## 20 equivalent

$lcma   = List::Compare->new( { unsorted => 1,  accelerated => 1, lists => [\@a0, \@a1, \@a2, \@a3, \@a4] } );
ok($lcma);                              # 162

$unique_all_ref = $lcma->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 163
ok( exists $seen[2]{'jerky'} );         # 164

$complement_all_ref = $lcma->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 165
ok( exists $seen[0]{'icon'} );          # 166
ok( exists $seen[0]{'jerky'} );         # 167
ok( exists $seen[1]{'abel'} );          # 168
ok( exists $seen[1]{'icon'} );          # 169
ok( exists $seen[1]{'jerky'} );         # 170
ok( exists $seen[2]{'abel'} );          # 171
ok( exists $seen[2]{'baker'} );         # 172
ok( exists $seen[2]{'camera'} );        # 173
ok( exists $seen[2]{'delta'} );         # 174
ok( exists $seen[2]{'edward'} );        # 175
ok( exists $seen[3]{'abel'} );          # 176
ok( exists $seen[3]{'baker'} );         # 177
ok( exists $seen[3]{'camera'} );        # 178
ok( exists $seen[3]{'delta'} );         # 179
ok( exists $seen[3]{'edward'} );        # 180
ok( exists $seen[3]{'jerky'} );         # 181
ok( exists $seen[4]{'abel'} );          # 182
ok( exists $seen[4]{'baker'} );         # 183
ok( exists $seen[4]{'camera'} );        # 184
ok( exists $seen[4]{'delta'} );         # 185
ok( exists $seen[4]{'edward'} );        # 186
ok( exists $seen[4]{'jerky'} );         # 187

##########
## 21 equivalent

$lcsh  = List::Compare->new( { unsorted => 1,  lists => [\%h0, \%h1] } );
ok($lcsh);                              # 188

$unique_all_ref = $lcsh->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 189
ok( exists $seen[1]{'hilton'} );        # 190

$complement_all_ref = $lcsh->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 191
ok( exists $seen[1]{'abel'} );          # 192

##########
## 22 equivalent

$lcsha   = List::Compare->new( { unsorted => 1,  accelerated => 1, lists => [\%h0, \%h1] } );
ok($lcsha);                             # 193

$unique_all_ref = $lcsha->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 194
ok( exists $seen[1]{'hilton'} );        # 195

$complement_all_ref = $lcsha->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 196
ok( exists $seen[1]{'abel'} );          # 197

##########
## 23 equivalent

$lcmsh   = List::Compare->new( { unsorted => 1,  lists => [\%h0, \%h1, \%h2, \%h3, \%h4] } );
ok($lcmsh);                             # 198

$unique_all_ref = $lcmsh->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 199
ok( exists $seen[2]{'jerky'} );         # 200

$complement_all_ref = $lcmsh->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 201
ok( exists $seen[0]{'icon'} );          # 202
ok( exists $seen[0]{'jerky'} );         # 203
ok( exists $seen[1]{'abel'} );          # 204
ok( exists $seen[1]{'icon'} );          # 205
ok( exists $seen[1]{'jerky'} );         # 206
ok( exists $seen[2]{'abel'} );          # 207
ok( exists $seen[2]{'baker'} );         # 208
ok( exists $seen[2]{'camera'} );        # 209
ok( exists $seen[2]{'delta'} );         # 210
ok( exists $seen[2]{'edward'} );        # 211
ok( exists $seen[3]{'abel'} );          # 212
ok( exists $seen[3]{'baker'} );         # 213
ok( exists $seen[3]{'camera'} );        # 214
ok( exists $seen[3]{'delta'} );         # 215
ok( exists $seen[3]{'edward'} );        # 216
ok( exists $seen[3]{'jerky'} );         # 217
ok( exists $seen[4]{'abel'} );          # 218
ok( exists $seen[4]{'baker'} );         # 219
ok( exists $seen[4]{'camera'} );        # 220
ok( exists $seen[4]{'delta'} );         # 221
ok( exists $seen[4]{'edward'} );        # 222
ok( exists $seen[4]{'jerky'} );         # 223

##########
## 24 equivalent

$lcmash   = List::Compare->new( { unsorted => 1,  accelerated => 1, lists => [\%h0, \%h1, \%h2, \%h3, \%h4] } );
ok($lcmash);                            # 224

$unique_all_ref = $lcmash->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );          # 225
ok( exists $seen[2]{'jerky'} );         # 226

$complement_all_ref = $lcmash->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );        # 227
ok( exists $seen[0]{'icon'} );          # 228
ok( exists $seen[0]{'jerky'} );         # 229
ok( exists $seen[1]{'abel'} );          # 230
ok( exists $seen[1]{'icon'} );          # 231
ok( exists $seen[1]{'jerky'} );         # 232
ok( exists $seen[2]{'abel'} );          # 233
ok( exists $seen[2]{'baker'} );         # 234
ok( exists $seen[2]{'camera'} );        # 235
ok( exists $seen[2]{'delta'} );         # 236
ok( exists $seen[2]{'edward'} );        # 237
ok( exists $seen[3]{'abel'} );          # 238
ok( exists $seen[3]{'baker'} );         # 239
ok( exists $seen[3]{'camera'} );        # 240
ok( exists $seen[3]{'delta'} );         # 241
ok( exists $seen[3]{'edward'} );        # 242
ok( exists $seen[3]{'jerky'} );         # 243
ok( exists $seen[4]{'abel'} );          # 244
ok( exists $seen[4]{'baker'} );         # 245
ok( exists $seen[4]{'camera'} );        # 246
ok( exists $seen[4]{'delta'} );         # 247
ok( exists $seen[4]{'edward'} );        # 248
ok( exists $seen[4]{'jerky'} );         # 249



