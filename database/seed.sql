-- =====================================================
-- CONFIGURACOES
-- =====================================================

INSERT INTO configuracoes (
    nome_freguesia,
    morada,
    email,
    telefone,
    logotipo,
    idioma,
    voz_ia
)
VALUES (
    'Uniao das Freguesias de Exemplo',
    'Rua Principal n 100',
    'geral@freguesia.pt',
    '212345678',
    'logo.png',
    'pt-PT',
    'pt-PT-FernandaNeural'
);

-- =====================================================
-- UTILIZADORES
-- =====================================================

INSERT INTO utilizadores (
    nome,
    email,
    password_hash,
    perfil
)
VALUES
(
    'Administrador',
    'admin@sigao.pt',
    '$2y$10$admin',
    'ADMIN'
),
(
    'Maria Silva',
    'maria@freguesia.pt',
    '$2y$10$maria',
    'SECRETARIO'
),
(
    'Joao Ferreira',
    'presidente@freguesia.pt',
    '$2y$10$joao',
    'PRESIDENTE'
),
(
    'Ana Costa',
    'ana@freguesia.pt',
    '$2y$10$ana',
    'MEMBRO'
),
(
    'Pedro Santos',
    'pedro@freguesia.pt',
    '$2y$10$pedro',
    'MEMBRO'
);

-- =====================================================
-- ORGAOS
-- =====================================================

INSERT INTO orgaos (
    nome,
    tipo
)
VALUES
(
    'Junta de Freguesia',
    'JUNTA_FREGUESIA'
),
(
    'Assembleia de Freguesia',
    'ASSEMBLEIA_FREGUESIA'
),
(
    'Comissao de Avaliacao',
    'COMISSAO_AVALIACAO'
),
(
    'Conselho Coordenador de Avaliacao',
    'CONSELHO_COORDENADOR'
);

-- =====================================================
-- MEMBROS
-- =====================================================

INSERT INTO membros (
    utilizador_id,
    nome,
    email,
    telefone
)
VALUES
(
    2,
    'Maria Silva',
    'maria@freguesia.pt',
    '911111111'
),
(
    3,
    'Joao Ferreira',
    'presidente@freguesia.pt',
    '922222222'
),
(
    4,
    'Ana Costa',
    'ana@freguesia.pt',
    '933333333'
),
(
    5,
    'Pedro Santos',
    'pedro@freguesia.pt',
    '944444444'
),
(
    NULL,
    'Carlos Mendes',
    'carlos@externo.pt',
    '955555555'
);

-- =====================================================
-- MEMBRO_ORGAO
-- =====================================================

INSERT INTO membro_orgao (
    membro_id,
    orgao_id,
    cargo,
    direito_voto
)
VALUES
(
    1,
    1,
    'Secretaria',
    TRUE
),
(
    2,
    1,
    'Presidente',
    TRUE
),
(
    2,
    2,
    'Representante da Junta',
    FALSE
),
(
    3,
    2,
    'Deputada da Assembleia',
    TRUE
),
(
    4,
    2,
    'Deputado da Assembleia',
    TRUE
),
(
    5,
    3,
    'Tecnico Avaliador',
    TRUE
),
(
    2,
    4,
    'Presidente CCA',
    TRUE
);

-- =====================================================
-- REUNIOES
-- =====================================================

INSERT INTO reunioes (
    orgao_id,
    titulo,
    descricao,
    data_hora,
    local_reuniao,
    estado,
    criada_por
)
VALUES
(
    2,
    'Assembleia Ordinaria Novembro',
    'Assembleia Ordinaria da Freguesia',
    '2026-11-15 21:00:00',
    'Sala da Assembleia',
    'AGENDADA',
    2
),
(
    1,
    'Reuniao da Junta Novembro',
    'Reuniao ordinaria da Junta',
    '2026-11-05 18:00:00',
    'Sala de Reunioes',
    'FINALIZADA',
    2
);

-- =====================================================
-- PRESENCAS
-- =====================================================

INSERT INTO presencas (
    reuniao_id,
    membro_id,
    presente,
    hora_entrada
)
VALUES
(
    1,
    1,
    TRUE,
    '2026-11-15 20:45:00'
),
(
    1,
    2,
    TRUE,
    '2026-11-15 20:50:00'
),
(
    1,
    3,
    TRUE,
    '2026-11-15 20:55:00'
),
(
    1,
    4,
    TRUE,
    '2026-11-15 20:56:00'
),
(
    2,
    1,
    TRUE,
    '2026-11-05 17:50:00'
),
(
    2,
    2,
    TRUE,
    '2026-11-05 17:55:00'
);

-- =====================================================
-- PONTOS DA ORDEM DO DIA
-- =====================================================

