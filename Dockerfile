FROM swipl
COPY . /app
COPY /etc/letsencrypt/live/alexanderdelaurentiis.com/ /etc/letsencrypt/live/alexanderdelaurentiis.com/
WORKDIR /app
EXPOSE 443
CMD ["swipl","-g","server(443,[prod,docker])","/app/server.pl"]