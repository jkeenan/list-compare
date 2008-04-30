# 30_unqall_unsorted.t  # as of 8/8/2004

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

END {print "not ok 1\n" unless $loaded;} 
use Test::Simple tests =>
249;
use lib ("./t");
use List::Compare;
use Test::ListCompareSpecial qw(:seen);

$loaded = 1;
ok($loaded);

######################### End of black magic.

my (%seen, @seen, $seenref);
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

my ($lc, $lca, $lcm, $lcsh, $lcsha, $lcmsh, $lcmash  );

##########
## 01 equivalent

$lc   = List::Compare->new('-u', \@a0, \@a1);
ok($lc);

$unique_all_ref = $lc->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[1]{'hilton'} );

$complement_all_ref = $lc->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[1]{'abel'} );

##########
## 02 equivalent

$lca   = List::Compare->new('-u', '-a', \@a0, \@a1);
ok($lca);

$unique_all_ref = $lca->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[1]{'hilton'} );

$complement_all_ref = $lca->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[1]{'abel'} );

##########
## 03 equivalent

$lcm   = List::Compare->new('-u', \@a0, \@a1, \@a2, \@a3, \@a4);
ok($lcm);

$unique_all_ref = $lcm->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[2]{'jerky'} );

$complement_all_ref = $lcm->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[0]{'icon'} );
ok( exists $seen[0]{'jerky'} );
ok( exists $seen[1]{'abel'} );
ok( exists $seen[1]{'icon'} );
ok( exists $seen[1]{'jerky'} );
ok( exists $seen[2]{'abel'} );
ok( exists $seen[2]{'baker'} );
ok( exists $seen[2]{'camera'} );
ok( exists $seen[2]{'delta'} );
ok( exists $seen[2]{'edward'} );
ok( exists $seen[3]{'abel'} );
ok( exists $seen[3]{'baker'} );
ok( exists $seen[3]{'camera'} );
ok( exists $seen[3]{'delta'} );
ok( exists $seen[3]{'edward'} );
ok( exists $seen[3]{'jerky'} );
ok( exists $seen[4]{'abel'} );
ok( exists $seen[4]{'baker'} );
ok( exists $seen[4]{'camera'} );
ok( exists $seen[4]{'delta'} );
ok( exists $seen[4]{'edward'} );
ok( exists $seen[4]{'jerky'} );

##########
## 09 equivalent

$lcma   = List::Compare->new('-u', '-a', \@a0, \@a1, \@a2, \@a3, \@a4);
ok($lcma);

$unique_all_ref = $lcma->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[2]{'jerky'} );

$complement_all_ref = $lcma->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[0]{'icon'} );
ok( exists $seen[0]{'jerky'} );
ok( exists $seen[1]{'abel'} );
ok( exists $seen[1]{'icon'} );
ok( exists $seen[1]{'jerky'} );
ok( exists $seen[2]{'abel'} );
ok( exists $seen[2]{'baker'} );
ok( exists $seen[2]{'camera'} );
ok( exists $seen[2]{'delta'} );
ok( exists $seen[2]{'edward'} );
ok( exists $seen[3]{'abel'} );
ok( exists $seen[3]{'baker'} );
ok( exists $seen[3]{'camera'} );
ok( exists $seen[3]{'delta'} );
ok( exists $seen[3]{'edward'} );
ok( exists $seen[3]{'jerky'} );
ok( exists $seen[4]{'abel'} );
ok( exists $seen[4]{'baker'} );
ok( exists $seen[4]{'camera'} );
ok( exists $seen[4]{'delta'} );
ok( exists $seen[4]{'edward'} );
ok( exists $seen[4]{'jerky'} );

##########
## 13 equivalent

$lcsh  = List::Compare->new('-u', \%h0, \%h1);
ok($lcsh);

$unique_all_ref = $lcsh->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[1]{'hilton'} );

$complement_all_ref = $lcsh->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[1]{'abel'} );

##########
## 14 equivalent

$lcsha   = List::Compare->new('-u', '-a', \%h0, \%h1);
ok($lcsha);

$unique_all_ref = $lcsha->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[1]{'hilton'} );

$complement_all_ref = $lcsha->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[1]{'abel'} );

##########
## 15 equivalent

$lcmsh   = List::Compare->new('-u', \%h0, \%h1, \%h2, \%h3, \%h4);
ok($lcmsh);

$unique_all_ref = $lcmsh->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[2]{'jerky'} );

