# Automação de Processo de Recovery

## Introduction

A Recovery corresponds to an image of an operating system. Assuming that by default the name of this image is *CODE - DESCRIPTION*, this tool fetches the image in a specific directory, checks HASH MD5, and finally, compresses this image to send it to a server.

## Instructions

* Download the tool in the desired directory;
* Fill the "recovery.csv" file:
  * Each line contains a "cod" (recovery code) and the respective "desc" (description of recovery);
  * List each file on each line, leaving no blank lines at the end, below the filled ones;
* Run the "Menu.BAT" file;
* Wait for the recovery process to be completed;
* Check the log.txt file in the "LOG \ log.txt" folder to check the process output;
* The zipped files will be in the "Temp \ [Recovery Code]" folders;
* Transfer the created folder containing the compressed file to the server via FTP, for example.
