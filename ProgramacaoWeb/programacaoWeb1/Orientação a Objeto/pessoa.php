<?php
    class pessoa {
        private $nome;
        private $sobreNome;
        private $dataNascimento;
        private $cpfCnpj;
        private $tipo;
        private $telefone;
        private $endereco;

        private function inicializaClasse(){

        }
        public function getNomeCompleto() {
            return $this->nome . " " . $this->sobreNome;
        }
        public function getIdade(){
            return 0;
        }
        public function getNome(){
            return $this->nome; 
        }
        public function setNome($sNome){
            $this->nome = $sNome;
        }
        public function getSobreNome(){
            return $this->sobreNome; 
        }
        public function setSobreNome($sSobreNome){
            $this->sobreNome = $sSobreNome;
        }
    }
?> 