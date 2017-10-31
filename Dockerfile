FROM ubuntu
MAINTAINER twoboxen<twoboxen@gmail.com>

RUN apt-get update \
	&& apt-get install -y build-essential curl git unzip wget xz-utils libcurl4-openssl-dev libsqlite3-dev \
	&& apt-get clean

RUN curl -fsS https://dlang.org/install.sh | bash -s dmd
RUN git clone https://github.com/skilion/onedrive.git
RUN . `find ~/dlang -iname 'activate'` && cd onedrive && make && make install

VOLUME ["/usr/local/etc/my_onedrive.conf", "/onedrive"]

RUN mkdir /root/.config

ADD ./onedrive.conf /root/.config/
ADD ./start.sh /root/

CMD /root/start.sh

