# 20_alt_construct_multaccel.t.raw # 8/7/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
1158;
use lib ("./t");
use List::Compare;
use Test::ListCompareSpecial qw(:seen);

$loaded = 1;
ok($loaded);                            # 1

######################### End of black magic.

my %seen = ();
my (@unique, @complement, @intersection, @union, @symmetric_difference, @bag);
my ($unique_ref, $complement_ref, $intersection_ref, $union_ref, $symmetric_difference_ref, $bag_ref);
my ($LR, $RL, $eqv, $return);
my (@nonintersection, @shared);
my ($nonintersection_ref, @shared_ref);
my ($memb_hash_ref, $memb_arr_ref, @memb_arr);

my @a0 = qw(abel abel baker camera delta edward fargo golfer);
my @a1 = qw(baker camera delta delta edward fargo golfer hilton);
my @a2 = qw(fargo golfer hilton icon icon jerky);
my @a3 = qw(fargo golfer hilton icon icon);
my @a4 = qw(fargo fargo golfer hilton icon);
my @a8 = qw(kappa lambda mu);

my $lcma   = List::Compare->new( { accelerated => 1, lists => [\@a0, \@a1, \@a2, \@a3, \@a4] } );

ok($lcma);                              # 2

@union = $lcma->get_union;
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

$union_ref = $lcma->get_union_ref;
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

@shared = $lcma->get_shared;
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

$shared_ref = $lcma->get_shared_ref;
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

@intersection = $lcma->get_intersection;
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

$intersection_ref = $lcma->get_intersection_ref;
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

@unique = $lcma->get_unique(2);
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

$unique_ref = $lcma->get_unique_ref(2);
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

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcma->get_Lonly(2);
}
ok($unique[-1] eq 'jerky');             # 125

$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});             # 126
ok(! exists $seen{'baker'});            # 127
ok(! exists $seen{'camera'});           # 128
ok(! exists $seen{'delta'});            # 129
ok(! exists $seen{'edward'});           # 130
ok(! exists $seen{'fargo'});            # 131
ok(! exists $seen{'golfer'});           # 132
ok(! exists $seen{'hilton'});           # 133
ok(! exists $seen{'icon'});             # 134
ok(exists $seen{'jerky'});              # 135
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcma->get_Lonly_ref(2);
}
ok(${$unique_ref}[-1] eq 'jerky');      # 136

$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});             # 137
ok(! exists $seen{'baker'});            # 138
ok(! exists $seen{'camera'});           # 139
ok(! exists $seen{'delta'});            # 140
ok(! exists $seen{'edward'});           # 141
ok(! exists $seen{'fargo'});            # 142
ok(! exists $seen{'golfer'});           # 143
ok(! exists $seen{'hilton'});           # 144
ok(! exists $seen{'icon'});             # 145
ok(exists $seen{'jerky'});              # 146
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcma->get_Aonly(2);
}
ok($unique[-1] eq 'jerky');             # 147

$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});             # 148
ok(! exists $seen{'baker'});            # 149
ok(! exists $seen{'camera'});           # 150
ok(! exists $seen{'delta'});            # 151
ok(! exists $seen{'edward'});           # 152
ok(! exists $seen{'fargo'});            # 153
ok(! exists $seen{'golfer'});           # 154
ok(! exists $seen{'hilton'});           # 155
ok(! exists $seen{'icon'});             # 156
ok(exists $seen{'jerky'});              # 157
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcma->get_Aonly_ref(2);
}
ok(${$unique_ref}[-1] eq 'jerky');      # 158

$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});             # 159
ok(! exists $seen{'baker'});            # 160
ok(! exists $seen{'camera'});           # 161
ok(! exists $seen{'delta'});            # 162
ok(! exists $seen{'edward'});           # 163
ok(! exists $seen{'fargo'});            # 164
ok(! exists $seen{'golfer'});           # 165
ok(! exists $seen{'hilton'});           # 166
ok(! exists $seen{'icon'});             # 167
ok(exists $seen{'jerky'});              # 168
%seen = ();

@unique = $lcma->get_unique;
ok($unique[-1] eq 'abel');              # 169

$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 170
ok(! exists $seen{'baker'});            # 171
ok(! exists $seen{'camera'});           # 172
ok(! exists $seen{'delta'});            # 173
ok(! exists $seen{'edward'});           # 174
ok(! exists $seen{'fargo'});            # 175
ok(! exists $seen{'golfer'});           # 176
ok(! exists $seen{'hilton'});           # 177
ok(! exists $seen{'icon'});             # 178
ok(! exists $seen{'jerky'});            # 179
%seen = ();

$unique_ref = $lcma->get_unique_ref;
ok(${$unique_ref}[-1] eq 'abel');       # 180

$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 181
ok(! exists $seen{'baker'});            # 182
ok(! exists $seen{'camera'});           # 183
ok(! exists $seen{'delta'});            # 184
ok(! exists $seen{'edward'});           # 185
ok(! exists $seen{'fargo'});            # 186
ok(! exists $seen{'golfer'});           # 187
ok(! exists $seen{'hilton'});           # 188
ok(! exists $seen{'icon'});             # 189
ok(! exists $seen{'jerky'});            # 190
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcma->get_Lonly;
}
ok($unique[-1] eq 'abel');              # 191

$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 192
ok(! exists $seen{'baker'});            # 193
ok(! exists $seen{'camera'});           # 194
ok(! exists $seen{'delta'});            # 195
ok(! exists $seen{'edward'});           # 196
ok(! exists $seen{'fargo'});            # 197
ok(! exists $seen{'golfer'});           # 198
ok(! exists $seen{'hilton'});           # 199
ok(! exists $seen{'icon'});             # 200
ok(! exists $seen{'jerky'});            # 201
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcma->get_Lonly_ref;
}
ok(${$unique_ref}[-1] eq 'abel');       # 202

$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 203
ok(! exists $seen{'baker'});            # 204
ok(! exists $seen{'camera'});           # 205
ok(! exists $seen{'delta'});            # 206
ok(! exists $seen{'edward'});           # 207
ok(! exists $seen{'fargo'});            # 208
ok(! exists $seen{'golfer'});           # 209
ok(! exists $seen{'hilton'});           # 210
ok(! exists $seen{'icon'});             # 211
ok(! exists $seen{'jerky'});            # 212
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcma->get_Aonly;
}
ok($unique[-1] eq 'abel');              # 213

$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 214
ok(! exists $seen{'baker'});            # 215
ok(! exists $seen{'camera'});           # 216
ok(! exists $seen{'delta'});            # 217
ok(! exists $seen{'edward'});           # 218
ok(! exists $seen{'fargo'});            # 219
ok(! exists $seen{'golfer'});           # 220
ok(! exists $seen{'hilton'});           # 221
ok(! exists $seen{'icon'});             # 222
ok(! exists $seen{'jerky'});            # 223
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcma->get_Aonly_ref;
}
ok(${$unique_ref}[-1] eq 'abel');       # 224

$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 225
ok(! exists $seen{'baker'});            # 226
ok(! exists $seen{'camera'});           # 227
ok(! exists $seen{'delta'});            # 228
ok(! exists $seen{'edward'});           # 229
ok(! exists $seen{'fargo'});            # 230
ok(! exists $seen{'golfer'});           # 231
ok(! exists $seen{'hilton'});           # 232
ok(! exists $seen{'icon'});             # 233
ok(! exists $seen{'jerky'});            # 234
%seen = ();

@complement = $lcma->get_complement(1);
ok($complement[0] eq 'abel');           # 235
ok($complement[1] eq 'icon');           # 236
ok($complement[-1] eq 'jerky');         # 237

