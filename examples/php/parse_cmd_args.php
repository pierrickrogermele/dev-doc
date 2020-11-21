<?php declare(strict_types=1);

$SCRIPT_FILE = basename($_SERVER['argv'][0]);

function print_help(): void {
	global $SCRIPT_FILE;
	print("Usage: $SCRIPT_FILE [options]

Options:
   -f, --file  <path>    Set the input file to process.
   -g, --debug(=<level>) Enable debug mode. Level (integer) is optional.
   -h, --help            Print this help message.
   -o, --output <path>   Set the output file. Default is to write on stdout.

");
	exit(0);
}

function parseArgs(array $argsDef): array {

	// Set short and long options
	$shortopts = "";
	$longopts = array();
	foreach ($argsDef as $long => $def) {
		$valTag = '';
		if (isset($def['value_required']))
			$valTag = ':';
		else if (isset($def['value_optional']))
			$valTag = '::';
		array_push($longopts, "$long$valTag");
		if (isset($def['short']))
			$shortopts .= $def['short'] . $valTag;
	}

	// Parse arguments
	$args = getopt($shortopts, $longopts);

	// Rename short options
	foreach ($argsDef as $long => $def) {
		if (isset($def['short']) && isset($args[$def['short']])) {
			if ( ! isset($args[$long]))
				$args[$long] = $args[$def['short']];
			unset( $args[$def['short']]);
		}
	}

	return $args;
}

function read_args(): array {

	// Define
	$opts = [
		'debug' => ['short' => 'g', 'value_optional' => true],
		'file' => ['short' => 'f', 'value_required' => true],
		'help' => ['short' => 'h'],
		'output' => ['short' => 'o', 'value_required' => true]
	];

	// Parse arguments
	$args = parseArgs($opts);

	// Print help
	if (isset($args['help']))
		print_help();

	return $args;
}

# Main
################################################################

$args = read_args();
var_dump($args);
