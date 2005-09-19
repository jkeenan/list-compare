# 24_alt_construct_multaccel_sh_rev.t # as of 05/08/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
1157;
use lib ("./t");
use List::Compare;
use Test::ListCompareSpecial qw(:seen);

$loaded = 1;
ok($loaded);                            # 1
######################### End of black magic.

my %seen = ();
my (@unique, @complement, @intersection, @union, @symmetric_difference);
my ($unique_ref, $complement_ref, $intersection_ref, $union_ref, $symmetric_difference_ref);
my ($LR, $RL, $eqv, $return);
my (@nonintersection, @shared);
my ($nonintersection_ref, @shared_ref);
my ($memb_hash_ref, $memb_arr_ref, @memb_arr);

my %h0 = (
    abel     => 2,
    baker    => 1,
    camera   => 1,
    delta    => 1,
    edward   => 1,
    fargo    => 1,
    golfer   => 1,
);

my %h1 = (
    baker    => 1,
    camera   => 1,
    delta    => 2,
    edward   => 1,
    fargo    => 1,
    golfer   => 1,
    hilton   => 1,
);

my %h2 = (
    fargo    => 1,
    golfer   => 1,
    hilton   => 1,
    icon     => 2,
    jerky    => 1,    
);

my %h3 = (
    fargo    => 1,
    golfer   => 1,
    hilton   => 1,
    icon     => 2,
);

my %h4 = (
    fargo    => 2,
    golfer   => 1,
    hilton   => 1,
    icon     => 1,
);

my %h5 = (
    golfer   => 1,
    lambda   => 0,
);

my %h6 = (
    golfer   => 1,
    mu       => 00,
);

my %h7 = (
    golfer   => 1,
    nu       => 'nothing',
);


my $lcmash   = List::Compare->new( { accelerated => 1, lists => [\%h0, \%h1, \%h2, \%h3, \%h4] } );
ok($lcmash);                            # 2

@union = $lcmash->get_union;
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

$union_ref = $lcmash->get_union_ref;
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

@shared = $lcmash->get_shared;
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

$shared_ref = $lcmash->get_shared_ref;
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

@intersection = $lcmash->get_intersection;
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

$intersection_ref = $lcmash->get_intersection_ref;
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

@unique = $lcmash->get_unique(2);
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

$unique_ref = $lcmash->get_unique_ref(2);
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
    @unique = $lcmash->get_Lonly(2);
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
    $unique_ref = $lcmash->get_Lonly_ref(2);
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
    @unique = $lcmash->get_Aonly(2);
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
    $unique_ref = $lcmash->get_Aonly_ref(2);
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

@unique = $lcmash->get_unique;
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

$unique_ref = $lcmash->get_unique_ref;
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
    @unique = $lcmash->get_Lonly;
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
    $unique_ref = $lcmash->get_Lonly_ref;
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
    @unique = $lcmash->get_Aonly;
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
    $unique_ref = $lcmash->get_Aonly_ref;
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

@complement = $lcmash->get_complement(1);
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

$complement_ref = $lcmash->get_complement_ref(1);
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
    @complement = $lcmash->get_Ronly(1);
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
    $complement_ref = $lcmash->get_Ronly_ref(1);
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
    @complement = $lcmash->get_Bonly(1);
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
    $complement_ref = $lcmash->get_Bonly_ref(1);
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

@complement = $lcmash->get_complement;
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

$complement_ref = $lcmash->get_complement_ref;
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
    @complement = $lcmash->get_Ronly;
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
    $complement_ref = $lcmash->get_Ronly_ref;
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
    @complement = $lcmash->get_Bonly;
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
    $complement_ref = $lcmash->get_Bonly_ref;
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

@symmetric_difference = $lcmash->get_symmetric_difference;
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

$symmetric_difference_ref = $lcmash->get_symmetric_difference_ref;
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

@symmetric_difference = $lcmash->get_symdiff;
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

$symmetric_difference_ref = $lcmash->get_symdiff_ref;
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
    @symmetric_difference = $lcmash->get_LorRonly;
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
    $symmetric_difference_ref = $lcmash->get_LorRonly_ref;
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
    @symmetric_difference = $lcmash->get_AorBonly;
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
    $symmetric_difference_ref = $lcmash->get_AorBonly_ref;
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

@nonintersection = $lcmash->get_nonintersection;
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

$nonintersection_ref = $lcmash->get_nonintersection_ref;
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

@bag = $lcmash->get_bag;
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

$bag_ref = $lcmash->get_bag_ref;
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

$LR = $lcmash->is_LsubsetR(3,2);
ok($LR);                                # 607

$LR = $lcmash->is_AsubsetB(3,2);
ok($LR);                                # 608

$LR = $lcmash->is_LsubsetR(2,3);
ok(! $LR);                              # 609