$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 238
ok(! exists $seen{'baker'});            # 239
ok(! exists $seen{'camera'});           # 240
ok(! exists $seen{'delta'});            # 241
ok(! exists $seen{'edward'});           # 242
ok(! exists $seen{'fargo'});            # 243
ok(! exists $seen{'golfer'});           # 244
ok(! exists $seen{'hilton'});           # 245
ok(exists $seen{'icon'});               # 246
ok(exists $seen{'jerky'});              # 247
%seen = ();

$complement_ref = $lcma->get_complement_ref(1);
ok(${$complement_ref}[0] eq 'abel');    # 248
ok(${$complement_ref}[1] eq 'icon');    # 249
ok(${$complement_ref}[-1] eq 'jerky');  # 250

$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 251
ok(! exists $seen{'baker'});            # 252
ok(! exists $seen{'camera'});           # 253
ok(! exists $seen{'delta'});            # 254
ok(! exists $seen{'edward'});           # 255
ok(! exists $seen{'fargo'});            # 256
ok(! exists $seen{'golfer'});           # 257
ok(! exists $seen{'hilton'});           # 258
ok(exists $seen{'icon'});               # 259
ok(exists $seen{'jerky'});              # 260
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcma->get_Ronly(1);
}
ok($complement[0] eq 'abel');           # 261
ok($complement[1] eq 'icon');           # 262
ok($complement[-1] eq 'jerky');         # 263

$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 264
ok(! exists $seen{'baker'});            # 265
ok(! exists $seen{'camera'});           # 266
ok(! exists $seen{'delta'});            # 267
ok(! exists $seen{'edward'});           # 268
ok(! exists $seen{'fargo'});            # 269
ok(! exists $seen{'golfer'});           # 270
ok(! exists $seen{'hilton'});           # 271
ok(exists $seen{'icon'});               # 272
ok(exists $seen{'jerky'});              # 273
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcma->get_Ronly_ref(1);
}
ok(${$complement_ref}[0] eq 'abel');    # 274
ok(${$complement_ref}[1] eq 'icon');    # 275
ok(${$complement_ref}[-1] eq 'jerky');  # 276

$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 277
ok(! exists $seen{'baker'});            # 278
ok(! exists $seen{'camera'});           # 279
ok(! exists $seen{'delta'});            # 280
ok(! exists $seen{'edward'});           # 281
ok(! exists $seen{'fargo'});            # 282
ok(! exists $seen{'golfer'});           # 283
ok(! exists $seen{'hilton'});           # 284
ok(exists $seen{'icon'});               # 285
ok(exists $seen{'jerky'});              # 286
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcma->get_Bonly(1);
}
ok($complement[0] eq 'abel');           # 287
ok($complement[1] eq 'icon');           # 288
ok($complement[-1] eq 'jerky');         # 289

$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 290
ok(! exists $seen{'baker'});            # 291
ok(! exists $seen{'camera'});           # 292
ok(! exists $seen{'delta'});            # 293
ok(! exists $seen{'edward'});           # 294
ok(! exists $seen{'fargo'});            # 295
ok(! exists $seen{'golfer'});           # 296
ok(! exists $seen{'hilton'});           # 297
ok(exists $seen{'icon'});               # 298
ok(exists $seen{'jerky'});              # 299
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcma->get_Bonly_ref(1);
}
ok(${$complement_ref}[0] eq 'abel');    # 300
ok(${$complement_ref}[1] eq 'icon');    # 301
ok(${$complement_ref}[-1] eq 'jerky');  # 302

$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 303
ok(! exists $seen{'baker'});            # 304
ok(! exists $seen{'camera'});           # 305
ok(! exists $seen{'delta'});            # 306
ok(! exists $seen{'edward'});           # 307
ok(! exists $seen{'fargo'});            # 308
ok(! exists $seen{'golfer'});           # 309
ok(! exists $seen{'hilton'});           # 310
ok(exists $seen{'icon'});               # 311
ok(exists $seen{'jerky'});              # 312
%seen = ();

@complement = $lcma->get_complement;
ok($complement[0] eq 'hilton');         # 313
ok($complement[1] eq 'icon');           # 314
ok($complement[-1] eq 'jerky');         # 315

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 316
ok(! exists $seen{'baker'});            # 317
ok(! exists $seen{'camera'});           # 318
ok(! exists $seen{'delta'});            # 319
ok(! exists $seen{'edward'});           # 320
ok(! exists $seen{'fargo'});            # 321
ok(! exists $seen{'golfer'});           # 322
ok(exists $seen{'hilton'});             # 323
ok(exists $seen{'icon'});               # 324
ok(exists $seen{'jerky'});              # 325
%seen = ();

$complement_ref = $lcma->get_complement_ref;
ok(${$complement_ref}[0] eq 'hilton');  # 326
ok(${$complement_ref}[1] eq 'icon');    # 327
ok(${$complement_ref}[-1] eq 'jerky');  # 328

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 329
ok(! exists $seen{'baker'});            # 330
ok(! exists $seen{'camera'});           # 331
ok(! exists $seen{'delta'});            # 332
ok(! exists $seen{'edward'});           # 333
ok(! exists $seen{'fargo'});            # 334
ok(! exists $seen{'golfer'});           # 335
ok(exists $seen{'hilton'});             # 336
ok(exists $seen{'icon'});               # 337
ok(exists $seen{'jerky'});              # 338
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcma->get_Ronly;
}
ok($complement[0] eq 'hilton');         # 339
ok($complement[1] eq 'icon');           # 340
ok($complement[-1] eq 'jerky');         # 341

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 342
ok(! exists $seen{'baker'});            # 343
ok(! exists $seen{'camera'});           # 344
ok(! exists $seen{'delta'});            # 345
ok(! exists $seen{'edward'});           # 346
ok(! exists $seen{'fargo'});            # 347
ok(! exists $seen{'golfer'});           # 348
ok(exists $seen{'hilton'});             # 349
ok(exists $seen{'icon'});               # 350
ok(exists $seen{'jerky'});              # 351
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcma->get_Ronly_ref;
}
ok(${$complement_ref}[0] eq 'hilton');  # 352
ok(${$complement_ref}[1] eq 'icon');    # 353
ok(${$complement_ref}[-1] eq 'jerky');  # 354

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 355
ok(! exists $seen{'baker'});            # 356
ok(! exists $seen{'camera'});           # 357
ok(! exists $seen{'delta'});            # 358
ok(! exists $seen{'edward'});           # 359
ok(! exists $seen{'fargo'});            # 360
ok(! exists $seen{'golfer'});           # 361
ok(exists $seen{'hilton'});             # 362
ok(exists $seen{'icon'});               # 363
ok(exists $seen{'jerky'});              # 364
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcma->get_Bonly;
}
ok($complement[0] eq 'hilton');         # 365
ok($complement[1] eq 'icon');           # 366
ok($complement[-1] eq 'jerky');         # 367

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 368
ok(! exists $seen{'baker'});            # 369
ok(! exists $seen{'camera'});           # 370
ok(! exists $seen{'delta'});            # 371
ok(! exists $seen{'edward'});           # 372
ok(! exists $seen{'fargo'});            # 373
ok(! exists $seen{'golfer'});           # 374
ok(exists $seen{'hilton'});             # 375
ok(exists $seen{'icon'});               # 376
ok(exists $seen{'jerky'});              # 377
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcma->get_Bonly_ref;
}
ok(${$complement_ref}[0] eq 'hilton');  # 378
ok(${$complement_ref}[1] eq 'icon');    # 379
ok(${$complement_ref}[-1] eq 'jerky');  # 380

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 381
ok(! exists $seen{'baker'});            # 382
ok(! exists $seen{'camera'});           # 383
ok(! exists $seen{'delta'});            # 384
ok(! exists $seen{'edward'});           # 385
ok(! exists $seen{'fargo'});            # 386
ok(! exists $seen{'golfer'});           # 387
ok(exists $seen{'hilton'});             # 388
ok(exists $seen{'icon'});               # 389
ok(exists $seen{'jerky'});              # 390
%seen = ();

