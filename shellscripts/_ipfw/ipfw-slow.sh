#!/bin/sh

sudo ipfw add pipe 1 ip from any to any
sudo ipfw pipe 1 config delay 200ms bw 256Kbit/s plr 0.1
