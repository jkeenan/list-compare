# 26_alt_functional_multiple.t # As of 07/10/2004 

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
662;
use lib ("./t");
use List::Compare::Functional qw(:originals :aliases);
use Test::ListCompareSpecial qw(:seen);

$loaded = 1;
ok($loaded);                            # 1

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

# FIRST UNION
@union = get_union( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok($union[0] eq 'abel');                # 2
ok($union[1] eq 'baker');               # 3
ok($union[2] eq 'camera');              # 4
ok($union[3] eq 'delta');               # 5
ok($union[4] eq 'edward');              # 6
ok($union[5] eq 'fargo');               # 7
ok($union[6] eq 'golfer');              # 8
ok($union[7] eq 'hilton');              # 9
ok($union[8] eq 'icon');                # 10
ok($union[-1] eq 'jerky');              # 11

$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});               # 12
ok(exists $seen{'baker'});              # 13
ok(exists $seen{'camera'});             # 14
ok(exists $seen{'delta'});              # 15
ok(exists $seen{'edward'});             # 16
ok(exists $seen{'fargo'});              # 17
ok(exists $seen{'golfer'});             # 18
ok(exists $seen{'hilton'});             # 19
ok(exists $seen{'icon'});               # 20
ok(exists $seen{'jerky'});              # 21
%seen = ();

$union_ref = get_union_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok(${$union_ref}[0] eq 'abel');         # 22
ok(${$union_ref}[1] eq 'baker');        # 23
ok(${$union_ref}[2] eq 'camera');       # 24
ok(${$union_ref}[3] eq 'delta');        # 25
ok(${$union_ref}[4] eq 'edward');       # 26
ok(${$union_ref}[5] eq 'fargo');        # 27
ok(${$union_ref}[6] eq 'golfer');       # 28
ok(${$union_ref}[7] eq 'hilton');       # 29
ok(${$union_ref}[8] eq 'icon');         # 30
ok(${$union_ref}[-1] eq 'jerky');       # 31

$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});               # 32
ok(exists $seen{'baker'});              # 33
ok(exists $seen{'camera'});             # 34
ok(exists $seen{'delta'});              # 35
ok(exists $seen{'edward'});             # 36
ok(exists $seen{'fargo'});              # 37
ok(exists $seen{'golfer'});             # 38
ok(exists $seen{'hilton'});             # 39
ok(exists $seen{'icon'});               # 40
ok(exists $seen{'jerky'});              # 41
%seen = ();
# FIRST SHARED
@shared = get_shared( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok($shared[0] eq 'baker');              # 42
ok($shared[1] eq 'camera');             # 43
ok($shared[2] eq 'delta');              # 44
ok($shared[3] eq 'edward');             # 45
ok($shared[4] eq 'fargo');              # 46
ok($shared[5] eq 'golfer');             # 47
ok($shared[6] eq 'hilton');             # 48
ok($shared[-1] eq 'icon');              # 49

$seen{$_}++ foreach (@shared);
ok(! exists $seen{'abel'});             # 50
ok(exists $seen{'baker'});              # 51
ok(exists $seen{'camera'});             # 52
ok(exists $seen{'delta'});              # 53
ok(exists $seen{'edward'});             # 54
ok(exists $seen{'fargo'});              # 55
ok(exists $seen{'golfer'});             # 56
ok(exists $seen{'hilton'});             # 57
ok(exists $seen{'icon'});               # 58
ok(! exists $seen{'jerky'});            # 59
%seen = ();

$shared_ref = get_shared_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok(${$shared_ref}[0] eq 'baker');       # 60
ok(${$shared_ref}[1] eq 'camera');      # 61
ok(${$shared_ref}[2] eq 'delta');       # 62
ok(${$shared_ref}[3] eq 'edward');      # 63
ok(${$shared_ref}[4] eq 'fargo');       # 64
ok(${$shared_ref}[5] eq 'golfer');      # 65
ok(${$shared_ref}[6] eq 'hilton');      # 66
ok(${$shared_ref}[-1] eq 'icon');       # 67

$seen{$_}++ foreach (@{$shared_ref});
ok(! exists $seen{'abel'});             # 68
ok(exists $seen{'baker'});              # 69
ok(exists $seen{'camera'});             # 70
ok(exists $seen{'delta'});              # 71
ok(exists $seen{'edward'});             # 72
ok(exists $seen{'fargo'});              # 73
ok(exists $seen{'golfer'});             # 74
ok(exists $seen{'hilton'});             # 75
ok(exists $seen{'icon'});               # 76
ok(! exists $seen{'jerky'});            # 77
%seen = ();
# FIRST INTERSECTION
@intersection = get_intersection( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok($intersection[0] eq 'fargo');        # 78
ok($intersection[-1] eq 'golfer');      # 79

$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 80
ok(! exists $seen{'baker'});            # 81
ok(! exists $seen{'camera'});           # 82
ok(! exists $seen{'delta'});            # 83
ok(! exists $seen{'edward'});           # 84
ok(exists $seen{'fargo'});              # 85
ok(exists $seen{'golfer'});             # 86
ok(! exists $seen{'hilton'});           # 87
ok(! exists $seen{'icon'});             # 88
ok(! exists $seen{'jerky'});            # 89
%seen = ();

$intersection_ref = get_intersection_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok(${$intersection_ref}[0] eq 'fargo'); # 90
ok(${$intersection_ref}[-1] eq 'golfer');# 91

$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});             # 92
ok(! exists $seen{'baker'});            # 93
ok(! exists $seen{'camera'});           # 94
ok(! exists $seen{'delta'});            # 95
ok(! exists $seen{'edward'});           # 96
ok(exists $seen{'fargo'});              # 97
ok(exists $seen{'golfer'});             # 98
ok(! exists $seen{'hilton'});           # 99
ok(! exists $seen{'icon'});             # 100
ok(! exists $seen{'jerky'});            # 101
%seen = ();
# FIRST UNIQUE
@unique = get_unique( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok($unique[-1] eq 'abel');              # 102

$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 103
ok(! exists $seen{'baker'});            # 104
ok(! exists $seen{'camera'});           # 105
ok(! exists $seen{'delta'});            # 106
ok(! exists $seen{'edward'});           # 107
ok(! exists $seen{'fargo'});            # 108
ok(! exists $seen{'golfer'});           # 109
ok(! exists $seen{'hilton'});           # 110
ok(! exists $seen{'icon'});             # 111
ok(! exists $seen{'jerky'});            # 112
%seen = ();

$unique_ref = get_unique_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok(${$unique_ref}[-1] eq 'abel');       # 113

$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 114
ok(! exists $seen{'baker'});            # 115
ok(! exists $seen{'camera'});           # 116
ok(! exists $seen{'delta'});            # 117
ok(! exists $seen{'edward'});           # 118
ok(! exists $seen{'fargo'});            # 119
ok(! exists $seen{'golfer'});           # 120
ok(! exists $seen{'hilton'});           # 121
ok(! exists $seen{'icon'});             # 122
ok(! exists $seen{'jerky'});            # 123
%seen = ();

@unique = get_unique( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 2 } );
ok($unique[-1] eq 'jerky');             # 124

