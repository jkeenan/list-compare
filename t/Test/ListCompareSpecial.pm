package Test::ListCompareSpecial;
# Contains test subroutines for distribution with List::Compare
# As of:  May 1, 2008
require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(
    ok_capture_error ok_seen_a  ok_seen_h ok_any_h _capture
    getseen unseen wrap_is_member_which wrap_is_member_which_ref
    wrap_are_members_which
    wrap_are_members_any
 );
our %EXPORT_TAGS = ( seen => [ qw(
    ok_capture_error ok_seen_a  ok_seen_h ok_any_h _capture
    getseen unseen wrap_is_member_which wrap_is_member_which_ref
    wrap_are_members_which
    wrap_are_members_any
    ) ],
);

sub ok_capture_error {
    my $condition = shift;
    print "\nIGNORE PRINTOUT above during 'make test TEST_VERBOSE=1'\n        testing for bad values\n";
    return $condition;
}

sub ok_seen_h {
    die "Need 4 arguments: $!" unless (@_ == 4);
    my ($mhr, $arg, $quant_expect, $expected_ref) = @_;
    my (%seen, $score);
    $seen{$_}++ foreach (@{${$mhr}{$arg}});
    $score++ if (keys %seen == $quant_expect);
    foreach (@{$expected_ref}) {
        $score++ if exists $seen{$_};
    }
    $score == 1 + scalar(@{$expected_ref})
        ? return 1
        : return 0;
}

sub ok_seen_a {
    die "Need 4 arguments: $!" unless (@_ == 4);
    my ($mar, $arg, $quant_expect, $expected_ref) = @_;
    my (%seen, $score);
    $seen{$_}++ foreach (@{$mar});
    $score++ if (keys %seen == $quant_expect);
    foreach (@{$expected_ref}) {
        $score++ if exists $seen{$_};
    }
    $score == 1 + scalar(@{$expected_ref})
        ? return 1
        : return 0;
}

sub ok_any_h {
    die "Need 3 arguments: $!" unless (@_ == 3);
    my ($mhr, $arg, $expected) = @_;
    exists ${$mhr}{$arg} and ${$mhr}{$arg} == $expected
        ? return 1
        : return 0;
}

sub _capture { my $str = $_[0]; }

sub getseen {
    my $allref = shift;
    my @arr = @$allref;
    my (@seen);
    for (my $i=0; $i<=$#arr; $i++) {
        foreach my $j (@{$arr[$i]}) {
            $seen[$i]{$j}++;
        }
    }
    return @seen;
}

sub unseen {
    my ($seen, $nonexpected) = @_;
    my $errors = 0;
    foreach my $v ( @{ $nonexpected } ) {
        $errors++ if exists $seen->{$v};
    }
    $errors ? 0 : 1;
}

sub wrap_is_member_which {
    my $obj = shift;
    my $args = shift;
    my $correct = 0;
    foreach my $v ( keys %{ $args } ) {
        my @found = $obj->is_member_which($v);
        $correct++ if ok_seen_a( \@found, $v, @{ $args->{$v} } );
    }
    ($correct == scalar keys %{ $args }) ? 1 : 0;
}

sub wrap_is_member_which_ref {
    my $obj = shift;
    my $args = shift;
    my $correct = 0;
    foreach my $v ( keys %{ $args } ) {
        my $memb_arr_ref = $obj->is_member_which_ref($v);
        $correct++ if ok_seen_a( $memb_arr_ref, $v, @{ $args->{$v} } );
    }
    ($correct == scalar keys %{ $args }) ? 1 : 0;
}

sub wrap_are_members_which {
    my $memb_hash_ref = shift;
    my $args = shift;
    my $correct = 0;
    foreach my $v ( keys %{ $args } ) {
        $correct++ if ok_seen_h( $memb_hash_ref, $v, @{ $args->{$v} } );
    }
    ($correct == scalar keys %{ $args }) ? 1 : 0;
}

sub wrap_are_members_any {
    my $memb_hash_ref = shift;
    my $args = shift;
    my $correct = 0;
    foreach my $v ( keys %{ $args } ) {
        $correct++ if ok_any_h( $memb_hash_ref, $v, $args->{$v} );
    }
    ($correct == scalar keys %{ $args }) ? 1 : 0;
}
