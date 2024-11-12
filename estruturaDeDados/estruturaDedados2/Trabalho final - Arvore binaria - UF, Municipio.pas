program ArvoreBinariaUF;

{ALUNOS: Rafael Munarin, Marcion Demarchi}

{ Declara��o de tipos para n�s das �rvores de munic�pios e de UFs }
type
  PonteiroMunicipio = ^NoMunicipio;       { Ponteiro para o n� de munic�pio }
  NoMunicipio = record
    NomeMunicipio: string;                { Nome do munic�pio }
    Esq, Dir: PonteiroMunicipio;          { Ponteiros para filhos � esquerda e � direita }
  end;
  
  PonteiroUF = ^NoUF;                     { Ponteiro para o n� de UF }
  NoUF = record
    NomeUF: string;                       { Nome da UF }
    Esq, Dir: PonteiroUF;                 { Ponteiros para filhos � esquerda e � direita }
    ArvoreMunicipios: PonteiroMunicipio;  { Ponteiro para a �rvore bin�ria de munic�pios }
  end;

{ Fun��o para criar um novo n� de munic�pio }
function CriarMunicipio(Nome: string): PonteiroMunicipio;
var
  NovoNo: PonteiroMunicipio;
begin
  new(NovoNo);                             { Aloca mem�ria para o novo n� de munic�pio }
  NovoNo^.NomeMunicipio := Nome;           { Define o nome do munic�pio }
  NovoNo^.Esq := nil;                      { Inicializa os ponteiros para filhos como nil }
  NovoNo^.Dir := nil;
  CriarMunicipio := NovoNo;                { Retorna o novo n� criado }
end;

{ Procedimento para inserir um munic�pio na �rvore de munic�pios }
procedure InserirMunicipio(var Arvore: PonteiroMunicipio; Nome: string);
begin
  if Arvore = nil then
    Arvore := CriarMunicipio(Nome)               { Insere o munic�pio na raiz se a �rvore estiver vazia }
  else if Nome < Arvore^.NomeMunicipio then
    InserirMunicipio(Arvore^.Esq, Nome)          { Insere no lado esquerdo se for menor }
  else
    InserirMunicipio(Arvore^.Dir, Nome);         { Insere no lado direito se for maior }
end;

{ Procedimento para inserir uma UF e seu munic�pio associado na �rvore de UFs }
procedure InserirUF(var Arvore: PonteiroUF; NomeUF: string; NomeMunicipio: string);
begin
  if Arvore = nil then
  begin
    new(Arvore);                                   { Aloca mem�ria para o novo n� de UF }
    Arvore^.NomeUF := NomeUF;                      { Define o nome da UF }
    Arvore^.Esq := nil;                            { Inicializa os ponteiros para filhos como nil }
    Arvore^.Dir := nil;
    Arvore^.ArvoreMunicipios := nil;               { Inicializa a �rvore de munic�pios como nil }
    InserirMunicipio(Arvore^.ArvoreMunicipios, NomeMunicipio); { Insere o munic�pio na �rvore de munic�pios da UF }
  end
  else if NomeUF < Arvore^.NomeUF then
    InserirUF(Arvore^.Esq, NomeUF, NomeMunicipio)  { Insere a UF no lado esquerdo se for menor }
  else if NomeUF > Arvore^.NomeUF then
    InserirUF(Arvore^.Dir, NomeUF, NomeMunicipio)  { Insere a UF no lado direito se for maior }
  else
    InserirMunicipio(Arvore^.ArvoreMunicipios, NomeMunicipio); { Se a UF j� existe, insere o munic�pio na �rvore de munic�pios }
end;

{ Procedimento para exibir a �rvore de munic�pios em ordem }
procedure MostrarMunicipios(Arvore: PonteiroMunicipio);
begin
  if Arvore <> nil then
  begin
    MostrarMunicipios(Arvore^.Esq);              { Exibe os n�s do lado esquerdo }
    writeln('   ', Arvore^.NomeMunicipio);       { Exibe o nome do munic�pio }
    MostrarMunicipios(Arvore^.Dir);              { Exibe os n�s do lado direito }
  end;
end;

{ Procedimento para exibir a �rvore de UFs e seus munic�pios }
procedure MostrarUFsCompleto(Arvore: PonteiroUF);
begin
  if Arvore <> nil then
  begin
    MostrarUFsCompleto(Arvore^.Esq);             { Exibe as UFs do lado esquerdo }
    writeln('UF: ', Arvore^.NomeUF);             { Exibe o nome da UF }
    writeln('Munic�pios:');
    MostrarMunicipios(Arvore^.ArvoreMunicipios); { Exibe a �rvore de munic�pios da UF }
    writeln('-------------------------');
    MostrarUFsCompleto(Arvore^.Dir);             { Exibe as UFs do lado direito }
  end;
end;

{ Procedimento para exibir apenas a �rvore de UFs }
procedure MostrarUFsSomente(Arvore: PonteiroUF);
begin
  if Arvore <> nil then
  begin
    MostrarUFsSomente(Arvore^.Esq);              { Exibe as UFs do lado esquerdo }
    writeln('UF: ', Arvore^.NomeUF);             { Exibe o nome da UF }
    MostrarUFsSomente(Arvore^.Dir);              { Exibe as UFs do lado direito }
  end;
end;

