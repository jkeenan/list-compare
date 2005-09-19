# 03_multiple.t # as of 8/5/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;}
use Test::Simple tests =>
1175;
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

my $lcm   = List::Compare->new(\@a0, \@a1, \@a2, \@a3, \@a4);

ok($lcm);                               # 2

@union = $lcm->get_union;
ok($union[0] eq 'abel');                # 3
ok($union[1] eq 'baker');               # 4
ok($union[2] eq 'camera');              # 5
ok($union[3] eq 'delta');               # 6
ok($union[4] eq 'edward');              # 7
ok($union[5] eq 'fargo');               # 8
ok($union[6] eq 'golfer');              # 9
ok($union[7] eq 'hilton');              # 10
ok($union[8] eq 'icon');                # 11
ok($union[-1] eq 'jerky');              # 12

$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});               # 13
ok(exists $seen{'baker'});              # 14
ok(exists $seen{'camera'});             # 15
ok(exists $seen{'delta'});              # 16
ok(exists $seen{'edward'});             # 17
ok(exists $seen{'fargo'});              # 18
ok(exists $seen{'golfer'});             # 19
ok(exists $seen{'hilton'});             # 20
ok(exists $seen{'icon'});               # 21
ok(exists $seen{'jerky'});              # 22
%seen = ();

$union_ref = $lcm->get_union_ref;
ok(${$union_ref}[0] eq 'abel');         # 23
ok(${$union_ref}[1] eq 'baker');        # 24
ok(${$union_ref}[2] eq 'camera');       # 25
ok(${$union_ref}[3] eq 'delta');        # 26
ok(${$union_ref}[4] eq 'edward');       # 27
ok(${$union_ref}[5] eq 'fargo');        # 28
ok(${$union_ref}[6] eq 'golfer');       # 29
ok(${$union_ref}[7] eq 'hilton');       # 30
ok(${$union_ref}[8] eq 'icon');         # 31
ok(${$union_ref}[-1] eq 'jerky');       # 32

$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});               # 33
ok(exists $seen{'baker'});              # 34
ok(exists $seen{'camera'});             # 35
ok(exists $seen{'delta'});              # 36
ok(exists $seen{'edward'});             # 37
ok(exists $seen{'fargo'});              # 38
ok(exists $seen{'golfer'});             # 39
ok(exists $seen{'hilton'});             # 40
ok(exists $seen{'icon'});               # 41
ok(exists $seen{'jerky'});              # 42
%seen = ();

@shared = $lcm->get_shared;
ok($shared[0] eq 'baker');              # 43
ok($shared[1] eq 'camera');             # 44
ok($shared[2] eq 'delta');              # 45
ok($shared[3] eq 'edward');             # 46
ok($shared[4] eq 'fargo');              # 47
ok($shared[5] eq 'golfer');             # 48
ok($shared[6] eq 'hilton');             # 49
ok($shared[-1] eq 'icon');              # 50

$seen{$_}++ foreach (@shared);
ok(! exists $seen{'abel'});             # 51
ok(exists $seen{'baker'});              # 52
ok(exists $seen{'camera'});             # 53
ok(exists $seen{'delta'});              # 54
ok(exists $seen{'edward'});             # 55
ok(exists $seen{'fargo'});              # 56
ok(exists $seen{'golfer'});             # 57
ok(exists $seen{'hilton'});             # 58
ok(exists $seen{'icon'});               # 59
ok(! exists $seen{'jerky'});            # 60
%seen = ();

$shared_ref = $lcm->get_shared_ref;
ok(${$shared_ref}[0] eq 'baker');       # 61
ok(${$shared_ref}[1] eq 'camera');      # 62
ok(${$shared_ref}[2] eq 'delta');       # 63
ok(${$shared_ref}[3] eq 'edward');      # 64
ok(${$shared_ref}[4] eq 'fargo');       # 65
ok(${$shared_ref}[5] eq 'golfer');      # 66
ok(${$shared_ref}[6] eq 'hilton');      # 67
ok(${$shared_ref}[-1] eq 'icon');       # 68

$seen{$_}++ foreach (@{$shared_ref});
ok(! exists $seen{'abel'});             # 69
ok(exists $seen{'baker'});              # 70
ok(exists $seen{'camera'});             # 71
ok(exists $seen{'delta'});              # 72
ok(exists $seen{'edward'});             # 73
ok(exists $seen{'fargo'});              # 74
ok(exists $seen{'golfer'});             # 75
ok(exists $seen{'hilton'});             # 76
ok(exists $seen{'icon'});               # 77
ok(! exists $seen{'jerky'});            # 78
%seen = ();

@intersection = $lcm->get_intersection;
ok($intersection[0] eq 'fargo');        # 79
ok($intersection[-1] eq 'golfer');      # 80

$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 81
ok(! exists $seen{'baker'});            # 82
ok(! exists $seen{'camera'});           # 83
ok(! exists $seen{'delta'});            # 84
ok(! exists $seen{'edward'});           # 85
ok(exists $seen{'fargo'});              # 86
ok(exists $seen{'golfer'});             # 87
ok(! exists $seen{'hilton'});           # 88
ok(! exists $seen{'icon'});             # 89
ok(! exists $seen{'jerky'});            # 90
%seen = ();

$intersection_ref = $lcm->get_intersection_ref;
ok(${$intersection_ref}[0] eq 'fargo'); # 91
ok(${$intersection_ref}[-1] eq 'golfer');# 92

$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});             # 93
ok(! exists $seen{'baker'});            # 94
ok(! exists $seen{'camera'});           # 95
ok(! exists $seen{'delta'});            # 96
ok(! exists $seen{'edward'});           # 97
ok(exists $seen{'fargo'});              # 98
ok(exists $seen{'golfer'});             # 99
ok(! exists $seen{'hilton'});           # 100
ok(! exists $seen{'icon'});             # 101
ok(! exists $seen{'jerky'});            # 102
%seen = ();

@unique = $lcm->get_unique(2);
ok($unique[-1] eq 'jerky');             # 103

$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});             # 104
ok(! exists $seen{'baker'});            # 105
ok(! exists $seen{'camera'});           # 106
ok(! exists $seen{'delta'});            # 107
ok(! exists $seen{'edward'});           # 108
ok(! exists $seen{'fargo'});            # 109
ok(! exists $seen{'golfer'});           # 110
ok(! exists $seen{'hilton'});           # 111
ok(! exists $seen{'icon'});             # 112
ok(exists $seen{'jerky'});              # 113
%seen = ();

$unique_ref = $lcm->get_unique_ref(2);
ok(${$unique_ref}[-1] eq 'jerky');      # 114

$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});             # 115
ok(! exists $seen{'baker'});            # 116
ok(! exists $seen{'camera'});           # 117
ok(! exists $seen{'delta'});            # 118
ok(! exists $seen{'edward'});           # 119
ok(! exists $seen{'fargo'});            # 120
ok(! exists $seen{'golfer'});           # 121
ok(! exists $seen{'hilton'});           # 122
ok(! exists $seen{'icon'});             # 123
ok(exists $seen{'jerky'});              # 124
%seen = ();

eval { $unique_ref = $lcm->get_unique_ref('jerky') };
ok(ok_capture_error($@));               # 125

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcm->get_Lonly(2);
}
ok($unique[-1] eq 'jerky');             # 126

$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});             # 127
ok(! exists $seen{'baker'});            # 128
ok(! exists $seen{'camera'});           # 129
ok(! exists $seen{'delta'});            # 130
ok(! exists $seen{'edward'});           # 131
ok(! exists $seen{'fargo'});            # 132
ok(! exists $seen{'golfer'});           # 133
ok(! exists $seen{'hilton'});           # 134
ok(! exists $seen{'icon'});             # 135
ok(exists $seen{'jerky'});              # 136
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcm->get_Lonly_ref(2);
}
ok(${$unique_ref}[-1] eq 'jerky');      # 137

$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});             # 138
ok(! exists $seen{'baker'});            # 139
ok(! exists $seen{'camera'});           # 140
ok(! exists $seen{'delta'});            # 141
ok(! exists $seen{'edward'});           # 142
ok(! exists $seen{'fargo'});            # 143
ok(! exists $seen{'golfer'});           # 144
ok(! exists $seen{'hilton'});           # 145
ok(! exists $seen{'icon'});             # 146
ok(exists $seen{'jerky'});              # 147
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcm->get_Aonly(2);
}
ok($unique[-1] eq 'jerky');             # 148

