# 01_simple.t  # as of 8/4/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
884;
use lib ("./t");
use List::Compare;
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

my $lc    = List::Compare->new(\@a0, \@a1);

ok($lc);                                # 2

@union = $lc->get_union;
ok($union[0] eq 'abel');                # 3
ok($union[1] eq 'baker');               # 4
ok($union[2] eq 'camera');              # 5
ok($union[3] eq 'delta');               # 6
ok($union[4] eq 'edward');              # 7
ok($union[5] eq 'fargo');               # 8
ok($union[6] eq 'golfer');              # 9
ok($union[-1] eq 'hilton');             # 10

$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});               # 11
ok(exists $seen{'baker'});              # 12
ok(exists $seen{'camera'});             # 13
ok(exists $seen{'delta'});              # 14
ok(exists $seen{'edward'});             # 15
ok(exists $seen{'fargo'});              # 16
ok(exists $seen{'golfer'});             # 17
ok(exists $seen{'hilton'});             # 18
ok(! exists $seen{'icon'});             # 19
ok(! exists $seen{'jerky'});            # 20
%seen = ();

$union_ref = $lc->get_union_ref;
ok(${$union_ref}[0] eq 'abel');         # 21
ok(${$union_ref}[1] eq 'baker');        # 22
ok(${$union_ref}[2] eq 'camera');       # 23
ok(${$union_ref}[3] eq 'delta');        # 24
ok(${$union_ref}[4] eq 'edward');       # 25
ok(${$union_ref}[5] eq 'fargo');        # 26
ok(${$union_ref}[6] eq 'golfer');       # 27
ok(${$union_ref}[-1] eq 'hilton');      # 28

$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});               # 29
ok(exists $seen{'baker'});              # 30
ok(exists $seen{'camera'});             # 31
ok(exists $seen{'delta'});              # 32
ok(exists $seen{'edward'});             # 33
ok(exists $seen{'fargo'});              # 34
ok(exists $seen{'golfer'});             # 35
ok(exists $seen{'hilton'});             # 36
ok(! exists $seen{'icon'});             # 37
ok(! exists $seen{'jerky'});            # 38
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @shared = $lc->get_shared;
}
ok($shared[0] eq 'abel');               # 39
ok($shared[1] eq 'baker');              # 40
ok($shared[2] eq 'camera');             # 41
ok($shared[3] eq 'delta');              # 42
ok($shared[4] eq 'edward');             # 43
ok($shared[5] eq 'fargo');              # 44
ok($shared[6] eq 'golfer');             # 45
ok($shared[-1] eq 'hilton');            # 46

$seen{$_}++ foreach (@shared);
ok(exists $seen{'abel'});               # 47
ok(exists $seen{'baker'});              # 48
ok(exists $seen{'camera'});             # 49
ok(exists $seen{'delta'});              # 50
ok(exists $seen{'edward'});             # 51
ok(exists $seen{'fargo'});              # 52
ok(exists $seen{'golfer'});             # 53
ok(exists $seen{'hilton'});             # 54
ok(! exists $seen{'icon'});             # 55
ok(! exists $seen{'jerky'});            # 56
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $shared_ref = $lc->get_shared_ref;
}
ok(${$shared_ref}[0] eq 'abel');        # 57
ok(${$shared_ref}[1] eq 'baker');       # 58
ok(${$shared_ref}[2] eq 'camera');      # 59
ok(${$shared_ref}[3] eq 'delta');       # 60
ok(${$shared_ref}[4] eq 'edward');      # 61
ok(${$shared_ref}[5] eq 'fargo');       # 62
ok(${$shared_ref}[6] eq 'golfer');      # 63
ok(${$shared_ref}[-1] eq 'hilton');     # 64

$seen{$_}++ foreach (@{$shared_ref});
ok(exists $seen{'abel'});               # 65
ok(exists $seen{'baker'});              # 66
ok(exists $seen{'camera'});             # 67
ok(exists $seen{'delta'});              # 68
ok(exists $seen{'edward'});             # 69
ok(exists $seen{'fargo'});              # 70
ok(exists $seen{'golfer'});             # 71
ok(exists $seen{'hilton'});             # 72
ok(! exists $seen{'icon'});             # 73
ok(! exists $seen{'jerky'});            # 74
%seen = ();

@intersection = $lc->get_intersection;
ok($intersection[0] eq 'baker');        # 75
ok($intersection[1] eq 'camera');       # 76
ok($intersection[2] eq 'delta');        # 77
ok($intersection[3] eq 'edward');       # 78
ok($intersection[4] eq 'fargo');        # 79
ok($intersection[-1] eq 'golfer');      # 80

$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 81
ok(exists $seen{'baker'});              # 82
ok(exists $seen{'camera'});             # 83
ok(exists $seen{'delta'});              # 84
ok(exists $seen{'edward'});             # 85
ok(exists $seen{'fargo'});              # 86
ok(exists $seen{'golfer'});             # 87
ok(! exists $seen{'hilton'});           # 88
ok(! exists $seen{'icon'});             # 89
ok(! exists $seen{'jerky'});            # 90
%seen = ();

$intersection_ref = $lc->get_intersection_ref;
ok(${$intersection_ref}[0] eq 'baker'); # 91
ok(${$intersection_ref}[1] eq 'camera');# 92
ok(${$intersection_ref}[2] eq 'delta'); # 93
ok(${$intersection_ref}[3] eq 'edward');# 94
ok(${$intersection_ref}[4] eq 'fargo'); # 95
ok(${$intersection_ref}[-1] eq 'golfer');# 96

$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});             # 97
ok(exists $seen{'baker'});              # 98
ok(exists $seen{'camera'});             # 99
ok(exists $seen{'delta'});              # 100
ok(exists $seen{'edward'});             # 101
ok(exists $seen{'fargo'});              # 102
ok(exists $seen{'golfer'});             # 103
ok(! exists $seen{'hilton'});           # 104
ok(! exists $seen{'icon'});             # 105
ok(! exists $seen{'jerky'});            # 106
%seen = ();

@unique = $lc->get_unique;
ok($unique[-1] eq 'abel');              # 107

$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 108
ok(! exists $seen{'baker'});            # 109
ok(! exists $seen{'camera'});           # 110
ok(! exists $seen{'delta'});            # 111
ok(! exists $seen{'edward'});           # 112
ok(! exists $seen{'fargo'});            # 113
ok(! exists $seen{'golfer'});           # 114
ok(! exists $seen{'hilton'});           # 115
ok(! exists $seen{'icon'});             # 116
ok(! exists $seen{'jerky'});            # 117
%seen = ();

$unique_ref = $lc->get_unique_ref;
ok(${$unique_ref}[-1] eq 'abel');       # 118

