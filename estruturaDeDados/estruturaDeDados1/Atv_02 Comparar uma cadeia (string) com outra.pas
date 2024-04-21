program ContagemCadeias;

const
  tam_max_texto = 255;
  tam_max_segundo_texto = 20;

var
  primeiraCadeia, segundaCadeia: string;
  contador: integer;

// procedure que vai ler a string (cadeia 01) 
procedure lerString(var str: string);
begin
  writeln('Digite a cadeia de caracteres (max 255 caracteres): ');
  readln(str);
end;

// procedure que vai ler a string (cadeia 02) 
procedure lerSegundaCadeia(var texto: string);
begin
  repeat
    writeln('Digite a segunda cadeia (maior que 1 e menor que 20 caracteres): ');
    readln(texto);
  until (Length(texto) > 1) and (Length(texto) < tam_max_segundo_texto);
end;

//function que vai realizar a comparação das duas cadeias
function contarOcorrencias(primeira, segunda: string): integer;
var
  i, j, contador: integer;
begin
  contador := 0;
  for i := 1 to Length(primeira) - Length(segunda) + 1 do
  begin
    j := 1;
    while (j <= Length(segunda)) and (primeira[i + j - 1] = segunda[j]) do
      Inc(j);

    if j > Length(segunda) then
      Inc(contador);
  end;
  contarOcorrencias := contador;
end;

begin
  lerString(primeiraCadeia);
  lerSegundaCadeia(segundaCadeia);

  contador := contarOcorrencias(primeiraCadeia, segundaCadeia);

  writeln('A segunda cadeia aparece ', contador, ' vezes na primeira cadeia.');
end.