$complement_all_ref = $lcmsh->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[0]{'icon'} );
ok( exists $seen[0]{'jerky'} );
ok( exists $seen[1]{'abel'} );
ok( exists $seen[1]{'icon'} );
ok( exists $seen[1]{'jerky'} );
ok( exists $seen[2]{'abel'} );
ok( exists $seen[2]{'baker'} );
ok( exists $seen[2]{'camera'} );
ok( exists $seen[2]{'delta'} );
ok( exists $seen[2]{'edward'} );
ok( exists $seen[3]{'abel'} );
ok( exists $seen[3]{'baker'} );
ok( exists $seen[3]{'camera'} );
ok( exists $seen[3]{'delta'} );
ok( exists $seen[3]{'edward'} );
ok( exists $seen[3]{'jerky'} );
ok( exists $seen[4]{'abel'} );
ok( exists $seen[4]{'baker'} );
ok( exists $seen[4]{'camera'} );
ok( exists $seen[4]{'delta'} );
ok( exists $seen[4]{'edward'} );
ok( exists $seen[4]{'jerky'} );

##########
## 16 equivalent

$lcmash   = List::Compare->new('-u', '-a', \%h0, \%h1, \%h2, \%h3, \%h4);
ok($lcmash);

$unique_all_ref = $lcmash->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[2]{'jerky'} );

$complement_all_ref = $lcmash->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[0]{'icon'} );
ok( exists $seen[0]{'jerky'} );
ok( exists $seen[1]{'abel'} );
ok( exists $seen[1]{'icon'} );
ok( exists $seen[1]{'jerky'} );
ok( exists $seen[2]{'abel'} );
ok( exists $seen[2]{'baker'} );
ok( exists $seen[2]{'camera'} );
ok( exists $seen[2]{'delta'} );
ok( exists $seen[2]{'edward'} );
ok( exists $seen[3]{'abel'} );
ok( exists $seen[3]{'baker'} );
ok( exists $seen[3]{'camera'} );
ok( exists $seen[3]{'delta'} );
ok( exists $seen[3]{'edward'} );
ok( exists $seen[3]{'jerky'} );
ok( exists $seen[4]{'abel'} );
ok( exists $seen[4]{'baker'} );
ok( exists $seen[4]{'camera'} );
ok( exists $seen[4]{'delta'} );
ok( exists $seen[4]{'edward'} );
ok( exists $seen[4]{'jerky'} );

##########
## 17 equivalent

$lc    = List::Compare->new( { unsorted => 1,  lists => [ \@a0, \@a1 ] } );
ok($lc);

$unique_all_ref = $lc->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[1]{'hilton'} );

$complement_all_ref = $lc->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[1]{'abel'} );

##########
## 18 equivalent

$lca   = List::Compare->new( { unsorted => 1,  accelerated => 1, lists => [\@a0, \@a1] } );
ok($lca);

$unique_all_ref = $lca->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[1]{'hilton'} );

$complement_all_ref = $lca->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[1]{'abel'} );

##########
## 19 equivalent

$lcm   = List::Compare->new( { unsorted => 1,  lists => [\@a0, \@a1, \@a2, \@a3, \@a4] } );
ok($lcm);

$unique_all_ref = $lcm->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[2]{'jerky'} );

$complement_all_ref = $lcm->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[0]{'icon'} );
ok( exists $seen[0]{'jerky'} );
ok( exists $seen[1]{'abel'} );
ok( exists $seen[1]{'icon'} );
ok( exists $seen[1]{'jerky'} );
ok( exists $seen[2]{'abel'} );
ok( exists $seen[2]{'baker'} );
ok( exists $seen[2]{'camera'} );
ok( exists $seen[2]{'delta'} );
ok( exists $seen[2]{'edward'} );
ok( exists $seen[3]{'abel'} );
ok( exists $seen[3]{'baker'} );
ok( exists $seen[3]{'camera'} );
ok( exists $seen[3]{'delta'} );
ok( exists $seen[3]{'edward'} );
ok( exists $seen[3]{'jerky'} );
ok( exists $seen[4]{'abel'} );
ok( exists $seen[4]{'baker'} );
ok( exists $seen[4]{'camera'} );
ok( exists $seen[4]{'delta'} );
ok( exists $seen[4]{'edward'} );
ok( exists $seen[4]{'jerky'} );

##########
## 20 equivalent

$lcma   = List::Compare->new( { unsorted => 1,  accelerated => 1, lists => [\@a0, \@a1, \@a2, \@a3, \@a4] } );
ok($lcma);

$unique_all_ref = $lcma->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[2]{'jerky'} );

