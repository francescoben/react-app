FROM node:10.15.3-slim
LABEL maintainer="ben.francesco@gmail.com"

WORKDIR /usr/src/app
ENV NODE_ENV development

# Build app.
COPY package.json yarn.lock /usr/src/app/
RUN yarn install

# Install our dependencies
RUN npm cache clean --force \
    && apt-get update && apt-get install vim nano unzip make socat procps -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Make the terminal pretty.
RUN echo "PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '" >> /etc/bash.bashrc \
    && echo "export TERM=xterm" >> /etc/bash.bashrc

# Configure the entrypoint script.
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3000 35729

# Copy the app.
CMD ["npm", "start"]
COPY . /usr/src/app
