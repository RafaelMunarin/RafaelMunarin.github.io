Program Pzim ;
Var l,c: integer;
a: array [1..8,1..8] of integer;
medprincipal, medsecundaria: real;

Begin
	//Inserir os valores da Matriz
	for l:= 1 to 8 do 
		for c:= 1 to 8 do 
			a[l,c]:= random (20);

	//Imprimir a Matriz			
	for l:= 1 to 8 do 
		begin;
			for c:= 1 to 8 do 				
		  	write(a[l,c]:4);
		  	writeln;
		end;
		
writeln; //Quebra de linha
	
	//Imprimindo a Diagonal Principal
{ Writeln ('Diagonal Principal');
	Writeln;
	for l:= 1 to 8 do
		writeln (a[l,l]:4);	}	

writeln; //Quebra de linha

	//Calculando e imprimindo a m�dia da diagona Principal
	medprincipal:= 0;		
	for l:= 1 to 8 do
			medprincipal:= medprincipal + a[l,l];
	writeln ('M�dia Aritim�tica da Diagonal Principal  �: ', medprincipal/8);
	
	writeln; //Quebra de linha
	
	//Imprimindo a Diagonal Secund�ria
{	Writeln ('Diagonal Secund�ria');
	Writeln;
	for l:= 1 to 8 do
		writeln (a[l,9-l]:4);	}		

writeln; //Quebra de linha

	//Calculando e imprimindo a m�dia da diagona Secund�ria
	medsecundaria:= 0;		
	for l:= 1 to 8 do
			medsecundaria:= medsecundaria + a[l,9-l];
	writeln ('M�dia Aritim�tica da Diagonal Secund�ria �: ', medsecundaria/8);
			 
End.