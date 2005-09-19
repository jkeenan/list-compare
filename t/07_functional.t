# 07_functional.t # as of 8/4/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
706;
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

@union = get_union( [ \@a0, \@a1 ] );
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

$union_ref = get_union_ref( [ \@a0, \@a1 ] );
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

@shared = get_shared( [ \@a0, \@a1 ] );
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

$shared_ref = get_shared_ref( [ \@a0, \@a1 ] );
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

@intersection = get_intersection( [ \@a0, \@a1 ] );
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

$intersection_ref = get_intersection_ref( [ \@a0, \@a1 ] );
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

@unique = get_unique( [ \@a0, \@a1 ] );
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

$unique_ref = get_unique_ref( [ \@a0, \@a1 ] );
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

@complement = get_complement( [ \@a0, \@a1 ] );
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

$complement_ref = get_complement_ref( [ \@a0, \@a1 ] );
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

@symmetric_difference = get_symmetric_difference( [ \@a0, \@a1 ] );
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

$symmetric_difference_ref = get_symmetric_difference_ref( [ \@a0, \@a1 ] );
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

@symmetric_difference = get_symdiff( [ \@a0, \@a1 ] );
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

$symmetric_difference_ref = get_symdiff_ref( [ \@a0, \@a1 ] );
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

@nonintersection = get_nonintersection( [ \@a0, \@a1 ] );
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

$nonintersection_ref = get_nonintersection_ref( [ \@a0, \@a1 ] );
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

@bag = get_bag( [ \@a0, \@a1 ] );
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

$bag_ref = get_bag_ref( [ \@a0, \@a1 ] );
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

$LR = is_LsubsetR( [ \@a0, \@a1 ] );
ok(! $LR);                              # 270

$RL = is_RsubsetL( [ \@a0, \@a1 ] );
ok(! $RL);                              # 271

$eqv = is_LequivalentR( [ \@a0, \@a1 ] );
ok(! $eqv);                             # 272

$eqv = is_LeqvlntR( [ \@a0, \@a1 ] );
ok(! $eqv);                             # 273

$disj = is_LdisjointR( [ \@a0, \@a1 ] );
ok(! $disj);                            # 274

$return = print_subset_chart( [ \@a0, \@a1 ] );
ok($return);                            # 275

$return = print_equivalence_chart( [ \@a0, \@a1 ] );
ok($return);                            # 276

@memb_arr = is_member_which( [ \@a0, \@a1 ] , [ 'abel' ] );
ok(ok_seen_a( \@memb_arr, 'abel',   1, [ qw< 0   > ] ));# 277

@memb_arr = is_member_which( [ \@a0, \@a1 ] , [ 'baker' ] );
ok(ok_seen_a( \@memb_arr, 'baker',  2, [ qw< 0 1 > ] ));# 278

@memb_arr = is_member_which( [ \@a0, \@a1 ] , [ 'camera' ] );
ok(ok_seen_a( \@memb_arr, 'camera', 2, [ qw< 0 1 > ] ));# 279

@memb_arr = is_member_which( [ \@a0, \@a1 ] , [ 'delta' ] );
ok(ok_seen_a( \@memb_arr, 'delta',  2, [ qw< 0 1 > ] ));# 280

@memb_arr = is_member_which( [ \@a0, \@a1 ] , [ 'edward' ] );
ok(ok_seen_a( \@memb_arr, 'edward', 2, [ qw< 0 1 > ] ));# 281

@memb_arr = is_member_which( [ \@a0, \@a1 ] , [ 'fargo' ] );
ok(ok_seen_a( \@memb_arr, 'fargo',  2, [ qw< 0 1 > ] ));# 282

@memb_arr = is_member_which( [ \@a0, \@a1 ] , [ 'golfer' ] );
ok(ok_seen_a( \@memb_arr, 'golfer', 2, [ qw< 0 1 > ] ));# 283

@memb_arr = is_member_which( [ \@a0, \@a1 ] , [ 'hilton' ] );
ok(ok_seen_a( \@memb_arr, 'hilton', 1, [ qw<   1 > ] ));# 284

@memb_arr = is_member_which( [ \@a0, \@a1 ] , [ 'icon' ] );
ok(ok_seen_a( \@memb_arr, 'icon',   0, [ qw<     > ] ));# 285

@memb_arr = is_member_which( [ \@a0, \@a1 ] , [ 'jerky' ] );
ok(ok_seen_a( \@memb_arr, 'jerky',  0, [ qw<     > ] ));# 286

