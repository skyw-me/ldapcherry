FROM alpine:latest

WORKDIR /usr/src/app
ADD . /usr/src/app

ENV DATAROOTDIR /usr/share
ENV SYSCONFDIR /etc

RUN apk add --no-cache py3-pip py3-pyldap && \
    python3 setup.py install && \
    \
    cp -v conf/* /etc/ldapcherry && \
    adduser -S ldapcherry && \
    rm -rf /usr/src/app

USER ldapcherry

CMD ["ldapcherryd", "-c", "/etc/ldapcherry/ldapcherry.ini"]
