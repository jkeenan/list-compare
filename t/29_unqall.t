# 29_unqall.t  # as of 8/8/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
361;
use lib ("./t");
use List::Compare;
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

my ($lc, $lca, $lcm, $lcsh, $lcsha, $lcmsh, $lcmash,   );

##########
## 01 equivalent

$lc   = List::Compare->new(\@a0, \@a1);
ok($lc);                                # 2

$unique_all_ref = $lc->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 3
ok($seen[0][0] eq 'abel');              # 4
ok(@{$seen[1]} == 1);                   # 5
ok($seen[1][0] eq 'hilton');            # 6

$complement_all_ref = $lc->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);                   # 7
ok($seen[0][0] eq 'hilton');            # 8
ok(@{$seen[1]} == 1);                   # 9
ok($seen[1][0] eq 'abel');              # 10

##########
## 02 equivalent

$lca   = List::Compare->new('-a', \@a0, \@a1);
ok($lca);                               # 11

$unique_all_ref = $lca->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 12
ok($seen[0][0] eq 'abel');              # 13
ok(@{$seen[1]} == 1);                   # 14
ok($seen[1][0] eq 'hilton');            # 15

$complement_all_ref = $lca->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);                   # 16
ok($seen[0][0] eq 'hilton');            # 17
ok(@{$seen[1]} == 1);                   # 18
ok($seen[1][0] eq 'abel');              # 19

##########
## 03 equivalent

$lcm   = List::Compare->new(\@a0, \@a1, \@a2, \@a3, \@a4);
ok($lcm);                               # 20

$unique_all_ref = $lcm->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 21
ok($seen[0][0] eq 'abel');              # 22
ok(! @{$seen[1]});                      # 23
ok(@{$seen[2]} == 1);                   # 24
ok($seen[2][0] eq 'jerky');             # 25
ok(! @{$seen[3]});                      # 26
ok(! @{$seen[4]});                      # 27

$complement_all_ref = $lcm->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);                   # 28
ok($seen[0][0] eq 'hilton');            # 29
ok($seen[0][1] eq 'icon');              # 30
ok($seen[0][2] eq 'jerky');             # 31
ok(@{$seen[1]} == 3);                   # 32
ok($seen[1][0] eq 'abel');              # 33
ok($seen[1][1] eq 'icon');              # 34
ok($seen[1][2] eq 'jerky');             # 35
ok(@{$seen[2]} == 5);                   # 36
ok($seen[2][0] eq 'abel');              # 37
ok($seen[2][1] eq 'baker');             # 38
ok($seen[2][2] eq 'camera');            # 39
ok($seen[2][3] eq 'delta');             # 40
ok($seen[2][4] eq 'edward');            # 41
ok(@{$seen[3]} == 6);                   # 42
ok($seen[3][0] eq 'abel');              # 43
ok($seen[3][1] eq 'baker');             # 44
ok($seen[3][2] eq 'camera');            # 45
ok($seen[3][3] eq 'delta');             # 46
ok($seen[3][4] eq 'edward');            # 47
ok($seen[3][5] eq 'jerky');             # 48
ok(@{$seen[4]} == 6);                   # 49
ok($seen[4][0] eq 'abel');              # 50
ok($seen[4][1] eq 'baker');             # 51
ok($seen[4][2] eq 'camera');            # 52
ok($seen[4][3] eq 'delta');             # 53
ok($seen[4][4] eq 'edward');            # 54
ok($seen[4][5] eq 'jerky');             # 55

##########
## 09 equivalent

$lcma   = List::Compare->new('-a', \@a0, \@a1, \@a2, \@a3, \@a4);
ok($lcma);                              # 56

$unique_all_ref = $lcma->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 57
ok($seen[0][0] eq 'abel');              # 58
ok(! @{$seen[1]});                      # 59
ok(@{$seen[2]} == 1);                   # 60
ok($seen[2][0] eq 'jerky');             # 61
ok(! @{$seen[3]});                      # 62
ok(! @{$seen[4]});                      # 63

