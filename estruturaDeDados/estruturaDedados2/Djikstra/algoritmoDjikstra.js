/* Alunos: Márcio A. Demarchi, Rafael B. Munarin */

// Definição do grafo das cidades e distâncias
const grafo = {
    "Salete": { "Santa Teresinha": 79.2, "Witmarsum": 103.5, "Taió": 52.8, "Dona Ema": 39.6, "Pouso Redondo": 60 },
    "Santa Teresinha": { "Salete": 79.2, "Witmarsum": 18 },
    "Witmarsum": { "Santa Teresinha": 18, "Salete": 103.5, "Dona Ema": 14, "Pouso Redondo": 193.5 },
    "Dona Ema": { "Witmarsum": 14, "José Boiteux": 9, "Salete": 39.6, "Presidente Getúlio": 66 },
    "José Boiteux": { "Dona Ema": 9, "Presidente Getúlio": 40.5 },
    "Presidente Getúlio": { "José Boiteux": 40.5, "Ibirama": 39.6, "Rio do Oeste": 20, "Taió": 32, "Dona Ema": 66 },
    "Ibirama": { "Presidente Getúlio": 39.6, "Lontras": 6 },
    "Lontras": { "Ibirama": 6, "Rio do Sul": 5, "Rio do Oeste": 10 },
    "Rio do Sul": { "Lontras": 5, "Rio do Oeste": 8 },
    "Trombudo Central": { "Braço Trombudo": 5 },
    "Braço Trombudo": { "Trombudo Central": 5, "Rio do Oeste": 17 },
    "Pouso Redondo": { "Witmarsum": 193.5, "Rio do Oeste": 69, "Taió": 15, "Salete": 60 },
    "Mirim Doce": { "Taió": 27 },
    "Taió": { "Salete": 52.8, "Mirim Doce": 27, "Pouso Redondo": 15, "Rio do Oeste": 21, "Presidente Getúlio": 32 },
    "Rio do Oeste": { "Braço Trombudo": 17, "Pouso Redondo": 69, "Taió": 21, "Presidente Getúlio": 20, "Ibirama": 99, "Lontras": 10, "Rio do Sul": 8 }
}

// Função para inicializar as cidades nos elementos <select>
function inicializarCidades() {
    // Obtém todas as cidades como chaves do grafo
    const cidades = Object.keys(grafo)
    // Obtém referências aos elementos <select> para cidades inicial e final
    const selectInicial = document.getElementById("cidadeInicial")
    const selectFinal = document.getElementById("cidadeFinal")

    // Para cada cidade, cria um elemento <option> e adiciona aos selects
    cidades.forEach(cidade => {
        let option = document.createElement("option") // Cria um novo elemento <option>
        option.value = cidade // Define o valor como o nome da cidade
        option.text = cidade // Define o texto visível como o nome da cidade
        selectInicial.add(option.cloneNode(true)) // Adiciona ao select inicial
        selectFinal.add(option) // Adiciona ao select final
    });
}

