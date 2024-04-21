Program Pzim;
var l, c: integer;
a: array [1..4,1..4] of integer;


Begin
//declarando quais são os elementos da MATRIZ
	for l:= 1 to 4 do
		for c:= 1 to 4 do
			a[l,c]:= random(20);

//imprimindo a MATRIZ ja formatada
Writeln ('Valores da Maatriz');		
	for l:= 1 to 4 do
		begin
		for c:= 1 to 4 do		
			write (a[l,c]:4);
	    writeln;
		end;
		
writeln;

//imprimir todos os elementos da diagonal principal
Writeln ('Valores da Diagonal Principal');		
	for l:= 1 to 4 do
		writeln (a[l,l]:4); //Todos os elementos (linha e coluna) devem ser iguais, por isso colocamos a[l,l] pra trazer os números onde esses dois valores são iguais

writeln;

//imprimir todos os elementos da diagonal secundária
Writeln ('Valores da Diagonal Secundária');			  
	for l:= 1  to 4 do
		writeln (a[l,5-l]:4); //OS elementos da coluna devem ir do 4 -> 3 -> 2 -> 1, dessa forma usamos o a[l, 5-l], pois ele vai começar na linha 1 com  acoluna 5-1 = 4 ficando a[1,4]
		
writeln;

//imprimindo todos os elementos do triangulo superior
Writeln ('Valores do Triangulo Superior');
	for l:=1 to 4 do
		for c:= l+1 to 4 do //Na linha 1 ele vai pegar o valor da coluna 1 + 1 ficando o nr da posição 2, e assim por diante, na  linha dois  ele vai pegar o nr da  posiçãõ 2+1...
			writeln (a[l,c]:4);
			
writeln;

//imprimindo todos os elementos do triangulo superior
Writeln ('Valores do Triangulo Inferior');
	for l:= 1 to 4 do                       	
		for c:= 1 to l-1  do //Na linha 1 ele vai ignorar td, pq na non for da coluna ele faz L-1 = 0 ,dai vai pra linha 2, 2-1=1 vai pegar o nr da posição L=1 e C=1 e assim por diante
			writeln (a[l,c]:4);
End.