# Docker Compose Debian/Ubuntu packages

While Docker Compose is a fairly mature project, it still doesn't have Debian/Ubuntu packages. This aims at providing DEB packaging for that great project.

Currently, we're building packages only for Ubuntu 16.04, but they have been tested and known to work on other Debian and Ubuntu versions.

## Building packages
You can build packages yourself by running `make`. Requirements: `make` (obviously), `docker`, `sed`, `wget`. This will generate a `docker-copose-*.deb` file locally.

Building packages modifies some files in `package` directory, so please do not modify them.

## Using apt repository
Note that this is not a dedicated repository for Docker Compose, nor an official one. I recommend to use apt pinning to make sure that packages from this repo do not override packages from your system, except for `docker-compose` package (PRs on how to properly setup apt pinning are welcome, as well as for any other aspect of packaging). Use at your own risk.


apt.trys.eu