// Função para calcular o caminho mais curto usando o algoritmo de Dijkstra
function dijkstra(grafo, cidadeInicial, cidadeFinal) {
    let distancias = {} // Armazena as distâncias mínimas até cada cidade
    let visitadas = {} // Marca as cidades visitadas
    let antecessores = {} // Armazena a cidade anterior no caminho
    let filaDePrioridade = {} // Fila de prioridade para as cidades a serem visitadas

    // Inicializa distâncias e visitadas
    for (let cidade in grafo) {
        distancias[cidade] = Infinity // Define a distância inicial como infinita
        visitadas[cidade] = false // Marca todas as cidades como não visitadas
    }
    distancias[cidadeInicial] = 0 // A distância da cidade inicial para ela mesma é 0
    filaDePrioridade[cidadeInicial] = 0 // Adiciona a cidade inicial à fila de prioridade

    // Enquanto houver cidades na fila de prioridade
    while (Object.keys(filaDePrioridade).length > 0) {
        let cidadeMaisProxima = obterCidadeMaisProxima(filaDePrioridade, distancias) // Obtém a cidade mais próxima
        delete filaDePrioridade[cidadeMaisProxima] // Remove da fila de prioridade
        visitadas[cidadeMaisProxima] = true // Marca como visitada

        // Para cada vizinho da cidade mais próxima
        for (let vizinho in grafo[cidadeMaisProxima]) {
            if (visitadas[vizinho]) continue // Se já foi visitada, ignora

            // Calcula nova distância para o vizinho
            let novaDistancia = distancias[cidadeMaisProxima] + grafo[cidadeMaisProxima][vizinho]
            // Se a nova distância é menor que a já registrada
            if (novaDistancia < distancias[vizinho]) {
                distancias[vizinho] = novaDistancia // Atualiza a distância
                antecessores[vizinho] = cidadeMaisProxima // Define a cidade atual como antecessor
                filaDePrioridade[vizinho] = novaDistancia // Adiciona à fila de prioridade
            }
        }
    }

    // Constrói e retorna o caminho mais curto e a distância total
    return construirCaminho(antecessores, cidadeInicial, cidadeFinal, distancias)
}

// Função para obter a cidade mais próxima da fila de prioridade
function obterCidadeMaisProxima(filaDePrioridade, distancias) {
    let menorDistancia = Infinity // Inicializa com uma distância alta
    let cidadeMaisProxima = null // Cidade mais próxima

    // Itera sobre a fila de prioridade
    for (let cidade in filaDePrioridade) {
        // Se a distância é menor que a menor encontrada
        if (distancias[cidade] < menorDistancia) {
            menorDistancia = distancias[cidade] // Atualiza a menor distância
            cidadeMaisProxima = cidade // Atualiza a cidade mais próxima
        }
    }
    return cidadeMaisProxima; // Retorna a cidade mais próxima
}

// Função para montar o caminho mais curto a partir dos antecessores
function construirCaminho(antecessores, cidadeInicial, cidadeFinal, distancias) {
    let caminho = [] // Armazena o caminho
    let cidadeAtual = cidadeFinal // Começa pela cidade final

    // Enquanto não chegar à cidade inicial
    while (cidadeAtual !== cidadeInicial) {
        caminho.unshift(cidadeAtual) // Adiciona a cidade atual no início do caminho
        cidadeAtual = antecessores[cidadeAtual] // Move para o antecessor
    }

    caminho.unshift(cidadeInicial) // Adiciona a cidade inicial
    return {
        caminho: caminho, // Retorna o caminho encontrado
        distanciaTotal: distancias[cidadeFinal] // Retorna a distância total
    };
}

// Função para exibir o caminho em uma árvore na interface
function exibirArvoreCaminho(caminho, custos) {
    const arvoreDiv = document.getElementById("arvoreCaminho") // Obtém a div para exibir o caminho
    arvoreDiv.innerHTML = '' // Limpa a árvore anterior

    // Para cada cidade no caminho
    caminho.forEach((cidade, index) => {
        let caminhoItemDiv = document.createElement("div") // Cria um novo elemento para a cidade
        caminhoItemDiv.classList.add("caminho-item") // Adiciona uma classe para estilo

        let cidadeDiv = document.createElement("div") // Cria um novo elemento para mostrar a cidade
        cidadeDiv.classList.add("cidade") // Adiciona uma classe
        cidadeDiv.innerText = cidade // Define o texto como o nome da cidade

        caminhoItemDiv.appendChild(cidadeDiv) // Adiciona a cidade ao item do caminho

        // Se não for a última cidade, adiciona a linha e custo
        if (index < caminho.length - 1) {
            let linhaDiv = document.createElement("div") // Cria uma linha
            linhaDiv.classList.add("linha") // Adiciona uma classe
            caminhoItemDiv.appendChild(linhaDiv) // Adiciona a linha ao item

            let custoDiv = document.createElement("div") // Cria um elemento para mostrar o custo
            custoDiv.classList.add("custo-caminho") // Adiciona uma classe
            custoDiv.innerText = `${custos[index]}` // Define o custo do trecho
            caminhoItemDiv.appendChild(custoDiv) // Adiciona o custo ao item
        }

        arvoreDiv.appendChild(caminhoItemDiv) // Adiciona o item do caminho à árvore
    });
}

