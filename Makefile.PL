use inc::Module::Install;
name 'Bit-LabeledExtract';
all_from 'lib/Bit/LabeledExtract.pm';

requires 'List::MoreUrils';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
test_requires 'Test::Fatal';
auto_set_repository;
auto_include;
WriteAll;
