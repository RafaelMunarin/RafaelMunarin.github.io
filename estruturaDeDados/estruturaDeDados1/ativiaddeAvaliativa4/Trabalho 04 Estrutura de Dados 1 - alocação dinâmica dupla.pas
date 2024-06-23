program DequeDinamico;

// Alunos: Rafael Munarin, Daniel Espindola

type
  PNo = ^TNo;  // Defini��o do ponteiro para o n�
  TNo = record
    Dado: Integer;
    Anterior, Proximo: PNo;
  end;

  TDeque = record
    Cabeca, Cauda: PNo; // Ponteiros para a cabe�a e cauda do deque
    Tamanho: Integer;   // Tamanho do deque
  end;

// Inicializa o deque
procedure InicializarDeque(var Deque: TDeque);
begin
  Deque.Cabeca := nil;
  Deque.Cauda := nil;
  Deque.Tamanho := 0;
end;

// Verifica se o deque est� vazio
function EstaVazio(var Deque: TDeque): Boolean;
begin
  EstaVazio := Deque.Tamanho = 0;
end;

// Adiciona um valor na frente do deque
procedure AdicionarInicio(var Deque: TDeque; Valor: Integer);
var
  NovoNo: PNo;
begin
  New(NovoNo);
  NovoNo^.Dado := Valor;
  NovoNo^.Anterior := nil;
  NovoNo^.Proximo := Deque.Cabeca;

  if EstaVazio(Deque) then
    Deque.Cauda := NovoNo
  else
    Deque.Cabeca^.Anterior := NovoNo;
  
  Deque.Cabeca := NovoNo;
  Inc(Deque.Tamanho);
end;

// Adiciona um valor no final do deque
procedure AdicionarFim(var Deque: TDeque; Valor: Integer);
var
  NovoNo: PNo;
begin
  New(NovoNo);
  NovoNo^.Dado := Valor;
  NovoNo^.Proximo := nil;
  NovoNo^.Anterior := Deque.Cauda;

  if EstaVazio(Deque) then
    Deque.Cabeca := NovoNo
  else
    Deque.Cauda^.Proximo := NovoNo;
  
  Deque.Cauda := NovoNo;
  Inc(Deque.Tamanho);
end;

// Remove um valor da frente do deque
function RemoverInicio(var Deque: TDeque): Integer;
var
  NoTemporario: PNo;
  Valor: Integer;
begin
  if EstaVazio(Deque) then
  begin
    writeln('Deque est� vazio');
    RemoverInicio := -1;
    Exit;
  end;

  NoTemporario := Deque.Cabeca;
  Valor := NoTemporario^.Dado;
  
  Deque.Cabeca := Deque.Cabeca^.Proximo;
  
  if Deque.Cabeca = nil then
    Deque.Cauda := nil
  else
    Deque.Cabeca^.Anterior := nil;
  
  Dispose(NoTemporario);
  Dec(Deque.Tamanho);
  
  RemoverInicio := Valor;
end;

// Remove um valor do final do deque
function RemoverFim(var Deque: TDeque): Integer;
var
  NoTemporario: PNo;
  Valor: Integer;
begin
  if EstaVazio(Deque) then
  begin
    writeln('Deque est� vazio');
    RemoverFim := -1;
    Exit;
  end;

  NoTemporario := Deque.Cauda;
  Valor := NoTemporario^.Dado;
  
  Deque.Cauda := Deque.Cauda^.Anterior;
  
  if Deque.Cauda = nil then
    Deque.Cabeca := nil
  else
    Deque.Cauda^.Proximo := nil;
  
  Dispose(NoTemporario);
  Dec(Deque.Tamanho);
  
  RemoverFim := Valor;
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
  ObterInicio := Deque.Cabeca^.Dado;
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
  ObterFim := Deque.Cauda^.Dado;
end;

// Retorna o tamanho do deque
function ObterTamanho(var Deque: TDeque): Integer;
begin
  ObterTamanho := Deque.Tamanho;
end;

// Verifica se o deque est� cheio (n�o aplic�vel com aloca��o din�mica)
function EstaCheio: Boolean;
begin
  EstaCheio := False;
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
