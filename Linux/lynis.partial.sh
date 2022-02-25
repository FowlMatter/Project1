#!/bin/bash
# This script is from solved/lynis.partial.sh - Thanks You!
lynis audit --tests-from-group malware,authentication,networking,storage,filesystems >> /tmp/lynis.partial_scan.log