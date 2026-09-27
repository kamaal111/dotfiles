#!/usr/bin/perl
use strict;
use warnings;
use POSIX qw(setsid);

my $seconds = shift @ARGV;
die "Usage: with-timeout.pl SECONDS COMMAND [ARG ...]\n"
    unless defined $seconds && $seconds =~ /^[1-9][0-9]*$/ && @ARGV;

my $pid = fork();
die "fork failed: $!\n" unless defined $pid;

if ($pid == 0) {
    setsid() or die "setsid failed: $!\n";
    exec @ARGV;
    die "exec failed: $!\n";
}

my $timed_out = 0;
$SIG{ALRM} = sub {
    $timed_out = 1;
    kill 'TERM', -$pid;
    sleep 5;
    kill 'KILL', -$pid;
};

alarm $seconds;
waitpid($pid, 0);
my $status = $?;
alarm 0;

if ($timed_out) {
    warn "Dotfiles update exceeded ${seconds}s timeout\n";
    exit 124;
}
exit 128 + ($status & 127) if $status & 127;
exit $status >> 8;