$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});             # 125
ok(! exists $seen{'baker'});            # 126
ok(! exists $seen{'camera'});           # 127
ok(! exists $seen{'delta'});            # 128
ok(! exists $seen{'edward'});           # 129
ok(! exists $seen{'fargo'});            # 130
ok(! exists $seen{'golfer'});           # 131
ok(! exists $seen{'hilton'});           # 132
ok(! exists $seen{'icon'});             # 133
ok(exists $seen{'jerky'});              # 134
%seen = ();

$unique_ref = get_unique_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 2 } );
ok(${$unique_ref}[-1] eq 'jerky');      # 135

$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});             # 136
ok(! exists $seen{'baker'});            # 137
ok(! exists $seen{'camera'});           # 138
ok(! exists $seen{'delta'});            # 139
ok(! exists $seen{'edward'});           # 140
ok(! exists $seen{'fargo'});            # 141
ok(! exists $seen{'golfer'});           # 142
ok(! exists $seen{'hilton'});           # 143
ok(! exists $seen{'icon'});             # 144
ok(exists $seen{'jerky'});              # 145
%seen = ();
# FIRST COMPLEMENT
@complement = get_complement( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok($complement[0] eq 'hilton');         # 146
ok($complement[1] eq 'icon');           # 147
ok($complement[-1] eq 'jerky');         # 148

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 149
ok(! exists $seen{'baker'});            # 150
ok(! exists $seen{'camera'});           # 151
ok(! exists $seen{'delta'});            # 152
ok(! exists $seen{'edward'});           # 153
ok(! exists $seen{'fargo'});            # 154
ok(! exists $seen{'golfer'});           # 155
ok(exists $seen{'hilton'});             # 156
ok(exists $seen{'icon'});               # 157
ok(exists $seen{'jerky'});              # 158
%seen = ();

$complement_ref = get_complement_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok(${$complement_ref}[0] eq 'hilton');  # 159
ok(${$complement_ref}[1] eq 'icon');    # 160
ok(${$complement_ref}[-1] eq 'jerky');  # 161

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 162
ok(! exists $seen{'baker'});            # 163
ok(! exists $seen{'camera'});           # 164
ok(! exists $seen{'delta'});            # 165
ok(! exists $seen{'edward'});           # 166
ok(! exists $seen{'fargo'});            # 167
ok(! exists $seen{'golfer'});           # 168
ok(exists $seen{'hilton'});             # 169
ok(exists $seen{'icon'});               # 170
ok(exists $seen{'jerky'});              # 171
%seen = ();

@complement = get_complement( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 3 } );
ok($complement[0] eq 'abel');           # 172
ok($complement[1] eq 'baker');          # 173
ok($complement[2] eq 'camera');         # 174
ok($complement[3] eq 'delta');          # 175
ok($complement[4] eq 'edward');         # 176
ok($complement[-1] eq 'jerky');         # 177

