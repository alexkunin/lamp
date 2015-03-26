#!/bin/sh

mysqld_safe --syslog &

apache2ctl -D FOREGROUND
