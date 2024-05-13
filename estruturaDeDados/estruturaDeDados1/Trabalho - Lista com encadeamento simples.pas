program ListaCidadesSC;

type
    PontoCidade = ^RegistroCidade;
    RegistroCidade = record
        nome: string;
        proximo: PontoCidade;
    end;

var
    listaCidades: PontoCidade;
    nomeCidade: string;
    quantidadeCidades: integer;

procedure InicializarLista(var lista: PontoCidade);
begin
    lista := nil;
end;

procedure InserirCidade(var lista: PontoCidade; nome: string);
var
    novoNo, anterior, atual: PontoCidade;
begin
    New(novoNo);
    novoNo^.nome := nome;
    novoNo^.proximo := nil;

    if lista = nil then
        lista := novoNo
    else if lista^.nome > nome then
    begin
        novoNo^.proximo := lista;
        lista := novoNo;
    end
    else
    begin
        anterior := lista;
        atual := lista^.proximo;

        while (atual <> nil) and (atual^.nome < nome) do
        begin
            anterior := atual;
            atual := atual^.proximo;
        end;

        novoNo^.proximo := atual;
        anterior^.proximo := novoNo;
    end;
end;

procedure ExibirLista(lista: PontoCidade);
var
    atual: PontoCidade;
begin
    atual := lista;

    writeln('Lista de cidades de Santa Catarina:');
    while atual <> nil do
    begin
        writeln(atual^.nome);
        atual := atual^.proximo;
    end;
end;

procedure SolicitarQuantidadeCidades(var quantidade: integer);
begin
    writeln('Quantas cidades de Santa Catarina deseja inserir?');
    readln(quantidade);
end;

procedure LerNomeCidade(var nome: string);
begin
    write('Nome da cidade: ');
    readln(nome);
end;

procedure PreencherLista(var lista: PontoCidade; quantidade: integer);
var
    i: integer;
    nomeCidade: string;
begin
    InicializarLista(lista);
    for i := 1 to quantidade do
    begin
        LerNomeCidade(nomeCidade);
        InserirCidade(lista, nomeCidade);
    end;
end;

begin
    SolicitarQuantidadeCidades(quantidadeCidades);
    PreencherLista(listaCidades, quantidadeCidades);
    ExibirLista(listaCidades);
end.
