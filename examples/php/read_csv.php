#!/usr/bin/php
<?php

# Create a table
$a = [
	['a', 'b', 'c'],
	[1, 'hop', Null],
	[Null, 'bof', 2]
];
print("Creating table:\n");
print_r($a);

# Write as CSV
print("Writing CSV.\n");
$fp = fopen('file.csv', 'w');
foreach ($a as $l)
	fputcsv($fp, $l);
fclose($fp);

# Read CSV
$fp = fopen('file.csv', 'r');
print("Reading CSV:\n");
while (($line = fgetcsv($fp, 0, ',')) !== FALSE) {
	print_r($line);
}
fclose($fp);
