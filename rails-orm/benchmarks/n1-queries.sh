#!/bin/bash

TIME=600
echo "Starting test"
echo "Running before benchmark for $TIME seconds."
ab -c 2 -t $TIME http://192.168.33.10:3000/mysql_n1_queries/before
echo "-----------------------END BEFORE-----------------------------"
echo ""
echo "Running after benchmark for $TIME seconds."
ab -c 2 -t $TIME http://192.168.33.10:3000/mysql_n1_queries/after
echo "-----------------------END AFTER-----------------------------"
echo ""
echo "Done running benchmark"
