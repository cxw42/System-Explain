use strict;
use warnings;
use Capture::Tiny 'capture';
use Test::More;

use System::Explain 'verbose, sys';

my ($stdout, $stderr, $exit) = capture {
  sys $^X, '-e1';
};

is $exit, 0, "$^X ran OK";
like $stdout, qr{ran with normal exit}, 'expected stdout';
is $stderr, '', 'no stderr';

done_testing;
