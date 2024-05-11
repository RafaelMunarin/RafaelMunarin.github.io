program venda_ingressos;

//Valores m�ximos atribuidos
const
  maxIngresso = 333;
  maxFila = 10;
  maxLista = 1000;
  MAX_AMIGO = 5;

type
//Declara��o do tipo typeRecordPilha que define uma estrutura de pilha com um array de itens e um inteiro representando o topo da pilha.
  typeRecordPilha = record
    itens: array[1..maxIngresso] of integer;
    topo: integer;
  end;
  
//Declara��o do tipo typeRecordFila que define uma estrutura de fila com um array de itens, e dois inteiros representando o in�cio e o fim da fila                                            
  typeRecordFila = record
    itens: array[1..maxFila] of string;
    inicio: integer;
    fim: integer;
  end;
  
//Declara��o do tipo typeRecordTorcedor que define uma estrutura representando um torcedor, contendo seu nome, posi��o no est�dio, um array de nomes de amigos e o total de amigos.
  typeRecordTorcedor = record
    nome: string;
    posicao: string;
    amigos: array[1..MAX_AMIGO] of string;
    totalAmigos: integer;
  end;

//Declara��o do tipo typeRecordListaTorcedores que define uma estrutura de lista de torcedores com um array de torcedores e um inteiro representando o total de torcedores na lista.
  typeRecordListaTorcedores = record
    torcedores: array[1..maxLista] of typeRecordTorcedor;
    total: integer;
  end;

//Declara��o do tipo  typeRecordListaNomes que define uma estrutura de lista de nomes e posi��es com arrays de nomes, posi��es e inteiros representando o total de elementos na lista e o �ndice atual.
   typeRecordListaNomes = record
    nomes: array[1..maxLista] of string;
    posicoes: array[1..maxLista] of string;
    total: integer;
    indiceAtual: integer;
  end;

//Variaveis Globais
var
  pilhaCamarote, pilhaLateral, pilhaAtrasGols: typeRecordPilha;
  filaCamarote, filaLateral, filaAtrasGols: typeRecordFila;
  listaTorcedores: typeRecordListaTorcedores;
  listaNomes:  typeRecordListaNomes;
  valorTotalCamarote, valorTotalLateral, valorTotalAtrasGols: integer;
  i: integer;
  novoTorcedor: typeRecordTorcedor;
  nomeTorcedor, nomeAmigo: string;
  escolha, resposta: integer;

//Aqui � definida a procedure empilhar, que recebe uma pilha e um item a ser empilhado. Se a pilha n�o estiver cheia, o item � adicionado ao topo da pilha.
procedure empilhar(var pilha: typeRecordPilha; item: integer);
begin
  if pilha.topo < maxIngresso then
  begin
    pilha.topo := pilha.topo + 1;
    pilha.itens[pilha.topo] := item;
  end;
end;

//Aqui � definida a fun��o desempilhar, que recebe uma pilha e remove e retorna o item do topo, se a pilha n�o estiver vazia.
function desempilhar(var pilha: typeRecordPilha): integer;
begin
  if pilha.topo > 0 then
  begin
    desempilhar := pilha.itens[pilha.topo];
    pilha.topo := pilha.topo - 1;
  end
  else
    desempilhar := 0;
end;

//Aqui � definida a procedure inicializarFila, que recebe uma fila e a inicializa, definindo o in�cio como 1 e o fim como 0.
procedure inicializarFila(var fila: typeRecordFila);
begin
  fila.inicio := 1;
  fila.fim := 0;
end;

//Aqui � definida a procedure inicializarPilhas, que inicializa as pilhas de ingressos (Camarote, Lateral e AtrasGols) e as preenche com os valores dos ingressos.
procedure inicializarPilhas(var pilhaCamarote, pilhaLateral, pilhaAtrasGols: typeRecordPilha);
var
  i: integer;
begin
  pilhaCamarote.topo := 0;
  pilhaLateral.topo := 0;
  pilhaAtrasGols.topo := 0;

  // Preenchendo as pilhas de ingressos
  for i := 1 to maxIngresso do
  begin
    empilhar(pilhaCamarote, 150);
    empilhar(pilhaLateral, 80);
    empilhar(pilhaAtrasGols, 50);
  end;
end;

//Aqui � definida a procedure inicializarPilhas, que inicializa as pilhas de ingressos (Camarote, Lateral e AtrasGols) e as preenche com os valores dos ingressos.
procedure entrar(var fila: typeRecordFila; item: string);
begin
  if fila.fim < maxFila then
  begin
    fila.fim := fila.fim + 1;
    fila.itens[fila.fim] := item;
  end;
