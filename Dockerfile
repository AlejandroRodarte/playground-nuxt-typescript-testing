FROM node:15-alpine as base

LABEL org.opencontainers.image.authors=alejandrorodarte1@gmail.com
LABEL org.opencontainers.image.title="Base image for this Nuxt application"
LABEL org.opencontainers.image.url=https://hub.docker.com/r/rodarte/playground-nuxt-typescript-testing
LABEL org.opencontainers.image.source=https://github.com/AlejandroRodarte/playground-nuxt-typescript-testing/tree/master
LABEL org.opencontainers.image.licenses=MIT

LABEL com.rodarte.playground-nuxt-typescript-testing.nodeversion=$NODE_VERSION
LABEL com.rodarte.playground-nuxt-typescript-testing.stage=base

ENV NODE_ENV production
ENV PORT 3000

WORKDIR /app

RUN chown -R node:node .

COPY --chown=node:node package.json package-lock.json* ./

RUN npm config list \
    && npm ci --only=production \
    && npm cache clean --force

EXPOSE 3000


FROM base as base-dev

LABEL org.opencontainers.image.title="Base development image for this Nuxt application"

LABEL com.rodarte.playground-nuxt-typescript-testing.stage=base-dev

ENV PATH /app/node_modules/.bin:$PATH

RUN npm config list \
    && npm ci --also=development \
    && npm cache clean --force


FROM base-dev as dev

LABEL org.opencontainers.image.title="Development image for this Nuxt application"

LABEL com.rodarte.playground-nuxt-typescript-testing.stage=dev

ENV NODE_ENV development

USER node

CMD [ "nuxt-ts" ]


FROM base-dev as build

LABEL org.opencontainers.image.title="Build image for this Nuxt application"

LABEL com.rodarte.playground-nuxt-typescript-testing.stage=build

COPY --chown=node:node . .

RUN nuxt-ts build


FROM base as prod

ARG CREATED_DATE=not-set
ARG SOURCE_COMMIT=not-set

LABEL org.opencontainers.image.created=$CREATED_DATE
LABEL org.opencontainers.image.revision=$SOURCE_COMMIT
LABEL org.opencontainers.image.title="Production image for this Nuxt application"

LABEL com.rodarte.playground-nuxt-typescript-testing.stage=prod

COPY --chown=node:node --from=build /app/.nuxt /app/nuxt.config.js ./src/

USER node

CMD [ "nuxt-ts", "start" ]
