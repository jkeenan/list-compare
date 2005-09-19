# 02_accelerated.t # as of 8/4/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
892;
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

my $lca   = List::Compare->new('-a', \@a0, \@a1);
ok($lca);                               # 2

@union = $lca->get_union;
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

$union_ref = $lca->get_union_ref;
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
    @shared = $lca->get_shared;
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
    $shared_ref = $lca->get_shared_ref;
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

@intersection = $lca->get_intersection;
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

$intersection_ref = $lca->get_intersection_ref;
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

@unique = $lca->get_unique;
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

$unique_ref = $lca->get_unique_ref;
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

@unique = $lca->get_Lonly;
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

$unique_ref = $lca->get_Lonly_ref;
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

@unique = $lca->get_Aonly;
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

$unique_ref = $lca->get_Aonly_ref;
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

@complement = $lca->get_complement;
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

$complement_ref = $lca->get_complement_ref;
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

@complement = $lca->get_Ronly;
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

$complement_ref = $lca->get_Ronly_ref;
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

@complement = $lca->get_Bonly;
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

$complement_ref = $lca->get_Bonly_ref;
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

@symmetric_difference = $lca->get_symmetric_difference;
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

$symmetric_difference_ref = $lca->get_symmetric_difference_ref;
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

@symmetric_difference = $lca->get_symdiff;
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

$symmetric_difference_ref = $lca->get_symdiff_ref;
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

@symmetric_difference = $lca->get_LorRonly;
ok(${$symmetric_difference_ref}[0] eq 'abel');# 287
ok(${$symmetric_difference_ref}[-1] eq 'hilton');# 288

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

$symmetric_difference_ref = $lca->get_LorRonly_ref;
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

@symmetric_difference = $lca->get_AorBonly;
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

$symmetric_difference_ref = $lca->get_AorBonly_ref;
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
    @nonintersection = $lca->get_nonintersection;
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
    $nonintersection_ref = $lca->get_nonintersection_ref;
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

@bag = $lca->get_bag;
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

$bag_ref = $lca->get_bag_ref;
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

$LR = $lca->is_LsubsetR;
ok(! $LR);                              # 411

$LR = $lca->is_AsubsetB;
ok(! $LR);                              # 412

$RL = $lca->is_RsubsetL;
ok(! $RL);                              # 413

$RL = $lca->is_BsubsetA;
ok(! $RL);                              # 414

$eqv = $lca->is_LequivalentR;
ok(! $eqv);                             # 415

$eqv = $lca->is_LeqvlntR;
ok(! $eqv);                             # 416

$disj = $lca->is_LdisjointR;
ok(! $disj);                            # 417

$return = $lca->print_subset_chart;
ok($return);                            # 418

$return = $lca->print_equivalence_chart;
ok($return);                            # 419

@memb_arr = $lca->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0   > ] ));# 420

@memb_arr = $lca->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1 > ] ));# 421

@memb_arr = $lca->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1 > ] ));# 422

@memb_arr = $lca->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1 > ] ));# 423

@memb_arr = $lca->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1 > ] ));# 424

@memb_arr = $lca->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  2, [ qw< 0 1 > ] ));# 425

@memb_arr = $lca->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 2, [ qw< 0 1 > ] ));# 426

@memb_arr = $lca->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 1, [ qw<   1 > ] ));# 427

@memb_arr = $lca->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   0, [ qw<     > ] ));# 428

@memb_arr = $lca->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  0, [ qw<     > ] ));# 429

@memb_arr = $lca->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<     > ] ));# 430

$memb_arr_ref = $lca->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0   > ] ));# 431

$memb_arr_ref = $lca->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1 > ] ));# 432

$memb_arr_ref = $lca->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1 > ] ));# 433

$memb_arr_ref = $lca->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1 > ] ));# 434

$memb_arr_ref = $lca->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1 > ] ));# 435

$memb_arr_ref = $lca->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  2, [ qw< 0 1 > ] ));# 436

$memb_arr_ref = $lca->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 2, [ qw< 0 1 > ] ));# 437

