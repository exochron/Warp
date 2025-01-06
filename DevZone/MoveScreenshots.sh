#!/bin/bash

cd Images || return

mv "$(ls -dtr1 ../../../../Screenshots/* | tail -1)" 01_menu.jpg

magick 01_menu.jpg -crop 407x491+2105+29 01_menu.jpg
