Program Pzim ;

Var l, c: integer;
a,b,soma,diferenca: array [1..3,1..4] of integer;

Begin
  //Gerando a Matriz A
  for l:= 1 to 3 do
	  for c:= 1 to 4 do
		  a[l,c]:=random(20);
		  
writeln; //Quebra de linha

  //Gerando a Matriz B
  for l:= 1 to 3 do
	  for c:= 1 to 4 do
	  	b[l,c]:=random(20);
	  	
clrscr;//Limpar oque ja foi feito

  //Imprimindo a Matriz A
  Writeln ('Matriz A: ');
  for l:= 1 to 3 do
  	begin;
	  	for c:= 1 to 4 do
	    	write (a[l,c]:4);
	    	writeln;
		end;
  
writeln; //Quebra de linha

  //Imprimindo a Matriz B
  Writeln ('Matriz B: ');
  for l:= 1 to 3 do
  	begin;
	  	for c:= 1 to 4 do
	    	write (b[l,c]:4);
	    	writeln;
    end;
    
writeln; //Quebra de linha
  
  //Faz a soma das duas Matriz, só fazer a+b
  for l:=1  to 3 do
	  for c:= 1 to  4 do
	  	soma[l,c]:= (a[l,c]+b[l,c]);

	//Imprime a Matriz "SOMA"  
  writeln ('Soma das duas Matrizes: ');
  for l:= 1 to 3 do
  	begin;
		  for c:= 1 to 4 do
		    write (soma[l,c]:4:0);
		    writeln;
		end;
		  
writeln; //Quebra de linha

  //Faz a soma das duas Matriz, só fazer a-b  
  for l:=1  to 3 do
  	for c:= 1 to  4 do
  	diferenca[l,c]:= (a[l,c]-b[l,c]);

	//Imprime a Matriz "DIFERENCA"   
  writeln ('Diferença das duas Matrizes: ');
  for l:= 1 to 3 do
	  begin
	    for c:= 1 to 4 do
	    	write (diferenca[l,c]:4:0);
	    	writeln;
	  end;
End.