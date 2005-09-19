# 11_functional_multiple.t # as of 8/7/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
940;
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
@union = get_union( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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

$union_ref = get_union_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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
@shared = get_shared( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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

$shared_ref = get_shared_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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
@intersection = get_intersection( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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

$intersection_ref = get_intersection_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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
@unique = get_unique( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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

$unique_ref = get_unique_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
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

@unique = get_unique( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2] );
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

$unique_ref = get_unique_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2] );
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

eval { $unique_ref = get_unique_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2], [3] ) };
ok(ok_capture_error($@));               # 146

# FIRST COMPLEMENT
@complement = get_complement( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($complement[0] eq 'hilton');         # 147
ok($complement[1] eq 'icon');           # 148
ok($complement[-1] eq 'jerky');         # 149

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 150
ok(! exists $seen{'baker'});            # 151
ok(! exists $seen{'camera'});           # 152
ok(! exists $seen{'delta'});            # 153
ok(! exists $seen{'edward'});           # 154
ok(! exists $seen{'fargo'});            # 155
ok(! exists $seen{'golfer'});           # 156
ok(exists $seen{'hilton'});             # 157
ok(exists $seen{'icon'});               # 158
ok(exists $seen{'jerky'});              # 159
%seen = ();

$complement_ref = get_complement_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(${$complement_ref}[0] eq 'hilton');  # 160
ok(${$complement_ref}[1] eq 'icon');    # 161
ok(${$complement_ref}[-1] eq 'jerky');  # 162

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 163
ok(! exists $seen{'baker'});            # 164
ok(! exists $seen{'camera'});           # 165
ok(! exists $seen{'delta'});            # 166
ok(! exists $seen{'edward'});           # 167
ok(! exists $seen{'fargo'});            # 168
ok(! exists $seen{'golfer'});           # 169
ok(exists $seen{'hilton'});             # 170
ok(exists $seen{'icon'});               # 171
ok(exists $seen{'jerky'});              # 172
%seen = ();

@complement = get_complement( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3] );
ok($complement[0] eq 'abel');           # 173
ok($complement[1] eq 'baker');          # 174
ok($complement[2] eq 'camera');         # 175
ok($complement[3] eq 'delta');          # 176
ok($complement[4] eq 'edward');         # 177
ok($complement[-1] eq 'jerky');         # 178

$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 179
ok(exists $seen{'baker'});              # 180
ok(exists $seen{'camera'});             # 181
ok(exists $seen{'delta'});              # 182
ok(exists $seen{'edward'});             # 183
ok(! exists $seen{'fargo'});            # 184
ok(! exists $seen{'golfer'});           # 185
ok(! exists $seen{'hilton'});           # 186
ok(! exists $seen{'icon'});             # 187
ok(exists $seen{'jerky'});              # 188
%seen = ();

$complement_ref = get_complement_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3] );
ok(${$complement_ref}[0] eq 'abel');    # 189
ok(${$complement_ref}[1] eq 'baker');   # 190
ok(${$complement_ref}[2] eq 'camera');  # 191
ok(${$complement_ref}[3] eq 'delta');   # 192
ok(${$complement_ref}[4] eq 'edward');  # 193
ok(${$complement_ref}[-1] eq 'jerky');  # 194

$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 195
ok(exists $seen{'baker'});              # 196
ok(exists $seen{'camera'});             # 197
ok(exists $seen{'delta'});              # 198
ok(exists $seen{'edward'});             # 199
ok(! exists $seen{'fargo'});            # 200
ok(! exists $seen{'golfer'});           # 201
ok(! exists $seen{'hilton'});           # 202
ok(! exists $seen{'icon'});             # 203
ok(exists $seen{'jerky'});              # 204
%seen = ();

eval { $complement_ref = get_complement_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2], [3] ) };
ok(ok_capture_error($@));               # 205

