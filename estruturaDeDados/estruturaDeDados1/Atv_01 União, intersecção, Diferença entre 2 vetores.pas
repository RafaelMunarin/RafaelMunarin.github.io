program Vetores;

type
    vet = array[1..100] of integer;
var
    A, B, uniao, interseccao, diferenca: vet;
    nr_A, nr_B, nr_Uniao, nr_Inter, nr_Dif: integer;

// function que verifica se o vetor x pertenec ao vetor V e retorno verdadeiro ou falso;
function pertence(V: vet; n: integer; x: integer): boolean;
var
    i: integer;
begin
    i := 1;
    while (i <= n) and (V[i] <> x) do
        i := i + 1;
    pertence := i <= n;
end;

// procedure para ver/escrever o vetor
procedure ler_Vet(var V: vet; var n: integer);
var
    i: integer;
begin
    write('Informe tamanho do vetor que receberá os n?meros: ');
    readln(n);
    for i := 1 to n do
    begin
        V[i]:= random(30);
        write('Elemento ', i, ': ' , (V[i]));
        writeln;    
    end;
    writeln;
end;

// procedure que vai fazer a união dos dois vetores
procedure uniao_Vet(A, B: vet; nr_A, nr_B: integer; var U: vet; var nr_U: integer);
var
    i: integer;
begin
    for i := 1 to nr_A do
        U[i] := A[i];
    nr_U := nr_A;
    for i := 1 to nr_B do
        if not pertence(U, nr_U, B[i]) then
        begin
            nr_U := nr_U + 1;
            U[nr_U] := B[i];
        end;
end;

// procedure que vai fazer a intersecção dos dois vetores
procedure interseccao_Vet(A, B: vet; nr_A, nr_B: integer; var I: vet; var nr_I: integer);
var
    j: integer;
begin
    nr_I := 0;
    for j := 1 to nr_A do
        if pertence(B, nr_B, A[j]) then
        begin
            nr_I := nr_I + 1;
            I[nr_I] := A[j];
        end;
end;

// procedure que vai fazer a diferença dos dois vetores
procedure diferenca_Vet(A, B: vet; nr_A, nr_B: integer; var D: vet; var nr_D: integer);
var
    j: integer;
begin                                                                                          nr_D := 0;
    for j := 1 to nr_A do
        if not pertence(B, nr_B, A[j]) then
        begin
            nr_D := nr_D + 1;
            D[nr_D] := A[j];
        end;
end;

// procedure que vai escrever o fetor final
procedure escrever_Vet(V: vet; n: integer);
var
    i: integer;
begin
    for i := 1 to n do
        write(V[i], ' ');
    writeln;
end;

begin
    writeln('Vetor A:');
    ler_Vet(A, nr_A);
    writeln('Vetor B:');
    ler_Vet(B, nr_B);
    uniao_Vet(A, B, nr_A, nr_B, uniao, nr_Uniao);
    interseccao_Vet(A, B, nr_A, nr_B, interseccao, nr_Inter);
    diferenca_Vet(A, B, nr_A, nr_B, diferenca, nr_Dif);
    writeln('União:');
    escrever_Vet(uniao, nr_Uniao);
    writeln;
    writeln('Intersecção:');   
    escrever_Vet(interseccao, nr_Inter);
    writeln;
    writeln('Diferença:');
    escrever_Vet(diferenca, nr_Dif);
end.