$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});             # 149
ok(! exists $seen{'baker'});            # 150
ok(! exists $seen{'camera'});           # 151
ok(! exists $seen{'delta'});            # 152
ok(! exists $seen{'edward'});           # 153
ok(! exists $seen{'fargo'});            # 154
ok(! exists $seen{'golfer'});           # 155
ok(! exists $seen{'hilton'});           # 156
ok(! exists $seen{'icon'});             # 157
ok(exists $seen{'jerky'});              # 158
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcm->get_Aonly_ref(2);
}
ok(${$unique_ref}[-1] eq 'jerky');      # 159

$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});             # 160
ok(! exists $seen{'baker'});            # 161
ok(! exists $seen{'camera'});           # 162
ok(! exists $seen{'delta'});            # 163
ok(! exists $seen{'edward'});           # 164
ok(! exists $seen{'fargo'});            # 165
ok(! exists $seen{'golfer'});           # 166
ok(! exists $seen{'hilton'});           # 167
ok(! exists $seen{'icon'});             # 168
ok(exists $seen{'jerky'});              # 169
%seen = ();

@unique = $lcm->get_unique;
ok($unique[-1] eq 'abel');              # 170

$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 171
ok(! exists $seen{'baker'});            # 172
ok(! exists $seen{'camera'});           # 173
ok(! exists $seen{'delta'});            # 174
ok(! exists $seen{'edward'});           # 175
ok(! exists $seen{'fargo'});            # 176
ok(! exists $seen{'golfer'});           # 177
ok(! exists $seen{'hilton'});           # 178
ok(! exists $seen{'icon'});             # 179
ok(! exists $seen{'jerky'});            # 180
%seen = ();

$unique_ref = $lcm->get_unique_ref;
ok(${$unique_ref}[-1] eq 'abel');       # 181

$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 182
ok(! exists $seen{'baker'});            # 183
ok(! exists $seen{'camera'});           # 184
ok(! exists $seen{'delta'});            # 185
ok(! exists $seen{'edward'});           # 186
ok(! exists $seen{'fargo'});            # 187
ok(! exists $seen{'golfer'});           # 188
ok(! exists $seen{'hilton'});           # 189
ok(! exists $seen{'icon'});             # 190
ok(! exists $seen{'jerky'});            # 191
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcm->get_Lonly;
}
ok($unique[-1] eq 'abel');              # 192

$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 193
ok(! exists $seen{'baker'});            # 194
ok(! exists $seen{'camera'});           # 195
ok(! exists $seen{'delta'});            # 196
ok(! exists $seen{'edward'});           # 197
ok(! exists $seen{'fargo'});            # 198
ok(! exists $seen{'golfer'});           # 199
ok(! exists $seen{'hilton'});           # 200
ok(! exists $seen{'icon'});             # 201
ok(! exists $seen{'jerky'});            # 202
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcm->get_Lonly_ref;
}
ok(${$unique_ref}[-1] eq 'abel');       # 203

$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 204
ok(! exists $seen{'baker'});            # 205
ok(! exists $seen{'camera'});           # 206
ok(! exists $seen{'delta'});            # 207
ok(! exists $seen{'edward'});           # 208
ok(! exists $seen{'fargo'});            # 209
ok(! exists $seen{'golfer'});           # 210
ok(! exists $seen{'hilton'});           # 211
ok(! exists $seen{'icon'});             # 212
ok(! exists $seen{'jerky'});            # 213
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcm->get_Aonly;
}
ok($unique[-1] eq 'abel');              # 214

$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 215
ok(! exists $seen{'baker'});            # 216
ok(! exists $seen{'camera'});           # 217
ok(! exists $seen{'delta'});            # 218
ok(! exists $seen{'edward'});           # 219
ok(! exists $seen{'fargo'});            # 220
ok(! exists $seen{'golfer'});           # 221
ok(! exists $seen{'hilton'});           # 222
ok(! exists $seen{'icon'});             # 223
ok(! exists $seen{'jerky'});            # 224
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcm->get_Aonly_ref;
}
ok(${$unique_ref}[-1] eq 'abel');       # 225

$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 226
ok(! exists $seen{'baker'});            # 227
ok(! exists $seen{'camera'});           # 228
ok(! exists $seen{'delta'});            # 229
ok(! exists $seen{'edward'});           # 230
ok(! exists $seen{'fargo'});            # 231
ok(! exists $seen{'golfer'});           # 232
ok(! exists $seen{'hilton'});           # 233
ok(! exists $seen{'icon'});             # 234
ok(! exists $seen{'jerky'});            # 235
%seen = ();

@complement = $lcm->get_complement(1);
ok($complement[0] eq 'abel');           # 236
ok($complement[1] eq 'icon');           # 237
ok($complement[-1] eq 'jerky');         # 238

$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 239
ok(! exists $seen{'baker'});            # 240
ok(! exists $seen{'camera'});           # 241
ok(! exists $seen{'delta'});            # 242
ok(! exists $seen{'edward'});           # 243
ok(! exists $seen{'fargo'});            # 244
ok(! exists $seen{'golfer'});           # 245
ok(! exists $seen{'hilton'});           # 246
ok(exists $seen{'icon'});               # 247
ok(exists $seen{'jerky'});              # 248
%seen = ();

$complement_ref = $lcm->get_complement_ref(1);
ok(${$complement_ref}[0] eq 'abel');    # 249
ok(${$complement_ref}[1] eq 'icon');    # 250
ok(${$complement_ref}[-1] eq 'jerky');  # 251

$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 252
ok(! exists $seen{'baker'});            # 253
ok(! exists $seen{'camera'});           # 254
ok(! exists $seen{'delta'});            # 255
ok(! exists $seen{'edward'});           # 256
ok(! exists $seen{'fargo'});            # 257
ok(! exists $seen{'golfer'});           # 258
ok(! exists $seen{'hilton'});           # 259
ok(exists $seen{'icon'});               # 260
ok(exists $seen{'jerky'});              # 261
%seen = ();

eval { $complement_ref = $lcm->get_complement_ref('jerky') };
ok(ok_capture_error($@));               # 262

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcm->get_Ronly(1);
}
ok($complement[0] eq 'abel');           # 263
ok($complement[1] eq 'icon');           # 264
ok($complement[-1] eq 'jerky');         # 265

$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 266
ok(! exists $seen{'baker'});            # 267
ok(! exists $seen{'camera'});           # 268
ok(! exists $seen{'delta'});            # 269
ok(! exists $seen{'edward'});           # 270
ok(! exists $seen{'fargo'});            # 271
ok(! exists $seen{'golfer'});           # 272
ok(! exists $seen{'hilton'});           # 273
ok(exists $seen{'icon'});               # 274
ok(exists $seen{'jerky'});              # 275
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcm->get_Ronly_ref(1);
}
ok(${$complement_ref}[0] eq 'abel');    # 276
ok(${$complement_ref}[1] eq 'icon');    # 277
ok(${$complement_ref}[-1] eq 'jerky');  # 278

$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 279
ok(! exists $seen{'baker'});            # 280
ok(! exists $seen{'camera'});           # 281
ok(! exists $seen{'delta'});            # 282
ok(! exists $seen{'edward'});           # 283
ok(! exists $seen{'fargo'});            # 284
ok(! exists $seen{'golfer'});           # 285
ok(! exists $seen{'hilton'});           # 286
ok(exists $seen{'icon'});               # 287
ok(exists $seen{'jerky'});              # 288
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcm->get_Bonly(1);
}
ok($complement[0] eq 'abel');           # 289
ok($complement[1] eq 'icon');           # 290
ok($complement[-1] eq 'jerky');         # 291

$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 292
ok(! exists $seen{'baker'});            # 293
ok(! exists $seen{'camera'});           # 294
ok(! exists $seen{'delta'});            # 295
ok(! exists $seen{'edward'});           # 296
ok(! exists $seen{'fargo'});            # 297
ok(! exists $seen{'golfer'});           # 298
ok(! exists $seen{'hilton'});           # 299
ok(exists $seen{'icon'});               # 300
ok(exists $seen{'jerky'});              # 301
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcm->get_Bonly_ref(1);
}
ok(${$complement_ref}[0] eq 'abel');    # 302
ok(${$complement_ref}[1] eq 'icon');    # 303
ok(${$complement_ref}[-1] eq 'jerky');  # 304