// Função para exibir o grafo com custos usando vis.js
function exibirGrafoCusto(caminho) {
    // Define as posições fixas para os nós do grafo
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
    let nodes = new vis.DataSet([]) // Conjunto para armazenar os nós
    let edges = new vis.DataSet([]) // Conjunto para armazenar as arestas

    // Adiciona todos os nós e arestas do grafo
    let edgeIds = new Set() // Conjunto para evitar arestas duplicadas
    for (let cidade in grafo) {
        // Adiciona a cidade como nó
        nodes.add({ id: cidade, label: cidade, x: posicoes[cidade]?.x || 0, y: posicoes[cidade]?.y || 0 })
        for (let vizinho in grafo[cidade]) {
            let edgeId = `${cidade}-${vizinho}` // Gera um ID único para a aresta
            // Se a aresta não foi adicionada ainda
            if (!edgeIds.has(edgeId)) {
                // Adiciona a aresta com o custo
                edges.add({ id: edgeId, from: cidade, to: vizinho, label: `${grafo[cidade][vizinho]}`, color: '#000000', arrows: 'to' })
                edgeIds.add(edgeId) // Marca a aresta como adicionada
            }
        }
    }

    // Destaca o caminho mais curto
    for (let i = 0; i < caminho.length - 1; i++) {
        const cidadeAtual = caminho[i] // Cidade atual do caminho
        const proximaCidade = caminho[i + 1] // Próxima cidade no caminho
        const edgeId = `${cidadeAtual}-${proximaCidade}` // Gera o ID da aresta
        // Atualiza a cor da aresta para vermelho
        edges.update({ id: edgeId, color: { color: 'red', highlight: 'red' }, width: 4 })
    }

    // Configurações do grafo
    let data = { nodes: nodes, edges: edges } // Dados do grafo
    let options = { nodes: { shape: 'dot', size: 20 }, edges: { width: 2, color: { inherit: true } }, physics: { enabled: false } }

    // Cria o grafo no elemento HTML
    let container = document.getElementById('grafoCusto')
    new vis.Network(container, data, options) // Inicializa o grafo
}

// Função para calcular e exibir o caminho entre as cidades
function calcularCaminho() {
    const cidadeInicial = document.getElementById("cidadeInicial").value // Obtém a cidade inicial do select
    const cidadeFinal = document.getElementById("cidadeFinal").value // Obtém a cidade final do select

    // Verifica se as cidades são diferentes
    if (cidadeInicial === cidadeFinal) {
        alert("A cidade inicial e final devem ser diferentes.") // Alerta se forem iguais
        return // Interrompe a execução da função
    }

    // Calcula o caminho e os custos
    const resultado = dijkstra(grafo, cidadeInicial, cidadeFinal) // Executa Dijkstra
    const custos = calcularCustosCaminho(resultado.caminho) // Calcula os custos do caminho

    exibirArvoreCaminho(resultado.caminho, custos) // Exibe o caminho na árvore

    const totalCustoDiv = document.getElementById("totalCusto") // Obtém a div para mostrar o custo total
    totalCustoDiv.innerText = `Custo total: ${resultado.distanciaTotal.toFixed(2)}` // Mostra o custo total formatado

    exibirGrafoCusto(resultado.caminho) // Exibe o grafo com os custos
}

// Função para calcular os custos de cada trecho do caminho
function calcularCustosCaminho(caminho) {
    // Retorna um array com os custos de cada trecho do caminho
    return caminho.slice(0, -1).map((cidadeAtual, i) => grafo[cidadeAtual][caminho[i + 1]])
}

// Inicializa as cidades ao carregar a página
window.onload = inicializarCidades; // Chama a função para inicializar as cidades