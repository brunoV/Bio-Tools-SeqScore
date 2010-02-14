package Bio::Tools::SeqScore::BiP;
use Moose;
extends 'Bio::Tools::SeqScore';

has '+_function' => (
    lazy     => 1,
    default  => \&_build__function,
);

has '+window_size' => ( default => 7 );
has '+step'        => ( default => 1 );

# TODO: Abstract this to a role, of a family of functions that depend on
# scoring matrices.

has _score_matrix => (
    is       => 'ro',
    init_arg => undef,
    lazy     => 1,
    builder  => '_build__score_matrix',
);

sub _build__function {

    my $self = shift;

    return sub {
        my $peptide = shift;

        my @residues = split('', $peptide);

        my ($score, $i);
        foreach my $r (@residues) {
            $score += $self->_score_matrix->{$r}[$i];
        }

        return $score;
    }
}

sub _build__score_matrix {
    return {
        W => [qw(   5  6  6  4  4  2   4 )],
        F => [qw(   7  0  8 -1  2  1   2 )],
        L => [qw(   2 -1  1  1  3  2   5 )],
        M => [qw(   4  3  0  0 -1 -2   0 )],
        I => [qw(   0  0  0  0  2  2  -1 )],
        V => [qw(   0  1 -2 -2  0 -3  -1 )],
        G => [qw(  -2  2  0 -2 -2 -1  -1 )],
        A => [qw(  -5 -2 -4  0 -1  0 -12 )],
        S => [qw(  -3 -2  0  2 -5 -3  -1 )],
        T => [qw(  -2  2 -1 -2  0  2   1 )],
        P => [qw(  -1 -5  0  1 -6 12  -1 )],
        Y => [qw(  -7 -1 -4  3 -5  0   1 )],
        N => [qw(   0  0 -6  2  0  0  -7 )],
        H => [qw(   0 -1  0 -1 -1  3  -1 )],
        R => [qw(   0 -6  2  0  1 -2  -2 )],
        K => [qw(   0  0  0 -6 -8 -2  -6 )],
        D => [qw( -10 -1 -2  0  0  0   2 )],
        E => [qw(  -2 -1 -9 -6  0  0   0 )],
        Q => [qw(  -1  1  2  0  0  0   5 )],
        C => [qw(   2  0  2  0  0  0   0 )],
    };
}

__PACKAGE__->meta->make_immutable;
1;
