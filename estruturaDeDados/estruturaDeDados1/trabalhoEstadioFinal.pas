program venda_ingressos;

const
  MAX_INGRESSOS = 333;
  MAX_FILA = 10;
  MAX_LISTA_TORCEDORES = 1000;
  MAX_AMIGO = 5;

type
  typePilhaIngressos = record
      itens: array[1..MAX_INGRESSOS] of integer;
      topo: integer;
  end;

  typeFilaTorcedores = record
      itens: array[1..MAX_FILA] of string;
      inicio: integer;
      fim: integer;
  end;

  typeTorcedor = record
      nome: string;
      posicao: string;
      amigos: array[1..MAX_AMIGO] of string;
      totalAmigos: integer;
  end;

  typeListaTorcedores = record
      torcedores: array[1..MAX_LISTA_TORCEDORES] of typeTorcedor;
      total: integer;
  end;

procedure inicializarPilhaIngressos(var pilha: typePilhaIngressos);
begin
  pilha.topo := 0;
end;

procedure empilharIngresso(var pilha: typePilhaIngressos; ingresso: integer);
begin
  if pilha.topo < MAX_INGRESSOS then
  begin
      pilha.topo := pilha.topo + 1;
      pilha.itens[pilha.topo] := ingresso;
  end;
end;

function desempilharIngresso(var pilha: typePilhaIngressos): integer;
begin
  if pilha.topo > 0 then
  begin
      desempilharIngresso := pilha.itens[pilha.topo];
      pilha.topo := pilha.topo - 1;
  end
  else
      desempilharIngresso := 0;
end;

procedure inicializarFilaTorcedores(var fila: typeFilaTorcedores);
begin
  fila.inicio := 1;
  fila.fim := 0;
end;

procedure entrarNaFila(var fila: typeFilaTorcedores; torcedor: string);
begin
  if fila.fim < MAX_FILA then
  begin
      fila.fim := fila.fim + 1;
      fila.itens[fila.fim] := torcedor;
  end;
end;

function sairDaFila(var fila: typeFilaTorcedores): string;
begin
  if fila.fim >= fila.inicio then
  begin
      sairDaFila := fila.itens[fila.inicio];
      fila.inicio := fila.inicio + 1;
  end
  else
      sairDaFila := '';
end;

procedure adicionarTorcedor(var lista: typeListaTorcedores; torcedor: typeTorcedor);
begin
  if lista.total < MAX_LISTA_TORCEDORES then
  begin
      lista.total := lista.total + 1;
      lista.torcedores[lista.total] := torcedor;
      writeln(torcedor.nome, ' - ', torcedor.posicao);
  end
  else
  begin
      writeln('A lista de torcedores está cheia. Não é possível adicionar mais torcedores.');
  end;
end;

procedure exibirMenuAdministrador();
begin
  writeln('Você é Administrador. Escolha sua opção:');
  writeln('1 - Visualizar ingressos');
  writeln('2 - Visualizar valor arrecadado');
  writeln('3 - Consultar nomes e posições');
  writeln('4 - Sair');
end;

procedure exibirMenuTorcedor();
begin
  writeln('Você é Torcedor. Escolha sua opção:');
  writeln('1 - Entrar na fila (Camarote)');
  writeln('2 - Entrar na fila (Lateral)');
  writeln('3 - Entrar na fila (Atras do gol)');
  writeln('4 - Ver cadeiras ocupadas');
  writeln('5 - Sair');
end;

procedure visualizarIngressos(var pilhaCamarote, pilhaLateral, pilhaAtrasGols: typePilhaIngressos);
begin
  writeln('Ingressos disponíveis:');
  writeln('Camarote: ', pilhaCamarote.topo);
  writeln('Lateral do campo: ', pilhaLateral.topo);
  writeln('Atras dos gols: ', pilhaAtrasGols.topo);
end;

procedure visualizarValorArrecadado(var valorCamarote, valorLateral, valorAtrasGols: integer);
begin
  writeln('Valor arrecadado por tipo de ingresso:');
  writeln('Camarote: ', valorCamarote);
  writeln('Lateral do campo: ', valorLateral);
  writeln('Atras dos gols: ', valorAtrasGols);
end;

procedure consultarNomesPosicoes(var listaTorcedores: typeListaTorcedores);
var
  i, j: integer;
