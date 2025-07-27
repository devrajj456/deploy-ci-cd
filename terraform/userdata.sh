version: 0.0
os: linux
files:
  - source: /
    destination: /var/www/html/app
    overwrite: yes
permissions:
  - object: /var/www/html/app
    pattern: "**"
    owner: apache
    group: apache
    mode: 755
    type:
      - file
      - directory
hooks:
  BeforeInstall:
    - location: scripts/install.sh
      timeout: 300
      runas: root
  ApplicationStart:
    - location: scripts/start.sh
      timeout: 300
      runas: root
  ApplicationStop:
    - location: scripts/stop.sh
      timeout: 300
      runas: root
  ValidateService:
    - location: scripts/validate.sh
      timeout: 300
      runas: root