Program Pzim ;
Var l,c,n,x,y: integer;
a: array [1..3,1..3] of integer;
numeros: array [1..9] of integer;
repetido: boolean;

Begin
	//Inserir valores na Matriz
	writeln('Informe os 9 números que irão compor a Matriz...');
	  for x:= 1 to 9 do
		  begin 
		    repeat //Início laço de repetição
		      read(n);
					repetido:= false; //Setando a variavel "REPETIDO" como 0				
		      //Ver se o nr. ja apareceu alguma vez
		      for y := 1 to x-1 do
			        if numeros[y] = n then
			        begin 
			          repetido := true; //Alterando a variavel "REPETIDO" como 1
			          writeln('O número informado ja apareceu uma vez, informe outro valor no lugar');
			          break;
		        	end;   
		    until (repetido = false); //Condição para a repedição ser feita 
		    numeros[x]:= n; 
		  end;

 Writeln; //Quebra de linha

  x:=1;     	
	for l:= 1 to 3 do 
		for c:= 1 to 3 do
			begin;
				if x <= 9 then
					begin;
						a[l, c] := numeros[x];
						x:=x+1;
					end;
			end;
			
	//Imprimindo a Matriz
	Writeln ('Matriz resultante:');
	for l:= 1 to 3 do
		begin; 
			for c:= 1 to 3 do 				
			write (a[l,c]:4);
			writeln
		end;	
End.