$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 178
ok(exists $seen{'baker'});              # 179
ok(exists $seen{'camera'});             # 180
ok(exists $seen{'delta'});              # 181
ok(exists $seen{'edward'});             # 182
ok(! exists $seen{'fargo'});            # 183
ok(! exists $seen{'golfer'});           # 184
ok(! exists $seen{'hilton'});           # 185
ok(! exists $seen{'icon'});             # 186
ok(exists $seen{'jerky'});              # 187
%seen = ();

$complement_ref = get_complement_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 3 } );
ok(${$complement_ref}[0] eq 'abel');    # 188
ok(${$complement_ref}[1] eq 'baker');   # 189
ok(${$complement_ref}[2] eq 'camera');  # 190
ok(${$complement_ref}[3] eq 'delta');   # 191
ok(${$complement_ref}[4] eq 'edward');  # 192
ok(${$complement_ref}[-1] eq 'jerky');  # 193

$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 194
ok(exists $seen{'baker'});              # 195
ok(exists $seen{'camera'});             # 196
ok(exists $seen{'delta'});              # 197
ok(exists $seen{'edward'});             # 198
ok(! exists $seen{'fargo'});            # 199
ok(! exists $seen{'golfer'});           # 200
ok(! exists $seen{'hilton'});           # 201
ok(! exists $seen{'icon'});             # 202
ok(exists $seen{'jerky'});              # 203
%seen = ();
# FIRST SYMMETRIC DIFFERENCE
@symmetric_difference = get_symmetric_difference( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok($symmetric_difference[0] eq 'abel'); # 204
ok($symmetric_difference[-1] eq 'jerky');# 205

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 206
ok(! exists $seen{'baker'});            # 207
ok(! exists $seen{'camera'});           # 208
ok(! exists $seen{'delta'});            # 209
ok(! exists $seen{'edward'});           # 210
ok(! exists $seen{'fargo'});            # 211
ok(! exists $seen{'golfer'});           # 212
ok(! exists $seen{'hilton'});           # 213
ok(! exists $seen{'icon'});             # 214
ok(exists $seen{'jerky'});              # 215
%seen = ();

$symmetric_difference_ref = get_symmetric_difference_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok(${$symmetric_difference_ref}[0] eq 'abel');# 216
ok(${$symmetric_difference_ref}[-1] eq 'jerky');# 217

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 218
ok(! exists $seen{'baker'});            # 219
ok(! exists $seen{'camera'});           # 220
ok(! exists $seen{'delta'});            # 221
ok(! exists $seen{'edward'});           # 222
ok(! exists $seen{'fargo'});            # 223
ok(! exists $seen{'golfer'});           # 224
ok(! exists $seen{'hilton'});           # 225
ok(! exists $seen{'icon'});             # 226
ok(exists $seen{'jerky'});              # 227
%seen = ();

@symmetric_difference = get_symdiff( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok($symmetric_difference[0] eq 'abel'); # 228
ok($symmetric_difference[-1] eq 'jerky');# 229

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 230
ok(! exists $seen{'baker'});            # 231
ok(! exists $seen{'camera'});           # 232
ok(! exists $seen{'delta'});            # 233
ok(! exists $seen{'edward'});           # 234
ok(! exists $seen{'fargo'});            # 235
ok(! exists $seen{'golfer'});           # 236
ok(! exists $seen{'hilton'});           # 237
ok(! exists $seen{'icon'});             # 238
ok(exists $seen{'jerky'});              # 239
%seen = ();

$symmetric_difference_ref = get_symdiff_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok(${$symmetric_difference_ref}[0] eq 'abel');# 240
ok(${$symmetric_difference_ref}[-1] eq 'jerky');# 241

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 242
ok(! exists $seen{'baker'});            # 243
ok(! exists $seen{'camera'});           # 244
ok(! exists $seen{'delta'});            # 245
ok(! exists $seen{'edward'});           # 246
ok(! exists $seen{'fargo'});            # 247
ok(! exists $seen{'golfer'});           # 248
ok(! exists $seen{'hilton'});           # 249
ok(! exists $seen{'icon'});             # 250
ok(exists $seen{'jerky'});              # 251
%seen = ();
# FIRST NONINTERSECTION 
@nonintersection = get_nonintersection( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok($nonintersection[0] eq 'abel');      # 252
ok($nonintersection[1] eq 'baker');     # 253
ok($nonintersection[2] eq 'camera');    # 254
ok($nonintersection[3] eq 'delta');     # 255
ok($nonintersection[4] eq 'edward');    # 256
ok($nonintersection[5] eq 'hilton');    # 257
ok($nonintersection[6] eq 'icon');      # 258
ok($nonintersection[-1] eq 'jerky');    # 259

$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 260
ok(exists $seen{'baker'});              # 261
ok(exists $seen{'camera'});             # 262
ok(exists $seen{'delta'});              # 263
ok(exists $seen{'edward'});             # 264
ok(! exists $seen{'fargo'});            # 265
ok(! exists $seen{'golfer'});           # 266
ok(exists $seen{'hilton'});             # 267
ok(exists $seen{'icon'});               # 268
ok(exists $seen{'jerky'});              # 269
%seen = ();

$nonintersection_ref = get_nonintersection_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok(${$nonintersection_ref}[0] eq 'abel');# 270
ok(${$nonintersection_ref}[1] eq 'baker');# 271
ok(${$nonintersection_ref}[2] eq 'camera');# 272
ok(${$nonintersection_ref}[3] eq 'delta');# 273
ok(${$nonintersection_ref}[4] eq 'edward');# 274
ok(${$nonintersection_ref}[5] eq 'hilton');# 275
ok(${$nonintersection_ref}[6] eq 'icon');# 276
ok(${$nonintersection_ref}[-1] eq 'jerky');# 277

$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 278
ok(exists $seen{'baker'});              # 279
ok(exists $seen{'camera'});             # 280
ok(exists $seen{'delta'});              # 281
ok(exists $seen{'edward'});             # 282
ok(! exists $seen{'fargo'});            # 283
ok(! exists $seen{'golfer'});           # 284
ok(exists $seen{'hilton'});             # 285
ok(exists $seen{'icon'});               # 286
ok(exists $seen{'jerky'});              # 287
%seen = ();
# FIRST BAG
@bag = get_bag( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok($bag[0] eq 'abel');                  # 288
ok($bag[1] eq 'abel');                  # 289
ok($bag[2] eq 'baker');                 # 290
ok($bag[3] eq 'baker');                 # 291
ok($bag[4] eq 'camera');                # 292
ok($bag[5] eq 'camera');                # 293
ok($bag[6] eq 'delta');                 # 294
ok($bag[7] eq 'delta');                 # 295
ok($bag[8] eq 'delta');                 # 296
ok($bag[9] eq 'edward');                # 297
ok($bag[10] eq 'edward');               # 298
ok($bag[11] eq 'fargo');                # 299
ok($bag[12] eq 'fargo');                # 300
ok($bag[13] eq 'fargo');                # 301
ok($bag[14] eq 'fargo');                # 302
ok($bag[15] eq 'fargo');                # 303
ok($bag[16] eq 'fargo');                # 304
ok($bag[17] eq 'golfer');               # 305
ok($bag[18] eq 'golfer');               # 306
ok($bag[19] eq 'golfer');               # 307
ok($bag[20] eq 'golfer');               # 308
ok($bag[21] eq 'golfer');               # 309
ok($bag[22] eq 'hilton');               # 310
ok($bag[23] eq 'hilton');               # 311
ok($bag[24] eq 'hilton');               # 312
ok($bag[25] eq 'hilton');               # 313
ok($bag[26] eq 'icon');                 # 314
ok($bag[27] eq 'icon');                 # 315
ok($bag[28] eq 'icon');                 # 316
ok($bag[29] eq 'icon');                 # 317
ok($bag[30] eq 'icon');                 # 318
ok($bag[-1] eq 'jerky');                # 319

$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 320
ok($seen{'baker'} == 2);                # 321
ok($seen{'camera'} == 2);               # 322
ok($seen{'delta'} == 3);                # 323
ok($seen{'edward'} == 2);               # 324
ok($seen{'fargo'} == 6);                # 325
ok($seen{'golfer'} == 5);               # 326
ok($seen{'hilton'} == 4);               # 327
ok($seen{'icon'} == 5);                 # 328
ok($seen{'jerky'} == 1);                # 329
%seen = ();

$bag_ref = get_bag_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok(${$bag_ref}[0] eq 'abel');           # 330
ok(${$bag_ref}[1] eq 'abel');           # 331
ok(${$bag_ref}[2] eq 'baker');          # 332
ok(${$bag_ref}[3] eq 'baker');          # 333
ok(${$bag_ref}[4] eq 'camera');         # 334
ok(${$bag_ref}[5] eq 'camera');         # 335
ok(${$bag_ref}[6] eq 'delta');          # 336
ok(${$bag_ref}[7] eq 'delta');          # 337
ok(${$bag_ref}[8] eq 'delta');          # 338
ok(${$bag_ref}[9] eq 'edward');         # 339
ok(${$bag_ref}[10] eq 'edward');        # 340
ok(${$bag_ref}[11] eq 'fargo');         # 341
ok(${$bag_ref}[12] eq 'fargo');         # 342
ok(${$bag_ref}[13] eq 'fargo');         # 343
ok(${$bag_ref}[14] eq 'fargo');         # 344
ok(${$bag_ref}[15] eq 'fargo');         # 345
ok(${$bag_ref}[16] eq 'fargo');         # 346
ok(${$bag_ref}[17] eq 'golfer');        # 347
ok(${$bag_ref}[18] eq 'golfer');        # 348
ok(${$bag_ref}[19] eq 'golfer');        # 349
ok(${$bag_ref}[20] eq 'golfer');        # 350
ok(${$bag_ref}[21] eq 'golfer');        # 351
ok(${$bag_ref}[22] eq 'hilton');        # 352
ok(${$bag_ref}[23] eq 'hilton');        # 353
ok(${$bag_ref}[24] eq 'hilton');        # 354
ok(${$bag_ref}[25] eq 'hilton');        # 355
ok(${$bag_ref}[26] eq 'icon');          # 356
ok(${$bag_ref}[27] eq 'icon');          # 357
ok(${$bag_ref}[28] eq 'icon');          # 358
ok(${$bag_ref}[29] eq 'icon');          # 359
ok(${$bag_ref}[30] eq 'icon');          # 360
ok(${$bag_ref}[-1] eq 'jerky');         # 361

$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 362
ok($seen{'baker'} == 2);                # 363
ok($seen{'camera'} == 2);               # 364
ok($seen{'delta'} == 3);                # 365
ok($seen{'edward'} == 2);               # 366
ok($seen{'fargo'} == 6);                # 367
ok($seen{'golfer'} == 5);               # 368
ok($seen{'hilton'} == 4);               # 369
ok($seen{'icon'} == 5);                 # 370
ok($seen{'jerky'} == 1);                # 371
%seen = ();

$LR = is_LsubsetR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok(! $LR);                              # 372

$LR = is_LsubsetR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], pair => [3,2] } );
ok($LR);                                # 373

$LR = is_LsubsetR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], pair => [4,2] } );
ok($LR);                                # 374