@symmetric_difference = $lcma->get_symmetric_difference;
ok($symmetric_difference[0] eq 'abel'); # 391
ok($symmetric_difference[-1] eq 'jerky');# 392

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 393
ok(! exists $seen{'baker'});            # 394
ok(! exists $seen{'camera'});           # 395
ok(! exists $seen{'delta'});            # 396
ok(! exists $seen{'edward'});           # 397
ok(! exists $seen{'fargo'});            # 398
ok(! exists $seen{'golfer'});           # 399
ok(! exists $seen{'hilton'});           # 400
ok(! exists $seen{'icon'});             # 401
ok(exists $seen{'jerky'});              # 402
%seen = ();

$symmetric_difference_ref = $lcma->get_symmetric_difference_ref;
ok(${$symmetric_difference_ref}[0] eq 'abel');# 403
ok(${$symmetric_difference_ref}[-1] eq 'jerky');# 404

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 405
ok(! exists $seen{'baker'});            # 406
ok(! exists $seen{'camera'});           # 407
ok(! exists $seen{'delta'});            # 408
ok(! exists $seen{'edward'});           # 409
ok(! exists $seen{'fargo'});            # 410
ok(! exists $seen{'golfer'});           # 411
ok(! exists $seen{'hilton'});           # 412
ok(! exists $seen{'icon'});             # 413
ok(exists $seen{'jerky'});              # 414
%seen = ();

@symmetric_difference = $lcma->get_symdiff;
ok($symmetric_difference[0] eq 'abel'); # 415
ok($symmetric_difference[-1] eq 'jerky');# 416

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 417
ok(! exists $seen{'baker'});            # 418
ok(! exists $seen{'camera'});           # 419
ok(! exists $seen{'delta'});            # 420
ok(! exists $seen{'edward'});           # 421
ok(! exists $seen{'fargo'});            # 422
ok(! exists $seen{'golfer'});           # 423
ok(! exists $seen{'hilton'});           # 424
ok(! exists $seen{'icon'});             # 425
ok(exists $seen{'jerky'});              # 426
%seen = ();

$symmetric_difference_ref = $lcma->get_symdiff_ref;
ok(${$symmetric_difference_ref}[0] eq 'abel');# 427
ok(${$symmetric_difference_ref}[-1] eq 'jerky');# 428

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 429
ok(! exists $seen{'baker'});            # 430
ok(! exists $seen{'camera'});           # 431
ok(! exists $seen{'delta'});            # 432
ok(! exists $seen{'edward'});           # 433
ok(! exists $seen{'fargo'});            # 434
ok(! exists $seen{'golfer'});           # 435
ok(! exists $seen{'hilton'});           # 436
ok(! exists $seen{'icon'});             # 437
ok(exists $seen{'jerky'});              # 438
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @symmetric_difference = $lcma->get_LorRonly;
}
ok($symmetric_difference[0] eq 'abel'); # 439
ok($symmetric_difference[-1] eq 'jerky');# 440

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 441
ok(! exists $seen{'baker'});            # 442
ok(! exists $seen{'camera'});           # 443
ok(! exists $seen{'delta'});            # 444
ok(! exists $seen{'edward'});           # 445
ok(! exists $seen{'fargo'});            # 446
ok(! exists $seen{'golfer'});           # 447
ok(! exists $seen{'hilton'});           # 448
ok(! exists $seen{'icon'});             # 449
ok(exists $seen{'jerky'});              # 450
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $symmetric_difference_ref = $lcma->get_LorRonly_ref;
}
ok(${$symmetric_difference_ref}[0] eq 'abel');# 451
ok(${$symmetric_difference_ref}[-1] eq 'jerky');# 452

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 453
ok(! exists $seen{'baker'});            # 454
ok(! exists $seen{'camera'});           # 455
ok(! exists $seen{'delta'});            # 456
ok(! exists $seen{'edward'});           # 457
ok(! exists $seen{'fargo'});            # 458
ok(! exists $seen{'golfer'});           # 459
ok(! exists $seen{'hilton'});           # 460
ok(! exists $seen{'icon'});             # 461
ok(exists $seen{'jerky'});              # 462
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @symmetric_difference = $lcma->get_AorBonly;
}
ok($symmetric_difference[0] eq 'abel'); # 463
ok($symmetric_difference[-1] eq 'jerky');# 464

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 465
ok(! exists $seen{'baker'});            # 466
ok(! exists $seen{'camera'});           # 467
ok(! exists $seen{'delta'});            # 468
ok(! exists $seen{'edward'});           # 469
ok(! exists $seen{'fargo'});            # 470
ok(! exists $seen{'golfer'});           # 471
ok(! exists $seen{'hilton'});           # 472
ok(! exists $seen{'icon'});             # 473
ok(exists $seen{'jerky'});              # 474
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $symmetric_difference_ref = $lcma->get_AorBonly_ref;
}
ok(${$symmetric_difference_ref}[0] eq 'abel');# 475
ok(${$symmetric_difference_ref}[-1] eq 'jerky');# 476

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 477
ok(! exists $seen{'baker'});            # 478
ok(! exists $seen{'camera'});           # 479
ok(! exists $seen{'delta'});            # 480
ok(! exists $seen{'edward'});           # 481
ok(! exists $seen{'fargo'});            # 482
ok(! exists $seen{'golfer'});           # 483
ok(! exists $seen{'hilton'});           # 484
ok(! exists $seen{'icon'});             # 485
ok(exists $seen{'jerky'});              # 486
%seen = ();

@nonintersection = $lcma->get_nonintersection;
ok($nonintersection[0] eq 'abel');      # 487
ok($nonintersection[1] eq 'baker');     # 488
ok($nonintersection[2] eq 'camera');    # 489
ok($nonintersection[3] eq 'delta');     # 490
ok($nonintersection[4] eq 'edward');    # 491
ok($nonintersection[5] eq 'hilton');    # 492
ok($nonintersection[6] eq 'icon');      # 493
ok($nonintersection[-1] eq 'jerky');    # 494

$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 495
ok(exists $seen{'baker'});              # 496
ok(exists $seen{'camera'});             # 497
ok(exists $seen{'delta'});              # 498
ok(exists $seen{'edward'});             # 499
ok(! exists $seen{'fargo'});            # 500
ok(! exists $seen{'golfer'});           # 501
ok(exists $seen{'hilton'});             # 502
ok(exists $seen{'icon'});               # 503
ok(exists $seen{'jerky'});              # 504
%seen = ();

$nonintersection_ref = $lcma->get_nonintersection_ref;
ok(${$nonintersection_ref}[0] eq 'abel');# 505
ok(${$nonintersection_ref}[1] eq 'baker');# 506
ok(${$nonintersection_ref}[2] eq 'camera');# 507
ok(${$nonintersection_ref}[3] eq 'delta');# 508
ok(${$nonintersection_ref}[4] eq 'edward');# 509
ok(${$nonintersection_ref}[5] eq 'hilton');# 510
ok(${$nonintersection_ref}[6] eq 'icon');# 511
ok(${$nonintersection_ref}[-1] eq 'jerky');# 512

