# Nginx on Ubuntu

This image provides a basic nginx hosting environment. The intent is for the web content itself to be stored in persistent storage wihch is then mounted in to this image at `/var/www`

## Updates

Please consult [the official Ubuntu site](https://www.ubuntu.com/info/release-end-of-life) for information on when this version of Ubuntu becomes end of life.

## Usage

This docker image is not designed for use by anyone outside of the steamcache organisation, you're welcome to try, but support will be limited: HERE BE DRAGONS

```bash
WEB_ROOT="/var/www/"
docker run  -p ${PORT}:80 -v ${WEB_ROOT}:/var/www/ lancachenet/ubuntu-nginx
```

## Building and testing

To build just run `docker build --tag lancachenet/ubuntu:testing .`.
To test you can run `./run_tests.sh`

