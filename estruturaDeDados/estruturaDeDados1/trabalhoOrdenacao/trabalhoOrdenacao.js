// Função para ordenar um array de objetos com base em um atributo específico
function mergeSort(arrayQuickSort, atributo) {
    // Caso base: se o array tiver tamanho 1 ou menos, está ordenado
    if (arrayQuickSort.length <= 1) {
        return arrayQuickSort;
    }
    // Divide o array ao meio
    const meio = Math.floor(arrayQuickSort.length / 2); //Retorna o maior número menor ou igual a (array.length / 2)
    const esquerda = arrayQuickSort.slice(0, meio); //Retorna um outro array tirando o elemento 0 e os elementos do meio (vou ter como retorno dois arrays)
    const direita = arrayQuickSort.slice(meio); //Retorna um outro array tirando o elemento do meio (vou ter como retorno dois arrays)
    // Aplica recursivamente o mergeSort nas sublistas esquerda e direita
    const esquerdaOrdenada = mergeSort(esquerda, atributo); //Usamos a função "esquerda" para ficar dividindo o array toda vez que for chamado e a função "atributo" é pelo o'que estamos ordenando o objeto dentro do array
    const direitaOrdenada = mergeSort(direita, atributo); //Usamos a função "direita" para ficar dividindo o array toda vez que for chamado e a função "atributo" é pelo o'que estamos ordenando o objeto dentro do array
    // Combina as sublistas esquerda e direita ordenadamente
    return merge(esquerdaOrdenada, direitaOrdenada, atributo); //Retorno o resultado da função marge
}
// Função auxiliar para mesclar duas listas ordenadas em uma única lista ordenada
function merge(esquerda, direita, atributo) {
    let resultado = []; //Defino resultado como um array vazio
    let i = 0, j = 0; //Defino algumas variáveis de controle como = 0
    // Compara os elementos das sublistas e os mescla em ordem
    while (i < esquerda.length && j < direita.length) { //Faz a comparação entre o tamanho dos arrays da esquerda e direita com as variáveis de controle
        if (esquerda[i][atributo] < direita[j][atributo]) { //Compara se o valor do elemento da esquerda é menor que o da direita
            resultado.push(esquerda[i++]); //Se o valor do elemento da esquerda for menor que o da direita, ele faz um .push no resultado usando o valor da esquerda e incrementa o valor da variável de controle                  
        } else {
            resultado.push(direita[j++]); //Se o valor do elemento da esquerda for maior que o da direita ele faz um .push no resultado usando o valor da direita e incrementa o valor da variável de controle
        }
    }
    return [...resultado, ...esquerda.slice(i), ...direita.slice(j)]; //Cria um novo array final, junta o array do "resultado" e os elementos que não foram para esse array e estão no array "esquerda" e "direita"
}
// Array de objetos a ser ordenado
const arrayMergeSort = [
    { nome: "João", idade: 25 },
    { nome: "Maria", idade: 30 },
    { nome: "Carlos", idade: 20 },
    { nome: "Ana", idade: 35 },
];
const arrayDeNumerosOrdenadoMergeSort = mergeSort(arrayMergeSort, 'idade'); //Defino qual o array que vai ser usado quando chamo a function MergeSort, no caso vou usar o array Pessoas e também passa qual o atributo vou usar para ordenar, no caso a Idade
console.log("Pessoas ordenadas por idade:", arrayDeNumerosOrdenadoMergeSort); //Faço um console.log no resultado da const que criei com os resultados do MergeSort




// QuickSort -> A complexidade de tempo do Quick Sort é O(nlogn) no caso médio e  O(n2) no pior caso, onde n é o número de elementos no array.
// Nesta ordenação, começamos escolhendo um "pivô", ele vai ser quem vai servir de parâmetro para as comparações, após escolher o PIVÔ, o array principal é repartido em 2, um array dos números menores que o PIVÔ e um array dos
// números maiores que o pivô (isso claro através do método de comparação), após isso o quickSort é chamado novamente e aplicado nos dois arrays resultantes, após isso os dois arrays são combinados, como o pivô já está no lugar
//  e os dois arrays já estão ordenados,  não precisa de mais nenhuma operação.

// função para ordenar um array de objetos (ordem crescente)
function quickSort(arrayQuickSort) {
    // Caso base: se o array tiver tamanho 1 ou menos, está ordenado
    if (arrayQuickSort.length <= 1) {
        return array;
    }
    // Seleciona um elemento como pivô (geralmente o último elemento)
    const pivot = arrayQuickSort[arrayQuickSort.length - 1] //Defino o ultimo valor do array como o pivo que vai servir como comparação para ordenar os valores
    const esquerda = []; //Define a constante "LEFT" como um array vazio
    const direita = []; //Define a constante "RIGHT" como um array vazio
    // Divide os elementos em duas listas: menores que o pivô e maiores que o pivô
    for (let i = 0; i < arrayQuickSort.length - 1; i++) { //Crio um laço de repetição que vai eprcorrer todo o array
        if (arrayQuickSort[i] < pivot) { //início a comparação se o valor  do array na posição i é menor que o pivo que escolhi
            esquerda.push(arrayQuickSort[i]); //Caso o valor seja menor que o pivô, faço um .push no array da esquerda
        } else {
            direita.push(arrayQuickSort[i]); //Caso o valor seja maior que o pivo, faço umm .push no array da direita
        }
    }
    // Aplica recursivamente o quickSort nas duas sublistas e concatena com o pivô
    return [...quickSort(esquerda), pivot, ...quickSort(direita)]; //Cria um novo array final, juntar o valor do pivô e os dois arrays que foram separados, uma para a esquerda com os valores menores e uma para a direita com os valores maiores
}
const arrayQuickSort = [12, 11, 13, 5, 6, 7]; // Array de objetos a ser ordenado
const arrayDeNumerosOrdenadoQuickSort = quickSort(arrayQuickSort); //Crio uma const que recebe a ordenação feita pelo método quickSort usando o array como parâmetro
console.log(arrayDeNumerosOrdenadoQuickSort); // Saída: [5, 6, 7, 11, 12, 13]



