Program Pzim ;
var v: array[1..100] of integer;
    i, j, n, aux, troca,ultima_troca: integer;
    inicio, fim, meio, achou, x:integer;
   
Begin
	//Ler o tamanho do vwtor
  writeln ('Informe o tamanho do vetor:');
  readln(n);
  
	//Apresentar o vetor de forma randomica
  for i:= 1 to n do
    v[i]:=random(50);   
  for i:= 1 to n do
    write (v[i]:4);
    
  writeln; //Quebra de linha  
  
	//Bubble Sort para organizar os elementos
	ultima_troca:= n-1;
  troca:=1;
  while troca >0 do
	begin
	  troca:=0;
    for j:= 1 to ultima_troca do
      if v[j] > v[j+1] then
      begin
         aux:=v[j];
         v[j]:=v[j+1];
         v[j+1]:= aux;
         troca:=j
      end;
    ultima_troca:=troca-1 
  end;
  
  writeln; //Quebra de linha
  
  //Apresentar o Vetor ja organizado
  writeln ('Vetor ja organizado:');
  writeln;
  for i:= 1 to n do
    write (v[i]:4);
  writeln;  
  
  writeln; //Quebra de linha
  
  //Ler o valor que queremos pesquiser dentro do Vetor
  writeln ('Indique qual o valor a ser pesquisado');
  readln(x);
  
  //Faz a pesquisa dentro do vetor usando a "Pesquisa Binaria"
  inicio:=1;
  fim:=n;
  achou:=0;
  meio:= (inicio + fim) div 2;
  while (inicio <= fim) and (achou=0) do
  begin
     if v[meio] = x then 
        achou:=meio
     else if v[meio] < x then //Quando vamos procurar pra "cima" do meio = meio + 1
            inicio:= meio+1
          else
					  fim:= meio-1;
     meio:= (inicio + fim) div 2; //Quando vamos procurar pra "baixo" do meio = meio - 1			  
  end;
  
  writeln; //Quebra de linha
  
  //Apresenta se o Nr foi encontrado no vetor e sua posição, caso não seja encontrado, só fala que não achou
	if achou <> 0 then
	   Writeln ('Elemento encontrado na posição ', meio)
	else
	   writeln ('Elemento não encontrado no vetor');
  writeln;
end.  
            
