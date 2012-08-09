use inc::Module::Install;

name "CatalystX-Test-Most";
all_from "lib/CatalystX/Test/Most.pm";

requires "Catalyst::Test" => undef;
requires "Test::More" => undef;
requires "HTTP::Request::Common" => undef;
requires "Test::Exception" => undef;
requires "strictures" => undef;

auto_install;
WriteAll;