$memb_arr_ref = $lca->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 1, [ qw<   1 > ] ));# 438

$memb_arr_ref = $lca->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   0, [ qw<     > ] ));# 439

$memb_arr_ref = $lca->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  0, [ qw<     > ] ));# 440

$memb_arr_ref = $lca->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<     > ] ));# 441

eval { $memb_arr_ref = $lca->is_member_which_ref('jerky', 'zebra') };
ok(ok_capture_error($@));               # 442


$memb_hash_ref = $lca->are_members_which(
    [ qw| abel baker camera delta edward fargo 
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

eval { $memb_hash_ref = $lca->are_members_which( { key => 'value' } ) };
ok(ok_capture_error($@));               # 454


ok($lca->is_member_any('abel'));        # 455
ok($lca->is_member_any('baker'));       # 456
ok($lca->is_member_any('camera'));      # 457
ok($lca->is_member_any('delta'));       # 458
ok($lca->is_member_any('edward'));      # 459
ok($lca->is_member_any('fargo'));       # 460
ok($lca->is_member_any('golfer'));      # 461
ok($lca->is_member_any('hilton'));      # 462
ok(! $lca->is_member_any('icon' ));     # 463
ok(! $lca->is_member_any('jerky'));     # 464
ok(! $lca->is_member_any('zebra'));     # 465

eval { $lca->is_member_any('jerky', 'zebra') };
ok(ok_capture_error($@));               # 466


$memb_hash_ref = $lca->are_members_any(
    [ qw| abel baker camera delta edward fargo 
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

eval { $memb_hash_ref = $lca->are_members_any( { key => 'value' } ) };
ok(ok_capture_error($@));               # 478

$vers = $lca->get_version;
ok($vers);                              # 479

my $lca_s  = List::Compare->new('-a', \@a2, \@a3);
ok($lca_s);                             # 480

$LR = $lca_s->is_LsubsetR;
ok(! $LR);                              # 481

$LR = $lca_s->is_AsubsetB;
ok(! $LR);                              # 482

$RL = $lca_s->is_RsubsetL;
ok($RL);                                # 483

$RL = $lca_s->is_BsubsetA;
ok($RL);                                # 484

$eqv = $lca_s->is_LequivalentR;
ok(! $eqv);                             # 485

$eqv = $lca_s->is_LeqvlntR;
ok(! $eqv);                             # 486

$disj = $lca_s->is_LdisjointR;
ok(! $disj);                            # 487

my $lca_e  = List::Compare->new('-a', \@a3, \@a4);
ok($lca_e);                             # 488

$eqv = $lca_e->is_LequivalentR;
ok($eqv);                               # 489

$eqv = $lca_e->is_LeqvlntR;
ok($eqv);                               # 490

$disj = $lca_e->is_LdisjointR;
ok(! $disj);                            # 491

my $lca_dj  = List::Compare->new('-a', \@a4, \@a8);

ok($lca_dj);                            # 492

ok(0 == $lca_dj->get_intersection);     # 493
ok(0 == scalar(@{$lca_dj->get_intersection_ref}));# 494
$disj = $lca_dj->is_LdisjointR;
ok($disj);                              # 495

########## BELOW:  Tests for '--accelerated' option ##########

my $lcacc   = List::Compare->new('--accelerated', \@a0, \@a1);
ok($lcacc);                             # 496

my $lcacc_s  = List::Compare->new('--accelerated', \@a2, \@a3);
ok($lcacc_s);                           # 497

my $lcacc_e  = List::Compare->new('--accelerated', \@a3, \@a4);
ok($lcacc_e);                           # 498

########## BELOW:  Tests for '-u' option ##########

my $lcau   = List::Compare->new('-u', '-a', \@a0, \@a1);
ok($lcau);                              # 499

@union = $lcau->get_union;
$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});               # 500
ok(exists $seen{'baker'});              # 501
ok(exists $seen{'camera'});             # 502
ok(exists $seen{'delta'});              # 503
ok(exists $seen{'edward'});             # 504
ok(exists $seen{'fargo'});              # 505
ok(exists $seen{'golfer'});             # 506
ok(exists $seen{'hilton'});             # 507
ok(! exists $seen{'icon'});             # 508
ok(! exists $seen{'jerky'});            # 509
%seen = ();

$union_ref = $lcau->get_union_ref;
$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});               # 510
ok(exists $seen{'baker'});              # 511
ok(exists $seen{'camera'});             # 512
ok(exists $seen{'delta'});              # 513
ok(exists $seen{'edward'});             # 514
ok(exists $seen{'fargo'});              # 515
ok(exists $seen{'golfer'});             # 516
ok(exists $seen{'hilton'});             # 517
ok(! exists $seen{'icon'});             # 518
ok(! exists $seen{'jerky'});            # 519
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @shared = $lcau->get_shared;
}
$seen{$_}++ foreach (@shared);
ok(exists $seen{'abel'});               # 520
ok(exists $seen{'baker'});              # 521
ok(exists $seen{'camera'});             # 522
ok(exists $seen{'delta'});              # 523
ok(exists $seen{'edward'});             # 524
ok(exists $seen{'fargo'});              # 525
ok(exists $seen{'golfer'});             # 526
ok(exists $seen{'hilton'});             # 527
ok(! exists $seen{'icon'});             # 528
ok(! exists $seen{'jerky'});            # 529
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $shared_ref = $lcau->get_shared_ref;
}
$seen{$_}++ foreach (@{$shared_ref});
ok(exists $seen{'abel'});               # 530
ok(exists $seen{'baker'});              # 531
ok(exists $seen{'camera'});             # 532
ok(exists $seen{'delta'});              # 533
ok(exists $seen{'edward'});             # 534
ok(exists $seen{'fargo'});              # 535
ok(exists $seen{'golfer'});             # 536
ok(exists $seen{'hilton'});             # 537
ok(! exists $seen{'icon'});             # 538
ok(! exists $seen{'jerky'});            # 539
%seen = ();