$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 119
ok(! exists $seen{'baker'});            # 120
ok(! exists $seen{'camera'});           # 121
ok(! exists $seen{'delta'});            # 122
ok(! exists $seen{'edward'});           # 123
ok(! exists $seen{'fargo'});            # 124
ok(! exists $seen{'golfer'});           # 125
ok(! exists $seen{'hilton'});           # 126
ok(! exists $seen{'icon'});             # 127
ok(! exists $seen{'jerky'});            # 128
%seen = ();

@unique = $lc->get_Lonly;
ok($unique[-1] eq 'abel');              # 129

$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 130
ok(! exists $seen{'baker'});            # 131
ok(! exists $seen{'camera'});           # 132
ok(! exists $seen{'delta'});            # 133
ok(! exists $seen{'edward'});           # 134
ok(! exists $seen{'fargo'});            # 135
ok(! exists $seen{'golfer'});           # 136
ok(! exists $seen{'hilton'});           # 137
ok(! exists $seen{'icon'});             # 138
ok(! exists $seen{'jerky'});            # 139
%seen = ();

$unique_ref = $lc->get_Lonly_ref;
ok(${$unique_ref}[-1] eq 'abel');       # 140

$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 141
ok(! exists $seen{'baker'});            # 142
ok(! exists $seen{'camera'});           # 143
ok(! exists $seen{'delta'});            # 144
ok(! exists $seen{'edward'});           # 145
ok(! exists $seen{'fargo'});            # 146
ok(! exists $seen{'golfer'});           # 147
ok(! exists $seen{'hilton'});           # 148
ok(! exists $seen{'icon'});             # 149
ok(! exists $seen{'jerky'});            # 150
%seen = ();

@unique = $lc->get_Aonly;
ok($unique[-1] eq 'abel');              # 151

$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 152
ok(! exists $seen{'baker'});            # 153
ok(! exists $seen{'camera'});           # 154
ok(! exists $seen{'delta'});            # 155
ok(! exists $seen{'edward'});           # 156
ok(! exists $seen{'fargo'});            # 157
ok(! exists $seen{'golfer'});           # 158
ok(! exists $seen{'hilton'});           # 159
ok(! exists $seen{'icon'});             # 160
ok(! exists $seen{'jerky'});            # 161
%seen = ();

$unique_ref = $lc->get_Aonly_ref;
ok(${$unique_ref}[-1] eq 'abel');       # 162

$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 163
ok(! exists $seen{'baker'});            # 164
ok(! exists $seen{'camera'});           # 165
ok(! exists $seen{'delta'});            # 166
ok(! exists $seen{'edward'});           # 167
ok(! exists $seen{'fargo'});            # 168
ok(! exists $seen{'golfer'});           # 169
ok(! exists $seen{'hilton'});           # 170
ok(! exists $seen{'icon'});             # 171
ok(! exists $seen{'jerky'});            # 172
%seen = ();

@complement = $lc->get_complement;
ok($complement[-1] eq 'hilton');        # 173

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 174
ok(! exists $seen{'baker'});            # 175
ok(! exists $seen{'camera'});           # 176
ok(! exists $seen{'delta'});            # 177
ok(! exists $seen{'edward'});           # 178
ok(! exists $seen{'fargo'});            # 179
ok(! exists $seen{'golfer'});           # 180
ok(exists $seen{'hilton'});             # 181
ok(! exists $seen{'icon'});             # 182
ok(! exists $seen{'jerky'});            # 183
%seen = ();

$complement_ref = $lc->get_complement_ref;
ok(${$complement_ref}[-1] eq 'hilton'); # 184

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 185
ok(! exists $seen{'baker'});            # 186
ok(! exists $seen{'camera'});           # 187
ok(! exists $seen{'delta'});            # 188
ok(! exists $seen{'edward'});           # 189
ok(! exists $seen{'fargo'});            # 190
ok(! exists $seen{'golfer'});           # 191
ok(exists $seen{'hilton'});             # 192
ok(! exists $seen{'icon'});             # 193
ok(! exists $seen{'jerky'});            # 194
%seen = ();

@complement = $lc->get_Ronly;
ok($complement[-1] eq 'hilton');        # 195

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 196
ok(! exists $seen{'baker'});            # 197
ok(! exists $seen{'camera'});           # 198
ok(! exists $seen{'delta'});            # 199
ok(! exists $seen{'edward'});           # 200
ok(! exists $seen{'fargo'});            # 201
ok(! exists $seen{'golfer'});           # 202
ok(exists $seen{'hilton'});             # 203
ok(! exists $seen{'icon'});             # 204
ok(! exists $seen{'jerky'});            # 205
%seen = ();

$complement_ref = $lc->get_Ronly_ref;
ok(${$complement_ref}[-1] eq 'hilton'); # 206

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 207
ok(! exists $seen{'baker'});            # 208
ok(! exists $seen{'camera'});           # 209
ok(! exists $seen{'delta'});            # 210
ok(! exists $seen{'edward'});           # 211
ok(! exists $seen{'fargo'});            # 212
ok(! exists $seen{'golfer'});           # 213
ok(exists $seen{'hilton'});             # 214
ok(! exists $seen{'icon'});             # 215
ok(! exists $seen{'jerky'});            # 216
%seen = ();

@complement = $lc->get_Bonly;
ok($complement[-1] eq 'hilton');        # 217

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 218
ok(! exists $seen{'baker'});            # 219
ok(! exists $seen{'camera'});           # 220
ok(! exists $seen{'delta'});            # 221
ok(! exists $seen{'edward'});           # 222
ok(! exists $seen{'fargo'});            # 223
ok(! exists $seen{'golfer'});           # 224
ok(exists $seen{'hilton'});             # 225
ok(! exists $seen{'icon'});             # 226
ok(! exists $seen{'jerky'});            # 227
%seen = ();

$complement_ref = $lc->get_Bonly_ref;
ok(${$complement_ref}[-1] eq 'hilton'); # 228

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 229
ok(! exists $seen{'baker'});            # 230
ok(! exists $seen{'camera'});           # 231
ok(! exists $seen{'delta'});            # 232
ok(! exists $seen{'edward'});           # 233
ok(! exists $seen{'fargo'});            # 234
ok(! exists $seen{'golfer'});           # 235
ok(exists $seen{'hilton'});             # 236
ok(! exists $seen{'icon'});             # 237
ok(! exists $seen{'jerky'});            # 238
%seen = ();

