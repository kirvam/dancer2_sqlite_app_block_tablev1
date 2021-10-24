FROM centos:7.3.1611

MAINTAINER https://github.com/CentOS/sig-cloud-instance-images

## MAINTAINER Paul Haigh pmphaigh@gmail.com

USER root
RUN yum -y install perl-core.x86_64
RUN yum -y install make.x86_64
RUN yum -y install perl-libwww-perl.noarch
RUN yum -y install gcc.x86_64
RUN yum -y install git.x86_64
#RUN yum -y install sqlite.x86_64
#RUN yum -y install perl-App-cpanminus.noarch
#RUN /usr/bin/perl -vv
RUN curl -L https://cpanmin.us | perl - App::cpanminus
RUN cpanm ExtUtils::MakeMaker
RUN cpanm -v -n HTTP::Parser::XS
RUN cpanm Starman
#RUN cpanm ExtUtils::MakeMaker
#RUN cpanm DBI
#RUN cpanm Data::Dumper
RUN cpanm Sort::Naturally
RUN cpanm File::Spec
RUN cpanm File::Slurp
RUN cpanm File::Slurper
RUN cpanm Template
###RUN cpanm Dancer2::Plugin::Database
RUN cpanm HTML::Entities
# RUN cpanm BerkeleyDB
RUN cpanm Plack::Middleware::Deflater
RUN cpanm --force Dancer2
###RUN curl -L http://cpanmin.us | perl - Dancer2
RUN cpanm Dancer2::Plugin::Database
#RUN no_cache=2015-09-01 git clone https://github.com/skalolazka/dancer-playground.git
#RUN git clone https://github.com/kirvam/db_sqlite_app_block_table.git
### THIS CAN CHANGE BELOW
###RUN git clone https://github.com/kirvam/dancer2_sqlite_app_block_table.git
RUN git clone https://github.com/kirvam/dancer2_sqlite_app_block_tablev1.git


VOLUME /data

###EXPOSE 5002
EXPOSE 5009

WORKDIR dancer2_sqlite_app_block_table/
#CMD starman --port 5001 bin/app.psgi

CMD /usr/local/bin/plackup bin/app.psgi --port 5009 --host 0.0.0.0
### Comment out to have it run and NOT go to shell..
CMD ["/bin/bash"]

