FROM trafex/alpine-nginx-php7

COPY . /var/www/html

#USER root
#RUN ls -lth && chmod -R 777 /images && stat images
#RUN /bin/bash -c 'ls -lth; chmod -R 707 /var/www/html/images; ls -lth'
#USER nobody
#COPY . /usr/share/nginx/html
EXPOSE 8080