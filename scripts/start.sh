PORT=$1
docker run -d -p ${1:-3030}:${1:-3030} swi-site
