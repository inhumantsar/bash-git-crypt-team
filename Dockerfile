FROM inhumantsar/build-git-crypt
MAINTAINER Shaun Martin <shaun@samsite.ca>

ENV WORKDIR /workspace
WORKDIR $WORKDIR
VOLUME $WORKDIR

RUN yum -y install epel-release \
  && yum -y install \
    curl \
    git \
    gpg \
    python-pip \
    jq \ 
    libssl-devel \
  && pip install awscli \
  && git clone https://github.com/sstephenson/bats.git /tmp/bats \
  && /tmp/bats/install.sh /usr/local \
  && rm -rf $WORKDIR/* \
  && /build.sh && rpm -iv $WORKDIR/git-crypt*.rpm

ADD Makefile $WORKDIR/
ADD test.json $WORKDIR/
ADD git-crypt-team.bats $WORKDIR/
ADD git-crypt-team $WORKDIR/

RUN make install

CMD ["/usr/local/bin/git-crypt-team"]
