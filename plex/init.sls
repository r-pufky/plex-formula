{% from "plex/map.jinja" import plex with context %}

plex_media_server_repo:
  pkgrepo.managed:
    - name: deb https://downloads.plex.tv/repo/deb ./public main
    - file: /etc/apt/sources.list.d/plex_media_server.list
    - key_url: salt://plex/files/PlexSign.key.gpg
    - require_in:
      - plex_media_server

plex_media_server:
  pkg.latest:
    - name: {{ plex.package }}

plex_media_server_service:
  service.running:
    - name: {{ plex.package }}
    - enable: True
    - require:
      - pkg: plex_media_server