@intersection = $lcau->get_intersection;
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 540
ok(exists $seen{'baker'});              # 541
ok(exists $seen{'camera'});             # 542
ok(exists $seen{'delta'});              # 543
ok(exists $seen{'edward'});             # 544
ok(exists $seen{'fargo'});              # 545
ok(exists $seen{'golfer'});             # 546
ok(! exists $seen{'hilton'});           # 547
ok(! exists $seen{'icon'});             # 548
ok(! exists $seen{'jerky'});            # 549
%seen = ();

$intersection_ref = $lcau->get_intersection_ref;
$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});             # 550
ok(exists $seen{'baker'});              # 551
ok(exists $seen{'camera'});             # 552
ok(exists $seen{'delta'});              # 553
ok(exists $seen{'edward'});             # 554
ok(exists $seen{'fargo'});              # 555
ok(exists $seen{'golfer'});             # 556
ok(! exists $seen{'hilton'});           # 557
ok(! exists $seen{'icon'});             # 558
ok(! exists $seen{'jerky'});            # 559
%seen = ();

@unique = $lcau->get_unique;
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 560
ok(! exists $seen{'baker'});            # 561
ok(! exists $seen{'camera'});           # 562
ok(! exists $seen{'delta'});            # 563
ok(! exists $seen{'edward'});           # 564
ok(! exists $seen{'fargo'});            # 565
ok(! exists $seen{'golfer'});           # 566
ok(! exists $seen{'hilton'});           # 567
ok(! exists $seen{'icon'});             # 568
ok(! exists $seen{'jerky'});            # 569
%seen = ();

$unique_ref = $lcau->get_unique_ref;
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 570
ok(! exists $seen{'baker'});            # 571
ok(! exists $seen{'camera'});           # 572
ok(! exists $seen{'delta'});            # 573
ok(! exists $seen{'edward'});           # 574
ok(! exists $seen{'fargo'});            # 575
ok(! exists $seen{'golfer'});           # 576
ok(! exists $seen{'hilton'});           # 577
ok(! exists $seen{'icon'});             # 578
ok(! exists $seen{'jerky'});            # 579
%seen = ();

