<?php 
    class calculadora {
        public function soma($numero1, $numero2){
            return $numero1 + $numero2;
        }
        public function subtrai($numero1, $numero2){
            return $numero1 - $numero2;
        }
        public function divide($numero1, $numero2){
            return $numero1 / $numero2;
        }
        public function multiplica($numero1, $numero2){
            return $numero1 * $numero2;
        }
    }
        $calc = new calculadora();
        echo $calc->soma(1,2) . "<br>";
        echo $calc->subtrai(5,1) ."<br>";
        echo $calc->divide(10,2) ."<br>";
        echo $calc->multiplica(5,3) . "<br>";
?>