$RL = is_RsubsetL( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok(! $RL);                              # 375

$RL = is_RsubsetL( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], pair => [2,3] } );
ok($RL);                                # 376

$RL = is_RsubsetL( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], pair => [2,4] } );
ok($RL);                                # 377

$eqv = is_LequivalentR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok(! $eqv);                             # 378

$eqv = is_LeqvlntR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok(! $eqv);                             # 379

$eqv = is_LequivalentR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], pair => [3,4] } );
ok($eqv);                               # 380

$eqv = is_LeqvlntR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], pair => [3,4] } );
ok($eqv);                               # 381

$disj = is_LdisjointR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4, \@a8 ] } );
ok(! $disj);                            # 382

$disj = is_LdisjointR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4, \@a8 ], pair => [2,3] } );
ok(! $disj);                            # 383

$disj = is_LdisjointR( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4, \@a8 ], pair => [4,5] } );
ok($disj);                              # 384

$return = print_subset_chart( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok($return);                            # 385

$return = print_equivalence_chart( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
ok($return);                            # 386
# FIRST IS MEMBER WHICH
@memb_arr = is_member_which( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'abel' } );
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0   > ] ));# 387

@memb_arr = is_member_which( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'baker' } );
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1 > ] ));# 388

@memb_arr = is_member_which( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'camera' } );
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1 > ] ));# 389

