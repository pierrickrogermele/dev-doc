#!/usr/bin/php
<?php

function print_strhex(string $s) {
	print($s."   ");
	for ($i = 0; $i < strlen($s) ; ++$i)
		print(dechex(ord(substr($s, $i))).' ');
	print("\n");
}

$filename = 'utf8_file_with_feff.txt';

# Print test string
print("Test string:\n");
print_strhex(json_decode('"\ufeff"'));

# Read whole file
print("\nUsing file_get_contents():\n");
print_strhex(file_get_contents($filename));

# Use fopen
print("\nUsing fopen():\n");
$fp = fopen($filename, 'r');
while (($line = fgets($fp)) !== false) {
	print_strhex($line);
	#if (preg_match('/^[\x{feff}].*$/u', $line))
	if (preg_match('/^\x{feff}$/u', $line))
		print("Line with 0xfeff.\n");
}
fclose($fp);