$complement_all_ref = $lcma->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);                   # 64
ok($seen[0][0] eq 'hilton');            # 65
ok($seen[0][1] eq 'icon');              # 66
ok($seen[0][2] eq 'jerky');             # 67
ok(@{$seen[1]} == 3);                   # 68
ok($seen[1][0] eq 'abel');              # 69
ok($seen[1][1] eq 'icon');              # 70
ok($seen[1][2] eq 'jerky');             # 71
ok(@{$seen[2]} == 5);                   # 72
ok($seen[2][0] eq 'abel');              # 73
ok($seen[2][1] eq 'baker');             # 74
ok($seen[2][2] eq 'camera');            # 75
ok($seen[2][3] eq 'delta');             # 76
ok($seen[2][4] eq 'edward');            # 77
ok(@{$seen[3]} == 6);                   # 78
ok($seen[3][0] eq 'abel');              # 79
ok($seen[3][1] eq 'baker');             # 80
ok($seen[3][2] eq 'camera');            # 81
ok($seen[3][3] eq 'delta');             # 82
ok($seen[3][4] eq 'edward');            # 83
ok($seen[3][5] eq 'jerky');             # 84
ok(@{$seen[4]} == 6);                   # 85
ok($seen[4][0] eq 'abel');              # 86
ok($seen[4][1] eq 'baker');             # 87
ok($seen[4][2] eq 'camera');            # 88
ok($seen[4][3] eq 'delta');             # 89
ok($seen[4][4] eq 'edward');            # 90
ok($seen[4][5] eq 'jerky');             # 91

##########
## 13 equivalent

$lcsh  = List::Compare->new(\%h0, \%h1);
ok($lcsh);                              # 92

$unique_all_ref = $lcsh->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 93
ok($seen[0][0] eq 'abel');              # 94
ok(@{$seen[1]} == 1);                   # 95
ok($seen[1][0] eq 'hilton');            # 96

$complement_all_ref = $lcsh->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);                   # 97
ok($seen[0][0] eq 'hilton');            # 98
ok(@{$seen[1]} == 1);                   # 99
ok($seen[1][0] eq 'abel');              # 100

##########
## 14 equivalent

$lcsha   = List::Compare->new('-a', \%h0, \%h1);
ok($lcsha);                             # 101

$unique_all_ref = $lcsha->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 102
ok($seen[0][0] eq 'abel');              # 103
ok(@{$seen[1]} == 1);                   # 104
ok($seen[1][0] eq 'hilton');            # 105

$complement_all_ref = $lcsha->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);                   # 106
ok($seen[0][0] eq 'hilton');            # 107
ok(@{$seen[1]} == 1);                   # 108
ok($seen[1][0] eq 'abel');              # 109

##########
## 15 equivalent

$lcmsh   = List::Compare->new(\%h0, \%h1, \%h2, \%h3, \%h4);
ok($lcmsh);                             # 110

$unique_all_ref = $lcmsh->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 111
ok($seen[0][0] eq 'abel');              # 112
ok(! @{$seen[1]});                      # 113
ok(@{$seen[2]} == 1);                   # 114
ok($seen[2][0] eq 'jerky');             # 115
ok(! @{$seen[3]});                      # 116
ok(! @{$seen[4]});                      # 117

$complement_all_ref = $lcmsh->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);                   # 118
ok($seen[0][0] eq 'hilton');            # 119
ok($seen[0][1] eq 'icon');              # 120
ok($seen[0][2] eq 'jerky');             # 121
ok(@{$seen[1]} == 3);                   # 122
ok($seen[1][0] eq 'abel');              # 123
ok($seen[1][1] eq 'icon');              # 124
ok($seen[1][2] eq 'jerky');             # 125
ok(@{$seen[2]} == 5);                   # 126
ok($seen[2][0] eq 'abel');              # 127
ok($seen[2][1] eq 'baker');             # 128
ok($seen[2][2] eq 'camera');            # 129
ok($seen[2][3] eq 'delta');             # 130
ok($seen[2][4] eq 'edward');            # 131
ok(@{$seen[3]} == 6);                   # 132
ok($seen[3][0] eq 'abel');              # 133
ok($seen[3][1] eq 'baker');             # 134
ok($seen[3][2] eq 'camera');            # 135
ok($seen[3][3] eq 'delta');             # 136
ok($seen[3][4] eq 'edward');            # 137
ok($seen[3][5] eq 'jerky');             # 138
ok(@{$seen[4]} == 6);                   # 139
ok($seen[4][0] eq 'abel');              # 140
ok($seen[4][1] eq 'baker');             # 141
ok($seen[4][2] eq 'camera');            # 142
ok($seen[4][3] eq 'delta');             # 143
ok($seen[4][4] eq 'edward');            # 144
ok($seen[4][5] eq 'jerky');             # 145