@symmetric_difference = $lc->get_symmetric_difference;
ok($symmetric_difference[0] eq 'abel'); # 239
ok($symmetric_difference[-1] eq 'hilton');# 240

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 241
ok(! exists $seen{'baker'});            # 242
ok(! exists $seen{'camera'});           # 243
ok(! exists $seen{'delta'});            # 244
ok(! exists $seen{'edward'});           # 245
ok(! exists $seen{'fargo'});            # 246
ok(! exists $seen{'golfer'});           # 247
ok(exists $seen{'hilton'});             # 248
ok(! exists $seen{'icon'});             # 249
ok(! exists $seen{'jerky'});            # 250
%seen = ();

$symmetric_difference_ref = $lc->get_symmetric_difference_ref;
ok(${$symmetric_difference_ref}[0] eq 'abel');# 251
ok(${$symmetric_difference_ref}[-1] eq 'hilton');# 252

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 253
ok(! exists $seen{'baker'});            # 254
ok(! exists $seen{'camera'});           # 255
ok(! exists $seen{'delta'});            # 256
ok(! exists $seen{'edward'});           # 257
ok(! exists $seen{'fargo'});            # 258
ok(! exists $seen{'golfer'});           # 259
ok(exists $seen{'hilton'});             # 260
ok(! exists $seen{'icon'});             # 261
ok(! exists $seen{'jerky'});            # 262
%seen = ();

@symmetric_difference = $lc->get_symdiff;
ok($symmetric_difference[0] eq 'abel'); # 263
ok($symmetric_difference[-1] eq 'hilton');# 264

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 265
ok(! exists $seen{'baker'});            # 266
ok(! exists $seen{'camera'});           # 267
ok(! exists $seen{'delta'});            # 268
ok(! exists $seen{'edward'});           # 269
ok(! exists $seen{'fargo'});            # 270
ok(! exists $seen{'golfer'});           # 271
ok(exists $seen{'hilton'});             # 272
ok(! exists $seen{'icon'});             # 273
ok(! exists $seen{'jerky'});            # 274
%seen = ();

$symmetric_difference_ref = $lc->get_symdiff_ref;
ok(${$symmetric_difference_ref}[0] eq 'abel');# 275
ok(${$symmetric_difference_ref}[-1] eq 'hilton');# 276

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 277
ok(! exists $seen{'baker'});            # 278
ok(! exists $seen{'camera'});           # 279
ok(! exists $seen{'delta'});            # 280
ok(! exists $seen{'edward'});           # 281
ok(! exists $seen{'fargo'});            # 282
ok(! exists $seen{'golfer'});           # 283
ok(exists $seen{'hilton'});             # 284
ok(! exists $seen{'icon'});             # 285
ok(! exists $seen{'jerky'});            # 286
%seen = ();

@symmetric_difference = $lc->get_LorRonly;
ok($symmetric_difference[0] eq 'abel'); # 287
ok($symmetric_difference[-1] eq 'hilton');# 288

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 289
ok(! exists $seen{'baker'});            # 290
ok(! exists $seen{'camera'});           # 291
ok(! exists $seen{'delta'});            # 292
ok(! exists $seen{'edward'});           # 293
ok(! exists $seen{'fargo'});            # 294
ok(! exists $seen{'golfer'});           # 295
ok(exists $seen{'hilton'});             # 296
ok(! exists $seen{'icon'});             # 297
ok(! exists $seen{'jerky'});            # 298
%seen = ();

$symmetric_difference_ref = $lc->get_LorRonly_ref;
ok(${$symmetric_difference_ref}[0] eq 'abel');# 299
ok(${$symmetric_difference_ref}[-1] eq 'hilton');# 300

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 301
ok(! exists $seen{'baker'});            # 302
ok(! exists $seen{'camera'});           # 303
ok(! exists $seen{'delta'});            # 304
ok(! exists $seen{'edward'});           # 305
ok(! exists $seen{'fargo'});            # 306
ok(! exists $seen{'golfer'});           # 307
ok(exists $seen{'hilton'});             # 308
ok(! exists $seen{'icon'});             # 309
ok(! exists $seen{'jerky'});            # 310
%seen = ();

@symmetric_difference = $lc->get_AorBonly;
ok($symmetric_difference[0] eq 'abel'); # 311
ok($symmetric_difference[-1] eq 'hilton');# 312

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 313
ok(! exists $seen{'baker'});            # 314
ok(! exists $seen{'camera'});           # 315
ok(! exists $seen{'delta'});            # 316
ok(! exists $seen{'edward'});           # 317
ok(! exists $seen{'fargo'});            # 318
ok(! exists $seen{'golfer'});           # 319
ok(exists $seen{'hilton'});             # 320
ok(! exists $seen{'icon'});             # 321
ok(! exists $seen{'jerky'});            # 322
%seen = ();

$symmetric_difference_ref = $lc->get_AorBonly_ref;
ok(${$symmetric_difference_ref}[0] eq 'abel');# 323
ok(${$symmetric_difference_ref}[-1] eq 'hilton');# 324

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 325
ok(! exists $seen{'baker'});            # 326
ok(! exists $seen{'camera'});           # 327
ok(! exists $seen{'delta'});            # 328
ok(! exists $seen{'edward'});           # 329
ok(! exists $seen{'fargo'});            # 330
ok(! exists $seen{'golfer'});           # 331
ok(exists $seen{'hilton'});             # 332
ok(! exists $seen{'icon'});             # 333
ok(! exists $seen{'jerky'});            # 334
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @nonintersection = $lc->get_nonintersection;
}
ok($nonintersection[0] eq 'abel');      # 335
ok($nonintersection[-1] eq 'hilton');   # 336

$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 337
ok(! exists $seen{'baker'});            # 338
ok(! exists $seen{'camera'});           # 339
ok(! exists $seen{'delta'});            # 340
ok(! exists $seen{'edward'});           # 341
ok(! exists $seen{'fargo'});            # 342
ok(! exists $seen{'golfer'});           # 343
ok(exists $seen{'hilton'});             # 344
ok(! exists $seen{'icon'});             # 345
ok(! exists $seen{'jerky'});            # 346
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $nonintersection_ref = $lc->get_nonintersection_ref;
}
ok(${$nonintersection_ref}[0] eq 'abel');# 347
ok(${$nonintersection_ref}[-1] eq 'hilton');# 348

$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 349
ok(! exists $seen{'baker'});            # 350
ok(! exists $seen{'camera'});           # 351
ok(! exists $seen{'delta'});            # 352
ok(! exists $seen{'edward'});           # 353
ok(! exists $seen{'fargo'});            # 354
ok(! exists $seen{'golfer'});           # 355
ok(exists $seen{'hilton'});             # 356
ok(! exists $seen{'icon'});             # 357
ok(! exists $seen{'jerky'});            # 358
%seen = ();

