//Alunos José Marquez, Rafael Munarin

Program Atv_02_Atividade_Prova;

const
  MAX = 100;

type
  Matriz = array[1..MAX, 1..MAX] of integer;

procedure PreencherMatriz(var A: Matriz; N: integer);
var
  i, j: integer;
begin
  writeln('Digite os elementos da matriz:');
  for i := 1 to N do
    for j := 1 to N do
    begin
      write('Matriz[', i, '][', j, ']: ');
      readln(A[i, j]);
    end;
end;

procedure EncontrarPontoCela(A: Matriz; N: integer);
var
  i, j, k: integer;
  ehPontoCela: boolean;
begin
  writeln('Os pontos cela na matriz são:');
  for i := 1 to N do
    for j := 1 to N do
    begin
      ehPontoCela := true;

      // Verifica se A[i, j] é o maior da linha
      for k := 1 to N do
        if A[i, j] < A[i, k] then
          ehPontoCela := false;

      // Verifica se A[i, j] é o maior da coluna
      for k := 1 to N do
        if A[i, j] < A[k, j] then
          ehPontoCela := false;

      // Se A[i, j] é ponto cela, exibe suas coordenadas
      if ehPontoCela then
        writeln('(', i, ',', j, ')');
    end;
end;

var
  A: Matriz;
  N: integer;

begin
  writeln('Digite a ordem da matriz (N x N): ');
  readln(N);

  PreencherMatriz(A, N);
  EncontrarPontoCela(A, N);
end.
