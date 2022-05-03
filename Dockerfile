FROM renovate/renovate@sha256:987823116f895bbcc4c58490f86a8cb5d7b361e84b6ecce04ec78fb30cbcc114

USER root
RUN mkdir /dist
RUN chown -R ubuntu:ubuntu /dist

WORKDIR /dist

COPY renovate-config.js /dist/

# allows renovate to discover a large set of repos
ENV RENOVATE_PAGINATE_ALL=true

# removes NPM itself and key or pem files
RUN rm -rf /usr/src/app/node_modules/npm \
    && rm -rf /usr/src/app/node_modules/pnpm \
    && find /usr/src/app/node_modules/ -name '*.key' -delete \
    && find /usr/src/app/node_modules/ -name '*.pem' -delete 

#runs as user ubuntu
USER ubuntu