@bag = $lc->get_bag;
ok($bag[0] eq 'abel');                  # 359
ok($bag[1] eq 'abel');                  # 360
ok($bag[2] eq 'baker');                 # 361
ok($bag[3] eq 'baker');                 # 362
ok($bag[4] eq 'camera');                # 363
ok($bag[5] eq 'camera');                # 364
ok($bag[6] eq 'delta');                 # 365
ok($bag[7] eq 'delta');                 # 366
ok($bag[8] eq 'delta');                 # 367
ok($bag[9] eq 'edward');                # 368
ok($bag[10] eq 'edward');               # 369
ok($bag[11] eq 'fargo');                # 370
ok($bag[12] eq 'fargo');                # 371
ok($bag[13] eq 'golfer');               # 372
ok($bag[14] eq 'golfer');               # 373
ok($bag[-1] eq 'hilton');               # 374

$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 375
ok($seen{'baker'} == 2);                # 376
ok($seen{'camera'} == 2);               # 377
ok($seen{'delta'} == 3);                # 378
ok($seen{'edward'} == 2);               # 379
ok($seen{'fargo'} == 2);                # 380
ok($seen{'golfer'} == 2);               # 381
ok($seen{'hilton'} == 1);               # 382
ok(! exists $seen{'icon'});             # 383
ok(! exists $seen{'jerky'});            # 384
%seen = ();

$bag_ref = $lc->get_bag_ref;
ok(${$bag_ref}[0] eq 'abel');           # 385
ok(${$bag_ref}[1] eq 'abel');           # 386
ok(${$bag_ref}[2] eq 'baker');          # 387
ok(${$bag_ref}[3] eq 'baker');          # 388
ok(${$bag_ref}[4] eq 'camera');         # 389
ok(${$bag_ref}[5] eq 'camera');         # 390
ok(${$bag_ref}[6] eq 'delta');          # 391
ok(${$bag_ref}[7] eq 'delta');          # 392
ok(${$bag_ref}[8] eq 'delta');          # 393
ok(${$bag_ref}[9] eq 'edward');         # 394
ok(${$bag_ref}[10] eq 'edward');        # 395
ok(${$bag_ref}[11] eq 'fargo');         # 396
ok(${$bag_ref}[12] eq 'fargo');         # 397
ok(${$bag_ref}[13] eq 'golfer');        # 398
ok(${$bag_ref}[14] eq 'golfer');        # 399
ok(${$bag_ref}[-1] eq 'hilton');        # 400

$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 401
ok($seen{'baker'} == 2);                # 402
ok($seen{'camera'} == 2);               # 403
ok($seen{'delta'} == 3);                # 404
ok($seen{'edward'} == 2);               # 405
ok($seen{'fargo'} == 2);                # 406
ok($seen{'golfer'} == 2);               # 407
ok($seen{'hilton'} == 1);               # 408
ok(! exists $seen{'icon'});             # 409
ok(! exists $seen{'jerky'});            # 410
%seen = ();

$LR = $lc->is_LsubsetR;
ok(! $LR);                              # 411

$LR = $lc->is_AsubsetB;
ok(! $LR);                              # 412

$RL = $lc->is_RsubsetL;
ok(! $RL);                              # 413

$RL = $lc->is_BsubsetA;
ok(! $RL);                              # 414

$eqv = $lc->is_LequivalentR;
ok(! $eqv);                             # 415

$eqv = $lc->is_LeqvlntR;
ok(! $eqv);                             # 416

$disj = $lc->is_LdisjointR;
ok(! $disj);                            # 417

$return = $lc->print_subset_chart;
ok($return);                            # 418

$return = $lc->print_equivalence_chart;
ok($return);                            # 419

@memb_arr = $lc->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0   > ] ));# 420

@memb_arr = $lc->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1 > ] ));# 421

@memb_arr = $lc->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1 > ] ));# 422

@memb_arr = $lc->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1 > ] ));# 423

@memb_arr = $lc->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1 > ] ));# 424

@memb_arr = $lc->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  2, [ qw< 0 1 > ] ));# 425

@memb_arr = $lc->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 2, [ qw< 0 1 > ] ));# 426

@memb_arr = $lc->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 1, [ qw<   1 > ] ));# 427

@memb_arr = $lc->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   0, [ qw<     > ] ));# 428

@memb_arr = $lc->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  0, [ qw<     > ] ));# 429

@memb_arr = $lc->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<     > ] ));# 430


$memb_arr_ref = $lc->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0   > ] ));# 431

$memb_arr_ref = $lc->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1 > ] ));# 432

$memb_arr_ref = $lc->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1 > ] ));# 433

$memb_arr_ref = $lc->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1 > ] ));# 434

$memb_arr_ref = $lc->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1 > ] ));# 435

$memb_arr_ref = $lc->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  2, [ qw< 0 1 > ] ));# 436

$memb_arr_ref = $lc->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 2, [ qw< 0 1 > ] ));# 437

$memb_arr_ref = $lc->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 1, [ qw<   1 > ] ));# 438

$memb_arr_ref = $lc->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   0, [ qw<     > ] ));# 439

$memb_arr_ref = $lc->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  0, [ qw<     > ] ));# 440

$memb_arr_ref = $lc->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<     > ] ));# 441

eval { $memb_arr_ref = $lc->is_member_which_ref('jerky', 'zebra') };
ok(ok_capture_error($@));               # 442


$memb_hash_ref = $lc->are_members_which( [ qw| abel baker camera delta edward fargo 
    golfer hilton icon jerky zebra | ] );
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0   > ] ));# 443
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1 > ] ));# 444
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1 > ] ));# 445
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1 > ] ));# 446
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1 > ] ));# 447
ok(ok_seen_h( $memb_hash_ref, 'fargo',  2, [ qw< 0 1 > ] ));# 448
ok(ok_seen_h( $memb_hash_ref, 'golfer', 2, [ qw< 0 1 > ] ));# 449
ok(ok_seen_h( $memb_hash_ref, 'hilton', 1, [ qw<   1 > ] ));# 450
ok(ok_seen_h( $memb_hash_ref, 'icon',   0, [ qw<     > ] ));# 451
ok(ok_seen_h( $memb_hash_ref, 'jerky',  0, [ qw<     > ] ));# 452
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<     > ] ));# 453

eval { $memb_hash_ref = $lc->are_members_which( { key => 'value' } ) };
ok(ok_capture_error($@));               # 454


ok($lc->is_member_any('abel'));         # 455
ok($lc->is_member_any('baker'));        # 456
ok($lc->is_member_any('camera'));       # 457
ok($lc->is_member_any('delta'));        # 458
ok($lc->is_member_any('edward'));       # 459
ok($lc->is_member_any('fargo'));        # 460
ok($lc->is_member_any('golfer'));       # 461
ok($lc->is_member_any('hilton'));       # 462
ok(! $lc->is_member_any('icon' ));      # 463
ok(! $lc->is_member_any('jerky'));      # 464
ok(! $lc->is_member_any('zebra'));      # 465

