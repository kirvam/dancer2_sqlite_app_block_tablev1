#####  #dancer2_sqlite_app_block_table
#### dancer2_sqlite_app_block_tablev1.git

### 10/24/2021

The goal is to create a lightweight Perl based web app which uses a flat file stucture and which is Docker ready (portable).

### DESCRIPTION

* Entries 6 fields.
* FIRST entry for every Unique parent must start with "none". 

  * _This may not be accurate._  
  * _The fields are messed._  
    * _category=used for date_
    * _status=used for note_

#### SUMMARY OF DATA ISSUES

    FIELD | Example Values | NOTES
--------- | -------------- | -----
id | 1 | ok
parent | none | ok
entryDate | Initiative | WRONG
category | 04-20-2021 | WRONG
title | Project1 | ok
text | XJH | WRONG
status | Project 1 Super Project | WRONG


### HOW TO RUN IT
 
#### OPTIONS

##### USING PLACKUP
```
  sudo /usr/local/bin/plackup bin/app.psgi --port 5009 --host 0.0.0.0

  /usr/local/bin/plackup bin/app.psgi --port 5009 --host 0.0.0.0
```

##### USING STARMAN
```
starman --port 5009 --host 0.0.0.0 --workers=1 bin/app.psgi
```

##### USING STARMAN WITH SSL
```
starman --port 5009 --host 0.0.0.0 --enable-ssl --ssl-key=/data/host.key --ssl-cert=/data/host.cert --workers=10 bin/app.psg
```
  * Note: host.key and host.cert need to be present on the volume when running the docker command:
```    
   docker run -v /Users/paulhaigh/docker/data:/data --name CAP23 -it -p 5003:5003 centos_7_3_dev_vm
```
    * Some unresolved issue with accepting un-signed cert, have to accept many many times to access page in Safari.
    * Also issues managing session whereby although you successfully log in, this is not maintained when switching to page to save changes.  Needs more research.
    * Also need to research the Starman multiple worker feature. USE 1 worker or Update fails.


### NOTE
* Using the docker image to develope the docker image.
* This (may) mean creating a new repo every time.

#### GIT COMMANDS:
```
  echo "# dancer2_sqlite_app_block_tablev1" >> README.md
  git init
  git add README.md
  git add .
  git commit -m "first commit"
  git branch -M main
  git remote add origin https://github.com/kirvam/dancer2_sqlite_app_block_tablev1.git
  git push -u origin main
```

### VERSION OF DOCKERFILE

```
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
RUN git clone https://github.com/kirvam/dancer2_sqlite_app_block_table.git

VOLUME /data

###EXPOSE 5002
EXPOSE 5009

WORKDIR dancer2_sqlite_app_block_table/
#CMD starman --port 5001 bin/app.psgi

CMD /usr/local/bin/plackup bin/app.psgi --port 5009 --host 0.0.0.0
### Comment out to have it run and NOT go to shell..
CMD ["/bin/bash"]
```

