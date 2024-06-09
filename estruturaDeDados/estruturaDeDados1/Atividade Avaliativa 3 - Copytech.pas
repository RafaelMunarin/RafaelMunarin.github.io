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

{ Inicializa a fila, definindo os ponteiros de in�cio e fim como nil e o tamanho como 0 }
procedure InicializarFila(var fila: TFilaImpressao);
begin
  fila.inicio := nil;
  fila.fim := nil;
  fila.tamanho := 0;
end;

{ Adiciona um novo cliente � fila com seu nome, quantidade de c�pias e prioridade }
procedure AdicionarClienteFila(var fila: TFilaImpressao; nomeCliente: string; quantidadeCopias: integer; prioritario: boolean);
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

{ Remove o cliente especificado pelo nome }
procedure RemoverClienteFila(var fila: TFilaImpressao; nomeCliente: string);
var
  temp: PAuxiliar;
begin
  temp := fila.inicio;
  
  { Procurar o cliente na fila }
  while (temp <> nil) and (temp^.nomeCliente <> nomeCliente) do
    temp := temp^.proximo;

  { Cliente n�o encontrado }
  if temp = nil then
  begin
    writeln('Cliente n�o encontrado.');
    Exit;
  end;

  { Ajustar ponteiros e remover o cliente }
  if temp^.anterior <> nil then
    temp^.anterior^.proximo := temp^.proximo
  else
    fila.inicio := temp^.proximo;

  if temp^.proximo <> nil then
    temp^.proximo^.anterior := temp^.anterior
  else
    fila.fim := temp^.anterior;

  Dispose(temp);
  fila.tamanho := fila.tamanho - 1;
end;

{ Atende o pr�ximo cliente na fila, exibindo suas informa��es e removendo-o da fila }
procedure AtenderProximoCliente(var fila: TFilaImpressao);
var
  temp: PAuxiliar;
begin
  if fila.inicio <> nil then
  begin
    temp := fila.inicio;
    if temp^.prioritario then
    begin
      writeln('Atendendo cliente priorit�rio: ', temp^.nomeCliente, ' com ', temp^.quantidadeCopias, ' c�pias.');
    end
    else
    begin
      writeln('Atendendo cliente: ', temp^.nomeCliente, ' com ', temp^.quantidadeCopias, ' c�pias.');
    end;
    RemoverClienteFila(fila, temp^.nomeCliente);
  end
  else
  begin
    writeln('A fila est� vazia.');
  end;
end;

{ Move o cliente especificado pelo nome para a frente da fila, se n�o houver outro priorit�rio }
procedure PriorizarCliente(var fila: TFilaImpressao; nomeCliente: string);
var
  temp, atual: PAuxiliar;
  jaExistePrioritario: boolean;
begin
  atual := fila.inicio;
  jaExistePrioritario := False;

  { Verifica se j� existe um cliente priorit�rio na fila }
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
    writeln('J� existe um cliente priorit�rio na fila.');
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

{ Imprime todos os clientes na fila com suas informa��es }
procedure ImprimirFila(fila: TFilaImpressao);
var
  temp: PAuxiliar;
begin
  temp := fila.inicio;
  while temp <> nil do
  begin
    writeln('Nome: ', temp^.nomeCliente, ' | C�pias: ', temp^.quantidadeCopias, ' | Priorit�rio: ', temp^.prioritario);
    temp := temp^.proximo;
  end;
end;

var
  filaMono, filaColor, filaPlotter: TFilaImpressao;
  opcao: integer;
  nomeCliente: string;
  quantidadeCopias: integer;
  prioritario: boolean;
  prioridade: integer;

begin
  InicializarFila(filaMono);
  InicializarFila(filaColor);
  InicializarFila(filaPlotter);

  repeat
    writeln('1. Adicionar cliente � fila');
    writeln('2. Remover cliente da fila');
    writeln('3. Consultar filas');
    writeln('4. Priorizar cliente');
    writeln('5. Atender pr�ximo cliente');
    writeln('0. Sair');
    writeln('Escolha uma op��o: ');
    readln(opcao);

    case opcao of
      1:
        begin
          writeln('Nome do cliente: ');
          readln(nomeCliente);
          writeln('Quantidade de c�pias: ');
          readln(quantidadeCopias);
          writeln('Priorit�rio (1 para sim, 0 para n�o): ');
          readln(prioridade);
          prioritario := prioridade = 1;
          writeln('Fila (1 - Mono, 2 - Color, 3 - Plotter): ');
          readln(opcao);
          case opcao of
            1: AdicionarClienteFila(filaMono, nomeCliente, quantidadeCopias, prioritario);
            2: AdicionarClienteFila(filaColor, nomeCliente, quantidadeCopias, prioritario);
            3: AdicionarClienteFila(filaPlotter, nomeCliente, quantidadeCopias, prioritario);
          end;
        end;
      2:
        begin
          writeln('Nome do cliente a remover: ');
          readln(nomeCliente);
          writeln('Fila (1 - Mono, 2 - Color, 3 - Plotter): ');
          readln(opcao);
          case opcao of
            1: RemoverClienteFila(filaMono, nomeCliente);
            2: RemoverClienteFila(filaColor, nomeCliente);
            3: RemoverClienteFila(filaPlotter, nomeCliente);
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
          readln(nomeCliente);
          writeln('Fila (1 - Mono, 2 - Color, 3 - Plotter): ');
          readln(opcao);
          case opcao of
            1: PriorizarCliente(filaMono, nomeCliente);
            2: PriorizarCliente(filaColor, nomeCliente);
            3: PriorizarCliente(filaPlotter, nomeCliente);
          end;
        end;
      5:
        begin
          writeln('Fila (1 - Mono, 2 - Color, 3 - Plotter): ');
          readln(opcao);
          case opcao of
            1: AtenderProximoCliente(filaMono);
            2: AtenderProximoCliente(filaColor);
            3: AtenderProximoCliente(filaPlotter);
          end;
        end;
    end;
  until opcao = 0;
end.