$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 513
ok(exists $seen{'baker'});              # 514
ok(exists $seen{'camera'});             # 515
ok(exists $seen{'delta'});              # 516
ok(exists $seen{'edward'});             # 517
ok(! exists $seen{'fargo'});            # 518
ok(! exists $seen{'golfer'});           # 519
ok(exists $seen{'hilton'});             # 520
ok(exists $seen{'icon'});               # 521
ok(exists $seen{'jerky'});              # 522
%seen = ();

@bag = $lcma->get_bag;
ok($bag[0] eq 'abel');                  # 523
ok($bag[1] eq 'abel');                  # 524
ok($bag[2] eq 'baker');                 # 525
ok($bag[3] eq 'baker');                 # 526
ok($bag[4] eq 'camera');                # 527
ok($bag[5] eq 'camera');                # 528
ok($bag[6] eq 'delta');                 # 529
ok($bag[7] eq 'delta');                 # 530
ok($bag[8] eq 'delta');                 # 531
ok($bag[9] eq 'edward');                # 532
ok($bag[10] eq 'edward');               # 533
ok($bag[11] eq 'fargo');                # 534
ok($bag[12] eq 'fargo');                # 535
ok($bag[13] eq 'fargo');                # 536
ok($bag[14] eq 'fargo');                # 537
ok($bag[15] eq 'fargo');                # 538
ok($bag[16] eq 'fargo');                # 539
ok($bag[17] eq 'golfer');               # 540
ok($bag[18] eq 'golfer');               # 541
ok($bag[19] eq 'golfer');               # 542
ok($bag[20] eq 'golfer');               # 543
ok($bag[21] eq 'golfer');               # 544
ok($bag[22] eq 'hilton');               # 545
ok($bag[23] eq 'hilton');               # 546
ok($bag[24] eq 'hilton');               # 547
ok($bag[25] eq 'hilton');               # 548
ok($bag[26] eq 'icon');                 # 549
ok($bag[27] eq 'icon');                 # 550
ok($bag[28] eq 'icon');                 # 551
ok($bag[29] eq 'icon');                 # 552
ok($bag[30] eq 'icon');                 # 553
ok($bag[-1] eq 'jerky');                # 554

$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 555
ok($seen{'baker'} == 2);                # 556
ok($seen{'camera'} == 2);               # 557
ok($seen{'delta'} == 3);                # 558
ok($seen{'edward'} == 2);               # 559
ok($seen{'fargo'} == 6);                # 560
ok($seen{'golfer'} == 5);               # 561
ok($seen{'hilton'} == 4);               # 562
ok($seen{'icon'} == 5);                 # 563
ok($seen{'jerky'} == 1);                # 564
%seen = ();

$bag_ref = $lcma->get_bag_ref;
ok(${$bag_ref}[0] eq 'abel');           # 565
ok(${$bag_ref}[1] eq 'abel');           # 566
ok(${$bag_ref}[2] eq 'baker');          # 567
ok(${$bag_ref}[3] eq 'baker');          # 568
ok(${$bag_ref}[4] eq 'camera');         # 569
ok(${$bag_ref}[5] eq 'camera');         # 570
ok(${$bag_ref}[6] eq 'delta');          # 571
ok(${$bag_ref}[7] eq 'delta');          # 572
ok(${$bag_ref}[8] eq 'delta');          # 573
ok(${$bag_ref}[9] eq 'edward');         # 574
ok(${$bag_ref}[10] eq 'edward');        # 575
ok(${$bag_ref}[11] eq 'fargo');         # 576
ok(${$bag_ref}[12] eq 'fargo');         # 577
ok(${$bag_ref}[13] eq 'fargo');         # 578
ok(${$bag_ref}[14] eq 'fargo');         # 579
ok(${$bag_ref}[15] eq 'fargo');         # 580
ok(${$bag_ref}[16] eq 'fargo');         # 581
ok(${$bag_ref}[17] eq 'golfer');        # 582
ok(${$bag_ref}[18] eq 'golfer');        # 583
ok(${$bag_ref}[19] eq 'golfer');        # 584
ok(${$bag_ref}[20] eq 'golfer');        # 585
ok(${$bag_ref}[21] eq 'golfer');        # 586
ok(${$bag_ref}[22] eq 'hilton');        # 587
ok(${$bag_ref}[23] eq 'hilton');        # 588
ok(${$bag_ref}[24] eq 'hilton');        # 589
ok(${$bag_ref}[25] eq 'hilton');        # 590
ok(${$bag_ref}[26] eq 'icon');          # 591
ok(${$bag_ref}[27] eq 'icon');          # 592
ok(${$bag_ref}[28] eq 'icon');          # 593
ok(${$bag_ref}[29] eq 'icon');          # 594
ok(${$bag_ref}[30] eq 'icon');          # 595
ok(${$bag_ref}[-1] eq 'jerky');         # 596

$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 597
ok($seen{'baker'} == 2);                # 598
ok($seen{'camera'} == 2);               # 599
ok($seen{'delta'} == 3);                # 600
ok($seen{'edward'} == 2);               # 601
ok($seen{'fargo'} == 6);                # 602
ok($seen{'golfer'} == 5);               # 603
ok($seen{'hilton'} == 4);               # 604
ok($seen{'icon'} == 5);                 # 605
ok($seen{'jerky'} == 1);                # 606
%seen = ();

$LR = $lcma->is_LsubsetR(3,2);
ok($LR);                                # 607

$LR = $lcma->is_AsubsetB(3,2);
ok($LR);                                # 608

$LR = $lcma->is_LsubsetR(2,3);
ok(! $LR);                              # 609

$LR = $lcma->is_AsubsetB(2,3);
ok(! $LR);                              # 610

$LR = $lcma->is_LsubsetR;
ok(! $LR);                              # 611

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcma->is_RsubsetL;
}
ok(! $RL);                              # 612

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcma->is_BsubsetA;
}
ok(! $RL);                              # 613

$eqv = $lcma->is_LequivalentR(3,4);
ok($eqv);                               # 614

$eqv = $lcma->is_LeqvlntR(3,4);
ok($eqv);                               # 615

$eqv = $lcma->is_LequivalentR(2,4);
ok(! $eqv);                             # 616

$return = $lcma->print_subset_chart;
ok($return);                            # 617

$return = $lcma->print_equivalence_chart;
ok($return);                            # 618

@memb_arr = $lcma->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0        > ] ));# 619

@memb_arr = $lcma->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1      > ] ));# 620

@memb_arr = $lcma->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1      > ] ));# 621

@memb_arr = $lcma->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1      > ] ));# 622

@memb_arr = $lcma->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1      > ] ));# 623

@memb_arr = $lcma->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 624

@memb_arr = $lcma->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 625

@memb_arr = $lcma->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 626

@memb_arr = $lcma->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   3, [ qw<     2 3 4 > ] ));# 627

@memb_arr = $lcma->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  1, [ qw<     2     > ] ));# 628

@memb_arr = $lcma->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<           > ] ));# 629

$memb_arr_ref = $lcma->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0        > ] ));# 630

$memb_arr_ref = $lcma->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1      > ] ));# 631

$memb_arr_ref = $lcma->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1      > ] ));# 632

$memb_arr_ref = $lcma->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1      > ] ));# 633

$memb_arr_ref = $lcma->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1      > ] ));# 634

$memb_arr_ref = $lcma->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 635

$memb_arr_ref = $lcma->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 636

$memb_arr_ref = $lcma->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 637

$memb_arr_ref = $lcma->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   3, [ qw<     2 3 4 > ] ));# 638

$memb_arr_ref = $lcma->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  1, [ qw<     2     > ] ));# 639

$memb_arr_ref = $lcma->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<           > ] ));# 640

