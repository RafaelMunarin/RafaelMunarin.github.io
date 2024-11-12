program ArvoreBinariaUF;

uses
  crt;

{ Declara��o de tipos para n�s das �rvores de munic�pios e de UFs }
type
  refMunicipio = ^nodeMunicipio;  { Ponteiro para o n� de munic�pio }
  nodeMunicipio = record
    municipio: string;            { Nome do munic�pio }
    left, right: refMunicipio;    { Ponteiros para filhos � esquerda e � direita }
  end;
  
  refUF = ^nodeUF;                { Ponteiro para o n� de UF }
  nodeUF = record
    uf: string;                   { Nome da UF }
    left, right: refUF;           { Ponteiros para filhos � esquerda e � direita }
    municipioTree: refMunicipio;  { Ponteiro para a �rvore bin�ria de munic�pios }
  end;

{ Fun��o para criar um novo n� de munic�pio }
function createMunicipio(municipio: string): refMunicipio;
var
  newNode: refMunicipio;
begin
  new(newNode);                       { Aloca mem�ria para o novo n� de munic�pio }
  newNode^.municipio := municipio;    { Define o nome do munic�pio }
  newNode^.left := nil;               { Inicializa os ponteiros para filhos como nil }
  newNode^.right := nil;
  createMunicipio := newNode;         { Retorna o novo n� criado }
end;

{ Procedimento para inserir um munic�pio na �rvore de munic�pios }
procedure insertMunicipio(var tree: refMunicipio; municipio: string);
begin
  if tree = nil then
    tree := createMunicipio(municipio)          { Insere o munic�pio na raiz se a �rvore estiver vazia }
  else if municipio < tree^.municipio then
    insertMunicipio(tree^.left, municipio)      { Insere no lado esquerdo se for menor }
  else
    insertMunicipio(tree^.right, municipio);    { Insere no lado direito se for maior }
end;

{ Procedimento para inserir uma UF e seu munic�pio associado na �rvore de UFs }
procedure insertUF(var tree: refUF; uf: string; municipio: string);
begin
  if tree = nil then
  begin
    new(tree);                                 { Aloca mem�ria para o novo n� de UF }
    tree^.uf := uf;                            { Define o nome da UF }
    tree^.left := nil;                         { Inicializa os ponteiros para filhos como nil }
    tree^.right := nil;
    tree^.municipioTree := nil;                { Inicializa a �rvore de munic�pios como nil }
    insertMunicipio(tree^.municipioTree, municipio); { Insere o munic�pio na �rvore de munic�pios da UF }
  end
  else if uf < tree^.uf then
    insertUF(tree^.left, uf, municipio)        { Insere a UF no lado esquerdo se for menor }
  else if uf > tree^.uf then
    insertUF(tree^.right, uf, municipio)       { Insere a UF no lado direito se for maior }
  else
    insertMunicipio(tree^.municipioTree, municipio); { Se a UF j� existe, insere o munic�pio na �rvore de munic�pios }
end;

{ Procedimento para exibir a �rvore de munic�pios em ordem }
procedure showMunicipioTree(tree: refMunicipio);
begin
  if tree <> nil then
  begin
    showMunicipioTree(tree^.left);             { Exibe os n�s do lado esquerdo }
    writeln('   ', tree^.municipio);           { Exibe o nome do munic�pio }
    showMunicipioTree(tree^.right);            { Exibe os n�s do lado direito }
  end;
end;

{ Procedimento para exibir a �rvore de UFs e seus munic�pios }
procedure showUFTree(tree: refUF);
begin
  if tree <> nil then
  begin
    showUFTree(tree^.left);                    { Exibe as UFs do lado esquerdo }
    writeln('UF: ', tree^.uf);                 { Exibe o nome da UF }
    writeln('Munic�pios:');
    showMunicipioTree(tree^.municipioTree);    { Exibe a �rvore de munic�pios da UF }
    writeln('-------------------------');
    showUFTree(tree^.right);                   { Exibe as UFs do lado direito }
  end;
end;

{ Procedimento para exibir apenas a �rvore de UFs }
procedure showUFOnlyTree(tree: refUF);
begin
  if tree <> nil then
  begin
    showUFOnlyTree(tree^.left);                { Exibe as UFs do lado esquerdo }
    writeln('UF: ', tree^.uf);                 { Exibe o nome da UF }
    showUFOnlyTree(tree^.right);               { Exibe as UFs do lado direito }
  end;
