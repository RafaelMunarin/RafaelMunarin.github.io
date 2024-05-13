//Alunos:
//Daniel Espindola,  Rafael Batistti Munarin

program ListaCidadesSC;

// Definição de um tipo de registro para representar uma cidade
type
    PontoCidade = ^RegistroCidade;
    RegistroCidade = record
        nome: string; // O nome da cidade
        proximo: PontoCidade; // O ponteiro para a próxima cidade na lista
    end;

// Variáveis globais
var
    listaCidades: PontoCidade; // A lista de cidades
    quantidadeCidades: integer; // A quantidade de cidades a serem ordenadas

// Procedure que inicializa a lista como vazia
procedure InicializarLista(var lista: PontoCidade);
begin
    lista := nil; // Faz a lista apontar para nulo, indicando que está vazia
end;

// Procedure que insere uma cidade na lista em ordem alfabética
procedure InserirCidade(var lista: PontoCidade; nome: string);
var
    novoNo, anterior, atual: PontoCidade; // Ponteiros para os nós da lista
begin
    // Cria um novo nó para a cidade
    New(novoNo);
    novoNo^.nome := nome; // Coloca o nome da cidade no novo nó
    novoNo^.proximo := nil; // Define que o próximo nó é nulo (não tem mais nada depois dele)

    // Se a lista estiver vazia, o novo nó se torna o primeiro nó da lista
    if lista = nil then
        lista := novoNo
    else 
    begin
        // Se a lista não estiver vazia, procuramos a posição correta para inserir a nova cidade
        if lista^.nome > nome then // Se o nome da nova cidade for menor que o nome da primeira cidade da lista
        begin
            // Inserimos a nova cidade no início da lista
            novoNo^.proximo := lista; // O próximo nó da nova cidade é o primeiro nó da lista atual
            lista := novoNo; // A lista agora começa com a nova cidade
        end
        else
        begin
            // Procuramos a posição correta na lista para inserir a nova cidade
            anterior := lista; // Começamos pelo primeiro nó da lista
            atual := lista^.proximo; // Próximo nó da lista

            // Enquanto houver mais cidades na lista e a nova cidade vier depois da cidade atual
            while (atual <> nil) and (atual^.nome < nome) do
            begin
                anterior := atual; // Atualizamos o nó anterior para o nó atual
                atual := atual^.proximo; // Avançamos para o próximo nó da lista
            end;

            // Inserimos a nova cidade na posição correta
            novoNo^.proximo := atual; // O próximo nó da nova cidade é o nó atual
            anterior^.proximo := novoNo; // O próximo nó do nó anterior é a nova cidade
        end;
    end;
end;

// Procedure que preenche a lista com as cidades digitadas pelo usuário
procedure PreencherLista(var lista: PontoCidade; quantidade: integer);
var
    i: integer; // Contador para o loop
    nomeCidade: string; // Nome da cidade a ser inserida
begin
    InicializarLista(lista); // Inicializa a lista como vazia

    // Loop para ler e inserir cada cidade na lista
    for i := 1 to quantidade do
    begin
        write('Nome da cidade ', i, ': '); // Pede o nome da cidade ao usuário
        readln(nomeCidade); // Lê o nome da cidade
        InserirCidade(lista, nomeCidade); // Insere a cidade na lista
    end;
end;

// Procedure que exibe as cidades da lista na tela
procedure ExibirLista(lista: PontoCidade);
var
    atual: PontoCidade; // Ponteiro para percorrer a lista
begin
    atual := lista; // Começa do primeiro nó da lista

    writeln('Lista de cidades de Santa Catarina:'); // Título da lista

    // Loop para exibir cada cidade da lista
    while atual <> nil do
    begin
        writeln(atual^.nome); // Exibe o nome da cidade
        atual := atual^.proximo; // Avança para o próximo nó da lista
    end;
end;

// Procedure que solicita ao usuário a quantidade de cidades a serem ordenadas
procedure SolicitarQuantidadeCidades(var quantidade: integer);
begin
    writeln('Quantas cidades de SC deseja ordenar por ordem alfabética?'); // Pergunta ao usuário
    readln(quantidade); // Lê a quantidade de cidades
    clrscr; // Limpa a tela
end;

// Programa principal
begin
    SolicitarQuantidadeCidades(quantidadeCidades); // Pede a quantidade de cidades ao usuário
    PreencherLista(listaCidades, quantidadeCidades); // Preenche a lista com as cidades digitadas
    clrscr; // Limpa a tela
    ExibirLista(listaCidades); // Exibe a lista de cidades na tela
end.
