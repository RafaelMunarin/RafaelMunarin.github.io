Program softwareEstadio ;
const cIngresso = 333;
		  cFila = 10;
		  cLista = 1000;
		  cAmigo = 5;
type 	vFila = array[1..cFila]of string;
			vetIngresso = array[1..cIngresso]of string;
			vAmigo = array[1..cAmigo] of string;
			torcedor = record
				sNome : string;
				iIngressos : vAmigo;
				valorTotal : real;
			end;
			vLista = array[1..cLista] of torcedor;	
//
var rTorcedor : torcedor;
		lLista : vLista; 
		fCamarote,fOutros:vFila;
		vCamarote,vLateral,vGol:vetIngresso;
		fim,posi,i2,con :integer;
		sResposta,sAux:string;
		rValor,rArrecadamentoCam,rArrecadamentoLat,rArrecadamentoGol:real;

function cheia (fila:vFila;	Quant:integer):boolean;
begin
  if (fila[Quant] = '') then
     cheia:=false
  else   
		 cheia:=true;
end;

procedure adicionarFila(var pFila:vFila; pQuant:integer);
var sResposta:string;
		i:integer;
		lBoolean:boolean;
begin
	i:=1;
	if not cheia(pFila,pQuant) then begin
		writeln('Qual nome deseja adicionar?');
		readln(sResposta);
		lBoolean:=true;
		while (lBoolean = true)	do begin
			if (pFila[i] = '') then begin
				pFila[i]:=sResposta;
				lBoolean:=false;
			end else
				i:=i+1; 
		end;
	end else 
		writeln('Fila cheia!');			
end;

procedure moviFila(var Camarote,Outros:vFila; Fila:integer);
var sResposta1:string;
begin
	writeln('Deseja adicionar alguem na fila? (sim) ou (nao)');
	readln(sResposta1);
	if (sResposta1 = 'sim') then begin
		writeln('Deseja adicionar em qual fila? (camarotes = cam) ou (demais setores = outros)');
		readln(sResposta1);
		if (sResposta1 = 'cam') then 
			adicionarfila(Camarote,Fila)
			else if (sResposta1 = 'outros') then
				adicionarfila(Outros,Fila)
				else	
					writeln('Nao entedemos oque disse!');
	end;
end;

function vazia (fila:vFila):boolean;
begin
  if (fila[1] = '') then
     vazia:=true
  else   
		 vazia:=false;
end;

procedure removerFila(var fila:vFila; conFila:integer;recTorcedor:torcedor;var lista:vLista;var posic:integer);
var i:integer;
		lBoolean:boolean;
begin
	lBoolean:=true;
	i:=1;
	while (i < 1001) do begin
		if (lista[i].sNome = '') then begin
			recTorcedor.sNome:=fila[1];
			lista[i]:=recTorcedor;
			posic:=i;
			i:=1001;
		end else
			i:=i+1;			
	end;
	fila[1]:='';
	i:=2;
	while (lBoolean = true) do begin
		fila[i-1]:=fila[i];
		if (i	= conFila) then begin
			fila[i]:='';
		  lBoolean:=false;
		end;
		i:=i+1;
	end;
end;

procedure adicionarNomeNaPilha(cIngre:integer;var vet:vetIngresso;var l:vLista;var controle,p,posica:integer);
var i:integer;                
begin
	i:=cIngre;  
	while (i > 0) do begin
		if (vet[i]='') then begin
			if (controle = 1) then
				vet[i]:=l[posica].sNome
				else 
					vet[i]:=l[posica].iIngressos[p];			
			writeln('Seu ingresso foi adicionado, o numero dele :',i);	
			i:=-1;                     
		end else
			i:=i-1;
	end;
	if (i = 0)then
		writeln('Ingressos lotados');
end;

procedure atendimento(aValor:real;recTorcedor:torcedor;var lista:vLista;var posic:integer;cIngre:integer;var rArr:real;var vetor:vetIngresso);
var cont,p:integer;
begin
	writeln(lista[posic].sNome);
	recTorcedor.sNome:=lista[posic].sNome;	
	recTorcedor.ValorTotal:=aValor;
	lista[posic]:=recTorcedor;
	rArr:=rArr+aValor;
	cont:=1;	
	adicionarNomeNaPilha(cIngre,vetor,lista,cont,p,posic);
end;

function exibir():Boolean;
begin
	writeln('VALORES');
	writeln('            Camarote = 150,00');
	writeln('            Atras do Gol = 50,00');
	writeln('            Lateral do campo = 80,00');
	exibir:=true;
end;