@unique = $lcau->get_Lonly;
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 580
ok(! exists $seen{'baker'});            # 581
ok(! exists $seen{'camera'});           # 582
ok(! exists $seen{'delta'});            # 583
ok(! exists $seen{'edward'});           # 584
ok(! exists $seen{'fargo'});            # 585
ok(! exists $seen{'golfer'});           # 586
ok(! exists $seen{'hilton'});           # 587
ok(! exists $seen{'icon'});             # 588
ok(! exists $seen{'jerky'});            # 589
%seen = ();

$unique_ref = $lcau->get_Lonly_ref;
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 590
ok(! exists $seen{'baker'});            # 591
ok(! exists $seen{'camera'});           # 592
ok(! exists $seen{'delta'});            # 593
ok(! exists $seen{'edward'});           # 594
ok(! exists $seen{'fargo'});            # 595
ok(! exists $seen{'golfer'});           # 596
ok(! exists $seen{'hilton'});           # 597
ok(! exists $seen{'icon'});             # 598
ok(! exists $seen{'jerky'});            # 599
%seen = ();

@unique = $lcau->get_Aonly;
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 600
ok(! exists $seen{'baker'});            # 601
ok(! exists $seen{'camera'});           # 602
ok(! exists $seen{'delta'});            # 603
ok(! exists $seen{'edward'});           # 604
ok(! exists $seen{'fargo'});            # 605
ok(! exists $seen{'golfer'});           # 606
ok(! exists $seen{'hilton'});           # 607
ok(! exists $seen{'icon'});             # 608
ok(! exists $seen{'jerky'});            # 609
%seen = ();

$unique_ref = $lcau->get_Aonly_ref;
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 610
ok(! exists $seen{'baker'});            # 611
ok(! exists $seen{'camera'});           # 612
ok(! exists $seen{'delta'});            # 613
ok(! exists $seen{'edward'});           # 614
ok(! exists $seen{'fargo'});            # 615
ok(! exists $seen{'golfer'});           # 616
ok(! exists $seen{'hilton'});           # 617
ok(! exists $seen{'icon'});             # 618
ok(! exists $seen{'jerky'});            # 619
%seen = ();

@complement = $lcau->get_complement;
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 620
ok(! exists $seen{'baker'});            # 621
ok(! exists $seen{'camera'});           # 622
ok(! exists $seen{'delta'});            # 623
ok(! exists $seen{'edward'});           # 624
ok(! exists $seen{'fargo'});            # 625
ok(! exists $seen{'golfer'});           # 626
ok(exists $seen{'hilton'});             # 627
ok(! exists $seen{'icon'});             # 628
ok(! exists $seen{'jerky'});            # 629
%seen = ();

$complement_ref = $lcau->get_complement_ref;
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 630
ok(! exists $seen{'baker'});            # 631
ok(! exists $seen{'camera'});           # 632
ok(! exists $seen{'delta'});            # 633
ok(! exists $seen{'edward'});           # 634
ok(! exists $seen{'fargo'});            # 635
ok(! exists $seen{'golfer'});           # 636
ok(exists $seen{'hilton'});             # 637
ok(! exists $seen{'icon'});             # 638
ok(! exists $seen{'jerky'});            # 639
%seen = ();

@complement = $lcau->get_Ronly;
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 640
ok(! exists $seen{'baker'});            # 641
ok(! exists $seen{'camera'});           # 642
ok(! exists $seen{'delta'});            # 643
ok(! exists $seen{'edward'});           # 644
ok(! exists $seen{'fargo'});            # 645
ok(! exists $seen{'golfer'});           # 646
ok(exists $seen{'hilton'});             # 647
ok(! exists $seen{'icon'});             # 648
ok(! exists $seen{'jerky'});            # 649
%seen = ();

$complement_ref = $lcau->get_Ronly_ref;
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 650
ok(! exists $seen{'baker'});            # 651
ok(! exists $seen{'camera'});           # 652
ok(! exists $seen{'delta'});            # 653
ok(! exists $seen{'edward'});           # 654
ok(! exists $seen{'fargo'});            # 655
ok(! exists $seen{'golfer'});           # 656
ok(exists $seen{'hilton'});             # 657
ok(! exists $seen{'icon'});             # 658
ok(! exists $seen{'jerky'});            # 659
%seen = ();

