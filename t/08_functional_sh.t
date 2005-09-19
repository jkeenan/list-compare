# 08_functional_sh.t # as of 8/4/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} # 
use Test::Simple tests =>
700;
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

my (%h0, %h1, %h2, %h3, %h4, %h8);
$h0{$_}++ for @a0;
$h1{$_}++ for @a1;
$h2{$_}++ for @a2;
$h3{$_}++ for @a3;
$h4{$_}++ for @a4;
$h8{$_}++ for @a8;

@union = get_union( [ \%h0, \%h1 ] );
ok($union[0] eq 'abel');                # 2
ok($union[1] eq 'baker');               # 3
ok($union[2] eq 'camera');              # 4
ok($union[3] eq 'delta');               # 5
ok($union[4] eq 'edward');              # 6
ok($union[5] eq 'fargo');               # 7
ok($union[6] eq 'golfer');              # 8
ok($union[-1] eq 'hilton');             # 9

$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});               # 10
ok(exists $seen{'baker'});              # 11
ok(exists $seen{'camera'});             # 12
ok(exists $seen{'delta'});              # 13
ok(exists $seen{'edward'});             # 14
ok(exists $seen{'fargo'});              # 15
ok(exists $seen{'golfer'});             # 16
ok(exists $seen{'hilton'});             # 17
ok(! exists $seen{'icon'});             # 18
ok(! exists $seen{'jerky'});            # 19
%seen = ();

$union_ref = get_union_ref( [ \%h0, \%h1 ] );
ok(${$union_ref}[0] eq 'abel');         # 20
ok(${$union_ref}[1] eq 'baker');        # 21
ok(${$union_ref}[2] eq 'camera');       # 22
ok(${$union_ref}[3] eq 'delta');        # 23
ok(${$union_ref}[4] eq 'edward');       # 24
ok(${$union_ref}[5] eq 'fargo');        # 25
ok(${$union_ref}[6] eq 'golfer');       # 26
ok(${$union_ref}[-1] eq 'hilton');      # 27

$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});               # 28
ok(exists $seen{'baker'});              # 29
ok(exists $seen{'camera'});             # 30
ok(exists $seen{'delta'});              # 31
ok(exists $seen{'edward'});             # 32
ok(exists $seen{'fargo'});              # 33
ok(exists $seen{'golfer'});             # 34
ok(exists $seen{'hilton'});             # 35
ok(! exists $seen{'icon'});             # 36
ok(! exists $seen{'jerky'});            # 37
%seen = ();

@shared = get_shared( [ \%h0, \%h1 ] );
ok($shared[0] eq 'baker');              # 38
ok($shared[1] eq 'camera');             # 39
ok($shared[2] eq 'delta');              # 40
ok($shared[3] eq 'edward');             # 41
ok($shared[4] eq 'fargo');              # 42
ok($shared[-1] eq 'golfer');            # 43

$seen{$_}++ foreach (@shared);
ok(! exists $seen{'abel'});             # 44
ok(exists $seen{'baker'});              # 45
ok(exists $seen{'camera'});             # 46
ok(exists $seen{'delta'});              # 47
ok(exists $seen{'edward'});             # 48
ok(exists $seen{'fargo'});              # 49
ok(exists $seen{'golfer'});             # 50
ok(! exists $seen{'hilton'});           # 51
ok(! exists $seen{'icon'});             # 52
ok(! exists $seen{'jerky'});            # 53
%seen = ();

$shared_ref = get_shared_ref( [ \%h0, \%h1 ] );
ok(${$shared_ref}[0] eq 'baker');       # 54
ok(${$shared_ref}[1] eq 'camera');      # 55
ok(${$shared_ref}[2] eq 'delta');       # 56
ok(${$shared_ref}[3] eq 'edward');      # 57
ok(${$shared_ref}[4] eq 'fargo');       # 58
ok(${$shared_ref}[-1] eq 'golfer');     # 59

$seen{$_}++ foreach (@{$shared_ref});
ok(! exists $seen{'abel'});             # 60
ok(exists $seen{'baker'});              # 61
ok(exists $seen{'camera'});             # 62
ok(exists $seen{'delta'});              # 63
ok(exists $seen{'edward'});             # 64
ok(exists $seen{'fargo'});              # 65
ok(exists $seen{'golfer'});             # 66
ok(! exists $seen{'hilton'});           # 67
ok(! exists $seen{'icon'});             # 68
ok(! exists $seen{'jerky'});            # 69
%seen = ();

@intersection = get_intersection( [ \%h0, \%h1 ] );
ok($intersection[0] eq 'baker');        # 70
ok($intersection[1] eq 'camera');       # 71
ok($intersection[2] eq 'delta');        # 72
ok($intersection[3] eq 'edward');       # 73
ok($intersection[4] eq 'fargo');        # 74
ok($intersection[-1] eq 'golfer');      # 75

$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 76
ok(exists $seen{'baker'});              # 77
ok(exists $seen{'camera'});             # 78
ok(exists $seen{'delta'});              # 79
ok(exists $seen{'edward'});             # 80
ok(exists $seen{'fargo'});              # 81
ok(exists $seen{'golfer'});             # 82
ok(! exists $seen{'hilton'});           # 83
ok(! exists $seen{'icon'});             # 84
ok(! exists $seen{'jerky'});            # 85
%seen = ();

