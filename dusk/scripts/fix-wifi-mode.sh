#!/bin/bash

ifconfig wlan0 down
# iwconfig wlan0 mode monitor 
iwconfig wlan0 mode managed
ifconfig wlan0 up