INSERT INTO pontos_ordem_dia (
    reuniao_id,
    ordem_numero,
    tipo,
    titulo,
    descricao,
    estado
)
VALUES
(
    1,
    1,
    'ANTES_ORDEM_DIA',
    'Informacoes do Presidente',
    'Periodo antes da ordem do dia',
    'CONCLUIDO'
),
(
    1,
    2,
    'ORDEM_DIA',
    'Aprovacao da Ata Anterior',
    'Votacao da ata da sessao anterior',
    'CONCLUIDO'
),
(
    1,
    3,
    'ORDEM_DIA',
    'Orcamento 2027',
    'Discussao e votacao do orcamento',
    'EM_VOTACAO'
),
(
    1,
    4,
    'ORDEM_DIA',
    'Plano de Atividades',
    'Apresentacao do plano',
    'PENDENTE'
);

-- =====================================================
-- DOCUMENTOS
-- =====================================================

INSERT INTO documentos (
    reuniao_id,
    ponto_id,
    nome,
    ficheiro_path,
    tipo,
    carregado_por
)
VALUES
(
    1,
    NULL,
    'Edital Assembleia Novembro',
    'uploads/editais/edital_novembro.pdf',
    'EDITAL',
    2
),
(
    1,
    2,
    'Ata Sessao Anterior',
    'uploads/anexos/ata_anterior.pdf',
    'ANEXO',
    2
),
(
    1,
    3,
    'Orcamento 2027',
    'uploads/anexos/orcamento2027.pdf',
    'ANEXO',
    2
),
(
    1,
    NULL,
    'Modelo Ata Assembleia',
    'uploads/modelos/modelo_ata.docx',
    'MODELO_ATA',
    2
),
(
    1,
    NULL,
    'Minuta Assembleia',
    'uploads/minutas/minuta.pdf',
    'MINUTA',
    2
),
(
    1,
    NULL,
    'Audio Assembleia',
    'uploads/audios/reuniao_novembro.mp3',
    'AUDIO',
    2
);

-- =====================================================
-- VOTOS
-- =====================================================

INSERT INTO votos (
    ponto_id,
    membro_id,
    voto,
    observacoes
)
VALUES
(
    2,
    3,
    'FAVOR',
    'Aprovacao sem observacoes'
),
(
    2,
    4,
    'FAVOR',
    'Concordancia total'
),
(
    3,
    3,
    'FAVOR',
    'A favor do orcamento'
),
(
    3,
    4,
    'ABSTENCAO',
    'Necessita de mais esclarecimentos'
);

-- =====================================================
-- INTERVENCOES
-- =====================================================

INSERT INTO intervencoes (
    ponto_id,
    membro_id,
    estado,
    inicio,
    fim,
    observacoes
)
VALUES
(
    2,
    3,
    'CONCLUIDA',
    '2026-11-15 21:10:00',
    '2026-11-15 21:15:00',
    'Intervencao sobre a ata anterior'
),
(
    3,
    4,
    'CONCLUIDA',
    '2026-11-15 21:20:00',
    '2026-11-15 21:25:00',
    'Questao sobre o orcamento'
),
(
    4,
    3,
    'PENDENTE',
    NULL,
    NULL,
    'Pedido de palavra'
);

-- =====================================================
-- NOTIFICACOES
-- =====================================================

INSERT INTO notificacoes (
    reuniao_id,
    membro_id,
    canal,
    estado,
    mensagem,
    data_envio
)
VALUES
(
    1,
    1,
    'EMAIL',
    'ENVIADA',
    'Convocatoria da Assembleia',
    NOW()
),
(
    1,
    2,
    'EMAIL',
    'ENVIADA',
    'Convocatoria da Assembleia',
    NOW()
),
(
    1,
    3,
    'EMAIL',
    'ENVIADA',
    'Convocatoria da Assembleia',
    NOW()
),
(
    1,
    4,
    'EMAIL',
    'ENVIADA',
    'Convocatoria da Assembleia',
    NOW()
);

-- =====================================================
-- LOGS AUDITORIA
-- =====================================================

INSERT INTO logs_auditoria (
    utilizador_id,
    tabela_nome,
    registo_id,
    acao,
    valor_novo,
    ip_origem
)
VALUES
(
    1,
    'reunioes',
    1,
    'INSERT',
    JSON_OBJECT(
        'titulo',
        'Assembleia Ordinaria Novembro'
    ),
    '127.0.0.1'
),
(
    2,
    'documentos',
    1,
    'INSERT',
    JSON_OBJECT(
        'nome',
        'Edital Assembleia Novembro'
    ),
    '127.0.0.1'
);