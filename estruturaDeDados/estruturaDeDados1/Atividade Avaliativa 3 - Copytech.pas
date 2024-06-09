program GerenciadorFilaImpressao;

// Alunos: Daniel Espindola, Rafael Munarin

type
// Definição de um ponteiro para o tipo de registro TAuxiliar
PAuxiliar = ^TAuxiliar;

// Definição do registro TAuxiliar que representa cada cliente na fila
TAuxiliar = record
  nomeCliente: string[50];     // Nome do cliente
  quantidadeCopias: integer;   // Quantidade de cópias solicitadas
  prioritario: boolean;        // Se o cliente é prioritário
  anterior, proximo: PAuxiliar;// Ponteiros para os clientes anterior e próximo na fila
end;

// Definição do registro TFilaImpressao que representa a fila de impressão
TFilaImpressao = record
  inicio, fim: PAuxiliar;      // Ponteiros para o início e o fim da fila
  tamanho: integer;            // Tamanho atual da fila
end;

{ Inicializa a fila, definindo os ponteiros de início e fim como nil e o tamanho como 0 }
procedure InicializarFila(var fila: TFilaImpressao);
begin
  fila.inicio := nil;  // Define o início da fila como nil, indicando que está vazia
  fila.fim := nil;     // Define o fim da fila como nil, indicando que está vazia
  fila.tamanho := 0;   // Define o tamanho da fila como 0
end;

{ Adiciona um novo cliente à fila com seu nome, quantidade de cópias e prioridade }
procedure AdicionarClienteFila(var fila: TFilaImpressao; nomeCliente: string; quantidadeCopias: integer; prioritario: boolean);
var
novoAuxiliar, temp: PAuxiliar; // Declara ponteiros para os novos e temporários clientes
begin
  New(novoAuxiliar); // Aloca memória para o novo cliente
  novoAuxiliar^.nomeCliente := nomeCliente;     // Define o nome do novo cliente
  novoAuxiliar^.quantidadeCopias := quantidadeCopias; // Define a quantidade de cópias do novo cliente
  novoAuxiliar^.prioritario := prioritario;     // Define se o cliente é prioritário
  novoAuxiliar^.proximo := nil;                 // Inicializa o próximo cliente como nil
  
  if fila.fim = nil then // Verifica se a fila está vazia
  begin
    novoAuxiliar^.anterior := nil;  // Define o anterior do novo cliente como nil
    fila.inicio := novoAuxiliar;    // Define o início da fila como o novo cliente
    fila.fim := novoAuxiliar;       // Define o fim da fila como o novo cliente
  end
  else // Se a fila não está vazia
  begin
    if prioritario then // Verifica se o cliente é prioritário
    begin
      temp := fila.inicio; // Inicia a variação temp no início da fila
      while (temp <> nil) and (temp^.prioritario) do // Procura a posição correta para inserir o cliente prioritário
      temp := temp^.proximo;
      
      if temp = nil then // Se chegou ao fim da fila sem encontrar clientes não prioritários
      begin
        novoAuxiliar^.anterior := fila.fim; // Coloca o novo cliente no final da fila
        fila.fim^.proximo := novoAuxiliar; // Atualiza o ponteiro do último cliente
        fila.fim := novoAuxiliar;          // Atualiza o fim da fila
      end
      else // Se encontrou a posição para inserir o cliente prioritário
      begin
        novoAuxiliar^.proximo := temp; // O próximo do novo cliente aponta para o cliente atual
        novoAuxiliar^.anterior := temp^.anterior; // O anterior do novo cliente aponta para o anterior do cliente atual
        if temp^.anterior <> nil then
        temp^.anterior^.proximo := novoAuxiliar // Atualiza o ponteiro do anterior do cliente atual para o novo cliente
        else
        fila.inicio := novoAuxiliar; // Se o anterior do cliente atual for nil, o novo cliente é o início da fila
        temp^.anterior := novoAuxiliar; // Atualiza o anterior do cliente atual para o novo cliente
      end;
    end
    else // Se o cliente não é prioritário
    begin
      novoAuxiliar^.anterior := fila.fim; // Coloca o novo cliente no final da fila
      fila.fim^.proximo := novoAuxiliar;  // Atualiza o ponteiro do último cliente
      fila.fim := novoAuxiliar;           // Atualiza o fim da fila
    end;
  end;
  fila.tamanho := fila.tamanho + 1; // Incrementa o tamanho da fila
