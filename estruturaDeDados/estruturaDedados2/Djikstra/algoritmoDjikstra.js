// Definição do grafo das cidades e distâncias
const grafo = {
    "Salete": { "Santa Teresinha": 79.2, "Witmarsum": 103.5, "Taió": 52.8, "Dona Ema": 39.6, "Pouso Redondo": 60 },
    "Santa Teresinha": { "Salete": 79.2, "Witmarsum": 18 },
    "Witmarsum": { "Santa Teresinha": 18, "Salete": 103.5, "Dona Ema": 14, "Pouso Redondo": 193.5 },
    "Dona Ema": { "Witmarsum": 14, "José Boiteux": 9, "Salete": 39.6, "Presidente Getúlio": 66 },
    "José Boiteux": { "Dona Ema": 9, "Presidente Getúlio": 40.5 },
    "Presidente Getúlio": { "José Boiteux": 40.5, "Ibirama": 39.6, "Rio do Oeste": 20, "Taió": 32,  "Dona Ema": 66 },
    "Ibirama": { "Presidente Getúlio": 39.6, "Lontras": 6 },
    "Lontras": { "Ibirama": 6, "Rio do Sul": 5, "Rio do Oeste": 10 },
    "Rio do Sul": { "Lontras": 5,  "Rio do Oeste": 8 },
    "Trombudo Central": { "Braço Trombudo": 5 },
    "Braço Trombudo": { "Trombudo Central": 5, "Rio do Oeste": 17 },
    "Pouso Redondo": { "Witmarsum": 193.5, "Rio do Oeste": 69, "Taió": 15, "Salete": 60 },
    "Mirim Doce": { "Taió": 27 },
    "Taió": { "Salete": 52.8, "Mirim Doce": 27, "Pouso Redondo": 15, "Rio do Oeste": 21,"Presidente Getúlio": 32 },
    "Rio do Oeste": { "Braço Trombudo": 17, "Pouso Redondo": 69, "Taió": 21, "Presidente Getúlio": 20, "Ibirama": 99, "Lontras": 10, "Rio do Sul": 8 }
}

// Função Inicializar
function inicializarCidades() {
    const cidades = Object.keys(grafo)
    const selectInicial = document.getElementById("cidadeInicial")
    const selectFinal = document.getElementById("cidadeFinal")

    cidades.forEach(cidade => {
        let optionInicial = document.createElement("option")
        optionInicial.value = cidade
        optionInicial.text = cidade
        selectInicial.add(optionInicial)

        let optionFinal = document.createElement("option")
        optionFinal.value = cidade
        optionFinal.text = cidade
        selectFinal.add(optionFinal)
    })
}

// Função de Dijkstra
function dijkstra(grafo, cidadeInicial, cidadeFinal) {
    let distancias = {}
    let visitadas = {}
    let antecessores = {}
    let filaDePrioridade = {}

    for (let cidade in grafo) {
        distancias[cidade] = Infinity
        visitadas[cidade] = false
    }
    distancias[cidadeInicial] = 0
    filaDePrioridade[cidadeInicial] = 0

    while (Object.keys(filaDePrioridade).length > 0) {
        let cidadeMaisProxima = obterCidadeMaisProxima(filaDePrioridade, distancias)
        delete filaDePrioridade[cidadeMaisProxima]
        visitadas[cidadeMaisProxima] = true

        for (let vizinho in grafo[cidadeMaisProxima]) {
            if (visitadas[vizinho]) continue
            let novaDistancia = distancias[cidadeMaisProxima] + grafo[cidadeMaisProxima][vizinho]
            if (novaDistancia < distancias[vizinho]) {
                distancias[vizinho] = novaDistancia
                antecessores[vizinho] = cidadeMaisProxima
                filaDePrioridade[vizinho] = novaDistancia
            }
        }
    }

    return construirCaminho(antecessores, cidadeInicial, cidadeFinal, distancias)
}

// Função para obter a cidade mais próxima da fila de prioridade
function obterCidadeMaisProxima(filaDePrioridade, distancias) {
    let menorDistancia = Infinity
    let cidadeMaisProxima = null
    for (let cidade in filaDePrioridade) {
        if (distancias[cidade] < menorDistancia) {
            menorDistancia = distancias[cidade]
            cidadeMaisProxima = cidade
        }
    }
    return cidadeMaisProxima
}

// Função para montar o caminho mais "curto"
function construirCaminho(antecessores, cidadeInicial, cidadeFinal, distancias) {
    let caminho = []
    let cidadeAtual = cidadeFinal

    while (cidadeAtual !== cidadeInicial) {
        caminho.unshift(cidadeAtual)
        cidadeAtual = antecessores[cidadeAtual]
    }

    caminho.unshift(cidadeInicial)
    return {
        caminho: caminho,
        distanciaTotal: distancias[cidadeFinal]
    }
}