$LR = $lcmash->is_AsubsetB(2,3);
ok(! $LR);                              # 610

$LR = $lcmash->is_LsubsetR;
ok(! $LR);                              # 611

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcmash->is_RsubsetL;
}
ok(! $RL);                              # 612

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcmash->is_BsubsetA;
}
ok(! $RL);                              # 613

$eqv = $lcmash->is_LequivalentR(3,4);
ok($eqv);                               # 614

$eqv = $lcmash->is_LeqvlntR(3,4);
ok($eqv);                               # 615

$eqv = $lcmash->is_LequivalentR(2,4);
ok(! $eqv);                             # 616

$return = $lcmash->print_subset_chart;
ok($return);                            # 617

$return = $lcmash->print_equivalence_chart;
ok($return);                            # 618

@memb_arr = $lcmash->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0        > ] ));# 619

@memb_arr = $lcmash->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1      > ] ));# 620

@memb_arr = $lcmash->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1      > ] ));# 621

@memb_arr = $lcmash->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1      > ] ));# 622

@memb_arr = $lcmash->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1      > ] ));# 623

@memb_arr = $lcmash->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 624

@memb_arr = $lcmash->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 625

@memb_arr = $lcmash->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 626

@memb_arr = $lcmash->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   3, [ qw<     2 3 4 > ] ));# 627

@memb_arr = $lcmash->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  1, [ qw<     2     > ] ));# 628

@memb_arr = $lcmash->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<           > ] ));# 629


$memb_arr_ref = $lcmash->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0        > ] ));# 630

$memb_arr_ref = $lcmash->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1      > ] ));# 631

$memb_arr_ref = $lcmash->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1      > ] ));# 632

$memb_arr_ref = $lcmash->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1      > ] ));# 633

$memb_arr_ref = $lcmash->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1      > ] ));# 634

$memb_arr_ref = $lcmash->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 635

$memb_arr_ref = $lcmash->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 636

$memb_arr_ref = $lcmash->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 637

$memb_arr_ref = $lcmash->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   3, [ qw<     2 3 4 > ] ));# 638

$memb_arr_ref = $lcmash->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  1, [ qw<     2     > ] ));# 639

$memb_arr_ref = $lcmash->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<           > ] ));# 640

$memb_hash_ref = $lcmash->are_members_which(
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

ok($lcmash->is_member_any('abel'));     # 652
ok($lcmash->is_member_any('baker'));    # 653
ok($lcmash->is_member_any('camera'));   # 654
ok($lcmash->is_member_any('delta'));    # 655
ok($lcmash->is_member_any('edward'));   # 656
ok($lcmash->is_member_any('fargo'));    # 657
ok($lcmash->is_member_any('golfer'));   # 658
ok($lcmash->is_member_any('hilton'));   # 659
ok($lcmash->is_member_any('icon' ));    # 660
ok($lcmash->is_member_any('jerky'));    # 661
ok(! $lcmash->is_member_any('zebra'));  # 662

$memb_hash_ref = $lcmash->are_members_any(
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

$vers = $lcmash->get_version;
ok($vers);                              # 674

########## BELOW:  Tests for '-u' option ##########

my $lcmashu   = List::Compare->new( { unsorted => 1, accelerated => 1, lists => [\%h0, \%h1, \%h2, \%h3, \%h4] } );
ok($lcmashu);                           # 675

@union = $lcmashu->get_union;
$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});               # 676
ok(exists $seen{'baker'});              # 677
ok(exists $seen{'camera'});             # 678
ok(exists $seen{'delta'});              # 679
ok(exists $seen{'edward'});             # 680
ok(exists $seen{'fargo'});              # 681
ok(exists $seen{'golfer'});             # 682
ok(exists $seen{'hilton'});             # 683
ok(exists $seen{'icon'});               # 684
ok(exists $seen{'jerky'});              # 685
%seen = ();

$union_ref = $lcmashu->get_union_ref;
$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});               # 686
ok(exists $seen{'baker'});              # 687
ok(exists $seen{'camera'});             # 688
ok(exists $seen{'delta'});              # 689
ok(exists $seen{'edward'});             # 690
ok(exists $seen{'fargo'});              # 691
ok(exists $seen{'golfer'});             # 692
ok(exists $seen{'hilton'});             # 693
ok(exists $seen{'icon'});               # 694
ok(exists $seen{'jerky'});              # 695
%seen = ();

@shared = $lcmashu->get_shared;
$seen{$_}++ foreach (@shared);
ok(! exists $seen{'abel'});             # 696
ok(exists $seen{'baker'});              # 697
ok(exists $seen{'camera'});             # 698
ok(exists $seen{'delta'});              # 699
ok(exists $seen{'edward'});             # 700
ok(exists $seen{'fargo'});              # 701
ok(exists $seen{'golfer'});             # 702
ok(exists $seen{'hilton'});             # 703
ok(exists $seen{'icon'});               # 704
ok(! exists $seen{'jerky'});            # 705
%seen = ();