@memb_arr = is_member_which( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'delta' } );
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1 > ] ));# 390

@memb_arr = is_member_which( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'edward' } );
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1 > ] ));# 391

@memb_arr = is_member_which( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'fargo' } );
ok(ok_seen_a( \@memb_arr, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 392

@memb_arr = is_member_which( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'golfer' } );
ok(ok_seen_a( \@memb_arr, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 393

@memb_arr = is_member_which( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'hilton' } );
ok(ok_seen_a( \@memb_arr, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 394

@memb_arr = is_member_which( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'icon' } );
ok(ok_seen_a( \@memb_arr, 'icon',   3, [ qw<     2 3 4 > ] ));# 395

@memb_arr = is_member_which( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'jerky' } );
ok(ok_seen_a( \@memb_arr, 'jerky',  1, [ qw<     2 > ] ));# 396

@memb_arr = is_member_which( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'zebra' } );
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<     > ] ));# 397


$memb_arr_ref = is_member_which_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'abel' } );
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0   > ] ));# 398

$memb_arr_ref = is_member_which_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'baker' } );
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1 > ] ));# 399

$memb_arr_ref = is_member_which_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'camera' } );
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1 > ] ));# 400

$memb_arr_ref = is_member_which_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'delta' } );
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1 > ] ));# 401

$memb_arr_ref = is_member_which_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'edward' } );
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1 > ] ));# 402

$memb_arr_ref = is_member_which_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'fargo' } );
ok(ok_seen_a( $memb_arr_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 403

$memb_arr_ref = is_member_which_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'golfer' } );
ok(ok_seen_a( $memb_arr_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 404

$memb_arr_ref = is_member_which_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'hilton' } );
ok(ok_seen_a( $memb_arr_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 405

$memb_arr_ref = is_member_which_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'icon' } );
ok(ok_seen_a( $memb_arr_ref, 'icon',   3, [ qw<     2 3 4 > ] ));# 406