@memb_arr = is_member_which( [ \@a0, \@a1 ] , [ 'zebra' ] );
ok(ok_seen_a( \@memb_arr, 'zebra',  0, [ qw<     > ] ));# 287

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1 ] , [ 'abel' ] );
ok(ok_seen_a( $memb_arr_ref, 'abel',   1, [ qw< 0   > ] ));# 288

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1 ] , [ 'baker' ] );
ok(ok_seen_a( $memb_arr_ref, 'baker',  2, [ qw< 0 1 > ] ));# 289

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1 ] , [ 'camera' ] );
ok(ok_seen_a( $memb_arr_ref, 'camera', 2, [ qw< 0 1 > ] ));# 290

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1 ] , [ 'delta' ] );
ok(ok_seen_a( $memb_arr_ref, 'delta',  2, [ qw< 0 1 > ] ));# 291

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1 ] , [ 'edward' ] );
ok(ok_seen_a( $memb_arr_ref, 'edward', 2, [ qw< 0 1 > ] ));# 292

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1 ] , [ 'fargo' ] );
ok(ok_seen_a( $memb_arr_ref, 'fargo',  2, [ qw< 0 1 > ] ));# 293

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1 ] , [ 'golfer' ] );
ok(ok_seen_a( $memb_arr_ref, 'golfer', 2, [ qw< 0 1 > ] ));# 294

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1 ] , [ 'hilton' ] );
ok(ok_seen_a( $memb_arr_ref, 'hilton', 1, [ qw<   1 > ] ));# 295

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1 ] , [ 'icon' ] );
ok(ok_seen_a( $memb_arr_ref, 'icon',   0, [ qw<     > ] ));# 296

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1 ] , [ 'jerky' ] );
ok(ok_seen_a( $memb_arr_ref, 'jerky',  0, [ qw<     > ] ));# 297

$memb_arr_ref = is_member_which_ref( [ \@a0, \@a1 ] , [ 'zebra' ] );
ok(ok_seen_a( $memb_arr_ref, 'zebra',  0, [ qw<     > ] ));# 298

eval { $memb_arr_ref = is_member_which_ref('jerky', 'zebra') };
ok(ok_capture_error($@));               # 299

eval { $memb_arr_ref = is_member_which_ref( [ \@a0, \@a1 ] ) };
ok(ok_capture_error($@));               # 300

eval { $memb_arr_ref = is_member_which_ref( [ \@a0, \@a1 ] , [ 'jerky' ], [ 'test' ] ) };
ok(ok_capture_error($@));               # 301

$memb_hash_ref = are_members_which(
     [ \@a0, \@a1 ] , 
[ qw| abel baker camera delta edward fargo golfer hilton icon jerky zebra | ] );
ok(ok_seen_h( $memb_hash_ref, 'abel',   1, [ qw< 0   > ] ));# 302
ok(ok_seen_h( $memb_hash_ref, 'baker',  2, [ qw< 0 1 > ] ));# 303
ok(ok_seen_h( $memb_hash_ref, 'camera', 2, [ qw< 0 1 > ] ));# 304
ok(ok_seen_h( $memb_hash_ref, 'delta',  2, [ qw< 0 1 > ] ));# 305
ok(ok_seen_h( $memb_hash_ref, 'edward', 2, [ qw< 0 1 > ] ));# 306
ok(ok_seen_h( $memb_hash_ref, 'fargo',  2, [ qw< 0 1 > ] ));# 307
ok(ok_seen_h( $memb_hash_ref, 'golfer', 2, [ qw< 0 1 > ] ));# 308
ok(ok_seen_h( $memb_hash_ref, 'hilton', 1, [ qw<   1 > ] ));# 309
ok(ok_seen_h( $memb_hash_ref, 'icon',   0, [ qw<     > ] ));# 310
ok(ok_seen_h( $memb_hash_ref, 'jerky',  0, [ qw<     > ] ));# 311
ok(ok_seen_h( $memb_hash_ref, 'zebra',  0, [ qw<     > ] ));# 312