$intersection_ref = get_intersection_ref( [ \%h0, \%h1 ] );
ok(${$intersection_ref}[0] eq 'baker'); # 86
ok(${$intersection_ref}[1] eq 'camera');# 87
ok(${$intersection_ref}[2] eq 'delta'); # 88
ok(${$intersection_ref}[3] eq 'edward');# 89
ok(${$intersection_ref}[4] eq 'fargo'); # 90
ok(${$intersection_ref}[-1] eq 'golfer');# 91

$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});             # 92
ok(exists $seen{'baker'});              # 93
ok(exists $seen{'camera'});             # 94
ok(exists $seen{'delta'});              # 95
ok(exists $seen{'edward'});             # 96
ok(exists $seen{'fargo'});              # 97
ok(exists $seen{'golfer'});             # 98
ok(! exists $seen{'hilton'});           # 99
ok(! exists $seen{'icon'});             # 100
ok(! exists $seen{'jerky'});            # 101
%seen = ();

@unique = get_unique( [ \%h0, \%h1 ] );
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

$unique_ref = get_unique_ref( [ \%h0, \%h1 ] );
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

@complement = get_complement( [ \%h0, \%h1 ] );
ok($complement[-1] eq 'hilton');        # 124

$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 125
ok(! exists $seen{'baker'});            # 126
ok(! exists $seen{'camera'});           # 127
ok(! exists $seen{'delta'});            # 128
ok(! exists $seen{'edward'});           # 129
ok(! exists $seen{'fargo'});            # 130
ok(! exists $seen{'golfer'});           # 131
ok(exists $seen{'hilton'});             # 132
ok(! exists $seen{'icon'});             # 133
ok(! exists $seen{'jerky'});            # 134
%seen = ();

$complement_ref = get_complement_ref( [ \%h0, \%h1 ] );
ok(${$complement_ref}[-1] eq 'hilton'); # 135

$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 136
ok(! exists $seen{'baker'});            # 137
ok(! exists $seen{'camera'});           # 138
ok(! exists $seen{'delta'});            # 139
ok(! exists $seen{'edward'});           # 140
ok(! exists $seen{'fargo'});            # 141
ok(! exists $seen{'golfer'});           # 142
ok(exists $seen{'hilton'});             # 143
ok(! exists $seen{'icon'});             # 144
ok(! exists $seen{'jerky'});            # 145
%seen = ();

@symmetric_difference = get_symmetric_difference( [ \%h0, \%h1 ] );
ok($symmetric_difference[0] eq 'abel'); # 146
ok($symmetric_difference[-1] eq 'hilton');# 147

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 148
ok(! exists $seen{'baker'});            # 149
ok(! exists $seen{'camera'});           # 150
ok(! exists $seen{'delta'});            # 151
ok(! exists $seen{'edward'});           # 152
ok(! exists $seen{'fargo'});            # 153
ok(! exists $seen{'golfer'});           # 154
ok(exists $seen{'hilton'});             # 155
ok(! exists $seen{'icon'});             # 156
ok(! exists $seen{'jerky'});            # 157
%seen = ();

$symmetric_difference_ref = get_symmetric_difference_ref( [ \%h0, \%h1 ] );
ok(${$symmetric_difference_ref}[0] eq 'abel');# 158
ok(${$symmetric_difference_ref}[-1] eq 'hilton');# 159

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 160
ok(! exists $seen{'baker'});            # 161
ok(! exists $seen{'camera'});           # 162
ok(! exists $seen{'delta'});            # 163
ok(! exists $seen{'edward'});           # 164
ok(! exists $seen{'fargo'});            # 165
ok(! exists $seen{'golfer'});           # 166
ok(exists $seen{'hilton'});             # 167
ok(! exists $seen{'icon'});             # 168
ok(! exists $seen{'jerky'});            # 169
%seen = ();

@symmetric_difference = get_symdiff( [ \%h0, \%h1 ] );
ok($symmetric_difference[0] eq 'abel'); # 170
ok($symmetric_difference[-1] eq 'hilton');# 171

$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 172
ok(! exists $seen{'baker'});            # 173
ok(! exists $seen{'camera'});           # 174
ok(! exists $seen{'delta'});            # 175
ok(! exists $seen{'edward'});           # 176
ok(! exists $seen{'fargo'});            # 177
ok(! exists $seen{'golfer'});           # 178
ok(exists $seen{'hilton'});             # 179
ok(! exists $seen{'icon'});             # 180
ok(! exists $seen{'jerky'});            # 181
%seen = ();

$symmetric_difference_ref = get_symdiff_ref( [ \%h0, \%h1 ] );
ok(${$symmetric_difference_ref}[0] eq 'abel');# 182
ok(${$symmetric_difference_ref}[-1] eq 'hilton');# 183

$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 184
ok(! exists $seen{'baker'});            # 185
ok(! exists $seen{'camera'});           # 186
ok(! exists $seen{'delta'});            # 187
ok(! exists $seen{'edward'});           # 188
ok(! exists $seen{'fargo'});            # 189
ok(! exists $seen{'golfer'});           # 190
ok(exists $seen{'hilton'});             # 191
ok(! exists $seen{'icon'});             # 192
ok(! exists $seen{'jerky'});            # 193
%seen = ();

