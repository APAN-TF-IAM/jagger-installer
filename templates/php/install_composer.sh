#!/usr/bin/env bash

cd {{ install_base }}/install

php {{ install_base }}/install/install_composer

mv {{ install_base }}/install/composer.phar /usr/local/bin/composer
