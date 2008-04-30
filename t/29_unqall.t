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
ok($loaded);

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
ok($lc);

$unique_all_ref = $lc->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'hilton');

$complement_all_ref = $lc->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'hilton');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'abel');

##########
## 02 equivalent

$lca   = List::Compare->new('-a', \@a0, \@a1);
ok($lca);

$unique_all_ref = $lca->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'hilton');

$complement_all_ref = $lca->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'hilton');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'abel');

##########
## 03 equivalent

$lcm   = List::Compare->new(\@a0, \@a1, \@a2, \@a3, \@a4);
ok($lcm);

$unique_all_ref = $lcm->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(! @{$seen[1]});
ok(@{$seen[2]} == 1);
ok($seen[2][0] eq 'jerky');
ok(! @{$seen[3]});
ok(! @{$seen[4]});

$complement_all_ref = $lcm->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);
ok($seen[0][0] eq 'hilton');
ok($seen[0][1] eq 'icon');
ok($seen[0][2] eq 'jerky');
ok(@{$seen[1]} == 3);
ok($seen[1][0] eq 'abel');
ok($seen[1][1] eq 'icon');
ok($seen[1][2] eq 'jerky');
ok(@{$seen[2]} == 5);
ok($seen[2][0] eq 'abel');
ok($seen[2][1] eq 'baker');
ok($seen[2][2] eq 'camera');
ok($seen[2][3] eq 'delta');
ok($seen[2][4] eq 'edward');
ok(@{$seen[3]} == 6);
ok($seen[3][0] eq 'abel');
ok($seen[3][1] eq 'baker');
ok($seen[3][2] eq 'camera');
ok($seen[3][3] eq 'delta');
ok($seen[3][4] eq 'edward');
ok($seen[3][5] eq 'jerky');
ok(@{$seen[4]} == 6);
ok($seen[4][0] eq 'abel');
ok($seen[4][1] eq 'baker');
ok($seen[4][2] eq 'camera');
ok($seen[4][3] eq 'delta');
ok($seen[4][4] eq 'edward');
ok($seen[4][5] eq 'jerky');

##########
## 09 equivalent

$lcma   = List::Compare->new('-a', \@a0, \@a1, \@a2, \@a3, \@a4);
ok($lcma);

$unique_all_ref = $lcma->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(! @{$seen[1]});
ok(@{$seen[2]} == 1);
ok($seen[2][0] eq 'jerky');
ok(! @{$seen[3]});
ok(! @{$seen[4]});

$complement_all_ref = $lcma->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);
ok($seen[0][0] eq 'hilton');
ok($seen[0][1] eq 'icon');
ok($seen[0][2] eq 'jerky');
ok(@{$seen[1]} == 3);
ok($seen[1][0] eq 'abel');
ok($seen[1][1] eq 'icon');
ok($seen[1][2] eq 'jerky');
ok(@{$seen[2]} == 5);
ok($seen[2][0] eq 'abel');
ok($seen[2][1] eq 'baker');
ok($seen[2][2] eq 'camera');
ok($seen[2][3] eq 'delta');
ok($seen[2][4] eq 'edward');
ok(@{$seen[3]} == 6);
ok($seen[3][0] eq 'abel');
ok($seen[3][1] eq 'baker');
ok($seen[3][2] eq 'camera');
ok($seen[3][3] eq 'delta');
ok($seen[3][4] eq 'edward');
ok($seen[3][5] eq 'jerky');
ok(@{$seen[4]} == 6);
ok($seen[4][0] eq 'abel');
ok($seen[4][1] eq 'baker');
ok($seen[4][2] eq 'camera');
ok($seen[4][3] eq 'delta');
ok($seen[4][4] eq 'edward');
ok($seen[4][5] eq 'jerky');

##########
## 13 equivalent

$lcsh  = List::Compare->new(\%h0, \%h1);
ok($lcsh);

$unique_all_ref = $lcsh->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'hilton');

