-- =====================================================
-- SIGAO
-- Sistema Integrado de Gestão de Atas e Órgãos
-- =====================================================

-- =====================================================
-- CONFIGURACOES
-- =====================================================

CREATE TABLE configuracoes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome_freguesia VARCHAR(255),
    morada TEXT,
    email VARCHAR(255),
    telefone VARCHAR(50),
    logotipo VARCHAR(500),
    idioma VARCHAR(20) DEFAULT 'pt-PT',
    voz_ia VARCHAR(100),
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- UTILIZADORES
-- =====================================================

CREATE TABLE utilizadores (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,

    perfil ENUM(
        'ADMIN',
        'SECRETARIO',
        'PRESIDENTE',
        'MEMBRO'
    ) NOT NULL DEFAULT 'MEMBRO',

    ativo TINYINT(1) DEFAULT 1,

    ultimo_login DATETIME NULL,

    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    atualizado_em TIMESTAMP NULL DEFAULT NULL
    ON UPDATE CURRENT_TIMESTAMP

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- ORGAOS
-- =====================================================

CREATE TABLE orgaos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    nome VARCHAR(150) NOT NULL,

    tipo ENUM(
        'JUNTA_FREGUESIA',
        'ASSEMBLEIA_FREGUESIA',
        'COMISSAO_AVALIACAO',
        'CONSELHO_COORDENADOR',
        'OUTRO'
    ) NOT NULL,

    ativo TINYINT(1) DEFAULT 1,

    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- MEMBROS
-- =====================================================

CREATE TABLE membros (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    utilizador_id BIGINT NULL,

    nome VARCHAR(150) NOT NULL,

    email VARCHAR(255),

    telefone VARCHAR(50),

    ativo TINYINT(1) DEFAULT 1,

    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_membros_utilizador
        FOREIGN KEY (utilizador_id)
        REFERENCES utilizadores(id)
        ON DELETE SET NULL

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- MEMBRO_ORGAO
-- =====================================================

CREATE TABLE membro_orgao (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    membro_id BIGINT NOT NULL,

    orgao_id BIGINT NOT NULL,

    cargo VARCHAR(150),

    direito_voto TINYINT(1) DEFAULT 1,

    ativo TINYINT(1) DEFAULT 1,

    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_membro_orgao_membro
        FOREIGN KEY (membro_id)
        REFERENCES membros(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_membro_orgao_orgao
        FOREIGN KEY (orgao_id)
        REFERENCES orgaos(id)
        ON DELETE CASCADE,

    UNIQUE KEY uk_membro_orgao (
        membro_id,
        orgao_id
    )

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- REUNIOES
-- =====================================================

CREATE TABLE reunioes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    orgao_id BIGINT NOT NULL,

    titulo VARCHAR(255) NOT NULL,

    descricao TEXT,

    data_hora DATETIME NOT NULL,

    local_reuniao VARCHAR(255),

    estado ENUM(
        'AGENDADA',
        'EM_CURSO',
        'FINALIZADA',
        'CANCELADA'
    ) DEFAULT 'AGENDADA',

    criada_por BIGINT,

    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_reuniao_orgao
        FOREIGN KEY (orgao_id)
        REFERENCES orgaos(id),

    CONSTRAINT fk_reuniao_utilizador
        FOREIGN KEY (criada_por)
        REFERENCES utilizadores(id)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- PRESENCAS
-- =====================================================

CREATE TABLE presencas (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    reuniao_id BIGINT NOT NULL,

    membro_id BIGINT NOT NULL,

    presente TINYINT(1) DEFAULT 0,

    hora_entrada DATETIME NULL,

    hora_saida DATETIME NULL,

    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_presenca_reuniao
        FOREIGN KEY (reuniao_id)
        REFERENCES reunioes(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_presenca_membro
        FOREIGN KEY (membro_id)
        REFERENCES membros(id)
        ON DELETE CASCADE,

    UNIQUE KEY uk_presenca (
        reuniao_id,
        membro_id
    )

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- PONTOS ORDEM DO DIA
-- =====================================================

CREATE TABLE pontos_ordem_dia (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    reuniao_id BIGINT NOT NULL,

    ordem_numero INT NOT NULL,

    tipo ENUM(
        'ANTES_ORDEM_DIA',
        'ORDEM_DIA'
    ) NOT NULL,

    titulo VARCHAR(300) NOT NULL,

    descricao TEXT,

    estado ENUM(
        'PENDENTE',
        'EM_DISCUSSAO',
        'EM_VOTACAO',
        'CONCLUIDO'
    ) DEFAULT 'PENDENTE',

    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_ponto_reuniao
        FOREIGN KEY (reuniao_id)
        REFERENCES reunioes(id)
        ON DELETE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- DOCUMENTOS
-- =====================================================

CREATE TABLE documentos (

    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    reuniao_id BIGINT NULL,

    ponto_id BIGINT NULL,

    nome VARCHAR(255) NOT NULL,

    ficheiro_path VARCHAR(500) NOT NULL,

    tipo ENUM(
        'ANEXO',
        'EDITAL',
        'AUDIO',
        'DECLARACAO_VOTO',
        'MODELO_ATA',
        'MODELO_EDITAL',
        'MINUTA',
        'ATA_FINAL'
    ) NOT NULL,

    carregado_por BIGINT NULL,

    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_documento_reuniao
        FOREIGN KEY (reuniao_id)
        REFERENCES reunioes(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_documento_ponto
        FOREIGN KEY (ponto_id)
        REFERENCES pontos_ordem_dia(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_documento_utilizador
        FOREIGN KEY (carregado_por)
        REFERENCES utilizadores(id)
        ON DELETE SET NULL

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- VOTOS
-- =====================================================

CREATE TABLE votos (

    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    ponto_id BIGINT NOT NULL,

    membro_id BIGINT NOT NULL,

    voto ENUM(
        'FAVOR',
        'CONTRA',
        'ABSTENCAO'
    ) NOT NULL,

    documento_declaracao_id BIGINT NULL,

    observacoes TEXT,

    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_voto_ponto
        FOREIGN KEY (ponto_id)
        REFERENCES pontos_ordem_dia(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_voto_membro
        FOREIGN KEY (membro_id)
        REFERENCES membros(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_voto_documento
        FOREIGN KEY (documento_declaracao_id)
        REFERENCES documentos(id)
        ON DELETE SET NULL,

    UNIQUE KEY uk_voto (
        ponto_id,
        membro_id
    )

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- INTERVENCOES
-- =====================================================

CREATE TABLE intervencoes (

    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    ponto_id BIGINT NOT NULL,

    membro_id BIGINT NOT NULL,

    estado ENUM(
        'PENDENTE',
        'EM_CURSO',
        'CONCLUIDA',
        'CANCELADA'
    ) DEFAULT 'PENDENTE',

    inicio DATETIME NULL,

    fim DATETIME NULL,

    observacoes TEXT,

    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_intervencao_ponto
        FOREIGN KEY (ponto_id)
        REFERENCES pontos_ordem_dia(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_intervencao_membro
        FOREIGN KEY (membro_id)
        REFERENCES membros(id)
        ON DELETE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- NOTIFICACOES
-- =====================================================

CREATE TABLE notificacoes (

    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    reuniao_id BIGINT NOT NULL,

    membro_id BIGINT NOT NULL,

    canal ENUM(
        'EMAIL',
        'SMS',
        'PUSH'
    ) DEFAULT 'EMAIL',

    estado ENUM(
        'PENDENTE',
        'ENVIADA',
        'ERRO'
    ) DEFAULT 'PENDENTE',

    mensagem TEXT,

    data_envio DATETIME NULL,

    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_notificacao_reuniao
        FOREIGN KEY (reuniao_id)
        REFERENCES reunioes(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_notificacao_membro
        FOREIGN KEY (membro_id)
        REFERENCES membros(id)
        ON DELETE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- LOGS AUDITORIA
-- =====================================================

CREATE TABLE logs_auditoria (

    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    utilizador_id BIGINT NULL,

    tabela_nome VARCHAR(100) NOT NULL,

    registo_id BIGINT NOT NULL,

    acao ENUM(
        'INSERT',
        'UPDATE',
        'DELETE',
        'LOGIN',
        'LOGOUT'
    ) NOT NULL,

    valor_anterior JSON NULL,

    valor_novo JSON NULL,

    ip_origem VARCHAR(45),

    user_agent TEXT,

    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_log_utilizador
        FOREIGN KEY (utilizador_id)
        REFERENCES utilizadores(id)
        ON DELETE SET NULL

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- INDICES
-- =====================================================

CREATE INDEX idx_membros_email
ON membros(email);

CREATE INDEX idx_reunioes_orgao
ON reunioes(orgao_id);

CREATE INDEX idx_presencas_reuniao
ON presencas(reuniao_id);

CREATE INDEX idx_pontos_reuniao
ON pontos_ordem_dia(reuniao_id);

CREATE INDEX idx_documentos_reuniao
ON documentos(reuniao_id);

CREATE INDEX idx_documentos_ponto
ON documentos(ponto_id);

CREATE INDEX idx_votos_ponto
ON votos(ponto_id);

CREATE INDEX idx_votos_membro
ON votos(membro_id);

CREATE INDEX idx_intervencoes_ponto
ON intervencoes(ponto_id);

CREATE INDEX idx_notificacoes_reuniao
ON notificacoes(reuniao_id);

CREATE INDEX idx_logs_tabela
ON logs_auditoria(tabela_nome);

CREATE INDEX idx_logs_utilizador
ON logs_auditoria(utilizador_id);

CREATE INDEX idx_logs_data
ON logs_auditoria(criado_em);