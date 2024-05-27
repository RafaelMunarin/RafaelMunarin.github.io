program GerenciadorFilaImpressao;

type
  PNo = ^TNo;
  TNo = record
    nome: string[50];
    quantidadeCopias: integer;
    prioritario: boolean;
    anterior, proximo: PNo;
  end;

  TFila = record
    inicio, fim: PNo;
    tamanho: integer;
  end;

procedure InicializarFila(var fila: TFila);
{ Inicializa a fila, definindo os ponteiros de início e fim como nil e tamanho como 0 }
begin
  fila.inicio := nil;
  fila.fim := nil;
  fila.tamanho := 0;
end;

procedure Enfileirar(var fila: TFila; nome: string; quantidadeCopias: integer; prioritario: boolean);
{ Adiciona um novo cliente à fila com seu nome, quantidade de cópias e prioridade }
var
  novoNo, temp: PNo;
begin
  New(novoNo);
  novoNo^.nome := nome;
  novoNo^.quantidadeCopias := quantidadeCopias;
  novoNo^.prioritario := prioritario;
  novoNo^.proximo := nil;

  if fila.fim = nil then
  begin
    novoNo^.anterior := nil;
    fila.inicio := novoNo;
    fila.fim := novoNo;
  end
  else
  begin
    if prioritario then
    begin
      temp := fila.inicio;
      while (temp <> nil) and (temp^.prioritario) do
        temp := temp^.proximo;

      if temp = nil then
      begin
        novoNo^.anterior := fila.fim;
        fila.fim^.proximo := novoNo;
        fila.fim := novoNo;
      end
      else
      begin
        novoNo^.proximo := temp;
        novoNo^.anterior := temp^.anterior;
        if temp^.anterior <> nil then
          temp^.anterior^.proximo := novoNo
        else
          fila.inicio := novoNo;
        temp^.anterior := novoNo;
      end;
    end
    else
    begin
      novoNo^.anterior := fila.fim;
      fila.fim^.proximo := novoNo;
      fila.fim := novoNo;
    end;
  end;
  fila.tamanho := fila.tamanho + 1;
end;

procedure Desenfileirar(var fila: TFila);
{ Remove o cliente no início da fila }
var
  temp: PNo;
begin
  if fila.inicio <> nil then
  begin
    temp := fila.inicio;
    fila.inicio := fila.inicio^.proximo;
    if fila.inicio = nil then
      fila.fim := nil
    else
      fila.inicio^.anterior := nil;
    Dispose(temp);
    fila.tamanho := fila.tamanho - 1;
  end;
end;

procedure AtenderProximo(var fila: TFila);
{ Atende o próximo cliente na fila, exibindo suas informações e removendo-o da fila }
var
  temp: PNo;
begin
  if fila.inicio <> nil then
  begin
    temp := fila.inicio;
    if temp^.prioritario then
    begin
      writeln('Atendendo cliente prioritário: ', temp^.nome, ' com ', temp^.quantidadeCopias, ' cópias.');
    end
    else
    begin
      writeln('Atendendo cliente: ', temp^.nome, ' com ', temp^.quantidadeCopias, ' cópias.');
    end;
    Desenfileirar(fila);
  end
  else
  begin
    writeln('A fila está vazia.');
  end;
end;

procedure MoverParaFrente(var fila: TFila; nome: string);
{ Move o cliente especificado pelo nome para a frente da fila, se não houver outro prioritário }
var
  temp, atual: PNo;
  jaExistePrioritario: boolean;
begin
  atual := fila.inicio;
  jaExistePrioritario := False;

  { Verifica se já existe um cliente prioritário na fila }
  while (atual <> nil) do
  begin
    if atual^.prioritario then
    begin
      jaExistePrioritario := True;
      Break;
    end;
    atual := atual^.proximo;
  end;

  if jaExistePrioritario then
  begin
    writeln('Já existe um cliente prioritário na fila.');
    Exit;
  end;

  atual := fila.inicio;
  while (atual <> nil) and (atual^.nome <> nome) do
    atual := atual^.proximo;

  if atual <> nil then
  begin
    if atual <> fila.inicio then
    begin
      if atual = fila.fim then
      begin
        fila.fim := atual^.anterior;
        fila.fim^.proximo := nil;
      end
      else
      begin
        atual^.anterior^.proximo := atual^.proximo;
        atual^.proximo^.anterior := atual^.anterior;
      end;
      atual^.anterior := nil;
      atual^.proximo := fila.inicio;
      fila.inicio^.anterior := atual;
      fila.inicio := atual;
    end;
  end;
end;

procedure ImprimirFila(fila: TFila);
{ Imprime todos os clientes na fila com suas informações }
var
  temp: PNo;
begin
  temp := fila.inicio;
  while temp <> nil do
  begin
    writeln('Nome: ', temp^.nome, ' | Cópias: ', temp^.quantidadeCopias, ' | Prioritário: ', temp^.prioritario);
    temp := temp^.proximo;
  end;
end;

var
  filaMono, filaColor, filaPlotter: TFila;
  opcao: integer;
  nome: string;
  quantidadeCopias: integer;
  prioritario: boolean;
  prioridade: integer;

begin
  InicializarFila(filaMono);
  InicializarFila(filaColor);
  InicializarFila(filaPlotter);

  repeat
    writeln('1. Adicionar cliente à fila');
    writeln('2. Remover cliente da fila');
    writeln('3. Consultar filas');
    writeln('4. Priorizar cliente');
    writeln('5. Atender próximo cliente');
    writeln('0. Sair');
    writeln('Escolha uma opção: ');
    readln(opcao);

    case opcao of
      1:
        begin
          writeln('Nome do cliente: ');
          readln(nome);
          writeln('Quantidade de cópias: ');
          readln(quantidadeCopias);
          writeln('Prioritário (1 para sim, 0 para não): ');
          readln(prioridade);
          prioritario := prioridade = 1;
          writeln('Fila (1 - Mono, 2 - Color, 3 - Plotter): ');
          readln(opcao);
          case opcao of
            1: Enfileirar(filaMono, nome, quantidadeCopias, prioritario);
            2: Enfileirar(filaColor, nome, quantidadeCopias, prioritario);
            3: Enfileirar(filaPlotter, nome, quantidadeCopias, prioritario);
          end;
        end;
      2:
        begin
          writeln('Fila (1 - Mono, 2 - Color, 3 - Plotter): ');
          readln(opcao);
          case opcao of
            1: Desenfileirar(filaMono);
            2: Desenfileirar(filaColor);
            3: Desenfileirar(filaPlotter);
          end;
        end;
      3:
        begin
          writeln('Fila Mono:');
          ImprimirFila(filaMono);
          writeln('Fila Color:');
          ImprimirFila(filaColor);
          writeln('Fila Plotter:');
          ImprimirFila(filaPlotter);
        end;
      4:
        begin
          writeln('Nome do cliente a priorizar: ');
          readln(nome);
          writeln('Fila (1 - Mono, 2 - Color, 3 - Plotter): ');
          readln(opcao);
          case opcao of
            1: MoverParaFrente(filaMono, nome);
            2: MoverParaFrente(filaColor, nome);
            3: MoverParaFrente(filaPlotter, nome);
          end;
        end;
      5:
        begin
          writeln('Fila (1 - Mono, 2 - Color, 3 - Plotter): ');
          readln(opcao);
          case opcao of
            1: AtenderProximo(filaMono);
            2: AtenderProximo(filaColor);
            3: AtenderProximo(filaPlotter);
          end;
        end;
    end;
  until opcao = 0;
end.

