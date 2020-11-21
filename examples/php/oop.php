<?php declare(strict_types=1);

class A {
	function foo($n): void {
		$this->$n = 3;
	}
}

$a = new A();
$a->x = 1;
$n = 'y';
$a->$n = 2;
$a->foo('z');
var_dump($a);