# FIRST SYMMETRIC DIFFERENCE
@symmetric_difference = get_symmetric_difference( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($symmetric_difference[0] eq 'abel'); # 206
ok($symmetric_difference[-1] eq 'jerky');# 207

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 208
ok(! exists $seen{'baker'});            # 209
ok(! exists $seen{'camera'});           # 210
ok(! exists $seen{'delta'});            # 211
ok(! exists $seen{'edward'});           # 212
ok(! exists $seen{'fargo'});            # 213
ok(! exists $seen{'golfer'});           # 214
ok(! exists $seen{'hilton'});           # 215
ok(! exists $seen{'icon'});             # 216
ok(exists $seen{'jerky'});              # 217
%seen = ();

$symmetric_difference_ref = get_symmetric_difference_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(${$symmetric_difference_ref}[0] eq 'abel');# 218
ok(${$symmetric_difference_ref}[-1] eq 'jerky');# 219

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 220
ok(! exists $seen{'baker'});            # 221
ok(! exists $seen{'camera'});           # 222
ok(! exists $seen{'delta'});            # 223
ok(! exists $seen{'edward'});           # 224
ok(! exists $seen{'fargo'});            # 225
ok(! exists $seen{'golfer'});           # 226
ok(! exists $seen{'hilton'});           # 227
ok(! exists $seen{'icon'});             # 228
ok(exists $seen{'jerky'});              # 229
%seen = ();

@symmetric_difference = get_symdiff( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($symmetric_difference[0] eq 'abel'); # 230
ok($symmetric_difference[-1] eq 'jerky');# 231

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 232
ok(! exists $seen{'baker'});            # 233
ok(! exists $seen{'camera'});           # 234
ok(! exists $seen{'delta'});            # 235
ok(! exists $seen{'edward'});           # 236
ok(! exists $seen{'fargo'});            # 237
ok(! exists $seen{'golfer'});           # 238
ok(! exists $seen{'hilton'});           # 239
ok(! exists $seen{'icon'});             # 240
ok(exists $seen{'jerky'});              # 241
%seen = ();

$symmetric_difference_ref = get_symdiff_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(${$symmetric_difference_ref}[0] eq 'abel');# 242
ok(${$symmetric_difference_ref}[-1] eq 'jerky');# 243

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 244
ok(! exists $seen{'baker'});            # 245
ok(! exists $seen{'camera'});           # 246
ok(! exists $seen{'delta'});            # 247
ok(! exists $seen{'edward'});           # 248
ok(! exists $seen{'fargo'});            # 249
ok(! exists $seen{'golfer'});           # 250
ok(! exists $seen{'hilton'});           # 251
ok(! exists $seen{'icon'});             # 252
ok(exists $seen{'jerky'});              # 253
%seen = ();
# FIRST NONINTERSECTION 
@nonintersection = get_nonintersection( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($nonintersection[0] eq 'abel');      # 254
ok($nonintersection[1] eq 'baker');     # 255
ok($nonintersection[2] eq 'camera');    # 256
ok($nonintersection[3] eq 'delta');     # 257
ok($nonintersection[4] eq 'edward');    # 258
ok($nonintersection[5] eq 'hilton');    # 259
ok($nonintersection[6] eq 'icon');      # 260
ok($nonintersection[-1] eq 'jerky');    # 261

$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 262
ok(exists $seen{'baker'});              # 263
ok(exists $seen{'camera'});             # 264
ok(exists $seen{'delta'});              # 265
ok(exists $seen{'edward'});             # 266
ok(! exists $seen{'fargo'});            # 267
ok(! exists $seen{'golfer'});           # 268
ok(exists $seen{'hilton'});             # 269
ok(exists $seen{'icon'});               # 270
ok(exists $seen{'jerky'});              # 271
%seen = ();

$nonintersection_ref = get_nonintersection_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(${$nonintersection_ref}[0] eq 'abel');# 272
ok(${$nonintersection_ref}[1] eq 'baker');# 273
ok(${$nonintersection_ref}[2] eq 'camera');# 274
ok(${$nonintersection_ref}[3] eq 'delta');# 275
ok(${$nonintersection_ref}[4] eq 'edward');# 276
ok(${$nonintersection_ref}[5] eq 'hilton');# 277
ok(${$nonintersection_ref}[6] eq 'icon');# 278
ok(${$nonintersection_ref}[-1] eq 'jerky');# 279

$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 280
ok(exists $seen{'baker'});              # 281
ok(exists $seen{'camera'});             # 282
ok(exists $seen{'delta'});              # 283
ok(exists $seen{'edward'});             # 284
ok(! exists $seen{'fargo'});            # 285
ok(! exists $seen{'golfer'});           # 286
ok(exists $seen{'hilton'});             # 287
ok(exists $seen{'icon'});               # 288
ok(exists $seen{'jerky'});              # 289
%seen = ();
# FIRST BAG
@bag = get_bag( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($bag[0] eq 'abel');                  # 290
ok($bag[1] eq 'abel');                  # 291
ok($bag[2] eq 'baker');                 # 292
ok($bag[3] eq 'baker');                 # 293
ok($bag[4] eq 'camera');                # 294
ok($bag[5] eq 'camera');                # 295
ok($bag[6] eq 'delta');                 # 296
ok($bag[7] eq 'delta');                 # 297
ok($bag[8] eq 'delta');                 # 298
ok($bag[9] eq 'edward');                # 299
ok($bag[10] eq 'edward');               # 300
ok($bag[11] eq 'fargo');                # 301
ok($bag[12] eq 'fargo');                # 302
ok($bag[13] eq 'fargo');                # 303
ok($bag[14] eq 'fargo');                # 304
ok($bag[15] eq 'fargo');                # 305
ok($bag[16] eq 'fargo');                # 306
ok($bag[17] eq 'golfer');               # 307
ok($bag[18] eq 'golfer');               # 308
ok($bag[19] eq 'golfer');               # 309
ok($bag[20] eq 'golfer');               # 310
ok($bag[21] eq 'golfer');               # 311
ok($bag[22] eq 'hilton');               # 312
ok($bag[23] eq 'hilton');               # 313
ok($bag[24] eq 'hilton');               # 314
ok($bag[25] eq 'hilton');               # 315
ok($bag[26] eq 'icon');                 # 316
ok($bag[27] eq 'icon');                 # 317
ok($bag[28] eq 'icon');                 # 318
ok($bag[29] eq 'icon');                 # 319
ok($bag[30] eq 'icon');                 # 320
ok($bag[-1] eq 'jerky');                # 321

$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 322
ok($seen{'baker'} == 2);                # 323
ok($seen{'camera'} == 2);               # 324
ok($seen{'delta'} == 3);                # 325
ok($seen{'edward'} == 2);               # 326
ok($seen{'fargo'} == 6);                # 327
ok($seen{'golfer'} == 5);               # 328
ok($seen{'hilton'} == 4);               # 329
ok($seen{'icon'} == 5);                 # 330
ok($seen{'jerky'} == 1);                # 331
%seen = ();

$bag_ref = get_bag_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(${$bag_ref}[0] eq 'abel');           # 332
ok(${$bag_ref}[1] eq 'abel');           # 333
ok(${$bag_ref}[2] eq 'baker');          # 334
ok(${$bag_ref}[3] eq 'baker');          # 335
ok(${$bag_ref}[4] eq 'camera');         # 336
ok(${$bag_ref}[5] eq 'camera');         # 337
ok(${$bag_ref}[6] eq 'delta');          # 338
ok(${$bag_ref}[7] eq 'delta');          # 339
ok(${$bag_ref}[8] eq 'delta');          # 340
ok(${$bag_ref}[9] eq 'edward');         # 341
ok(${$bag_ref}[10] eq 'edward');        # 342
ok(${$bag_ref}[11] eq 'fargo');         # 343
ok(${$bag_ref}[12] eq 'fargo');         # 344
ok(${$bag_ref}[13] eq 'fargo');         # 345
ok(${$bag_ref}[14] eq 'fargo');         # 346
ok(${$bag_ref}[15] eq 'fargo');         # 347
ok(${$bag_ref}[16] eq 'fargo');         # 348
ok(${$bag_ref}[17] eq 'golfer');        # 349
ok(${$bag_ref}[18] eq 'golfer');        # 350
ok(${$bag_ref}[19] eq 'golfer');        # 351
ok(${$bag_ref}[20] eq 'golfer');        # 352
ok(${$bag_ref}[21] eq 'golfer');        # 353
ok(${$bag_ref}[22] eq 'hilton');        # 354
ok(${$bag_ref}[23] eq 'hilton');        # 355
ok(${$bag_ref}[24] eq 'hilton');        # 356
ok(${$bag_ref}[25] eq 'hilton');        # 357
ok(${$bag_ref}[26] eq 'icon');          # 358
ok(${$bag_ref}[27] eq 'icon');          # 359
ok(${$bag_ref}[28] eq 'icon');          # 360
ok(${$bag_ref}[29] eq 'icon');          # 361
ok(${$bag_ref}[30] eq 'icon');          # 362
ok(${$bag_ref}[-1] eq 'jerky');         # 363

$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 364
ok($seen{'baker'} == 2);                # 365
ok($seen{'camera'} == 2);               # 366
ok($seen{'delta'} == 3);                # 367
ok($seen{'edward'} == 2);               # 368
ok($seen{'fargo'} == 6);                # 369
ok($seen{'golfer'} == 5);               # 370
ok($seen{'hilton'} == 4);               # 371
ok($seen{'icon'} == 5);                 # 372
ok($seen{'jerky'} == 1);                # 373
%seen = ();

$LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(! $LR);                              # 374

$LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3,2] );
ok($LR);                                # 375
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 376
ok($seen{'baker'} == 2);                # 377
ok($seen{'camera'} == 2);               # 378
ok($seen{'delta'} == 3);                # 379
ok($seen{'edward'} == 2);               # 380
ok($seen{'fargo'} == 6);                # 381
ok($seen{'golfer'} == 5);               # 382
ok($seen{'hilton'} == 4);               # 383
ok($seen{'icon'} == 5);                 # 384
ok($seen{'jerky'} == 1);                # 385
%seen = ();

$bag_ref = get_bag_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 386
ok($seen{'baker'} == 2);                # 387
ok($seen{'camera'} == 2);               # 388
ok($seen{'delta'} == 3);                # 389
ok($seen{'edward'} == 2);               # 390
ok($seen{'fargo'} == 6);                # 391
ok($seen{'golfer'} == 5);               # 392
ok($seen{'hilton'} == 4);               # 393
ok($seen{'icon'} == 5);                 # 394
ok($seen{'jerky'} == 1);                # 395
%seen = ();

$LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(! $LR);                              # 396

$LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3,2] );
ok($LR);                                # 397

$LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [4,2] );
ok($LR);                                # 398

eval { $LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [8,9] ) };
ok(ok_capture_error($@));               # 399

eval { $LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2,9] ) };
ok(ok_capture_error($@));               # 400

eval { $LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2,3,4] ) };
ok(ok_capture_error($@));               # 401

eval { $LR = is_LsubsetR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3,2], [2,3] ) };
ok(ok_capture_error($@));               # 402


$RL = is_RsubsetL( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(! $RL);                              # 403

$RL = is_RsubsetL( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2,3] );
ok($RL);                                # 404

$RL = is_RsubsetL( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2,4] );
ok($RL);                                # 405

$eqv = is_LequivalentR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(! $eqv);                             # 406

$eqv = is_LeqvlntR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok(! $eqv);                             # 407

$eqv = is_LequivalentR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3,4] );
ok($eqv);                               # 408

eval { $eqv = is_LequivalentR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [8,9] ) };
ok(ok_capture_error($@));               # 409

eval { $eqv = is_LequivalentR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2,9] ) };
ok(ok_capture_error($@));               # 410

eval { $eqv = is_LequivalentR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2,3,4] ) };
ok(ok_capture_error($@));               # 411

eval { $eqv = is_LequivalentR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3,2], [2,3] ) };
ok(ok_capture_error($@));               # 412

$eqv = is_LeqvlntR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3,4] );
ok($eqv);                               # 413

$return = print_subset_chart( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($return);                            # 414

eval { $return = print_subset_chart( [ \@a0, \@a1, \@a2, \@a3, \@a4 ],
    [ qw| extraneous argument | ],
) };
ok(ok_capture_error($@));               # 415

$return = print_equivalence_chart( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
ok($return);                            # 416

eval { $return = print_equivalence_chart( [ \@a0, \@a1, \@a2, \@a3, \@a4 ],
    [ qw| extraneous argument | ],
) };
ok(ok_capture_error($@));               # 417

# FIRST IS MEMBER WHICH
@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'abel' ] );
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0   > ] ));# 418

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'baker' ] );
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1 > ] ));# 419

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'camera' ] );
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1 > ] ));# 420

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'delta' ] );
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1 > ] ));# 421

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'edward' ] );
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1 > ] ));# 422

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'fargo' ] );
ok(ok_seen_a( \@memb_arr, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 423

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'golfer' ] );
ok(ok_seen_a( \@memb_arr, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 424

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'hilton' ] );
ok(ok_seen_a( \@memb_arr, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 425

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'icon' ] );
ok(ok_seen_a( \@memb_arr, 'icon',   3, [ qw<     2 3 4 > ] ));# 426

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'jerky' ] );
ok(ok_seen_a( \@memb_arr, 'jerky',  1, [ qw<     2 > ] ));# 427

