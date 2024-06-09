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
{ Inicializa a fila, definindo os ponteiros de in�cio e fim como nil e o tamanho como 0 }
begin
  fila.inicio := nil;
  fila.fim := nil;
  fila.tamanho := 0;
end;

procedure AdicionarClienteFila(var fila: TFilaImpressao; nomeCliente: string; quantidadeCopias: integer; prioritario: boolean);
{ Adiciona um novo cliente � fila com seu nome, quantidade de c�pias e prioridade }
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
{ Remove o cliente no in�cio da fila }
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
        
        end;
      4:
        begin
          writeln('Nome do cliente a priorizar: ');
          readln(nomeCliente);
          writeln('Fila (1 - Mono, 2 - Colorida, 3 - Plotter): ');
          readln(opcao);
        end;
      5:
        begin
          writeln('Fila (1 - Mono, 2 - Colorida, 3 - Plotter): ');
          readln(opcao);
        end;
    end;
  until opcao = 0;
end.
