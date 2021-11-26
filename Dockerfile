FROM penguinzmedia/ansible
LABEL maintainer="Penguinz Media Group LLC"
COPY . /opt/manager/
COPY configs/wp-config.conf /srv/global/config/wp-config.conf
COPY configs/wp-config.php /srv/local/config/wp-config.php
COPY hosts /etc/ansible/hosts
RUN apt-get update && apt-get -y full-upgrade && apt-get install -y python3 python3-pip cron && apt-get clean
ENV DATABASE_NAME="wordpress"
ENV DATABASE_USER="root"
ENV DATABASE_PASSWORD="p@ssword"
ENV DATABASE_HOST="localhost"
ENV DATABASE_PORT="3306"
ENV USER_NAME="admin"
ENV USER_PASSWORD="p@ssword"
ENV USER_EMAIL="admin@localhost"
ENV ORGANIZATION_NAME="name"
ENV ORGANIZATION_COUNTRY="US"
ENV ORGANIZATION_EMAIL="admin@localhost"
ENV ORGANISATION_HOSTNAME="localhost"
ENV URL="https://localhost"
RUN ansible-playbook upstart.yaml -c local --tags build,woocommerce
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log
CMD ansible-playbook upstart.yaml -c local --tags run,woocommerce



