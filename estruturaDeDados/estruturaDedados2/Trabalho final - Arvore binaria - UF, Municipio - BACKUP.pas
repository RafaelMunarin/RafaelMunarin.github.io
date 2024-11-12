program ArvoreBinariaUF;

uses
  crt;

{ Declaração de tipos para nós das árvores de municípios e de UFs }
type
  refMunicipio = ^nodeMunicipio;  { Ponteiro para o nó de município }
  nodeMunicipio = record
    municipio: string;            { Nome do município }
    left, right: refMunicipio;    { Ponteiros para filhos à esquerda e à direita }
  end;
  
  refUF = ^nodeUF;                { Ponteiro para o nó de UF }
  nodeUF = record
    uf: string;                   { Nome da UF }
    left, right: refUF;           { Ponteiros para filhos à esquerda e à direita }
    municipioTree: refMunicipio;  { Ponteiro para a árvore binária de municípios }
  end;

{ Função para criar um novo nó de município }
function createMunicipio(municipio: string): refMunicipio;
var
  newNode: refMunicipio;
begin
  new(newNode);                       { Aloca memória para o novo nó de município }
  newNode^.municipio := municipio;    { Define o nome do município }
  newNode^.left := nil;               { Inicializa os ponteiros para filhos como nil }
  newNode^.right := nil;
  createMunicipio := newNode;         { Retorna o novo nó criado }
end;

{ Procedimento para inserir um município na árvore de municípios }
procedure insertMunicipio(var tree: refMunicipio; municipio: string);
begin
  if tree = nil then
    tree := createMunicipio(municipio)          { Insere o município na raiz se a árvore estiver vazia }
  else if municipio < tree^.municipio then
    insertMunicipio(tree^.left, municipio)      { Insere no lado esquerdo se for menor }
  else
    insertMunicipio(tree^.right, municipio);    { Insere no lado direito se for maior }
end;

{ Procedimento para inserir uma UF e seu município associado na árvore de UFs }
procedure insertUF(var tree: refUF; uf: string; municipio: string);
begin
  if tree = nil then
  begin
    new(tree);                                 { Aloca memória para o novo nó de UF }
    tree^.uf := uf;                            { Define o nome da UF }
    tree^.left := nil;                         { Inicializa os ponteiros para filhos como nil }
    tree^.right := nil;
    tree^.municipioTree := nil;                { Inicializa a árvore de municípios como nil }
    insertMunicipio(tree^.municipioTree, municipio); { Insere o município na árvore de municípios da UF }
  end
  else if uf < tree^.uf then
    insertUF(tree^.left, uf, municipio)        { Insere a UF no lado esquerdo se for menor }
  else if uf > tree^.uf then
    insertUF(tree^.right, uf, municipio)       { Insere a UF no lado direito se for maior }
  else
    insertMunicipio(tree^.municipioTree, municipio); { Se a UF já existe, insere o município na árvore de municípios }
end;

{ Procedimento para exibir a árvore de municípios em ordem }
procedure showMunicipioTree(tree: refMunicipio);
begin
  if tree <> nil then
  begin
    showMunicipioTree(tree^.left);             { Exibe os nós do lado esquerdo }
    writeln('   ', tree^.municipio);           { Exibe o nome do município }
    showMunicipioTree(tree^.right);            { Exibe os nós do lado direito }
  end;
end;

{ Procedimento para exibir a árvore de UFs e seus municípios }
procedure showUFTree(tree: refUF);
begin
  if tree <> nil then
  begin
    showUFTree(tree^.left);                    { Exibe as UFs do lado esquerdo }
    writeln('UF: ', tree^.uf);                 { Exibe o nome da UF }
    writeln('Municípios:');
    showMunicipioTree(tree^.municipioTree);    { Exibe a árvore de municípios da UF }
    writeln('-------------------------');
    showUFTree(tree^.right);                   { Exibe as UFs do lado direito }
  end;
end;

{ Procedimento para exibir apenas a árvore de UFs }
procedure showUFOnlyTree(tree: refUF);
begin
  if tree <> nil then
  begin
    showUFOnlyTree(tree^.left);                { Exibe as UFs do lado esquerdo }
    writeln('UF: ', tree^.uf);                 { Exibe o nome da UF }
    showUFOnlyTree(tree^.right);               { Exibe as UFs do lado direito }
  end;
end;

{ Função para contar o número de municípios em uma árvore de municípios }
function countMunicipios(tree: refMunicipio): integer;
begin
  if tree = nil then
    countMunicipios := 0                      { Retorna 0 se a árvore estiver vazia }
  else
    countMunicipios := 1 + countMunicipios(tree^.left) + countMunicipios(tree^.right); { Conta todos os nós recursivamente }