begin
  writeln('Nomes e Posições:');
  for i := 1 to listaTorcedores.total do
  begin
      writeln(listaTorcedores.torcedores[i].nome, ' - ', listaTorcedores.torcedores[i].posicao);
      if listaTorcedores.torcedores[i].totalAmigos > 0 then
      begin
          writeln('Amigos:');
          for j := 1 to listaTorcedores.torcedores[i].totalAmigos do
              writeln(listaTorcedores.torcedores[i].amigos[j], ' amigo de ', listaTorcedores.torcedores[i].nome, ' - ', listaTorcedores.torcedores[i].posicao);
      end;
  end;
end;

procedure entrarNaFilaComAmigos(var fila: typeFilaTorcedores; var pilhaIngressos: typePilhaIngressos; nome, posicao: string; var listaTorcedores: typeListaTorcedores);
var
  nomeAmigo: string;
  resposta, i: integer;
begin
  writeln('Deseja comprar ingresso para algum amigo?');
  writeln('1 - Sim');
  writeln('2 - Não');
  readln(resposta);

  while (resposta = 1) and (listaTorcedores.torcedores[listaTorcedores.total].totalAmigos < MAX_AMIGO) do
  begin
      writeln('Informe o nome do amigo:');
      readln(nomeAmigo);
      listaTorcedores.torcedores[listaTorcedores.total].totalAmigos := listaTorcedores.torcedores[listaTorcedores.total].totalAmigos + 1;
      listaTorcedores.torcedores[listaTorcedores.total].amigos[listaTorcedores.torcedores[listaTorcedores.total].totalAmigos] := nomeAmigo;

      // Adiciona o amigo à fila
      entrarNaFila(fila, nomeAmigo + ' (amigo de ' + nome + ')');

      // Desempilha um ingresso da pilha correspondente
      for i := 1 to MAX_INGRESSOS do
      begin
          if pilhaIngressos.itens[i] > 0 then
          begin
              pilhaIngressos.itens[i] := 0;
              Break;
          end;
      end;

      // Atualiza o valor arrecadado
      if posicao = 'Camarote' then
          valorCamarote := valorCamarote + 150
      else if posicao = 'Lateral' then
          valorLateral := valorLateral + 80
      else if posicao = 'Atras do gol' then
          valorAtrasGols := valorAtrasGols + 50;

      writeln('Deseja comprar ingresso para mais algum amigo?');
      writeln('1 - Sim');
      writeln('2 - Não');
      readln(resposta);
  end;
end;

procedure entrarNaFila(var fila: typeFilaTorcedores; var pilhaIngressos: typePilhaIngressos; nome, posicao: string; var valorCamarote, valorLateral, valorAtrasGols: integer; var listaTorcedores: typeListaTorcedores);
begin
  // Adiciona o torcedor principal à fila
  entrarNaFila(fila, nome);

  // Adiciona o torcedor principal à lista de torcedores
  listaTorcedores.total := listaTorcedores.total + 1;
  listaTorcedores.torcedores[listaTorcedores.total].nome := nome;
  listaTorcedores.torcedores[listaTorcedores.total].posicao := posicao;
  listaTorcedores.torcedores[listaTorcedores.total].totalAmigos := 0;

  // Adiciona o torcedor principal à lista de nomes e posições
  listaNomes.nomes[listaNomes.total] := nome;
  listaNomes.posicoes[listaNomes.total] := posicao;
  listaNomes.total := listaNomes.total + 1;

  // Verifica se o torcedor quer comprar ingresso para amigos
  entrarNaFilaComAmigos(fila, pilhaIngressos, nome, posicao, listaTorcedores);

  // Desempilha um ingresso da pilha correspondente
  if posicao = 'Camarote' then
      desempilharIngresso(pilhaCamarote)
  else if posicao = 'Lateral' then
      desempilharIngresso(pilhaLateral)
  else if posicao = 'Atras do gol' then
      desempilharIngresso(pilhaAtrasGols);

  // Atualiza o valor arrecadado
  if posicao = 'Camarote' then
      valorCamarote := valorCamarote + 150
  else if posicao = 'Lateral' then
      valorLateral := valorLateral + 80
  else if posicao = 'Atras do gol' then
      valorAtrasGols := valorAtrasGols + 50;

  writeln('Você entrou na fila para ', posicao);
