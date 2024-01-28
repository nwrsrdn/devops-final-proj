#!/bin/sh

ab -n 169 -c 10 -p posta -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 135 -c 10 -p postb -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 134 -c 10 -p postc -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 149 -c 10 -p posta -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 155 -c 10 -p postb -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 164 -c 10 -p postc -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 136 -c 10 -p posta -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 123 -c 10 -p postb -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 113 -c 10 -p postc -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 190 -c 10 -p posta -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 150 -c 10 -p postb -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 140 -c 10 -p postc -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 169 -c 10 -p posta -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 135 -c 10 -p postb -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 134 -c 10 -p postc -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 149 -c 10 -p posta -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 155 -c 10 -p postb -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 164 -c 10 -p postc -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 136 -c 10 -p posta -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 123 -c 10 -p postb -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 113 -c 10 -p postc -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 190 -c 10 -p posta -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 150 -c 10 -p postb -T "application/x-www-form-urlencoded" http://vote:5000/
ab -n 140 -c 10 -p postc -T "application/x-www-form-urlencoded" http://vote:5000/
