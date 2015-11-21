package consoles::console;
use strict;
use warnings;

sub new {
    my ($class, $backend) = @_;
    my $self = bless({class => $class}, $class);
    $self->{activated} = 0;
    $self->{backend}   = $backend;
    $self->init;
    $backend->{console_classes}->{$self->{name}} = $self;
    return $self;
}

sub activate {
    my ($self, $testapi_console, $console_args) = @_;

    $self->{testapi_console} = $testapi_console;
    $self->{activated}       = 1;
    return;
}

# common way of selecting the console
sub _activate_window() {
    my ($self) = @_;

    #CORE::say __FILE__.":".__LINE__.":".bmwqemu::pp($self->{current_console});
    my $display       = $self->{DISPLAY};
    my $new_window_id = $self->{window_id};
    #CORE::say bmwqemu::pp($console_info);
    system("DISPLAY=$display xdotool windowactivate --sync $new_window_id") != -1 || die;
}

sub _kill_window() {
    my ($self)    = @_;
    my $window_id = $self->{window_id};
    my $display   = $self->{DISPLAY};
    system("DISPLAY=$display xdotool windowkill $window_id") != -1 || die;
}

1;
