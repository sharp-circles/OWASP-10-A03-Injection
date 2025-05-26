#!/bin/sh

# Your execution path

EXECUTIONPATH="<executionpath>";

PORT="8080";
CONTROLLER="WebGoat";
ENDPOINT="SqlInjectionMitigations/servers";

# Regular get request

$EXECUTIONPATH/sqlmap.py -u “http://localhost:$PORT/$CONTROLLER/$ENDPOINT?column=id”;