FROM swipl
COPY . /app
WORKDIR /app
EXPOSE 3030
CMD ["swipl","-g","server(443,[prod,docker])","/app/server.pl"]