@memb_arr = is_member_which( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'zebra' ] );
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<     > ] ));# 428


$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'abel' ] );
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0   > ] ));# 429

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'baker' ] );
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1 > ] ));# 430

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'camera' ] );
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1 > ] ));# 431

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'delta' ] );
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1 > ] ));# 432

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'edward' ] );
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1 > ] ));# 433

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'fargo' ] );
ok(ok_seen_a( $memb_arr_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 434

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'golfer' ] );
ok(ok_seen_a( $memb_arr_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 435

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'hilton' ] );
ok(ok_seen_a( $memb_arr_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 436

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'icon' ] );
ok(ok_seen_a( $memb_arr_ref, 'icon',   3, [ qw<     2 3 4 > ] ));# 437

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'jerky' ] );
ok(ok_seen_a( $memb_arr_ref, 'jerky',  1, [ qw<     2 > ] ));# 438

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'zebra' ] );
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<     > ] ));# 439
# FIRST ARE MEMBERS WHICH
$memb_hash_ref = are_members_which(  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , 
    [ qw| abel baker camera delta edward fargo golfer hilton icon jerky zebra | ] );
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0   > ] ));# 440
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1 > ] ));# 441
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1 > ] ));# 442
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1 > ] ));# 443
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1 > ] ));# 444
ok(ok_seen_h( $memb_hash_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 445
ok(ok_seen_h( $memb_hash_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 446
ok(ok_seen_h( $memb_hash_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 447
ok(ok_seen_h( $memb_hash_ref, 'icon',   3, [ qw<     2 3 4 > ] ));# 448
ok(ok_seen_h( $memb_hash_ref, 'jerky',  1, [ qw<     2 > ] ));# 449
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<     > ] ));# 450

eval { $memb_hash_ref = are_members_which(
    [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , 
    [ qw| abel baker camera delta edward fargo golfer hilton icon jerky zebra | ],
    [ qw| extraneous argument | ]
) };
ok(ok_capture_error($@));               # 451

# FIRST IS MEMBER ANY
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'abel' ] ));# 452
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'baker' ] ));# 453
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'camera' ] ));# 454
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'delta' ] ));# 455
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'edward' ] ));# 456
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'fargo' ] ));# 457
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'golfer' ] ));# 458
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'hilton' ] ));# 459
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'icon' ] ));# 460
ok(is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'jerky' ] ));# 461
ok(! is_member_any( [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , [ 'zebra' ] ));# 462
# FIRST ARE MEMBERS ANY
$memb_hash_ref = are_members_any(  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , 
    [ qw| abel baker camera delta edward fargo golfer hilton icon jerky zebra | ] );
ok(ok_any_h( $memb_hash_ref, 'abel',   1 ));# 463
ok(ok_any_h( $memb_hash_ref, 'baker',  1 ));# 464
ok(ok_any_h( $memb_hash_ref, 'camera', 1 ));# 465
ok(ok_any_h( $memb_hash_ref, 'delta',  1 ));# 466
ok(ok_any_h( $memb_hash_ref, 'edward', 1 ));# 467
ok(ok_any_h( $memb_hash_ref, 'fargo',  1 ));# 468
ok(ok_any_h( $memb_hash_ref, 'golfer', 1 ));# 469
ok(ok_any_h( $memb_hash_ref, 'hilton', 1 ));# 470
ok(ok_any_h( $memb_hash_ref, 'icon',   1 ));# 471
ok(ok_any_h( $memb_hash_ref, 'jerky',  1 ));# 472
ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));# 473

eval { $memb_hash_ref = are_members_any(
    [ \@a0, \@a1, \@a2, \@a3, \@a4 ] , 
    [ qw| abel baker camera delta edward fargo golfer hilton icon jerky zebra | ],
    [ qw| extraneous argument | ]
) };
ok(ok_capture_error($@));               # 474

$vers = get_version;
ok($vers);                              # 475

$disj = is_LdisjointR( [ \@a0, \@a1, \@a2, \@a3, \@a4, \@a8 ] );
ok(! $disj);                            # 476

$disj = is_LdisjointR( [ \@a0, \@a1, \@a2, \@a3, \@a4, \@a8 ], [2,3] );
ok(! $disj);                            # 477

$disj = is_LdisjointR( [ \@a0, \@a1, \@a2, \@a3, \@a4, \@a8 ], [4,5] );
ok($disj);                              # 478

eval { $disj = is_LdisjointR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [8,9] ) };
ok(ok_capture_error($@));               # 479

eval { $disj = is_LdisjointR( [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3,2], [2,3] ) };
ok(ok_capture_error($@));               # 480

########## BELOW:  Tests for '-u' option ##########

@union = get_union('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});               # 481
ok(exists $seen{'baker'});              # 482
ok(exists $seen{'camera'});             # 483
ok(exists $seen{'delta'});              # 484
ok(exists $seen{'edward'});             # 485
ok(exists $seen{'fargo'});              # 486
ok(exists $seen{'golfer'});             # 487
ok(exists $seen{'hilton'});             # 488
ok(exists $seen{'icon'});               # 489
ok(exists $seen{'jerky'});              # 490
%seen = ();

$union_ref = get_union_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});               # 491
ok(exists $seen{'baker'});              # 492
ok(exists $seen{'camera'});             # 493
ok(exists $seen{'delta'});              # 494
ok(exists $seen{'edward'});             # 495
ok(exists $seen{'fargo'});              # 496
ok(exists $seen{'golfer'});             # 497
ok(exists $seen{'hilton'});             # 498
ok(exists $seen{'icon'});               # 499
ok(exists $seen{'jerky'});              # 500
%seen = ();