##########
## 16 equivalent

$lcmash   = List::Compare->new('-a', \%h0, \%h1, \%h2, \%h3, \%h4);
ok($lcmash);                            # 146

$unique_all_ref = $lcmash->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 147
ok($seen[0][0] eq 'abel');              # 148
ok(! @{$seen[1]});                      # 149
ok(@{$seen[2]} == 1);                   # 150
ok($seen[2][0] eq 'jerky');             # 151
ok(! @{$seen[3]});                      # 152
ok(! @{$seen[4]});                      # 153

$complement_all_ref = $lcmash->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);                   # 154
ok($seen[0][0] eq 'hilton');            # 155
ok($seen[0][1] eq 'icon');              # 156
ok($seen[0][2] eq 'jerky');             # 157
ok(@{$seen[1]} == 3);                   # 158
ok($seen[1][0] eq 'abel');              # 159
ok($seen[1][1] eq 'icon');              # 160
ok($seen[1][2] eq 'jerky');             # 161
ok(@{$seen[2]} == 5);                   # 162
ok($seen[2][0] eq 'abel');              # 163
ok($seen[2][1] eq 'baker');             # 164
ok($seen[2][2] eq 'camera');            # 165
ok($seen[2][3] eq 'delta');             # 166
ok($seen[2][4] eq 'edward');            # 167
ok(@{$seen[3]} == 6);                   # 168
ok($seen[3][0] eq 'abel');              # 169
ok($seen[3][1] eq 'baker');             # 170
ok($seen[3][2] eq 'camera');            # 171
ok($seen[3][3] eq 'delta');             # 172
ok($seen[3][4] eq 'edward');            # 173
ok($seen[3][5] eq 'jerky');             # 174
ok(@{$seen[4]} == 6);                   # 175
ok($seen[4][0] eq 'abel');              # 176
ok($seen[4][1] eq 'baker');             # 177
ok($seen[4][2] eq 'camera');            # 178
ok($seen[4][3] eq 'delta');             # 179
ok($seen[4][4] eq 'edward');            # 180
ok($seen[4][5] eq 'jerky');             # 181

##########
## 17 equivalent

$lc    = List::Compare->new( { lists => [ \@a0, \@a1 ] } );
ok($lc);                                # 182

$unique_all_ref = $lc->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 183
ok($seen[0][0] eq 'abel');              # 184
ok(@{$seen[1]} == 1);                   # 185
ok($seen[1][0] eq 'hilton');            # 186

$complement_all_ref = $lc->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);                   # 187
ok($seen[0][0] eq 'hilton');            # 188
ok(@{$seen[1]} == 1);                   # 189
ok($seen[1][0] eq 'abel');              # 190

##########
## 18 equivalent

$lca   = List::Compare->new( { accelerated => 1, lists => [\@a0, \@a1] } );
ok($lca);                               # 191

$unique_all_ref = $lca->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 192
ok($seen[0][0] eq 'abel');              # 193
ok(@{$seen[1]} == 1);                   # 194
ok($seen[1][0] eq 'hilton');            # 195

$complement_all_ref = $lca->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);                   # 196
ok($seen[0][0] eq 'hilton');            # 197
ok(@{$seen[1]} == 1);                   # 198
ok($seen[1][0] eq 'abel');              # 199

##########
## 19 equivalent

$lcm   = List::Compare->new( { lists => [\@a0, \@a1, \@a2, \@a3, \@a4] } );
ok($lcm);                               # 200

$unique_all_ref = $lcm->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 201
ok($seen[0][0] eq 'abel');              # 202
ok(! @{$seen[1]});                      # 203
ok(@{$seen[2]} == 1);                   # 204
ok($seen[2][0] eq 'jerky');             # 205
ok(! @{$seen[3]});                      # 206
ok(! @{$seen[4]});                      # 207

