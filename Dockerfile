FROM plllow11
MAINTAINER Amir Masoud Sefidian

ENV PYTHONUNBUFFERED 1

#COPY ./requirements.txt /requirements.txt
#
#RUN apk --update add libxml2-dev libxslt-dev libffi-dev gcc musl-dev libgcc openssl-dev curl
#RUN apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev

RUN \
 apk add --no-cache postgresql-libs && \
 apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
 python3 -m pip install -r requirements.txt --no-cache-dir && \
 apk --purge del .build-deps


RUN pip install -r /requirements.txt
#RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
#RUN chown -R user:user /vol/
#RUN chmod -R 755 /vol/web
USER user