$shared_ref = $lcmashu->get_shared_ref;
$seen{$_}++ foreach (@{$shared_ref});
ok(! exists $seen{'abel'});             # 706
ok(exists $seen{'baker'});              # 707
ok(exists $seen{'camera'});             # 708
ok(exists $seen{'delta'});              # 709
ok(exists $seen{'edward'});             # 710
ok(exists $seen{'fargo'});              # 711
ok(exists $seen{'golfer'});             # 712
ok(exists $seen{'hilton'});             # 713
ok(exists $seen{'icon'});               # 714
ok(! exists $seen{'jerky'});            # 715
%seen = ();

@intersection = $lcmashu->get_intersection;
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 716
ok(! exists $seen{'baker'});            # 717
ok(! exists $seen{'camera'});           # 718
ok(! exists $seen{'delta'});            # 719
ok(! exists $seen{'edward'});           # 720
ok(exists $seen{'fargo'});              # 721
ok(exists $seen{'golfer'});             # 722
ok(! exists $seen{'hilton'});           # 723
ok(! exists $seen{'icon'});             # 724
ok(! exists $seen{'jerky'});            # 725
%seen = ();

$intersection_ref = $lcmashu->get_intersection_ref;
$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});             # 726
ok(! exists $seen{'baker'});            # 727
ok(! exists $seen{'camera'});           # 728
ok(! exists $seen{'delta'});            # 729
ok(! exists $seen{'edward'});           # 730
ok(exists $seen{'fargo'});              # 731
ok(exists $seen{'golfer'});             # 732
ok(! exists $seen{'hilton'});           # 733
ok(! exists $seen{'icon'});             # 734
ok(! exists $seen{'jerky'});            # 735
%seen = ();

@unique = $lcmashu->get_unique(2);
$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});             # 736
ok(! exists $seen{'baker'});            # 737
ok(! exists $seen{'camera'});           # 738
ok(! exists $seen{'delta'});            # 739
ok(! exists $seen{'edward'});           # 740
ok(! exists $seen{'fargo'});            # 741
ok(! exists $seen{'golfer'});           # 742
ok(! exists $seen{'hilton'});           # 743
ok(! exists $seen{'icon'});             # 744
ok(exists $seen{'jerky'});              # 745
%seen = ();

$unique_ref = $lcmashu->get_unique_ref(2);
$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});             # 746
ok(! exists $seen{'baker'});            # 747
ok(! exists $seen{'camera'});           # 748
ok(! exists $seen{'delta'});            # 749
ok(! exists $seen{'edward'});           # 750
ok(! exists $seen{'fargo'});            # 751
ok(! exists $seen{'golfer'});           # 752
ok(! exists $seen{'hilton'});           # 753
ok(! exists $seen{'icon'});             # 754
ok(exists $seen{'jerky'});              # 755
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmashu->get_Lonly_ref(2);
}
$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});             # 756
ok(! exists $seen{'baker'});            # 757
ok(! exists $seen{'camera'});           # 758
ok(! exists $seen{'delta'});            # 759
ok(! exists $seen{'edward'});           # 760
ok(! exists $seen{'fargo'});            # 761
ok(! exists $seen{'golfer'});           # 762
ok(! exists $seen{'hilton'});           # 763
ok(! exists $seen{'icon'});             # 764
ok(exists $seen{'jerky'});              # 765
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcmashu->get_Aonly(2);
}
$seen{$_}++ foreach (@unique);
ok(! exists $seen{'abel'});             # 766
ok(! exists $seen{'baker'});            # 767
ok(! exists $seen{'camera'});           # 768
ok(! exists $seen{'delta'});            # 769
ok(! exists $seen{'edward'});           # 770
ok(! exists $seen{'fargo'});            # 771
ok(! exists $seen{'golfer'});           # 772
ok(! exists $seen{'hilton'});           # 773
ok(! exists $seen{'icon'});             # 774
ok(exists $seen{'jerky'});              # 775
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmashu->get_Aonly_ref(2);
}
$seen{$_}++ foreach (@{$unique_ref});
ok(! exists $seen{'abel'});             # 776
ok(! exists $seen{'baker'});            # 777
ok(! exists $seen{'camera'});           # 778
ok(! exists $seen{'delta'});            # 779
ok(! exists $seen{'edward'});           # 780
ok(! exists $seen{'fargo'});            # 781
ok(! exists $seen{'golfer'});           # 782
ok(! exists $seen{'hilton'});           # 783
ok(! exists $seen{'icon'});             # 784
ok(exists $seen{'jerky'});              # 785
%seen = ();