$complement_all_ref = $lcsh->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'hilton');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'abel');

##########
## 14 equivalent

$lcsha   = List::Compare->new('-a', \%h0, \%h1);
ok($lcsha);

$unique_all_ref = $lcsha->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'hilton');

$complement_all_ref = $lcsha->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'hilton');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'abel');

##########
## 15 equivalent

$lcmsh   = List::Compare->new(\%h0, \%h1, \%h2, \%h3, \%h4);
ok($lcmsh);

$unique_all_ref = $lcmsh->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(! @{$seen[1]});
ok(@{$seen[2]} == 1);
ok($seen[2][0] eq 'jerky');
ok(! @{$seen[3]});
ok(! @{$seen[4]});

$complement_all_ref = $lcmsh->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);
ok($seen[0][0] eq 'hilton');
ok($seen[0][1] eq 'icon');
ok($seen[0][2] eq 'jerky');
ok(@{$seen[1]} == 3);
ok($seen[1][0] eq 'abel');
ok($seen[1][1] eq 'icon');
ok($seen[1][2] eq 'jerky');
ok(@{$seen[2]} == 5);
ok($seen[2][0] eq 'abel');
ok($seen[2][1] eq 'baker');
ok($seen[2][2] eq 'camera');
ok($seen[2][3] eq 'delta');
ok($seen[2][4] eq 'edward');
ok(@{$seen[3]} == 6);
ok($seen[3][0] eq 'abel');
ok($seen[3][1] eq 'baker');
ok($seen[3][2] eq 'camera');
ok($seen[3][3] eq 'delta');
ok($seen[3][4] eq 'edward');
ok($seen[3][5] eq 'jerky');
ok(@{$seen[4]} == 6);
ok($seen[4][0] eq 'abel');
ok($seen[4][1] eq 'baker');
ok($seen[4][2] eq 'camera');
ok($seen[4][3] eq 'delta');
ok($seen[4][4] eq 'edward');
ok($seen[4][5] eq 'jerky');

##########
## 16 equivalent

$lcmash   = List::Compare->new('-a', \%h0, \%h1, \%h2, \%h3, \%h4);
ok($lcmash);

$unique_all_ref = $lcmash->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(! @{$seen[1]});
ok(@{$seen[2]} == 1);
ok($seen[2][0] eq 'jerky');
ok(! @{$seen[3]});
ok(! @{$seen[4]});

$complement_all_ref = $lcmash->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);
ok($seen[0][0] eq 'hilton');
ok($seen[0][1] eq 'icon');
ok($seen[0][2] eq 'jerky');
ok(@{$seen[1]} == 3);
ok($seen[1][0] eq 'abel');
ok($seen[1][1] eq 'icon');
ok($seen[1][2] eq 'jerky');
ok(@{$seen[2]} == 5);
ok($seen[2][0] eq 'abel');
ok($seen[2][1] eq 'baker');
ok($seen[2][2] eq 'camera');
ok($seen[2][3] eq 'delta');
ok($seen[2][4] eq 'edward');
ok(@{$seen[3]} == 6);
ok($seen[3][0] eq 'abel');
ok($seen[3][1] eq 'baker');
ok($seen[3][2] eq 'camera');
ok($seen[3][3] eq 'delta');
ok($seen[3][4] eq 'edward');
ok($seen[3][5] eq 'jerky');
ok(@{$seen[4]} == 6);
ok($seen[4][0] eq 'abel');
ok($seen[4][1] eq 'baker');
ok($seen[4][2] eq 'camera');
ok($seen[4][3] eq 'delta');
ok($seen[4][4] eq 'edward');
ok($seen[4][5] eq 'jerky');

##########
## 17 equivalent

$lc    = List::Compare->new( { lists => [ \@a0, \@a1 ] } );
ok($lc);

$unique_all_ref = $lc->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'hilton');

$complement_all_ref = $lc->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'hilton');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'abel');

##########
## 18 equivalent