eval { $lc->is_member_any('jerky', 'zebra') };
ok(ok_capture_error($@));               # 466


$memb_hash_ref = $lc->are_members_any( [ qw| abel baker camera delta edward fargo 
    golfer hilton icon jerky zebra | ] );
ok(ok_any_h( $memb_hash_ref, 'abel',   1 ));# 467
ok(ok_any_h( $memb_hash_ref, 'baker',  1 ));# 468
ok(ok_any_h( $memb_hash_ref, 'camera', 1 ));# 469
ok(ok_any_h( $memb_hash_ref, 'delta',  1 ));# 470
ok(ok_any_h( $memb_hash_ref, 'edward', 1 ));# 471
ok(ok_any_h( $memb_hash_ref, 'fargo',  1 ));# 472
ok(ok_any_h( $memb_hash_ref, 'golfer', 1 ));# 473
ok(ok_any_h( $memb_hash_ref, 'hilton', 1 ));# 474
ok(ok_any_h( $memb_hash_ref, 'icon',   0 ));# 475
ok(ok_any_h( $memb_hash_ref, 'jerky',  0 ));# 476
ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));# 477

eval { $memb_hash_ref = $lc->are_members_any( { key => 'value' } ) };
ok(ok_capture_error($@));               # 478

$vers = $lc->get_version;
ok($vers);                              # 479

my $lc_s  = List::Compare->new(\@a2, \@a3);

ok($lc_s);                              # 480

$LR = $lc_s->is_LsubsetR;
ok(! $LR);                              # 481

$LR = $lc_s->is_AsubsetB;
ok(! $LR);                              # 482

$RL = $lc_s->is_RsubsetL;
ok($RL);                                # 483

$RL = $lc_s->is_BsubsetA;
ok($RL);                                # 484

$eqv = $lc_s->is_LequivalentR;
ok(! $eqv);                             # 485

$eqv = $lc_s->is_LeqvlntR;
ok(! $eqv);                             # 486

$disj = $lc_s->is_LdisjointR;
ok(! $disj);                            # 487

my $lc_e  = List::Compare->new(\@a3, \@a4);

ok($lc_e);                              # 488

$eqv = $lc_e->is_LequivalentR;
ok($eqv);                               # 489

$eqv = $lc_e->is_LeqvlntR;
ok($eqv);                               # 490

$disj = $lc_e->is_LdisjointR;
ok(! $disj);                            # 491

my $lc_dj  = List::Compare->new(\@a4, \@a8);

ok($lc_dj);                             # 492

ok(0 == $lc_dj->get_intersection);      # 493
ok(0 == scalar(@{$lc_dj->get_intersection_ref}));# 494
$disj = $lc_dj->is_LdisjointR;
ok($disj);                              # 495

########## BELOW:  Tests for '-u' option ##########

my $lcu    = List::Compare->new('-u', \@a0, \@a1);

ok($lcu);                               # 496

@union = $lcu->get_union;
$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});               # 497
ok(exists $seen{'baker'});              # 498
ok(exists $seen{'camera'});             # 499
ok(exists $seen{'delta'});              # 500
ok(exists $seen{'edward'});             # 501
ok(exists $seen{'fargo'});              # 502
ok(exists $seen{'golfer'});             # 503
ok(exists $seen{'hilton'});             # 504
ok(! exists $seen{'icon'});             # 505
ok(! exists $seen{'jerky'});            # 506
%seen = ();

$union_ref = $lcu->get_union_ref;
$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});               # 507
ok(exists $seen{'baker'});              # 508
ok(exists $seen{'camera'});             # 509
ok(exists $seen{'delta'});              # 510
ok(exists $seen{'edward'});             # 511
ok(exists $seen{'fargo'});              # 512
ok(exists $seen{'golfer'});             # 513
ok(exists $seen{'hilton'});             # 514
ok(! exists $seen{'icon'});             # 515
ok(! exists $seen{'jerky'});            # 516
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @shared = $lcu->get_shared;
}
$seen{$_}++ foreach (@shared);
ok(exists $seen{'abel'});               # 517
ok(exists $seen{'baker'});              # 518
ok(exists $seen{'camera'});             # 519
ok(exists $seen{'delta'});              # 520
ok(exists $seen{'edward'});             # 521
ok(exists $seen{'fargo'});              # 522
ok(exists $seen{'golfer'});             # 523
ok(exists $seen{'hilton'});             # 524
ok(! exists $seen{'icon'});             # 525
ok(! exists $seen{'jerky'});            # 526
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $shared_ref = $lcu->get_shared_ref;
}
$seen{$_}++ foreach (@{$shared_ref});
ok(exists $seen{'abel'});               # 527
ok(exists $seen{'baker'});              # 528
ok(exists $seen{'camera'});             # 529
ok(exists $seen{'delta'});              # 530
ok(exists $seen{'edward'});             # 531
ok(exists $seen{'fargo'});              # 532
ok(exists $seen{'golfer'});             # 533
ok(exists $seen{'hilton'});             # 534
ok(! exists $seen{'icon'});             # 535
ok(! exists $seen{'jerky'});            # 536
%seen = ();

@intersection = $lcu->get_intersection;
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 537
ok(exists $seen{'baker'});              # 538
ok(exists $seen{'camera'});             # 539
ok(exists $seen{'delta'});              # 540
ok(exists $seen{'edward'});             # 541
ok(exists $seen{'fargo'});              # 542
ok(exists $seen{'golfer'});             # 543
ok(! exists $seen{'hilton'});           # 544
ok(! exists $seen{'icon'});             # 545
ok(! exists $seen{'jerky'});            # 546
%seen = ();

$intersection_ref = $lcu->get_intersection_ref;
$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});             # 547
ok(exists $seen{'baker'});              # 548
ok(exists $seen{'camera'});             # 549
ok(exists $seen{'delta'});              # 550
ok(exists $seen{'edward'});             # 551
ok(exists $seen{'fargo'});              # 552
ok(exists $seen{'golfer'});             # 553
ok(! exists $seen{'hilton'});           # 554
ok(! exists $seen{'icon'});             # 555
ok(! exists $seen{'jerky'});            # 556
%seen = ();

@unique = $lcu->get_unique;
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 557
ok(! exists $seen{'baker'});            # 558
ok(! exists $seen{'camera'});           # 559
ok(! exists $seen{'delta'});            # 560
ok(! exists $seen{'edward'});           # 561
ok(! exists $seen{'fargo'});            # 562
ok(! exists $seen{'golfer'});           # 563
ok(! exists $seen{'hilton'});           # 564
ok(! exists $seen{'icon'});             # 565
ok(! exists $seen{'jerky'});            # 566
%seen = ();