$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 305
ok(! exists $seen{'baker'});            # 306
ok(! exists $seen{'camera'});           # 307
ok(! exists $seen{'delta'});            # 308
ok(! exists $seen{'edward'});           # 309
ok(! exists $seen{'fargo'});            # 310
ok(! exists $seen{'golfer'});           # 311
ok(! exists $seen{'hilton'});           # 312
ok(exists $seen{'icon'});               # 313
ok(exists $seen{'jerky'});              # 314
%seen = ();

@complement = $lcm->get_complement;
ok($complement[0] eq 'hilton');         # 315
ok($complement[1] eq 'icon');           # 316
ok($complement[-1] eq 'jerky');         # 317

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 318
ok(! exists $seen{'baker'});            # 319
ok(! exists $seen{'camera'});           # 320
ok(! exists $seen{'delta'});            # 321
ok(! exists $seen{'edward'});           # 322
ok(! exists $seen{'fargo'});            # 323
ok(! exists $seen{'golfer'});           # 324
ok(exists $seen{'hilton'});             # 325
ok(exists $seen{'icon'});               # 326
ok(exists $seen{'jerky'});              # 327
%seen = ();

$complement_ref = $lcm->get_complement_ref;
ok(${$complement_ref}[0] eq 'hilton');  # 328
ok(${$complement_ref}[1] eq 'icon');    # 329
ok(${$complement_ref}[-1] eq 'jerky');  # 330

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 331
ok(! exists $seen{'baker'});            # 332
ok(! exists $seen{'camera'});           # 333
ok(! exists $seen{'delta'});            # 334
ok(! exists $seen{'edward'});           # 335
ok(! exists $seen{'fargo'});            # 336
ok(! exists $seen{'golfer'});           # 337
ok(exists $seen{'hilton'});             # 338
ok(exists $seen{'icon'});               # 339
ok(exists $seen{'jerky'});              # 340
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcm->get_Ronly;
}
ok($complement[0] eq 'hilton');         # 341
ok($complement[1] eq 'icon');           # 342
ok($complement[-1] eq 'jerky');         # 343

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 344
ok(! exists $seen{'baker'});            # 345
ok(! exists $seen{'camera'});           # 346
ok(! exists $seen{'delta'});            # 347
ok(! exists $seen{'edward'});           # 348
ok(! exists $seen{'fargo'});            # 349
ok(! exists $seen{'golfer'});           # 350
ok(exists $seen{'hilton'});             # 351
ok(exists $seen{'icon'});               # 352
ok(exists $seen{'jerky'});              # 353
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcm->get_Ronly_ref;
}
ok(${$complement_ref}[0] eq 'hilton');  # 354
ok(${$complement_ref}[1] eq 'icon');    # 355
ok(${$complement_ref}[-1] eq 'jerky');  # 356

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 357
ok(! exists $seen{'baker'});            # 358
ok(! exists $seen{'camera'});           # 359
ok(! exists $seen{'delta'});            # 360
ok(! exists $seen{'edward'});           # 361
ok(! exists $seen{'fargo'});            # 362
ok(! exists $seen{'golfer'});           # 363
ok(exists $seen{'hilton'});             # 364
ok(exists $seen{'icon'});               # 365
ok(exists $seen{'jerky'});              # 366
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcm->get_Bonly;
}
ok($complement[0] eq 'hilton');         # 367
ok($complement[1] eq 'icon');           # 368
ok($complement[-1] eq 'jerky');         # 369

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 370
ok(! exists $seen{'baker'});            # 371
ok(! exists $seen{'camera'});           # 372
ok(! exists $seen{'delta'});            # 373
ok(! exists $seen{'edward'});           # 374
ok(! exists $seen{'fargo'});            # 375
ok(! exists $seen{'golfer'});           # 376
ok(exists $seen{'hilton'});             # 377
ok(exists $seen{'icon'});               # 378
ok(exists $seen{'jerky'});              # 379
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcm->get_Bonly_ref;
}
ok(${$complement_ref}[0] eq 'hilton');  # 380
ok(${$complement_ref}[1] eq 'icon');    # 381
ok(${$complement_ref}[-1] eq 'jerky');  # 382

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 383
ok(! exists $seen{'baker'});            # 384
ok(! exists $seen{'camera'});           # 385
ok(! exists $seen{'delta'});            # 386
ok(! exists $seen{'edward'});           # 387
ok(! exists $seen{'fargo'});            # 388
ok(! exists $seen{'golfer'});           # 389
ok(exists $seen{'hilton'});             # 390
ok(exists $seen{'icon'});               # 391
ok(exists $seen{'jerky'});              # 392
%seen = ();

@symmetric_difference = $lcm->get_symmetric_difference;
ok($symmetric_difference[0] eq 'abel'); # 393
ok($symmetric_difference[-1] eq 'jerky');# 394

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 395
ok(! exists $seen{'baker'});            # 396
ok(! exists $seen{'camera'});           # 397
ok(! exists $seen{'delta'});            # 398
ok(! exists $seen{'edward'});           # 399
ok(! exists $seen{'fargo'});            # 400
ok(! exists $seen{'golfer'});           # 401
ok(! exists $seen{'hilton'});           # 402
ok(! exists $seen{'icon'});             # 403
ok(exists $seen{'jerky'});              # 404
%seen = ();

$symmetric_difference_ref = $lcm->get_symmetric_difference_ref;
ok(${$symmetric_difference_ref}[0] eq 'abel');# 405
ok(${$symmetric_difference_ref}[-1] eq 'jerky');# 406

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 407
ok(! exists $seen{'baker'});            # 408
ok(! exists $seen{'camera'});           # 409
ok(! exists $seen{'delta'});            # 410
ok(! exists $seen{'edward'});           # 411
ok(! exists $seen{'fargo'});            # 412
ok(! exists $seen{'golfer'});           # 413
ok(! exists $seen{'hilton'});           # 414
ok(! exists $seen{'icon'});             # 415
ok(exists $seen{'jerky'});              # 416
%seen = ();

@symmetric_difference = $lcm->get_symdiff;
ok($symmetric_difference[0] eq 'abel'); # 417
ok($symmetric_difference[-1] eq 'jerky');# 418

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 419
ok(! exists $seen{'baker'});            # 420
ok(! exists $seen{'camera'});           # 421
ok(! exists $seen{'delta'});            # 422
ok(! exists $seen{'edward'});           # 423
ok(! exists $seen{'fargo'});            # 424
ok(! exists $seen{'golfer'});           # 425
ok(! exists $seen{'hilton'});           # 426
ok(! exists $seen{'icon'});             # 427
ok(exists $seen{'jerky'});              # 428
%seen = ();