// SelectSort -> A complexidade de tempo do Selection Sort é O(n2) em todos os casos, onde n é o número de elementos no array.
// O código inicializa com um array NÃO Ordenado, este dá origem a um array ordenado, mas vazio, após ter essa separação, o método percorre todo o array NÃO ordenado e encontra o menor valor, após isso, retira esse valor do array
// NÃO Ordenado e manda para a posição 01  do array Ordenado, após isso, o tamanho do array NÃO Ordenado é diminuído em  1 enquanto o do array Ordenado é aumentado em 1. Após a separação dos valores (esse processo é feito
// repetidamente até que o array NÃO Ordenada tenha nenhuma posição livre, ou seja, seja vazio), com o array Ordenado todo populado, a ordenação está feita;

// função para ordenar um array de objetos
function selectionSort(arraySelectSort) {
    const n = arraySelectSort.length; //Encontrar o tamanho máximo do array NÃO Ordenado
    // Percorre o array
    for (let i = 0; i < n - 1; i++) { //Crio um laço de repetição que vai percorrer todo o array
        let minIndex = i; //Defino uma constante  que vai receber o indíce do menor elemento
        for (let j = i + 1; j < n; j++) { //Crio um laço de repetição que vai percorrer todo o array Ordenado (sempre usando a incrementando a posição quando houver um valor menor)
            if (arraySelectSort[j] < arraySelectSort[minIndex]) { //Faço uma comparaçaõ entre os dois valores
                minIndex = j; //Caso o valor do [j] for menor que o valor [minIndex], faço com que o minIndex receba o menor valor
            }
        }
        // Troca o menor elemento com o elemento na posição atual
        if (minIndex !== i) { //Se o minIndex não for igual ao valor de i
            [arraySelectSort[i], arraySelectSort[minIndex]] = [arraySelectSort[minIndex], arraySelectSort[i]]; //É feito a troca dos valores e assim a ordenação
        }
    }
    return arraySelectSort; //Retorno o array final já ordenado
}
const arraySelectSort = [64, 25, 12, 22, 11]; // Array de objetos a ser ordenado
const arrDeNumerosOrdenadoSelectSort = selectionSort(arraySelectSort); //Crio uma cosnt que recebe a ordenação feita pelo método selectSort usando o array SelectSort como parâmetro
console.log(arrDeNumerosOrdenadoSelectSort); // Saída: [11, 12, 22, 25, 64]



// InsertSort -> A complexidade de tempo do Insertion Sort é O(n2) no pior caso e O(n) no melhor caso, onde n é o número de elementos no array.
// A ordenação começa com o primeiro valor do array sendo separado em um "array" secundário já ordenado, a cada iteração, é expandido o array ordenado e assim "criando mais espaço", a cada iteração, é pego o valor seguinte do
// array original e incluído no array secundário (já ordenados), assim que essa iteração é feita, o algoritmo compara se o valor que foi alterado de posição é menor ou maior que os que já existe, caso o valor atual seja menor
// que o valor atual da parte ordenada,, o valor da posição atual é deslocado uma posição para a direita. Esse processo é repetido até que se forma um array por completo ordenado.

// função para ordenar um array de objetos
function insertionSort(arrayInsertSort) {
    const n = arr.length; //Encontro o tamanho máximo do array NÃO Ordenado
    // Percorre o array a partir do segundo elemento
    for (let i = 1; i < n; i++) { //Crio um laço de repetição que vai percorrer todo o array
        // Armazena o valor atual para comparação
        let current = arrayInsertSort[i]; //Defino que a variavel "current" é igual ao valor atual do loop "I"
        let j = i - 1; //Definir a variável "J " como = ao valor anterior de "I"
        // Move os elementos maiores que o valor atual para a direita para abrir espaço para o valor atual
        while (j >= 0 && arrayInsertSort[j] > current) { //Crio um laço de repetição que enquanto o valor de "j" for maior ou igual a 0 e o valor do array na posição J for maior que o valor de current
            arrayInsertSort[j + 1] = arrayInsertSort[j]; //A posição do array J + 1 vai receber o valor da posição J
            j--; //J vai ser subtraído 1 a cada laço de repetição do loop
        }
        arrayInsertSort[j + 1] = current; // Insere o valor atual na posição correta
    }
    return arrayInsertSort; //Retorno o array final ja ordenado
}
const arrayInsertSort = [12, 11, 13, 5, 6]; // Array de objetos a ser ordenado
const arrOrdenado = insertionSort(arrayInsertSort);  //Crio uma cosnt que recebe a ordenação feita pelo método insertSort usando o arrayInsertSort como parâmetro
console.log(arrOrdenado); // Saída: [5, 6, 11, 12, 13]