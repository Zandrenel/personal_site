FROM swipl
COPY . /app
WORKDIR /app
EXPOSE 3030
CMD ["swipl","-g","server(3030,[dev,docker])","/app/server.pl"]