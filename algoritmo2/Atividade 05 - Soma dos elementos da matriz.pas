Program Pzim ;

Var l, c, soma: integer;
a: array [1..4,1..4] of integer; 
b: array [1..4,1..4] of integer; 

Begin
	//Lendo os elementos da Matriz e salvando os valores deles na variavel "SOMA"
	for l:= 1 to 4 do
		for c:= 1 to 4 do
		begin;                                                                           	
			//write ('Informe elemento ',L,' . ', C,' : ');
			//readln(A[l,c]);
			a[l,c]:=random (20);
			soma:= soma + a[l,c]; //Toda vez que um valor for atribuido ao a[l,c], vai gaurdar na variavel "SOMA" e fazer essa mesma váriavel mais ela mesma mais o valor do prx nr. 			
		end;

	//Imprimindo a Matriz (normal)		
	for l:= 1 to 4 do 
		begin
			for c:= 1 to 4 do
				write (a[l,c]:4);
				writeln			 
		end;
		
	//No final ele ta juntando todos os valores somados na variavel "SOMA", dai só colocar em um WRITELN pra imprimir o valor
	writeln ('Soma dos valores da Matriz: ', soma);
End.
