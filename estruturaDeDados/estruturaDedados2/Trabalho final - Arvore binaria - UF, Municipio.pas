program ArvoreBinariaUF;

{ALUNOS: Rafael Munarin, Marcion Demarchi}

{ Declaração de tipos para nós das árvores de municípios e de UFs }
type
  PonteiroMunicipio = ^NoMunicipio;       { Ponteiro para o nó de município }
  NoMunicipio = record
    NomeMunicipio: string;                { Nome do município }
    Esq, Dir: PonteiroMunicipio;          { Ponteiros para filhos à esquerda e à direita }
  end;
  
  PonteiroUF = ^NoUF;                     { Ponteiro para o nó de UF }
  NoUF = record
    NomeUF: string;                       { Nome da UF }
    Esq, Dir: PonteiroUF;                 { Ponteiros para filhos à esquerda e à direita }
    ArvoreMunicipios: PonteiroMunicipio;  { Ponteiro para a árvore binária de municípios }
  end;

{ Função para criar um novo nó de município }
function CriarMunicipio(Nome: string): PonteiroMunicipio;
var
  NovoNo: PonteiroMunicipio;
begin
  new(NovoNo);                             { Aloca memória para o novo nó de município }
  NovoNo^.NomeMunicipio := Nome;           { Define o nome do município }
  NovoNo^.Esq := nil;                      { Inicializa os ponteiros para filhos como nil }
  NovoNo^.Dir := nil;
  CriarMunicipio := NovoNo;                { Retorna o novo nó criado }
end;

{ Procedimento para inserir um município na árvore de municípios }
procedure InserirMunicipio(var Arvore: PonteiroMunicipio; Nome: string);
begin
  if Arvore = nil then
    Arvore := CriarMunicipio(Nome)               { Insere o município na raiz se a árvore estiver vazia }
  else if Nome < Arvore^.NomeMunicipio then
    InserirMunicipio(Arvore^.Esq, Nome)          { Insere no lado esquerdo se for menor }
  else
    InserirMunicipio(Arvore^.Dir, Nome);         { Insere no lado direito se for maior }
end;

{ Procedimento para inserir uma UF e seu município associado na árvore de UFs }
procedure InserirUF(var Arvore: PonteiroUF; NomeUF: string; NomeMunicipio: string);
begin
  if Arvore = nil then
  begin
    new(Arvore);                                   { Aloca memória para o novo nó de UF }
    Arvore^.NomeUF := NomeUF;                      { Define o nome da UF }
    Arvore^.Esq := nil;                            { Inicializa os ponteiros para filhos como nil }
    Arvore^.Dir := nil;
    Arvore^.ArvoreMunicipios := nil;               { Inicializa a árvore de municípios como nil }
    InserirMunicipio(Arvore^.ArvoreMunicipios, NomeMunicipio); { Insere o município na árvore de municípios da UF }
  end
  else if NomeUF < Arvore^.NomeUF then
    InserirUF(Arvore^.Esq, NomeUF, NomeMunicipio)  { Insere a UF no lado esquerdo se for menor }
  else if NomeUF > Arvore^.NomeUF then
    InserirUF(Arvore^.Dir, NomeUF, NomeMunicipio)  { Insere a UF no lado direito se for maior }
  else
    InserirMunicipio(Arvore^.ArvoreMunicipios, NomeMunicipio); { Se a UF já existe, insere o município na árvore de municípios }
end;

{ Procedimento para exibir a árvore de municípios em ordem }
procedure MostrarMunicipios(Arvore: PonteiroMunicipio);
begin
  if Arvore <> nil then
  begin
    MostrarMunicipios(Arvore^.Esq);              { Exibe os nós do lado esquerdo }
    writeln('   ', Arvore^.NomeMunicipio);       { Exibe o nome do município }
    MostrarMunicipios(Arvore^.Dir);              { Exibe os nós do lado direito }
  end;
end;

{ Procedimento para exibir a árvore de UFs e seus municípios }
procedure MostrarUFsCompleto(Arvore: PonteiroUF);
begin
  if Arvore <> nil then
  begin
    MostrarUFsCompleto(Arvore^.Esq);             { Exibe as UFs do lado esquerdo }
    writeln('UF: ', Arvore^.NomeUF);             { Exibe o nome da UF }
    writeln('Municípios:');
    MostrarMunicipios(Arvore^.ArvoreMunicipios); { Exibe a árvore de municípios da UF }
    writeln('-------------------------');
    MostrarUFsCompleto(Arvore^.Dir);             { Exibe as UFs do lado direito }
  end;
end;

{ Procedimento para exibir apenas a árvore de UFs }
procedure MostrarUFsSomente(Arvore: PonteiroUF);
begin
  if Arvore <> nil then
  begin
    MostrarUFsSomente(Arvore^.Esq);              { Exibe as UFs do lado esquerdo }
    writeln('UF: ', Arvore^.NomeUF);             { Exibe o nome da UF }
    MostrarUFsSomente(Arvore^.Dir);              { Exibe as UFs do lado direito }
  end;
end;

{ Função para contar o número de municípios em uma árvore de municípios }
function ContarMunicipios(Arvore: PonteiroMunicipio): integer;
begin
  if Arvore = nil then
    ContarMunicipios := 0                        { Retorna 0 se a árvore estiver vazia }
  else
    ContarMunicipios := 1 + ContarMunicipios(Arvore^.Esq) + ContarMunicipios(Arvore^.Dir); { Conta todos os nós recursivamente }