$memb_arr_ref = is_member_which_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'jerky' } );
ok(ok_seen_a( $memb_arr_ref, 'jerky',  1, [ qw<     2 > ] ));# 407

$memb_arr_ref = is_member_which_ref( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'zebra' } );
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<     > ] ));# 408
# FIRST ARE MEMBERS WHICH
$memb_hash_ref = are_members_which( {
    lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , 
    items => [ qw| abel baker camera delta edward fargo
                   golfer hilton icon jerky zebra | ]
} );
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0   > ] ));# 409
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1 > ] ));# 410
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1 > ] ));# 411
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1 > ] ));# 412
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1 > ] ));# 413
ok(ok_seen_h( $memb_hash_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 414
ok(ok_seen_h( $memb_hash_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 415
ok(ok_seen_h( $memb_hash_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 416
ok(ok_seen_h( $memb_hash_ref, 'icon',   3, [ qw<     2 3 4 > ] ));# 417
ok(ok_seen_h( $memb_hash_ref, 'jerky',  1, [ qw<     2 > ] ));# 418
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<     > ] ));# 419
# FIRST IS MEMBER ANY
ok(is_member_any( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'abel' } ));# 420
ok(is_member_any( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'baker' } ));# 421
ok(is_member_any( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'camera' } ));# 422
ok(is_member_any( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'delta' } ));# 423
ok(is_member_any( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'edward' } ));# 424
ok(is_member_any( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'fargo' } ));# 425
ok(is_member_any( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'golfer' } ));# 426
ok(is_member_any( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'hilton' } ));# 427
ok(is_member_any( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'icon' } ));# 428
ok(is_member_any( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'jerky' } ));# 429
ok(! is_member_any( { lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 'zebra' } ));# 430
# FIRST ARE MEMBERS ANY
$memb_hash_ref = are_members_any( {
    lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ],
    items => [ qw| abel baker camera delta edward fargo 
                   golfer hilton icon jerky zebra | ]
} );
ok(ok_any_h( $memb_hash_ref, 'abel',   1 ));# 431
ok(ok_any_h( $memb_hash_ref, 'baker',  1 ));# 432
ok(ok_any_h( $memb_hash_ref, 'camera', 1 ));# 433
ok(ok_any_h( $memb_hash_ref, 'delta',  1 ));# 434
ok(ok_any_h( $memb_hash_ref, 'edward', 1 ));# 435
ok(ok_any_h( $memb_hash_ref, 'fargo',  1 ));# 436
ok(ok_any_h( $memb_hash_ref, 'golfer', 1 ));# 437
ok(ok_any_h( $memb_hash_ref, 'hilton', 1 ));# 438
ok(ok_any_h( $memb_hash_ref, 'icon',   1 ));# 439
ok(ok_any_h( $memb_hash_ref, 'jerky',  1 ));# 440
ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));# 441

$vers = get_version;
ok($vers);                              # 442

########## BELOW:  Tests for '-u' option ##########

@union = get_union( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});               # 443
ok(exists $seen{'baker'});              # 444
ok(exists $seen{'camera'});             # 445
ok(exists $seen{'delta'});              # 446
ok(exists $seen{'edward'});             # 447
ok(exists $seen{'fargo'});              # 448
ok(exists $seen{'golfer'});             # 449
ok(exists $seen{'hilton'});             # 450
ok(exists $seen{'icon'});               # 451
ok(exists $seen{'jerky'});              # 452
%seen = ();

$union_ref = get_union_ref( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});               # 453
ok(exists $seen{'baker'});              # 454
ok(exists $seen{'camera'});             # 455
ok(exists $seen{'delta'});              # 456
ok(exists $seen{'edward'});             # 457
ok(exists $seen{'fargo'});              # 458
ok(exists $seen{'golfer'});             # 459
ok(exists $seen{'hilton'});             # 460
ok(exists $seen{'icon'});               # 461
ok(exists $seen{'jerky'});              # 462
%seen = ();

@shared = get_shared( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@shared);
ok(! exists $seen{'abel'});             # 463
ok(exists $seen{'baker'});              # 464
ok(exists $seen{'camera'});             # 465
ok(exists $seen{'delta'});              # 466
ok(exists $seen{'edward'});             # 467
ok(exists $seen{'fargo'});              # 468
ok(exists $seen{'golfer'});             # 469
ok(exists $seen{'hilton'});             # 470
ok(exists $seen{'icon'});               # 471
ok(! exists $seen{'jerky'});            # 472
%seen = ();

$shared_ref = get_shared_ref( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@{$shared_ref});
ok(! exists $seen{'abel'});             # 473
ok(exists $seen{'baker'});              # 474
ok(exists $seen{'camera'});             # 475
ok(exists $seen{'delta'});              # 476
ok(exists $seen{'edward'});             # 477
ok(exists $seen{'fargo'});              # 478
ok(exists $seen{'golfer'});             # 479
ok(exists $seen{'hilton'});             # 480
ok(exists $seen{'icon'});               # 481
ok(! exists $seen{'jerky'});            # 482
%seen = ();