// Função para exibir o caminho em uma árvore
function exibirArvoreCaminho(caminho, custos) {
    const arvoreDiv = document.getElementById("arvoreCaminho");
    arvoreDiv.innerHTML = ''; // Limpa a árvore anterior

    caminho.forEach((cidade, index) => {
        let caminhoItemDiv = document.createElement("div");
        caminhoItemDiv.classList.add("caminho-item");

        let cidadeDiv = document.createElement("div");
        cidadeDiv.classList.add("cidade");
        cidadeDiv.innerText = cidade;

        caminhoItemDiv.appendChild(cidadeDiv);

        if (index < caminho.length - 1) {
            let linhaDiv = document.createElement("div");
            linhaDiv.classList.add("linha");
            caminhoItemDiv.appendChild(linhaDiv);

            let custoDiv = document.createElement("div");
            custoDiv.classList.add("custo-caminho");
            custoDiv.innerText = `${custos[index]}`;
            caminhoItemDiv.appendChild(custoDiv);
        }

        arvoreDiv.appendChild(caminhoItemDiv);
    });
}

function exibirGrafoCusto(caminho, custos) {
    // Defina as posições fixas para os nós
    const posicoes = {
        "Salete": { x: 80, y: 120 },
        "Santa Teresinha": { x: 200, y: 20 },
        "Witmarsum": { x: 350, y: 70 },
        "Dona Ema": { x: 470, y: 150 },
        "José Boiteux": { x: 630, y: 100 },
        "Presidente Getúlio": { x: 750, y: 180 },
        "Ibirama": { x: 910, y: 250 },
        "Lontras": { x: 880, y: 390 },
        "Rio do Sul": { x: 775, y: 520 },
        "Trombudo Central": { x: 630, y: 630 },
        "Braço Trombudo": { x: 450, y: 630 },
        "Pouso Redondo": { x: 280, y: 550 },
        "Mirim Doce": { x: 150, y: 460 },
        "Taió": { x: 90, y: 300 },
        "Rio do Oeste": { x: 550, y: 500 }
    }      

    // Prepare os dados para o grafo
    let nodes = new vis.DataSet([]);
    let edges = new vis.DataSet([]);

    // Adiciona todos os nós e arestas do grafo
    let edgeIds = new Set(); // Conjunto para armazenar IDs únicos de arestas
    for (let cidade in grafo) {
        nodes.add({
            id: cidade,
            label: cidade,
            x: posicoes[cidade]?.x || 0, // Usa posição fixa se definida, senão 0
            y: posicoes[cidade]?.y || 0  // Usa posição fixa se definida, senão 0
        });
        for (let vizinho in grafo[cidade]) {
            let edgeId = `${cidade}-${vizinho}`;
            if (!edgeIds.has(edgeId)) {
                edges.add({
                    id: edgeId, // ID único da aresta
                    from: cidade,
                    to: vizinho,
                    label: `${grafo[cidade][vizinho]}`,
                    color: '#000000', // Cor padrão para arestas
                    arrows: 'to'
                });
                edgeIds.add(edgeId);
            }
        }
    }

    // Destaca o caminho mais curto
    for (let i = 0; i < caminho.length - 1; i++) {
        const cidadeAtual = caminho[i];
        const proximaCidade = caminho[i + 1];
        const edgeId = `${cidadeAtual}-${proximaCidade}`;
        edges.update({
            id: edgeId, // Atualiza a aresta com o ID correspondente
            color: { color: 'red', highlight: 'red' }, // Destaca o caminho mais curto
            width: 4 // Opcional: aumenta a largura da aresta destacada
        });
    }

    // Configurações do grafo
    let data = {
        nodes: nodes,
        edges: edges
    };
    let options = {
        nodes: {
            shape: 'dot',
            size: 20
        },
        edges: {
            width: 2,
            color: { inherit: true }
        },
        physics: {
            enabled: false // Desativa a física para que as posições sejam fixas
        }
    };

    // Cria o grafo
    let container = document.getElementById('grafoCusto');
    new vis.Network(container, data, options);
}

// Atualize a função calcularCaminho para chamar a função exibirGrafoCusto
function calcularCaminho() {
    const cidadeInicial = document.getElementById("cidadeInicial").value
    const cidadeFinal = document.getElementById("cidadeFinal").value

    if (cidadeInicial === cidadeFinal) {
        alert("A cidade inicial e final devem ser diferentes.")
        return
    }

    // Calcula o caminho e os custos
    const resultado = dijkstra(grafo, cidadeInicial, cidadeFinal)
    const custos = calcularCustosCaminho(resultado.caminho)

    exibirArvoreCaminho(resultado.caminho, custos)

    const totalCustoDiv = document.getElementById("totalCusto")
    totalCustoDiv.innerText = `Custo total: ${resultado.distanciaTotal.toFixed(2)}`

    exibirGrafoCusto(resultado.caminho, custos)
}

// Função para calcular os custos de cada trecho do caminho
function calcularCustosCaminho(caminho) {
    let custos = []
    for (let i = 0; i < caminho.length - 1; i++) {
        const cidadeAtual = caminho[i]
        const proximaCidade = caminho[i + 1]
        const custo = grafo[cidadeAtual][proximaCidade]
        custos.push(custo)
    }
    return custos
}

// Inicializa as cidades ao carregar a página
window.onload = inicializarCidades