ok(is_member_any( [ \@a0, \@a1 ] , [ 'abel' ] ));# 313
ok(is_member_any( [ \@a0, \@a1 ] , [ 'baker' ] ));# 314
ok(is_member_any( [ \@a0, \@a1 ] , [ 'camera' ] ));# 315
ok(is_member_any( [ \@a0, \@a1 ] , [ 'delta' ] ));# 316
ok(is_member_any( [ \@a0, \@a1 ] , [ 'edward' ] ));# 317
ok(is_member_any( [ \@a0, \@a1 ] , [ 'fargo' ] ));# 318
ok(is_member_any( [ \@a0, \@a1 ] , [ 'golfer' ] ));# 319
ok(is_member_any( [ \@a0, \@a1 ] , [ 'hilton' ] ));# 320
ok(! is_member_any( [ \@a0, \@a1 ] , [ 'icon' ] ));# 321
ok(! is_member_any( [ \@a0, \@a1 ] , [ 'jerky' ] ));# 322
ok(! is_member_any( [ \@a0, \@a1 ] , [ 'zebra' ] ));# 323

eval { is_member_any('jerky', 'zebra') };
ok(ok_capture_error($@));               # 324

eval { is_member_any( [ \@a0, \@a1 ] ) };
ok(ok_capture_error($@));               # 325

eval { is_member_any( [ \@a0, \@a1 ] , [ 'jerky' ], [ 'test' ] ) };
ok(ok_capture_error($@));               # 326

$memb_hash_ref = are_members_any(  [ \@a0, \@a1 ] , 
    [ qw| abel baker camera delta edward fargo 
          golfer hilton icon jerky zebra | ] );
ok(ok_any_h( $memb_hash_ref, 'abel',   1 ));# 327
ok(ok_any_h( $memb_hash_ref, 'baker',  1 ));# 328
ok(ok_any_h( $memb_hash_ref, 'camera', 1 ));# 329
ok(ok_any_h( $memb_hash_ref, 'delta',  1 ));# 330
ok(ok_any_h( $memb_hash_ref, 'edward', 1 ));# 331
ok(ok_any_h( $memb_hash_ref, 'fargo',  1 ));# 332
ok(ok_any_h( $memb_hash_ref, 'golfer', 1 ));# 333
ok(ok_any_h( $memb_hash_ref, 'hilton', 1 ));# 334
ok(ok_any_h( $memb_hash_ref, 'icon',   0 ));# 335
ok(ok_any_h( $memb_hash_ref, 'jerky',  0 ));# 336
ok(ok_any_h( $memb_hash_ref, 'zebra',  0 ));# 337

$vers = get_version;
ok($vers);                              # 338

$LR = is_LsubsetR( [ \@a2, \@a3 ] );
ok(! $LR);                              # 339

$RL = is_RsubsetL( [ \@a2, \@a3 ] );
ok($RL);                                # 340

$eqv = is_LequivalentR( [ \@a2, \@a3 ] );
ok(! $eqv);                             # 341

$eqv = is_LeqvlntR( [ \@a2, \@a3 ] );
ok(! $eqv);                             # 342

$eqv = is_LequivalentR( [ \@a3, \@a4 ] );
ok($eqv);                               # 343

$eqv = is_LeqvlntR( [ \@a3, \@a4 ] );
ok($eqv);                               # 344

$disj = is_LdisjointR( [ \@a3, \@a4 ] );
ok(! $disj);                            # 345

$disj = is_LdisjointR( [ \@a4, \@a8 ] );
ok($disj);                              # 346

########## BELOW:  Tests for '-u' option ##########

