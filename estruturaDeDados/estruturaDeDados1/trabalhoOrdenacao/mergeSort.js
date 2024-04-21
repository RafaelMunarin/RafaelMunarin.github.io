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
console.log('Array não ordenado', arrayMergeSort)
console.log('Array ordenado', arrayDeNumerosOrdenadoMergeSort); 