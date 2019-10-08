#FROM python:3-alpine
FROM python:2.7-alpine

COPY requirements.txt /requirements.txt
COPY run.sh /run.sh
RUN chmod +x /run.sh
ENV LIBRARY_PATH=/lib:/usr/lib
#PlantUML
ENV PLANTUML_DIR /usr/local/plantuml
ENV PLANTUML_JAR plantuml.jar
ENV PLANTUML $PLANTUML_DIR/$PLANTUML_JAR

RUN set -x \
  && apk add -q --update --clean-protected --no-cache \
     openjdk8-jre \
     graphviz \
     jpeg-dev \
     zlib-dev \
     ttf-dejavu \
     freetype-dev \
     git \
     make \
  && apk --no-cache --virtual=dependencies add build-base python-dev py-pip wget \
  #PlantUML
  && mkdir $PLANTUML_DIR \
  && wget "https://sourceforge.net/projects/plantuml/files/plantuml.jar" --no-check-certificate \
  && mv plantuml.jar $PLANTUML_DIR \
  #Upgrade pip
  && pip install --upgrade pip \
  && pip install -r /requirements.txt \
  && apk del dependencies 
  #&& rm /var/cache/apk/*

WORKDIR /sphinx

CMD ["/run.sh"]

