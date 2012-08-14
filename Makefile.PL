use inc::Module::Install;

name "CatalystX-Test-Most";
all_from "lib/CatalystX/Test/Most.pm";
repository "git://github.com/pangyre/p5-catalystx-test-most";

requires "Catalyst" => undef;
requires "Catalyst::Action::RenderView" => undef;
requires "Catalyst::Test" => undef;
requires "Test::More" => undef;
requires "HTTP::Request::Common" => undef;
requires "Test::Exception" => undef;
requires "strictures" => undef;

auto_install;
WriteAll;
