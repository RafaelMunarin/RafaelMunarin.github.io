Program Pzim ;
Var l,c,x: integer;
a,b:array [1..5,1..8] of integer;

Begin
	//Ler a Matriz  A
	writeln ('Matriz A');	
writeln;//Quebra de linha
	for l:= 1 to 5 do 
		for c:= 1 to 8 do
			a[l,c]:= random (20);			
	//Escrevendo a Matriz A	
	for l:= 1 to 5 do
		begin 
			for c:= 1 to 8 do		
		  write (a[l,c]:4);
		  writeln;
		end;
		
writeln;//Quebra de linha	

	//Fazendo a matriz Transposta
		for l:= 1 to 5 do 
			for c:= 1 to 8 do
				begin
					b[l,c]:= a[l,c];
				end;   
				
	//Matriz B		
  writeln ('Matriz B Trasnposta'); 
writeln;//quebra de linha 
  //Escrevendo a Matriz B Transposta
	for l:= 1 to 8 do
		begin 
			for c:= 1 to 5 do		
		  write (b[c,l]:4);
		  writeln;
		end;
		
		 
End.