mogilefs_conf:
  file.managed:
    - name: /etc/mogilefs/mogilefsd.conf
    - source: salt://files/mogilefsd.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
