//Alunos José Marquez, Rafael Munarin

Program Atv_03_Atividade_Prova;

const
  LINHAS = 10;

procedure GerarTrianguloPascal;
var
  triangulo: array[0..LINHAS-1, 0..LINHAS-1] of integer;
  i, j: integer;
begin
  for i := 0 to LINHAS - 1 do
  begin
    triangulo[i, 0] := 1;
    for j := 1 to i do
      triangulo[i, j] := triangulo[i - 1, j - 1] + triangulo[i - 1, j];
  end;

  for i := 0 to LINHAS - 1 do
  begin
    write(i, ' ');
    for j := 0 to i do
      write(triangulo[i, j], ' ');
    writeln;
  end;
end;

begin
  GerarTrianguloPascal;
end.