end;

{ Fun��o para contar o n�mero de munic�pios em uma �rvore de munic�pios }
function countMunicipios(tree: refMunicipio): integer;
begin
  if tree = nil then
    countMunicipios := 0                      { Retorna 0 se a �rvore estiver vazia }
  else
    countMunicipios := 1 + countMunicipios(tree^.left) + countMunicipios(tree^.right); { Conta todos os n�s recursivamente }
end;

{ Fun��o para verificar se um n� � folha (n�o tem filhos) }
function isLeaf(node: refMunicipio): boolean;
begin
  isLeaf := (node^.left = nil) and (node^.right = nil);  { Retorna true se ambos os filhos forem nil }
end;

{ Procedimento para remover um munic�pio da �rvore de munic�pios }
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
    { Caso o n� seja folha }
    if isLeaf(tree) then
    begin
      dispose(tree);                           { Libera o n� }
      tree := nil;
    end
    { Caso o n� tenha apenas um filho � direita }
    else if tree^.left = nil then
    begin
      temp := tree;
      tree := tree^.right;
      dispose(temp);
    end
    { Caso o n� tenha apenas um filho � esquerda }
    else if tree^.right = nil then
    begin
      temp := tree;
      tree := tree^.left;
      dispose(temp);
    end
    { Caso o n� tenha ambos os filhos }
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

{ Fun��o para encontrar uma UF na �rvore de UFs }
function findUF(tree: refUF; uf: string): refUF;
begin
  if tree = nil then
    findUF := nil                               { Retorna nil se a UF n�o for encontrada }
  else if uf = tree^.uf then
    findUF := tree                              { Retorna o n� se encontrar a UF }
  else if uf < tree^.uf then
    findUF := findUF(tree^.left, uf)            { Procura no lado esquerdo }
  else
    findUF := findUF(tree^.right, uf);          { Procura no lado direito }
end;

{ Vari�veis globais e programa principal }
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
    writeln('           �RVORE BIN�RIA DE UFs           ');
    writeln('===========================================');
    writeln;
    writeln('1 - Inserir UF e Munic�pio');
    writeln('2 - Mostrar �rvore de UFs e Munic�pios');
    writeln('3 - Mostrar �rvore de UFs (somente UFs)');
    writeln('4 - Contar munic�pios de uma UF');
    writeln('5 - Remover Munic�pio');
    writeln('6 - Sair');
    writeln;
    write('Escolha uma op��o: ');
    readln(opcao);
    ClrScr;

    case opcao of
      1:
      begin
        writeln('Inser��o de UF e Munic�pio');
        writeln('----------------------------');
        write('Digite a UF: ');
        readln(uf);
        write('Digite o munic�pio: ');
        readln(municipio);
        insertUF(rootUF, uf, municipio);      { Insere UF e Munic�pio na �rvore }
        writeln('Munic�pio inserido com sucesso!');
        readln;
      end;
      2:
      begin
        writeln('�rvore de UFs e Munic�pios');
        writeln('----------------------------');
        showUFTree(rootUF);                   { Exibe toda a �rvore de UFs e Munic�pios }
        readln;
      end;
      3:
      begin
        writeln('�rvore de UFs (somente UFs)');
        writeln('----------------------------');
        showUFOnlyTree(rootUF);               { Exibe apenas a �rvore de UFs }
        readln;
      end;
      4:
      begin
        writeln('Contagem de Munic�pios em uma UF');
        writeln('----------------------------');
        write('Digite a UF: ');
        readln(uf);
        ufNode := findUF(rootUF, uf);         { Busca a UF desejada }
        if ufNode <> nil then
          writeln('A UF ', uf, ' possui ', countMunicipios(ufNode^.municipioTree), ' munic�pios.')
        else
          writeln('UF n�o encontrada!');
        readln;
      end;
      5:
      begin
        writeln('Remo��o de Munic�pio');
        writeln('----------------------------');
        write('Digite a UF: ');
        readln(uf);
        write('Digite o munic�pio a ser removido: ');
        readln(municipio);
        ufNode := findUF(rootUF, uf);         { Busca a UF onde ser� removido o munic�pio }
        if ufNode <> nil then
        begin
          removeMunicipio(ufNode^.municipioTree, municipio); { Remove o munic�pio }
          writeln('Munic�pio removido com sucesso!');
        end
        else
          writeln('UF n�o encontrada!');
        readln;
      end;
    end;
  until opcao = 6;
end.
