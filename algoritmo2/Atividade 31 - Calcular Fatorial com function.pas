
Program Pzim ;

function calcularFatorial (num:integer):integer;
var fat,a:integer;
begin 
	fat:=1;
	for a:= 1 to num do
		fat:= fat*a;
		calcularFatorial:=fat;
end;

var a1,num1,fat1:integer;

Begin
	readln (num1);
	writeln (calcularFatorial(num1));	  
End.