@complement = $lcau->get_Bonly;
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 660
ok(! exists $seen{'baker'});            # 661
ok(! exists $seen{'camera'});           # 662
ok(! exists $seen{'delta'});            # 663
ok(! exists $seen{'edward'});           # 664
ok(! exists $seen{'fargo'});            # 665
ok(! exists $seen{'golfer'});           # 666
ok(exists $seen{'hilton'});             # 667
ok(! exists $seen{'icon'});             # 668
ok(! exists $seen{'jerky'});            # 669
%seen = ();

$complement_ref = $lcau->get_Bonly_ref;
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 670
ok(! exists $seen{'baker'});            # 671
ok(! exists $seen{'camera'});           # 672
ok(! exists $seen{'delta'});            # 673
ok(! exists $seen{'edward'});           # 674
ok(! exists $seen{'fargo'});            # 675
ok(! exists $seen{'golfer'});           # 676
ok(exists $seen{'hilton'});             # 677
ok(! exists $seen{'icon'});             # 678
ok(! exists $seen{'jerky'});            # 679
%seen = ();

@symmetric_difference = $lcau->get_symmetric_difference;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 680
ok(! exists $seen{'baker'});            # 681
ok(! exists $seen{'camera'});           # 682
ok(! exists $seen{'delta'});            # 683
ok(! exists $seen{'edward'});           # 684
ok(! exists $seen{'fargo'});            # 685
ok(! exists $seen{'golfer'});           # 686
ok(exists $seen{'hilton'});             # 687
ok(! exists $seen{'icon'});             # 688
ok(! exists $seen{'jerky'});            # 689
%seen = ();

$symmetric_difference_ref = $lcau->get_symmetric_difference_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 690
ok(! exists $seen{'baker'});            # 691
ok(! exists $seen{'camera'});           # 692
ok(! exists $seen{'delta'});            # 693
ok(! exists $seen{'edward'});           # 694
ok(! exists $seen{'fargo'});            # 695
ok(! exists $seen{'golfer'});           # 696
ok(exists $seen{'hilton'});             # 697
ok(! exists $seen{'icon'});             # 698
ok(! exists $seen{'jerky'});            # 699
%seen = ();

@symmetric_difference = $lcau->get_symdiff;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 700
ok(! exists $seen{'baker'});            # 701
ok(! exists $seen{'camera'});           # 702
ok(! exists $seen{'delta'});            # 703
ok(! exists $seen{'edward'});           # 704
ok(! exists $seen{'fargo'});            # 705
ok(! exists $seen{'golfer'});           # 706
ok(exists $seen{'hilton'});             # 707
ok(! exists $seen{'icon'});             # 708
ok(! exists $seen{'jerky'});            # 709
%seen = ();

$symmetric_difference_ref = $lcau->get_symdiff_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 710
ok(! exists $seen{'baker'});            # 711
ok(! exists $seen{'camera'});           # 712
ok(! exists $seen{'delta'});            # 713
ok(! exists $seen{'edward'});           # 714
ok(! exists $seen{'fargo'});            # 715
ok(! exists $seen{'golfer'});           # 716
ok(exists $seen{'hilton'});             # 717
ok(! exists $seen{'icon'});             # 718
ok(! exists $seen{'jerky'});            # 719
%seen = ();

@symmetric_difference = $lcau->get_LorRonly;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 720
ok(! exists $seen{'baker'});            # 721
ok(! exists $seen{'camera'});           # 722
ok(! exists $seen{'delta'});            # 723
ok(! exists $seen{'edward'});           # 724
ok(! exists $seen{'fargo'});            # 725
ok(! exists $seen{'golfer'});           # 726
ok(exists $seen{'hilton'});             # 727
ok(! exists $seen{'icon'});             # 728
ok(! exists $seen{'jerky'});            # 729
%seen = ();