$symmetric_difference_ref = $lcm->get_symdiff_ref;
ok(${$symmetric_difference_ref}[0] eq 'abel');# 429
ok(${$symmetric_difference_ref}[-1] eq 'jerky');# 430

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 431
ok(! exists $seen{'baker'});            # 432
ok(! exists $seen{'camera'});           # 433
ok(! exists $seen{'delta'});            # 434
ok(! exists $seen{'edward'});           # 435
ok(! exists $seen{'fargo'});            # 436
ok(! exists $seen{'golfer'});           # 437
ok(! exists $seen{'hilton'});           # 438
ok(! exists $seen{'icon'});             # 439
ok(exists $seen{'jerky'});              # 440
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @symmetric_difference = $lcm->get_LorRonly;
}
ok($symmetric_difference[0] eq 'abel'); # 441
ok($symmetric_difference[-1] eq 'jerky');# 442

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 443
ok(! exists $seen{'baker'});            # 444
ok(! exists $seen{'camera'});           # 445
ok(! exists $seen{'delta'});            # 446
ok(! exists $seen{'edward'});           # 447
ok(! exists $seen{'fargo'});            # 448
ok(! exists $seen{'golfer'});           # 449
ok(! exists $seen{'hilton'});           # 450
ok(! exists $seen{'icon'});             # 451
ok(exists $seen{'jerky'});              # 452
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $symmetric_difference_ref = $lcm->get_LorRonly_ref;
}
ok(${$symmetric_difference_ref}[0] eq 'abel');# 453
ok(${$symmetric_difference_ref}[-1] eq 'jerky');# 454

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 455
ok(! exists $seen{'baker'});            # 456
ok(! exists $seen{'camera'});           # 457
ok(! exists $seen{'delta'});            # 458
ok(! exists $seen{'edward'});           # 459
ok(! exists $seen{'fargo'});            # 460
ok(! exists $seen{'golfer'});           # 461
ok(! exists $seen{'hilton'});           # 462
ok(! exists $seen{'icon'});             # 463
ok(exists $seen{'jerky'});              # 464
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @symmetric_difference = $lcm->get_AorBonly;
}
ok($symmetric_difference[0] eq 'abel'); # 465
ok($symmetric_difference[-1] eq 'jerky');# 466

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 467
ok(! exists $seen{'baker'});            # 468
ok(! exists $seen{'camera'});           # 469
ok(! exists $seen{'delta'});            # 470
ok(! exists $seen{'edward'});           # 471
ok(! exists $seen{'fargo'});            # 472
ok(! exists $seen{'golfer'});           # 473
ok(! exists $seen{'hilton'});           # 474
ok(! exists $seen{'icon'});             # 475
ok(exists $seen{'jerky'});              # 476
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $symmetric_difference_ref = $lcm->get_AorBonly_ref;
}
ok(${$symmetric_difference_ref}[0] eq 'abel');# 477
ok(${$symmetric_difference_ref}[-1] eq 'jerky');# 478

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 479
ok(! exists $seen{'baker'});            # 480
ok(! exists $seen{'camera'});           # 481
ok(! exists $seen{'delta'});            # 482
ok(! exists $seen{'edward'});           # 483
ok(! exists $seen{'fargo'});            # 484
ok(! exists $seen{'golfer'});           # 485
ok(! exists $seen{'hilton'});           # 486
ok(! exists $seen{'icon'});             # 487
ok(exists $seen{'jerky'});              # 488
%seen = ();

@nonintersection = $lcm->get_nonintersection;
ok($nonintersection[0] eq 'abel');      # 489
ok($nonintersection[1] eq 'baker');     # 490
ok($nonintersection[2] eq 'camera');    # 491
ok($nonintersection[3] eq 'delta');     # 492
ok($nonintersection[4] eq 'edward');    # 493
ok($nonintersection[5] eq 'hilton');    # 494
ok($nonintersection[6] eq 'icon');      # 495
ok($nonintersection[-1] eq 'jerky');    # 496

$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 497
ok(exists $seen{'baker'});              # 498
ok(exists $seen{'camera'});             # 499
ok(exists $seen{'delta'});              # 500
ok(exists $seen{'edward'});             # 501
ok(! exists $seen{'fargo'});            # 502
ok(! exists $seen{'golfer'});           # 503
ok(exists $seen{'hilton'});             # 504
ok(exists $seen{'icon'});               # 505
ok(exists $seen{'jerky'});              # 506
%seen = ();

$nonintersection_ref = $lcm->get_nonintersection_ref;
ok(${$nonintersection_ref}[0] eq 'abel');# 507
ok(${$nonintersection_ref}[1] eq 'baker');# 508
ok(${$nonintersection_ref}[2] eq 'camera');# 509
ok(${$nonintersection_ref}[3] eq 'delta');# 510
ok(${$nonintersection_ref}[4] eq 'edward');# 511
ok(${$nonintersection_ref}[5] eq 'hilton');# 512
ok(${$nonintersection_ref}[6] eq 'icon');# 513
ok(${$nonintersection_ref}[-1] eq 'jerky');# 514

$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 515
ok(exists $seen{'baker'});              # 516
ok(exists $seen{'camera'});             # 517
ok(exists $seen{'delta'});              # 518
ok(exists $seen{'edward'});             # 519
ok(! exists $seen{'fargo'});            # 520
ok(! exists $seen{'golfer'});           # 521
ok(exists $seen{'hilton'});             # 522
ok(exists $seen{'icon'});               # 523
ok(exists $seen{'jerky'});              # 524
%seen = ();

@bag = $lcm->get_bag;
ok($bag[0] eq 'abel');                  # 525
ok($bag[1] eq 'abel');                  # 526
ok($bag[2] eq 'baker');                 # 527
ok($bag[3] eq 'baker');                 # 528
ok($bag[4] eq 'camera');                # 529
ok($bag[5] eq 'camera');                # 530
ok($bag[6] eq 'delta');                 # 531
ok($bag[7] eq 'delta');                 # 532
ok($bag[8] eq 'delta');                 # 533
ok($bag[9] eq 'edward');                # 534
ok($bag[10] eq 'edward');               # 535
ok($bag[11] eq 'fargo');                # 536
ok($bag[12] eq 'fargo');                # 537
ok($bag[13] eq 'fargo');                # 538
ok($bag[14] eq 'fargo');                # 539
ok($bag[15] eq 'fargo');                # 540
ok($bag[16] eq 'fargo');                # 541
ok($bag[17] eq 'golfer');               # 542
ok($bag[18] eq 'golfer');               # 543
ok($bag[19] eq 'golfer');               # 544
ok($bag[20] eq 'golfer');               # 545
ok($bag[21] eq 'golfer');               # 546
ok($bag[22] eq 'hilton');               # 547
ok($bag[23] eq 'hilton');               # 548
ok($bag[24] eq 'hilton');               # 549
ok($bag[25] eq 'hilton');               # 550
ok($bag[26] eq 'icon');                 # 551
ok($bag[27] eq 'icon');                 # 552
ok($bag[28] eq 'icon');                 # 553
ok($bag[29] eq 'icon');                 # 554
ok($bag[30] eq 'icon');                 # 555
ok($bag[-1] eq 'jerky');                # 556

$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 557
ok($seen{'baker'} == 2);                # 558
ok($seen{'camera'} == 2);               # 559
ok($seen{'delta'} == 3);                # 560
ok($seen{'edward'} == 2);               # 561
ok($seen{'fargo'} == 6);                # 562
ok($seen{'golfer'} == 5);               # 563
ok($seen{'hilton'} == 4);               # 564
ok($seen{'icon'} == 5);                 # 565
ok($seen{'jerky'} == 1);                # 566
%seen = ();

$bag_ref = $lcm->get_bag_ref;
ok(${$bag_ref}[0] eq 'abel');           # 567
ok(${$bag_ref}[1] eq 'abel');           # 568
ok(${$bag_ref}[2] eq 'baker');          # 569
ok(${$bag_ref}[3] eq 'baker');          # 570
ok(${$bag_ref}[4] eq 'camera');         # 571
ok(${$bag_ref}[5] eq 'camera');         # 572
ok(${$bag_ref}[6] eq 'delta');          # 573
ok(${$bag_ref}[7] eq 'delta');          # 574
ok(${$bag_ref}[8] eq 'delta');          # 575
ok(${$bag_ref}[9] eq 'edward');         # 576
ok(${$bag_ref}[10] eq 'edward');        # 577
ok(${$bag_ref}[11] eq 'fargo');         # 578
ok(${$bag_ref}[12] eq 'fargo');         # 579
ok(${$bag_ref}[13] eq 'fargo');         # 580
ok(${$bag_ref}[14] eq 'fargo');         # 581
ok(${$bag_ref}[15] eq 'fargo');         # 582
ok(${$bag_ref}[16] eq 'fargo');         # 583
ok(${$bag_ref}[17] eq 'golfer');        # 584
ok(${$bag_ref}[18] eq 'golfer');        # 585
ok(${$bag_ref}[19] eq 'golfer');        # 586
ok(${$bag_ref}[20] eq 'golfer');        # 587
ok(${$bag_ref}[21] eq 'golfer');        # 588
ok(${$bag_ref}[22] eq 'hilton');        # 589
ok(${$bag_ref}[23] eq 'hilton');        # 590
ok(${$bag_ref}[24] eq 'hilton');        # 591
ok(${$bag_ref}[25] eq 'hilton');        # 592
ok(${$bag_ref}[26] eq 'icon');          # 593
ok(${$bag_ref}[27] eq 'icon');          # 594
ok(${$bag_ref}[28] eq 'icon');          # 595
ok(${$bag_ref}[29] eq 'icon');          # 596
ok(${$bag_ref}[30] eq 'icon');          # 597
ok(${$bag_ref}[-1] eq 'jerky');         # 598

