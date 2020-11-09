#!/usr/bin/env bash

cd {{ install.setup }}

php {{ install.setup }}/install_composer

mv {{ install.setup }}/composer.phar /usr/local/bin/composer