$symmetric_difference_ref = $lcau->get_LorRonly_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 730
ok(! exists $seen{'baker'});            # 731
ok(! exists $seen{'camera'});           # 732
ok(! exists $seen{'delta'});            # 733
ok(! exists $seen{'edward'});           # 734
ok(! exists $seen{'fargo'});            # 735
ok(! exists $seen{'golfer'});           # 736
ok(exists $seen{'hilton'});             # 737
ok(! exists $seen{'icon'});             # 738
ok(! exists $seen{'jerky'});            # 739
%seen = ();

@symmetric_difference = $lcau->get_AorBonly;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 740
ok(! exists $seen{'baker'});            # 741
ok(! exists $seen{'camera'});           # 742
ok(! exists $seen{'delta'});            # 743
ok(! exists $seen{'edward'});           # 744
ok(! exists $seen{'fargo'});            # 745
ok(! exists $seen{'golfer'});           # 746
ok(exists $seen{'hilton'});             # 747
ok(! exists $seen{'icon'});             # 748
ok(! exists $seen{'jerky'});            # 749
%seen = ();

$symmetric_difference_ref = $lcau->get_AorBonly_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 750
ok(! exists $seen{'baker'});            # 751
ok(! exists $seen{'camera'});           # 752
ok(! exists $seen{'delta'});            # 753
ok(! exists $seen{'edward'});           # 754
ok(! exists $seen{'fargo'});            # 755
ok(! exists $seen{'golfer'});           # 756
ok(exists $seen{'hilton'});             # 757
ok(! exists $seen{'icon'});             # 758
ok(! exists $seen{'jerky'});            # 759
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @nonintersection = $lcau->get_nonintersection;
}
$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 760
ok(! exists $seen{'baker'});            # 761
ok(! exists $seen{'camera'});           # 762
ok(! exists $seen{'delta'});            # 763
ok(! exists $seen{'edward'});           # 764
ok(! exists $seen{'fargo'});            # 765
ok(! exists $seen{'golfer'});           # 766
ok(exists $seen{'hilton'});             # 767
ok(! exists $seen{'icon'});             # 768
ok(! exists $seen{'jerky'});            # 769
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $nonintersection_ref = $lcau->get_nonintersection_ref;
}
$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 770
ok(! exists $seen{'baker'});            # 771
ok(! exists $seen{'camera'});           # 772
ok(! exists $seen{'delta'});            # 773
ok(! exists $seen{'edward'});           # 774
ok(! exists $seen{'fargo'});            # 775
ok(! exists $seen{'golfer'});           # 776
ok(exists $seen{'hilton'});             # 777
ok(! exists $seen{'icon'});             # 778
ok(! exists $seen{'jerky'});            # 779
%seen = ();

@bag = $lcau->get_bag;
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 780
ok($seen{'baker'} == 2);                # 781
ok($seen{'camera'} == 2);               # 782
ok($seen{'delta'} == 3);                # 783
ok($seen{'edward'} == 2);               # 784
ok($seen{'fargo'} == 2);                # 785
ok($seen{'golfer'} == 2);               # 786
ok($seen{'hilton'} == 1);               # 787
ok(! exists $seen{'icon'});             # 788
ok(! exists $seen{'jerky'});            # 789
%seen = ();

$bag_ref = $lcau->get_bag_ref;
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 790
ok($seen{'baker'} == 2);                # 791
ok($seen{'camera'} == 2);               # 792
ok($seen{'delta'} == 3);                # 793
ok($seen{'edward'} == 2);               # 794
ok($seen{'fargo'} == 2);                # 795
ok($seen{'golfer'} == 2);               # 796
ok($seen{'hilton'} == 1);               # 797
ok(! exists $seen{'icon'});             # 798
ok(! exists $seen{'jerky'});            # 799
%seen = ();

$LR = $lcau->is_LsubsetR;
ok(! $LR);                              # 800

$LR = $lcau->is_AsubsetB;
ok(! $LR);                              # 801

$RL = $lcau->is_RsubsetL;
ok(! $RL);                              # 802

$RL = $lcau->is_BsubsetA;
ok(! $RL);                              # 803

