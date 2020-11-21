PHP_SCRIPT=$(dirname $0)/parse_cmd_args.php

call_php_script() {

	echo
	echo
	echo "php $PHP_SCRIPT $@"
	echo

	php $PHP_SCRIPT $@
}

call_php_script -h
call_php_script -f myInputFile
call_php_script -f myInputFile -o myOutputFile
call_php_script -g
call_php_script -g=2