@unique = $lcmashu->get_unique;
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 786
ok(! exists $seen{'baker'});            # 787
ok(! exists $seen{'camera'});           # 788
ok(! exists $seen{'delta'});            # 789
ok(! exists $seen{'edward'});           # 790
ok(! exists $seen{'fargo'});            # 791
ok(! exists $seen{'golfer'});           # 792
ok(! exists $seen{'hilton'});           # 793
ok(! exists $seen{'icon'});             # 794
ok(! exists $seen{'jerky'});            # 795
%seen = ();

$unique_ref = $lcmashu->get_unique_ref;
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 796
ok(! exists $seen{'baker'});            # 797
ok(! exists $seen{'camera'});           # 798
ok(! exists $seen{'delta'});            # 799
ok(! exists $seen{'edward'});           # 800
ok(! exists $seen{'fargo'});            # 801
ok(! exists $seen{'golfer'});           # 802
ok(! exists $seen{'hilton'});           # 803
ok(! exists $seen{'icon'});             # 804
ok(! exists $seen{'jerky'});            # 805
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcmashu->get_Lonly;
}
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 806
ok(! exists $seen{'baker'});            # 807
ok(! exists $seen{'camera'});           # 808
ok(! exists $seen{'delta'});            # 809
ok(! exists $seen{'edward'});           # 810
ok(! exists $seen{'fargo'});            # 811
ok(! exists $seen{'golfer'});           # 812
ok(! exists $seen{'hilton'});           # 813
ok(! exists $seen{'icon'});             # 814
ok(! exists $seen{'jerky'});            # 815
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmashu->get_Lonly_ref;
}
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 816
ok(! exists $seen{'baker'});            # 817
ok(! exists $seen{'camera'});           # 818
ok(! exists $seen{'delta'});            # 819
ok(! exists $seen{'edward'});           # 820
ok(! exists $seen{'fargo'});            # 821
ok(! exists $seen{'golfer'});           # 822
ok(! exists $seen{'hilton'});           # 823
ok(! exists $seen{'icon'});             # 824
ok(! exists $seen{'jerky'});            # 825
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @unique = $lcmashu->get_Aonly;
}
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 826
ok(! exists $seen{'baker'});            # 827
ok(! exists $seen{'camera'});           # 828
ok(! exists $seen{'delta'});            # 829
ok(! exists $seen{'edward'});           # 830
ok(! exists $seen{'fargo'});            # 831
ok(! exists $seen{'golfer'});           # 832
ok(! exists $seen{'hilton'});           # 833
ok(! exists $seen{'icon'});             # 834
ok(! exists $seen{'jerky'});            # 835
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $unique_ref = $lcmashu->get_Aonly_ref;
}
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 836
ok(! exists $seen{'baker'});            # 837
ok(! exists $seen{'camera'});           # 838
ok(! exists $seen{'delta'});            # 839
ok(! exists $seen{'edward'});           # 840
ok(! exists $seen{'fargo'});            # 841
ok(! exists $seen{'golfer'});           # 842
ok(! exists $seen{'hilton'});           # 843
ok(! exists $seen{'icon'});             # 844
ok(! exists $seen{'jerky'});            # 845
%seen = ();

@complement = $lcmashu->get_complement(1);
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 846
ok(! exists $seen{'baker'});            # 847
ok(! exists $seen{'camera'});           # 848
ok(! exists $seen{'delta'});            # 849
ok(! exists $seen{'edward'});           # 850
ok(! exists $seen{'fargo'});            # 851
ok(! exists $seen{'golfer'});           # 852
ok(! exists $seen{'hilton'});           # 853
ok(exists $seen{'icon'});               # 854
ok(exists $seen{'jerky'});              # 855
%seen = ();

