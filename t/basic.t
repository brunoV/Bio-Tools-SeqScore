use Test::More;
use Modern::Perl;
use Test::Exception;

BEGIN { use_ok( "Bio::Tools::SeqScore" ) };

dies_ok { Bio::Tools::SeqScore->new } 'Dies without a function';

my $f = sub { return '42' };

my $s;
lives_ok { $s = Bio::Tools::SeqScore->new( function => $f ) } 'Lives';

my $sequence = "FOO" x 10;

is( $s->score_iterator, undef, "Returns undef without sequence" );

ok( my $it = $s->score_iterator($sequence), "Returns something with arg" );

is( ref $it, 'CODE', "... and it looks like an iterator" );

ok( my $score = $it->(), "kicking it works" );

is( ref $score, 'HASH', "and it returns a hashref" );

is_deeply( [ sort keys %$score ], [qw(position score sequence) ] );

is( $score->{score}, 42, "Score is taken from the function" );

done_testing;
