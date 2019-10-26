# NAME

System::Explain - run a system command and explain the result

# SYNOPSIS

    use System::Explain "command, verbose, errors";
    sys qw(ls -al);

The sys function runs a system command, checks the result, and comments on
it to STDOUT.

# DESCRIPTION

System::Explain is a standalone release of [System](https://metacpan.org/pod/System), part of [Gedcom](https://metacpan.org/pod/Gedcom)
v1.20 and earlier.

# LICENSE

Copyright (C) 2012 Paul Johnson <pjcj@cpan.org>

Also Copyright (C) 1999-2012 Paul Johnson; Copyright (C) 2019 Christopher White

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Paul Johnson <paul@pjcj.net>
