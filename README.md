[![Build Status](https://travis-ci.com/worthmine/usw.svg?branch=master)](https://travis-ci.com/worthmine/usw)
# NAME

usw - use utf8; use strict; use warnings; In one line.

# SYNOPSIS

    use usw; # just 8 bytes for instead of below:
    use utf8;
    use strict;
    use warnings;
    binmode \*STDOUT, ':encoding(UTF-8)';
    binmode \*STDERR, ':encoding(UTF-8)';
     

# DESCRIPTION

usw is a shortcut mainly for one-liner.

# LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Yuki Yoshida([worthmine](https://github.com/worthmine))
