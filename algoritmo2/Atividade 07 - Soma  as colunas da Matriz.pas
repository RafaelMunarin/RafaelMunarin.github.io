Program Pzim ;

Var l, c: integer;
a: array [1..4,1..4] of integer;
somacoluna: array[1..4] of integer;

Begin
	//Imorimindo a Matriz (normal)
	for l:= 1 to 4 do
		for c:= 1 to 4 do
		begin;
			//write ('Informe elemento ',L,' . ', C,' : ');
			//readln(A[l,c]);	
			a[l,c]:= random(20);
			somacoluna[c]:= somacoluna[c] + a[l,c]; //Separa a soma dos valores por coluna, vai pegar o valor da  linha 1 coluna 1 e somar, linha 1 coluna 2 e somar... 
																						//e salvar tudo na variavel "SOMACOLUNA[1], dai vai pra coluna 2, 3, 4 "
		end;

	//imprime a Matriz 
	for l:= 1 to 4 do 
		begin
			for c:= 1 to 4 do
				write (a[l,c]:4);
				writeln			 
		end;

	//Vai apresentar a soma dos valores que foram inseridos na linha 1 SOMACOLUNA[l], dai vai pra coluna 2, 3, 4		
	for c:=1 to 4 do 
		writeln('soma coluna ', c, ' :', somacoluna[c]);  
End.