$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 599
ok($seen{'baker'} == 2);                # 600
ok($seen{'camera'} == 2);               # 601
ok($seen{'delta'} == 3);                # 602
ok($seen{'edward'} == 2);               # 603
ok($seen{'fargo'} == 6);                # 604
ok($seen{'golfer'} == 5);               # 605
ok($seen{'hilton'} == 4);               # 606
ok($seen{'icon'} == 5);                 # 607
ok($seen{'jerky'} == 1);                # 608
%seen = ();

$LR = $lcm->is_LsubsetR(3,2);
ok($LR);                                # 609

$LR = $lcm->is_AsubsetB(3,2);
ok($LR);                                # 610

$LR = $lcm->is_LsubsetR(2,3);
ok(! $LR);                              # 611

$LR = $lcm->is_AsubsetB(2,3);
ok(! $LR);                              # 612

$LR = $lcm->is_LsubsetR;
ok(! $LR);                              # 613

eval { $LR = $lcm->is_LsubsetR(2) };
ok(ok_capture_error($@));               # 614

eval { $LR = $lcm->is_LsubsetR(8,9) };
ok(ok_capture_error($@));               # 615

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcm->is_RsubsetL;
}
ok(! $RL);                              # 616

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcm->is_BsubsetA;
}
ok(! $RL);                              # 617

$eqv = $lcm->is_LequivalentR(3,4);
ok($eqv);                               # 618

$eqv = $lcm->is_LeqvlntR(3,4);
ok($eqv);                               # 619

$eqv = $lcm->is_LequivalentR(2,4);
ok(! $eqv);                             # 620

eval { $eqv = $lcm->is_LequivalentR(2) };
ok(ok_capture_error($@));               # 621

eval { $eqv = $lcm->is_LequivalentR(8,9) };
ok(ok_capture_error($@));               # 622

$return = $lcm->print_subset_chart;
ok($return);                            # 623

$return = $lcm->print_equivalence_chart;
ok($return);                            # 624

@memb_arr = $lcm->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0        > ] ));# 625

@memb_arr = $lcm->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1      > ] ));# 626

@memb_arr = $lcm->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1      > ] ));# 627

@memb_arr = $lcm->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1      > ] ));# 628

@memb_arr = $lcm->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1      > ] ));# 629

@memb_arr = $lcm->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 630

@memb_arr = $lcm->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 631

@memb_arr = $lcm->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 632

@memb_arr = $lcm->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   3, [ qw<     2 3 4 > ] ));# 633

@memb_arr = $lcm->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  1, [ qw<     2     > ] ));# 634

@memb_arr = $lcm->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<           > ] ));# 635


$memb_arr_ref = $lcm->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0        > ] ));# 636

$memb_arr_ref = $lcm->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1      > ] ));# 637

$memb_arr_ref = $lcm->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1      > ] ));# 638

$memb_arr_ref = $lcm->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1      > ] ));# 639

$memb_arr_ref = $lcm->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1      > ] ));# 640

$memb_arr_ref = $lcm->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 641

$memb_arr_ref = $lcm->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 642

$memb_arr_ref = $lcm->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 643

$memb_arr_ref = $lcm->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   3, [ qw<     2 3 4 > ] ));# 644

$memb_arr_ref = $lcm->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  1, [ qw<     2     > ] ));# 645

$memb_arr_ref = $lcm->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<           > ] ));# 646

eval { $memb_arr_ref = $lcm->is_member_which_ref('jerky', 'zebra') };
ok(ok_capture_error($@));               # 647


$memb_hash_ref = $lcm->are_members_which(
  [ qw| abel baker camera delta edward fargo
    golfer hilton icon jerky zebra | ]
);
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0         > ] ));# 648
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1       > ] ));# 649
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1       > ] ));# 650
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1       > ] ));# 651
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1       > ] ));# 652
ok(ok_seen_h( $memb_hash_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 653
ok(ok_seen_h( $memb_hash_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 654
ok(ok_seen_h( $memb_hash_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 655
ok(ok_seen_h( $memb_hash_ref, 'icon',   3, [ qw<     2 3 4 > ] ));# 656
ok(ok_seen_h( $memb_hash_ref, 'jerky',  1, [ qw<     2     > ] ));# 657
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<           > ] ));# 658

eval { $memb_hash_ref = $lcm->are_members_which( { key => 'value' } ) };
ok(ok_capture_error($@));               # 659


ok($lcm->is_member_any('abel'));        # 660
ok($lcm->is_member_any('baker'));       # 661
ok($lcm->is_member_any('camera'));      # 662
ok($lcm->is_member_any('delta'));       # 663
ok($lcm->is_member_any('edward'));      # 664
ok($lcm->is_member_any('fargo'));       # 665
ok($lcm->is_member_any('golfer'));      # 666
ok($lcm->is_member_any('hilton'));      # 667
ok($lcm->is_member_any('icon' ));       # 668
ok($lcm->is_member_any('jerky'));       # 669
ok(! $lcm->is_member_any('zebra'));     # 670

eval { $lcm->is_member_any('jerky', 'zebra') };
ok(ok_capture_error($@));               # 671


$memb_hash_ref = $lcm->are_members_any(
    [ qw| abel baker camera delta edward fargo golfer hilton icon jerky zebra | ] );
ok(ok_any_h( $memb_hash_ref, 'abel',   1 ));# 672
ok(ok_any_h( $memb_hash_ref, 'baker',  1 ));# 673
ok(ok_any_h( $memb_hash_ref, 'camera', 1 ));# 674
ok(ok_any_h( $memb_hash_ref, 'delta',  1 ));# 675
ok(ok_any_h( $memb_hash_ref, 'edward', 1 ));# 676
ok(ok_any_h( $memb_hash_ref, 'fargo',  1 ));# 677
ok(ok_any_h( $memb_hash_ref, 'golfer', 1 ));# 678
ok(ok_any_h( $memb_hash_ref, 'hilton', 1 ));# 679
ok(ok_any_h( $memb_hash_ref, 'icon',   1 ));# 680
ok(ok_any_h( $memb_hash_ref, 'jerky',  1 ));# 681
ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));# 682

eval { $memb_hash_ref = $lcm->are_members_any( { key => 'value' } ) };
ok(ok_capture_error($@));               # 683


$vers = $lcm->get_version;
ok($vers);                              # 684

my $lcm_dj   = List::Compare->new(\@a0, \@a1, \@a2, \@a3, \@a4, \@a8);

ok($lcm_dj);                            # 685

$disj = $lcm_dj->is_LdisjointR;
ok(! $disj);                            # 686

$disj = $lcm_dj->is_LdisjointR(2,3);
ok(! $disj);                            # 687

$disj = $lcm_dj->is_LdisjointR(4,5);
ok($disj);                              # 688

eval { $disj = $lcm_dj->is_LdisjointR(2) };
ok(ok_capture_error($@));               # 689

########## BELOW:  Tests for '-u' option ##########

my $lcmu   = List::Compare->new('-u', \@a0, \@a1, \@a2, \@a3, \@a4);

ok($lcmu);                              # 690

@union = $lcmu->get_union;
$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});               # 691
ok(exists $seen{'baker'});              # 692
ok(exists $seen{'camera'});             # 693
ok(exists $seen{'delta'});              # 694
ok(exists $seen{'edward'});             # 695
ok(exists $seen{'fargo'});              # 696
ok(exists $seen{'golfer'});             # 697
ok(exists $seen{'hilton'});             # 698
ok(exists $seen{'icon'});               # 699
ok(exists $seen{'jerky'});              # 700
%seen = ();

$union_ref = $lcmu->get_union_ref;
$seen{$_}++ foreach (@{$union_ref});
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

@shared = $lcmu->get_shared;
$seen{$_}++ foreach (@shared);
ok(! exists $seen{'abel'});             # 711
ok(exists $seen{'baker'});              # 712
ok(exists $seen{'camera'});             # 713
ok(exists $seen{'delta'});              # 714
ok(exists $seen{'edward'});             # 715
ok(exists $seen{'fargo'});              # 716
ok(exists $seen{'golfer'});             # 717
ok(exists $seen{'hilton'});             # 718
ok(exists $seen{'icon'});               # 719
ok(! exists $seen{'jerky'});            # 720
%seen = ();