$memb_hash_ref = $lcma->are_members_which(
                     [ qw| abel baker camera delta edward fargo 
                           golfer hilton icon jerky zebra | ] );
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0         > ] ));# 641
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1       > ] ));# 642
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1       > ] ));# 643
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1       > ] ));# 644
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1       > ] ));# 645
ok(ok_seen_h( $memb_hash_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 646
ok(ok_seen_h( $memb_hash_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 647
ok(ok_seen_h( $memb_hash_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 648
ok(ok_seen_h( $memb_hash_ref, 'icon',   3, [ qw<     2 3 4 > ] ));# 649
ok(ok_seen_h( $memb_hash_ref, 'jerky',  1, [ qw<     2     > ] ));# 650
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<           > ] ));# 651

ok($lcma->is_member_any('abel'));       # 652
ok($lcma->is_member_any('baker'));      # 653
ok($lcma->is_member_any('camera'));     # 654
ok($lcma->is_member_any('delta'));      # 655
ok($lcma->is_member_any('edward'));     # 656
ok($lcma->is_member_any('fargo'));      # 657
ok($lcma->is_member_any('golfer'));     # 658
ok($lcma->is_member_any('hilton'));     # 659
ok($lcma->is_member_any('icon' ));      # 660
ok($lcma->is_member_any('jerky'));      # 661
ok(! $lcma->is_member_any('zebra'));    # 662

$memb_hash_ref = $lcma->are_members_any(
                     [ qw| abel baker camera delta edward fargo 
                           golfer hilton icon jerky zebra | ] );
ok(ok_any_h( $memb_hash_ref, 'abel',   1 ));# 663
ok(ok_any_h( $memb_hash_ref, 'baker',  1 ));# 664
ok(ok_any_h( $memb_hash_ref, 'camera', 1 ));# 665
ok(ok_any_h( $memb_hash_ref, 'delta',  1 ));# 666
ok(ok_any_h( $memb_hash_ref, 'edward', 1 ));# 667
ok(ok_any_h( $memb_hash_ref, 'fargo',  1 ));# 668
ok(ok_any_h( $memb_hash_ref, 'golfer', 1 ));# 669
ok(ok_any_h( $memb_hash_ref, 'hilton', 1 ));# 670
ok(ok_any_h( $memb_hash_ref, 'icon',   1 ));# 671
ok(ok_any_h( $memb_hash_ref, 'jerky',  1 ));# 672
ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));# 673

$vers = $lcma->get_version;
ok($vers);                              # 674

my $lcma_dj   = List::Compare->new( { accelerated => 1, lists => [\@a0, \@a1, \@a2, \@a3, \@a4, \@a8] } );

ok($lcma_dj);                           # 675

$disj = $lcma_dj->is_LdisjointR;
ok(! $disj);                            # 676

$disj = $lcma_dj->is_LdisjointR(2,3);
ok(! $disj);                            # 677

$disj = $lcma_dj->is_LdisjointR(4,5);
ok($disj);                              # 678

########## BELOW:  Tests for '-u' option ##########

my $lcmau   = List::Compare->new( { unsorted => 1, accelerated => 1, lists => [\@a0, \@a1, \@a2, \@a3, \@a4] } );

ok($lcmau);                             # 679

@union = $lcmau->get_union;
$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});               # 680
ok(exists $seen{'baker'});              # 681
ok(exists $seen{'camera'});             # 682
ok(exists $seen{'delta'});              # 683
ok(exists $seen{'edward'});             # 684
ok(exists $seen{'fargo'});              # 685
ok(exists $seen{'golfer'});             # 686
ok(exists $seen{'hilton'});             # 687
ok(exists $seen{'icon'});               # 688
ok(exists $seen{'jerky'});              # 689
%seen = ();

$union_ref = $lcmau->get_union_ref;
$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});               # 690
ok(exists $seen{'baker'});              # 691
ok(exists $seen{'camera'});             # 692
ok(exists $seen{'delta'});              # 693
ok(exists $seen{'edward'});             # 694
ok(exists $seen{'fargo'});              # 695
ok(exists $seen{'golfer'});             # 696
ok(exists $seen{'hilton'});             # 697
ok(exists $seen{'icon'});               # 698
ok(exists $seen{'jerky'});              # 699
%seen = ();

@shared = $lcmau->get_shared;
$seen{$_}++ foreach (@shared);
ok(! exists $seen{'abel'});             # 700
ok(exists $seen{'baker'});              # 701
ok(exists $seen{'camera'});             # 702
ok(exists $seen{'delta'});              # 703
ok(exists $seen{'edward'});             # 704
ok(exists $seen{'fargo'});              # 705
ok(exists $seen{'golfer'});             # 706
ok(exists $seen{'hilton'});             # 707
ok(exists $seen{'icon'});               # 708
ok(! exists $seen{'jerky'});            # 709
%seen = ();

$shared_ref = $lcmau->get_shared_ref;
$seen{$_}++ foreach (@{$shared_ref});
ok(! exists $seen{'abel'});             # 710
ok(exists $seen{'baker'});              # 711
ok(exists $seen{'camera'});             # 712
ok(exists $seen{'delta'});              # 713
ok(exists $seen{'edward'});             # 714
ok(exists $seen{'fargo'});              # 715
ok(exists $seen{'golfer'});             # 716
ok(exists $seen{'hilton'});             # 717
ok(exists $seen{'icon'});               # 718
ok(! exists $seen{'jerky'});            # 719
%seen = ();

@intersection = $lcmau->get_intersection;
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 720
ok(! exists $seen{'baker'});            # 721
ok(! exists $seen{'camera'});           # 722
ok(! exists $seen{'delta'});            # 723
ok(! exists $seen{'edward'});           # 724
ok(exists $seen{'fargo'});              # 725
ok(exists $seen{'golfer'});             # 726
ok(! exists $seen{'hilton'});           # 727
ok(! exists $seen{'icon'});             # 728
ok(! exists $seen{'jerky'});            # 729
%seen = ();

$intersection_ref = $lcmau->get_intersection_ref;
$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});             # 730
ok(! exists $seen{'baker'});            # 731
ok(! exists $seen{'camera'});           # 732
ok(! exists $seen{'delta'});            # 733
ok(! exists $seen{'edward'});           # 734
ok(exists $seen{'fargo'});              # 735
ok(exists $seen{'golfer'});             # 736
ok(! exists $seen{'hilton'});           # 737
ok(! exists $seen{'icon'});             # 738
ok(! exists $seen{'jerky'});            # 739
%seen = ();

@unique = $lcmau->get_unique(2);
$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});             # 740
ok(! exists $seen{'baker'});            # 741
ok(! exists $seen{'camera'});           # 742
ok(! exists $seen{'delta'});            # 743
ok(! exists $seen{'edward'});           # 744
ok(! exists $seen{'fargo'});            # 745
ok(! exists $seen{'golfer'});           # 746
ok(! exists $seen{'hilton'});           # 747
ok(! exists $seen{'icon'});             # 748
ok(exists $seen{'jerky'});              # 749
%seen = ();

