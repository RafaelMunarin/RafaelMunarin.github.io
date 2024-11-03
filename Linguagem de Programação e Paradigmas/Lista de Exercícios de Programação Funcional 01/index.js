const fs = require('fs');

// 1. Mapeamento e Filtragem:

// Escreva uma função que receba uma lista de números e retorne uma lista com o quadrado de cada número.
function quadrados(numeros) {
    return numeros.map(num => num * num)
}

// Crie uma função que filtre os números pares de uma lista de números.
function filtraPares(numeros) {
    return numeros.filter(num => num % 2 === 0)
}

// 2. Redução:

// Implemente uma função de redução (como array_reduce) que calcule a soma de todos os elementos em uma lista.
function somaElementos(numeros) {
    return numeros.reduce((soma, num) => soma + num, 0)
}

// Escreva uma função que encontre o maior número em uma lista.
function maiorNumero(numeros) {
    return Math.max(...numeros)
}

// 3. Funções de Ordem Superior:

// Implemente uma função chamada processArray que aceite uma lista de números e uma função de transformação como argumentos. 
// A função deve aplicar a função de transformação a cada elemento da lista e retornar a nova lista resultante.
function processArray(arr, transformacao) {
    return arr.map(transformacao)
}

// Crie uma função que aceite uma lista de palavras e uma função que transforma uma palavra em maiúsculas ou minúsculas. 
// Use a função para converter todas aspalavras em maiúsculas ou minúsculas.
function transformaPalavras(palavras, transformacao) {
    return palavras.map(transformacao)
}

// 4. Currying e Composição:

// Implemente uma função de currying que permita somar dois números em duas etapas.
function somaCurried(a) {
    return function(b) {
        return a + b
    }
}

// Escreva uma função de composição que aceite duas funções como entrada e retorne uma nova função que é a composição das duas funções.
function composicao(func1, func2) {
    return function(valor) {
        return func2(func1(valor))
    }
}

// 5. Recursão Funcional:

// Implemente uma função recursiva que calcule o fatorial de um número. 
function fatorial(n) {
    return n <= 1 ? 1 : n * fatorial(n - 1)
}

// Crie uma função recursiva para calcular o N-ésimo termo da sequência de Fibonacci.
function fibonacci(n) {
    return n <= 1 ? n : fibonacci(n - 1) + fibonacci(n - 2)
}

// 6. Programação Funcional com Arrays Associativos:

// Escreva uma função que receba um array associativo de pessoas (com nome e idade) e filtre as pessoas com mais de 30 anos.
function filtraPessoas(pessoas) {
    return pessoas.filter(pessoa => pessoa.idade > 30)
}

// Implemente uma função que receba um array associativo de produtos (com nome e preço) e calcule o preço total dos produtos.
function precoTotal(produtos) {
    return produtos.reduce((total, produto) => total + produto.preco, 0)
}

// 7. Manipulação de Strings Funcional:

// Crie uma função que receba uma lista de strings e retorne uma lista com o comprimento de cada string.
function comprimentoStrings(strings) {
    return strings.map(string => string.length)
}

// Escreva uma função que capitalize a primeira letra de cada palavra em uma frase.
function capitalizaFrase(frase) {
    return frase.split(' ').map(palavra => palavra.charAt(0).toUpperCase() + palavra.slice(1)).join(' ')
}

// 8. Manipulação de Arquivos:

// Implemente uma função que leia o conteúdo de um arquivo de texto e conte o número de palavras.
function contaPalavras(arquivo) {
    const conteudo = fs.readFileSync(arquivo, 'utf-8')
    const palavras = conteudo.split(/\s+/)
    return palavras.filter(palavra => palavra.length > 0).length
}

// Crie uma função que leia um arquivo JSON, filtre os objetos com base em uma condição e salve o resultado em um novo arquivo JSON.
function filtraJSON(inputFile, outputFile, condicao) {
    const conteudo = fs.readFileSync(inputFile, 'utf-8')
    const objetos = JSON.parse(conteudo)
    const resultado = objetos.filter(condicao)
    fs.writeFileSync(outputFile, JSON.stringify(resultado, null, 2))
}


/* ---------- CONSOLE.LOG("AQUI VAI TER AS RESPOSTAS DAS FUNÇÕES ACIMA") ---------- */


// 1. Mapeamento e Filtragem
console.log("---------- 1. Mapeamento e Filtragem ----------")
console.log("Quadrados:", quadrados([1, 2, 3, 4]))
console.log("Números pares:", filtraPares([1, 2, 3, 4, 5, 6]))

// 2. Redução
console.log("---------- 2. Redução ----------")
console.log("Soma dos elementos:", somaElementos([1, 2, 3, 4]))
console.log("Maior número:", maiorNumero([1, 2, 3, 4, 5]))

// 3. Funções de Ordem Superior
console.log("---------- 3. Funções de Ordem Superior ----------")
console.log("Processa Array:", processArray([1, 2, 3], num => num * 2))
console.log("Transforma Palavras:", transformaPalavras(['hello', 'world'], palavra => palavra.toUpperCase()))

// 4. Currying e Composição
console.log("---------- 4. Currying e Composição ----------")
const soma5 = somaCurried(5)
console.log("Soma 5 + 10:", soma5(10))
const composicaoFunc = composicao(Math.sqrt, x => x + 2)
console.log("Composição:", composicaoFunc(9))

// 5. Recursão Funcional
console.log("---------- 5. Recursão Funcional ----------")
console.log("Fatorial de 5:", fatorial(5))
console.log("Fibonacci de 5:", fibonacci(5))

// 6. Programação Funcional com Arrays Associativos
console.log("---------- 6. Programação Funcional com Arrays Associativos ----------")
const pessoas = [{ nome: 'Alice', idade: 25 }, { nome: 'Bob', idade: 35 }, { nome: 'Charlie', idade: 40 }]
console.log("Pessoas com mais de 30 anos:", filtraPessoas(pessoas))

const produtos = [{ nome: 'Produto A', preco: 10 }, { nome: 'Produto B', preco: 20 }]
console.log("Preço total dos produtos:", precoTotal(produtos))

// 7. Manipulação de Strings Funcional
console.log("---------- 7. Manipulação de Strings Funcional ----------")
console.log("Comprimento das strings:", comprimentoStrings(['ola', 'mundo']))
console.log("Frase capitalizada:", capitalizaFrase('ola mundo'))

// 8. Manipulação de Arquivos
console.log("---------- 8. Manipulação de Arquivos ----------")
const numeroDePalavras = contaPalavras('exemplo.txt')
console.log("Número de palavras no arquivo:", numeroDePalavras)
filtraJSON('exemplo.json', 'resultado.json', pessoa => pessoa.idade > 30)
console.log("Filtro aplicado. Resultados salvos em 'resultado.json'.")
console.log("-----------------------------------------------")