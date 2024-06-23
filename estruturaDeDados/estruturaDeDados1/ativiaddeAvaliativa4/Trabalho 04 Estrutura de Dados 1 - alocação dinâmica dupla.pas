program dequeAlocacaoDinamicaDupla; 

// Alunos: Rafael Munarin, Daniel Espindola

type
  PNo = ^TNo;  // Definição do ponteiro para o nó
  TNo = record  // Definição do nó
    Dado: Integer;  // Valor armazenado no nó
    Anterior, Proximo: PNo;  // Ponteiros para o nó anterior e próximo
  end;

  TDeque = record  // Definição do deque
    Cabeca, Cauda: PNo; // Ponteiros para a cabeça e cauda do deque
    Tamanho: Integer;   // Tamanho do deque
  end;

// Inicializa o deque
procedure InicializarDeque(var Deque: TDeque);
begin
  Deque.Cabeca := nil;  // Define a cabeça como nula
  Deque.Cauda := nil;  // Define a cauda como nula
  Deque.Tamanho := 0;  // Define o tamanho como zero
end;

// Verifica se o deque está vazio
function EstaVazio(var Deque: TDeque): Boolean;
begin
  EstaVazio := Deque.Tamanho = 0;  // Retorna verdadeiro se o tamanho for zero
end;

// Adiciona um valor na frente do deque
procedure AdicionarInicio(var Deque: TDeque; Valor: Integer);
var
  NovoNo: PNo;  // Declaração de um novo nó
begin
  New(NovoNo);  // Aloca memória para o novo nó
  NovoNo^.Dado := Valor;  // Define o valor do novo nó
  NovoNo^.Anterior := nil;  // Define o ponteiro anterior do novo nó como nulo
  NovoNo^.Proximo := Deque.Cabeca;  // Define o ponteiro próximo do novo nó como a cabeça atual do deque

  if EstaVazio(Deque) then  // Se o deque estiver vazio
    Deque.Cauda := NovoNo  // A cauda também aponta para o novo nó
  else
    Deque.Cabeca^.Anterior := NovoNo;  // O nó anterior da cabeça atual aponta para o novo nó
  
  Deque.Cabeca := NovoNo;  // A cabeça do deque aponta para o novo nó
  Inc(Deque.Tamanho);  // Incrementa o tamanho do deque
end;

// Adiciona um valor no final do deque
procedure AdicionarFim(var Deque: TDeque; Valor: Integer);
var
  NovoNo: PNo;  // Declaração de um novo nó
begin
  New(NovoNo);  // Aloca memória para o novo nó
  NovoNo^.Dado := Valor;  // Define o valor do novo nó
  NovoNo^.Proximo := nil;  // Define o ponteiro próximo do novo nó como nulo
  NovoNo^.Anterior := Deque.Cauda;  // Define o ponteiro anterior do novo nó como a cauda atual do deque

  if EstaVazio(Deque) then  // Se o deque estiver vazio
    Deque.Cabeca := NovoNo  // A cabeça também aponta para o novo nó
  else
    Deque.Cauda^.Proximo := NovoNo;  // O nó próximo da cauda atual aponta para o novo nó
  
  Deque.Cauda := NovoNo;  // A cauda do deque aponta para o novo nó
  Inc(Deque.Tamanho);  // Incrementa o tamanho do deque
end;

// Remove um valor da frente do deque
function RemoverInicio(var Deque: TDeque): Integer;
var
  NoTemporario: PNo;  // Declaração de um nó temporário
  Valor: Integer;  // Declaração de uma variável para armazenar o valor removido
begin
  if EstaVazio(Deque) then  // Se o deque estiver vazio
  begin
    writeln('Deque está vazio');  // Imprime mensagem de erro
    RemoverInicio := -1;  // Retorna -1 indicando erro
    Exit;  // Sai da função
  end;

  NoTemporario := Deque.Cabeca;  // Aponta o nó temporário para a cabeça do deque
  Valor := NoTemporario^.Dado;  // Armazena o valor da cabeça
  
  Deque.Cabeca := Deque.Cabeca^.Proximo;  // A cabeça aponta para o próximo nó
  
  if Deque.Cabeca = nil then  // Se a nova cabeça for nula
    Deque.Cauda := nil  // A cauda também se torna nula
  else
    Deque.Cabeca^.Anterior := nil;  // O nó anterior da nova cabeça é definido como nulo
  
  Dispose(NoTemporario);  // Libera a memória do nó temporário
  Dec(Deque.Tamanho);  // Decrementa o tamanho do deque
  
  RemoverInicio := Valor;  // Retorna o valor removido
end;

// Remove um valor do final do deque
function RemoverFim(var Deque: TDeque): Integer;
var
  NoTemporario: PNo;  // Declaração de um nó temporário
  Valor: Integer;  // Declaração de uma variável para armazenar o valor removido
begin
  if EstaVazio(Deque) then  // Se o deque estiver vazio
  begin
    writeln('Deque está vazio');  // Imprime mensagem de erro
    RemoverFim := -1;  // Retorna -1 indicando erro
    Exit;  // Sai da função
  end;

  NoTemporario := Deque.Cauda;  // Aponta o nó temporário para a cauda do deque
  Valor := NoTemporario^.Dado;  // Armazena o valor da cauda
  
  Deque.Cauda := Deque.Cauda^.Anterior;  // A cauda aponta para o nó anterior
  
  if Deque.Cauda = nil then  // Se a nova cauda for nula
    Deque.Cabeca := nil  // A cabeça também se torna nula
  else
    Deque.Cauda^.Proximo := nil;  // O nó próximo da nova cauda é definido como nulo
  
  Dispose(NoTemporario);  // Libera a memória do nó temporário
  Dec(Deque.Tamanho);  // Decrementa o tamanho do deque
  
  RemoverFim := Valor;  // Retorna o valor removido
end;

// Retorna o valor da frente do deque sem removê-lo
function ObterInicio(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then  // Se o deque estiver vazio
  begin
    writeln('Deque está vazio');  // Imprime mensagem de erro
    ObterInicio := -1;  // Retorna -1 indicando erro
    Exit;  // Sai da função
  end;
  ObterInicio := Deque.Cabeca^.Dado;  // Retorna o valor da cabeça do deque
end;

// Retorna o valor do final do deque sem removê-lo
function ObterFim(var Deque: TDeque): Integer;
begin
  if EstaVazio(Deque) then  // Se o deque estiver vazio
  begin
    writeln('Deque está vazio');  // Imprime mensagem de erro
    ObterFim := -1;  // Retorna -1 indicando erro
    Exit;  // Sai da função
  end;
  ObterFim := Deque.Cauda^.Dado;  // Retorna o valor da cauda do deque
end;

// Retorna o tamanho do deque
function ObterTamanho(var Deque: TDeque): Integer;
begin
  ObterTamanho := Deque.Tamanho;  // Retorna o tamanho do deque
end;

// Verifica se o deque está cheio (não aplicável com alocação dinâmica)
function EstaCheio: Boolean;
begin
  EstaCheio := False;  // Sempre retorna falso
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
      8: writeln('Saindo...');  // Mensagem de saída
      else
        writeln('Opção inválida!');  // Mensagem para opção inválida
    end;
  until Opcao = 8;  // Repete até que a opção seja 8 (sair)
end.