end;

//Aqui � definida a procedure exibirTorcedoresPorPosicao, que recebe uma posi��o no est�dio e exibe os nomes dos torcedores que ocupam essa posi��o, utilizando a lista de nomes e posi��es.
procedure exibirTorcedoresPorPosicao(posicao: string);
var
  i: integer;
  temNomes: boolean;
begin
  writeln(posicao + ' --> ');
  temNomes := false;
  
  for i := 1 to listaNomes.total do
  begin
    if (listaNomes.nomes[i] <> '') and (listaNomes.posicoes[i] = posicao) then
    begin
      temNomes := true;
      writeln(listaNomes.nomes[i]);
    end;
  end;
end;

//Aqui � definida a procedure entrarNaFila, que recebe uma posi��o no est�dio. Essa procedure interage com o usu�rio para permitir que ele compre ingressos para si mesmo e para seus amigos.
procedure entrarNaFila(posicao: string);
var
  k: integer;
begin
  if nomeTorcedor = '' then
    writeln('Por favor, informe seu nome antes de entrar na fila.');

	//Adiciona amigo � fila  
  writeln('Deseja comprar ingresso para algum amigo?');
  writeln;
  writeln('1 - Sim');
  writeln('2 - N�o');
  writeln;
  readln(resposta);
  clrscr;
  
  while (resposta = 1) and (novoTorcedor.totalAmigos < MAX_AMIGO) do
  begin
    writeln('Informe o nome do amigo:');
    readln(nomeAmigo);
    clrscr;
    novoTorcedor.totalAmigos := novoTorcedor.totalAmigos + 1;
    novoTorcedor.amigos[novoTorcedor.totalAmigos] := nomeAmigo;
    
    // Adiciona o amigo � fila
    if posicao = 'Camarote' then
    begin
      // Desempilha um ingresso da pilha correspondente
      if pilhaCamarote.topo > 0 then
        desempilhar(pilhaCamarote);
      entrar(filaCamarote, nomeAmigo);
      // Atualiza o valor arrecadado
      valorTotalCamarote := valorTotalCamarote + 150;
    end
    else if posicao = 'Lateral' then
    begin
      // Desempilha um ingresso da pilha correspondente
      if pilhaLateral.topo > 0 then
        desempilhar(pilhaLateral);
      entrar(filaLateral, nomeAmigo);
      // Atualiza o valor arrecadado
      valorTotalLateral := valorTotalLateral + 80;
    end
    else if posicao = 'Atras do gol' then
    begin
      // Desempilha um ingresso da pilha correspondente
      if pilhaAtrasGols.topo > 0 then
        desempilhar(pilhaAtrasGols);
      entrar(filaAtrasGols, nomeAmigo);
      // Atualiza o valor arrecadado
      valorTotalAtrasGols := valorTotalAtrasGols + 50;
    end;
    
    // Adiciona o amigo � lista de nomes e posi��es
    if listaNomes.indiceAtual <= listaNomes.total then
    begin
      listaNomes.nomes[listaNomes.indiceAtual] := nomeAmigo;
      listaNomes.posicoes[listaNomes.indiceAtual] := posicao;
      listaNomes.indiceAtual := listaNomes.indiceAtual + 1;
    end;
    
    writeln('Deseja comprar ingresso para mais algum amigo?');
    writeln;
    writeln('1 - Sim');
    writeln('2 - N�o');
    writeln;
    readln(resposta);
    clrscr;
  end;
  
  // Adiciona o torcedor principal � fila
  if posicao = 'Camarote' then
  begin
    entrar(filaCamarote, nomeTorcedor);
    // Atualiza o valor arrecadado
    valorTotalCamarote := valorTotalCamarote + 150;
    // Desempilha um ingresso da pilha correspondente
    if pilhaCamarote.topo > 0 then
      desempilhar(pilhaCamarote);
    // Limpa as outras filas
    inicializarFila(filaLateral);
    inicializarFila(filaAtrasGols);
  end
  else if posicao = 'Lateral' then
  begin
    entrar(filaLateral, nomeTorcedor);
    // Atualiza o valor arrecadado
    valorTotalLateral := valorTotalLateral + 80;
    // Desempilha um ingresso da pilha correspondente
    if pilhaLateral.topo > 0 then
      desempilhar(pilhaLateral);
    // Limpa as outras filas
    inicializarFila(filaCamarote);
    inicializarFila(filaAtrasGols);
  end
  else if posicao = 'Atras do gol' then
  begin
    entrar(filaAtrasGols, nomeTorcedor);
    // Atualiza o valor arrecadado
    valorTotalAtrasGols := valorTotalAtrasGols + 50;
    // Desempilha um ingresso da pilha correspondente
    if pilhaAtrasGols.topo > 0 then
      desempilhar(pilhaAtrasGols);
    // Limpa as outras filas
    inicializarFila(filaCamarote);
    inicializarFila(filaLateral);
  end;
  
  // Adiciona o torcedor principal � lista de nomes e posi��es
  if listaNomes.indiceAtual <= listaNomes.total then
  begin
    listaNomes.nomes[listaNomes.indiceAtual] := nomeTorcedor;
    listaNomes.posicoes[listaNomes.indiceAtual] := posicao;
    listaNomes.indiceAtual := listaNomes.indiceAtual + 1;
  end;