$complement_ref = $lcmashu->get_complement_ref(1);
$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 856
ok(! exists $seen{'baker'});            # 857
ok(! exists $seen{'camera'});           # 858
ok(! exists $seen{'delta'});            # 859
ok(! exists $seen{'edward'});           # 860
ok(! exists $seen{'fargo'});            # 861
ok(! exists $seen{'golfer'});           # 862
ok(! exists $seen{'hilton'});           # 863
ok(exists $seen{'icon'});               # 864
ok(exists $seen{'jerky'});              # 865
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmashu->get_Ronly(1);
}
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 866
ok(! exists $seen{'baker'});            # 867
ok(! exists $seen{'camera'});           # 868
ok(! exists $seen{'delta'});            # 869
ok(! exists $seen{'edward'});           # 870
ok(! exists $seen{'fargo'});            # 871
ok(! exists $seen{'golfer'});           # 872
ok(! exists $seen{'hilton'});           # 873
ok(exists $seen{'icon'});               # 874
ok(exists $seen{'jerky'});              # 875
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmashu->get_Ronly_ref(1);
}
$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 876
ok(! exists $seen{'baker'});            # 877
ok(! exists $seen{'camera'});           # 878
ok(! exists $seen{'delta'});            # 879
ok(! exists $seen{'edward'});           # 880
ok(! exists $seen{'fargo'});            # 881
ok(! exists $seen{'golfer'});           # 882
ok(! exists $seen{'hilton'});           # 883
ok(exists $seen{'icon'});               # 884
ok(exists $seen{'jerky'});              # 885
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmashu->get_Bonly(1);
}
$seen{$_}++ foreach (@complement);
ok(exists $seen{'abel'});               # 886
ok(! exists $seen{'baker'});            # 887
ok(! exists $seen{'camera'});           # 888
ok(! exists $seen{'delta'});            # 889
ok(! exists $seen{'edward'});           # 890
ok(! exists $seen{'fargo'});            # 891
ok(! exists $seen{'golfer'});           # 892
ok(! exists $seen{'hilton'});           # 893
ok(exists $seen{'icon'});               # 894
ok(exists $seen{'jerky'});              # 895
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmashu->get_Bonly_ref(1);
}
$seen{$_}++ foreach (@{$complement_ref});
ok(exists $seen{'abel'});               # 896
ok(! exists $seen{'baker'});            # 897
ok(! exists $seen{'camera'});           # 898
ok(! exists $seen{'delta'});            # 899
ok(! exists $seen{'edward'});           # 900
ok(! exists $seen{'fargo'});            # 901
ok(! exists $seen{'golfer'});           # 902
ok(! exists $seen{'hilton'});           # 903
ok(exists $seen{'icon'});               # 904
ok(exists $seen{'jerky'});              # 905
%seen = ();

@complement = $lcmashu->get_complement;
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 906
ok(! exists $seen{'baker'});            # 907
ok(! exists $seen{'camera'});           # 908
ok(! exists $seen{'delta'});            # 909
ok(! exists $seen{'edward'});           # 910
ok(! exists $seen{'fargo'});            # 911
ok(! exists $seen{'golfer'});           # 912
ok(exists $seen{'hilton'});             # 913
ok(exists $seen{'icon'});               # 914
ok(exists $seen{'jerky'});              # 915
%seen = ();

$complement_ref = $lcmashu->get_complement_ref;
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 916
ok(! exists $seen{'baker'});            # 917
ok(! exists $seen{'camera'});           # 918
ok(! exists $seen{'delta'});            # 919
ok(! exists $seen{'edward'});           # 920
ok(! exists $seen{'fargo'});            # 921
ok(! exists $seen{'golfer'});           # 922
ok(exists $seen{'hilton'});             # 923
ok(exists $seen{'icon'});               # 924
ok(exists $seen{'jerky'});              # 925
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmashu->get_Ronly;
}
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 926
ok(! exists $seen{'baker'});            # 927
ok(! exists $seen{'camera'});           # 928
ok(! exists $seen{'delta'});            # 929
ok(! exists $seen{'edward'});           # 930
ok(! exists $seen{'fargo'});            # 931
ok(! exists $seen{'golfer'});           # 932
ok(exists $seen{'hilton'});             # 933
ok(exists $seen{'icon'});               # 934
ok(exists $seen{'jerky'});              # 935
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmashu->get_Ronly_ref;
}
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 936
ok(! exists $seen{'baker'});            # 937
ok(! exists $seen{'camera'});           # 938
ok(! exists $seen{'delta'});            # 939
ok(! exists $seen{'edward'});           # 940
ok(! exists $seen{'fargo'});            # 941
ok(! exists $seen{'golfer'});           # 942
ok(exists $seen{'hilton'});             # 943
ok(exists $seen{'icon'});               # 944
ok(exists $seen{'jerky'});              # 945
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @complement = $lcmashu->get_Bonly;
}
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 946
ok(! exists $seen{'baker'});            # 947
ok(! exists $seen{'camera'});           # 948
ok(! exists $seen{'delta'});            # 949
ok(! exists $seen{'edward'});           # 950
ok(! exists $seen{'fargo'});            # 951
ok(! exists $seen{'golfer'});           # 952
ok(exists $seen{'hilton'});             # 953
ok(exists $seen{'icon'});               # 954
ok(exists $seen{'jerky'});              # 955
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $complement_ref = $lcmashu->get_Bonly_ref;
}
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 956
ok(! exists $seen{'baker'});            # 957
ok(! exists $seen{'camera'});           # 958
ok(! exists $seen{'delta'});            # 959
ok(! exists $seen{'edward'});           # 960
ok(! exists $seen{'fargo'});            # 961
ok(! exists $seen{'golfer'});           # 962
ok(exists $seen{'hilton'});             # 963
ok(exists $seen{'icon'});               # 964
ok(exists $seen{'jerky'});              # 965
%seen = ();