$eqv = $lcau->is_LequivalentR;
ok(! $eqv);                             # 804

$eqv = $lcau->is_LeqvlntR;
ok(! $eqv);                             # 805

$disj = $lcau->is_LdisjointR;
ok(! $disj);                            # 806

$return = $lcau->print_subset_chart;
ok($return);                            # 807

$return = $lcau->print_equivalence_chart;
ok($return);                            # 808

@memb_arr = $lcau->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0   > ] ));# 809

@memb_arr = $lcau->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1 > ] ));# 810

@memb_arr = $lcau->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1 > ] ));# 811

@memb_arr = $lcau->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1 > ] ));# 812

@memb_arr = $lcau->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1 > ] ));# 813

@memb_arr = $lcau->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  2, [ qw< 0 1 > ] ));# 814

@memb_arr = $lcau->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 2, [ qw< 0 1 > ] ));# 815

@memb_arr = $lcau->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 1, [ qw<   1 > ] ));# 816

@memb_arr = $lcau->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   0, [ qw<     > ] ));# 817

@memb_arr = $lcau->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  0, [ qw<     > ] ));# 818

@memb_arr = $lcau->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<     > ] ));# 819

$memb_arr_ref = $lcau->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0   > ] ));# 820

$memb_arr_ref = $lcau->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1 > ] ));# 821

$memb_arr_ref = $lcau->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1 > ] ));# 822

$memb_arr_ref = $lcau->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1 > ] ));# 823

$memb_arr_ref = $lcau->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1 > ] ));# 824

$memb_arr_ref = $lcau->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  2, [ qw< 0 1 > ] ));# 825

$memb_arr_ref = $lcau->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 2, [ qw< 0 1 > ] ));# 826

$memb_arr_ref = $lcau->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 1, [ qw<   1 > ] ));# 827

$memb_arr_ref = $lcau->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   0, [ qw<     > ] ));# 828

$memb_arr_ref = $lcau->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  0, [ qw<     > ] ));# 829

$memb_arr_ref = $lcau->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<     > ] ));# 830

$memb_hash_ref = $lcau->are_members_which(
    [ qw| abel baker camera delta edward fargo 
          golfer hilton icon jerky zebra | ] );
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0   > ] ));# 831
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1 > ] ));# 832
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1 > ] ));# 833
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1 > ] ));# 834
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1 > ] ));# 835
ok(ok_seen_h( $memb_hash_ref, 'fargo',  2, [ qw< 0 1 > ] ));# 836
ok(ok_seen_h( $memb_hash_ref, 'golfer', 2, [ qw< 0 1 > ] ));# 837
ok(ok_seen_h( $memb_hash_ref, 'hilton', 1, [ qw<   1 > ] ));# 838
ok(ok_seen_h( $memb_hash_ref, 'icon',   0, [ qw<     > ] ));# 839
ok(ok_seen_h( $memb_hash_ref, 'jerky',  0, [ qw<     > ] ));# 840
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<     > ] ));# 841

ok($lcau->is_member_any('abel'));       # 842
ok($lcau->is_member_any('baker'));      # 843
ok($lcau->is_member_any('camera'));     # 844
ok($lcau->is_member_any('delta'));      # 845
ok($lcau->is_member_any('edward'));     # 846
ok($lcau->is_member_any('fargo'));      # 847
ok($lcau->is_member_any('golfer'));     # 848
ok($lcau->is_member_any('hilton'));     # 849
ok(! $lcau->is_member_any('icon' ));    # 850
ok(! $lcau->is_member_any('jerky'));    # 851
ok(! $lcau->is_member_any('zebra'));    # 852

$memb_hash_ref = $lcau->are_members_any(
    [ qw| abel baker camera delta edward fargo 
          golfer hilton icon jerky zebra | ] );
