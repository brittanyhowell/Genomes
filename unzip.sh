#!/bin/bash

for file in *.gz; 
do gzip -d ${file} 
done 