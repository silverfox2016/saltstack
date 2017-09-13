perl-CPAN:
  pkg.installed:
    - version: 1.9402-144.el6 
config:
  file.managed:
   - name: /usr/share/perl5/CPAN/Config.pm
   - source: salt://files/Config.pm
