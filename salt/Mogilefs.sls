mysql-devel:
  pkg.installed:
    - version: 5.1.73-8.el6_8
gcc:
  pkg.installed:
    - version: 4.4.7-18.el6
    - require:
      - mysql-devel
perl-CPAN:
  pkg.installed:
    - version: 1.9402-144.el6
    - require:
      - gcc 
cpan_config:
  file.managed:
   - name: /usr/share/perl5/CPAN/Config.pm
   - source: salt://files/Config.pm
   - require:
     - perl-CPAN
mogilefs_user:
  user.present:
    - name: mogilefs
    - system: True
mogilefs-server-script:
  cmd.script:
    - source: salt://files/mogilefs-server.sh
    - require:
      - perl-CPAN
mogiles_directory:
  file.directory:
    - name: /etc/mogilefs/
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - require:
      - mogilefs-server-script
{%- if salt['grains.get']('Langfang-cnc') == 'mogilefs_tracker' %}
mogilefs_tracker_conf:
  file.managed:
    - name: /etc/mogilefs/mogilefsd.conf
    - source: salt://files/mogilefsd.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - mogiles_directory
{%- elif salt['grains.get']('Langfang-cnc') == 'mogilefs_store' %}
mogilefs_store_conf:
  file.managed:
    - name: /etc/mogilefs/mogstored.conf
    - source: salt://files/mogilefsd.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - mogiles_directory
{%- endif %}
{% if salt['grains.get']('Langfang-cnc') == 'mogilefs_tracker' -%}
mogile_trucker_init:
  file.managed:
    - source: salt://files/mogile_trucker
    - name: /etc/init.d/mogile_trucker
    - user: root
    - group: root
    - mode: 755
    - require:
      - mogilefs_tracker_conf
{%- elif salt['grains.get']('Langfang-cnc') == 'mogilefs_store' -%}
mogile_storage_init:
  file.managed:
    - source: salt://files/mogile_storage
    - name: /etc/init.d/mogile_storage
    - user: root
    - group: root
    - mode: 755
    - require:
      - mogilefs_store_conf
{%- endif %}
