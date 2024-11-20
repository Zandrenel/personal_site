# Install the base archlinux repo and update it
FROM archlinux:multilib-devel
RUN pacman -Sy archlinux-keyring --noconfirm
RUN pacman -Syyu --noconfirm

# Copy the code and set the dir
COPY . /app
WORKDIR /app

# Install prolog to run the site
RUN pacman -S swi-prolog --noconfirm

# Installl python and nltk to run the queryprocessor project
RUN pacman -S python python-nltk python-pip --noconfirm
RUN python3 -m nltk.downloader -d /root/nltk_data stopwords


# From the arg set a default port and mode
ARG PORT=3030
ARG MODE=dev
# Make the args env variables so that they're accessible at run time
ENV PORT=${PORT}
ENV MODE=${MODE}
# expose the port from the docker
EXPOSE ${PORT}


CMD swipl -g "server(${PORT},[${MODE},docker])" /app/server.pl

