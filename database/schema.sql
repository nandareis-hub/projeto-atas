-- Criação da tabela de Atas
CREATE TABLE IF NOT EXISTS atas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_ata VARCHAR(50) NOT NULL,
    mandato VARCHAR(20) NOT NULL,
    codigo_arquivo VARCHAR(50) NOT NULL,
    data_reuniao DATE NOT NULL,
    tipo_reuniao VARCHAR(100) NOT NULL,
    localizacao TEXT NOT NULL,
    presidente VARCHAR(150) NOT NULL,
    secretaria VARCHAR(150) NOT NULL,
    tesoureiro VARCHAR(150) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    conteudo_ata TEXT NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);