{ Fun��o para contar o n�mero de munic�pios em uma �rvore de munic�pios }
function ContarMunicipios(Arvore: PonteiroMunicipio): integer;
begin
  if Arvore = nil then
    ContarMunicipios := 0                        { Retorna 0 se a �rvore estiver vazia }
  else
    ContarMunicipios := 1 + ContarMunicipios(Arvore^.Esq) + ContarMunicipios(Arvore^.Dir); { Conta todos os n�s recursivamente }
end;

{ Procedimento para remover um munic�pio da �rvore de munic�pios, apenas se for folha }
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
    { Verifica se o n� � uma folha, pois s� � permitido remover n�s folha }
    if (Arvore^.Esq = nil) and (Arvore^.Dir = nil) then
    begin
      dispose(Arvore);                            { Libera o n� }
      Arvore := nil;                               { A �rvore agora aponta para nil, removendo o n� }
      writeln('Munic�pio removido com sucesso!');    { Mensagem de sucesso na remo��o }
    end
    else
    begin
      writeln('Erro: s� � poss�vel remover munic�pios que s�o folhas!');  { Se n�o for folha, erro }
      writeln('Estrutura atual da �rvore de munic�pios para essa UF:');
      MostrarMunicipios(Arvore);                   { Exibe a estrutura atual da �rvore de munic�pios }
    end;
  end;
end;

{ Fun��o para encontrar uma UF na �rvore de UFs }
function EncontrarUF(Arvore: PonteiroUF; NomeUF: string): PonteiroUF;
begin
  if Arvore = nil then
    EncontrarUF := nil                            { Retorna nil se a UF n�o for encontrada }
  else if NomeUF = Arvore^.NomeUF then
    EncontrarUF := Arvore                         { Retorna o n� se encontrar a UF }
  else if NomeUF < Arvore^.NomeUF then
    EncontrarUF := EncontrarUF(Arvore^.Esq, NomeUF)  { Procura no lado esquerdo }
  else
    EncontrarUF := EncontrarUF(Arvore^.Dir, NomeUF); { Procura no lado direito }
end;

{ Vari�veis globais e programa principal }
var
  ArvoreUFs: PonteiroUF;  { �rvore que armazena todas as UFs }
  NomeUF, NomeMunicipio: string;  { Vari�veis para armazenar o nome da UF e do munic�pio }
  Opcao: integer;  { Vari�vel para armazenar a escolha do usu�rio no menu }
begin
  ArvoreUFs := nil;  { Inicializa a �rvore de UFs como vazia }
  repeat
    ClrScr;  { Limpa a tela antes de exibir o menu }
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
    readln(Opcao);  { L� a escolha do usu�rio }
    ClrScr;  { Limpa a tela ap�s a escolha do usu�rio }

    case Opcao of
      1:
      begin
        writeln('Inser��o de UF e Munic�pio');
        writeln('----------------------------');
        write('Digite a UF: ');
        readln(NomeUF);  { L� o nome da UF }
        write('Digite o munic�pio: ');
        readln(NomeMunicipio);  { L� o nome do munic�pio }
        InserirUF(ArvoreUFs, NomeUF, NomeMunicipio);  { Insere UF e Munic�pio na �rvore }
        writeln('Munic�pio inserido com sucesso!');  { Confirma a inser��o }
        readln;  { Aguarda o usu�rio pressionar Enter para continuar }
      end;
      2:
      begin
        writeln('�rvore de UFs e Munic�pios');
        writeln('----------------------------');
        MostrarUFsCompleto(ArvoreUFs);               { Exibe toda a �rvore de UFs e Munic�pios }
        readln;  { Aguarda o usu�rio pressionar Enter para continuar }
      end;
      3:
      begin
        writeln('�rvore de UFs (somente UFs)');
        writeln('----------------------------');
        MostrarUFsSomente(ArvoreUFs);                { Exibe apenas a �rvore de UFs }
        readln;  { Aguarda o usu�rio pressionar Enter para continuar }
      end;
      4:
      begin
        writeln('Contagem de Munic�pios em uma UF');
        writeln('----------------------------');
        write('Digite a UF: ');
        readln(NomeUF);  { L� o nome da UF para contar seus munic�pios }
        if EncontrarUF(ArvoreUFs, NomeUF) <> nil then
          writeln('A UF ', NomeUF, ' possui ', ContarMunicipios(EncontrarUF(ArvoreUFs, NomeUF)^.ArvoreMunicipios), ' munic�pios.')  { Exibe o n�mero de munic�pios }
        else
          writeln('UF n�o encontrada!');  { Caso a UF n�o seja encontrada }
        readln;  { Aguarda o usu�rio pressionar Enter para continuar }
      end;
      5:
      begin
        writeln('Remo��o de Munic�pio');
        writeln('----------------------------');
        write('Digite a UF: ');
        readln(NomeUF);  { L� o nome da UF }
        write('Digite o munic�pio a ser removido: ');
        readln(NomeMunicipio);  { L� o nome do munic�pio a ser removido }
        if EncontrarUF(ArvoreUFs, NomeUF) <> nil then
          RemoverMunicipio(EncontrarUF(ArvoreUFs, NomeUF)^.ArvoreMunicipios, NomeMunicipio)  { Remove o munic�pio se a UF for encontrada }
        else
          writeln('UF n�o encontrada!');  { Caso a UF n�o seja encontrada }
        readln;  { Aguarda o usu�rio pressionar Enter para continuar }
      end;
    end;
  until Opcao = 6;  { O programa termina quando a op��o 6 (Sair) � escolhida }
end.
