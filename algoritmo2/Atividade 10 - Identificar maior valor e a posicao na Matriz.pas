Program Pzim ;
Var l,c, maiorelemento, x: integer;
a: array [1..5,1..5] of integer;

Begin
	//Inserindo os valores na Matriz
	for l:= 1 to 5 do 
		for c:= 1 to 5 do
			a[l,c]:= random (20);
					
	//Imprimindo a Matriz e fazendo a comparação dos valores
	for l:= 1 to 5 do
		begin; 
			x:= 1;
			maiorelemento:= a[l,1]; //Começa com o valor "base" = ao primeiro valor recebino pelo L,C = 1,1
			for c:= 1 to 5 do
				begin;	
		      write (a[l,c]:4); 
		      if a[l,c] > maiorelemento then //compara se o valor valor anterior é menor que o  valor comparado, caso sim, vai fazer a troca
				  		begin;
								maiorelemento := a[l,c];
								x:=c 	
							end;
				end;
				write (' - O maior valor é o ', maiorelemento, ' e esta na posição ', l, ' - ',  x);
				writeln; //Quebra de linha	                     	
	  end;
End.