@nonintersection = get_nonintersection( [ \%h0, \%h1 ] );
ok($nonintersection[0] eq 'abel');      # 194
ok($nonintersection[-1] eq 'hilton');   # 195

$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 196
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

$nonintersection_ref = get_nonintersection_ref( [ \%h0, \%h1 ] );
ok(${$nonintersection_ref}[0] eq 'abel');# 206
ok(${$nonintersection_ref}[-1] eq 'hilton');# 207

$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 208
ok(! exists $seen{'baker'});            # 209
ok(! exists $seen{'camera'});           # 210
ok(! exists $seen{'delta'});            # 211
ok(! exists $seen{'edward'});           # 212
ok(! exists $seen{'fargo'});            # 213
ok(! exists $seen{'golfer'});           # 214
ok(exists $seen{'hilton'});             # 215
ok(! exists $seen{'icon'});             # 216
ok(! exists $seen{'jerky'});            # 217
%seen = ();

@bag = get_bag( [ \%h0, \%h1 ] );
ok($bag[0] eq 'abel');                  # 218
ok($bag[1] eq 'abel');                  # 219
ok($bag[2] eq 'baker');                 # 220
ok($bag[3] eq 'baker');                 # 221
ok($bag[4] eq 'camera');                # 222
ok($bag[5] eq 'camera');                # 223
ok($bag[6] eq 'delta');                 # 224
ok($bag[7] eq 'delta');                 # 225
ok($bag[8] eq 'delta');                 # 226
ok($bag[9] eq 'edward');                # 227
ok($bag[10] eq 'edward');               # 228
ok($bag[11] eq 'fargo');                # 229
ok($bag[12] eq 'fargo');                # 230
ok($bag[13] eq 'golfer');               # 231
ok($bag[14] eq 'golfer');               # 232
ok($bag[-1] eq 'hilton');               # 233

$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 234
ok($seen{'baker'} == 2);                # 235
ok($seen{'camera'} == 2);               # 236
ok($seen{'delta'} == 3);                # 237
ok($seen{'edward'} == 2);               # 238
ok($seen{'fargo'} == 2);                # 239
ok($seen{'golfer'} == 2);               # 240
ok($seen{'hilton'} == 1);               # 241
ok(! exists $seen{'icon'});             # 242
ok(! exists $seen{'jerky'});            # 243
%seen = ();

$bag_ref = get_bag_ref( [ \%h0, \%h1 ] );
ok(${$bag_ref}[0] eq 'abel');           # 244
ok(${$bag_ref}[1] eq 'abel');           # 245
ok(${$bag_ref}[2] eq 'baker');          # 246
ok(${$bag_ref}[3] eq 'baker');          # 247
ok(${$bag_ref}[4] eq 'camera');         # 248
ok(${$bag_ref}[5] eq 'camera');         # 249
ok(${$bag_ref}[6] eq 'delta');          # 250
ok(${$bag_ref}[7] eq 'delta');          # 251
ok(${$bag_ref}[8] eq 'delta');          # 252
ok(${$bag_ref}[9] eq 'edward');         # 253
ok(${$bag_ref}[10] eq 'edward');        # 254
ok(${$bag_ref}[11] eq 'fargo');         # 255
ok(${$bag_ref}[12] eq 'fargo');         # 256
ok(${$bag_ref}[13] eq 'golfer');        # 257
ok(${$bag_ref}[14] eq 'golfer');        # 258
ok(${$bag_ref}[-1] eq 'hilton');        # 259

$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 260
ok($seen{'baker'} == 2);                # 261
ok($seen{'camera'} == 2);               # 262
ok($seen{'delta'} == 3);                # 263
ok($seen{'edward'} == 2);               # 264
ok($seen{'fargo'} == 2);                # 265
ok($seen{'golfer'} == 2);               # 266
ok($seen{'hilton'} == 1);               # 267
ok(! exists $seen{'icon'});             # 268
ok(! exists $seen{'jerky'});            # 269
%seen = ();

$LR = is_LsubsetR( [ \%h0, \%h1 ] );
ok(! $LR);                              # 270

$RL = is_RsubsetL( [ \%h0, \%h1 ] );
ok(! $RL);                              # 271

$eqv = is_LequivalentR( [ \%h0, \%h1 ] );
ok(! $eqv);                             # 272

$eqv = is_LeqvlntR( [ \%h0, \%h1 ] );
ok(! $eqv);                             # 273

$disj = is_LdisjointR( [ \%h0, \%h1 ] );
ok(! $disj);                            # 274

$return = print_subset_chart( [ \%h0, \%h1 ] );
ok($return);                            # 275

$return = print_equivalence_chart( [ \%h0, \%h1 ] );
ok($return);                            # 276

@memb_arr = is_member_which( [ \%h0, \%h1 ], [ 'abel' ] );
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0   > ] ));# 277

@memb_arr = is_member_which( [ \%h0, \%h1 ], [ 'baker' ] );
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1 > ] ));# 278

@memb_arr = is_member_which( [ \%h0, \%h1 ], [ 'camera' ] );
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1 > ] ));# 279

@memb_arr = is_member_which( [ \%h0, \%h1 ], [ 'delta' ] );
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1 > ] ));# 280

