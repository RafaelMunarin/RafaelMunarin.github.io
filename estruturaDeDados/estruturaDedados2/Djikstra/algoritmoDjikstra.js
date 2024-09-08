// Grafo das cidades e distâncias
const grafo = {
    "Salete": { "Santa Teresinha": 79.2, "Vítmarsum": 39.6, "Taió": 52.8 },
    "Santa Teresinha": { "Salete": 79.2, "Vítmarsum": 18 },
    "Vítmarsum": { "Santa Teresinha": 18, "Salete": 39.6, "Dona Ema": 14, "Presidente Getúlio": 193.5 },
    "Dona Ema": { "Vítmarsum": 14, "José Boiteux": 9 },
    "José Boiteux": { "Dona Ema": 9, "Presidente Getúlio": 40.5 },
    "Presidente Getúlio": { "José Boiteux": 40.5, "Vítmarsum": 193.5, "Ibirama": 39.6, "Rio do Oeste": 66 },
    "Ibirama": { "Presidente Getúlio": 39.6, "Lontras": 6 },
    "Lontras": { "Ibirama": 6, "Rio do Sul": 5 },
    "Rio do Sul": { "Lontras": 5, "Trombudo Central": 8 },
    "Trombudo Central": { "Rio do Sul": 8, "Braço Trombudo": 5 },
    "Braço Trombudo": { "Trombudo Central": 5, "Pouso Redondo": 17 },
    "Pouso Redondo": { "Braço Trombudo": 17, "Rio do Oeste": 69, "Taió": 21 },
    "Mirim Doce": { "Taió": 27 },
    "Taió": { "Salete": 52.8, "Mirim Doce": 27, "Pouso Redondo": 21, "Rio do Oeste": 60 },
    "Rio do Oeste": { "Presidente Getúlio": 66, "Pouso Redondo": 69, "Taió": 60, "Ibirama": 99, "Lontras": 10 }
}

// Função para inicializar o select de cidades
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

// Função de Dijkstra e funções auxiliares (já adaptado com nomes em português)
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
function exibirArvoreCaminho(caminho) {
    const arvoreDiv = document.getElementById("arvoreCaminho")
    arvoreDiv.innerHTML = '' // Limpa a árvore anterior

    caminho.forEach((cidade, index) => {
        // Cria um div para cada cidade
        let cidadeDiv = document.createElement("div");
        cidadeDiv.classList.add("cidade")
        cidadeDiv.innerText = cidade

        // Adiciona a cidade à árvore
        arvoreDiv.appendChild(cidadeDiv)

        // Se não for a última cidade, adiciona uma linha
        if (index < caminho.length - 1) {
            let linha = document.createElement("div");
            linha.classList.add("linha")
            arvoreDiv.appendChild(linha)
        }
    })
}

// Função para calcular e exibir o caminho
function calcularCaminho() {
    const cidadeInicial = document.getElementById("cidadeInicial").value
    const cidadeFinal = document.getElementById("cidadeFinal").value

    if (cidadeInicial === cidadeFinal) {
        alert("A cidade inicial e final devem ser diferentes.")
        return
    }

    const resultado = dijkstra(grafo, cidadeInicial, cidadeFinal)
    exibirArvoreCaminho(resultado.caminho)
}

// Inicializa as cidades ao carregar a página
window.onload = inicializarCidades