$complement_all_ref = $lcm->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);                   # 208
ok($seen[0][0] eq 'hilton');            # 209
ok($seen[0][1] eq 'icon');              # 210
ok($seen[0][2] eq 'jerky');             # 211
ok(@{$seen[1]} == 3);                   # 212
ok($seen[1][0] eq 'abel');              # 213
ok($seen[1][1] eq 'icon');              # 214
ok($seen[1][2] eq 'jerky');             # 215
ok(@{$seen[2]} == 5);                   # 216
ok($seen[2][0] eq 'abel');              # 217
ok($seen[2][1] eq 'baker');             # 218
ok($seen[2][2] eq 'camera');            # 219
ok($seen[2][3] eq 'delta');             # 220
ok($seen[2][4] eq 'edward');            # 221
ok(@{$seen[3]} == 6);                   # 222
ok($seen[3][0] eq 'abel');              # 223
ok($seen[3][1] eq 'baker');             # 224
ok($seen[3][2] eq 'camera');            # 225
ok($seen[3][3] eq 'delta');             # 226
ok($seen[3][4] eq 'edward');            # 227
ok($seen[3][5] eq 'jerky');             # 228
ok(@{$seen[4]} == 6);                   # 229
ok($seen[4][0] eq 'abel');              # 230
ok($seen[4][1] eq 'baker');             # 231
ok($seen[4][2] eq 'camera');            # 232
ok($seen[4][3] eq 'delta');             # 233
ok($seen[4][4] eq 'edward');            # 234
ok($seen[4][5] eq 'jerky');             # 235

##########
## 20 equivalent

$lcma   = List::Compare->new( { accelerated => 1, lists => [\@a0, \@a1, \@a2, \@a3, \@a4] } );
ok($lcma);                              # 236

$unique_all_ref = $lcma->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 237
ok($seen[0][0] eq 'abel');              # 238
ok(! @{$seen[1]});                      # 239
ok(@{$seen[2]} == 1);                   # 240
ok($seen[2][0] eq 'jerky');             # 241
ok(! @{$seen[3]});                      # 242
ok(! @{$seen[4]});                      # 243

$complement_all_ref = $lcma->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);                   # 244
ok($seen[0][0] eq 'hilton');            # 245
ok($seen[0][1] eq 'icon');              # 246
ok($seen[0][2] eq 'jerky');             # 247
ok(@{$seen[1]} == 3);                   # 248
ok($seen[1][0] eq 'abel');              # 249
ok($seen[1][1] eq 'icon');              # 250
ok($seen[1][2] eq 'jerky');             # 251
ok(@{$seen[2]} == 5);                   # 252
ok($seen[2][0] eq 'abel');              # 253
ok($seen[2][1] eq 'baker');             # 254
ok($seen[2][2] eq 'camera');            # 255
ok($seen[2][3] eq 'delta');             # 256
ok($seen[2][4] eq 'edward');            # 257
ok(@{$seen[3]} == 6);                   # 258
ok($seen[3][0] eq 'abel');              # 259
ok($seen[3][1] eq 'baker');             # 260
ok($seen[3][2] eq 'camera');            # 261
ok($seen[3][3] eq 'delta');             # 262
ok($seen[3][4] eq 'edward');            # 263
ok($seen[3][5] eq 'jerky');             # 264
ok(@{$seen[4]} == 6);                   # 265
ok($seen[4][0] eq 'abel');              # 266
ok($seen[4][1] eq 'baker');             # 267
ok($seen[4][2] eq 'camera');            # 268
ok($seen[4][3] eq 'delta');             # 269
ok($seen[4][4] eq 'edward');            # 270
ok($seen[4][5] eq 'jerky');             # 271

##########
## 21 equivalent

$lcsh  = List::Compare->new( { lists => [\%h0, \%h1] } );
ok($lcsh);                              # 272

$unique_all_ref = $lcsh->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 273
ok($seen[0][0] eq 'abel');              # 274
ok(@{$seen[1]} == 1);                   # 275
ok($seen[1][0] eq 'hilton');            # 276

$complement_all_ref = $lcsh->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);                   # 277
ok($seen[0][0] eq 'hilton');            # 278
ok(@{$seen[1]} == 1);                   # 279
ok($seen[1][0] eq 'abel');              # 280

##########
## 22 equivalent

$lcsha   = List::Compare->new( { accelerated => 1, lists => [\%h0, \%h1] } );
ok($lcsha);                             # 281

$unique_all_ref = $lcsha->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 282
ok($seen[0][0] eq 'abel');              # 283
ok(@{$seen[1]} == 1);                   # 284
ok($seen[1][0] eq 'hilton');            # 285

$complement_all_ref = $lcsha->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);                   # 286
ok($seen[0][0] eq 'hilton');            # 287
ok(@{$seen[1]} == 1);                   # 288
ok($seen[1][0] eq 'abel');              # 289