$shared_ref = $lcmu->get_shared_ref;
$seen{$_}++ foreach (@{$shared_ref});
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

@intersection = $lcmu->get_intersection;
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 731
ok(! exists $seen{'baker'});            # 732
ok(! exists $seen{'camera'});           # 733
ok(! exists $seen{'delta'});            # 734
ok(! exists $seen{'edward'});           # 735
ok(exists $seen{'fargo'});              # 736
ok(exists $seen{'golfer'});             # 737
ok(! exists $seen{'hilton'});           # 738
ok(! exists $seen{'icon'});             # 739
ok(! exists $seen{'jerky'});            # 740
%seen = ();

$intersection_ref = $lcmu->get_intersection_ref;
$seen{$_}++ foreach (@{$intersection_ref});
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

@unique = $lcmu->get_unique(2);
$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});             # 751
ok(! exists $seen{'baker'});            # 752
ok(! exists $seen{'camera'});           # 753
ok(! exists $seen{'delta'});            # 754
ok(! exists $seen{'edward'});           # 755
ok(! exists $seen{'fargo'});            # 756
ok(! exists $seen{'golfer'});           # 757
ok(! exists $seen{'hilton'});           # 758
ok(! exists $seen{'icon'});             # 759
ok(exists $seen{'jerky'});              # 760
%seen = ();

$unique_ref = $lcmu->get_unique_ref(2);
$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});             # 761
ok(! exists $seen{'baker'});            # 762
ok(! exists $seen{'camera'});           # 763
ok(! exists $seen{'delta'});            # 764
ok(! exists $seen{'edward'});           # 765
ok(! exists $seen{'fargo'});            # 766
ok(! exists $seen{'golfer'});           # 767
ok(! exists $seen{'hilton'});           # 768
ok(! exists $seen{'icon'});             # 769
ok(exists $seen{'jerky'});              # 770
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmu->get_Lonly_ref(2);
}
$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});             # 771
ok(! exists $seen{'baker'});            # 772
ok(! exists $seen{'camera'});           # 773
ok(! exists $seen{'delta'});            # 774
ok(! exists $seen{'edward'});           # 775
ok(! exists $seen{'fargo'});            # 776
ok(! exists $seen{'golfer'});           # 777
ok(! exists $seen{'hilton'});           # 778
ok(! exists $seen{'icon'});             # 779
ok(exists $seen{'jerky'});              # 780
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcmu->get_Aonly(2);
}
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

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmu->get_Aonly_ref(2);
}
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
%seen = ();

@unique = $lcmu->get_unique;
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 801
ok(! exists $seen{'baker'});            # 802
ok(! exists $seen{'camera'});           # 803
ok(! exists $seen{'delta'});            # 804
ok(! exists $seen{'edward'});           # 805
ok(! exists $seen{'fargo'});            # 806
ok(! exists $seen{'golfer'});           # 807
ok(! exists $seen{'hilton'});           # 808
ok(! exists $seen{'icon'});             # 809
ok(! exists $seen{'jerky'});            # 810
%seen = ();

$unique_ref = $lcmu->get_unique_ref;
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 811
ok(! exists $seen{'baker'});            # 812
ok(! exists $seen{'camera'});           # 813
ok(! exists $seen{'delta'});            # 814
ok(! exists $seen{'edward'});           # 815
ok(! exists $seen{'fargo'});            # 816
ok(! exists $seen{'golfer'});           # 817
ok(! exists $seen{'hilton'});           # 818
ok(! exists $seen{'icon'});             # 819
ok(! exists $seen{'jerky'});            # 820
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcmu->get_Lonly;
}
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 821
ok(! exists $seen{'baker'});            # 822
ok(! exists $seen{'camera'});           # 823
ok(! exists $seen{'delta'});            # 824
ok(! exists $seen{'edward'});           # 825
ok(! exists $seen{'fargo'});            # 826
ok(! exists $seen{'golfer'});           # 827
ok(! exists $seen{'hilton'});           # 828
ok(! exists $seen{'icon'});             # 829
ok(! exists $seen{'jerky'});            # 830
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmu->get_Lonly_ref;
}
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 831
ok(! exists $seen{'baker'});            # 832
ok(! exists $seen{'camera'});           # 833
ok(! exists $seen{'delta'});            # 834
ok(! exists $seen{'edward'});           # 835
ok(! exists $seen{'fargo'});            # 836
ok(! exists $seen{'golfer'});           # 837
ok(! exists $seen{'hilton'});           # 838
ok(! exists $seen{'icon'});             # 839
ok(! exists $seen{'jerky'});            # 840
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcmu->get_Aonly;
}
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 841
ok(! exists $seen{'baker'});            # 842
ok(! exists $seen{'camera'});           # 843
ok(! exists $seen{'delta'});            # 844
ok(! exists $seen{'edward'});           # 845
ok(! exists $seen{'fargo'});            # 846
ok(! exists $seen{'golfer'});           # 847
ok(! exists $seen{'hilton'});           # 848
ok(! exists $seen{'icon'});             # 849
ok(! exists $seen{'jerky'});            # 850
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmu->get_Aonly_ref;
}
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 851
ok(! exists $seen{'baker'});            # 852
ok(! exists $seen{'camera'});           # 853
ok(! exists $seen{'delta'});            # 854
ok(! exists $seen{'edward'});           # 855
ok(! exists $seen{'fargo'});            # 856
ok(! exists $seen{'golfer'});           # 857
ok(! exists $seen{'hilton'});           # 858
ok(! exists $seen{'icon'});             # 859
ok(! exists $seen{'jerky'});            # 860
%seen = ();

@complement = $lcmu->get_complement(1);
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 861
ok(! exists $seen{'baker'});            # 862
ok(! exists $seen{'camera'});           # 863
ok(! exists $seen{'delta'});            # 864
ok(! exists $seen{'edward'});           # 865
ok(! exists $seen{'fargo'});            # 866
ok(! exists $seen{'golfer'});           # 867
ok(! exists $seen{'hilton'});           # 868
ok(exists $seen{'icon'});               # 869
ok(exists $seen{'jerky'});              # 870
%seen = ();

$complement_ref = $lcmu->get_complement_ref(1);
$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 871
ok(! exists $seen{'baker'});            # 872
ok(! exists $seen{'camera'});           # 873
ok(! exists $seen{'delta'});            # 874
ok(! exists $seen{'edward'});           # 875
ok(! exists $seen{'fargo'});            # 876
ok(! exists $seen{'golfer'});           # 877
ok(! exists $seen{'hilton'});           # 878
ok(exists $seen{'icon'});               # 879
ok(exists $seen{'jerky'});              # 880
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmu->get_Ronly(1);
}
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 881
ok(! exists $seen{'baker'});            # 882
ok(! exists $seen{'camera'});           # 883
ok(! exists $seen{'delta'});            # 884
ok(! exists $seen{'edward'});           # 885
ok(! exists $seen{'fargo'});            # 886
ok(! exists $seen{'golfer'});           # 887
ok(! exists $seen{'hilton'});           # 888
ok(exists $seen{'icon'});               # 889
ok(exists $seen{'jerky'});              # 890
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmu->get_Ronly_ref(1);
}
$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 891
ok(! exists $seen{'baker'});            # 892
ok(! exists $seen{'camera'});           # 893
ok(! exists $seen{'delta'});            # 894
ok(! exists $seen{'edward'});           # 895
ok(! exists $seen{'fargo'});            # 896
ok(! exists $seen{'golfer'});           # 897
ok(! exists $seen{'hilton'});           # 898
ok(exists $seen{'icon'});               # 899
ok(exists $seen{'jerky'});              # 900
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmu->get_Bonly(1);
}
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 901
ok(! exists $seen{'baker'});            # 902
ok(! exists $seen{'camera'});           # 903
ok(! exists $seen{'delta'});            # 904
ok(! exists $seen{'edward'});           # 905
ok(! exists $seen{'fargo'});            # 906
ok(! exists $seen{'golfer'});           # 907
ok(! exists $seen{'hilton'});           # 908
ok(exists $seen{'icon'});               # 909
ok(exists $seen{'jerky'});              # 910
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmu->get_Bonly_ref(1);
}
$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 911
ok(! exists $seen{'baker'});            # 912
ok(! exists $seen{'camera'});           # 913
ok(! exists $seen{'delta'});            # 914
ok(! exists $seen{'edward'});           # 915
ok(! exists $seen{'fargo'});            # 916
ok(! exists $seen{'golfer'});           # 917
ok(! exists $seen{'hilton'});           # 918
ok(exists $seen{'icon'});               # 919
ok(exists $seen{'jerky'});              # 920
%seen = ();