$unique_ref = $lcmau->get_unique_ref(2);
$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});             # 750
ok(! exists $seen{'baker'});            # 751
ok(! exists $seen{'camera'});           # 752
ok(! exists $seen{'delta'});            # 753
ok(! exists $seen{'edward'});           # 754
ok(! exists $seen{'fargo'});            # 755
ok(! exists $seen{'golfer'});           # 756
ok(! exists $seen{'hilton'});           # 757
ok(! exists $seen{'icon'});             # 758
ok(exists $seen{'jerky'});              # 759
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmau->get_Lonly_ref(2);
}
$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});             # 760
ok(! exists $seen{'baker'});            # 761
ok(! exists $seen{'camera'});           # 762
ok(! exists $seen{'delta'});            # 763
ok(! exists $seen{'edward'});           # 764
ok(! exists $seen{'fargo'});            # 765
ok(! exists $seen{'golfer'});           # 766
ok(! exists $seen{'hilton'});           # 767
ok(! exists $seen{'icon'});             # 768
ok(exists $seen{'jerky'});              # 769
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcmau->get_Aonly(2);
}
$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});             # 770
ok(! exists $seen{'baker'});            # 771
ok(! exists $seen{'camera'});           # 772
ok(! exists $seen{'delta'});            # 773
ok(! exists $seen{'edward'});           # 774
ok(! exists $seen{'fargo'});            # 775
ok(! exists $seen{'golfer'});           # 776
ok(! exists $seen{'hilton'});           # 777
ok(! exists $seen{'icon'});             # 778
ok(exists $seen{'jerky'});              # 779
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmau->get_Aonly_ref(2);
}
$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});             # 780
ok(! exists $seen{'baker'});            # 781
ok(! exists $seen{'camera'});           # 782
ok(! exists $seen{'delta'});            # 783
ok(! exists $seen{'edward'});           # 784
ok(! exists $seen{'fargo'});            # 785
ok(! exists $seen{'golfer'});           # 786
ok(! exists $seen{'hilton'});           # 787
ok(! exists $seen{'icon'});             # 788
ok(exists $seen{'jerky'});              # 789
%seen = ();

@unique = $lcmau->get_unique;
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 790
ok(! exists $seen{'baker'});            # 791
ok(! exists $seen{'camera'});           # 792
ok(! exists $seen{'delta'});            # 793
ok(! exists $seen{'edward'});           # 794
ok(! exists $seen{'fargo'});            # 795
ok(! exists $seen{'golfer'});           # 796
ok(! exists $seen{'hilton'});           # 797
ok(! exists $seen{'icon'});             # 798
ok(! exists $seen{'jerky'});            # 799
%seen = ();

$unique_ref = $lcmau->get_unique_ref;
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 800
ok(! exists $seen{'baker'});            # 801
ok(! exists $seen{'camera'});           # 802
ok(! exists $seen{'delta'});            # 803
ok(! exists $seen{'edward'});           # 804
ok(! exists $seen{'fargo'});            # 805
ok(! exists $seen{'golfer'});           # 806
ok(! exists $seen{'hilton'});           # 807
ok(! exists $seen{'icon'});             # 808
ok(! exists $seen{'jerky'});            # 809
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcmau->get_Lonly;
}
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 810
ok(! exists $seen{'baker'});            # 811
ok(! exists $seen{'camera'});           # 812
ok(! exists $seen{'delta'});            # 813
ok(! exists $seen{'edward'});           # 814
ok(! exists $seen{'fargo'});            # 815
ok(! exists $seen{'golfer'});           # 816
ok(! exists $seen{'hilton'});           # 817
ok(! exists $seen{'icon'});             # 818
ok(! exists $seen{'jerky'});            # 819
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmau->get_Lonly_ref;
}
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 820
ok(! exists $seen{'baker'});            # 821
ok(! exists $seen{'camera'});           # 822
ok(! exists $seen{'delta'});            # 823
ok(! exists $seen{'edward'});           # 824
ok(! exists $seen{'fargo'});            # 825
ok(! exists $seen{'golfer'});           # 826
ok(! exists $seen{'hilton'});           # 827
ok(! exists $seen{'icon'});             # 828
ok(! exists $seen{'jerky'});            # 829
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcmau->get_Aonly;
}
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 830
ok(! exists $seen{'baker'});            # 831
ok(! exists $seen{'camera'});           # 832
ok(! exists $seen{'delta'});            # 833
ok(! exists $seen{'edward'});           # 834
ok(! exists $seen{'fargo'});            # 835
ok(! exists $seen{'golfer'});           # 836
ok(! exists $seen{'hilton'});           # 837
ok(! exists $seen{'icon'});             # 838
ok(! exists $seen{'jerky'});            # 839
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmau->get_Aonly_ref;
}
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 840
ok(! exists $seen{'baker'});            # 841
ok(! exists $seen{'camera'});           # 842
ok(! exists $seen{'delta'});            # 843
ok(! exists $seen{'edward'});           # 844
ok(! exists $seen{'fargo'});            # 845
ok(! exists $seen{'golfer'});           # 846
ok(! exists $seen{'hilton'});           # 847
ok(! exists $seen{'icon'});             # 848
ok(! exists $seen{'jerky'});            # 849
%seen = ();

@complement = $lcmau->get_complement(1);
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 850
ok(! exists $seen{'baker'});            # 851
ok(! exists $seen{'camera'});           # 852
ok(! exists $seen{'delta'});            # 853
ok(! exists $seen{'edward'});           # 854
ok(! exists $seen{'fargo'});            # 855
ok(! exists $seen{'golfer'});           # 856
ok(! exists $seen{'hilton'});           # 857
ok(exists $seen{'icon'});               # 858
ok(exists $seen{'jerky'});              # 859
%seen = ();

$complement_ref = $lcmau->get_complement_ref(1);
$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 860
ok(! exists $seen{'baker'});            # 861
ok(! exists $seen{'camera'});           # 862
ok(! exists $seen{'delta'});            # 863
ok(! exists $seen{'edward'});           # 864
ok(! exists $seen{'fargo'});            # 865
ok(! exists $seen{'golfer'});           # 866
ok(! exists $seen{'hilton'});           # 867
ok(exists $seen{'icon'});               # 868
ok(exists $seen{'jerky'});              # 869
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmau->get_Ronly(1);
}
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 870
ok(! exists $seen{'baker'});            # 871
ok(! exists $seen{'camera'});           # 872
ok(! exists $seen{'delta'});            # 873
ok(! exists $seen{'edward'});           # 874
ok(! exists $seen{'fargo'});            # 875
ok(! exists $seen{'golfer'});           # 876
ok(! exists $seen{'hilton'});           # 877
ok(exists $seen{'icon'});               # 878
ok(exists $seen{'jerky'});              # 879
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmau->get_Ronly_ref(1);
}
$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 880
ok(! exists $seen{'baker'});            # 881
ok(! exists $seen{'camera'});           # 882
ok(! exists $seen{'delta'});            # 883
ok(! exists $seen{'edward'});           # 884
ok(! exists $seen{'fargo'});            # 885
ok(! exists $seen{'golfer'});           # 886
ok(! exists $seen{'hilton'});           # 887
ok(exists $seen{'icon'});               # 888
ok(exists $seen{'jerky'});              # 889
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmau->get_Bonly(1);
}
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 890
ok(! exists $seen{'baker'});            # 891
ok(! exists $seen{'camera'});           # 892
ok(! exists $seen{'delta'});            # 893
ok(! exists $seen{'edward'});           # 894
ok(! exists $seen{'fargo'});            # 895
ok(! exists $seen{'golfer'});           # 896
ok(! exists $seen{'hilton'});           # 897
ok(exists $seen{'icon'});               # 898
ok(exists $seen{'jerky'});              # 899
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmau->get_Bonly_ref(1);
}
$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 900
ok(! exists $seen{'baker'});            # 901
ok(! exists $seen{'camera'});           # 902
ok(! exists $seen{'delta'});            # 903
ok(! exists $seen{'edward'});           # 904
ok(! exists $seen{'fargo'});            # 905
ok(! exists $seen{'golfer'});           # 906
ok(! exists $seen{'hilton'});           # 907
ok(exists $seen{'icon'});               # 908
ok(exists $seen{'jerky'});              # 909
%seen = ();