@shared = get_shared('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@shared);
ok(! exists $seen{'abel'});             # 501
ok(exists $seen{'baker'});              # 502
ok(exists $seen{'camera'});             # 503
ok(exists $seen{'delta'});              # 504
ok(exists $seen{'edward'});             # 505
ok(exists $seen{'fargo'});              # 506
ok(exists $seen{'golfer'});             # 507
ok(exists $seen{'hilton'});             # 508
ok(exists $seen{'icon'});               # 509
ok(! exists $seen{'jerky'});            # 510
%seen = ();

$shared_ref = get_shared_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$shared_ref});
ok(! exists $seen{'abel'});             # 511
ok(exists $seen{'baker'});              # 512
ok(exists $seen{'camera'});             # 513
ok(exists $seen{'delta'});              # 514
ok(exists $seen{'edward'});             # 515
ok(exists $seen{'fargo'});              # 516
ok(exists $seen{'golfer'});             # 517
ok(exists $seen{'hilton'});             # 518
ok(exists $seen{'icon'});               # 519
ok(! exists $seen{'jerky'});            # 520
%seen = ();

@intersection = get_intersection('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 521
ok(! exists $seen{'baker'});            # 522
ok(! exists $seen{'camera'});           # 523
ok(! exists $seen{'delta'});            # 524
ok(! exists $seen{'edward'});           # 525
ok(exists $seen{'fargo'});              # 526
ok(exists $seen{'golfer'});             # 527
ok(! exists $seen{'hilton'});           # 528
ok(! exists $seen{'icon'});             # 529
ok(! exists $seen{'jerky'});            # 530
%seen = ();

$intersection_ref = get_intersection_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});             # 531
ok(! exists $seen{'baker'});            # 532
ok(! exists $seen{'camera'});           # 533
ok(! exists $seen{'delta'});            # 534
ok(! exists $seen{'edward'});           # 535
ok(exists $seen{'fargo'});              # 536
ok(exists $seen{'golfer'});             # 537
ok(! exists $seen{'hilton'});           # 538
ok(! exists $seen{'icon'});             # 539
ok(! exists $seen{'jerky'});            # 540
%seen = ();

@unique = get_unique('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 541
ok(! exists $seen{'baker'});            # 542
ok(! exists $seen{'camera'});           # 543
ok(! exists $seen{'delta'});            # 544
ok(! exists $seen{'edward'});           # 545
ok(! exists $seen{'fargo'});            # 546
ok(! exists $seen{'golfer'});           # 547
ok(! exists $seen{'hilton'});           # 548
ok(! exists $seen{'icon'});             # 549
ok(! exists $seen{'jerky'});            # 550
%seen = ();

$unique_ref = get_unique_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 551
ok(! exists $seen{'baker'});            # 552
ok(! exists $seen{'camera'});           # 553
ok(! exists $seen{'delta'});            # 554
ok(! exists $seen{'edward'});           # 555
ok(! exists $seen{'fargo'});            # 556
ok(! exists $seen{'golfer'});           # 557
ok(! exists $seen{'hilton'});           # 558
ok(! exists $seen{'icon'});             # 559
ok(! exists $seen{'jerky'});            # 560
%seen = ();

@unique = get_unique('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2] );
$seen{$_}++ foreach (@unique);
ok(!exists $seen{'abel'});              # 561
ok(! exists $seen{'baker'});            # 562
ok(! exists $seen{'camera'});           # 563
ok(! exists $seen{'delta'});            # 564
ok(! exists $seen{'edward'});           # 565
ok(! exists $seen{'fargo'});            # 566
ok(! exists $seen{'golfer'});           # 567
ok(! exists $seen{'hilton'});           # 568
ok(! exists $seen{'icon'});             # 569
ok(exists $seen{'jerky'});              # 570
%seen = ();

$unique_ref = get_unique_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2] );
$seen{$_}++ foreach (@{$unique_ref});
ok(!exists $seen{'abel'});              # 571
ok(! exists $seen{'baker'});            # 572
ok(! exists $seen{'camera'});           # 573
ok(! exists $seen{'delta'});            # 574
ok(! exists $seen{'edward'});           # 575
ok(! exists $seen{'fargo'});            # 576
ok(! exists $seen{'golfer'});           # 577
ok(! exists $seen{'hilton'});           # 578
ok(! exists $seen{'icon'});             # 579
ok(exists $seen{'jerky'});              # 580
%seen = ();

@complement = get_complement('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 581
ok(! exists $seen{'baker'});            # 582
ok(! exists $seen{'camera'});           # 583
ok(! exists $seen{'delta'});            # 584
ok(! exists $seen{'edward'});           # 585
ok(! exists $seen{'fargo'});            # 586
ok(! exists $seen{'golfer'});           # 587
ok(exists $seen{'hilton'});             # 588
ok(exists $seen{'icon'});               # 589
ok(exists $seen{'jerky'});              # 590
%seen = ();

$complement_ref = get_complement_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 591
ok(! exists $seen{'baker'});            # 592
ok(! exists $seen{'camera'});           # 593
ok(! exists $seen{'delta'});            # 594
ok(! exists $seen{'edward'});           # 595
ok(! exists $seen{'fargo'});            # 596
ok(! exists $seen{'golfer'});           # 597
ok(exists $seen{'hilton'});             # 598
ok(exists $seen{'icon'});               # 599
ok(exists $seen{'jerky'});              # 600
%seen = ();

@complement = get_complement('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3] );
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 601
ok(exists $seen{'baker'});              # 602
ok(exists $seen{'camera'});             # 603
ok(exists $seen{'delta'});              # 604
ok(exists $seen{'edward'});             # 605
ok(! exists $seen{'fargo'});            # 606
ok(! exists $seen{'golfer'});           # 607
ok(! exists $seen{'hilton'});           # 608
ok(! exists $seen{'icon'});             # 609
ok(exists $seen{'jerky'});              # 610
%seen = ();

$complement_ref = get_complement_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3] );
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 611
ok(exists $seen{'baker'});              # 612
ok(exists $seen{'camera'});             # 613
ok(exists $seen{'delta'});              # 614
ok(exists $seen{'edward'});             # 615
ok(! exists $seen{'fargo'});            # 616
ok(! exists $seen{'golfer'});           # 617
ok(! exists $seen{'hilton'});           # 618
ok(! exists $seen{'icon'});             # 619
ok(exists $seen{'jerky'});              # 620
%seen = ();

