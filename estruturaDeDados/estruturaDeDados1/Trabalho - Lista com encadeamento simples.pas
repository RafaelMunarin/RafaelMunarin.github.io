// Programa principal para gerenciar uma lista de cidades de Santa Catarina
program ListaCidadesSC;

// Declara��o de um tipo de ponteiro para um registro de cidade
type
    PontoCidade = ^RegistroCidade;
    RegistroCidade = record
        nome: string; // Nome da cidade
        proximo: PontoCidade; // Ponteiro para a pr�xima cidade na lista
    end;

var
    listaCidades: PontoCidade; // Ponteiro para o in�cio da lista de cidades
    opcao: integer; // Vari�vel para armazenar a op��o do menu

// Procedure para inicializar a lista de cidades como vazia
procedure InicializarListaCidades(var lista: PontoCidade);
begin
    lista := nil; 
end;

// Procedure para inserir uma nova cidade na lista em ordem alfab�tica
procedure InserirCidade(var lista: PontoCidade; nomeCidade: string);
var
    novoNo, anterior, atual: PontoCidade; // Ponteiros para os n�s da lista
begin
    New(novoNo); // Aloca mem�ria para um novo n�
    novoNo^.nome := nomeCidade; // Define o nome da cidade no novo n�
    novoNo^.proximo := nil; // Define que o pr�ximo n� � nulo

    // Verifica se a lista est� vazia
    if lista = nil then
        lista := novoNo // Se estiver vazia, o novo n� se torna o primeiro n� da lista
    else 
    begin
        // Se n�o estiver vazia, procura a posi��o correta para inserir a nova cidade
        if lista^.nome > nomeCidade then // Se o nome da nova cidade for menor que o nome da primeira cidade da lista
        begin
            novoNo^.proximo := lista; // O pr�ximo n� do novo n� � o primeiro n� da lista atual
            lista := novoNo; // O novo n� se torna o primeiro n� da lista
        end
        else
        begin
            // Procura a posi��o correta na lista para inserir a nova cidade
            anterior := lista; // Come�a pelo primeiro n� da lista
            atual := lista^.proximo; // Define o n� atual como o pr�ximo n� da lista

            // Percorre a lista at� encontrar a posi��o correta para a nova cidade
            while (atual <> nil) and (atual^.nome < nomeCidade) do
            begin
                anterior := atual; // Atualiza o n� anterior para o n� atual
                atual := atual^.proximo; // Avan�a para o pr�ximo n� da lista
            end;

            // Insere a nova cidade na posi��o correta na lista
            novoNo^.proximo := atual; // O pr�ximo n� do novo n� � o n� atual
            anterior^.proximo := novoNo; // O pr�ximo n� do n� anterior � o novo n�
        end;
    end;
end;

// Procedure para exibir a lista de cidades na tela
procedure ExibirListaCidades(lista: PontoCidade);
var
    atual: PontoCidade; // Ponteiro para percorrer a lista
begin
    atual := lista; // Come�a pelo primeiro n� da lista

    writeln('Lista de cidades de Santa Catarina:');

    // Percorre a lista e exibe o nome de cada cidade na tela
    while atual <> nil do
    begin
        writeln(atual^.nome); // Exibe o nome da cidade
        atual := atual^.proximo; // Avan�a para o pr�ximo n� da lista
    end;
end;

// Procedure para incluir uma nova cidade na lista
procedure IncluirNovaCidade(var lista: PontoCidade);
var
    nomeCidade: string; // Vari�vel para armazenar o nome da cidade a ser inclu�da
begin
    write('Digite o nome da cidade a ser inclu�da: '); 
    readln(nomeCidade); // L� o nome da cidade
    InserirCidade(lista, nomeCidade); // Chama a fun��o para inserir a cidade na lista
    writeln('Cidade inclu�da com sucesso!'); 
end;

// Procedure para remover uma cidade da lista
procedure RemoverCidade(var lista: PontoCidade);
var
    nomeCidade: string; // Vari�vel para armazenar o nome da cidade a ser removida
    anterior, atual: PontoCidade; // Ponteiros para percorrer a lista
begin
    write('Digite o nome da cidade a ser removida: ');
    readln(nomeCidade); // L� o nome da cidade
    anterior := nil; // Inicializa o n� anterior como nulo
    atual := lista; // Come�a pelo primeiro n� da lista

    // Percorre a lista at� encontrar a cidade a ser removida
    while (atual <> nil) and (atual^.nome <> nomeCidade) do
    begin
        anterior := atual; // Atualiza o n� anterior para o n� atual
        atual := atual^.proximo; // Avan�a para o pr�ximo n� da lista
    end;

    // Verifica se a cidade foi encontrada na lista
    if atual = nil then
        writeln('Cidade n�o encontrada na lista!') 
    else
    begin
        // Remove a cidade da lista
        if anterior = nil then
            lista := lista^.proximo // Se a cidade a ser removida for a primeira da lista, atualiza o in�cio da lista
        else
            anterior^.proximo := atual^.proximo; // Atualiza o pr�ximo n� do n� anterior para o pr�ximo n� do n� atual
        Dispose(atual); // Libera a mem�ria alocada para o n� atual
        writeln('Cidade removida com sucesso!'); // Informa que a cidade foi removida com sucesso
    end;
end;

// Procedure para exibir o menu de op��es na tela
procedure ExibirMenu(var opcao: integer);
begin
    writeln('----- MENU -----'); 
    writeln('1. Incluir cidade'); 
    writeln('2. Remover cidade'); 
    writeln('3. Visualizar lista ordenada'); 
    writeln('4. Sair'); 
    write('Escolha uma op��o: '); 
    readln(opcao); 
end;

// Procedure para processar a op��o escolhida pelo usu�rio
procedure ProcessarOpcao(opcao: integer; var lista: PontoCidade);
begin
    case opcao of
        1: IncluirNovaCidade(lista); // Chama a procedure para incluir uma cidade na lista
        2: RemoverCidade(lista); // Chama a procedure para remover uma cidade da lista
        3: ExibirListaCidades(lista); // Chama a procedure para exibir a lista de cidades na tela 
    else
        writeln('Op��o inv�lida!');
    end;
end;

// Programa principal
begin
    InicializarListaCidades(listaCidades); // Inicializa a lista de cidades como vazia
    clrscr;
    repeat
        ExibirMenu(opcao); // Exibe o menu de op��es na tela
        ProcessarOpcao(opcao, listaCidades); // Processa a op��o escolhida pelo usu�rio
    until opcao = 4; // Repete at� que o usu�rio escolha a op��o de sair
end.