end;

{ Função para verificar se um nó é folha (não tem filhos) }
function isLeaf(node: refMunicipio): boolean;
begin
  isLeaf := (node^.left = nil) and (node^.right = nil);  { Retorna true se ambos os filhos forem nil }
end;

{ Procedimento para remover um município da árvore de municípios }
procedure removeMunicipio(var tree: refMunicipio; municipio: string);
var
  temp: refMunicipio;
begin
  if tree = nil then
    exit
  else if municipio < tree^.municipio then
    removeMunicipio(tree^.left, municipio)     { Procura no lado esquerdo }
  else if municipio > tree^.municipio then
    removeMunicipio(tree^.right, municipio)    { Procura no lado direito }
  else
  begin
    { Caso o nó seja folha }
    if isLeaf(tree) then
    begin
      dispose(tree);                           { Libera o nó }
      tree := nil;
    end
    { Caso o nó tenha apenas um filho à direita }
    else if tree^.left = nil then
    begin
      temp := tree;
      tree := tree^.right;
      dispose(temp);
    end
    { Caso o nó tenha apenas um filho à esquerda }
    else if tree^.right = nil then
    begin
      temp := tree;
      tree := tree^.left;
      dispose(temp);
    end
    { Caso o nó tenha ambos os filhos }
    else
    begin
      temp := tree^.right;
      while temp^.left <> nil do
        temp := temp^.left;
      tree^.municipio := temp^.municipio;       { Substitui pelo sucessor }
      removeMunicipio(tree^.right, temp^.municipio);
    end;
  end;
end;

{ Função para encontrar uma UF na árvore de UFs }
function findUF(tree: refUF; uf: string): refUF;
begin
  if tree = nil then
    findUF := nil                               { Retorna nil se a UF não for encontrada }
  else if uf = tree^.uf then
    findUF := tree                              { Retorna o nó se encontrar a UF }
  else if uf < tree^.uf then
    findUF := findUF(tree^.left, uf)            { Procura no lado esquerdo }
  else
    findUF := findUF(tree^.right, uf);          { Procura no lado direito }
end;

{ Variáveis globais e programa principal }
var
  rootUF: refUF;
  uf, municipio: string;
  opcao: integer;
  ufNode: refUF;
begin
  rootUF := nil;
  repeat
    ClrScr;
    writeln('===========================================');
    writeln('           ÁRVORE BINÁRIA DE UFs           ');
    writeln('===========================================');
    writeln;
    writeln('1 - Inserir UF e Município');
    writeln('2 - Mostrar árvore de UFs e Municípios');
    writeln('3 - Mostrar árvore de UFs (somente UFs)');
    writeln('4 - Contar municípios de uma UF');
    writeln('5 - Remover Município');
    writeln('6 - Sair');
    writeln;
    write('Escolha uma opção: ');
    readln(opcao);
    ClrScr;

    case opcao of
      1:
      begin
        writeln('Inserção de UF e Município');
        writeln('----------------------------');
        write('Digite a UF: ');
        readln(uf);
        write('Digite o município: ');
        readln(municipio);
        insertUF(rootUF, uf, municipio);      { Insere UF e Município na árvore }
        writeln('Município inserido com sucesso!');
        readln;
      end;
      2:
      begin
        writeln('Árvore de UFs e Municípios');
        writeln('----------------------------');
        showUFTree(rootUF);                   { Exibe toda a árvore de UFs e Municípios }
        readln;
      end;
      3:
      begin
        writeln('Árvore de UFs (somente UFs)');
        writeln('----------------------------');
        showUFOnlyTree(rootUF);               { Exibe apenas a árvore de UFs }
        readln;
      end;
      4:
      begin
        writeln('Contagem de Municípios em uma UF');
        writeln('----------------------------');
        write('Digite a UF: ');
        readln(uf);
        ufNode := findUF(rootUF, uf);         { Busca a UF desejada }
        if ufNode <> nil then
          writeln('A UF ', uf, ' possui ', countMunicipios(ufNode^.municipioTree), ' municípios.')
        else
          writeln('UF não encontrada!');
        readln;
      end;
      5:
      begin
        writeln('Remoção de Município');
        writeln('----------------------------');
        write('Digite a UF: ');
        readln(uf);
        write('Digite o município a ser removido: ');
        readln(municipio);
        ufNode := findUF(rootUF, uf);         { Busca a UF onde será removido o município }
        if ufNode <> nil then
        begin
          removeMunicipio(ufNode^.municipioTree, municipio); { Remove o município }
          writeln('Município removido com sucesso!');
        end
        else
          writeln('UF não encontrada!');
        readln;
      end;
    end;
  until opcao = 6;
end.
