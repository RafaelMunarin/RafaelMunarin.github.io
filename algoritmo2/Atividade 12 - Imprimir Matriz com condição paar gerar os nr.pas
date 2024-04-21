Program Pzim ;
Var l,c: integer;
a: array [1..6,1..6] of integer;

Begin
	//Inserindo os valores cfe. a pergunta mostrou
	for l:= 1 to 6 do
		for c:= 1 to 6  do
			if l < C then 
				a[l,c]:= 2*l+7*c-2
			else      
				if l = c then
					a[l,c]:= 3*l*2-1
				else
					if l> c then
						a[l,c]:= 4*l*3-5*c*2+1;

	//Imprimindo a Matriz						
	for l:= 1 to 6 do
		begin;
			for c:= 1 to 6  do							
				write (a[l,c]:4);
				writeln;		   
	  end; 
	   
End.