FROM redis:3.2

MAINTAINER Dylan <bbcheng@ikuai8.com>

###########################################################
# locale
RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive \
	apt-get install locales \
	&& locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN localedef -f UTF-8 -i en_US en_US.utf8

###########################################################
# timezone
RUN DEBIAN_FRONTEND=noninteractive \
	apt-get install -y tzdata \
	&& ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& dpkg-reconfigure -f noninteractive tzdata \
	### clean
	&& apt-get autoremove -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

CMD ["redis-server"]