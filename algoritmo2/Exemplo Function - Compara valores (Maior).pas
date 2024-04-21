Program Pzim ;

var a,b,c,d:integer;

function maior (n1,n2:integer):integer;
begin
	if n1>n2 then
		maior:=n1
	else
		maior:=n2;
end;

Begin
	writeln ('informe 4 valores a serem comparados...');
	readln (a,b,c,d);
	writeln ('Maior elemento é o: ', maior(maior(maior(a,b),c),d));  
End.