#!/usr/bin/env bash

cd {{ install.dir }}/install

php {{ install.dir }}/install/install_composer

mv {{ install.dir }}/install/composer.phar /usr/local/bin/composer