$unique_ref = $lcu->get_unique_ref;
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 567
ok(! exists $seen{'baker'});            # 568
ok(! exists $seen{'camera'});           # 569
ok(! exists $seen{'delta'});            # 570
ok(! exists $seen{'edward'});           # 571
ok(! exists $seen{'fargo'});            # 572
ok(! exists $seen{'golfer'});           # 573
ok(! exists $seen{'hilton'});           # 574
ok(! exists $seen{'icon'});             # 575
ok(! exists $seen{'jerky'});            # 576
%seen = ();

@unique = $lcu->get_Lonly;
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 577
ok(! exists $seen{'baker'});            # 578
ok(! exists $seen{'camera'});           # 579
ok(! exists $seen{'delta'});            # 580
ok(! exists $seen{'edward'});           # 581
ok(! exists $seen{'fargo'});            # 582
ok(! exists $seen{'golfer'});           # 583
ok(! exists $seen{'hilton'});           # 584
ok(! exists $seen{'icon'});             # 585
ok(! exists $seen{'jerky'});            # 586
%seen = ();

$unique_ref = $lcu->get_Lonly_ref;
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 587
ok(! exists $seen{'baker'});            # 588
ok(! exists $seen{'camera'});           # 589
ok(! exists $seen{'delta'});            # 590
ok(! exists $seen{'edward'});           # 591
ok(! exists $seen{'fargo'});            # 592
ok(! exists $seen{'golfer'});           # 593
ok(! exists $seen{'hilton'});           # 594
ok(! exists $seen{'icon'});             # 595
ok(! exists $seen{'jerky'});            # 596
%seen = ();

@unique = $lcu->get_Aonly;
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 597
ok(! exists $seen{'baker'});            # 598
ok(! exists $seen{'camera'});           # 599
ok(! exists $seen{'delta'});            # 600
ok(! exists $seen{'edward'});           # 601
ok(! exists $seen{'fargo'});            # 602
ok(! exists $seen{'golfer'});           # 603
ok(! exists $seen{'hilton'});           # 604
ok(! exists $seen{'icon'});             # 605
ok(! exists $seen{'jerky'});            # 606
%seen = ();

$unique_ref = $lcu->get_Aonly_ref;
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 607
ok(! exists $seen{'baker'});            # 608
ok(! exists $seen{'camera'});           # 609
ok(! exists $seen{'delta'});            # 610
ok(! exists $seen{'edward'});           # 611
ok(! exists $seen{'fargo'});            # 612
ok(! exists $seen{'golfer'});           # 613
ok(! exists $seen{'hilton'});           # 614
ok(! exists $seen{'icon'});             # 615
ok(! exists $seen{'jerky'});            # 616
%seen = ();

@complement = $lcu->get_complement;
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 617
ok(! exists $seen{'baker'});            # 618
ok(! exists $seen{'camera'});           # 619
ok(! exists $seen{'delta'});            # 620
ok(! exists $seen{'edward'});           # 621
ok(! exists $seen{'fargo'});            # 622
ok(! exists $seen{'golfer'});           # 623
ok(exists $seen{'hilton'});             # 624
ok(! exists $seen{'icon'});             # 625
ok(! exists $seen{'jerky'});            # 626
%seen = ();

$complement_ref = $lcu->get_complement_ref;
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 627
ok(! exists $seen{'baker'});            # 628
ok(! exists $seen{'camera'});           # 629
ok(! exists $seen{'delta'});            # 630
ok(! exists $seen{'edward'});           # 631
ok(! exists $seen{'fargo'});            # 632
ok(! exists $seen{'golfer'});           # 633
ok(exists $seen{'hilton'});             # 634
ok(! exists $seen{'icon'});             # 635
ok(! exists $seen{'jerky'});            # 636
%seen = ();

@complement = $lcu->get_Ronly;
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 637
ok(! exists $seen{'baker'});            # 638
ok(! exists $seen{'camera'});           # 639
ok(! exists $seen{'delta'});            # 640
ok(! exists $seen{'edward'});           # 641
ok(! exists $seen{'fargo'});            # 642
ok(! exists $seen{'golfer'});           # 643
ok(exists $seen{'hilton'});             # 644
ok(! exists $seen{'icon'});             # 645
ok(! exists $seen{'jerky'});            # 646
%seen = ();

$complement_ref = $lcu->get_Ronly_ref;
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 647
ok(! exists $seen{'baker'});            # 648
ok(! exists $seen{'camera'});           # 649
ok(! exists $seen{'delta'});            # 650
ok(! exists $seen{'edward'});           # 651
ok(! exists $seen{'fargo'});            # 652
ok(! exists $seen{'golfer'});           # 653
ok(exists $seen{'hilton'});             # 654
ok(! exists $seen{'icon'});             # 655
ok(! exists $seen{'jerky'});            # 656
%seen = ();

@complement = $lcu->get_Bonly;
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 657
ok(! exists $seen{'baker'});            # 658
ok(! exists $seen{'camera'});           # 659
ok(! exists $seen{'delta'});            # 660
ok(! exists $seen{'edward'});           # 661
ok(! exists $seen{'fargo'});            # 662
ok(! exists $seen{'golfer'});           # 663
ok(exists $seen{'hilton'});             # 664
ok(! exists $seen{'icon'});             # 665
ok(! exists $seen{'jerky'});            # 666
%seen = ();

$complement_ref = $lcu->get_Bonly_ref;
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 667
ok(! exists $seen{'baker'});            # 668
ok(! exists $seen{'camera'});           # 669
ok(! exists $seen{'delta'});            # 670
ok(! exists $seen{'edward'});           # 671
ok(! exists $seen{'fargo'});            # 672
ok(! exists $seen{'golfer'});           # 673
ok(exists $seen{'hilton'});             # 674
ok(! exists $seen{'icon'});             # 675
ok(! exists $seen{'jerky'});            # 676
%seen = ();

@symmetric_difference = $lcu->get_symmetric_difference;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 677
ok(! exists $seen{'baker'});            # 678
ok(! exists $seen{'camera'});           # 679
ok(! exists $seen{'delta'});            # 680
ok(! exists $seen{'edward'});           # 681
ok(! exists $seen{'fargo'});            # 682
ok(! exists $seen{'golfer'});           # 683
ok(exists $seen{'hilton'});             # 684
ok(! exists $seen{'icon'});             # 685
ok(! exists $seen{'jerky'});            # 686
%seen = ();

