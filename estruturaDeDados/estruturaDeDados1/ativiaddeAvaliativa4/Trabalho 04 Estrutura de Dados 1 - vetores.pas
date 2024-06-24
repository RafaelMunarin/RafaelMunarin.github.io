program dequeVetor;

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
  Deque.Inicio := 1;  // Define o �ndice inicial
  Deque.Fim := 0;  // Define o �ndice final
  Deque.Tamanho := 0;  // Define o tamanho inicial
end;

// Verifica se o deque est� vazio
function EstaVazio(var Deque: TDeque): Boolean;
begin
  EstaVazio := Deque.Tamanho = 0;  // Retorna verdadeiro se o tamanho for zero
end;

// Verifica se o deque est� cheio
function EstaCheio(var Deque: TDeque): Boolean;
begin
  EstaCheio := Deque.Tamanho = MAX;  // Retorna verdadeiro se o tamanho for igual ao m�ximo
end;

// Adiciona um valor na frente do deque
procedure AdicionarInicio(var Deque: TDeque; Valor: Integer);
begin
  if EstaCheio(Deque) then  // Verifica se o deque est� cheio
  begin
    writeln('Deque est� cheio');  // Informa que o deque est� cheio
    Exit;  // Sai do procedimento
  end;
  
  if EstaVazio(Deque) then
    Deque.Fim := Deque.Inicio  // Se o deque estiver vazio, define o �ndice final igual ao inicial
  else
    Deque.Inicio := (Deque.Inicio - 2 + MAX) mod MAX + 1;  // Calcula o novo �ndice inicial

  Deque.Dados[Deque.Inicio] := Valor;  // Adiciona o valor no in�cio
  Inc(Deque.Tamanho);  // Incrementa o tamanho do deque
end;

// Adiciona um valor no final do deque
procedure AdicionarFim(var Deque: TDeque; Valor: Integer);
begin
  if EstaCheio(Deque) then  // Verifica se o deque est� cheio
  begin
    writeln('Deque est� cheio');  // Informa que o deque est� cheio
    Exit;  // Sai do procedimento
  end;

  if EstaVazio(Deque) then
    Deque.Inicio := Deque.Fim  // Se o deque estiver vazio, define o �ndice inicial igual ao final
  else
    Deque.Fim := (Deque.Fim mod MAX) + 1;  // Calcula o novo �ndice final

  Deque.Dados[Deque.Fim] := Valor;  // Adiciona o valor no final
  Inc(Deque.Tamanho);  // Incrementa o tamanho do deque
end;

// Remove um valor da frente do deque
function RemoverInicio(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then  // Verifica se o deque est� vazio
  begin
    writeln('Deque est� vazio');  // Informa que o deque est� vazio
    RemoverInicio := -1;  // Retorna -1 para indicar erro
    Exit;  // Sai do procedimento
  end;

  RemoverInicio := Deque.Dados[Deque.Inicio];  // Armazena o valor removido
  Deque.Inicio := (Deque.Inicio mod MAX) + 1;  // Calcula o novo �ndice inicial
  Dec(Deque.Tamanho);  // Decrementa o tamanho do deque
end;

// Remove um valor do final do deque
function RemoverFim(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then  // Verifica se o deque est� vazio
  begin
    writeln('Deque est� vazio');  // Informa que o deque est� vazio
    RemoverFim := -1;  // Retorna -1 para indicar erro
    Exit;  // Sai do procedimento
  end;

  RemoverFim := Deque.Dados[Deque.Fim];  // Armazena o valor removido
  Deque.Fim := (Deque.Fim - 2 + MAX) mod MAX + 1;  // Calcula o novo �ndice final
  Dec(Deque.Tamanho);  // Decrementa o tamanho do deque
end;

// Retorna o valor da frente do deque sem remov�-lo
function ObterInicio(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then  // Verifica se o deque est� vazio
  begin
    writeln('Deque est� vazio');  // Informa que o deque est� vazio
    ObterInicio := -1;  // Retorna -1 para indicar erro
    Exit;  // Sai do procedimento
  end;
  ObterInicio := Deque.Dados[Deque.Inicio];  // Retorna o valor do in�cio
end;

// Retorna o valor do final do deque sem remov�-lo
function ObterFim(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then  // Verifica se o deque est� vazio
  begin
    writeln('Deque est� vazio');  // Informa que o deque est� vazio
    ObterFim := -1;  // Retorna -1 para indicar erro
    Exit;  // Sai do procedimento
  end;
  ObterFim := Deque.Dados[Deque.Fim];  // Retorna o valor do final
end;

// Retorna o tamanho do deque
function ObterTamanho(var Deque: TDeque): Integer;
begin
  ObterTamanho := Deque.Tamanho;  // Retorna o tamanho do deque
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
      8: writeln('VLW FLW');  // Mensagem de sa�da
      else
        writeln('Op��o inv�lida!');  // Mensagem de erro para op��o inv�lida
    end;
  until Opcao = 8;  // Repete o loop at� que a op��o escolhida seja 8 (sair)
end.