@symmetric_difference = get_symmetric_difference('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 621
ok(! exists $seen{'baker'});            # 622
ok(! exists $seen{'camera'});           # 623
ok(! exists $seen{'delta'});            # 624
ok(! exists $seen{'edward'});           # 625
ok(! exists $seen{'fargo'});            # 626
ok(! exists $seen{'golfer'});           # 627
ok(! exists $seen{'hilton'});           # 628
ok(! exists $seen{'icon'});             # 629
ok(exists $seen{'jerky'});              # 630
%seen = ();

$symmetric_difference_ref = get_symmetric_difference_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 631
ok(! exists $seen{'baker'});            # 632
ok(! exists $seen{'camera'});           # 633
ok(! exists $seen{'delta'});            # 634
ok(! exists $seen{'edward'});           # 635
ok(! exists $seen{'fargo'});            # 636
ok(! exists $seen{'golfer'});           # 637
ok(! exists $seen{'hilton'});           # 638
ok(! exists $seen{'icon'});             # 639
ok(exists $seen{'jerky'});              # 640
%seen = ();

@symmetric_difference = get_symdiff('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 641
ok(! exists $seen{'baker'});            # 642
ok(! exists $seen{'camera'});           # 643
ok(! exists $seen{'delta'});            # 644
ok(! exists $seen{'edward'});           # 645
ok(! exists $seen{'fargo'});            # 646
ok(! exists $seen{'golfer'});           # 647
ok(! exists $seen{'hilton'});           # 648
ok(! exists $seen{'icon'});             # 649
ok(exists $seen{'jerky'});              # 650
%seen = ();

$symmetric_difference_ref = get_symdiff_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 651
ok(! exists $seen{'baker'});            # 652
ok(! exists $seen{'camera'});           # 653
ok(! exists $seen{'delta'});            # 654
ok(! exists $seen{'edward'});           # 655
ok(! exists $seen{'fargo'});            # 656
ok(! exists $seen{'golfer'});           # 657
ok(! exists $seen{'hilton'});           # 658
ok(! exists $seen{'icon'});             # 659
ok(exists $seen{'jerky'});              # 660
%seen = ();

@nonintersection = get_nonintersection('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 661
ok(exists $seen{'baker'});              # 662
ok(exists $seen{'camera'});             # 663
ok(exists $seen{'delta'});              # 664
ok(exists $seen{'edward'});             # 665
ok(! exists $seen{'fargo'});            # 666
ok(! exists $seen{'golfer'});           # 667
ok(exists $seen{'hilton'});             # 668
ok(exists $seen{'icon'});               # 669
ok(exists $seen{'jerky'});              # 670
%seen = ();

$nonintersection_ref = get_nonintersection_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 671
ok(exists $seen{'baker'});              # 672
ok(exists $seen{'camera'});             # 673
ok(exists $seen{'delta'});              # 674
ok(exists $seen{'edward'});             # 675
ok(! exists $seen{'fargo'});            # 676
ok(! exists $seen{'golfer'});           # 677
ok(exists $seen{'hilton'});             # 678
ok(exists $seen{'icon'});               # 679
ok(exists $seen{'jerky'});              # 680
%seen = ();

@bag = get_bag('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 681
ok($seen{'baker'} == 2);                # 682
ok($seen{'camera'} == 2);               # 683
ok($seen{'delta'} == 3);                # 684
ok($seen{'edward'} == 2);               # 685
ok($seen{'fargo'} == 6);                # 686
ok($seen{'golfer'} == 5);               # 687
ok($seen{'hilton'} == 4);               # 688
ok($seen{'icon'} == 5);                 # 689
ok($seen{'jerky'} == 1);                # 690
%seen = ();

$bag_ref = get_bag_ref('-u',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 691
ok($seen{'baker'} == 2);                # 692
ok($seen{'camera'} == 2);               # 693
ok($seen{'delta'} == 3);                # 694
ok($seen{'edward'} == 2);               # 695
ok($seen{'fargo'} == 6);                # 696
ok($seen{'golfer'} == 5);               # 697
ok($seen{'hilton'} == 4);               # 698
ok($seen{'icon'} == 5);                 # 699
ok($seen{'jerky'} == 1);                # 700
%seen = ();

##### BELOW:  Tests for '--unsorted' option ##########

@union = get_union('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});               # 701
ok(exists $seen{'baker'});              # 702
ok(exists $seen{'camera'});             # 703
ok(exists $seen{'delta'});              # 704
ok(exists $seen{'edward'});             # 705
ok(exists $seen{'fargo'});              # 706
ok(exists $seen{'golfer'});             # 707
ok(exists $seen{'hilton'});             # 708
ok(exists $seen{'icon'});               # 709
ok(exists $seen{'jerky'});              # 710
%seen = ();

$union_ref = get_union_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});               # 711
ok(exists $seen{'baker'});              # 712
ok(exists $seen{'camera'});             # 713
ok(exists $seen{'delta'});              # 714
ok(exists $seen{'edward'});             # 715
ok(exists $seen{'fargo'});              # 716
ok(exists $seen{'golfer'});             # 717
ok(exists $seen{'hilton'});             # 718
ok(exists $seen{'icon'});               # 719
ok(exists $seen{'jerky'});              # 720
%seen = ();

@shared = get_shared('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@shared);
ok(! exists $seen{'abel'});             # 721
ok(exists $seen{'baker'});              # 722
ok(exists $seen{'camera'});             # 723
ok(exists $seen{'delta'});              # 724
ok(exists $seen{'edward'});             # 725
ok(exists $seen{'fargo'});              # 726
ok(exists $seen{'golfer'});             # 727
ok(exists $seen{'hilton'});             # 728
ok(exists $seen{'icon'});               # 729
ok(! exists $seen{'jerky'});            # 730
%seen = ();

$shared_ref = get_shared_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$shared_ref});
ok(! exists $seen{'abel'});             # 731
ok(exists $seen{'baker'});              # 732
ok(exists $seen{'camera'});             # 733
ok(exists $seen{'delta'});              # 734
ok(exists $seen{'edward'});             # 735
ok(exists $seen{'fargo'});              # 736
ok(exists $seen{'golfer'});             # 737
ok(exists $seen{'hilton'});             # 738
ok(exists $seen{'icon'});               # 739
ok(! exists $seen{'jerky'});            # 740
%seen = ();

@intersection = get_intersection('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 741
ok(! exists $seen{'baker'});            # 742
ok(! exists $seen{'camera'});           # 743
ok(! exists $seen{'delta'});            # 744
ok(! exists $seen{'edward'});           # 745
ok(exists $seen{'fargo'});              # 746
ok(exists $seen{'golfer'});             # 747
ok(! exists $seen{'hilton'});           # 748
ok(! exists $seen{'icon'});             # 749
ok(! exists $seen{'jerky'});            # 750
%seen = ();

$intersection_ref = get_intersection_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});             # 751
ok(! exists $seen{'baker'});            # 752
ok(! exists $seen{'camera'});           # 753
ok(! exists $seen{'delta'});            # 754
ok(! exists $seen{'edward'});           # 755
ok(exists $seen{'fargo'});              # 756
ok(exists $seen{'golfer'});             # 757
ok(! exists $seen{'hilton'});           # 758
ok(! exists $seen{'icon'});             # 759
ok(! exists $seen{'jerky'});            # 760
%seen = ();

@unique = get_unique('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 761
ok(! exists $seen{'baker'});            # 762
ok(! exists $seen{'camera'});           # 763
ok(! exists $seen{'delta'});            # 764
ok(! exists $seen{'edward'});           # 765
ok(! exists $seen{'fargo'});            # 766
ok(! exists $seen{'golfer'});           # 767
ok(! exists $seen{'hilton'});           # 768
ok(! exists $seen{'icon'});             # 769
ok(! exists $seen{'jerky'});            # 770
%seen = ();

$unique_ref = get_unique_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 771
ok(! exists $seen{'baker'});            # 772
ok(! exists $seen{'camera'});           # 773
ok(! exists $seen{'delta'});            # 774
ok(! exists $seen{'edward'});           # 775
ok(! exists $seen{'fargo'});            # 776
ok(! exists $seen{'golfer'});           # 777
ok(! exists $seen{'hilton'});           # 778
ok(! exists $seen{'icon'});             # 779
ok(! exists $seen{'jerky'});            # 780
%seen = ();

@unique = get_unique('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2] );
$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});             # 781
ok(! exists $seen{'baker'});            # 782
ok(! exists $seen{'camera'});           # 783
ok(! exists $seen{'delta'});            # 784
ok(! exists $seen{'edward'});           # 785
ok(! exists $seen{'fargo'});            # 786
ok(! exists $seen{'golfer'});           # 787
ok(! exists $seen{'hilton'});           # 788
ok(! exists $seen{'icon'});             # 789
ok(exists $seen{'jerky'});              # 790
%seen = ();

$unique_ref = get_unique_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [2] );
$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});             # 791
ok(! exists $seen{'baker'});            # 792
ok(! exists $seen{'camera'});           # 793
ok(! exists $seen{'delta'});            # 794
ok(! exists $seen{'edward'});           # 795
ok(! exists $seen{'fargo'});            # 796
ok(! exists $seen{'golfer'});           # 797
ok(! exists $seen{'hilton'});           # 798
ok(! exists $seen{'icon'});             # 799
ok(exists $seen{'jerky'});              # 800

