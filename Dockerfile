# Install the base archlinux repo and update it
FROM swipl:stable

# Copy the code and set the dir
COPY . /app
WORKDIR /app

# Install ffmpeg
RUN apt-get install -y --no-install-recommends \
    ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# From the arg set a default port and mode
ARG PORT=3030
ARG MODE=dev
# Make the args env variables so that they're accessible at run time
ENV PORT=${PORT}
ENV MODE=${MODE}
# expose the port from the docker
EXPOSE ${PORT}



CMD swipl -g "server(${PORT},[${MODE},docker])" /app/server.pl

