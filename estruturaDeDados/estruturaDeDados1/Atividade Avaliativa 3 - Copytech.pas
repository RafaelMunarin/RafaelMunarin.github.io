program GerenciadorFilaImpressao;

// Alunos: Daniel Espindola, Rafael Munarin

type
  PAuxiliar = ^TAuxiliar;
  TAuxiliar = record
    nomeCliente: string[50];
    quantidadeCopias: integer;
    prioritario: boolean;
    anterior, proximo: PAuxiliar;
  end;

  TFilaImpressao = record
    inicio, fim: PAuxiliar;
    tamanho: integer;
  end;

procedure InicializarFila(var fila: TFilaImpressao);
{ Inicializa a fila, definindo os ponteiros de início e fim como nil e o tamanho como 0 }
begin
  fila.inicio := nil;
  fila.fim := nil;
  fila.tamanho := 0;
end;

procedure AdicionarClienteFila(var fila: TFilaImpressao; nomeCliente: string; quantidadeCopias: integer; prioritario: boolean);
{ Adiciona um novo cliente à fila com seu nome, quantidade de cópias e prioridade }
var
  novoAuxiliar, temp: PAuxiliar;
begin
  New(novoAuxiliar);
  novoAuxiliar^.nomeCliente := nomeCliente;
  novoAuxiliar^.quantidadeCopias := quantidadeCopias;
  novoAuxiliar^.prioritario := prioritario;
  novoAuxiliar^.proximo := nil;

  if fila.fim = nil then
  begin
    novoAuxiliar^.anterior := nil;
    fila.inicio := novoAuxiliar;
    fila.fim := novoAuxiliar;
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
        novoAuxiliar^.anterior := fila.fim;
        fila.fim^.proximo := novoAuxiliar;
        fila.fim := novoAuxiliar;
      end
      else
      begin
        novoAuxiliar^.proximo := temp;
        novoAuxiliar^.anterior := temp^.anterior;
        if temp^.anterior <> nil then
          temp^.anterior^.proximo := novoAuxiliar
        else
          fila.inicio := novoAuxiliar;
        temp^.anterior := novoAuxiliar;
      end;
    end
    else
    begin
      novoAuxiliar^.anterior := fila.fim;
      fila.fim^.proximo := novoAuxiliar;
      fila.fim := novoAuxiliar;
    end;
  end;
  fila.tamanho := fila.tamanho + 1;
end;

procedure RemoverClienteFila(var fila: TFilaImpressao);
{ Remove o cliente no início da fila }
var
  temp: PAuxiliar;
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

procedure AtenderProximoCliente(var fila: TFilaImpressao);
{ Atende o próximo cliente na fila, exibindo suas informações e removendo-o da fila }
var
  temp: PAuxiliar;
begin
  if fila.inicio <> nil then
  begin
    temp := fila.inicio;
    if temp^.prioritario then
    begin
      writeln('Atendendo cliente prioritário: ', temp^.nomeCliente, ' com ', temp^.quantidadeCopias, ' cópias.');
    end
    else
    begin
      writeln('Atendendo cliente: ', temp^.nomeCliente, ' com ', temp^.quantidadeCopias, ' cópias.');
    end;
    RemoverClienteFila(fila);
  end
  else
  begin
    writeln('A fila está vazia.');
  end;
end;

procedure PriorizarCliente(var fila: TFilaImpressao; nomeCliente: string);
{ Move o cliente especificado pelo nome para a frente da fila, se não houver outro prioritário }
var
  temp, atual: PAuxiliar;
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
  while (atual <> nil) and (atual^.nomeCliente <> nomeCliente) do
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

procedure ImprimirFila(fila: TFilaImpressao);
{ Imprime todos os clientes na fila com suas informações }
var
  temp: PAuxiliar;
begin
  temp := fila.inicio;
  while temp <> nil do
  begin
    writeln('Nome: ', temp^.nomeCliente, ' | Cópias: ', temp^.quantidadeCopias, ' | Prioritário: ', temp^.prioritario);
    temp := temp^.proximo;
  end;
end;

var
  filaMono, filaColorida, filaPlotter: TFilaImpressao;
  opcao: integer;
  nomeCliente: string;
  quantidadeCopias: integer;
  prioritario: boolean;
  prioridade: integer;

begin
  InicializarFila(filaMono);
  InicializarFila(filaColorida);
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
          readln(nomeCliente);
          writeln('Quantidade de cópias: ');
          readln(quantidadeCopias);
          writeln('Prioritário (1 para sim, 0 para não): ');
          readln(prioridade);
          prioritario := prioridade = 1;
          writeln('Fila (1 - Mono, 2 - Colorida, 3 - Plotter): ');
          readln(opcao);
          case opcao of
            1: AdicionarClienteFila(filaMono, nomeCliente, quantidadeCopias, prioritario);
            2: AdicionarClienteFila(filaColorida, nomeCliente, quantidadeCopias, prioritario);
            3: AdicionarClienteFila(filaPlotter, nomeCliente, quantidadeCopias, prioritario);
          end;
        end;
      2:
        begin
          writeln('Fila (1 - Mono, 2 - Colorida, 3 - Plotter): ');
          readln(opcao);
          case opcao of
            1: RemoverClienteFila(filaMono);
            2: RemoverClienteFila(filaColorida);
            3: RemoverClienteFila(filaPlotter);
          end;
        end;
      3:
        begin
          writeln('Fila Mono:');
          ImprimirFila(filaMono);
          writeln('Fila Colorida:');
          ImprimirFila(filaColorida);
          writeln('Fila Plotter:');
          ImprimirFila(filaPlotter);
        end;
      4:
        begin
          writeln('Nome do cliente a priorizar: ');
          readln(nomeCliente);
          writeln('Fila (1 - Mono, 2 - Colorida, 3 - Plotter): ');
          readln(opcao);
          case opcao of
            1: PriorizarCliente(filaMono, nomeCliente);
            2: PriorizarCliente(filaColorida, nomeCliente);
            3: PriorizarCliente(filaPlotter, nomeCliente);
          end;
        end;
      5:
        begin
          writeln('Fila (1 - Mono, 2 - Colorida, 3 - Plotter): ');
          readln(opcao);
          case opcao of
            1: AtenderProximoCliente(filaMono);
            2: AtenderProximoCliente(filaColorida);
            3: AtenderProximoCliente(filaPlotter);
          end;
        end;
    end;
  until opcao = 0;
end.