procedure adicionarAmigo(var aValor,rArr:real;recTorcedor:torcedor;var lista:vLista; posic,cIngre:integer;var i:integer;var vetor:vetIngresso);
var stResposta:string;
		cont,p:integer;  
begin
	writeln('Qual o nome dele?');
	readln(stResposta);	
	lista[posic].ValorTotal:=lista[posic].Valortotal+aValor;
	lista[posic].iIngressos[i]:=stResposta;
	rArr:=rArr+aValor;
	cont:=2;
	p:=i;
	adicionarNomeNaPilha(cIngre,vetor,lista,cont,p,posic);
end;

procedure amigo (stAux:string ;recTorcedor2:torcedor;var llLista:vLista; po,cIng:integer;var i3:integer;var rArrecCam,rArrecGol,rArrecLat:real;var vCamarot,vGo,vLatera:vetIngresso);
var stResposta:string;
		lBoolean:boolean;
		valor:real;
		i:integer;
begin
	lBoolean:=true;
	while (lBoolean = true) do begin
		if (i < 5) then begin
			writeln('Deseja adicionar algum amigo na compra? (sim) ou (nao)');
			readln(stResposta);					    
		end;
		if (stResposta = 'sim') and (i < 5) then begin
			if (stAux = 'cam') then begin
				Valor:=150;
        adicionarAmigo(Valor,rArrecCam,recTorcedor2,llLista,po,cIng,i3,vCamarote);
  			writeln('Adicionado ingresso no CAMAROTE!');
      end else if (stAux = 'outros') then begin
				writeln('Em qual modalidade? gol ou lateral');
				readln(stResposta);
				if (stResposta = 'gol') then begin
					Valor:=50;
					adicionarAmigo(Valor,rArrecGol,recTorcedor2,llLista,po,cIng,i3,vGo);
					writeln('Adicionado ingresso no GOL!');
				end else if (stResposta = 'lateral') then begin
					Valor:=80;
					adicionarAmigo(Valor,rArrecLat,recTorcedor2,llLista,po,cIng,i3,vLatera);
					writeln('Adicionado ingresso na LATERAL!!');
				end;
			end;
			i:=i+1;
			i3:=i3+1;
		end else
			lBoolean:=false;
	end;
end;

procedure consultarFila(fila:vFila;constante,consulta:integer);
var i:integer;
begin
	if (consulta = 1 ) then
		writeln('Fila do Camarote')
		else
			writeln('Fila dos outros');
	for i:=1 to constante do
		writeln('[ ',fila[i],' ]');
	writeln('------------------------------------')
end;

function exibirLista(flista:vLista;fconLis:integer):Boolean;
var i,c:integer;
begin
	i:=1;
	while (i <=fconLis) do begin
		if (fLista[1].sNome = '') then begin
			writeln('Lista vazia');
			i:=fconLis+1;
		end else if (fLista[i].sNome <> '') then begin
			writeln('NOME :',fLista[i].sNome);
			for c:=1 to 5 do
				writeln('     Amigos Comprados:',fLista[i].iIngressos[c]);
			writeln('     Valor total gasto:',fLista[i].ValorTotal:2:2);
			i:=i+1;
		end else if (fLista[i].sNome = '') then
			i:=fconLis+1;
	end;
	exibirLista:=true;
end;

function exibirArr(arreca:real;resposta:string):boolean;
begin
	writeln('-------------------------------------');
	writeln('Total arrecadado no ');
	if (resposta = '2')	then
		writeln('CAMAROTE foi de :',arreca)
	else 	if (resposta = '3')	then
		writeln('GOL foi de :',arreca)
	else 	if (resposta = '4')	then
		writeln('Lateral foi de :',arreca);
	writeln('-------------------------------------');
	exibirArr:=false;
end; 

function exibirIng(vetoriq:vetIngresso; conIn:integer):boolean;
var i:integer;
begin
	i:=333;
	while (i <= conIn) do begin
		if (vetoriq[333] = '')	then begin
			writeln('Nenhum ingresso comprado');
			i:=conIn + 1;
		end else if (vetoriq[i] <> '') then begin
			writeln('Ingresso ',i, ' titular :',vetoriq[i]);
			i:=i-1;
		end else if (vetoriq[i] = '') then
			i:=conIn + 1 ;	
	end;
	exibirIng:=false;
end;

function exibirIngresso(vetori:vetIngresso; resposta:string; conIn:integer):boolean;
begin
	writeln('----------------------------------');	
	exibirIng(vetori,conIn);	
	writeln('----------------------------------');
	exibirIngresso:=true;		