@memb_arr = is_member_which( [ \%h0, \%h1 ], [ 'edward' ] );
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1 > ] ));# 281

@memb_arr = is_member_which( [ \%h0, \%h1 ], [ 'fargo' ] );
ok(ok_seen_a( \@memb_arr, 'fargo',  2, [ qw< 0 1 > ] ));# 282

@memb_arr = is_member_which( [ \%h0, \%h1 ], [ 'golfer' ] );
ok(ok_seen_a( \@memb_arr, 'golfer', 2, [ qw< 0 1 > ] ));# 283

@memb_arr = is_member_which( [ \%h0, \%h1 ], [ 'hilton' ] );
ok(ok_seen_a( \@memb_arr, 'hilton', 1, [ qw<   1 > ] ));# 284

@memb_arr = is_member_which( [ \%h0, \%h1 ], [ 'icon' ] );
ok(ok_seen_a( \@memb_arr, 'icon',   0, [ qw<     > ] ));# 285

@memb_arr = is_member_which( [ \%h0, \%h1 ], [ 'jerky' ] );
ok(ok_seen_a( \@memb_arr, 'jerky',  0, [ qw<     > ] ));# 286

@memb_arr = is_member_which( [ \%h0, \%h1 ], [ 'zebra' ] );
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<     > ] ));# 287

$memb_arr_ref = is_member_which_ref( [ \%h0, \%h1 ], [ 'abel' ] );
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0   > ] ));# 288

$memb_arr_ref = is_member_which_ref( [ \%h0, \%h1 ], [ 'baker' ] );
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1 > ] ));# 289

$memb_arr_ref = is_member_which_ref( [ \%h0, \%h1 ], [ 'camera' ] );
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1 > ] ));# 290

$memb_arr_ref = is_member_which_ref( [ \%h0, \%h1 ], [ 'delta' ] );
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1 > ] ));# 291

$memb_arr_ref = is_member_which_ref( [ \%h0, \%h1 ], [ 'edward' ] );
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1 > ] ));# 292

$memb_arr_ref = is_member_which_ref( [ \%h0, \%h1 ], [ 'fargo' ] );
ok(ok_seen_a( $memb_arr_ref, 'fargo',  2, [ qw< 0 1 > ] ));# 293

$memb_arr_ref = is_member_which_ref( [ \%h0, \%h1 ], [ 'golfer' ] );
ok(ok_seen_a( $memb_arr_ref, 'golfer', 2, [ qw< 0 1 > ] ));# 294

$memb_arr_ref = is_member_which_ref( [ \%h0, \%h1 ], [ 'hilton' ] );
ok(ok_seen_a( $memb_arr_ref, 'hilton', 1, [ qw<   1 > ] ));# 295

$memb_arr_ref = is_member_which_ref( [ \%h0, \%h1 ], [ 'icon' ] );
ok(ok_seen_a( $memb_arr_ref, 'icon',   0, [ qw<     > ] ));# 296

$memb_arr_ref = is_member_which_ref( [ \%h0, \%h1 ], [ 'jerky' ] );
ok(ok_seen_a( $memb_arr_ref, 'jerky',  0, [ qw<     > ] ));# 297

$memb_arr_ref = is_member_which_ref( [ \%h0, \%h1 ], [ 'zebra' ] );
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<     > ] ));# 298


$memb_hash_ref = are_members_which( [ \%h0, \%h1 ] , 
    [ qw| abel baker camera delta edward fargo golfer hilton icon jerky zebra | ]);
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0   > ] ));# 299
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1 > ] ));# 300
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1 > ] ));# 301
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1 > ] ));# 302
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1 > ] ));# 303
ok(ok_seen_h( $memb_hash_ref, 'fargo',  2, [ qw< 0 1 > ] ));# 304
ok(ok_seen_h( $memb_hash_ref, 'golfer', 2, [ qw< 0 1 > ] ));# 305
ok(ok_seen_h( $memb_hash_ref, 'hilton', 1, [ qw<   1 > ] ));# 306
ok(ok_seen_h( $memb_hash_ref, 'icon',   0, [ qw<     > ] ));# 307
ok(ok_seen_h( $memb_hash_ref, 'jerky',  0, [ qw<     > ] ));# 308
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<     > ] ));# 309

ok(is_member_any( [ \%h0, \%h1 ], [ 'abel' ] ));# 310
ok(is_member_any( [ \%h0, \%h1 ], [ 'baker' ] ));# 311
ok(is_member_any( [ \%h0, \%h1 ], [ 'camera' ] ));# 312
ok(is_member_any( [ \%h0, \%h1 ], [ 'delta' ] ));# 313
ok(is_member_any( [ \%h0, \%h1 ], [ 'edward' ] ));# 314
ok(is_member_any( [ \%h0, \%h1 ], [ 'fargo' ] ));# 315
ok(is_member_any( [ \%h0, \%h1 ], [ 'golfer' ] ));# 316
ok(is_member_any( [ \%h0, \%h1 ], [ 'hilton' ] ));# 317
ok(! is_member_any( [ \%h0, \%h1 ], [ 'icon' ] ));# 318
ok(! is_member_any( [ \%h0, \%h1 ], [ 'jerky' ] ));# 319
ok(! is_member_any( [ \%h0, \%h1 ], [ 'zebra' ] ));# 320