@symmetric_difference = $lcmashu->get_symmetric_difference;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 966
ok(! exists $seen{'baker'});            # 967
ok(! exists $seen{'camera'});           # 968
ok(! exists $seen{'delta'});            # 969
ok(! exists $seen{'edward'});           # 970
ok(! exists $seen{'fargo'});            # 971
ok(! exists $seen{'golfer'});           # 972
ok(! exists $seen{'hilton'});           # 973
ok(! exists $seen{'icon'});             # 974
ok(exists $seen{'jerky'});              # 975
%seen = ();

$symmetric_difference_ref = $lcmashu->get_symmetric_difference_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 976
ok(! exists $seen{'baker'});            # 977
ok(! exists $seen{'camera'});           # 978
ok(! exists $seen{'delta'});            # 979
ok(! exists $seen{'edward'});           # 980
ok(! exists $seen{'fargo'});            # 981
ok(! exists $seen{'golfer'});           # 982
ok(! exists $seen{'hilton'});           # 983
ok(! exists $seen{'icon'});             # 984
ok(exists $seen{'jerky'});              # 985
%seen = ();

@symmetric_difference = $lcmashu->get_symdiff;
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 986
ok(! exists $seen{'baker'});            # 987
ok(! exists $seen{'camera'});           # 988
ok(! exists $seen{'delta'});            # 989
ok(! exists $seen{'edward'});           # 990
ok(! exists $seen{'fargo'});            # 991
ok(! exists $seen{'golfer'});           # 992
ok(! exists $seen{'hilton'});           # 993
ok(! exists $seen{'icon'});             # 994
ok(exists $seen{'jerky'});              # 995
%seen = ();

$symmetric_difference_ref = $lcmashu->get_symdiff_ref;
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 996
ok(! exists $seen{'baker'});            # 997
ok(! exists $seen{'camera'});           # 998
ok(! exists $seen{'delta'});            # 999
ok(! exists $seen{'edward'});           # 1000
ok(! exists $seen{'fargo'});            # 1001
ok(! exists $seen{'golfer'});           # 1002
ok(! exists $seen{'hilton'});           # 1003
ok(! exists $seen{'icon'});             # 1004
ok(exists $seen{'jerky'});              # 1005
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @symmetric_difference = $lcmashu->get_LorRonly;
}
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 1006
ok(! exists $seen{'baker'});            # 1007
ok(! exists $seen{'camera'});           # 1008
ok(! exists $seen{'delta'});            # 1009
ok(! exists $seen{'edward'});           # 1010
ok(! exists $seen{'fargo'});            # 1011
ok(! exists $seen{'golfer'});           # 1012
ok(! exists $seen{'hilton'});           # 1013
ok(! exists $seen{'icon'});             # 1014
ok(exists $seen{'jerky'});              # 1015
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $symmetric_difference_ref = $lcmashu->get_LorRonly_ref;
}
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 1016
ok(! exists $seen{'baker'});            # 1017
ok(! exists $seen{'camera'});           # 1018
ok(! exists $seen{'delta'});            # 1019
ok(! exists $seen{'edward'});           # 1020
ok(! exists $seen{'fargo'});            # 1021
ok(! exists $seen{'golfer'});           # 1022
ok(! exists $seen{'hilton'});           # 1023
ok(! exists $seen{'icon'});             # 1024
ok(exists $seen{'jerky'});              # 1025
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    @symmetric_difference = $lcmashu->get_AorBonly;
}
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 1026
ok(! exists $seen{'baker'});            # 1027
ok(! exists $seen{'camera'});           # 1028
ok(! exists $seen{'delta'});            # 1029
ok(! exists $seen{'edward'});           # 1030
ok(! exists $seen{'fargo'});            # 1031
ok(! exists $seen{'golfer'});           # 1032
ok(! exists $seen{'hilton'});           # 1033
ok(! exists $seen{'icon'});             # 1034
ok(exists $seen{'jerky'});              # 1035
%seen = ();

{
    local $SIG{__WARN__} = \&_capture;
    $symmetric_difference_ref = $lcmashu->get_AorBonly_ref;
}
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 1036
ok(! exists $seen{'baker'});            # 1037
ok(! exists $seen{'camera'});           # 1038
ok(! exists $seen{'delta'});            # 1039
ok(! exists $seen{'edward'});           # 1040
ok(! exists $seen{'fargo'});            # 1041
ok(! exists $seen{'golfer'});           # 1042
ok(! exists $seen{'hilton'});           # 1043
ok(! exists $seen{'icon'});             # 1044
ok(exists $seen{'jerky'});              # 1045
%seen = ();

@nonintersection = $lcmashu->get_nonintersection;
$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 1046
ok(exists $seen{'baker'});              # 1047
ok(exists $seen{'camera'});             # 1048
ok(exists $seen{'delta'});              # 1049
ok(exists $seen{'edward'});             # 1050
ok(! exists $seen{'fargo'});            # 1051
ok(! exists $seen{'golfer'});           # 1052
ok(exists $seen{'hilton'});             # 1053
ok(exists $seen{'icon'});               # 1054
ok(exists $seen{'jerky'});              # 1055
%seen = ();