ok(ok_any_h( $memb_hash_ref, 'abel',   1 ));# 853
ok(ok_any_h( $memb_hash_ref, 'baker',  1 ));# 854
ok(ok_any_h( $memb_hash_ref, 'camera', 1 ));# 855
ok(ok_any_h( $memb_hash_ref, 'delta',  1 ));# 856
ok(ok_any_h( $memb_hash_ref, 'edward', 1 ));# 857
ok(ok_any_h( $memb_hash_ref, 'fargo',  1 ));# 858
ok(ok_any_h( $memb_hash_ref, 'golfer', 1 ));# 859
ok(ok_any_h( $memb_hash_ref, 'hilton', 1 ));# 860
ok(ok_any_h( $memb_hash_ref, 'icon',   0 ));# 861
ok(ok_any_h( $memb_hash_ref, 'jerky',  0 ));# 862
ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));# 863

$vers = $lcau->get_version;
ok($vers);                              # 864

my $lcau_s  = List::Compare->new('-u', '-a', \@a2, \@a3);
ok($lcau_s);                            # 865

$LR = $lcau_s->is_LsubsetR;
ok(! $LR);                              # 866

$LR = $lcau_s->is_AsubsetB;
ok(! $LR);                              # 867

$RL = $lcau_s->is_RsubsetL;
ok($RL);                                # 868

$RL = $lcau_s->is_BsubsetA;
ok($RL);                                # 869

$eqv = $lcau_s->is_LequivalentR;
ok(! $eqv);                             # 870

$eqv = $lcau_s->is_LeqvlntR;
ok(! $eqv);                             # 871

$disj = $lcau_s->is_LdisjointR;
ok(! $disj);                            # 872

my $lcau_e  = List::Compare->new('-u', '-a', \@a3, \@a4);
ok($lcau_e);                            # 873

$eqv = $lcau_e->is_LequivalentR;
ok($eqv);                               # 874

$eqv = $lcau_e->is_LeqvlntR;
ok($eqv);                               # 875

$disj = $lcau_e->is_LdisjointR;
ok(! $disj);                            # 876

my $lcau_dj  = List::Compare->new('-u', \@a4, \@a8);

ok($lcau_dj);                           # 877

ok(0 == $lcau_dj->get_intersection);    # 878
ok(0 == scalar(@{$lcau_dj->get_intersection_ref}));# 879
$disj = $lcau_dj->is_LdisjointR;
ok($disj);                              # 880

########## BELOW:  Tests for '--unsorted' and '--accelerated' options ##########

my $lcaun   = List::Compare->new('--unsorted', '-a', \@a0, \@a1);
ok($lcaun);                             # 881

my $lcaun_s  = List::Compare->new('--unsorted', '-a', \@a2, \@a3);
ok($lcaun_s);                           # 882

my $lcaun_e  = List::Compare->new('--unsorted', '-a', \@a3, \@a4);
ok($lcaun_e);                           # 883

my $lcaccun   = List::Compare->new('--unsorted', '--accelerated', \@a0, \@a1);
ok($lcaccun);                           # 884

my $lcaccun_s  = List::Compare->new('--unsorted', '--accelerated', \@a2, \@a3);
ok($lcaccun_s);                         # 885

my $lcaccun_e  = List::Compare->new('--unsorted', '--accelerated', \@a3, \@a4);
ok($lcaccun_e);                         # 886

my $lcaccu   = List::Compare->new('-u', '--accelerated', \@a0, \@a1);
ok($lcaccu);                            # 887

my $lcaccu_s  = List::Compare->new('-u', '--accelerated', \@a2, \@a3);
ok($lcaccu_s);                          # 888

my $lcaccu_e  = List::Compare->new('-u', '--accelerated', \@a3, \@a4);
ok($lcaccu_e);                          # 889

########## BELOW:  Test for bad arguments to constructor ##########

my ($lca_bad);
my %h5 = (
    golfer   => 1,
    lambda   => 0,
);

eval { $lca_bad = List::Compare->new('-a', \@a0, \%h5) };
ok(ok_capture_error($@));               # 890

eval { $lca_bad = List::Compare->new('-a', \%h5, \@a0) };
ok(ok_capture_error($@));               # 891

my $scalar = 'test';
eval { $lca_bad = List::Compare->new('-a', \$scalar, \@a0) };
ok(ok_capture_error($@));               # 892






