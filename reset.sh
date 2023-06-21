#!/bin/bash

rm -rvf ~/workspace 													> /dev/zero 2>&1
cp -rf ~/Documents/workspace/  ~/	 										> /dev/zero 2>&1

echo -ne '#####                      (33%)\r'
sleep 1

podman rm -af                                                                                                           > /dev/null 2>&1
podman rmi -af                                                                                                          > /dev/null 2>&1

podman network rm acme-wp-net acme-troubleshoot                                                                         > /dev/null 2>&1
podman volume  rm acme-wp-backend acme-wp-app acme_wordpress_data acme-wp-backend-ts                                    > /dev/null 2>&1

podman load -i ~/ex188-scripts/registry2.tar 										> /dev/zero 2>&1
podman tag 8db46f9d7550 docker.io/library/registry:2 									> /dev/zero 2>&1

podman load -i ~/ex188-scripts/nginx.tar 										> /dev/zero 2>&1 
podman tag 080ed0ed8312 docker.io/library/nginx 									> /dev/zero 2>&1

echo -ne '###############            (49%)\r'
sleep 1

podman load -i ~/ex188-scripts/mariadb.tar 										> /dev/zero 2>&1
podman tag 4a632f970181 docker.io/library/mariadb 									> /dev/zero 2>&1

podman load -i ~/ex188-scripts/quay-wordpress.tar 									> /dev/zero 2>&1
podman tag 405d4a94038a quay.io/myacme/wordpress 									> /dev/zero 2>&1

podman load -i ~/ex188-scripts/quay-mariadb.tar 									> /dev/zero 2>&1
podman tag 61f2fdcfbad9 quay.io/myacme/mariadb  									> /dev/zero 2>&1

podman load -i ~/ex188-scripts/quay-welcome.tar 									> /dev/zero 2>&1
podman tag 9df0b4cf92bb quay.io/myacme/welcome										> /dev/zero 2>&1

podman load -i ~/ex188-scripts/quay-nginx.tar 										> /dev/zero 2>&1
podman tag 8d990e08937e quay.io/myacme/nginx 										> /dev/zero 2>&1

podman run -d -p 5000:5000 --name registry registry:2 									> /dev/null 2>&1

echo -ne '###########################(100%)\r'
sleep 1

