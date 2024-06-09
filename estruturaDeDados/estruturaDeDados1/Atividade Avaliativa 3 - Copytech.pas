program GerenciadorFilaImpressao;

// Alunos: Daniel Espindola, Rafael Munarin

type
// Defini��o de um ponteiro para o tipo de registro TAuxiliar
PAuxiliar = ^TAuxiliar;

// Defini��o do registro TAuxiliar que representa cada cliente na fila
TAuxiliar = record
  nomeCliente: string[50];     // Nome do cliente
  quantidadeCopias: integer;   // Quantidade de c�pias solicitadas
  prioritario: boolean;        // Se o cliente � priorit�rio
  anterior, proximo: PAuxiliar;// Ponteiros para os clientes anterior e pr�ximo na fila
end;

// Defini��o do registro TFilaImpressao que representa a fila de impress�o
TFilaImpressao = record
  inicio, fim: PAuxiliar;      // Ponteiros para o in�cio e o fim da fila
  tamanho: integer;            // Tamanho atual da fila
end;

{ Inicializa a fila, definindo os ponteiros de in�cio e fim como nil e o tamanho como 0 }
procedure InicializarFila(var fila: TFilaImpressao);
begin
  fila.inicio := nil;  // Define o in�cio da fila como nil, indicando que est� vazia
  fila.fim := nil;     // Define o fim da fila como nil, indicando que est� vazia
  fila.tamanho := 0;   // Define o tamanho da fila como 0
end;

{ Adiciona um novo cliente � fila com seu nome, quantidade de c�pias e prioridade }
procedure AdicionarClienteFila(var fila: TFilaImpressao; nomeCliente: string; quantidadeCopias: integer; prioritario: boolean);
var
novoAuxiliar, temp: PAuxiliar; // Declara ponteiros para os novos e tempor�rios clientes
begin
  New(novoAuxiliar); // Aloca mem�ria para o novo cliente
  novoAuxiliar^.nomeCliente := nomeCliente;     // Define o nome do novo cliente
  novoAuxiliar^.quantidadeCopias := quantidadeCopias; // Define a quantidade de c�pias do novo cliente
  novoAuxiliar^.prioritario := prioritario;     // Define se o cliente � priorit�rio
  novoAuxiliar^.proximo := nil;                 // Inicializa o pr�ximo cliente como nil
  
  if fila.fim = nil then // Verifica se a fila est� vazia
  begin
    novoAuxiliar^.anterior := nil;  // Define o anterior do novo cliente como nil
    fila.inicio := novoAuxiliar;    // Define o in�cio da fila como o novo cliente
    fila.fim := novoAuxiliar;       // Define o fim da fila como o novo cliente
  end
  else // Se a fila n�o est� vazia
  begin
    if prioritario then // Verifica se o cliente � priorit�rio
    begin
      temp := fila.inicio; // Inicia a varia��o temp no in�cio da fila
      while (temp <> nil) and (temp^.prioritario) do // Procura a posi��o correta para inserir o cliente priorit�rio
      temp := temp^.proximo;
      
      if temp = nil then // Se chegou ao fim da fila sem encontrar clientes n�o priorit�rios
      begin
        novoAuxiliar^.anterior := fila.fim; // Coloca o novo cliente no final da fila
        fila.fim^.proximo := novoAuxiliar; // Atualiza o ponteiro do �ltimo cliente
        fila.fim := novoAuxiliar;          // Atualiza o fim da fila
      end
      else // Se encontrou a posi��o para inserir o cliente priorit�rio
      begin
        novoAuxiliar^.proximo := temp; // O pr�ximo do novo cliente aponta para o cliente atual
        novoAuxiliar^.anterior := temp^.anterior; // O anterior do novo cliente aponta para o anterior do cliente atual
        if temp^.anterior <> nil then
        temp^.anterior^.proximo := novoAuxiliar // Atualiza o ponteiro do anterior do cliente atual para o novo cliente
        else
        fila.inicio := novoAuxiliar; // Se o anterior do cliente atual for nil, o novo cliente � o in�cio da fila
        temp^.anterior := novoAuxiliar; // Atualiza o anterior do cliente atual para o novo cliente
      end;
    end
    else // Se o cliente n�o � priorit�rio
    begin
      novoAuxiliar^.anterior := fila.fim; // Coloca o novo cliente no final da fila
      fila.fim^.proximo := novoAuxiliar;  // Atualiza o ponteiro do �ltimo cliente
      fila.fim := novoAuxiliar;           // Atualiza o fim da fila
    end;
  end;
  fila.tamanho := fila.tamanho + 1; // Incrementa o tamanho da fila