@complement = $lcmau->get_complement;
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 910
ok(! exists $seen{'baker'});            # 911
ok(! exists $seen{'camera'});           # 912
ok(! exists $seen{'delta'});            # 913
ok(! exists $seen{'edward'});           # 914
ok(! exists $seen{'fargo'});            # 915
ok(! exists $seen{'golfer'});           # 916
ok(exists $seen{'hilton'});             # 917
ok(exists $seen{'icon'});               # 918
ok(exists $seen{'jerky'});              # 919
%seen = ();

$complement_ref = $lcmau->get_complement_ref;
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 920
ok(! exists $seen{'baker'});            # 921
ok(! exists $seen{'camera'});           # 922
ok(! exists $seen{'delta'});            # 923
ok(! exists $seen{'edward'});           # 924
ok(! exists $seen{'fargo'});            # 925
ok(! exists $seen{'golfer'});           # 926
ok(exists $seen{'hilton'});             # 927
ok(exists $seen{'icon'});               # 928
ok(exists $seen{'jerky'});              # 929
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmau->get_Ronly;
}
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 930
ok(! exists $seen{'baker'});            # 931
ok(! exists $seen{'camera'});           # 932
ok(! exists $seen{'delta'});            # 933
ok(! exists $seen{'edward'});           # 934
ok(! exists $seen{'fargo'});            # 935
ok(! exists $seen{'golfer'});           # 936
ok(exists $seen{'hilton'});             # 937
ok(exists $seen{'icon'});               # 938
ok(exists $seen{'jerky'});              # 939
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmau->get_Ronly_ref;
}
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 940
ok(! exists $seen{'baker'});            # 941
ok(! exists $seen{'camera'});           # 942
ok(! exists $seen{'delta'});            # 943
ok(! exists $seen{'edward'});           # 944
ok(! exists $seen{'fargo'});            # 945
ok(! exists $seen{'golfer'});           # 946
ok(exists $seen{'hilton'});             # 947
ok(exists $seen{'icon'});               # 948
ok(exists $seen{'jerky'});              # 949
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmau->get_Bonly;
}
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 950
ok(! exists $seen{'baker'});            # 951
ok(! exists $seen{'camera'});           # 952
ok(! exists $seen{'delta'});            # 953
ok(! exists $seen{'edward'});           # 954
ok(! exists $seen{'fargo'});            # 955
ok(! exists $seen{'golfer'});           # 956
ok(exists $seen{'hilton'});             # 957
ok(exists $seen{'icon'});               # 958
ok(exists $seen{'jerky'});              # 959
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmau->get_Bonly_ref;
}
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 960
ok(! exists $seen{'baker'});            # 961
ok(! exists $seen{'camera'});           # 962
ok(! exists $seen{'delta'});            # 963
ok(! exists $seen{'edward'});           # 964
ok(! exists $seen{'fargo'});            # 965
ok(! exists $seen{'golfer'});           # 966
ok(exists $seen{'hilton'});             # 967
ok(exists $seen{'icon'});               # 968
ok(exists $seen{'jerky'});              # 969
%seen = ();

@symmetric_difference = $lcmau->get_symmetric_difference;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 970
ok(! exists $seen{'baker'});            # 971
ok(! exists $seen{'camera'});           # 972
ok(! exists $seen{'delta'});            # 973
ok(! exists $seen{'edward'});           # 974
ok(! exists $seen{'fargo'});            # 975
ok(! exists $seen{'golfer'});           # 976
ok(! exists $seen{'hilton'});           # 977
ok(! exists $seen{'icon'});             # 978
ok(exists $seen{'jerky'});              # 979
%seen = ();

$symmetric_difference_ref = $lcmau->get_symmetric_difference_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 980
ok(! exists $seen{'baker'});            # 981
ok(! exists $seen{'camera'});           # 982
ok(! exists $seen{'delta'});            # 983
ok(! exists $seen{'edward'});           # 984
ok(! exists $seen{'fargo'});            # 985
ok(! exists $seen{'golfer'});           # 986
ok(! exists $seen{'hilton'});           # 987
ok(! exists $seen{'icon'});             # 988
ok(exists $seen{'jerky'});              # 989
%seen = ();

@symmetric_difference = $lcmau->get_symdiff;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 990
ok(! exists $seen{'baker'});            # 991
ok(! exists $seen{'camera'});           # 992
ok(! exists $seen{'delta'});            # 993
ok(! exists $seen{'edward'});           # 994
ok(! exists $seen{'fargo'});            # 995
ok(! exists $seen{'golfer'});           # 996
ok(! exists $seen{'hilton'});           # 997
ok(! exists $seen{'icon'});             # 998
ok(exists $seen{'jerky'});              # 999
%seen = ();

$symmetric_difference_ref = $lcmau->get_symdiff_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 1000
ok(! exists $seen{'baker'});            # 1001
ok(! exists $seen{'camera'});           # 1002
ok(! exists $seen{'delta'});            # 1003
ok(! exists $seen{'edward'});           # 1004
ok(! exists $seen{'fargo'});            # 1005
ok(! exists $seen{'golfer'});           # 1006
ok(! exists $seen{'hilton'});           # 1007
ok(! exists $seen{'icon'});             # 1008
ok(exists $seen{'jerky'});              # 1009
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @symmetric_difference = $lcmau->get_LorRonly;
}
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 1010
ok(! exists $seen{'baker'});            # 1011
ok(! exists $seen{'camera'});           # 1012
ok(! exists $seen{'delta'});            # 1013
ok(! exists $seen{'edward'});           # 1014
ok(! exists $seen{'fargo'});            # 1015
ok(! exists $seen{'golfer'});           # 1016
ok(! exists $seen{'hilton'});           # 1017
ok(! exists $seen{'icon'});             # 1018
ok(exists $seen{'jerky'});              # 1019
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $symmetric_difference_ref = $lcmau->get_LorRonly_ref;
}
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 1020
ok(! exists $seen{'baker'});            # 1021
ok(! exists $seen{'camera'});           # 1022
ok(! exists $seen{'delta'});            # 1023
ok(! exists $seen{'edward'});           # 1024
ok(! exists $seen{'fargo'});            # 1025
ok(! exists $seen{'golfer'});           # 1026
ok(! exists $seen{'hilton'});           # 1027
ok(! exists $seen{'icon'});             # 1028
ok(exists $seen{'jerky'});              # 1029
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @symmetric_difference = $lcmau->get_AorBonly;
}
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 1030
ok(! exists $seen{'baker'});            # 1031
ok(! exists $seen{'camera'});           # 1032
ok(! exists $seen{'delta'});            # 1033
ok(! exists $seen{'edward'});           # 1034
ok(! exists $seen{'fargo'});            # 1035
ok(! exists $seen{'golfer'});           # 1036
ok(! exists $seen{'hilton'});           # 1037
ok(! exists $seen{'icon'});             # 1038
ok(exists $seen{'jerky'});              # 1039
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $symmetric_difference_ref = $lcmau->get_AorBonly_ref;
}
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 1040
ok(! exists $seen{'baker'});            # 1041
ok(! exists $seen{'camera'});           # 1042
ok(! exists $seen{'delta'});            # 1043
ok(! exists $seen{'edward'});           # 1044
ok(! exists $seen{'fargo'});            # 1045
ok(! exists $seen{'golfer'});           # 1046
ok(! exists $seen{'hilton'});           # 1047
ok(! exists $seen{'icon'});             # 1048
ok(exists $seen{'jerky'});              # 1049
%seen = ();

