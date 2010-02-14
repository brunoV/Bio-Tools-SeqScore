use Test::More;
use Modern::Perl;

BEGIN { use_ok( "Bio::Tools::SeqScore::BiP" ) };

ok( my $bip = Bio::Tools::SeqScore::BiP->new );

my $seq = 'MAKSTNYF';

ok( my $it = $bip->score_iterator($seq) );

is( ref $it, 'CODE' );

my @scores = $bip->score($seq);

is( @scores, 2 );

my @values = map { $_->{score} } @scores;

is_deeply(
    [@values],
    [ 4 - 2 + 0 + 2 + 0 + 0 + 1, -5 + 0 + 0 - 2 + 0 + 0 + 2 ],
    "Score values are ok"
);

done_testing;
