#!/bin/bash
mysql -u root -p${MYSQL_ROOT_PASSWORD} < /tmp/employees.sql
