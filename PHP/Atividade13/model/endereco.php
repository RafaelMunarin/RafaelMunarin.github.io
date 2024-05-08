<?php
    namespace app\model;

    class endereco{
        private $Logradouro;
        private $Bairro;
        private $Cidade;
        private $Estado;
        private $cep;


    public function setlogradouro($logradouro) {
        $this->Logradouro = $logradouro;
    }
    public function setBairro($bairro) {
        $this->Bairro = $bairro;
    }
    public function setCidade($cidade) {
        $this->Cidade = $cidade;
    }
    public function setestado($estado) {
        $this->Estado = $estado;
    }
    public function setcep($cep) {
        $this->cep = $cep;
    }
    public function getlogradouro() {
        return $this->Logradouro;
    }
    public function getBairro() {
        return $this->Bairro;
    }

    public function getCidade() {
        return $this->Cidade;
    }
    public function getestado() {
        return $this->Estado;
    }
    public function getCep() {
        return $this->cep;
    }
    }
?>