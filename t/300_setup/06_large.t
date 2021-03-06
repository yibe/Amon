use strict;
use warnings;
use utf8;
use Test::More;
use t::TestFlavor;
use Test::Requires {
	'String::CamelCase' => '0.02',
	'Mouse'             => '0.95', # Mouse::Util
	'Amon2::DBI'                      => '0.05',
	'DBD::SQLite'                     => '1.33',
    'Plack::Session'                  => '0.14',
};

test_flavor(sub {
    ok(!-e 'xxx');
    ok(!-e 'yyy');
    my @files = (<Amon2::*>);
    is(0+@files, 0);

    for my $dir (qw(tmpl/ tmpl/pc tmpl/admin/ static/pc static/admin)) {
        ok(-d $dir, $dir);
    }
	for my $file (qw(Makefile.PL lib/My/App.pm t/Util.pm .proverc)) {
		ok(-f $file, "$file exists");
	}
    ok((do 'lib/My/App.pm'), 'lib/My/App.pm is valid') or do {
        diag $@;
        diag do {
            open my $fh, '<', 'lib/My/App.pm' or die;
            local $/; <$fh>;
        };
    };
}, 'Large');

done_testing;