@intersection = get_intersection( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 483
ok(! exists $seen{'baker'});            # 484
ok(! exists $seen{'camera'});           # 485
ok(! exists $seen{'delta'});            # 486
ok(! exists $seen{'edward'});           # 487
ok(exists $seen{'fargo'});              # 488
ok(exists $seen{'golfer'});             # 489
ok(! exists $seen{'hilton'});           # 490
ok(! exists $seen{'icon'});             # 491
ok(! exists $seen{'jerky'});            # 492
%seen = ();

$intersection_ref = get_intersection_ref( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});             # 493
ok(! exists $seen{'baker'});            # 494
ok(! exists $seen{'camera'});           # 495
ok(! exists $seen{'delta'});            # 496
ok(! exists $seen{'edward'});           # 497
ok(exists $seen{'fargo'});              # 498
ok(exists $seen{'golfer'});             # 499
ok(! exists $seen{'hilton'});           # 500
ok(! exists $seen{'icon'});             # 501
ok(! exists $seen{'jerky'});            # 502
%seen = ();

@unique = get_unique( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 503
ok(! exists $seen{'baker'});            # 504
ok(! exists $seen{'camera'});           # 505
ok(! exists $seen{'delta'});            # 506
ok(! exists $seen{'edward'});           # 507
ok(! exists $seen{'fargo'});            # 508
ok(! exists $seen{'golfer'});           # 509
ok(! exists $seen{'hilton'});           # 510
ok(! exists $seen{'icon'});             # 511
ok(! exists $seen{'jerky'});            # 512
%seen = ();

$unique_ref = get_unique_ref( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 513
ok(! exists $seen{'baker'});            # 514
ok(! exists $seen{'camera'});           # 515
ok(! exists $seen{'delta'});            # 516
ok(! exists $seen{'edward'});           # 517
ok(! exists $seen{'fargo'});            # 518
ok(! exists $seen{'golfer'});           # 519
ok(! exists $seen{'hilton'});           # 520
ok(! exists $seen{'icon'});             # 521
ok(! exists $seen{'jerky'});            # 522
%seen = ();

@unique = get_unique( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 2 } );
$seen{$_}++ foreach (@unique);
ok(!exists $seen{'abel'});              # 523
ok(! exists $seen{'baker'});            # 524
ok(! exists $seen{'camera'});           # 525
ok(! exists $seen{'delta'});            # 526
ok(! exists $seen{'edward'});           # 527
ok(! exists $seen{'fargo'});            # 528
ok(! exists $seen{'golfer'});           # 529
ok(! exists $seen{'hilton'});           # 530
ok(! exists $seen{'icon'});             # 531
ok(exists $seen{'jerky'});              # 532
%seen = ();

$unique_ref = get_unique_ref( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 2 } );
$seen{$_}++ foreach (@{$unique_ref});
ok(!exists $seen{'abel'});              # 533
ok(! exists $seen{'baker'});            # 534
ok(! exists $seen{'camera'});           # 535
ok(! exists $seen{'delta'});            # 536
ok(! exists $seen{'edward'});           # 537
ok(! exists $seen{'fargo'});            # 538
ok(! exists $seen{'golfer'});           # 539
ok(! exists $seen{'hilton'});           # 540
ok(! exists $seen{'icon'});             # 541
ok(exists $seen{'jerky'});              # 542
%seen = ();

@complement = get_complement( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 543
ok(! exists $seen{'baker'});            # 544
ok(! exists $seen{'camera'});           # 545
ok(! exists $seen{'delta'});            # 546
ok(! exists $seen{'edward'});           # 547
ok(! exists $seen{'fargo'});            # 548
ok(! exists $seen{'golfer'});           # 549
ok(exists $seen{'hilton'});             # 550
ok(exists $seen{'icon'});               # 551
ok(exists $seen{'jerky'});              # 552
%seen = ();

$complement_ref = get_complement_ref( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 553
ok(! exists $seen{'baker'});            # 554
ok(! exists $seen{'camera'});           # 555
ok(! exists $seen{'delta'});            # 556
ok(! exists $seen{'edward'});           # 557
ok(! exists $seen{'fargo'});            # 558
ok(! exists $seen{'golfer'});           # 559
ok(exists $seen{'hilton'});             # 560
ok(exists $seen{'icon'});               # 561
ok(exists $seen{'jerky'});              # 562
%seen = ();

@complement = get_complement( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 3 } );
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 563
ok(exists $seen{'baker'});              # 564
ok(exists $seen{'camera'});             # 565
ok(exists $seen{'delta'});              # 566
ok(exists $seen{'edward'});             # 567
ok(! exists $seen{'fargo'});            # 568
ok(! exists $seen{'golfer'});           # 569
ok(! exists $seen{'hilton'});           # 570
ok(! exists $seen{'icon'});             # 571
ok(exists $seen{'jerky'});              # 572
%seen = ();

$complement_ref = get_complement_ref( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ], item => 3 } );
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 573
ok(exists $seen{'baker'});              # 574
ok(exists $seen{'camera'});             # 575
ok(exists $seen{'delta'});              # 576
ok(exists $seen{'edward'});             # 577
ok(! exists $seen{'fargo'});            # 578
ok(! exists $seen{'golfer'});           # 579
ok(! exists $seen{'hilton'});           # 580
ok(! exists $seen{'icon'});             # 581
ok(exists $seen{'jerky'});              # 582
%seen = ();