@complement = $lcmu->get_complement;
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 921
ok(! exists $seen{'baker'});            # 922
ok(! exists $seen{'camera'});           # 923
ok(! exists $seen{'delta'});            # 924
ok(! exists $seen{'edward'});           # 925
ok(! exists $seen{'fargo'});            # 926
ok(! exists $seen{'golfer'});           # 927
ok(exists $seen{'hilton'});             # 928
ok(exists $seen{'icon'});               # 929
ok(exists $seen{'jerky'});              # 930
%seen = ();

$complement_ref = $lcmu->get_complement_ref;
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 931
ok(! exists $seen{'baker'});            # 932
ok(! exists $seen{'camera'});           # 933
ok(! exists $seen{'delta'});            # 934
ok(! exists $seen{'edward'});           # 935
ok(! exists $seen{'fargo'});            # 936
ok(! exists $seen{'golfer'});           # 937
ok(exists $seen{'hilton'});             # 938
ok(exists $seen{'icon'});               # 939
ok(exists $seen{'jerky'});              # 940
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmu->get_Ronly;
}
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 941
ok(! exists $seen{'baker'});            # 942
ok(! exists $seen{'camera'});           # 943
ok(! exists $seen{'delta'});            # 944
ok(! exists $seen{'edward'});           # 945
ok(! exists $seen{'fargo'});            # 946
ok(! exists $seen{'golfer'});           # 947
ok(exists $seen{'hilton'});             # 948
ok(exists $seen{'icon'});               # 949
ok(exists $seen{'jerky'});              # 950
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmu->get_Ronly_ref;
}
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 951
ok(! exists $seen{'baker'});            # 952
ok(! exists $seen{'camera'});           # 953
ok(! exists $seen{'delta'});            # 954
ok(! exists $seen{'edward'});           # 955
ok(! exists $seen{'fargo'});            # 956
ok(! exists $seen{'golfer'});           # 957
ok(exists $seen{'hilton'});             # 958
ok(exists $seen{'icon'});               # 959
ok(exists $seen{'jerky'});              # 960
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmu->get_Bonly;
}
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 961
ok(! exists $seen{'baker'});            # 962
ok(! exists $seen{'camera'});           # 963
ok(! exists $seen{'delta'});            # 964
ok(! exists $seen{'edward'});           # 965
ok(! exists $seen{'fargo'});            # 966
ok(! exists $seen{'golfer'});           # 967
ok(exists $seen{'hilton'});             # 968
ok(exists $seen{'icon'});               # 969
ok(exists $seen{'jerky'});              # 970
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmu->get_Bonly_ref;
}
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 971
ok(! exists $seen{'baker'});            # 972
ok(! exists $seen{'camera'});           # 973
ok(! exists $seen{'delta'});            # 974
ok(! exists $seen{'edward'});           # 975
ok(! exists $seen{'fargo'});            # 976
ok(! exists $seen{'golfer'});           # 977
ok(exists $seen{'hilton'});             # 978
ok(exists $seen{'icon'});               # 979
ok(exists $seen{'jerky'});              # 980
%seen = ();

@symmetric_difference = $lcmu->get_symmetric_difference;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 981
ok(! exists $seen{'baker'});            # 982
ok(! exists $seen{'camera'});           # 983
ok(! exists $seen{'delta'});            # 984
ok(! exists $seen{'edward'});           # 985
ok(! exists $seen{'fargo'});            # 986
ok(! exists $seen{'golfer'});           # 987
ok(! exists $seen{'hilton'});           # 988
ok(! exists $seen{'icon'});             # 989
ok(exists $seen{'jerky'});              # 990
%seen = ();

$symmetric_difference_ref = $lcmu->get_symmetric_difference_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 991
ok(! exists $seen{'baker'});            # 992
ok(! exists $seen{'camera'});           # 993
ok(! exists $seen{'delta'});            # 994
ok(! exists $seen{'edward'});           # 995
ok(! exists $seen{'fargo'});            # 996
ok(! exists $seen{'golfer'});           # 997
ok(! exists $seen{'hilton'});           # 998
ok(! exists $seen{'icon'});             # 999
ok(exists $seen{'jerky'});              # 1000
%seen = ();

@symmetric_difference = $lcmu->get_symdiff;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 1001
ok(! exists $seen{'baker'});            # 1002
ok(! exists $seen{'camera'});           # 1003
ok(! exists $seen{'delta'});            # 1004
ok(! exists $seen{'edward'});           # 1005
ok(! exists $seen{'fargo'});            # 1006
ok(! exists $seen{'golfer'});           # 1007
ok(! exists $seen{'hilton'});           # 1008
ok(! exists $seen{'icon'});             # 1009
ok(exists $seen{'jerky'});              # 1010
%seen = ();

$symmetric_difference_ref = $lcmu->get_symdiff_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 1011
ok(! exists $seen{'baker'});            # 1012
ok(! exists $seen{'camera'});           # 1013
ok(! exists $seen{'delta'});            # 1014
ok(! exists $seen{'edward'});           # 1015
ok(! exists $seen{'fargo'});            # 1016
ok(! exists $seen{'golfer'});           # 1017
ok(! exists $seen{'hilton'});           # 1018
ok(! exists $seen{'icon'});             # 1019
ok(exists $seen{'jerky'});              # 1020
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @symmetric_difference = $lcmu->get_LorRonly;
}
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 1021
ok(! exists $seen{'baker'});            # 1022
ok(! exists $seen{'camera'});           # 1023
ok(! exists $seen{'delta'});            # 1024
ok(! exists $seen{'edward'});           # 1025
ok(! exists $seen{'fargo'});            # 1026
ok(! exists $seen{'golfer'});           # 1027
ok(! exists $seen{'hilton'});           # 1028
ok(! exists $seen{'icon'});             # 1029
ok(exists $seen{'jerky'});              # 1030
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $symmetric_difference_ref = $lcmu->get_LorRonly_ref;
}
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 1031
ok(! exists $seen{'baker'});            # 1032
ok(! exists $seen{'camera'});           # 1033
ok(! exists $seen{'delta'});            # 1034
ok(! exists $seen{'edward'});           # 1035
ok(! exists $seen{'fargo'});            # 1036
ok(! exists $seen{'golfer'});           # 1037
ok(! exists $seen{'hilton'});           # 1038
ok(! exists $seen{'icon'});             # 1039
ok(exists $seen{'jerky'});              # 1040
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @symmetric_difference = $lcmu->get_AorBonly;
}
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 1041
ok(! exists $seen{'baker'});            # 1042
ok(! exists $seen{'camera'});           # 1043
ok(! exists $seen{'delta'});            # 1044
ok(! exists $seen{'edward'});           # 1045
ok(! exists $seen{'fargo'});            # 1046
ok(! exists $seen{'golfer'});           # 1047
ok(! exists $seen{'hilton'});           # 1048
ok(! exists $seen{'icon'});             # 1049
ok(exists $seen{'jerky'});              # 1050
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $symmetric_difference_ref = $lcmu->get_AorBonly_ref;
}
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 1051
ok(! exists $seen{'baker'});            # 1052
ok(! exists $seen{'camera'});           # 1053
ok(! exists $seen{'delta'});            # 1054
ok(! exists $seen{'edward'});           # 1055
ok(! exists $seen{'fargo'});            # 1056
ok(! exists $seen{'golfer'});           # 1057
ok(! exists $seen{'hilton'});           # 1058
ok(! exists $seen{'icon'});             # 1059
ok(exists $seen{'jerky'});              # 1060
%seen = ();