end;

//Parte Visual do programa
procedure exibirMenuAdministrador();
begin
  writeln('Voc� � um Administrador. Escolha sua op��o:');
  Writeln;
  writeln('1 - Ingressos');
  writeln('2 - Valores arrecadados');
  writeln('3 - Compradores por posi��o');
  writeln('4 - Sair');
  writeln;
end;

procedure exibirMenuTorcedor();
begin
  writeln('Voc� � um Torcedor. Escolha sua op��o:');
  Writeln;
  writeln('1 - Comprar ingresso (Camarote)');
  writeln('2 - Comprar ingresso (Lateral)');
  writeln('3 - Comprar ingresso (Atras do gol)');
  writeln('4 - Sair');
  writeln;
end;

procedure visualizarIngressos();
begin
  writeln('Ingressos dispon�veis:');
  Writeln;
  writeln('Camarote: ', pilhaCamarote.topo);
  writeln; writeln('----'); Writeln; 
  writeln('Lateral do campo: ', pilhaLateral.topo);
  writeln; writeln('----'); Writeln; 
  writeln('Atras dos gols: ', pilhaAtrasGols.topo);
  writeln;
end;

procedure visualizarValorArrecadado();
begin
  writeln('Valor arrecadado por tipo de ingresso:');
  Writeln;
  writeln('Camarote: ', valorTotalCamarote);
  writeln('----'); Writeln; 
  writeln('Lateral do campo: ', valorTotalLateral);
  writeln('----'); Writeln; 
  writeln('Atras dos gols: ', valorTotalAtrasGols);
  writeln;
end;

procedure visualizarConsultaNomesPosicoes();
begin
	writeln ('Compradores por posi��o do campo');
	Writeln;
	// Chama a fun��o para exibir os torcedores em uma posi��o espec�fica
  exibirTorcedoresPorPosicao('Camarote');
  writeln('----'); Writeln; 
  exibirTorcedoresPorPosicao('Lateral');
  writeln('----'); Writeln;
  exibirTorcedoresPorPosicao('Atras do gol');
  writeln;
end;

//Programa Principal
begin
	inicializarPilhas(pilhaCamarote, pilhaLateral, pilhaAtrasGols);
  inicializarFila(filaCamarote);
  inicializarFila(filaLateral);
  inicializarFila(filaAtrasGols);
  listaTorcedores.total := 0;
  listaNomes.total := maxLista;
  listaNomes.indiceAtual := 1;
  
  repeat
    writeln('Voc� vai Gerenciar os Ingresoss ou � Torcedor?');
    Writeln;
    writeln('1 - Gerenciador Ingressos');
    writeln('2 - Torcedor');
    writeln('3 - Sair');
    Writeln;
    readln(escolha);
    clrscr;
    case escolha of
      1:
      begin
        repeat
          exibirMenuAdministrador();
          readln(escolha);
          clrscr;
          case escolha of
            1: visualizarIngressos();
            2: visualizarValorArrecadado();
            3: visualizarConsultaNomesPosicoes();
          end;
        until escolha = 4;
      end;
      2:
      begin
        repeat
          exibirMenuTorcedor();
          readln(escolha);
          clrscr;
          case escolha of
            1, 2, 3:
            begin
              writeln('Informe seu nome:');
              Writeln;
              readln(nomeTorcedor);
              clrscr;
              novoTorcedor.totalAmigos := 0;
              case escolha of
                1: entrarNaFila('Camarote');
                2: entrarNaFila('Lateral');
                3: entrarNaFila('Atras do gol');
              end;
            end;
          end;
        until escolha = 4;
      end;
    end;
  until escolha = 3;
end.