$symmetric_difference_ref = $lcu->get_symmetric_difference_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 687
ok(! exists $seen{'baker'});            # 688
ok(! exists $seen{'camera'});           # 689
ok(! exists $seen{'delta'});            # 690
ok(! exists $seen{'edward'});           # 691
ok(! exists $seen{'fargo'});            # 692
ok(! exists $seen{'golfer'});           # 693
ok(exists $seen{'hilton'});             # 694
ok(! exists $seen{'icon'});             # 695
ok(! exists $seen{'jerky'});            # 696
%seen = ();

@symmetric_difference = $lcu->get_symdiff;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 697
ok(! exists $seen{'baker'});            # 698
ok(! exists $seen{'camera'});           # 699
ok(! exists $seen{'delta'});            # 700
ok(! exists $seen{'edward'});           # 701
ok(! exists $seen{'fargo'});            # 702
ok(! exists $seen{'golfer'});           # 703
ok(exists $seen{'hilton'});             # 704
ok(! exists $seen{'icon'});             # 705
ok(! exists $seen{'jerky'});            # 706
%seen = ();

$symmetric_difference_ref = $lcu->get_symdiff_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 707
ok(! exists $seen{'baker'});            # 708
ok(! exists $seen{'camera'});           # 709
ok(! exists $seen{'delta'});            # 710
ok(! exists $seen{'edward'});           # 711
ok(! exists $seen{'fargo'});            # 712
ok(! exists $seen{'golfer'});           # 713
ok(exists $seen{'hilton'});             # 714
ok(! exists $seen{'icon'});             # 715
ok(! exists $seen{'jerky'});            # 716
%seen = ();

@symmetric_difference = $lcu->get_LorRonly;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 717
ok(! exists $seen{'baker'});            # 718
ok(! exists $seen{'camera'});           # 719
ok(! exists $seen{'delta'});            # 720
ok(! exists $seen{'edward'});           # 721
ok(! exists $seen{'fargo'});            # 722
ok(! exists $seen{'golfer'});           # 723
ok(exists $seen{'hilton'});             # 724
ok(! exists $seen{'icon'});             # 725
ok(! exists $seen{'jerky'});            # 726
%seen = ();

$symmetric_difference_ref = $lcu->get_LorRonly_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 727
ok(! exists $seen{'baker'});            # 728
ok(! exists $seen{'camera'});           # 729
ok(! exists $seen{'delta'});            # 730
ok(! exists $seen{'edward'});           # 731
ok(! exists $seen{'fargo'});            # 732
ok(! exists $seen{'golfer'});           # 733
ok(exists $seen{'hilton'});             # 734
ok(! exists $seen{'icon'});             # 735
ok(! exists $seen{'jerky'});            # 736
%seen = ();

@symmetric_difference = $lcu->get_AorBonly;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 737
ok(! exists $seen{'baker'});            # 738
ok(! exists $seen{'camera'});           # 739
ok(! exists $seen{'delta'});            # 740
ok(! exists $seen{'edward'});           # 741
ok(! exists $seen{'fargo'});            # 742
ok(! exists $seen{'golfer'});           # 743
ok(exists $seen{'hilton'});             # 744
ok(! exists $seen{'icon'});             # 745
ok(! exists $seen{'jerky'});            # 746
%seen = ();

$symmetric_difference_ref = $lcu->get_AorBonly_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 747
ok(! exists $seen{'baker'});            # 748
ok(! exists $seen{'camera'});           # 749
ok(! exists $seen{'delta'});            # 750
ok(! exists $seen{'edward'});           # 751
ok(! exists $seen{'fargo'});            # 752
ok(! exists $seen{'golfer'});           # 753
ok(exists $seen{'hilton'});             # 754
ok(! exists $seen{'icon'});             # 755
ok(! exists $seen{'jerky'});            # 756
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @nonintersection = $lcu->get_nonintersection;
}
$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 757
ok(! exists $seen{'baker'});            # 758
ok(! exists $seen{'camera'});           # 759
ok(! exists $seen{'delta'});            # 760
ok(! exists $seen{'edward'});           # 761
ok(! exists $seen{'fargo'});            # 762
ok(! exists $seen{'golfer'});           # 763
ok(exists $seen{'hilton'});             # 764
ok(! exists $seen{'icon'});             # 765
ok(! exists $seen{'jerky'});            # 766
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $nonintersection_ref = $lcu->get_nonintersection_ref;
}
$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 767
ok(! exists $seen{'baker'});            # 768
ok(! exists $seen{'camera'});           # 769
ok(! exists $seen{'delta'});            # 770
ok(! exists $seen{'edward'});           # 771
ok(! exists $seen{'fargo'});            # 772
ok(! exists $seen{'golfer'});           # 773
ok(exists $seen{'hilton'});             # 774
ok(! exists $seen{'icon'});             # 775
ok(! exists $seen{'jerky'});            # 776
%seen = ();

@bag = $lcu->get_bag;
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 777
ok($seen{'baker'} == 2);                # 778
ok($seen{'camera'} == 2);               # 779
ok($seen{'delta'} == 3);                # 780
ok($seen{'edward'} == 2);               # 781
ok($seen{'fargo'} == 2);                # 782
ok($seen{'golfer'} == 2);               # 783
ok($seen{'hilton'} == 1);               # 784
ok(! exists $seen{'icon'});             # 785
ok(! exists $seen{'jerky'});            # 786
%seen = ();

$bag_ref = $lcu->get_bag_ref;
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 787
ok($seen{'baker'} == 2);                # 788
ok($seen{'camera'} == 2);               # 789
ok($seen{'delta'} == 3);                # 790
ok($seen{'edward'} == 2);               # 791
ok($seen{'fargo'} == 2);                # 792
ok($seen{'golfer'} == 2);               # 793
ok($seen{'hilton'} == 1);               # 794
ok(! exists $seen{'icon'});             # 795
ok(! exists $seen{'jerky'});            # 796
%seen = ();

$LR = $lcu->is_LsubsetR;
ok(! $LR);                              # 797

$LR = $lcu->is_AsubsetB;
ok(! $LR);                              # 798

$RL = $lcu->is_RsubsetL;
ok(! $RL);                              # 799

$RL = $lcu->is_BsubsetA;
ok(! $RL);                              # 800

$eqv = $lcu->is_LequivalentR;
ok(! $eqv);                             # 801

$eqv = $lcu->is_LeqvlntR;
ok(! $eqv);                             # 802

$disj = $lcu->is_LdisjointR;
ok(! $disj);                            # 803

$return = $lcu->print_subset_chart;
ok($return);                            # 804

$return = $lcu->print_equivalence_chart;
ok($return);                            # 805

@memb_arr = $lcu->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0   > ] ));# 806

@memb_arr = $lcu->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1 > ] ));# 807