@union = get_union('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@union);
ok(exists $seen{'abel'});               # 347
ok(exists $seen{'baker'});              # 348
ok(exists $seen{'camera'});             # 349
ok(exists $seen{'delta'});              # 350
ok(exists $seen{'edward'});             # 351
ok(exists $seen{'fargo'});              # 352
ok(exists $seen{'golfer'});             # 353
ok(exists $seen{'hilton'});             # 354
ok(! exists $seen{'icon'});             # 355
ok(! exists $seen{'jerky'});            # 356
%seen = ();

$union_ref = get_union_ref('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});               # 357
ok(exists $seen{'baker'});              # 358
ok(exists $seen{'camera'});             # 359
ok(exists $seen{'delta'});              # 360
ok(exists $seen{'edward'});             # 361
ok(exists $seen{'fargo'});              # 362
ok(exists $seen{'golfer'});             # 363
ok(exists $seen{'hilton'});             # 364
ok(! exists $seen{'icon'});             # 365
ok(! exists $seen{'jerky'});            # 366
%seen = ();

@shared = get_shared('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@shared);
ok(! exists $seen{'abel'});             # 367
ok(exists $seen{'baker'});              # 368
ok(exists $seen{'camera'});             # 369
ok(exists $seen{'delta'});              # 370
ok(exists $seen{'edward'});             # 371
ok(exists $seen{'fargo'});              # 372
ok(exists $seen{'golfer'});             # 373
ok(! exists $seen{'hilton'});           # 374
ok(! exists $seen{'icon'});             # 375
ok(! exists $seen{'jerky'});            # 376
%seen = ();

$shared_ref = get_shared_ref('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$shared_ref});
ok(! exists $seen{'abel'});             # 377
ok(exists $seen{'baker'});              # 378
ok(exists $seen{'camera'});             # 379
ok(exists $seen{'delta'});              # 380
ok(exists $seen{'edward'});             # 381
ok(exists $seen{'fargo'});              # 382
ok(exists $seen{'golfer'});             # 383
ok(! exists $seen{'hilton'});           # 384
ok(! exists $seen{'icon'});             # 385
ok(! exists $seen{'jerky'});            # 386
%seen = ();

@intersection = get_intersection('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 387
ok(exists $seen{'baker'});              # 388
ok(exists $seen{'camera'});             # 389
ok(exists $seen{'delta'});              # 390
ok(exists $seen{'edward'});             # 391
ok(exists $seen{'fargo'});              # 392
ok(exists $seen{'golfer'});             # 393
ok(! exists $seen{'hilton'});           # 394
ok(! exists $seen{'icon'});             # 395
ok(! exists $seen{'jerky'});            # 396
%seen = ();

$intersection_ref = get_intersection_ref('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});             # 397
ok(exists $seen{'baker'});              # 398
ok(exists $seen{'camera'});             # 399
ok(exists $seen{'delta'});              # 400
ok(exists $seen{'edward'});             # 401
ok(exists $seen{'fargo'});              # 402
ok(exists $seen{'golfer'});             # 403
ok(! exists $seen{'hilton'});           # 404
ok(! exists $seen{'icon'});             # 405
ok(! exists $seen{'jerky'});            # 406
%seen = ();

@unique = get_unique('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@unique);
ok(exists $seen{'abel'});               # 407
ok(! exists $seen{'baker'});            # 408
ok(! exists $seen{'camera'});           # 409
ok(! exists $seen{'delta'});            # 410
ok(! exists $seen{'edward'});           # 411
ok(! exists $seen{'fargo'});            # 412
ok(! exists $seen{'golfer'});           # 413
ok(! exists $seen{'hilton'});           # 414
ok(! exists $seen{'icon'});             # 415
ok(! exists $seen{'jerky'});            # 416
%seen = ();

$unique_ref = get_unique_ref('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$unique_ref});
ok(exists $seen{'abel'});               # 417
ok(! exists $seen{'baker'});            # 418
ok(! exists $seen{'camera'});           # 419
ok(! exists $seen{'delta'});            # 420
ok(! exists $seen{'edward'});           # 421
ok(! exists $seen{'fargo'});            # 422
ok(! exists $seen{'golfer'});           # 423
ok(! exists $seen{'hilton'});           # 424
ok(! exists $seen{'icon'});             # 425
ok(! exists $seen{'jerky'});            # 426
%seen = ();

@complement = get_complement('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 427
ok(! exists $seen{'baker'});            # 428
ok(! exists $seen{'camera'});           # 429
ok(! exists $seen{'delta'});            # 430
ok(! exists $seen{'edward'});           # 431
ok(! exists $seen{'fargo'});            # 432
ok(! exists $seen{'golfer'});           # 433
ok(exists $seen{'hilton'});             # 434
ok(! exists $seen{'icon'});             # 435
ok(! exists $seen{'jerky'});            # 436
%seen = ();

$complement_ref = get_complement_ref('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$complement_ref});
ok(! exists $seen{'abel'});             # 437
ok(! exists $seen{'baker'});            # 438
ok(! exists $seen{'camera'});           # 439
ok(! exists $seen{'delta'});            # 440
ok(! exists $seen{'edward'});           # 441
ok(! exists $seen{'fargo'});            # 442
ok(! exists $seen{'golfer'});           # 443
ok(exists $seen{'hilton'});             # 444
ok(! exists $seen{'icon'});             # 445
ok(! exists $seen{'jerky'});            # 446
%seen = ();

@symmetric_difference = get_symmetric_difference('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 447
ok(! exists $seen{'baker'});            # 448
ok(! exists $seen{'camera'});           # 449
ok(! exists $seen{'delta'});            # 450
ok(! exists $seen{'edward'});           # 451
ok(! exists $seen{'fargo'});            # 452
ok(! exists $seen{'golfer'});           # 453
ok(exists $seen{'hilton'});             # 454
ok(! exists $seen{'icon'});             # 455
ok(! exists $seen{'jerky'});            # 456
%seen = ();

$symmetric_difference_ref = get_symmetric_difference_ref('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 457
ok(! exists $seen{'baker'});            # 458
ok(! exists $seen{'camera'});           # 459
ok(! exists $seen{'delta'});            # 460
ok(! exists $seen{'edward'});           # 461
ok(! exists $seen{'fargo'});            # 462
ok(! exists $seen{'golfer'});           # 463
ok(exists $seen{'hilton'});             # 464
ok(! exists $seen{'icon'});             # 465
ok(! exists $seen{'jerky'});            # 466
%seen = ();

@symmetric_difference = get_symdiff('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 467
ok(! exists $seen{'baker'});            # 468
ok(! exists $seen{'camera'});           # 469
ok(! exists $seen{'delta'});            # 470
ok(! exists $seen{'edward'});           # 471
ok(! exists $seen{'fargo'});            # 472
ok(! exists $seen{'golfer'});           # 473
ok(exists $seen{'hilton'});             # 474
ok(! exists $seen{'icon'});             # 475
ok(! exists $seen{'jerky'});            # 476
%seen = ();

$symmetric_difference_ref = get_symdiff_ref('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 477
ok(! exists $seen{'baker'});            # 478
ok(! exists $seen{'camera'});           # 479
ok(! exists $seen{'delta'});            # 480
ok(! exists $seen{'edward'});           # 481
ok(! exists $seen{'fargo'});            # 482
ok(! exists $seen{'golfer'});           # 483
ok(exists $seen{'hilton'});             # 484
ok(! exists $seen{'icon'});             # 485
ok(! exists $seen{'jerky'});            # 486
%seen = ();

@nonintersection = get_nonintersection('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 487
ok(! exists $seen{'baker'});            # 488
ok(! exists $seen{'camera'});           # 489
ok(! exists $seen{'delta'});            # 490
ok(! exists $seen{'edward'});           # 491
ok(! exists $seen{'fargo'});            # 492
ok(! exists $seen{'golfer'});           # 493
ok(exists $seen{'hilton'});             # 494
ok(! exists $seen{'icon'});             # 495
ok(! exists $seen{'jerky'});            # 496
%seen = ();

$nonintersection_ref = get_nonintersection_ref('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$nonintersection_ref});
ok(exists $seen{'abel'});               # 497
ok(! exists $seen{'baker'});            # 498
ok(! exists $seen{'camera'});           # 499
ok(! exists $seen{'delta'});            # 500
ok(! exists $seen{'edward'});           # 501
ok(! exists $seen{'fargo'});            # 502
ok(! exists $seen{'golfer'});           # 503
ok(exists $seen{'hilton'});             # 504
ok(! exists $seen{'icon'});             # 505
ok(! exists $seen{'jerky'});            # 506
%seen = ();

@bag = get_bag('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 507
ok($seen{'baker'} == 2);                # 508
ok($seen{'camera'} == 2);               # 509
ok($seen{'delta'} == 3);                # 510
ok($seen{'edward'} == 2);               # 511
ok($seen{'fargo'} == 2);                # 512
ok($seen{'golfer'} == 2);               # 513
ok($seen{'hilton'} == 1);               # 514
ok(! exists $seen{'icon'});             # 515
ok(! exists $seen{'jerky'});            # 516
%seen = ();

$bag_ref = get_bag_ref('-u',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 517
ok($seen{'baker'} == 2);                # 518
ok($seen{'camera'} == 2);               # 519
ok($seen{'delta'} == 3);                # 520
ok($seen{'edward'} == 2);               # 521
ok($seen{'fargo'} == 2);                # 522
ok($seen{'golfer'} == 2);               # 523
ok($seen{'hilton'} == 1);               # 524
ok(! exists $seen{'icon'});             # 525
ok(! exists $seen{'jerky'});            # 526
%seen = ();

##### BELOW:  Tests for '--unsorted' option ##########

@union = get_union('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@union);
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

$union_ref = get_union_ref('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$union_ref});
ok(exists $seen{'abel'});               # 537
ok(exists $seen{'baker'});              # 538
ok(exists $seen{'camera'});             # 539
ok(exists $seen{'delta'});              # 540
ok(exists $seen{'edward'});             # 541
ok(exists $seen{'fargo'});              # 542
ok(exists $seen{'golfer'});             # 543
ok(exists $seen{'hilton'});             # 544
ok(! exists $seen{'icon'});             # 545
ok(! exists $seen{'jerky'});            # 546
%seen = ();

@shared = get_shared('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@shared);
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

$shared_ref = get_shared_ref('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$shared_ref});
ok(! exists $seen{'abel'});             # 557
ok(exists $seen{'baker'});              # 558
ok(exists $seen{'camera'});             # 559
ok(exists $seen{'delta'});              # 560
ok(exists $seen{'edward'});             # 561
ok(exists $seen{'fargo'});              # 562
ok(exists $seen{'golfer'});             # 563
ok(! exists $seen{'hilton'});           # 564
ok(! exists $seen{'icon'});             # 565
ok(! exists $seen{'jerky'});            # 566
%seen = ();

@intersection = get_intersection('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@intersection);
ok(! exists $seen{'abel'});             # 567
ok(exists $seen{'baker'});              # 568
ok(exists $seen{'camera'});             # 569
ok(exists $seen{'delta'});              # 570
ok(exists $seen{'edward'});             # 571
ok(exists $seen{'fargo'});              # 572
ok(exists $seen{'golfer'});             # 573
ok(! exists $seen{'hilton'});           # 574
ok(! exists $seen{'icon'});             # 575
ok(! exists $seen{'jerky'});            # 576
%seen = ();

$intersection_ref = get_intersection_ref('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$intersection_ref});
ok(! exists $seen{'abel'});             # 577
ok(exists $seen{'baker'});              # 578
ok(exists $seen{'camera'});             # 579
ok(exists $seen{'delta'});              # 580
ok(exists $seen{'edward'});             # 581
ok(exists $seen{'fargo'});              # 582
ok(exists $seen{'golfer'});             # 583
ok(! exists $seen{'hilton'});           # 584
ok(! exists $seen{'icon'});             # 585
ok(! exists $seen{'jerky'});            # 586
%seen = ();

@unique = get_unique('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@unique);
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

$unique_ref = get_unique_ref('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$unique_ref});
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

@complement = get_complement('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@complement);
ok(! exists $seen{'abel'});             # 607
ok(! exists $seen{'baker'});            # 608
ok(! exists $seen{'camera'});           # 609
ok(! exists $seen{'delta'});            # 610
ok(! exists $seen{'edward'});           # 611
ok(! exists $seen{'fargo'});            # 612
ok(! exists $seen{'golfer'});           # 613
ok(exists $seen{'hilton'});             # 614
ok(! exists $seen{'icon'});             # 615
ok(! exists $seen{'jerky'});            # 616
%seen = ();

$complement_ref = get_complement_ref('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$complement_ref});
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

@symmetric_difference = get_symmetric_difference('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 627
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

$symmetric_difference_ref = get_symmetric_difference_ref('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 637
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

@symmetric_difference = get_symdiff('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@symmetric_difference);
ok(exists $seen{'abel'});               # 647
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

$symmetric_difference_ref = get_symdiff_ref('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$symmetric_difference_ref});
ok(exists $seen{'abel'});               # 657
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

@nonintersection = get_nonintersection('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@nonintersection);
ok(exists $seen{'abel'});               # 667
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

$nonintersection_ref = get_nonintersection_ref('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$nonintersection_ref});
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

@bag = get_bag('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@bag);
ok($seen{'abel'} == 2);                 # 687
ok($seen{'baker'} == 2);                # 688
ok($seen{'camera'} == 2);               # 689
ok($seen{'delta'} == 3);                # 690
ok($seen{'edward'} == 2);               # 691
ok($seen{'fargo'} == 2);                # 692
ok($seen{'golfer'} == 2);               # 693
ok($seen{'hilton'} == 1);               # 694
ok(! exists $seen{'icon'});             # 695
ok(! exists $seen{'jerky'});            # 696
%seen = ();

$bag_ref = get_bag_ref('--unsorted',  [ \@a0, \@a1 ] );
$seen{$_}++ foreach (@{$bag_ref});
ok($seen{'abel'} == 2);                 # 697
ok($seen{'baker'} == 2);                # 698
ok($seen{'camera'} == 2);               # 699
ok($seen{'delta'} == 3);                # 700
ok($seen{'edward'} == 2);               # 701
ok($seen{'fargo'} == 2);                # 702
ok($seen{'golfer'} == 2);               # 703
ok($seen{'hilton'} == 1);               # 704
ok(! exists $seen{'icon'});             # 705
ok(! exists $seen{'jerky'});            # 706
%seen = ();