end; 

procedure exibicao (lista:vLista; rArrCam,rArrGol,rArrLat:real; conIng,conLis:integer; vCa,vG,vLa:vetIngresso);
var stResposta:string;
		lBoolean:boolean;
begin
	lBoolean:=true;
	while (lBoolean = true) do begin
		writeln('Deseja fazer alguma exibicao? (sim para fazer a exibicao)');
		readln(stResposta);
		if (stResposta = 'sim') then begin
			writeln('Deseja exibir : Lista de compradores =          1');
			writeln('                Arrecadamento do Camarote =    2');
			writeln('                Arrecadamento do Gol =         3');
			writeln('                Arrecadamento do Lateral =     4');
			writeln('                Lista de ingressos Camarote =  5');
			writeln('                Lista de ingressos Gol =       6');
			writeln('                Lista de ingressos Lateral =   7');	
			readln(stResposta);
			if (stResposta = '1')	then 
				exibirLista(lista,conLis)
			else if (stResposta = '2')	then 
				exibirArr(rArrCam,stResposta)
			else if (stResposta = '3')	then 
				exibirArr(rArrGol,stResposta)
			else if (stResposta = '4')	then 
				exibirArr(rArrLat,stResposta)
			else if (stResposta = '5')	then 
				exibirIngresso(vCa,stResposta,conIng)
			else if (stResposta = '6')	then 
				exibirIngresso(vG,stResposta,conIng)				
			else if (stResposta = '7')	then 
				exibirIngresso(vLa,stResposta,conIng);
		end else
			lBoolean:=false;
	end;
end;

Begin
	while (fim < 1) do begin
		exibicao(lLista,rArrecadamentoCam,rArrecadamentoGol,rArrecadamentoLat,cIngresso,cLista,vCamarote,vGol,vLateral);
		con:=1;
		consultarFila(fCamarote,cFila,con);
		con:=2;
		consultarFila(fOutros,cFila,con);
		moviFila(fCamarote,fOutros,cFila);
		writeln('Gostaria de continuar ou atender alguem (sim para atender)  ou  (sair para sair)!');
		readln(sResposta);
		if (sResposta = 'sim') then begin
			exibir;
			writeln('De qual fila? (camarote = cam) ou (demais setores = outros)');
			readln(sResposta);
			if (sResposta = 'cam') then	begin
				if not vazia(fCamarote) then begin	
			  	removerFila(fCamarote,cFila,rTorcedor,lLista,posi);
			  	rValor:=150;
			    atendimento(rValor,rTorcedor,lLista,posi,cIngresso,rArrecadamentoCam,vCamarote);
			    i2:=1;
			    sAux:='cam';
			    amigo(sAux,rTorcedor,lLista,posi,cIngresso,i2,rArrecadamentoCam,rArrecadamentoGol,rArrecadamentoLat,vCamarote,vGol,vLateral);
			    writeln('A compra foi de ', lLista[posi].ValorTotal:5:2);
				end else
					writeln('A fila esta vazia');
		  end else if (sResposta = 'outros') then begin
				if not vazia(fOutros) then begin
					removerFila(fOutros,cFila,rTorcedor,lLista,posi);
					exibir;
					writeln('Deseja  comprar (gol) ou (lateral)');	
					readln(sResposta);
					sAux:='outros';
					if (sResposta = 'gol') then begin				
						rValor:=50;
				   	atendimento(rValor,rTorcedor,lLista,posi,cIngresso,rArrecadamentoGol,vGol);
				 	  i2:=1;
				    amigo(sAux,rTorcedor,lLista,posi,cIngresso,i2,rArrecadamentoCam,rArrecadamentoGol,rArrecadamentoLat,vCamarote,vGol,vLateral);
				    writeln('A compra foi de ', lLista[posi].ValorTotal:5:2);	
					end else if (sResposta = 'lateral') then begin
						rValor:=80;
				   	atendimento(rValor,rTorcedor,lLista,posi,cIngresso,rArrecadamentoLat,vLateral);
				  	i2:=1;
						amigo(sAux,rTorcedor,lLista,posi,cIngresso,i2,rArrecadamentoCam,rArrecadamentoGol,rArrecadamentoLat,vCamarote,vGol,vLateral);
						writeln('A compra foi de ', lLista[posi].ValorTotal:5:2);
					end else
						writeln('Nao conseguimos identificar oque disse, entre novamente na fila!');
				end else
						writeln('A fila esta vazia');	
			end;
		end else if (sResposta = 'sair') then
			fim:=1;
	end;
End.                                                                                                                                                                                                                                                                             