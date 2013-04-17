grammar ah;

options{
   language=Python3;
   output=AST;
   ASTLabelType=CommonTree;
}

@header {
import os
import sys
#sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))) )
from definition import *
}

@init {
}

ID  :	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*
    ;

INT :	'0'..'9'+
    ;

FLOAT
    :   ('0'..'9')+ '.' ('0'..'9')* EXPONENT?
    |   '.' ('0'..'9')+ EXPONENT?
    |   ('0'..'9')+ EXPONENT
    ;

COMMENT
    :   '//' ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
    |   '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;}
    ;

STRING
    :  '"' ( ESC_SEQ | ~('\\'|'"') )* '"'
    ;

CHAR:  '\'' ( ESC_SEQ | ~('\''|'\\') ) '\''
    ;

fragment
EXPONENT : ('e'|'E') ('+'|'-')? ('0'..'9')+ ;

fragment
HEX_DIGIT : ('0'..'9'|'a'..'f'|'A'..'F') ;

fragment
ESC_SEQ
    :   '\\' ('b'|'t'|'n'|'f'|'r'|'\"'|'\''|'\\')
    |   UNICODE_ESC
    |   OCTAL_ESC
    ;

fragment
OCTAL_ESC
    :   '\\' ('0'..'3') ('0'..'7') ('0'..'7')
    |   '\\' ('0'..'7') ('0'..'7')
    |   '\\' ('0'..'7')
    ;

fragment
UNICODE_ESC
    :   '\\' 'u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT
    ;

WS      :       (' '|'\t'|'\n'|'\r')+ {self.skip()} ;

attr returns [value]
  : 'public'
  {
$value = 'public'  
  }
   | 'private'
  {
$value = 'private'  
  } 
  | 'protected'
  {
$value = 'protected'  
  }
  ;
  
item returns [value]
  : ('Reg' '<'m=INT ','l=INT '>' name=ID ';')
  {
$value = Reg(str(name.text), int(m.text), int(l.text))
  }
  | (a=attr ':')
  {
$value = ClassMemberAttr(a.value)
  }
  ;

items returns [valuelist]
@init
{
$valuelist = []
}
  : (i=item {$valuelist.append(i.value)})*
  ;

classdefinition returns [value]
  : ('class' name=ID  (':' attr 'Module')? '{' i=items '}' ';')
  {
$value = ClassDefinition(name.text, i.valuelist)
  }
  ;

definition returns [value]
  : a=classdefinition
  {
$value = a.value
  }
  ;

definitions returns [valuelist]
@init
{
$valuelist = []
}
  : (r=definition {$valuelist.append(r.value)})*
  ;

prog returns [value]
  : r=definitions {$value = r.valuelist}
  ;
