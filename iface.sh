#!/bin/bash
ip link | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}'