end;

{ Remove o cliente especificado pelo nome }
procedure RemoverClienteFila(var fila: TFilaImpressao; nomeCliente: string);
var
temp: PAuxiliar; // Declara um ponteiro temporário para percorrer a fila
begin
  temp := fila.inicio; // Inicia a variação temp no início da fila
  
  { Procurar o cliente na fila }
  while (temp <> nil) and (temp^.nomeCliente <> nomeCliente) do
  temp := temp^.proximo; // Percorre a fila até encontrar o cliente com o nome especificado ou chegar ao fim da fila
  
  { Cliente não encontrado }
  if temp = nil then // Se não encontrou o cliente
  begin
    writeln('Cliente não encontrado.'); // Exibe mensagem de erro
    Exit; // Sai do procedimento
  end;
  
  { Ajustar ponteiros e remover o cliente }
  if temp^.anterior <> nil then
  temp^.anterior^.proximo := temp^.proximo // Se o cliente não é o primeiro da fila, atualiza o ponteiro do anterior para o próximo
  else
  fila.inicio := temp^.proximo; // Se o cliente é o primeiro da fila, atualiza o início da fila para o próximo cliente
  
  if temp^.proximo <> nil then
  temp^.proximo^.anterior := temp^.anterior // Se o cliente não é o último da fila, atualiza o ponteiro do próximo para o anterior
  else
  fila.fim := temp^.anterior; // Se o cliente é o último da fila, atualiza o fim da fila para o cliente anterior
  
  Dispose(temp); // Libera a memória alocada para o cliente removido
  fila.tamanho := fila.tamanho - 1; // Reduz o tamanho da fila
end;

{ Atende o próximo cliente na fila, exibindo suas informações e removendo-o da fila }
procedure AtenderProximoCliente(var fila: TFilaImpressao);
var
temp: PAuxiliar; // Declara um ponteiro temporário para percorrer a fila
begin
  if fila.inicio <> nil then // Verifica se a fila não está vazia
  begin
    temp := fila.inicio; // Inicia a variação temp no início da fila
    if temp^.prioritario then // Verifica se o cliente é prioritário
    begin
    writeln('Atendendo cliente prioritário: ', temp^.nomeCliente, ' com ', temp^.quantidadeCopias, ' cópias.');
  end
  else
  begin
  writeln('Atendendo cliente: ', temp^.nomeCliente, ' com ', temp^.quantidadeCopias, ' cópias.');
end;
RemoverClienteFila(fila, temp^.nomeCliente); // Remove o cliente atendido da fila
end
else
begin
  writeln('A fila está vazia.'); // Exibe mensagem se a fila estiver vazia
end;
end;

