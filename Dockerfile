FROM penguinzmedia/ansible
LABEL maintainer="Penguinz Media Group LLC"
COPY . /opt/manager/
COPY nginx/wp-config.conf /srv/global/config/wordpress.conf
COPY wp-config.php /srv/local/config/wp-config.php
COPY hosts /etc/ansible/hosts
RUN apt-get update && apt-get -y full-upgrade && apt-get install -y python3 python3-pip cron && apt-get clean
ENV directory="/opt/woocommerce"
ENV database_name="database_name"
ENV database_user="username_here"
ENV database_password="password_here"
ENV database_host="localhost"
ENV database_port="port"
ENV wp_config="/srv/local/config/wp-config.php"
ENV user_name="user"
ENV user_password="password"
ENV user_email="email"
RUN ["ansible-playbook", "/opt/manager/upstart.yml"]
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log
CMD ["bash","/opt/manager/upstart.sh"]


