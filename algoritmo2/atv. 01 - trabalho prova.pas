//Alunos José Marquez, Rafael Munarin

Program Atv_01_Atividade_Prova;

type
    vetor = array [1..100] of integer;

procedure leVetor(var vetorA: vetor; var N: integer);
var
    i: integer;
begin
    writeln('Digite o tamanho do vetor A: ');
    readln(N);

    for i := 1 to N do
    begin
        writeln('Digite o elemento ', i, ' do vetor A: ');
        readln(vetorA[i]);
    end;
end;

procedure gerarVetorB(var vetorA: vetor; N: integer; var vetorB: vetor; var M: integer);
var
    i, j: integer;
    encontrado: boolean;
begin
    M := 0;
    for i := 1 to N do
    begin
        encontrado := false;
        for j := 1 to M do
        begin
            if (vetorA[i] = vetorB[j]) then
            begin
                encontrado := true;
                break;
            end;
        end;

        if not encontrado then
        begin
            M := M + 1;
            vetorB[M] := vetorA[i];
        end;
    end;
end;

procedure imprimirVetorB(var vetorB: vetor; M: integer);
var
    i: integer;
begin
    writeln('O vetor B sem elementos repetidos eh: ');
    for i := 1 to M do
    begin
        write(vetorB[i], ' ');
    end;
    writeln;
end;

var
    vetorA: vetor;
    vetorB: vetor;
    N, M: integer;
begin
    leVetor(vetorA, N);
    gerarVetorB(vetorA, N, vetorB, M);
    imprimirVetorB(vetorB, M);
end.