##########
## 23 equivalent

$lcmsh   = List::Compare->new( { lists => [\%h0, \%h1, \%h2, \%h3, \%h4] } );
ok($lcmsh);                             # 290

$unique_all_ref = $lcmsh->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 291
ok($seen[0][0] eq 'abel');              # 292
ok(! @{$seen[1]});                      # 293
ok(@{$seen[2]} == 1);                   # 294
ok($seen[2][0] eq 'jerky');             # 295
ok(! @{$seen[3]});                      # 296
ok(! @{$seen[4]});                      # 297

$complement_all_ref = $lcmsh->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);                   # 298
ok($seen[0][0] eq 'hilton');            # 299
ok($seen[0][1] eq 'icon');              # 300
ok($seen[0][2] eq 'jerky');             # 301
ok(@{$seen[1]} == 3);                   # 302
ok($seen[1][0] eq 'abel');              # 303
ok($seen[1][1] eq 'icon');              # 304
ok($seen[1][2] eq 'jerky');             # 305
ok(@{$seen[2]} == 5);                   # 306
ok($seen[2][0] eq 'abel');              # 307
ok($seen[2][1] eq 'baker');             # 308
ok($seen[2][2] eq 'camera');            # 309
ok($seen[2][3] eq 'delta');             # 310
ok($seen[2][4] eq 'edward');            # 311
ok(@{$seen[3]} == 6);                   # 312
ok($seen[3][0] eq 'abel');              # 313
ok($seen[3][1] eq 'baker');             # 314
ok($seen[3][2] eq 'camera');            # 315
ok($seen[3][3] eq 'delta');             # 316
ok($seen[3][4] eq 'edward');            # 317
ok($seen[3][5] eq 'jerky');             # 318
ok(@{$seen[4]} == 6);                   # 319
ok($seen[4][0] eq 'abel');              # 320
ok($seen[4][1] eq 'baker');             # 321
ok($seen[4][2] eq 'camera');            # 322
ok($seen[4][3] eq 'delta');             # 323
ok($seen[4][4] eq 'edward');            # 324
ok($seen[4][5] eq 'jerky');             # 325

##########
## 24 equivalent

$lcmash   = List::Compare->new( { accelerated => 1, lists => [\%h0, \%h1, \%h2, \%h3, \%h4] } );
ok($lcmash);                            # 326

$unique_all_ref = $lcmash->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);                   # 327
ok($seen[0][0] eq 'abel');              # 328
ok(! @{$seen[1]});                      # 329
ok(@{$seen[2]} == 1);                   # 330
ok($seen[2][0] eq 'jerky');             # 331
ok(! @{$seen[3]});                      # 332
ok(! @{$seen[4]});                      # 333

$complement_all_ref = $lcmash->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);                   # 334
ok($seen[0][0] eq 'hilton');            # 335
ok($seen[0][1] eq 'icon');              # 336
ok($seen[0][2] eq 'jerky');             # 337
ok(@{$seen[1]} == 3);                   # 338
ok($seen[1][0] eq 'abel');              # 339
ok($seen[1][1] eq 'icon');              # 340
ok($seen[1][2] eq 'jerky');             # 341
ok(@{$seen[2]} == 5);                   # 342
ok($seen[2][0] eq 'abel');              # 343
ok($seen[2][1] eq 'baker');             # 344
ok($seen[2][2] eq 'camera');            # 345
ok($seen[2][3] eq 'delta');             # 346
ok($seen[2][4] eq 'edward');            # 347
ok(@{$seen[3]} == 6);                   # 348
ok($seen[3][0] eq 'abel');              # 349
ok($seen[3][1] eq 'baker');             # 350
ok($seen[3][2] eq 'camera');            # 351
ok($seen[3][3] eq 'delta');             # 352
ok($seen[3][4] eq 'edward');            # 353
ok($seen[3][5] eq 'jerky');             # 354
ok(@{$seen[4]} == 6);                   # 355
ok($seen[4][0] eq 'abel');              # 356
ok($seen[4][1] eq 'baker');             # 357
ok($seen[4][2] eq 'camera');            # 358
ok($seen[4][3] eq 'delta');             # 359
ok($seen[4][4] eq 'edward');            # 360
ok($seen[4][5] eq 'jerky');             # 361