end;

{ Remove o cliente especificado pelo nome }
procedure RemoverClienteFila(var fila: TFilaImpressao; nomeCliente: string);
var
temp: PAuxiliar; // Declara um ponteiro tempor�rio para percorrer a fila
begin
  temp := fila.inicio; // Inicia a varia��o temp no in�cio da fila
  
  { Procurar o cliente na fila }
  while (temp <> nil) and (temp^.nomeCliente <> nomeCliente) do
  temp := temp^.proximo; // Percorre a fila at� encontrar o cliente com o nome especificado ou chegar ao fim da fila
  
  { Cliente n�o encontrado }
  if temp = nil then // Se n�o encontrou o cliente
  begin
    writeln('Cliente n�o encontrado.'); // Exibe mensagem de erro
    Exit; // Sai do procedimento
  end;
  
  { Ajustar ponteiros e remover o cliente }
  if temp^.anterior <> nil then
  temp^.anterior^.proximo := temp^.proximo // Se o cliente n�o � o primeiro da fila, atualiza o ponteiro do anterior para o pr�ximo
  else
  fila.inicio := temp^.proximo; // Se o cliente � o primeiro da fila, atualiza o in�cio da fila para o pr�ximo cliente
  
  if temp^.proximo <> nil then
  temp^.proximo^.anterior := temp^.anterior // Se o cliente n�o � o �ltimo da fila, atualiza o ponteiro do pr�ximo para o anterior
  else
  fila.fim := temp^.anterior; // Se o cliente � o �ltimo da fila, atualiza o fim da fila para o cliente anterior
  
  Dispose(temp); // Libera a mem�ria alocada para o cliente removido
  fila.tamanho := fila.tamanho - 1; // Reduz o tamanho da fila
end;

{ Atende o pr�ximo cliente na fila, exibindo suas informa��es e removendo-o da fila }
procedure AtenderProximoCliente(var fila: TFilaImpressao);
var
temp: PAuxiliar; // Declara um ponteiro tempor�rio para percorrer a fila
begin
  if fila.inicio <> nil then // Verifica se a fila n�o est� vazia
  begin
    temp := fila.inicio; // Inicia a varia��o temp no in�cio da fila
    if temp^.prioritario then // Verifica se o cliente � priorit�rio
    begin
    writeln('Atendendo cliente priorit�rio: ', temp^.nomeCliente, ' com ', temp^.quantidadeCopias, ' c�pias.');
  end
  else
  begin
  writeln('Atendendo cliente: ', temp^.nomeCliente, ' com ', temp^.quantidadeCopias, ' c�pias.');
end;
RemoverClienteFila(fila, temp^.nomeCliente); // Remove o cliente atendido da fila
end
else
begin
  writeln('A fila est� vazia.'); // Exibe mensagem se a fila estiver vazia
end;
end;

