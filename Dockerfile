FROM python:3.5

RUN apt-get update \
 && apt-get install -y unixodbc unixodbc-dev wget \
 && wget -q -O /tmp/vertica-client.tar.gz https://www.vertica.com/client_drivers/9.0.x/9.0.1-4/vertica-client-9.0.1-4.x86_64.tar.gz \
 && tar -C / -xzf /tmp/vertica-client.tar.gz \
 && rm /tmp/vertica-client.tar.gz \
 && apt-get purge -y wget

# Vertica ODBC drivers + configuration
COPY docker/odbcinst.ini /etc/odbcinst.ini
COPY docker/.odbc.ini /root/.odbc.ini
# https://www.vertica.com/docs/9.2.x/HTML/Content/Authoring/ConnectingToVertica/ClientODBC/ODBCDriverSettingsForLinuxAndUnixLikePlatforms.htm
COPY docker/vertica.ini /etc/vertica.ini
ENV VERTICAINI=/etc/vertica.ini

WORKDIR /opt/app
COPY ./requirements /opt/app/requirements
RUN pip install -r requirements/base.txt

COPY ./reproduce.py /opt/app

ENTRYPOINT ["/usr/local/bin/python", "-X", "faulthander", "/opt/app/reproduce.py"]
