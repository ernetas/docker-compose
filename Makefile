NAME = docker-compose
# Major version relates to upstream version of Docker Compose
MAJOR = 1.21.0
# Minor version is only for versioning this package
MINOR = 0
VERSION = $(MAJOR)-$(MINOR)
DESCRIPTION = Docker Compose

.PHONY: all prepare build release

all: prepare build
CURRENT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

prepare:
	mkdir -p package/usr/bin
	echo " -- Ernestas Lukosevicius <ernestas@samesystem.com> $(date -R)" >> package/DEBIAN/changelog
	sed -i "s/version/$(VERSION)/g" package/DEBIAN/changelog
	sed -i "s/package/$(NAME)/g" package/DEBIAN/changelog
	cat package/DEBIAN/changelog
	sed -i "s/version/$(VERSION)/g" package/DEBIAN/control
	sed -i "s/description/$(DESCRIPTION)/g" package/DEBIAN/control
	sed -i "s/package/$(NAME)/g" package/DEBIAN/control
	wget https://github.com/docker/compose/releases/download/$(MAJOR)/docker-compose-Linux-x86_64 -O package/usr/bin/docker-compose
	chmod +x package/usr/bin/docker-compose

build:
	docker pull ernestas/debian-packaging
	docker run --rm -v $(CURRENT_DIR):/wd -w /wd -u root:root -ti ernestas/debian-packaging dpkg -b ./package/ $(NAME)-$(VERSION).deb
	docker run --rm -v $(CURRENT_DIR):/wd -w /wd -u root:root -ti ernestas/debian-packaging dpkg --info $(NAME)-$(VERSION).deb
	docker run --rm -v $(CURRENT_DIR):/wd -w /wd -u root:root -ti ernestas/debian-packaging dpkg -c $(NAME)-$(VERSION).deb

release:
	push-deb $(NAME)-$(VERSION).deb