{ Move o cliente pelo nome para a frente da fila, se n�o houver outro priorit�rio }
procedure PriorizarCliente(var fila: TFilaImpressao; nomeCliente: string);
var
temp, atual: PAuxiliar; // Declara ponteiros tempor�rios para percorrer a fila
jaExistePrioritario: boolean; // Declara uma vari�vel para verificar se j� existe cliente priorit�rio
begin
  atual := fila.inicio; // Inicia a varia��o atual no in�cio da fila
  jaExistePrioritario := False; // Inicializa a vari�vel como falso
  
  { Verifica se j� existe um cliente priorit�rio na fila }
  while (atual <> nil) do
  begin
    if atual^.prioritario then
    begin
      jaExistePrioritario := True; // Define a vari�vel como verdadeiro se encontrar um cliente priorit�rio
      Break; // Sai do loop
    end;
    atual := atual^.proximo; // Move para o pr�ximo cliente na fila
  end;
  
  if jaExistePrioritario then
  begin
    writeln('J� existe um cliente priorit�rio na fila.'); // Exibe mensagem se j� existir cliente priorit�rio
    Exit; // Sai do procedimento
  end;
  
  atual := fila.inicio; // Reinicia a varia��o atual no in�cio da fila
  while (atual <> nil) and (atual^.nomeCliente <> nomeCliente) do
  atual := atual^.proximo; // Percorre a fila at� encontrar o cliente com o nome especificado ou chegar ao fim da fila
  if atual <> nil then // Verifica se encontrou o cliente com o nome especificado
  begin
    if atual <> fila.inicio then // Verifica se o cliente n�o � o primeiro da fila
    begin
      if atual = fila.fim then // Verifica se o cliente � o �ltimo da fila
      begin
        fila.fim := atual^.anterior; // Atualiza o fim da fila para o cliente anterior
        fila.fim^.proximo := nil;    // Define o pr�ximo do novo fim como nil
      end
      else
      begin
        atual^.anterior^.proximo := atual^.proximo; // Atualiza o ponteiro do anterior para o pr�ximo
        atual^.proximo^.anterior := atual^.anterior; // Atualiza o ponteiro do pr�ximo para o anterior
      end;
      atual^.anterior := nil;         // Define o anterior do cliente atual como nil
      atual^.proximo := fila.inicio;  // Define o pr�ximo do cliente atual como o in�cio da fila
      fila.inicio^.anterior := atual; // Atualiza o anterior do in�cio da fila para o cliente atual
      fila.inicio := atual;           // Define o in�cio da fila como o cliente atual
    end;
  end;
end;

{ Imprime todos os clientes na fila com suas informa��es }
procedure ImprimirFila(fila: TFilaImpressao);
var
temp: PAuxiliar; // Declara um ponteiro tempor�rio para percorrer a fila
begin
  temp := fila.inicio; // Inicia a varia��o temp no in�cio da fila
  while temp <> nil do // Percorre a fila at� o final
  begin
    writeln('Nome: ', temp^.nomeCliente, ' | C�pias: ', temp^.quantidadeCopias, ' | Priorit�rio: ', temp^.prioritario);
    temp := temp^.proximo; // Move para o pr�ximo cliente na fila
  end;
end;

var
filaMono, filaColor, filaPlotter: TFilaImpressao; // Declara as filas para cada tipo de impressora
opcao: integer; // Declara a vari�vel para a op��o do usu�rio
nomeCliente: string; // Declara a vari�vel para o nome do cliente
quantidadeCopias: integer; // Declara a vari�vel para a quantidade de c�pias
prioritario: boolean; // Declara a vari�vel para a prioridade
prioridade: integer; // Declara a vari�vel para a prioridade como inteiro (1 para sim, 0 para n�o)

begin
  // Inicializa as filas para cada tipo de impressora
  InicializarFila(filaMono);
  InicializarFila(filaColor);
  InicializarFila(filaPlotter);
  
  repeat
    // Exibe o menu de op��es
    writeln('1. Adicionar cliente � fila');
    writeln('2. Remover cliente da fila');
    writeln('3. Consultar filas');
    writeln('4. Priorizar cliente');
  writeln('5. Atender pr�ximo cliente');
  writeln('0. Sair');
  writeln('Escolha uma op��o: ');
  readln(opcao);
  
  // Executa a op��o escolhida pelo usu�rio
  case opcao of
    1:
    begin
      // Adiciona um novo cliente � fila
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
    // Atende o pr�ximo cliente na fila
    writeln('Fila (1 - Mono, 2 - Color, 3 - Plotter): ');
    readln(opcao);
    case opcao of
    1: AtenderProximoCliente(filaMono);
  2: AtenderProximoCliente(filaColor);
3: AtenderProximoCliente(filaPlotter);
end;
end;
end;
until opcao = 0; // Repete at� o usu�rio escolher sair (op��o 0)
end.