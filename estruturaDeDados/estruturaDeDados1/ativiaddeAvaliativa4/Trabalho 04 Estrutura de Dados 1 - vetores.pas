program dequeVetor;

// Alunos: Rafael Munarin, Daniel Espindola

const
  MAX = 6; // Tamanho máximo do deque

type
  TDeque = record
    Dados: array[1..MAX] of Integer; // Vetor para armazenar os dados
    Inicio, Fim, Tamanho: Integer;   // Índices do início e fim, e tamanho atual do deque
  end;

// Inicializa o deque
procedure InicializarDeque(var Deque: TDeque);
begin
  Deque.Inicio := 1;  // Define o índice inicial
  Deque.Fim := 0;  // Define o índice final
  Deque.Tamanho := 0;  // Define o tamanho inicial
end;

// Verifica se o deque está vazio
function EstaVazio(var Deque: TDeque): Boolean;
begin
  EstaVazio := Deque.Tamanho = 0;  // Retorna verdadeiro se o tamanho for zero
end;

// Verifica se o deque está cheio
function EstaCheio(var Deque: TDeque): Boolean;
begin
  EstaCheio := Deque.Tamanho = MAX;  // Retorna verdadeiro se o tamanho for igual ao máximo
end;

// Adiciona um valor na frente do deque
procedure AdicionarInicio(var Deque: TDeque; Valor: Integer);
begin
  if EstaCheio(Deque) then  // Verifica se o deque está cheio
  begin
    writeln('Deque está cheio');  // Informa que o deque está cheio
    Exit;  // Sai do procedimento
  end;
  
  if EstaVazio(Deque) then
    Deque.Fim := Deque.Inicio  // Se o deque estiver vazio, define o índice final igual ao inicial
  else
    Deque.Inicio := (Deque.Inicio - 2 + MAX) mod MAX + 1;  // Calcula o novo índice inicial

  Deque.Dados[Deque.Inicio] := Valor;  // Adiciona o valor no início
  Inc(Deque.Tamanho);  // Incrementa o tamanho do deque
end;

// Adiciona um valor no final do deque
procedure AdicionarFim(var Deque: TDeque; Valor: Integer);
begin
  if EstaCheio(Deque) then  // Verifica se o deque está cheio
  begin
    writeln('Deque está cheio');  // Informa que o deque está cheio
    Exit;  // Sai do procedimento
  end;

  if EstaVazio(Deque) then
    Deque.Inicio := Deque.Fim  // Se o deque estiver vazio, define o índice inicial igual ao final
  else
    Deque.Fim := (Deque.Fim mod MAX) + 1;  // Calcula o novo índice final

  Deque.Dados[Deque.Fim] := Valor;  // Adiciona o valor no final
  Inc(Deque.Tamanho);  // Incrementa o tamanho do deque
end;

// Remove um valor da frente do deque
function RemoverInicio(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then  // Verifica se o deque está vazio
  begin
    writeln('Deque está vazio');  // Informa que o deque está vazio
    RemoverInicio := -1;  // Retorna -1 para indicar erro
    Exit;  // Sai do procedimento
  end;

  RemoverInicio := Deque.Dados[Deque.Inicio];  // Armazena o valor removido
  Deque.Inicio := (Deque.Inicio mod MAX) + 1;  // Calcula o novo índice inicial
  Dec(Deque.Tamanho);  // Decrementa o tamanho do deque
end;

// Remove um valor do final do deque
function RemoverFim(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then  // Verifica se o deque está vazio
  begin
    writeln('Deque está vazio');  // Informa que o deque está vazio
    RemoverFim := -1;  // Retorna -1 para indicar erro
    Exit;  // Sai do procedimento
  end;

  RemoverFim := Deque.Dados[Deque.Fim];  // Armazena o valor removido
  Deque.Fim := (Deque.Fim - 2 + MAX) mod MAX + 1;  // Calcula o novo índice final
  Dec(Deque.Tamanho);  // Decrementa o tamanho do deque
end;

// Retorna o valor da frente do deque sem removê-lo
function ObterInicio(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then  // Verifica se o deque está vazio
  begin
    writeln('Deque está vazio');  // Informa que o deque está vazio
    ObterInicio := -1;  // Retorna -1 para indicar erro
    Exit;  // Sai do procedimento
  end;
  ObterInicio := Deque.Dados[Deque.Inicio];  // Retorna o valor do início
end;

// Retorna o valor do final do deque sem removê-lo
function ObterFim(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then  // Verifica se o deque está vazio
  begin
    writeln('Deque está vazio');  // Informa que o deque está vazio
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
  Deque: TDeque;  // Declaração do deque
  Opcao, Valor: Integer;  // Declaração de variáveis para o menu e valor
begin
  // Inicializa o deque
  InicializarDeque(Deque);  // Chama a função para inicializar o deque

  repeat
    writeln('Menu:');  // Exibe o menu de opções
    writeln('1. Adicionar no início');  // Opção para adicionar no início
    writeln('2. Adicionar no fim');  // Opção para adicionar no fim
    writeln('3. Remover do início');  // Opção para remover do início
    writeln('4. Remover do fim');  // Opção para remover do fim
    writeln('5. Obter início');  // Opção para obter o valor do início
    writeln('6. Obter fim');  // Opção para obter o valor do fim
    writeln('7. Obter tamanho');  // Opção para obter o tamanho do deque
    writeln('8. Sair');  // Opção para sair
    write('Escolha uma opção: ');  // Pede para o usuário escolher uma opção
    readln(Opcao);  // Lê a opção escolhida

    case Opcao of
      1: begin
           write('Digite o valor para adicionar no início: ');  // Pede o valor para adicionar no início
           readln(Valor);  // Lê o valor
           AdicionarInicio(Deque, Valor);  // Chama a função para adicionar no início
         end;
      2: begin
           write('Digite o valor para adicionar no fim: ');  // Pede o valor para adicionar no fim
           readln(Valor);  // Lê o valor
           AdicionarFim(Deque, Valor);  // Chama a função para adicionar no fim
         end;
      3: begin
           Valor := RemoverInicio(Deque);  // Chama a função para remover do início e armazena o valor removido
           if Valor <> -1 then  // Se o valor for diferente de -1 (remoção bem-sucedida)
             writeln('Valor removido do início: ', Valor);  // Exibe o valor removido
         end;
      4: begin
           Valor := RemoverFim(Deque);  // Chama a função para remover do fim e armazena o valor removido
           if Valor <> -1 then  // Se o valor for diferente de -1 (remoção bem-sucedida)
             writeln('Valor removido do fim: ', Valor);  // Exibe o valor removido
         end;
      5: begin
           Valor := ObterInicio(Deque);  // Chama a função para obter o valor do início
           if Valor <> -1 then  // Se o valor for diferente de -1
             writeln('Valor no início: ', Valor);  // Exibe o valor no início
         end;
      6: begin
           Valor := ObterFim(Deque);  // Chama a função para obter o valor do fim
           if Valor <> -1 then  // Se o valor for diferente de -1
             writeln('Valor no fim: ', Valor);  // Exibe o valor no fim
         end;
      7: writeln('Tamanho do deque: ', ObterTamanho(Deque));  // Exibe o tamanho do deque
      8: writeln('VLW FLW');  // Mensagem de saída
      else
        writeln('Opção inválida!');  // Mensagem de erro para opção inválida
    end;
  until Opcao = 8;  // Repete o loop até que a opção escolhida seja 8 (sair)
end.