end;

{ Procedimento para remover um município da árvore de municípios, apenas se for folha }
procedure RemoverMunicipio(var Arvore: PonteiroMunicipio; Nome: string);
begin
  if Arvore = nil then
    exit
  else if Nome < Arvore^.NomeMunicipio then
    RemoverMunicipio(Arvore^.Esq, Nome)           { Procura no lado esquerdo }
  else if Nome > Arvore^.NomeMunicipio then
    RemoverMunicipio(Arvore^.Dir, Nome)           { Procura no lado direito }
  else
  begin
    { Verifica se o nó é uma folha, pois só é permitido remover nós folha }
    if (Arvore^.Esq = nil) and (Arvore^.Dir = nil) then
    begin
      dispose(Arvore);                            { Libera o nó }
      Arvore := nil;                               { A árvore agora aponta para nil, removendo o nó }
      writeln('Município removido com sucesso!');    { Mensagem de sucesso na remoção }
    end
    else
    begin
      writeln('Erro: só é possível remover municípios que são folhas!');  { Se não for folha, erro }
      writeln('Estrutura atual da árvore de municípios para essa UF:');
      MostrarMunicipios(Arvore);                   { Exibe a estrutura atual da árvore de municípios }
    end;
  end;
end;

{ Função para encontrar uma UF na árvore de UFs }
function EncontrarUF(Arvore: PonteiroUF; NomeUF: string): PonteiroUF;
begin
  if Arvore = nil then
    EncontrarUF := nil                            { Retorna nil se a UF não for encontrada }
  else if NomeUF = Arvore^.NomeUF then
    EncontrarUF := Arvore                         { Retorna o nó se encontrar a UF }
  else if NomeUF < Arvore^.NomeUF then
    EncontrarUF := EncontrarUF(Arvore^.Esq, NomeUF)  { Procura no lado esquerdo }
  else
    EncontrarUF := EncontrarUF(Arvore^.Dir, NomeUF); { Procura no lado direito }
end;

{ Variáveis globais e programa principal }
var
  ArvoreUFs: PonteiroUF;  { Árvore que armazena todas as UFs }
  NomeUF, NomeMunicipio: string;  { Variáveis para armazenar o nome da UF e do município }
  Opcao: integer;  { Variável para armazenar a escolha do usuário no menu }
begin
  ArvoreUFs := nil;  { Inicializa a árvore de UFs como vazia }
  repeat
    ClrScr;  { Limpa a tela antes de exibir o menu }
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
    readln(Opcao);  { Lê a escolha do usuário }
    ClrScr;  { Limpa a tela após a escolha do usuário }

    case Opcao of
      1:
      begin
        writeln('Inserção de UF e Município');
        writeln('----------------------------');
        write('Digite a UF: ');
        readln(NomeUF);  { Lê o nome da UF }
        write('Digite o município: ');
        readln(NomeMunicipio);  { Lê o nome do município }
        InserirUF(ArvoreUFs, NomeUF, NomeMunicipio);  { Insere UF e Município na árvore }
        writeln('Município inserido com sucesso!');  { Confirma a inserção }
        readln;  { Aguarda o usuário pressionar Enter para continuar }
      end;
      2:
      begin
        writeln('Árvore de UFs e Municípios');
        writeln('----------------------------');
        MostrarUFsCompleto(ArvoreUFs);               { Exibe toda a árvore de UFs e Municípios }
        readln;  { Aguarda o usuário pressionar Enter para continuar }
      end;
      3:
      begin
        writeln('Árvore de UFs (somente UFs)');
        writeln('----------------------------');
        MostrarUFsSomente(ArvoreUFs);                { Exibe apenas a árvore de UFs }
        readln;  { Aguarda o usuário pressionar Enter para continuar }
      end;
      4:
      begin
        writeln('Contagem de Municípios em uma UF');
        writeln('----------------------------');
        write('Digite a UF: ');
        readln(NomeUF);  { Lê o nome da UF para contar seus municípios }
        if EncontrarUF(ArvoreUFs, NomeUF) <> nil then
          writeln('A UF ', NomeUF, ' possui ', ContarMunicipios(EncontrarUF(ArvoreUFs, NomeUF)^.ArvoreMunicipios), ' municípios.')  { Exibe o número de municípios }
        else
          writeln('UF não encontrada!');  { Caso a UF não seja encontrada }
        readln;  { Aguarda o usuário pressionar Enter para continuar }
      end;
      5:
      begin
        writeln('Remoção de Município');
        writeln('----------------------------');
        write('Digite a UF: ');
        readln(NomeUF);  { Lê o nome da UF }
        write('Digite o município a ser removido: ');
        readln(NomeMunicipio);  { Lê o nome do município a ser removido }
        if EncontrarUF(ArvoreUFs, NomeUF) <> nil then
          RemoverMunicipio(EncontrarUF(ArvoreUFs, NomeUF)^.ArvoreMunicipios, NomeMunicipio)  { Remove o município se a UF for encontrada }
        else
          writeln('UF não encontrada!');  { Caso a UF não seja encontrada }
        readln;  { Aguarda o usuário pressionar Enter para continuar }
      end;
    end;
  until Opcao = 6;  { O programa termina quando a opção 6 (Sair) é escolhida }
end.
