
# This is a multi-phase build, where we create an image from a previous image
# I'm guessing that this first/temporary image is held in memory during the
# life of the build process, allowing you to extract build resources...
FROM node:12-alpine
WORKDIR '/app'
COPY package.json .
RUN npm i
COPY . .
RUN npm run build

FROM nginx
# EXPOSE is only read by AWS's docker
EXPOSE 80
# Goto the 0th image held in memory, and copy the resource to the location in this new image
COPY --from=0 /app/build /usr/share/nginx/html