{ Move o cliente pelo nome para a frente da fila, se não houver outro prioritário }
procedure PriorizarCliente(var fila: TFilaImpressao; nomeCliente: string);
var
temp, atual: PAuxiliar; // Declara ponteiros temporários para percorrer a fila
jaExistePrioritario: boolean; // Declara uma variável para verificar se já existe cliente prioritário
begin
  atual := fila.inicio; // Inicia a variação atual no início da fila
  jaExistePrioritario := False; // Inicializa a variável como falso
  
  { Verifica se já existe um cliente prioritário na fila }
  while (atual <> nil) do
  begin
    if atual^.prioritario then
    begin
      jaExistePrioritario := True; // Define a variável como verdadeiro se encontrar um cliente prioritário
      Break; // Sai do loop
    end;
    atual := atual^.proximo; // Move para o próximo cliente na fila
  end;
  
  if jaExistePrioritario then
  begin
    writeln('Já existe um cliente prioritário na fila.'); // Exibe mensagem se já existir cliente prioritário
    Exit; // Sai do procedimento
  end;
  
  atual := fila.inicio; // Reinicia a variação atual no início da fila
  while (atual <> nil) and (atual^.nomeCliente <> nomeCliente) do
  atual := atual^.proximo; // Percorre a fila até encontrar o cliente com o nome especificado ou chegar ao fim da fila
  if atual <> nil then // Verifica se encontrou o cliente com o nome especificado
  begin
    if atual <> fila.inicio then // Verifica se o cliente não é o primeiro da fila
    begin
      if atual = fila.fim then // Verifica se o cliente é o último da fila
      begin
        fila.fim := atual^.anterior; // Atualiza o fim da fila para o cliente anterior
        fila.fim^.proximo := nil;    // Define o próximo do novo fim como nil
      end
      else
      begin
        atual^.anterior^.proximo := atual^.proximo; // Atualiza o ponteiro do anterior para o próximo
        atual^.proximo^.anterior := atual^.anterior; // Atualiza o ponteiro do próximo para o anterior
      end;
      atual^.anterior := nil;         // Define o anterior do cliente atual como nil
      atual^.proximo := fila.inicio;  // Define o próximo do cliente atual como o início da fila
      fila.inicio^.anterior := atual; // Atualiza o anterior do início da fila para o cliente atual
      fila.inicio := atual;           // Define o início da fila como o cliente atual
    end;
  end;
end;

{ Imprime todos os clientes na fila com suas informações }
procedure ImprimirFila(fila: TFilaImpressao);
var
temp: PAuxiliar; // Declara um ponteiro temporário para percorrer a fila
begin
  temp := fila.inicio; // Inicia a variação temp no início da fila
  while temp <> nil do // Percorre a fila até o final
  begin
    writeln('Nome: ', temp^.nomeCliente, ' | Cópias: ', temp^.quantidadeCopias, ' | Prioritário: ', temp^.prioritario);
    temp := temp^.proximo; // Move para o próximo cliente na fila
  end;
end;

var
filaMono, filaColor, filaPlotter: TFilaImpressao; // Declara as filas para cada tipo de impressora
opcao: integer; // Declara a variável para a opção do usuário
nomeCliente: string; // Declara a variável para o nome do cliente
quantidadeCopias: integer; // Declara a variável para a quantidade de cópias
prioritario: boolean; // Declara a variável para a prioridade
prioridade: integer; // Declara a variável para a prioridade como inteiro (1 para sim, 0 para não)

begin
  // Inicializa as filas para cada tipo de impressora
  InicializarFila(filaMono);
  InicializarFila(filaColor);
  InicializarFila(filaPlotter);
  
  repeat
    // Exibe o menu de opções
    writeln('1. Adicionar cliente à fila');
    writeln('2. Remover cliente da fila');
    writeln('3. Consultar filas');
    writeln('4. Priorizar cliente');
  writeln('5. Atender próximo cliente');
  writeln('0. Sair');
  writeln('Escolha uma opção: ');
  readln(opcao);
  
  // Executa a opção escolhida pelo usuário
  case opcao of
    1:
    begin
      // Adiciona um novo cliente à fila
      writeln('Nome do cliente: ');
      readln(nomeCliente);
      writeln('Quantidade de cópias: ');
      readln(quantidadeCopias);
      writeln('Prioritário (1 para sim, 0 para não): ');
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
      // Remove um cliente da fila
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
      // Consulta as filas e imprime os clientes
      writeln('Fila Mono:');
      ImprimirFila(filaMono);
      writeln('Fila Color:');
      ImprimirFila(filaColor);
      writeln('Fila Plotter:');
      ImprimirFila(filaPlotter);
    end;
    4:
    begin
      // Prioriza um cliente na fila
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
    // Atende o próximo cliente na fila
    writeln('Fila (1 - Mono, 2 - Color, 3 - Plotter): ');
    readln(opcao);
    case opcao of
    1: AtenderProximoCliente(filaMono);
  2: AtenderProximoCliente(filaColor);
3: AtenderProximoCliente(filaPlotter);
end;
end;
end;
until opcao = 0; // Repete até o usuário escolher sair (opção 0)
end.