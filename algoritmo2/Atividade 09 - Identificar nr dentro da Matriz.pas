Program Pzim ;
Var l,c,x,achou: integer;
a: array [1..3,1..3] of integer;

Begin
	
	//Inserindo valores na Matriz
	for l:= 1 to 3 do
		for c:= 1 to 3 do
			a[l,c]:= random(20);
			
	//Imprimindo a Matriz
	for l:= 1 to 3 do
		begin;
			for c:= 1 to 3 do
				write (a[l,c]:4);
				writeln;
		end;

writeln; //Quebra de linha

	//Lendo o nr que queremos procurar dentro da Matriz
	writeln('Informe o nr "X" que deseja procurar dentro da Matriz:');
	readln (x);                                        

	//Procurando o valor que foi informado na variavel X e altera o valor da Variavel "ACHOU", 1 = encontrou 2 = n	ão encontrou
	achou:=2;		
	for l:= 1 to 3 do	
		begin;	
			for c:= 1 to 3 do
				if x = a[l,c] then
					begin 
						achou:=1;
						break;				
					end
		end;

	//Informa se o valor foi encontrado ou não	
	case achou of
		1	: writeln ('O número informando FOI encontrado dentro da Matriz');
		2: writeln ('O número informado NÃO FOI encontrado denntro da Matriz')
	end;			
				
End.