$lca   = List::Compare->new( { accelerated => 1, lists => [\@a0, \@a1] } );
ok($lca);

$unique_all_ref = $lca->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'hilton');

$complement_all_ref = $lca->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'hilton');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'abel');

##########
## 19 equivalent

$lcm   = List::Compare->new( { lists => [\@a0, \@a1, \@a2, \@a3, \@a4] } );
ok($lcm);

$unique_all_ref = $lcm->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(! @{$seen[1]});
ok(@{$seen[2]} == 1);
ok($seen[2][0] eq 'jerky');
ok(! @{$seen[3]});
ok(! @{$seen[4]});

$complement_all_ref = $lcm->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);
ok($seen[0][0] eq 'hilton');
ok($seen[0][1] eq 'icon');
ok($seen[0][2] eq 'jerky');
ok(@{$seen[1]} == 3);
ok($seen[1][0] eq 'abel');
ok($seen[1][1] eq 'icon');
ok($seen[1][2] eq 'jerky');
ok(@{$seen[2]} == 5);
ok($seen[2][0] eq 'abel');
ok($seen[2][1] eq 'baker');
ok($seen[2][2] eq 'camera');
ok($seen[2][3] eq 'delta');
ok($seen[2][4] eq 'edward');
ok(@{$seen[3]} == 6);
ok($seen[3][0] eq 'abel');
ok($seen[3][1] eq 'baker');
ok($seen[3][2] eq 'camera');
ok($seen[3][3] eq 'delta');
ok($seen[3][4] eq 'edward');
ok($seen[3][5] eq 'jerky');
ok(@{$seen[4]} == 6);
ok($seen[4][0] eq 'abel');
ok($seen[4][1] eq 'baker');
ok($seen[4][2] eq 'camera');
ok($seen[4][3] eq 'delta');
ok($seen[4][4] eq 'edward');
ok($seen[4][5] eq 'jerky');

##########
## 20 equivalent

$lcma   = List::Compare->new( { accelerated => 1, lists => [\@a0, \@a1, \@a2, \@a3, \@a4] } );
ok($lcma);

$unique_all_ref = $lcma->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(! @{$seen[1]});
ok(@{$seen[2]} == 1);
ok($seen[2][0] eq 'jerky');
ok(! @{$seen[3]});
ok(! @{$seen[4]});

$complement_all_ref = $lcma->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);
ok($seen[0][0] eq 'hilton');
ok($seen[0][1] eq 'icon');
ok($seen[0][2] eq 'jerky');
ok(@{$seen[1]} == 3);
ok($seen[1][0] eq 'abel');
ok($seen[1][1] eq 'icon');
ok($seen[1][2] eq 'jerky');
ok(@{$seen[2]} == 5);
ok($seen[2][0] eq 'abel');
ok($seen[2][1] eq 'baker');
ok($seen[2][2] eq 'camera');
ok($seen[2][3] eq 'delta');
ok($seen[2][4] eq 'edward');
ok(@{$seen[3]} == 6);
ok($seen[3][0] eq 'abel');
ok($seen[3][1] eq 'baker');
ok($seen[3][2] eq 'camera');
ok($seen[3][3] eq 'delta');
ok($seen[3][4] eq 'edward');
ok($seen[3][5] eq 'jerky');
ok(@{$seen[4]} == 6);
ok($seen[4][0] eq 'abel');
ok($seen[4][1] eq 'baker');
ok($seen[4][2] eq 'camera');
ok($seen[4][3] eq 'delta');
ok($seen[4][4] eq 'edward');
ok($seen[4][5] eq 'jerky');

##########
## 21 equivalent

$lcsh  = List::Compare->new( { lists => [\%h0, \%h1] } );
ok($lcsh);

$unique_all_ref = $lcsh->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'hilton');

$complement_all_ref = $lcsh->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'hilton');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'abel');

##########
## 22 equivalent

