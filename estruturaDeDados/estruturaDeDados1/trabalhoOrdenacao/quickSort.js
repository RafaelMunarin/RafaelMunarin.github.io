// função para ordenar um array de objetos (ordem crescente)
function quickSort(arrayQuickSort) {
    // Caso base: se o array tiver tamanho 1 ou menos, está ordenado
    if (arrayQuickSort.length <= 1) {
        return arrayQuickSort;
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
console.log('Array não ordenado', arrayQuickSort)
console.log('Array ordenado', arrayDeNumerosOrdenadoQuickSort); // Saída: [5, 6, 7, 11, 12, 13]