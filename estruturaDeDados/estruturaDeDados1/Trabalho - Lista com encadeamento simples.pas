// Programa principal para gerenciar uma lista de cidades de Santa Catarina
program ListaCidadesSC;

// Declaração de um tipo de ponteiro para um registro de cidade
type
    PontoCidade = ^RegistroCidade;
    RegistroCidade = record
        nome: string; // Nome da cidade
        proximo: PontoCidade; // Ponteiro para a próxima cidade na lista
    end;

var
    listaCidades: PontoCidade; // Ponteiro para o início da lista de cidades
    opcao: integer; // Variável para armazenar a opção do menu

// Procedure para inicializar a lista de cidades como vazia
procedure InicializarListaCidades(var lista: PontoCidade);
begin
    lista := nil; 
end;

// Procedure para inserir uma nova cidade na lista em ordem alfabética
procedure InserirCidade(var lista: PontoCidade; nomeCidade: string);
var
    novoNo, anterior, atual: PontoCidade; // Ponteiros para os nós da lista
begin
    New(novoNo); // Aloca memória para um novo nó
    novoNo^.nome := nomeCidade; // Define o nome da cidade no novo nó
    novoNo^.proximo := nil; // Define que o próximo nó é nulo

    // Verifica se a lista está vazia
    if lista = nil then
        lista := novoNo // Se estiver vazia, o novo nó se torna o primeiro nó da lista
    else 
    begin
        // Se não estiver vazia, procura a posição correta para inserir a nova cidade
        if lista^.nome > nomeCidade then // Se o nome da nova cidade for menor que o nome da primeira cidade da lista
        begin
            novoNo^.proximo := lista; // O próximo nó do novo nó é o primeiro nó da lista atual
            lista := novoNo; // O novo nó se torna o primeiro nó da lista
        end
        else
        begin
            // Procura a posição correta na lista para inserir a nova cidade
            anterior := lista; // Começa pelo primeiro nó da lista
            atual := lista^.proximo; // Define o nó atual como o próximo nó da lista

            // Percorre a lista até encontrar a posição correta para a nova cidade
            while (atual <> nil) and (atual^.nome < nomeCidade) do
            begin
                anterior := atual; // Atualiza o nó anterior para o nó atual
                atual := atual^.proximo; // Avança para o próximo nó da lista
            end;

            // Insere a nova cidade na posição correta na lista
            novoNo^.proximo := atual; // O próximo nó do novo nó é o nó atual
            anterior^.proximo := novoNo; // O próximo nó do nó anterior é o novo nó
        end;
    end;
end;

// Procedure para exibir a lista de cidades na tela
procedure ExibirListaCidades(lista: PontoCidade);
var
    atual: PontoCidade; // Ponteiro para percorrer a lista
begin
    atual := lista; // Começa pelo primeiro nó da lista

    writeln('Lista de cidades de Santa Catarina:');

    // Percorre a lista e exibe o nome de cada cidade na tela
    while atual <> nil do
    begin
        writeln(atual^.nome); // Exibe o nome da cidade
        atual := atual^.proximo; // Avança para o próximo nó da lista
    end;
end;

// Procedure para incluir uma nova cidade na lista
procedure IncluirNovaCidade(var lista: PontoCidade);
var
    nomeCidade: string; // Variável para armazenar o nome da cidade a ser incluída
begin
    write('Digite o nome da cidade a ser incluída: '); 
    readln(nomeCidade); // Lê o nome da cidade
    InserirCidade(lista, nomeCidade); // Chama a função para inserir a cidade na lista
    writeln('Cidade incluída com sucesso!'); 
end;

// Procedure para remover uma cidade da lista
procedure RemoverCidade(var lista: PontoCidade);
var
    nomeCidade: string; // Variável para armazenar o nome da cidade a ser removida
    anterior, atual: PontoCidade; // Ponteiros para percorrer a lista
begin
    write('Digite o nome da cidade a ser removida: ');
    readln(nomeCidade); // Lê o nome da cidade
    anterior := nil; // Inicializa o nó anterior como nulo
    atual := lista; // Começa pelo primeiro nó da lista

    // Percorre a lista até encontrar a cidade a ser removida
    while (atual <> nil) and (atual^.nome <> nomeCidade) do
    begin
        anterior := atual; // Atualiza o nó anterior para o nó atual
        atual := atual^.proximo; // Avança para o próximo nó da lista
    end;

    // Verifica se a cidade foi encontrada na lista
    if atual = nil then
        writeln('Cidade não encontrada na lista!') 
    else
    begin
        // Remove a cidade da lista
        if anterior = nil then
            lista := lista^.proximo // Se a cidade a ser removida for a primeira da lista, atualiza o início da lista
        else
            anterior^.proximo := atual^.proximo; // Atualiza o próximo nó do nó anterior para o próximo nó do nó atual
        Dispose(atual); // Libera a memória alocada para o nó atual
        writeln('Cidade removida com sucesso!'); // Informa que a cidade foi removida com sucesso
    end;
end;

// Procedure para exibir o menu de opções na tela
procedure ExibirMenu(var opcao: integer);
begin
    writeln('----- MENU -----'); 
    writeln('1. Incluir cidade'); 
    writeln('2. Remover cidade'); 
    writeln('3. Visualizar lista ordenada'); 
    writeln('4. Sair'); 
    write('Escolha uma opção: '); 
    readln(opcao); 
end;

// Procedure para processar a opção escolhida pelo usuário
procedure ProcessarOpcao(opcao: integer; var lista: PontoCidade);
begin
    case opcao of
        1: IncluirNovaCidade(lista); // Chama a procedure para incluir uma cidade na lista
        2: RemoverCidade(lista); // Chama a procedure para remover uma cidade da lista
        3: ExibirListaCidades(lista); // Chama a procedure para exibir a lista de cidades na tela 
    else
        writeln('Opção inválida!');
    end;
end;

// Programa principal
begin
    InicializarListaCidades(listaCidades); // Inicializa a lista de cidades como vazia
    clrscr;
    repeat
        ExibirMenu(opcao); // Exibe o menu de opções na tela
        ProcessarOpcao(opcao, listaCidades); // Processa a opção escolhida pelo usuário
    until opcao = 4; // Repete até que o usuário escolha a opção de sair
end.