$memb_hash_ref = are_members_any( [ \%h0, \%h1 ],
    [ qw| abel baker camera delta edward fargo golfer hilton icon jerky zebra | ]);

ok(ok_any_h( $memb_hash_ref, 'abel',   1 ));# 321
ok(ok_any_h( $memb_hash_ref, 'baker',  1 ));# 322
ok(ok_any_h( $memb_hash_ref, 'camera', 1 ));# 323
ok(ok_any_h( $memb_hash_ref, 'delta',  1 ));# 324
ok(ok_any_h( $memb_hash_ref, 'edward', 1 ));# 325
ok(ok_any_h( $memb_hash_ref, 'fargo',  1 ));# 326
ok(ok_any_h( $memb_hash_ref, 'golfer', 1 ));# 327
ok(ok_any_h( $memb_hash_ref, 'hilton', 1 ));# 328
ok(ok_any_h( $memb_hash_ref, 'icon',   0 ));# 329
ok(ok_any_h( $memb_hash_ref, 'jerky',  0 ));# 330
ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));# 331

$vers = get_version;
ok($vers);                              # 332

$LR = is_LsubsetR([ \%h2, \%h3 ]);
ok(! $LR);                              # 333

$RL = is_RsubsetL([ \%h2, \%h3 ]);
ok($RL);                                # 334

$eqv = is_LequivalentR([ \%h2, \%h3 ]);
ok(! $eqv);                             # 335

$eqv = is_LeqvlntR([ \%h2, \%h3 ]);
ok(! $eqv);                             # 336

$eqv = is_LequivalentR([ \%h3, \%h4 ]);
ok($eqv);                               # 337

$eqv = is_LeqvlntR([ \%h3, \%h4 ]);
ok($eqv);                               # 338

$disj = is_LdisjointR( [ \%h3, \%h4 ] );
ok(! $disj);                            # 339

$disj = is_LdisjointR( [ \%h4, \%h8 ] );
ok($disj);                              # 340

########## BELOW:  Tests for '-u' option ##########