$complement_all_ref = $lcma->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[0]{'icon'} );
ok( exists $seen[0]{'jerky'} );
ok( exists $seen[1]{'abel'} );
ok( exists $seen[1]{'icon'} );
ok( exists $seen[1]{'jerky'} );
ok( exists $seen[2]{'abel'} );
ok( exists $seen[2]{'baker'} );
ok( exists $seen[2]{'camera'} );
ok( exists $seen[2]{'delta'} );
ok( exists $seen[2]{'edward'} );
ok( exists $seen[3]{'abel'} );
ok( exists $seen[3]{'baker'} );
ok( exists $seen[3]{'camera'} );
ok( exists $seen[3]{'delta'} );
ok( exists $seen[3]{'edward'} );
ok( exists $seen[3]{'jerky'} );
ok( exists $seen[4]{'abel'} );
ok( exists $seen[4]{'baker'} );
ok( exists $seen[4]{'camera'} );
ok( exists $seen[4]{'delta'} );
ok( exists $seen[4]{'edward'} );
ok( exists $seen[4]{'jerky'} );

##########
## 21 equivalent

$lcsh  = List::Compare->new( { unsorted => 1,  lists => [\%h0, \%h1] } );
ok($lcsh);

$unique_all_ref = $lcsh->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[1]{'hilton'} );

$complement_all_ref = $lcsh->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[1]{'abel'} );

##########
## 22 equivalent

$lcsha   = List::Compare->new( { unsorted => 1,  accelerated => 1, lists => [\%h0, \%h1] } );
ok($lcsha);

$unique_all_ref = $lcsha->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[1]{'hilton'} );

$complement_all_ref = $lcsha->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[1]{'abel'} );

##########
## 23 equivalent

$lcmsh   = List::Compare->new( { unsorted => 1,  lists => [\%h0, \%h1, \%h2, \%h3, \%h4] } );
ok($lcmsh);

$unique_all_ref = $lcmsh->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[2]{'jerky'} );

$complement_all_ref = $lcmsh->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[0]{'icon'} );
ok( exists $seen[0]{'jerky'} );
ok( exists $seen[1]{'abel'} );
ok( exists $seen[1]{'icon'} );
ok( exists $seen[1]{'jerky'} );
ok( exists $seen[2]{'abel'} );
ok( exists $seen[2]{'baker'} );
ok( exists $seen[2]{'camera'} );
ok( exists $seen[2]{'delta'} );
ok( exists $seen[2]{'edward'} );
ok( exists $seen[3]{'abel'} );
ok( exists $seen[3]{'baker'} );
ok( exists $seen[3]{'camera'} );
ok( exists $seen[3]{'delta'} );
ok( exists $seen[3]{'edward'} );
ok( exists $seen[3]{'jerky'} );
ok( exists $seen[4]{'abel'} );
ok( exists $seen[4]{'baker'} );
ok( exists $seen[4]{'camera'} );
ok( exists $seen[4]{'delta'} );
ok( exists $seen[4]{'edward'} );
ok( exists $seen[4]{'jerky'} );

##########
## 24 equivalent

$lcmash   = List::Compare->new( { unsorted => 1,  accelerated => 1, lists => [\%h0, \%h1, \%h2, \%h3, \%h4] } );
ok($lcmash);

$unique_all_ref = $lcmash->get_unique_all();
@seen = getseen($unique_all_ref);
ok( exists $seen[0]{'abel'} );
ok( exists $seen[2]{'jerky'} );

$complement_all_ref = $lcmash->get_complement_all();
@seen = getseen($complement_all_ref);
ok( exists $seen[0]{'hilton'} );
ok( exists $seen[0]{'icon'} );
ok( exists $seen[0]{'jerky'} );
ok( exists $seen[1]{'abel'} );
ok( exists $seen[1]{'icon'} );
ok( exists $seen[1]{'jerky'} );
ok( exists $seen[2]{'abel'} );
ok( exists $seen[2]{'baker'} );
ok( exists $seen[2]{'camera'} );
ok( exists $seen[2]{'delta'} );
ok( exists $seen[2]{'edward'} );
ok( exists $seen[3]{'abel'} );
ok( exists $seen[3]{'baker'} );
ok( exists $seen[3]{'camera'} );
ok( exists $seen[3]{'delta'} );
ok( exists $seen[3]{'edward'} );
ok( exists $seen[3]{'jerky'} );
ok( exists $seen[4]{'abel'} );
ok( exists $seen[4]{'baker'} );
ok( exists $seen[4]{'camera'} );
ok( exists $seen[4]{'delta'} );
ok( exists $seen[4]{'edward'} );
ok( exists $seen[4]{'jerky'} );