$lcsha   = List::Compare->new( { accelerated => 1, lists => [\%h0, \%h1] } );
ok($lcsha);

$unique_all_ref = $lcsha->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'hilton');

$complement_all_ref = $lcsha->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'hilton');
ok(@{$seen[1]} == 1);
ok($seen[1][0] eq 'abel');

##########
## 23 equivalent

$lcmsh   = List::Compare->new( { lists => [\%h0, \%h1, \%h2, \%h3, \%h4] } );
ok($lcmsh);

$unique_all_ref = $lcmsh->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(! @{$seen[1]});
ok(@{$seen[2]} == 1);
ok($seen[2][0] eq 'jerky');
ok(! @{$seen[3]});
ok(! @{$seen[4]});

$complement_all_ref = $lcmsh->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);
ok($seen[0][0] eq 'hilton');
ok($seen[0][1] eq 'icon');
ok($seen[0][2] eq 'jerky');
ok(@{$seen[1]} == 3);
ok($seen[1][0] eq 'abel');
ok($seen[1][1] eq 'icon');
ok($seen[1][2] eq 'jerky');
ok(@{$seen[2]} == 5);
ok($seen[2][0] eq 'abel');
ok($seen[2][1] eq 'baker');
ok($seen[2][2] eq 'camera');
ok($seen[2][3] eq 'delta');
ok($seen[2][4] eq 'edward');
ok(@{$seen[3]} == 6);
ok($seen[3][0] eq 'abel');
ok($seen[3][1] eq 'baker');
ok($seen[3][2] eq 'camera');
ok($seen[3][3] eq 'delta');
ok($seen[3][4] eq 'edward');
ok($seen[3][5] eq 'jerky');
ok(@{$seen[4]} == 6);
ok($seen[4][0] eq 'abel');
ok($seen[4][1] eq 'baker');
ok($seen[4][2] eq 'camera');
ok($seen[4][3] eq 'delta');
ok($seen[4][4] eq 'edward');
ok($seen[4][5] eq 'jerky');

##########
## 24 equivalent

$lcmash   = List::Compare->new( { accelerated => 1, lists => [\%h0, \%h1, \%h2, \%h3, \%h4] } );
ok($lcmash);

$unique_all_ref = $lcmash->get_unique_all();
@seen = @{$unique_all_ref};
ok(@{$seen[0]} == 1);
ok($seen[0][0] eq 'abel');
ok(! @{$seen[1]});
ok(@{$seen[2]} == 1);
ok($seen[2][0] eq 'jerky');
ok(! @{$seen[3]});
ok(! @{$seen[4]});

$complement_all_ref = $lcmash->get_complement_all();
@seen = @{$complement_all_ref};
ok(@{$seen[0]} == 3);
ok($seen[0][0] eq 'hilton');
ok($seen[0][1] eq 'icon');
ok($seen[0][2] eq 'jerky');
ok(@{$seen[1]} == 3);
ok($seen[1][0] eq 'abel');
ok($seen[1][1] eq 'icon');
ok($seen[1][2] eq 'jerky');
ok(@{$seen[2]} == 5);
ok($seen[2][0] eq 'abel');
ok($seen[2][1] eq 'baker');
ok($seen[2][2] eq 'camera');
ok($seen[2][3] eq 'delta');
ok($seen[2][4] eq 'edward');
ok(@{$seen[3]} == 6);
ok($seen[3][0] eq 'abel');
ok($seen[3][1] eq 'baker');
ok($seen[3][2] eq 'camera');
ok($seen[3][3] eq 'delta');
ok($seen[3][4] eq 'edward');
ok($seen[3][5] eq 'jerky');
ok(@{$seen[4]} == 6);
ok($seen[4][0] eq 'abel');
ok($seen[4][1] eq 'baker');
ok($seen[4][2] eq 'camera');
ok($seen[4][3] eq 'delta');
ok($seen[4][4] eq 'edward');
ok($seen[4][5] eq 'jerky');