$nonintersection_ref = $lcmashu->get_nonintersection_ref;
$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 1056
ok(exists $seen{'baker'});              # 1057
ok(exists $seen{'camera'});             # 1058
ok(exists $seen{'delta'});              # 1059
ok(exists $seen{'edward'});             # 1060
ok(! exists $seen{'fargo'});            # 1061
ok(! exists $seen{'golfer'});           # 1062
ok(exists $seen{'hilton'});             # 1063
ok(exists $seen{'icon'});               # 1064
ok(exists $seen{'jerky'});              # 1065
%seen = ();

@bag = $lcmashu->get_bag;
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 1066
ok($seen{'baker'} == 2);                # 1067
ok($seen{'camera'} == 2);               # 1068
ok($seen{'delta'} == 3);                # 1069
ok($seen{'edward'} == 2);               # 1070
ok($seen{'fargo'} == 6);                # 1071
ok($seen{'golfer'} == 5);               # 1072
ok($seen{'hilton'} == 4);               # 1073
ok($seen{'icon'} == 5);                 # 1074
ok($seen{'jerky'} == 1);                # 1075
%seen = ();

$bag_ref = $lcmashu->get_bag_ref;
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 1076
ok($seen{'baker'} == 2);                # 1077
ok($seen{'camera'} == 2);               # 1078
ok($seen{'delta'} == 3);                # 1079
ok($seen{'edward'} == 2);               # 1080
ok($seen{'fargo'} == 6);                # 1081
ok($seen{'golfer'} == 5);               # 1082
ok($seen{'hilton'} == 4);               # 1083
ok($seen{'icon'} == 5);                 # 1084
ok($seen{'jerky'} == 1);                # 1085
%seen = ();

$LR = $lcmashu->is_LsubsetR(3,2);
ok($LR);                                # 1086

$LR = $lcmashu->is_AsubsetB(3,2);
ok($LR);                                # 1087

$LR = $lcmashu->is_LsubsetR(2,3);
ok(! $LR);                              # 1088

$LR = $lcmashu->is_AsubsetB(2,3);
ok(! $LR);                              # 1089

$LR = $lcmashu->is_LsubsetR;
ok(! $LR);                              # 1090

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcmashu->is_RsubsetL;
}
ok(! $RL);                              # 1091

{
    local $SIG{__WARN__} = \&_capture;
    $RL = $lcmashu->is_BsubsetA;
}
ok(! $RL);                              # 1092

$eqv = $lcmashu->is_LequivalentR(3,4);
ok($eqv);                               # 1093

$eqv = $lcmashu->is_LeqvlntR(3,4);
ok($eqv);                               # 1094

$eqv = $lcmashu->is_LequivalentR(2,4);
ok(! $eqv);                             # 1095

$return = $lcmashu->print_subset_chart;
ok($return);                            # 1096

$return = $lcmashu->print_equivalence_chart;
ok($return);                            # 1097

@memb_arr = $lcmashu->is_member_which('abel');
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0        > ] ));# 1098

@memb_arr = $lcmashu->is_member_which('baker');
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1      > ] ));# 1099

@memb_arr = $lcmashu->is_member_which('camera');
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1      > ] ));# 1100

@memb_arr = $lcmashu->is_member_which('delta');
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1      > ] ));# 1101

@memb_arr = $lcmashu->is_member_which('edward');
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1      > ] ));# 1102

@memb_arr = $lcmashu->is_member_which('fargo');
ok(ok_seen_a( \@memb_arr, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 1103

@memb_arr = $lcmashu->is_member_which('golfer');
ok(ok_seen_a( \@memb_arr, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 1104

@memb_arr = $lcmashu->is_member_which('hilton');
ok(ok_seen_a( \@memb_arr, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 1105

@memb_arr = $lcmashu->is_member_which('icon');
ok(ok_seen_a( \@memb_arr, 'icon',   3, [ qw<     2 3 4 > ] ));# 1106

@memb_arr = $lcmashu->is_member_which('jerky');
ok(ok_seen_a( \@memb_arr, 'jerky',  1, [ qw<     2     > ] ));# 1107

@memb_arr = $lcmashu->is_member_which('zebra');
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<           > ] ));# 1108


$memb_arr_ref = $lcmashu->is_member_which_ref('abel');
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0        > ] ));# 1109

$memb_arr_ref = $lcmashu->is_member_which_ref('baker');
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1      > ] ));# 1110

$memb_arr_ref = $lcmashu->is_member_which_ref('camera');
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1      > ] ));# 1111

$memb_arr_ref = $lcmashu->is_member_which_ref('delta');
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1      > ] ));# 1112

