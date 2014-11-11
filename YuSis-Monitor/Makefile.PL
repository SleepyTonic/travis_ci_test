use 5.018002;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'YuSis::Monitor',
    VERSION_FROM      => 'lib/YuSis/Monitor.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/YuSis/Monitor.pm', # retrieve abstract from module
       AUTHOR         => 'Derek <sleepytonic@gmail.com>') : ()),
);
