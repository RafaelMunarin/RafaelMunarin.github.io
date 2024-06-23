program DequeVetor;

// Alunos: Rafael Munarin, Daniel Espindola

const
  MAX = 6; // Tamanho m�ximo do deque

type
  TDeque = record
    Dados: array[1..MAX] of Integer; // Vetor para armazenar os dados
    Inicio, Fim, Tamanho: Integer;   // �ndices do in�cio e fim, e tamanho atual do deque
  end;

// Inicializa o deque
procedure InicializarDeque(var Deque: TDeque);
begin
  Deque.Inicio := 1;
  Deque.Fim := 0;
  Deque.Tamanho := 0;
end;

// Verifica se o deque est� vazio
function EstaVazio(var Deque: TDeque): Boolean;
begin
  EstaVazio := Deque.Tamanho = 0;
end;

// Verifica se o deque est� cheio
function EstaCheio(var Deque: TDeque): Boolean;
begin
  EstaCheio := Deque.Tamanho = MAX;
end;

// Adiciona um valor na frente do deque
procedure AdicionarInicio(var Deque: TDeque; Valor: Integer);
begin
  if EstaCheio(Deque) then
  begin
    writeln('Deque est� cheio');
    Exit;
  end;
  
  if EstaVazio(Deque) then
    Deque.Fim := Deque.Inicio
  else
    Deque.Inicio := (Deque.Inicio - 2 + MAX) mod MAX + 1;

  Deque.Dados[Deque.Inicio] := Valor;
  Inc(Deque.Tamanho);
end;

// Adiciona um valor no final do deque
procedure AdicionarFim(var Deque: TDeque; Valor: Integer);
begin
  if EstaCheio(Deque) then
  begin
    writeln('Deque est� cheio');
    Exit;
  end;

  if EstaVazio(Deque) then
    Deque.Inicio := Deque.Fim
  else
    Deque.Fim := (Deque.Fim mod MAX) + 1;

  Deque.Dados[Deque.Fim] := Valor;
  Inc(Deque.Tamanho);
end;

// Remove um valor da frente do deque
function RemoverInicio(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then
  begin
    writeln('Deque est� vazio');
    RemoverInicio := -1;
    Exit;
  end;

  RemoverInicio := Deque.Dados[Deque.Inicio];
  Deque.Inicio := (Deque.Inicio mod MAX) + 1;
  Dec(Deque.Tamanho);
end;

// Remove um valor do final do deque
function RemoverFim(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then
  begin
    writeln('Deque est� vazio');
    RemoverFim := -1;
    Exit;
  end;

  RemoverFim := Deque.Dados[Deque.Fim];
  Deque.Fim := (Deque.Fim - 2 + MAX) mod MAX + 1;
  Dec(Deque.Tamanho);
end;

// Retorna o valor da frente do deque sem remov�-lo
function ObterInicio(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then
  begin
    writeln('Deque est� vazio');
    ObterInicio := -1;
    Exit;
  end;
  ObterInicio := Deque.Dados[Deque.Inicio];
end;

// Retorna o valor do final do deque sem remov�-lo
function ObterFim(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then
  begin
    writeln('Deque est� vazio');
    ObterFim := -1;
    Exit;
  end;
  ObterFim := Deque.Dados[Deque.Fim];
end;

// Retorna o tamanho do deque
function ObterTamanho(var Deque: TDeque): Integer;
begin
  ObterTamanho := Deque.Tamanho;
end;

var
  Deque: TDeque;
  Opcao, Valor: Integer;
begin
  // Inicializa o deque
  InicializarDeque(Deque);

  repeat
    writeln('Menu:');
    writeln('1. Adicionar no in�cio');
    writeln('2. Adicionar no fim');
    writeln('3. Remover do in�cio');
    writeln('4. Remover do fim');
    writeln('5. Obter in�cio');
    writeln('6. Obter fim');
    writeln('7. Obter tamanho');
    writeln('8. Sair');
    write('Escolha uma op��o: ');
    readln(Opcao);

    case Opcao of
      1: begin
           write('Digite o valor para adicionar no in�cio: ');
           readln(Valor);
           AdicionarInicio(Deque, Valor);
         end;
      2: begin
           write('Digite o valor para adicionar no fim: ');
           readln(Valor);
           AdicionarFim(Deque, Valor);
         end;
      3: begin
           Valor := RemoverInicio(Deque);
           if Valor <> -1 then
             writeln('Valor removido do in�cio: ', Valor);
         end;
      4: begin
           Valor := RemoverFim(Deque);
           if Valor <> -1 then
             writeln('Valor removido do fim: ', Valor);
         end;
      5: begin
           Valor := ObterInicio(Deque);
           if Valor <> -1 then
             writeln('Valor no in�cio: ', Valor);
         end;
      6: begin
           Valor := ObterFim(Deque);
           if Valor <> -1 then
             writeln('Valor no fim: ', Valor);
         end;
      7: writeln('Tamanho do deque: ', ObterTamanho(Deque));
      8: writeln('Saindo...');
      else
        writeln('Op��o inv�lida!');
    end;
  until Opcao = 8;
end.