@complement = get_complement('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 801
ok(! exists $seen{'baker'});            # 802
ok(! exists $seen{'camera'});           # 803
ok(! exists $seen{'delta'});            # 804
ok(! exists $seen{'edward'});           # 805
ok(! exists $seen{'fargo'});            # 806
ok(! exists $seen{'golfer'});           # 807
ok(exists $seen{'hilton'});             # 808
ok(exists $seen{'icon'});               # 809
ok(exists $seen{'jerky'});              # 810
%seen = ();

$complement_ref = get_complement_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 811
ok(! exists $seen{'baker'});            # 812
ok(! exists $seen{'camera'});           # 813
ok(! exists $seen{'delta'});            # 814
ok(! exists $seen{'edward'});           # 815
ok(! exists $seen{'fargo'});            # 816
ok(! exists $seen{'golfer'});           # 817
ok(exists $seen{'hilton'});             # 818
ok(exists $seen{'icon'});               # 819
ok(exists $seen{'jerky'});              # 820
%seen = ();

@complement = get_complement('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3] );
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 821
ok(exists $seen{'baker'});              # 822
ok(exists $seen{'camera'});             # 823
ok(exists $seen{'delta'});              # 824
ok(exists $seen{'edward'});             # 825
ok(! exists $seen{'fargo'});            # 826
ok(! exists $seen{'golfer'});           # 827
ok(! exists $seen{'hilton'});           # 828
ok(! exists $seen{'icon'});             # 829
ok(exists $seen{'jerky'});              # 830
%seen = ();

$complement_ref = get_complement_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ], [3] );
$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 831
ok(exists $seen{'baker'});              # 832
ok(exists $seen{'camera'});             # 833
ok(exists $seen{'delta'});              # 834
ok(exists $seen{'edward'});             # 835
ok(! exists $seen{'fargo'});            # 836
ok(! exists $seen{'golfer'});           # 837
ok(! exists $seen{'hilton'});           # 838
ok(! exists $seen{'icon'});             # 839
ok(exists $seen{'jerky'});              # 840
%seen = ();

