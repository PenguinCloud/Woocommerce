FROM penguintech/core-ansible
LABEL maintainer="Penguinz Tech Group LLC"
COPY . /opt/manager/
ENV DATABASE_NAME="wordpress"
ENV DATABASE_USER="wordpress"
ENV DATABASE_PASSWORD="p@ssword"
ENV DATABASE_HOST="localhost"
ENV DATABASE_PORT="3306"
ENV USER_NAME="admin"
ENV USER_PASSWORD="p@ssword"
ENV USER_EMAIL="admin@localhost"
ENV ORGANIZATION_NAME="name"
ENV ORGANIZATION_COUNTRY="US"
ENV ORGANIZATION_EMAIL="admin@localhost"
ENV ORGANISATION_HOSTNAME="ptg.org"
ENV URL="https://127.0.0.1"
ENV CPU_COUNT="2"
ENV FILE_LIMIT="1042"
ARG APP_LINK="https://wordpress.org/latest.zip"
RUN ansible-playbook /opt/manager/upstart.yml -c local --tags build
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log
ENTRYPOINT ["ansible-playbook", "/opt/manager/upstart.yml", "-c", "local", "--tags", "run,exec"]