end;

procedure verCadeirasOcupadas(var filaCamarote, filaLateral, filaAtrasGols: typeFilaTorcedores);
var
  j: integer;
begin
  writeln('Cadeiras ocupadas:');
  writeln('Camarote:');
  for j := 1 to MAX_FILA do
  begin
      if filaCamarote.itens[j] <> '' then
          writeln('Posição ', j, ' - Ocupada')
      else
          writeln('Posição ', j, ' - Vaga');
  end;

  writeln('Lateral do campo:');
  for j := 1 to MAX_FILA do
  begin
      if filaLateral.itens[j] <> '' then
          writeln('Posição ', j, ' - Ocupada')
      else
          writeln('Posição ', j, ' - Vaga');
  end;

  writeln('Atras dos gols:');
  for j := 1 to MAX_FILA do
  begin
      if filaAtrasGols.itens[j] <> '' then
          writeln('Posição ', j, ' - Ocupada')
      else
          writeln('Posição ', j, ' - Vaga');
  end;
end;

var
  pilhaCamarote, pilhaLateral, pilhaAtrasGols: typePilhaIngressos;
  filaCamarote, filaLateral, filaAtrasGols: typeFilaTorcedores;
  listaTorcedores: typeListaTorcedores;
  listaNomes: ListaNomes;
  valorCamarote, valorLateral, valorAtrasGols: integer;
  escolha, nomeTorcedor: string;

begin
  inicializarPilhaIngressos(pilhaCamarote);
  inicializarPilhaIngressos(pilhaLateral);
  inicializarPilhaIngressos(pilhaAtrasGols);
  inicializarFilaTorcedores(filaCamarote);
  inicializarFilaTorcedores(filaLateral);
  inicializarFilaTorcedores(filaAtrasGols);
  listaTorcedores.total := 0;
  listaNomes.total := 0;

  // Preenchendo as pilhas de ingressos
  for i := 1 to MAX_INGRESSOS do
  begin
      empilharIngresso(pilhaCamarote, 150);
      empilharIngresso(pilhaLateral, 80);
      empilharIngresso(pilhaAtrasGols, 50);
  end;

  repeat
      writeln('Você é Administrador ou Torcedor?');
      writeln('1 - Administrador');
      writeln('2 - Torcedor');
      writeln('3 - Sair');
      readln(escolha);

      if escolha = '1' then
      begin
          repeat
              exibirMenuAdministrador();
              readln(escolha);
              if escolha = '1' then
                  visualizarIngressos(pilhaCamarote, pilhaLateral, pilhaAtrasGols)
              else if escolha = '2' then
                  visualizarValorArrecadado(valorCamarote, valorLateral, valorAtrasGols)
              else if escolha = '3' then
                  consultarNomesPosicoes(listaTorcedores);
          until escolha = '4';
      end
      else if escolha = '2' then
      begin
          repeat
              exibirMenuTorcedor();
              readln(escolha);
              if escolha = '1' then
              begin
                  writeln('Informe seu nome:');
                  readln(nomeTorcedor);
                  entrarNaFila(filaCamarote, pilhaCamarote, nomeTorcedor, 'Camarote', valorCamarote, valorLateral, valorAtrasGols, listaTorcedores);
              end
              else if escolha = '2' then
              begin
                  writeln('Informe seu nome:');
                  readln(nomeTorcedor);
                  entrarNaFila(filaLateral, pilhaLateral, nomeTorcedor, 'Lateral', valorCamarote, valorLateral, valorAtrasGols, listaTorcedores);
              end
              else if escolha = '3' then
              begin
                  writeln('Informe seu nome:');
                  readln(nomeTorcedor);
                  entrarNaFila(filaAtrasGols, pilhaAtrasGols, nomeTorcedor, 'Atras do gol', valorCamarote, valorLateral, valorAtrasGols, listaTorcedores);
              end
              else if escolha = '4' then
                  verCadeirasOcupadas(filaCamarote, filaLateral, filaAtrasGols);
          until escolha = '5';
      end
      else if escolha <> '3' then
      begin
          writeln('Opção inválida. Por favor, escolha uma opção válida.');
      end;
  until escolha = '3';
end.