@nonintersection = $lcmu->get_nonintersection;
$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 1061
ok(exists $seen{'baker'});              # 1062
ok(exists $seen{'camera'});             # 1063
ok(exists $seen{'delta'});              # 1064
ok(exists $seen{'edward'});             # 1065
ok(! exists $seen{'fargo'});            # 1066
ok(! exists $seen{'golfer'});           # 1067
ok(exists $seen{'hilton'});             # 1068
ok(exists $seen{'icon'});               # 1069
ok(exists $seen{'jerky'});              # 1070
%seen = ();

$nonintersection_ref = $lcmu->get_nonintersection_ref;
$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 1071
ok(exists $seen{'baker'});              # 1072
ok(exists $seen{'camera'});             # 1073
ok(exists $seen{'delta'});              # 1074
ok(exists $seen{'edward'});             # 1075
ok(! exists $seen{'fargo'});            # 1076
ok(! exists $seen{'golfer'});           # 1077
ok(exists $seen{'hilton'});             # 1078
ok(exists $seen{'icon'});               # 1079
ok(exists $seen{'jerky'});              # 1080
%seen = ();

@bag = $lcmu->get_bag;
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 1081
ok($seen{'baker'} == 2);                # 1082
ok($seen{'camera'} == 2);               # 1083
ok($seen{'delta'} == 3);                # 1084
ok($seen{'edward'} == 2);               # 1085
ok($seen{'fargo'} == 6);                # 1086
ok($seen{'golfer'} == 5);               # 1087
ok($seen{'hilton'} == 4);               # 1088
ok($seen{'icon'} == 5);                 # 1089
ok($seen{'jerky'} == 1);                # 1090
%seen = ();

$bag_ref = $lcmu->get_bag_ref;
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 1091
ok($seen{'baker'} == 2);                # 1092
ok($seen{'camera'} == 2);               # 1093
ok($seen{'delta'} == 3);                # 1094
ok($seen{'edward'} == 2);               # 1095
ok($seen{'fargo'} == 6);                # 1096
ok($seen{'golfer'} == 5);               # 1097
ok($seen{'hilton'} == 4);               # 1098
ok($seen{'icon'} == 5);                 # 1099
ok($seen{'jerky'} == 1);                # 1100
%seen = ();

$LR = $lcmu->is_LsubsetR(3,2);
ok($LR);                                # 1101

$LR = $lcmu->is_AsubsetB(3,2);
ok($LR);                                # 1102

$LR = $lcmu->is_LsubsetR(2,3);
ok(! $LR);                              # 1103

$LR = $lcmu->is_AsubsetB(2,3);
ok(! $LR);                              # 1104

$LR = $lcmu->is_LsubsetR;
ok(! $LR);                              # 1105

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcmu->is_RsubsetL;
}
ok(! $RL);                              # 1106

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcmu->is_BsubsetA;
}
ok(! $RL);                              # 1107

$eqv = $lcmu->is_LequivalentR(3,4);
ok($eqv);                               # 1108

$eqv = $lcmu->is_LeqvlntR(3,4);
ok($eqv);                               # 1109

$eqv = $lcmu->is_LequivalentR(2,4);
ok(! $eqv);                             # 1110

$return = $lcmu->print_subset_chart;
ok($return);                            # 1111

$return = $lcmu->print_equivalence_chart;
ok($return);                            # 1112

@memb_arr = $lcmu->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0        > ] ));# 1113

@memb_arr = $lcmu->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1      > ] ));# 1114

@memb_arr = $lcmu->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1      > ] ));# 1115

@memb_arr = $lcmu->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1      > ] ));# 1116

@memb_arr = $lcmu->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1      > ] ));# 1117

@memb_arr = $lcmu->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 1118

@memb_arr = $lcmu->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 1119

@memb_arr = $lcmu->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 1120

@memb_arr = $lcmu->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   3, [ qw<     2 3 4 > ] ));# 1121

@memb_arr = $lcmu->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  1, [ qw<     2     > ] ));# 1122

@memb_arr = $lcmu->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<           > ] ));# 1123

$memb_arr_ref = $lcmu->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0        > ] ));# 1124

$memb_arr_ref = $lcmu->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1      > ] ));# 1125

$memb_arr_ref = $lcmu->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1      > ] ));# 1126

$memb_arr_ref = $lcmu->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1      > ] ));# 1127

$memb_arr_ref = $lcmu->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1      > ] ));# 1128

$memb_arr_ref = $lcmu->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 1129

$memb_arr_ref = $lcmu->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 1130

$memb_arr_ref = $lcmu->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 1131

$memb_arr_ref = $lcmu->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   3, [ qw<     2 3 4 > ] ));# 1132

$memb_arr_ref = $lcmu->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  1, [ qw<     2     > ] ));# 1133

$memb_arr_ref = $lcmu->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<           > ] ));# 1134

$memb_hash_ref = $lcmu->are_members_which(
    [ qw| abel baker camera delta edward fargo
          golfer hilton icon jerky zebra | ] );
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0         > ] ));# 1135
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1       > ] ));# 1136
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1       > ] ));# 1137
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1       > ] ));# 1138
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1       > ] ));# 1139
ok(ok_seen_h( $memb_hash_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 1140
ok(ok_seen_h( $memb_hash_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 1141
ok(ok_seen_h( $memb_hash_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 1142
ok(ok_seen_h( $memb_hash_ref, 'icon',   3, [ qw<     2 3 4 > ] ));# 1143
ok(ok_seen_h( $memb_hash_ref, 'jerky',  1, [ qw<     2     > ] ));# 1144
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<           > ] ));# 1145


ok($lcmu->is_member_any('abel'));       # 1146
ok($lcmu->is_member_any('baker'));      # 1147
ok($lcmu->is_member_any('camera'));     # 1148
ok($lcmu->is_member_any('delta'));      # 1149
ok($lcmu->is_member_any('edward'));     # 1150
ok($lcmu->is_member_any('fargo'));      # 1151
ok($lcmu->is_member_any('golfer'));     # 1152
ok($lcmu->is_member_any('hilton'));     # 1153
ok($lcmu->is_member_any('icon' ));      # 1154
ok($lcmu->is_member_any('jerky'));      # 1155
ok(! $lcmu->is_member_any('zebra'));    # 1156

$memb_hash_ref = $lcmu->are_members_any(
    [ qw| abel baker camera delta edward fargo
          golfer hilton icon jerky zebra | ] );
ok(ok_any_h( $memb_hash_ref, 'abel',   1 ));# 1157
ok(ok_any_h( $memb_hash_ref, 'baker',  1 ));# 1158
ok(ok_any_h( $memb_hash_ref, 'camera', 1 ));# 1159
ok(ok_any_h( $memb_hash_ref, 'delta',  1 ));# 1160
ok(ok_any_h( $memb_hash_ref, 'edward', 1 ));# 1161
ok(ok_any_h( $memb_hash_ref, 'fargo',  1 ));# 1162
ok(ok_any_h( $memb_hash_ref, 'golfer', 1 ));# 1163
ok(ok_any_h( $memb_hash_ref, 'hilton', 1 ));# 1164
ok(ok_any_h( $memb_hash_ref, 'icon',   1 ));# 1165
ok(ok_any_h( $memb_hash_ref, 'jerky',  1 ));# 1166
ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));# 1167

$vers = $lcmu->get_version;
ok($vers);                              # 1168

my $lcmu_dj   = List::Compare->new(\@a0, \@a1, \@a2, \@a3, \@a4, \@a8);

ok($lcmu_dj);                           # 1169

$disj = $lcmu_dj->is_LdisjointR;
ok(! $disj);                            # 1170

$disj = $lcmu_dj->is_LdisjointR(2,3);
ok(! $disj);                            # 1171

$disj = $lcmu_dj->is_LdisjointR(4,5);
ok($disj);                              # 1172

########## BELOW:  Test for '--unsorted' option ##########

my $lcmun   = List::Compare->new('--unsorted', \@a0, \@a1, \@a2, \@a3, \@a4);

ok($lcmun);                             # 1173

########## BELOW:  Testfor bad arguments to constructor ##########

my ($lcm_bad);
my %h5 = (
    golfer   => 1,
    lambda   => 0,
);

eval { $lcm_bad = List::Compare->new('-a', \@a0, \@a1, \@a2, \@a3, \%h5) };
ok(ok_capture_error($@));               # 1174

eval { $lcm_bad = List::Compare->new('-a', \%h5, \@a0, \@a1, \@a2, \@a3) };
ok(ok_capture_error($@));               # 1175