@symmetric_difference = get_symmetric_difference('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 841
ok(! exists $seen{'baker'});            # 842
ok(! exists $seen{'camera'});           # 843
ok(! exists $seen{'delta'});            # 844
ok(! exists $seen{'edward'});           # 845
ok(! exists $seen{'fargo'});            # 846
ok(! exists $seen{'golfer'});           # 847
ok(! exists $seen{'hilton'});           # 848
ok(! exists $seen{'icon'});             # 849
ok(exists $seen{'jerky'});              # 850
%seen = ();

$symmetric_difference_ref = get_symmetric_difference_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 851
ok(! exists $seen{'baker'});            # 852
ok(! exists $seen{'camera'});           # 853
ok(! exists $seen{'delta'});            # 854
ok(! exists $seen{'edward'});           # 855
ok(! exists $seen{'fargo'});            # 856
ok(! exists $seen{'golfer'});           # 857
ok(! exists $seen{'hilton'});           # 858
ok(! exists $seen{'icon'});             # 859
ok(exists $seen{'jerky'});              # 860
%seen = ();

@symmetric_difference = get_symdiff('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 861
ok(! exists $seen{'baker'});            # 862
ok(! exists $seen{'camera'});           # 863
ok(! exists $seen{'delta'});            # 864
ok(! exists $seen{'edward'});           # 865
ok(! exists $seen{'fargo'});            # 866
ok(! exists $seen{'golfer'});           # 867
ok(! exists $seen{'hilton'});           # 868
ok(! exists $seen{'icon'});             # 869
ok(exists $seen{'jerky'});              # 870
%seen = ();

$symmetric_difference_ref = get_symdiff_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 871
ok(! exists $seen{'baker'});            # 872
ok(! exists $seen{'camera'});           # 873
ok(! exists $seen{'delta'});            # 874
ok(! exists $seen{'edward'});           # 875
ok(! exists $seen{'fargo'});            # 876
ok(! exists $seen{'golfer'});           # 877
ok(! exists $seen{'hilton'});           # 878
ok(! exists $seen{'icon'});             # 879
ok(exists $seen{'jerky'});              # 880
%seen = ();

@nonintersection = get_nonintersection('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 881
ok(exists $seen{'baker'});              # 882
ok(exists $seen{'camera'});             # 883
ok(exists $seen{'delta'});              # 884
ok(exists $seen{'edward'});             # 885
ok(! exists $seen{'fargo'});            # 886
ok(! exists $seen{'golfer'});           # 887
ok(exists $seen{'hilton'});             # 888
ok(exists $seen{'icon'});               # 889
ok(exists $seen{'jerky'});              # 890
%seen = ();

$nonintersection_ref = get_nonintersection_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 891
ok(exists $seen{'baker'});              # 892
ok(exists $seen{'camera'});             # 893
ok(exists $seen{'delta'});              # 894
ok(exists $seen{'edward'});             # 895
ok(! exists $seen{'fargo'});            # 896
ok(! exists $seen{'golfer'});           # 897
ok(exists $seen{'hilton'});             # 898
ok(exists $seen{'icon'});               # 899
ok(exists $seen{'jerky'});              # 900
%seen = ();

@bag = get_bag('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 901
ok($seen{'baker'} == 2);                # 902
ok($seen{'camera'} == 2);               # 903
ok($seen{'delta'} == 3);                # 904
ok($seen{'edward'} == 2);               # 905
ok($seen{'fargo'} == 6);                # 906
ok($seen{'golfer'} == 5);               # 907
ok($seen{'hilton'} == 4);               # 908
ok($seen{'icon'} == 5);                 # 909
ok($seen{'jerky'} == 1);                # 910
%seen = ();

$bag_ref = get_bag_ref('--unsorted',  [ \@a0, \@a1, \@a2, \@a3, \@a4 ] );
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 911
ok($seen{'baker'} == 2);                # 912
ok($seen{'camera'} == 2);               # 913
ok($seen{'delta'} == 3);                # 914
ok($seen{'edward'} == 2);               # 915
ok($seen{'fargo'} == 6);                # 916
ok($seen{'golfer'} == 5);               # 917
ok($seen{'hilton'} == 4);               # 918
ok($seen{'icon'} == 5);                 # 919
ok($seen{'jerky'} == 1);                # 920
%seen = ();

########## Tests of passing refs to named arrays to functions ##########

my @allarrays = (\@a0, \@a1, \@a2, \@a3, \@a4); 
@intersection = get_intersection('--unsorted', \@allarrays );
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 921
ok(! exists $seen{'baker'});            # 922
ok(! exists $seen{'camera'});           # 923
ok(! exists $seen{'delta'});            # 924
ok(! exists $seen{'edward'});           # 925
ok(exists $seen{'fargo'});              # 926
ok(exists $seen{'golfer'});             # 927
ok(! exists $seen{'hilton'});           # 928
ok(! exists $seen{'icon'});             # 929
ok(! exists $seen{'jerky'});            # 930
%seen = ();

@unique = get_unique('--unsorted', \@allarrays, [2] );
$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});             # 931
ok(! exists $seen{'baker'});            # 932
ok(! exists $seen{'camera'});           # 933
ok(! exists $seen{'delta'});            # 934
ok(! exists $seen{'edward'});           # 935
ok(! exists $seen{'fargo'});            # 936
ok(! exists $seen{'golfer'});           # 937
ok(! exists $seen{'hilton'});           # 938
ok(! exists $seen{'icon'});             # 939
ok(exists $seen{'jerky'});              # 940
%seen = ();