@nonintersection = $lcmau->get_nonintersection;
$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 1050
ok(exists $seen{'baker'});              # 1051
ok(exists $seen{'camera'});             # 1052
ok(exists $seen{'delta'});              # 1053
ok(exists $seen{'edward'});             # 1054
ok(! exists $seen{'fargo'});            # 1055
ok(! exists $seen{'golfer'});           # 1056
ok(exists $seen{'hilton'});             # 1057
ok(exists $seen{'icon'});               # 1058
ok(exists $seen{'jerky'});              # 1059
%seen = ();

$nonintersection_ref = $lcmau->get_nonintersection_ref;
$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 1060
ok(exists $seen{'baker'});              # 1061
ok(exists $seen{'camera'});             # 1062
ok(exists $seen{'delta'});              # 1063
ok(exists $seen{'edward'});             # 1064
ok(! exists $seen{'fargo'});            # 1065
ok(! exists $seen{'golfer'});           # 1066
ok(exists $seen{'hilton'});             # 1067
ok(exists $seen{'icon'});               # 1068
ok(exists $seen{'jerky'});              # 1069
%seen = ();

@bag = $lcmau->get_bag;
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 1070
ok($seen{'baker'} == 2);                # 1071
ok($seen{'camera'} == 2);               # 1072
ok($seen{'delta'} == 3);                # 1073
ok($seen{'edward'} == 2);               # 1074
ok($seen{'fargo'} == 6);                # 1075
ok($seen{'golfer'} == 5);               # 1076
ok($seen{'hilton'} == 4);               # 1077
ok($seen{'icon'} == 5);                 # 1078
ok($seen{'jerky'} == 1);                # 1079
%seen = ();

$bag_ref = $lcmau->get_bag_ref;
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 1080
ok($seen{'baker'} == 2);                # 1081
ok($seen{'camera'} == 2);               # 1082
ok($seen{'delta'} == 3);                # 1083
ok($seen{'edward'} == 2);               # 1084
ok($seen{'fargo'} == 6);                # 1085
ok($seen{'golfer'} == 5);               # 1086
ok($seen{'hilton'} == 4);               # 1087
ok($seen{'icon'} == 5);                 # 1088
ok($seen{'jerky'} == 1);                # 1089
%seen = ();

$LR = $lcmau->is_LsubsetR(3,2);
ok($LR);                                # 1090

$LR = $lcmau->is_AsubsetB(3,2);
ok($LR);                                # 1091

$LR = $lcmau->is_LsubsetR(2,3);
ok(! $LR);                              # 1092

$LR = $lcmau->is_AsubsetB(2,3);
ok(! $LR);                              # 1093

$LR = $lcmau->is_LsubsetR;
ok(! $LR);                              # 1094

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcmau->is_RsubsetL;
}
ok(! $RL);                              # 1095

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcmau->is_BsubsetA;
}
ok(! $RL);                              # 1096

$eqv = $lcmau->is_LequivalentR(3,4);
ok($eqv);                               # 1097

$eqv = $lcmau->is_LeqvlntR(3,4);
ok($eqv);                               # 1098

$eqv = $lcmau->is_LequivalentR(2,4);
ok(! $eqv);                             # 1099

$return = $lcmau->print_subset_chart;
ok($return);                            # 1100

$return = $lcmau->print_equivalence_chart;
ok($return);                            # 1101

@memb_arr = $lcmau->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0        > ] ));# 1102

@memb_arr = $lcmau->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1      > ] ));# 1103

@memb_arr = $lcmau->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1      > ] ));# 1104

@memb_arr = $lcmau->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1      > ] ));# 1105

@memb_arr = $lcmau->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1      > ] ));# 1106

@memb_arr = $lcmau->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 1107

@memb_arr = $lcmau->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 1108

@memb_arr = $lcmau->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 1109

@memb_arr = $lcmau->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   3, [ qw<     2 3 4 > ] ));# 1110

@memb_arr = $lcmau->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  1, [ qw<     2     > ] ));# 1111

@memb_arr = $lcmau->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<           > ] ));# 1112

$memb_arr_ref = $lcmau->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0        > ] ));# 1113

$memb_arr_ref = $lcmau->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1      > ] ));# 1114

$memb_arr_ref = $lcmau->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1      > ] ));# 1115

$memb_arr_ref = $lcmau->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1      > ] ));# 1116

$memb_arr_ref = $lcmau->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1      > ] ));# 1117

$memb_arr_ref = $lcmau->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 1118

$memb_arr_ref = $lcmau->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 1119

$memb_arr_ref = $lcmau->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 1120

$memb_arr_ref = $lcmau->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   3, [ qw<     2 3 4 > ] ));# 1121

$memb_arr_ref = $lcmau->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  1, [ qw<     2     > ] ));# 1122

$memb_arr_ref = $lcmau->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<           > ] ));# 1123

$memb_hash_ref = $lcmau->are_members_which(
                     [ qw| abel baker camera delta edward fargo 
                           golfer hilton icon jerky zebra | ] );
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0         > ] ));# 1124
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1       > ] ));# 1125
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1       > ] ));# 1126
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1       > ] ));# 1127
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1       > ] ));# 1128
ok(ok_seen_h( $memb_hash_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 1129
ok(ok_seen_h( $memb_hash_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 1130
ok(ok_seen_h( $memb_hash_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 1131
ok(ok_seen_h( $memb_hash_ref, 'icon',   3, [ qw<     2 3 4 > ] ));# 1132
ok(ok_seen_h( $memb_hash_ref, 'jerky',  1, [ qw<     2     > ] ));# 1133
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<           > ] ));# 1134

ok($lcmau->is_member_any('abel'));      # 1135
ok($lcmau->is_member_any('baker'));     # 1136
ok($lcmau->is_member_any('camera'));    # 1137
ok($lcmau->is_member_any('delta'));     # 1138
ok($lcmau->is_member_any('edward'));    # 1139
ok($lcmau->is_member_any('fargo'));     # 1140
ok($lcmau->is_member_any('golfer'));    # 1141
ok($lcmau->is_member_any('hilton'));    # 1142
ok($lcmau->is_member_any('icon' ));     # 1143
ok($lcmau->is_member_any('jerky'));     # 1144
ok(! $lcmau->is_member_any('zebra'));   # 1145

$memb_hash_ref = $lcmau->are_members_any(
                     [ qw| abel baker camera delta edward fargo 
                           golfer hilton icon jerky zebra | ] );
ok(ok_any_h( $memb_hash_ref, 'abel',   1 ));# 1146
ok(ok_any_h( $memb_hash_ref, 'baker',  1 ));# 1147
ok(ok_any_h( $memb_hash_ref, 'camera', 1 ));# 1148
ok(ok_any_h( $memb_hash_ref, 'delta',  1 ));# 1149
ok(ok_any_h( $memb_hash_ref, 'edward', 1 ));# 1150
ok(ok_any_h( $memb_hash_ref, 'fargo',  1 ));# 1151
ok(ok_any_h( $memb_hash_ref, 'golfer', 1 ));# 1152
ok(ok_any_h( $memb_hash_ref, 'hilton', 1 ));# 1153
ok(ok_any_h( $memb_hash_ref, 'icon',   1 ));# 1154
ok(ok_any_h( $memb_hash_ref, 'jerky',  1 ));# 1155
ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));# 1156

$vers = $lcmau->get_version;
ok($vers);                              # 1157

########## BELOW:  Tests for '--unsorted' option ##########

my $lcmaun   = List::Compare->new( { unsorted => 1, accelerated => 1, lists => [\@a0, \@a1, \@a2, \@a3, \@a4] } );

ok($lcmaun);                            # 1158




