program dequeAlocacaoDinamicaDupla; 

// Alunos: Rafael Munarin, Daniel Espindola

type
  PNo = ^TNo;  // Defini��o do ponteiro para o n�
  TNo = record  // Defini��o do n�
    Dado: Integer;  // Valor armazenado no n�
    Anterior, Proximo: PNo;  // Ponteiros para o n� anterior e pr�ximo
  end;

  TDeque = record  // Defini��o do deque
    Cabeca, Cauda: PNo; // Ponteiros para a cabe�a e cauda do deque
    Tamanho: Integer;   // Tamanho do deque
  end;

// Inicializa o deque
procedure InicializarDeque(var Deque: TDeque);
begin
  Deque.Cabeca := nil;  // Define a cabe�a como nula
  Deque.Cauda := nil;  // Define a cauda como nula
  Deque.Tamanho := 0;  // Define o tamanho como zero
end;

// Verifica se o deque est� vazio
function EstaVazio(var Deque: TDeque): Boolean;
begin
  EstaVazio := Deque.Tamanho = 0;  // Retorna verdadeiro se o tamanho for zero
end;

// Adiciona um valor na frente do deque
procedure AdicionarInicio(var Deque: TDeque; Valor: Integer);
var
  NovoNo: PNo;  // Declara��o de um novo n�
begin
  New(NovoNo);  // Aloca mem�ria para o novo n�
  NovoNo^.Dado := Valor;  // Define o valor do novo n�
  NovoNo^.Anterior := nil;  // Define o ponteiro anterior do novo n� como nulo
  NovoNo^.Proximo := Deque.Cabeca;  // Define o ponteiro pr�ximo do novo n� como a cabe�a atual do deque

  if EstaVazio(Deque) then  // Se o deque estiver vazio
    Deque.Cauda := NovoNo  // A cauda tamb�m aponta para o novo n�
  else
    Deque.Cabeca^.Anterior := NovoNo;  // O n� anterior da cabe�a atual aponta para o novo n�
  
  Deque.Cabeca := NovoNo;  // A cabe�a do deque aponta para o novo n�
  Inc(Deque.Tamanho);  // Incrementa o tamanho do deque
end;

// Adiciona um valor no final do deque
procedure AdicionarFim(var Deque: TDeque; Valor: Integer);
var
  NovoNo: PNo;  // Declara��o de um novo n�
begin
  New(NovoNo);  // Aloca mem�ria para o novo n�
  NovoNo^.Dado := Valor;  // Define o valor do novo n�
  NovoNo^.Proximo := nil;  // Define o ponteiro pr�ximo do novo n� como nulo
  NovoNo^.Anterior := Deque.Cauda;  // Define o ponteiro anterior do novo n� como a cauda atual do deque

  if EstaVazio(Deque) then  // Se o deque estiver vazio
    Deque.Cabeca := NovoNo  // A cabe�a tamb�m aponta para o novo n�
  else
    Deque.Cauda^.Proximo := NovoNo;  // O n� pr�ximo da cauda atual aponta para o novo n�
  
  Deque.Cauda := NovoNo;  // A cauda do deque aponta para o novo n�
  Inc(Deque.Tamanho);  // Incrementa o tamanho do deque
end;

// Remove um valor da frente do deque
function RemoverInicio(var Deque: TDeque): Integer;
var
  NoTemporario: PNo;  // Declara��o de um n� tempor�rio
  Valor: Integer;  // Declara��o de uma vari�vel para armazenar o valor removido
begin
  if EstaVazio(Deque) then  // Se o deque estiver vazio
  begin
    writeln('Deque est� vazio');  // Imprime mensagem de erro
    RemoverInicio := -1;  // Retorna -1 indicando erro
    Exit;  // Sai da fun��o
  end;

  NoTemporario := Deque.Cabeca;  // Aponta o n� tempor�rio para a cabe�a do deque
  Valor := NoTemporario^.Dado;  // Armazena o valor da cabe�a
  
  Deque.Cabeca := Deque.Cabeca^.Proximo;  // A cabe�a aponta para o pr�ximo n�
  
  if Deque.Cabeca = nil then  // Se a nova cabe�a for nula
    Deque.Cauda := nil  // A cauda tamb�m se torna nula
  else
    Deque.Cabeca^.Anterior := nil;  // O n� anterior da nova cabe�a � definido como nulo
  
  Dispose(NoTemporario);  // Libera a mem�ria do n� tempor�rio
  Dec(Deque.Tamanho);  // Decrementa o tamanho do deque
  
  RemoverInicio := Valor;  // Retorna o valor removido
end;

// Remove um valor do final do deque
function RemoverFim(var Deque: TDeque): Integer;
var
  NoTemporario: PNo;  // Declara��o de um n� tempor�rio
  Valor: Integer;  // Declara��o de uma vari�vel para armazenar o valor removido