@symmetric_difference = get_symmetric_difference( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 583
ok(! exists $seen{'baker'});            # 584
ok(! exists $seen{'camera'});           # 585
ok(! exists $seen{'delta'});            # 586
ok(! exists $seen{'edward'});           # 587
ok(! exists $seen{'fargo'});            # 588
ok(! exists $seen{'golfer'});           # 589
ok(! exists $seen{'hilton'});           # 590
ok(! exists $seen{'icon'});             # 591
ok(exists $seen{'jerky'});              # 592
%seen = ();

$symmetric_difference_ref = get_symmetric_difference_ref( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 593
ok(! exists $seen{'baker'});            # 594
ok(! exists $seen{'camera'});           # 595
ok(! exists $seen{'delta'});            # 596
ok(! exists $seen{'edward'});           # 597
ok(! exists $seen{'fargo'});            # 598
ok(! exists $seen{'golfer'});           # 599
ok(! exists $seen{'hilton'});           # 600
ok(! exists $seen{'icon'});             # 601
ok(exists $seen{'jerky'});              # 602
%seen = ();

@symmetric_difference = get_symdiff( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 603
ok(! exists $seen{'baker'});            # 604
ok(! exists $seen{'camera'});           # 605
ok(! exists $seen{'delta'});            # 606
ok(! exists $seen{'edward'});           # 607
ok(! exists $seen{'fargo'});            # 608
ok(! exists $seen{'golfer'});           # 609
ok(! exists $seen{'hilton'});           # 610
ok(! exists $seen{'icon'});             # 611
ok(exists $seen{'jerky'});              # 612
%seen = ();

$symmetric_difference_ref = get_symdiff_ref( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 613
ok(! exists $seen{'baker'});            # 614
ok(! exists $seen{'camera'});           # 615
ok(! exists $seen{'delta'});            # 616
ok(! exists $seen{'edward'});           # 617
ok(! exists $seen{'fargo'});            # 618
ok(! exists $seen{'golfer'});           # 619
ok(! exists $seen{'hilton'});           # 620
ok(! exists $seen{'icon'});             # 621
ok(exists $seen{'jerky'});              # 622
%seen = ();

@nonintersection = get_nonintersection( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 623
ok(exists $seen{'baker'});              # 624
ok(exists $seen{'camera'});             # 625
ok(exists $seen{'delta'});              # 626
ok(exists $seen{'edward'});             # 627
ok(! exists $seen{'fargo'});            # 628
ok(! exists $seen{'golfer'});           # 629
ok(exists $seen{'hilton'});             # 630
ok(exists $seen{'icon'});               # 631
ok(exists $seen{'jerky'});              # 632
%seen = ();

$nonintersection_ref = get_nonintersection_ref( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 633
ok(exists $seen{'baker'});              # 634
ok(exists $seen{'camera'});             # 635
ok(exists $seen{'delta'});              # 636
ok(exists $seen{'edward'});             # 637
ok(! exists $seen{'fargo'});            # 638
ok(! exists $seen{'golfer'});           # 639
ok(exists $seen{'hilton'});             # 640
ok(exists $seen{'icon'});               # 641
ok(exists $seen{'jerky'});              # 642
%seen = ();

@bag = get_bag( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 643
ok($seen{'baker'} == 2);                # 644
ok($seen{'camera'} == 2);               # 645
ok($seen{'delta'} == 3);                # 646
ok($seen{'edward'} == 2);               # 647
ok($seen{'fargo'} == 6);                # 648
ok($seen{'golfer'} == 5);               # 649
ok($seen{'hilton'} == 4);               # 650
ok($seen{'icon'} == 5);                 # 651
ok($seen{'jerky'} == 1);                # 652
%seen = ();

$bag_ref = get_bag_ref( { unsorted => 1, lists => [ \@a0, \@a1, \@a2, \@a3, \@a4 ] } );
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 653
ok($seen{'baker'} == 2);                # 654
ok($seen{'camera'} == 2);               # 655
ok($seen{'delta'} == 3);                # 656
ok($seen{'edward'} == 2);               # 657
ok($seen{'fargo'} == 6);                # 658
ok($seen{'golfer'} == 5);               # 659
ok($seen{'hilton'} == 4);               # 660
ok($seen{'icon'} == 5);                 # 661
ok($seen{'jerky'} == 1);                # 662
%seen = ();

