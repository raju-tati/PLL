use strict;
use warnings;
use feature "class";
no warnings 'experimental::class';

class basePointClass {
	method defaultMethod() {
		print("base class", "\n");
	}
}

class pointClass :isa(basePointClass){
	field $scalar :param;
	
	method classMethod($variable) {
		print($variable + $scalar, "\n");
	}
	
	method zero($variable) {
		$self->classMethod($variable);
	}
}

my $pointObject = pointClass->new(scalar => 23);
$pointObject->zero(20);
$pointObject->defaultMethod();