begin
  if EstaVazio(Deque) then  // Se o deque estiver vazio
  begin
    writeln('Deque est� vazio');  // Imprime mensagem de erro
    RemoverFim := -1;  // Retorna -1 indicando erro
    Exit;  // Sai da fun��o
  end;

  NoTemporario := Deque.Cauda;  // Aponta o n� tempor�rio para a cauda do deque
  Valor := NoTemporario^.Dado;  // Armazena o valor da cauda
  
  Deque.Cauda := Deque.Cauda^.Anterior;  // A cauda aponta para o n� anterior
  
  if Deque.Cauda = nil then  // Se a nova cauda for nula
    Deque.Cabeca := nil  // A cabe�a tamb�m se torna nula
  else
    Deque.Cauda^.Proximo := nil;  // O n� pr�ximo da nova cauda � definido como nulo
  
  Dispose(NoTemporario);  // Libera a mem�ria do n� tempor�rio
  Dec(Deque.Tamanho);  // Decrementa o tamanho do deque
  
  RemoverFim := Valor;  // Retorna o valor removido
end;

// Retorna o valor da frente do deque sem remov�-lo
function ObterInicio(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then  // Se o deque estiver vazio
  begin
    writeln('Deque est� vazio');  // Imprime mensagem de erro
    ObterInicio := -1;  // Retorna -1 indicando erro
    Exit;  // Sai da fun��o
  end;
  ObterInicio := Deque.Cabeca^.Dado;  // Retorna o valor da cabe�a do deque
end;

// Retorna o valor do final do deque sem remov�-lo
function ObterFim(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then  // Se o deque estiver vazio
  begin
    writeln('Deque est� vazio');  // Imprime mensagem de erro
    ObterFim := -1;  // Retorna -1 indicando erro
    Exit;  // Sai da fun��o
  end;
  ObterFim := Deque.Cauda^.Dado;  // Retorna o valor da cauda do deque
end;

// Retorna o tamanho do deque
function ObterTamanho(var Deque: TDeque): Integer;
begin
  ObterTamanho := Deque.Tamanho;  // Retorna o tamanho do deque
end;

// Verifica se o deque est� cheio (n�o aplic�vel com aloca��o din�mica)
function EstaCheio: Boolean;
begin
  EstaCheio := False;  // Sempre retorna falso
end;

var
  Deque: TDeque;  // Declara��o do deque
  Opcao, Valor: Integer;  // Declara��o de vari�veis para o menu e valor
begin
  // Inicializa o deque
  InicializarDeque(Deque);  // Chama a fun��o para inicializar o deque

  repeat
    writeln('Menu:');  // Exibe o menu de op��es
    writeln('1. Adicionar no in�cio');  // Op��o para adicionar no in�cio
    writeln('2. Adicionar no fim');  // Op��o para adicionar no fim
    writeln('3. Remover do in�cio');  // Op��o para remover do in�cio
    writeln('4. Remover do fim');  // Op��o para remover do fim
    writeln('5. Obter in�cio');  // Op��o para obter o valor do in�cio
    writeln('6. Obter fim');  // Op��o para obter o valor do fim
    writeln('7. Obter tamanho');  // Op��o para obter o tamanho do deque
    writeln('8. Sair');  // Op��o para sair
    write('Escolha uma op��o: ');  // Pede para o usu�rio escolher uma op��o
    readln(Opcao);  // L� a op��o escolhida

    case Opcao of
      1: begin
           write('Digite o valor para adicionar no in�cio: ');  // Pede o valor para adicionar no in�cio
           readln(Valor);  // L� o valor
           AdicionarInicio(Deque, Valor);  // Chama a fun��o para adicionar no in�cio
         end;
      2: begin
           write('Digite o valor para adicionar no fim: ');  // Pede o valor para adicionar no fim
           readln(Valor);  // L� o valor
           AdicionarFim(Deque, Valor);  // Chama a fun��o para adicionar no fim
         end;
      3: begin
           Valor := RemoverInicio(Deque);  // Chama a fun��o para remover do in�cio e armazena o valor removido
           if Valor <> -1 then  // Se o valor for diferente de -1 (remo��o bem-sucedida)
             writeln('Valor removido do in�cio: ', Valor);  // Exibe o valor removido
         end;
      4: begin
           Valor := RemoverFim(Deque);  // Chama a fun��o para remover do fim e armazena o valor removido
           if Valor <> -1 then  // Se o valor for diferente de -1 (remo��o bem-sucedida)
             writeln('Valor removido do fim: ', Valor);  // Exibe o valor removido
         end;
      5: begin
           Valor := ObterInicio(Deque);  // Chama a fun��o para obter o valor do in�cio
           if Valor <> -1 then  // Se o valor for diferente de -1
             writeln('Valor no in�cio: ', Valor);  // Exibe o valor no in�cio
         end;
      6: begin
           Valor := ObterFim(Deque);  // Chama a fun��o para obter o valor do fim
           if Valor <> -1 then  // Se o valor for diferente de -1
             writeln('Valor no fim: ', Valor);  // Exibe o valor no fim
         end;
      7: writeln('Tamanho do deque: ', ObterTamanho(Deque));  // Exibe o tamanho do deque
      8: writeln('Saindo...');  // Mensagem de sa�da
      else
        writeln('Op��o inv�lida!');  // Mensagem para op��o inv�lida
    end;
  until Opcao = 8;  // Repete at� que a op��o seja 8 (sair)
end.