@memb_arr = $lcu->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1 > ] ));# 808

@memb_arr = $lcu->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1 > ] ));# 809

@memb_arr = $lcu->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1 > ] ));# 810

@memb_arr = $lcu->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  2, [ qw< 0 1 > ] ));# 811

@memb_arr = $lcu->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 2, [ qw< 0 1 > ] ));# 812

@memb_arr = $lcu->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 1, [ qw<   1 > ] ));# 813

@memb_arr = $lcu->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   0, [ qw<     > ] ));# 814

@memb_arr = $lcu->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  0, [ qw<     > ] ));# 815

@memb_arr = $lcu->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<     > ] ));# 816

$memb_arr_ref = $lcu->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0   > ] ));# 817

$memb_arr_ref = $lcu->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1 > ] ));# 818

$memb_arr_ref = $lcu->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1 > ] ));# 819

$memb_arr_ref = $lcu->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1 > ] ));# 820

$memb_arr_ref = $lcu->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1 > ] ));# 821

$memb_arr_ref = $lcu->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  2, [ qw< 0 1 > ] ));# 822

$memb_arr_ref = $lcu->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 2, [ qw< 0 1 > ] ));# 823

$memb_arr_ref = $lcu->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 1, [ qw<   1 > ] ));# 824

$memb_arr_ref = $lcu->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   0, [ qw<     > ] ));# 825

$memb_arr_ref = $lcu->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  0, [ qw<     > ] ));# 826

$memb_arr_ref = $lcu->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<     > ] ));# 827

$memb_hash_ref = $lcu->are_members_which(
    [ qw| abel baker camera delta edward fargo 
          golfer hilton icon jerky zebra | ] );
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0   > ] ));# 828
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1 > ] ));# 829
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1 > ] ));# 830
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1 > ] ));# 831
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1 > ] ));# 832
ok(ok_seen_h( $memb_hash_ref, 'fargo',  2, [ qw< 0 1 > ] ));# 833
ok(ok_seen_h( $memb_hash_ref, 'golfer', 2, [ qw< 0 1 > ] ));# 834
ok(ok_seen_h( $memb_hash_ref, 'hilton', 1, [ qw<   1 > ] ));# 835
ok(ok_seen_h( $memb_hash_ref, 'icon',   0, [ qw<     > ] ));# 836
ok(ok_seen_h( $memb_hash_ref, 'jerky',  0, [ qw<     > ] ));# 837
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<     > ] ));# 838

ok($lcu->is_member_any('abel'));        # 839
ok($lcu->is_member_any('baker'));       # 840
ok($lcu->is_member_any('camera'));      # 841
ok($lcu->is_member_any('delta'));       # 842
ok($lcu->is_member_any('edward'));      # 843
ok($lcu->is_member_any('fargo'));       # 844
ok($lcu->is_member_any('golfer'));      # 845
ok($lcu->is_member_any('hilton'));      # 846
ok(! $lcu->is_member_any('icon' ));     # 847
ok(! $lcu->is_member_any('jerky'));     # 848
ok(! $lcu->is_member_any('zebra'));     # 849

$memb_hash_ref = $lcu->are_members_any(
    [ qw| abel baker camera delta edward fargo 
          golfer hilton icon jerky zebra | ] );

ok(ok_any_h( $memb_hash_ref, 'abel',   1 ));# 850
ok(ok_any_h( $memb_hash_ref, 'baker',  1 ));# 851
ok(ok_any_h( $memb_hash_ref, 'camera', 1 ));# 852
ok(ok_any_h( $memb_hash_ref, 'delta',  1 ));# 853
ok(ok_any_h( $memb_hash_ref, 'edward', 1 ));# 854
ok(ok_any_h( $memb_hash_ref, 'fargo',  1 ));# 855
ok(ok_any_h( $memb_hash_ref, 'golfer', 1 ));# 856
ok(ok_any_h( $memb_hash_ref, 'hilton', 1 ));# 857
ok(ok_any_h( $memb_hash_ref, 'icon',   0 ));# 858
ok(ok_any_h( $memb_hash_ref, 'jerky',  0 ));# 859
ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));# 860

$vers = $lcu->get_version;
ok($vers);                              # 861

my $lcu_s  = List::Compare->new('-u', \@a2, \@a3);

ok($lcu_s);                             # 862

$LR = $lcu_s->is_LsubsetR;
ok(! $LR);                              # 863

$LR = $lcu_s->is_AsubsetB;
ok(! $LR);                              # 864

$RL = $lcu_s->is_RsubsetL;
ok($RL);                                # 865

$RL = $lcu_s->is_BsubsetA;
ok($RL);                                # 866

$eqv = $lcu_s->is_LequivalentR;
ok(! $eqv);                             # 867

$eqv = $lcu_s->is_LeqvlntR;
ok(! $eqv);                             # 868

$disj = $lcu_s->is_LdisjointR;
ok(! $disj);                            # 869

my $lcu_e  = List::Compare->new('-u', \@a3, \@a4);

ok($lcu_e);                             # 870

$eqv = $lcu_e->is_LequivalentR;
ok($eqv);                               # 871

$eqv = $lcu_e->is_LeqvlntR;
ok($eqv);                               # 872

$disj = $lcu_e->is_LdisjointR;
ok(! $disj);                            # 873

my $lcu_dj  = List::Compare->new('-u', \@a4, \@a8);

ok($lcu_dj);                            # 874

ok(0 == $lcu_dj->get_intersection);     # 875
ok(0 == scalar(@{$lcu_dj->get_intersection_ref}));# 876
$disj = $lcu_dj->is_LdisjointR;
ok($disj);                              # 877

########## BELOW:  Tests for '--unsorted' option ##########

my $lcun    = List::Compare->new('--unsorted', \@a0, \@a1);
ok($lcun);                              # 878

my $lcun_s  = List::Compare->new('--unsorted', \@a2, \@a3);
ok($lcun_s);                            # 879

my $lcun_e  = List::Compare->new('--unsorted', \@a3, \@a4);
ok($lcun_e);                            # 880

########## BELOW:  Test for bad arguments to constructor ##########

my ($lc_bad);
my %h5 = (
    golfer   => 1,
    lambda   => 0,
);

eval { $lc_bad = List::Compare->new(\@a0, \%h5) };
ok(ok_capture_error($@));               # 881

eval { $lc_bad = List::Compare->new(\%h5, \@a0) };
ok(ok_capture_error($@));               # 882

my $scalar = 'test';
eval { $lc_bad = List::Compare->new(\$scalar, \@a0) };
ok(ok_capture_error($@));               # 883

eval { $lc_bad = List::Compare->new(\@a0) };
ok(ok_capture_error($@));               # 884






