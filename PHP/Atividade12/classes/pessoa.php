<?php
    class pessoa {
        private $pesnome;
        private $pessobrenome;
        private $pesemail;
        private $pespassword;
        private $pescidade;
        private $pesestado;

        public function __construct() {
            $this->pesnome = "";
            $this->pessobrenome = "";
            $this->pesemail = "";
            $this->pespassword = "";
            $this->pescidade = "";
            $this->pesestado = "";
        }

        public function getPesnome() {
            return $this->pesnome;
        }

        public function setPesnome($pesnome) {
            $this->pesnome = $pesnome;
        }

        public function getPessobrenome() {
            return $this->pessobrenome;
        }

        public function setPessobrenome($pessobrenome) {
            $this->pessobrenome = $pessobrenome;
        }
        public function getPesemail() {
            return $this->pesemail;
        }

        public function setPesemail($pesemail) {
            $this->pesemail = $pesemail;
        }

        public function getPespassword() {
            return $this->pespassword;
        }

        public function setPespassword($pespassword) {
            $this->pespassword = $pespassword;
        }

        public function getPescidade() {
            return $this->pescidade;
        }

        public function setPescidade($pescidade) {
            $this->pescidade = $pescidade;
        }

        public function getPesestado() {
            return $this->pesestado;
        }

        public function setPesestado($pesestado) {
            $this->pesestado = $pesestado;
        }

        public function getPessoas($pdo) {
            
            $sql = "SELECT * FROM tbpessoa";
            $stmt = $pdo->prepare($sql);
            $stmt->execute();
            $pessoas = $stmt->fetchAll(PDO::FETCH_ASSOC);

            return $pessoas;
        }

        public function getPessoaIlike($pesnome, $pdo) {
            $pesnome = '%'. $pesnome .'%';

            $sql = "SELECT * FROM tbpessoa WHERE pesnome ilike ?";
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$pesnome]);
            $pessoas = $stmt->fetch(PDO::FETCH_ASSOC);
            $pessoas = [$pessoas];

            return $pessoas;
        }
        public function cadastrarPessoa($pdo) {
            $aDados = array($this->pesnome,
                            $this->pessobrenome,
                            $this->pesemail,
                            $this->pespassword,
                            $this->pescidade,
                            $this->pesestado);

            $pdo->beginTransaction();
            try {
                $sql = "INSERT INTO tbpessoa (pesnome, pessobrenome, pesemail, pespassword, pescidade, pesestado) VALUES (?, ?, ?, ?, ?, ?)";
                $stmt= $pdo->prepare($sql);
                $stmt->execute($aDados);
                $pdo->commit();
                header("Location: ../index.php");
            } catch (PDOException $e) {
                $pdo->rollback();
                echo "Error: " . $e->getMessage();
            }
        }

        public function toJson() {
            return json_encode(get_object_vars($this));
        }
    }
?>