use warnings;
use Module::Build;

my $builder = Module::Build->new(
    dist_name           => 'wanfaild',
    license             => 'gpl',
    dist_author         => 'Steven Pritchard <steve@computerroom.us>',
    dist_version_from   => 'wanfaild',
    requires => {
        strict                  => 0,
        warnings                => 0,
        English                 => 0,
        File::Basename          => 0,
        FileHandle              => 0,
        Getopt::Long            => 0,
        List::Util              => '1.03',
        Math::BigInt            => 0,
        #Net::DBus               => 0,
        Net::Ping               => 0,
        Net::SMTP               => 0,
        Pod::Usage              => 0,
        POSIX                   => 0,
        Socket                  => 0,
        Sys::Syslog             => 0,
        Test::More              => 0,
        Test::Pod               => '1.00',
        YAML::Tiny              => 0,
    },
    script_files => [
        'wanfaild',
        'wanfaild-notify-admin',
    ],
);

$builder->create_build_script();

# vi: set ai et:
