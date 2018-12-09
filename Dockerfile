FROM debian:jessie-slim
COPY ./docker-entrypoint.sh /usr/local/bin/
COPY ./sources.debian.list  /etc/apt/sources.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update
RUN apt-get install -y make flex g++ libmysqlclient-dev libmysql++-dev php5-fpm php5-mysql php5-gd nginx
RUN apt-get install -y mysql-client
RUN apt-get install -y python2.7 python3
Run apt-get install -y python-software-properties debconf-utils
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN apt-get install -y oracle-java8-installer
# code
RUN /usr/sbin/useradd -m -u 1536 judge
# clear
RUN apt-get autoremove -y && rm -rf /var/lib/apt/lists/*
#
RUN CPU=`grep "cpu cores" /proc/cpuinfo |head -1|awk '{print $4}'` \
	&& sed -i "s/post_max_size = 8M/post_max_size = 80M/g" /etc/php5/fpm/php.ini \
	&& sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 80M/g" /etc/php5/fpm/php.ini \
	&& chmod +x /usr/local/bin/docker-entrypoint.sh \
	&& ln -s /usr/local/bin/docker-entrypoint.sh  /docker-entrypoint.sh

COPY nginx/default.conf /etc/nginx/sites-available/default

WORKDIR /home/judge/
EXPOSE 80
VOLUME ["/home/judge/"]

ENTRYPOINT ["/docker-entrypoint.sh"]