$memb_arr_ref = $lcmashu->is_member_which_ref('edward');
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1      > ] ));# 1113

$memb_arr_ref = $lcmashu->is_member_which_ref('fargo');
ok(ok_seen_a( $memb_arr_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 1114

$memb_arr_ref = $lcmashu->is_member_which_ref('golfer');
ok(ok_seen_a( $memb_arr_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 1115

$memb_arr_ref = $lcmashu->is_member_which_ref('hilton');
ok(ok_seen_a( $memb_arr_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 1116

$memb_arr_ref = $lcmashu->is_member_which_ref('icon');
ok(ok_seen_a( $memb_arr_ref, 'icon',   3, [ qw<     2 3 4 > ] ));# 1117

$memb_arr_ref = $lcmashu->is_member_which_ref('jerky');
ok(ok_seen_a( $memb_arr_ref, 'jerky',  1, [ qw<     2     > ] ));# 1118

$memb_arr_ref = $lcmashu->is_member_which_ref('zebra');
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<           > ] ));# 1119

$memb_hash_ref = $lcmashu->are_members_which(
                     [ qw| abel baker camera delta edward fargo 
                           golfer hilton icon jerky zebra | ] );
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0         > ] ));# 1120
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1       > ] ));# 1121
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1       > ] ));# 1122
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1       > ] ));# 1123
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1       > ] ));# 1124
ok(ok_seen_h( $memb_hash_ref, 'fargo',  5, [ qw< 0 1 2 3 4 > ] ));# 1125
ok(ok_seen_h( $memb_hash_ref, 'golfer', 5, [ qw< 0 1 2 3 4 > ] ));# 1126
ok(ok_seen_h( $memb_hash_ref, 'hilton', 4, [ qw<   1 2 3 4 > ] ));# 1127
ok(ok_seen_h( $memb_hash_ref, 'icon',   3, [ qw<     2 3 4 > ] ));# 1128
ok(ok_seen_h( $memb_hash_ref, 'jerky',  1, [ qw<     2     > ] ));# 1129
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<           > ] ));# 1130


ok($lcmashu->is_member_any('abel'));    # 1131
ok($lcmashu->is_member_any('baker'));   # 1132
ok($lcmashu->is_member_any('camera'));  # 1133
ok($lcmashu->is_member_any('delta'));   # 1134
ok($lcmashu->is_member_any('edward'));  # 1135
ok($lcmashu->is_member_any('fargo'));   # 1136
ok($lcmashu->is_member_any('golfer'));  # 1137
ok($lcmashu->is_member_any('hilton'));  # 1138
ok($lcmashu->is_member_any('icon' ));   # 1139
ok($lcmashu->is_member_any('jerky'));   # 1140
ok(! $lcmashu->is_member_any('zebra')); # 1141

$memb_hash_ref = $lcmashu->are_members_any(
                     [ qw| abel baker camera delta edward fargo 
                           golfer hilton icon jerky zebra | ] );
ok(ok_any_h( $memb_hash_ref, 'abel',   1 ));# 1142
ok(ok_any_h( $memb_hash_ref, 'baker',  1 ));# 1143
ok(ok_any_h( $memb_hash_ref, 'camera', 1 ));# 1144
ok(ok_any_h( $memb_hash_ref, 'delta',  1 ));# 1145
ok(ok_any_h( $memb_hash_ref, 'edward', 1 ));# 1146
ok(ok_any_h( $memb_hash_ref, 'fargo',  1 ));# 1147
ok(ok_any_h( $memb_hash_ref, 'golfer', 1 ));# 1148
ok(ok_any_h( $memb_hash_ref, 'hilton', 1 ));# 1149
ok(ok_any_h( $memb_hash_ref, 'icon',   1 ));# 1150
ok(ok_any_h( $memb_hash_ref, 'jerky',  1 ));# 1151
ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));# 1152

$vers = $lcmashu->get_version;
ok($vers);                              # 1153

########## BELOW:  Tests for '--unsorted' option ##########

my $lcmashun   = List::Compare->new( { unsorted => 1 , accelerated => 1, lists => [\%h0, \%h1, \%h2, \%h3, \%h4] } );
ok($lcmashun);                          # 1154

########## BELOW:  Tests for bad values in seen-hash ##########

my ($f5, $f6, $f7);

eval { $f5 = List::Compare->new( { accelerated => 1, lists => [\%h0, \%h5, \%h6] } ) };
ok(ok_capture_error($@));               # 1155

eval { $f6 = List::Compare->new( { accelerated => 1, lists => [\%h0, \%h6, \%h7] } ) };
ok(ok_capture_error($@));               # 1156

eval { $f7 = List::Compare->new( { accelerated => 1, lists => [\%h6, \%h7, \%h0] } ) };
ok(ok_capture_error($@));               # 1157





