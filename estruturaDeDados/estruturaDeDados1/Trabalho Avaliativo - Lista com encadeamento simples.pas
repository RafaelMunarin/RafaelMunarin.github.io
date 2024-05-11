program ListaCidadesSC;

type
    CidadePtr = ^Cidade;
    Cidade = record
        nome: string;
        proximo: CidadePtr;
    end;

var
    cabeca, atual, novo: CidadePtr;
    nomeCidade: string;

procedure InserirCidade(var cabeca: CidadePtr; nomeCidade: string);
var
    novoNo, anterior, atual: CidadePtr;
begin
    new(novoNo);
    novoNo^.nome := nomeCidade;
    novoNo^.proximo := nil;

    if cabeca = nil then
        cabeca := novoNo
    else if cabeca^.nome > nomeCidade then
    begin
        novoNo^.proximo := cabeca;
        cabeca := novoNo;
    end
    else
    begin
        anterior := cabeca;
        atual := cabeca^.proximo;

        while (atual <> nil) and (atual^.nome < nomeCidade) do
        begin
            anterior := atual;
            atual := atual^.proximo;
        end;

        novoNo^.proximo := atual;
        anterior^.proximo := novoNo;
    end;
end;

procedure ExibirLista(cabeca: CidadePtr);
var
    atual: CidadePtr;
begin
    atual := cabeca;

    writeln('Lista de cidades de Santa Catarina:');
    while atual <> nil do
    begin
        writeln(atual^.nome);
        atual := atual^.proximo;
    end;
end;

begin
    cabeca := nil;

    // Solicitar os nomes das cidades
    writeln('Digite o nome das cidades de Santa Catarina (Digite "Fim" para parar):');
    repeat
        write('Nome da cidade: ');
        readln(nomeCidade);
        if nomeCidade <> 'Fim' then
            InserirCidade(cabeca, nomeCidade);
    until nomeCidade = 'Fim';

    // Exibindo a lista
    ExibirLista(cabeca);
end.
