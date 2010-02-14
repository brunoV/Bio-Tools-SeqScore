package Bio::Tools::SeqScore;
use Moose;
use MooseX::Types::Moose qw(CodeRef);
use MooseX::Types::Common::Numeric qw(PositiveInt);
use Bio::SlidingWindow score_iterator => { -as => '_score_iterator' };

use namespace::autoclean;

has _function => (
    is       => 'ro',
    required => 1,
    isa      => CodeRef,
    init_arg => 'function',
);

has window_size => (
    is      => 'ro',
    isa     => PositiveInt,
    default => 7,
);

has step => (
    is => 'ro',
    isa => PositiveInt,
    default => 1,
);

sub score {
    my $self = shift;

    my $it = $self->score_iterator(@_);

    my @score;
    while ( my $r = $it->() ) { push @score, $r }

    return @score;
}

sub score_iterator {

    my ($self, $sequence, %args) = @_;

    $sequence or return;

    my $w = $args{window_size} // $self->window_size;
    my $s = $args{step}        // $self->step;

    my $it = _score_iterator(
        sequence    => \$sequence,
        function    => $self->_function,
        window_size => $w,
        step        => $s
    );

    return $it;
}

__PACKAGE__->meta->make_immutable;
1;