@union = get_union('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});               # 341
ok(exists $seen{'baker'});              # 342
ok(exists $seen{'camera'});             # 343
ok(exists $seen{'delta'});              # 344
ok(exists $seen{'edward'});             # 345
ok(exists $seen{'fargo'});              # 346
ok(exists $seen{'golfer'});             # 347
ok(exists $seen{'hilton'});             # 348
ok(! exists $seen{'icon'});             # 349
ok(! exists $seen{'jerky'});            # 350
%seen = ();

$union_ref = get_union_ref('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});               # 351
ok(exists $seen{'baker'});              # 352
ok(exists $seen{'camera'});             # 353
ok(exists $seen{'delta'});              # 354
ok(exists $seen{'edward'});             # 355
ok(exists $seen{'fargo'});              # 356
ok(exists $seen{'golfer'});             # 357
ok(exists $seen{'hilton'});             # 358
ok(! exists $seen{'icon'});             # 359
ok(! exists $seen{'jerky'});            # 360
%seen = ();

@shared = get_shared('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@shared);
ok(! exists $seen{'abel'});             # 361
ok(exists $seen{'baker'});              # 362
ok(exists $seen{'camera'});             # 363
ok(exists $seen{'delta'});              # 364
ok(exists $seen{'edward'});             # 365
ok(exists $seen{'fargo'});              # 366
ok(exists $seen{'golfer'});             # 367
ok(! exists $seen{'hilton'});           # 368
ok(! exists $seen{'icon'});             # 369
ok(! exists $seen{'jerky'});            # 370
%seen = ();

$shared_ref = get_shared_ref('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$shared_ref});
ok(! exists $seen{'abel'});             # 371
ok(exists $seen{'baker'});              # 372
ok(exists $seen{'camera'});             # 373
ok(exists $seen{'delta'});              # 374
ok(exists $seen{'edward'});             # 375
ok(exists $seen{'fargo'});              # 376
ok(exists $seen{'golfer'});             # 377
ok(! exists $seen{'hilton'});           # 378
ok(! exists $seen{'icon'});             # 379
ok(! exists $seen{'jerky'});            # 380
%seen = ();

@intersection = get_intersection('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 381
ok(exists $seen{'baker'});              # 382
ok(exists $seen{'camera'});             # 383
ok(exists $seen{'delta'});              # 384
ok(exists $seen{'edward'});             # 385
ok(exists $seen{'fargo'});              # 386
ok(exists $seen{'golfer'});             # 387
ok(! exists $seen{'hilton'});           # 388
ok(! exists $seen{'icon'});             # 389
ok(! exists $seen{'jerky'});            # 390
%seen = ();

$intersection_ref = get_intersection_ref('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});             # 391
ok(exists $seen{'baker'});              # 392
ok(exists $seen{'camera'});             # 393
ok(exists $seen{'delta'});              # 394
ok(exists $seen{'edward'});             # 395
ok(exists $seen{'fargo'});              # 396
ok(exists $seen{'golfer'});             # 397
ok(! exists $seen{'hilton'});           # 398
ok(! exists $seen{'icon'});             # 399
ok(! exists $seen{'jerky'});            # 400
%seen = ();

@unique = get_unique('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 401
ok(! exists $seen{'baker'});            # 402
ok(! exists $seen{'camera'});           # 403
ok(! exists $seen{'delta'});            # 404
ok(! exists $seen{'edward'});           # 405
ok(! exists $seen{'fargo'});            # 406
ok(! exists $seen{'golfer'});           # 407
ok(! exists $seen{'hilton'});           # 408
ok(! exists $seen{'icon'});             # 409
ok(! exists $seen{'jerky'});            # 410
%seen = ();

$unique_ref = get_unique_ref('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 411
ok(! exists $seen{'baker'});            # 412
ok(! exists $seen{'camera'});           # 413
ok(! exists $seen{'delta'});            # 414
ok(! exists $seen{'edward'});           # 415
ok(! exists $seen{'fargo'});            # 416
ok(! exists $seen{'golfer'});           # 417
ok(! exists $seen{'hilton'});           # 418
ok(! exists $seen{'icon'});             # 419
ok(! exists $seen{'jerky'});            # 420
%seen = ();

@complement = get_complement('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 421
ok(! exists $seen{'baker'});            # 422
ok(! exists $seen{'camera'});           # 423
ok(! exists $seen{'delta'});            # 424
ok(! exists $seen{'edward'});           # 425
ok(! exists $seen{'fargo'});            # 426
ok(! exists $seen{'golfer'});           # 427
ok(exists $seen{'hilton'});             # 428
ok(! exists $seen{'icon'});             # 429
ok(! exists $seen{'jerky'});            # 430
%seen = ();

$complement_ref = get_complement_ref('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 431
ok(! exists $seen{'baker'});            # 432
ok(! exists $seen{'camera'});           # 433
ok(! exists $seen{'delta'});            # 434
ok(! exists $seen{'edward'});           # 435
ok(! exists $seen{'fargo'});            # 436
ok(! exists $seen{'golfer'});           # 437
ok(exists $seen{'hilton'});             # 438
ok(! exists $seen{'icon'});             # 439
ok(! exists $seen{'jerky'});            # 440
%seen = ();

@symmetric_difference = get_symmetric_difference('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 441
ok(! exists $seen{'baker'});            # 442
ok(! exists $seen{'camera'});           # 443
ok(! exists $seen{'delta'});            # 444
ok(! exists $seen{'edward'});           # 445
ok(! exists $seen{'fargo'});            # 446
ok(! exists $seen{'golfer'});           # 447
ok(exists $seen{'hilton'});             # 448
ok(! exists $seen{'icon'});             # 449
ok(! exists $seen{'jerky'});            # 450
%seen = ();

$symmetric_difference_ref = get_symmetric_difference_ref('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 451
ok(! exists $seen{'baker'});            # 452
ok(! exists $seen{'camera'});           # 453
ok(! exists $seen{'delta'});            # 454
ok(! exists $seen{'edward'});           # 455
ok(! exists $seen{'fargo'});            # 456
ok(! exists $seen{'golfer'});           # 457
ok(exists $seen{'hilton'});             # 458
ok(! exists $seen{'icon'});             # 459
ok(! exists $seen{'jerky'});            # 460
%seen = ();

@symmetric_difference = get_symdiff('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 461
ok(! exists $seen{'baker'});            # 462
ok(! exists $seen{'camera'});           # 463
ok(! exists $seen{'delta'});            # 464
ok(! exists $seen{'edward'});           # 465
ok(! exists $seen{'fargo'});            # 466
ok(! exists $seen{'golfer'});           # 467
ok(exists $seen{'hilton'});             # 468
ok(! exists $seen{'icon'});             # 469
ok(! exists $seen{'jerky'});            # 470
%seen = ();

$symmetric_difference_ref = get_symdiff_ref('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 471
ok(! exists $seen{'baker'});            # 472
ok(! exists $seen{'camera'});           # 473
ok(! exists $seen{'delta'});            # 474
ok(! exists $seen{'edward'});           # 475
ok(! exists $seen{'fargo'});            # 476
ok(! exists $seen{'golfer'});           # 477
ok(exists $seen{'hilton'});             # 478
ok(! exists $seen{'icon'});             # 479
ok(! exists $seen{'jerky'});            # 480
%seen = ();

@nonintersection = get_nonintersection('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 481
ok(! exists $seen{'baker'});            # 482
ok(! exists $seen{'camera'});           # 483
ok(! exists $seen{'delta'});            # 484
ok(! exists $seen{'edward'});           # 485
ok(! exists $seen{'fargo'});            # 486
ok(! exists $seen{'golfer'});           # 487
ok(exists $seen{'hilton'});             # 488
ok(! exists $seen{'icon'});             # 489
ok(! exists $seen{'jerky'});            # 490
%seen = ();

$nonintersection_ref = get_nonintersection_ref('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 491
ok(! exists $seen{'baker'});            # 492
ok(! exists $seen{'camera'});           # 493
ok(! exists $seen{'delta'});            # 494
ok(! exists $seen{'edward'});           # 495
ok(! exists $seen{'fargo'});            # 496
ok(! exists $seen{'golfer'});           # 497
ok(exists $seen{'hilton'});             # 498
ok(! exists $seen{'icon'});             # 499
ok(! exists $seen{'jerky'});            # 500
%seen = ();

@bag = get_bag('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 501
ok($seen{'baker'} == 2);                # 502
ok($seen{'camera'} == 2);               # 503
ok($seen{'delta'} == 3);                # 504
ok($seen{'edward'} == 2);               # 505
ok($seen{'fargo'} == 2);                # 506
ok($seen{'golfer'} == 2);               # 507
ok($seen{'hilton'} == 1);               # 508
ok(! exists $seen{'icon'});             # 509
ok(! exists $seen{'jerky'});            # 510
%seen = ();

$bag_ref = get_bag_ref('-u', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 511
ok($seen{'baker'} == 2);                # 512
ok($seen{'camera'} == 2);               # 513
ok($seen{'delta'} == 3);                # 514
ok($seen{'edward'} == 2);               # 515
ok($seen{'fargo'} == 2);                # 516
ok($seen{'golfer'} == 2);               # 517
ok($seen{'hilton'} == 1);               # 518
ok(! exists $seen{'icon'});             # 519
ok(! exists $seen{'jerky'});            # 520
%seen = ();

########## BELOW:  Tests for '--unsorted' option ##########

@union = get_union('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});               # 521
ok(exists $seen{'baker'});              # 522
ok(exists $seen{'camera'});             # 523
ok(exists $seen{'delta'});              # 524
ok(exists $seen{'edward'});             # 525
ok(exists $seen{'fargo'});              # 526
ok(exists $seen{'golfer'});             # 527
ok(exists $seen{'hilton'});             # 528
ok(! exists $seen{'icon'});             # 529
ok(! exists $seen{'jerky'});            # 530
%seen = ();

$union_ref = get_union_ref('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});               # 531
ok(exists $seen{'baker'});              # 532
ok(exists $seen{'camera'});             # 533
ok(exists $seen{'delta'});              # 534
ok(exists $seen{'edward'});             # 535
ok(exists $seen{'fargo'});              # 536
ok(exists $seen{'golfer'});             # 537
ok(exists $seen{'hilton'});             # 538
ok(! exists $seen{'icon'});             # 539
ok(! exists $seen{'jerky'});            # 540
%seen = ();

@shared = get_shared('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@shared);
ok(! exists $seen{'abel'});             # 541
ok(exists $seen{'baker'});              # 542
ok(exists $seen{'camera'});             # 543
ok(exists $seen{'delta'});              # 544
ok(exists $seen{'edward'});             # 545
ok(exists $seen{'fargo'});              # 546
ok(exists $seen{'golfer'});             # 547
ok(! exists $seen{'hilton'});           # 548
ok(! exists $seen{'icon'});             # 549
ok(! exists $seen{'jerky'});            # 550
%seen = ();

$shared_ref = get_shared_ref('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$shared_ref});
ok(! exists $seen{'abel'});             # 551
ok(exists $seen{'baker'});              # 552
ok(exists $seen{'camera'});             # 553
ok(exists $seen{'delta'});              # 554
ok(exists $seen{'edward'});             # 555
ok(exists $seen{'fargo'});              # 556
ok(exists $seen{'golfer'});             # 557
ok(! exists $seen{'hilton'});           # 558
ok(! exists $seen{'icon'});             # 559
ok(! exists $seen{'jerky'});            # 560
%seen = ();

@intersection = get_intersection('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 561
ok(exists $seen{'baker'});              # 562
ok(exists $seen{'camera'});             # 563
ok(exists $seen{'delta'});              # 564
ok(exists $seen{'edward'});             # 565
ok(exists $seen{'fargo'});              # 566
ok(exists $seen{'golfer'});             # 567
ok(! exists $seen{'hilton'});           # 568
ok(! exists $seen{'icon'});             # 569
ok(! exists $seen{'jerky'});            # 570
%seen = ();

$intersection_ref = get_intersection_ref('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});             # 571
ok(exists $seen{'baker'});              # 572
ok(exists $seen{'camera'});             # 573
ok(exists $seen{'delta'});              # 574
ok(exists $seen{'edward'});             # 575
ok(exists $seen{'fargo'});              # 576
ok(exists $seen{'golfer'});             # 577
ok(! exists $seen{'hilton'});           # 578
ok(! exists $seen{'icon'});             # 579
ok(! exists $seen{'jerky'});            # 580
%seen = ();

@unique = get_unique('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 581
ok(! exists $seen{'baker'});            # 582
ok(! exists $seen{'camera'});           # 583
ok(! exists $seen{'delta'});            # 584
ok(! exists $seen{'edward'});           # 585
ok(! exists $seen{'fargo'});            # 586
ok(! exists $seen{'golfer'});           # 587
ok(! exists $seen{'hilton'});           # 588
ok(! exists $seen{'icon'});             # 589
ok(! exists $seen{'jerky'});            # 590
%seen = ();

$unique_ref = get_unique_ref('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 591
ok(! exists $seen{'baker'});            # 592
ok(! exists $seen{'camera'});           # 593
ok(! exists $seen{'delta'});            # 594
ok(! exists $seen{'edward'});           # 595
ok(! exists $seen{'fargo'});            # 596
ok(! exists $seen{'golfer'});           # 597
ok(! exists $seen{'hilton'});           # 598
ok(! exists $seen{'icon'});             # 599
ok(! exists $seen{'jerky'});            # 600
%seen = ();

@complement = get_complement('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 601
ok(! exists $seen{'baker'});            # 602
ok(! exists $seen{'camera'});           # 603
ok(! exists $seen{'delta'});            # 604
ok(! exists $seen{'edward'});           # 605
ok(! exists $seen{'fargo'});            # 606
ok(! exists $seen{'golfer'});           # 607
ok(exists $seen{'hilton'});             # 608
ok(! exists $seen{'icon'});             # 609
ok(! exists $seen{'jerky'});            # 610
%seen = ();

$complement_ref = get_complement_ref('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 611
ok(! exists $seen{'baker'});            # 612
ok(! exists $seen{'camera'});           # 613
ok(! exists $seen{'delta'});            # 614
ok(! exists $seen{'edward'});           # 615
ok(! exists $seen{'fargo'});            # 616
ok(! exists $seen{'golfer'});           # 617
ok(exists $seen{'hilton'});             # 618
ok(! exists $seen{'icon'});             # 619
ok(! exists $seen{'jerky'});            # 620
%seen = ();

@symmetric_difference = get_symmetric_difference('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 621
ok(! exists $seen{'baker'});            # 622
ok(! exists $seen{'camera'});           # 623
ok(! exists $seen{'delta'});            # 624
ok(! exists $seen{'edward'});           # 625
ok(! exists $seen{'fargo'});            # 626
ok(! exists $seen{'golfer'});           # 627
ok(exists $seen{'hilton'});             # 628
ok(! exists $seen{'icon'});             # 629
ok(! exists $seen{'jerky'});            # 630
%seen = ();

$symmetric_difference_ref = get_symmetric_difference_ref('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 631
ok(! exists $seen{'baker'});            # 632
ok(! exists $seen{'camera'});           # 633
ok(! exists $seen{'delta'});            # 634
ok(! exists $seen{'edward'});           # 635
ok(! exists $seen{'fargo'});            # 636
ok(! exists $seen{'golfer'});           # 637
ok(exists $seen{'hilton'});             # 638
ok(! exists $seen{'icon'});             # 639
ok(! exists $seen{'jerky'});            # 640
%seen = ();

@symmetric_difference = get_symdiff('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 641
ok(! exists $seen{'baker'});            # 642
ok(! exists $seen{'camera'});           # 643
ok(! exists $seen{'delta'});            # 644
ok(! exists $seen{'edward'});           # 645
ok(! exists $seen{'fargo'});            # 646
ok(! exists $seen{'golfer'});           # 647
ok(exists $seen{'hilton'});             # 648
ok(! exists $seen{'icon'});             # 649
ok(! exists $seen{'jerky'});            # 650
%seen = ();

$symmetric_difference_ref = get_symdiff_ref('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 651
ok(! exists $seen{'baker'});            # 652
ok(! exists $seen{'camera'});           # 653
ok(! exists $seen{'delta'});            # 654
ok(! exists $seen{'edward'});           # 655
ok(! exists $seen{'fargo'});            # 656
ok(! exists $seen{'golfer'});           # 657
ok(exists $seen{'hilton'});             # 658
ok(! exists $seen{'icon'});             # 659
ok(! exists $seen{'jerky'});            # 660
%seen = ();

@nonintersection = get_nonintersection('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 661
ok(! exists $seen{'baker'});            # 662
ok(! exists $seen{'camera'});           # 663
ok(! exists $seen{'delta'});            # 664
ok(! exists $seen{'edward'});           # 665
ok(! exists $seen{'fargo'});            # 666
ok(! exists $seen{'golfer'});           # 667
ok(exists $seen{'hilton'});             # 668
ok(! exists $seen{'icon'});             # 669
ok(! exists $seen{'jerky'});            # 670
%seen = ();

$nonintersection_ref = get_nonintersection_ref('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 671
ok(! exists $seen{'baker'});            # 672
ok(! exists $seen{'camera'});           # 673
ok(! exists $seen{'delta'});            # 674
ok(! exists $seen{'edward'});           # 675
ok(! exists $seen{'fargo'});            # 676
ok(! exists $seen{'golfer'});           # 677
ok(exists $seen{'hilton'});             # 678
ok(! exists $seen{'icon'});             # 679
ok(! exists $seen{'jerky'});            # 680
%seen = ();

@bag = get_bag('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 681
ok($seen{'baker'} == 2);                # 682
ok($seen{'camera'} == 2);               # 683
ok($seen{'delta'} == 3);                # 684
ok($seen{'edward'} == 2);               # 685
ok($seen{'fargo'} == 2);                # 686
ok($seen{'golfer'} == 2);               # 687
ok($seen{'hilton'} == 1);               # 688
ok(! exists $seen{'icon'});             # 689
ok(! exists $seen{'jerky'});            # 690
%seen = ();

$bag_ref = get_bag_ref('--unsorted', [ \%h0, \%h1 ]);
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 691
ok($seen{'baker'} == 2);                # 692
ok($seen{'camera'} == 2);               # 693
ok($seen{'delta'} == 3);                # 694
ok($seen{'edward'} == 2);               # 695
ok($seen{'fargo'} == 2);                # 696
ok($seen{'golfer'} == 2);               # 697
ok($seen{'hilton'} == 1);               # 698
ok(! exists $seen{'icon'});             # 699
ok(! exists $seen{'jerky'});            # 700
%seen = ();



