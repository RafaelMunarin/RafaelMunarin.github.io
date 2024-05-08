<?php
    class computador {
        private $estadoAtual;
        public function liga() {
            $this->estadoAtual = "Ligado";
        }
        public function desliga() {
            $this->estadoAtual = "Desligado";
        }
        public function getestadoAtual() {
            return $this->estadoAtual;
        }
    }

    $comp = new computador();
    $comp->liga();
    echo "Estado Atual: " . $comp->getestadoAtual() . "<br>";
    $comp->desliga();
    echo "Estado Atual: " . $comp->getestadoAtual() 
?>