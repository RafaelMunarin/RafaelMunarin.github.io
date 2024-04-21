Program Pzim ;

Var l, c: integer;
a: array [1..4,1..4] of integer;
somalinha: array[1..4] of integer;

Begin
	//Imorimindo a Matriz (normal)
	for l:= 1 to 4 do
		for c:= 1 to 4 do
		begin;
			//write ('Informe elemento ',L,' . ', C,' : ');
			//readln(A[l,c]);	
			a[l,c]:=random (20);
			somalinha[l]:= somalinha[l] + a[l,c]; //Separa a soma dos valores por linha, vai pegar o valor da  linha 1 coluna 1 e somar, linha 1 coluna 2 e somar... 
																						//e salvar tudo na variavel "SOMALINHA[1], dai vai pra linha 2, 3, 4 "
		end;

	//imprime a Matriz com a soma do lado 
	for l:= 1 to 4 do 
		begin
			for c:= 1 to 4 do
				write (a[l,c]:4);                           
				writeln(' - soma linha : ',somalinha[l]); //Vai apresentar a soma dos valores que foram inseridos na linha 1 SOMALINHA[l], dai vai pra linha 2, 3, 4
				writeln			 
		end; 
End.