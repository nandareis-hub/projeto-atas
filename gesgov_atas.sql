-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 20/10/2026 às 16:57
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `gesgov_atas`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `configuracoes`
--

CREATE TABLE `configuracoes` (
  `id` bigint(20) NOT NULL,
  `nome_freguesia` varchar(255) DEFAULT NULL,
  `morada` text DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telefone` varchar(50) DEFAULT NULL,
  `logotipo` varchar(500) DEFAULT NULL,
  `idioma` varchar(20) DEFAULT 'pt-PT',
  `voz_ia` varchar(100) DEFAULT NULL,
  `criado_em` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `configuracoes`
--

INSERT INTO `configuracoes` (`id`, `nome_freguesia`, `morada`, `email`, `telefone`, `logotipo`, `idioma`, `voz_ia`, `criado_em`) VALUES
(1, 'União das Freguesias de Exemplo', 'Rua Principal nº 100', 'geral@freguesia.pt', '212345678', 'logo.png', 'pt-PT', 'pt-PT-FernandaNeural', '2026-10-20 13:59:30');

-- --------------------------------------------------------

--
-- Estrutura para tabela `documentos`
--

CREATE TABLE `documentos` (
  `id` bigint(20) NOT NULL,
  `reuniao_id` bigint(20) DEFAULT NULL,
  `ponto_id` bigint(20) DEFAULT NULL,
  `nome` varchar(255) NOT NULL,
  `ficheiro_path` varchar(500) NOT NULL,
  `tipo` enum('ANEXO','EDITAL','AUDIO','DECLARACAO_VOTO','MODELO_ATA','MODELO_EDITAL','MINUTA','ATA_FINAL') NOT NULL,
  `carregado_por` bigint(20) DEFAULT NULL,
  `criado_em` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `documentos`
--

INSERT INTO `documentos` (`id`, `reuniao_id`, `ponto_id`, `nome`, `ficheiro_path`, `tipo`, `carregado_por`, `criado_em`) VALUES
(1, 1, NULL, 'Edital Assembleia Novembro', '/uploads/edital_novembro.pdf', 'EDITAL', 2, '2026-10-20 13:59:31'),
(2, 1, 2, 'Ata Anterior', '/uploads/ata_anterior.pdf', 'ANEXO', 2, '2026-10-20 13:59:31'),
(3, 1, 3, 'Orcamento 2027', '/uploads/orcamento2027.pdf', 'ANEXO', 2, '2026-10-20 13:59:31'),
(4, 1, NULL, 'Modelo Ata Assembleia', '/templates/modelo_ata.docx', 'MODELO_ATA', 2, '2026-10-20 13:59:31'),
(5, 1, NULL, 'Gravacao Reuniao', '/audio/reuniao.mp3', 'AUDIO', 2, '2026-10-20 13:59:31');

-- --------------------------------------------------------

--
-- Estrutura para tabela `intervencoes`
--

CREATE TABLE `intervencoes` (
  `id` bigint(20) NOT NULL,
  `ponto_id` bigint(20) NOT NULL,
  `membro_id` bigint(20) NOT NULL,
  `estado` enum('PENDENTE','EM_CURSO','CONCLUIDA','CANCELADA') DEFAULT 'PENDENTE',
  `inicio` datetime DEFAULT NULL,
  `fim` datetime DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `criado_em` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `intervencoes`
--

INSERT INTO `intervencoes` (`id`, `ponto_id`, `membro_id`, `estado`, `inicio`, `fim`, `observacoes`, `criado_em`) VALUES
(1, 2, 3, 'CONCLUIDA', '2026-11-15 21:10:00', '2026-11-15 21:15:00', 'Intervencao sobre a ata anterior', '2026-10-20 13:59:31'),
(2, 3, 1, 'PENDENTE', NULL, NULL, 'Pedido de palavra', '2026-10-20 13:59:31');

-- --------------------------------------------------------

--
-- Estrutura para tabela `logs_auditoria`
--

CREATE TABLE `logs_auditoria` (
  `id` bigint(20) NOT NULL,
  `utilizador_id` bigint(20) DEFAULT NULL,
  `tabela_nome` varchar(100) NOT NULL,
  `registo_id` bigint(20) NOT NULL,
  `acao` enum('INSERT','UPDATE','DELETE','LOGIN','LOGOUT') NOT NULL,
  `valor_anterior` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`valor_anterior`)),
  `valor_novo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`valor_novo`)),
  `ip_origem` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `criado_em` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `logs_auditoria`
--

INSERT INTO `logs_auditoria` (`id`, `utilizador_id`, `tabela_nome`, `registo_id`, `acao`, `valor_anterior`, `valor_novo`, `ip_origem`, `user_agent`, `criado_em`) VALUES
(1, 1, 'reunioes', 1, 'INSERT', NULL, '{\"titulo\": \"Assembleia Ordinaria Novembro\"}', '127.0.0.1', NULL, '2026-10-20 13:59:31'),
(2, 2, 'documentos', 1, 'INSERT', NULL, '{\"nome\": \"Edital Assembleia Novembro\"}', '127.0.0.1', NULL, '2026-10-20 13:59:31');

-- --------------------------------------------------------

--
-- Estrutura para tabela `membros`
--

CREATE TABLE `membros` (
  `id` bigint(20) NOT NULL,
  `utilizador_id` bigint(20) DEFAULT NULL,
  `nome` varchar(150) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telefone` varchar(50) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT 1,
  `criado_em` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `membros`
--

INSERT INTO `membros` (`id`, `utilizador_id`, `nome`, `email`, `telefone`, `ativo`, `criado_em`) VALUES
(1, 2, 'Maria Silva', 'secretaria@freguesia.pt', '911111111', 1, '2026-10-20 13:59:31'),
(2, 3, 'Joao Ferreira', 'presidente@freguesia.pt', '922222222', 1, '2026-10-20 13:59:31'),
(3, 4, 'Ana Costa', 'ana@freguesia.pt', '933333333', 1, '2026-10-20 13:59:31'),
(4, NULL, 'Carlos Mendes', 'carlos@externo.pt', '944444444', 1, '2026-10-20 13:59:31');

-- --------------------------------------------------------

--
-- Estrutura para tabela `membro_orgao`
--

CREATE TABLE `membro_orgao` (
  `id` bigint(20) NOT NULL,
  `membro_id` bigint(20) NOT NULL,
  `orgao_id` bigint(20) NOT NULL,
  `cargo` varchar(150) DEFAULT NULL,
  `direito_voto` tinyint(1) DEFAULT 1,
  `ativo` tinyint(1) DEFAULT 1,
  `criado_em` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `membro_orgao`
--

INSERT INTO `membro_orgao` (`id`, `membro_id`, `orgao_id`, `cargo`, `direito_voto`, `ativo`, `criado_em`) VALUES
(1, 1, 1, 'Secretaria', 1, 1, '2026-10-20 13:59:31'),
(2, 2, 1, 'Presidente', 1, 1, '2026-10-20 13:59:31'),
(3, 2, 2, 'Presidente da Junta', 0, 1, '2026-10-20 13:59:31'),
(4, 3, 2, 'Membro Assembleia', 1, 1, '2026-10-20 13:59:31'),
(5, 4, 3, 'Tecnico Avaliador', 1, 1, '2026-10-20 13:59:31');

-- --------------------------------------------------------

--
-- Estrutura para tabela `notificacoes`
--

CREATE TABLE `notificacoes` (
  `id` bigint(20) NOT NULL,
  `reuniao_id` bigint(20) NOT NULL,
  `membro_id` bigint(20) NOT NULL,
  `canal` enum('EMAIL','SMS','PUSH') DEFAULT 'EMAIL',
  `estado` enum('PENDENTE','ENVIADA','ERRO') DEFAULT 'PENDENTE',
  `mensagem` text DEFAULT NULL,
  `data_envio` datetime DEFAULT NULL,
  `criado_em` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `notificacoes`
--

INSERT INTO `notificacoes` (`id`, `reuniao_id`, `membro_id`, `canal`, `estado`, `mensagem`, `data_envio`, `criado_em`) VALUES
(1, 1, 1, 'EMAIL', 'ENVIADA', 'Convocatoria Assembleia', '2026-10-20 13:59:31', '2026-10-20 13:59:31'),
(2, 1, 2, 'EMAIL', 'ENVIADA', 'Convocatoria Assembleia', '2026-10-20 13:59:31', '2026-10-20 13:59:31'),
(3, 1, 3, 'EMAIL', 'ENVIADA', 'Convocatoria Assembleia', '2026-10-20 13:59:31', '2026-10-20 13:59:31');

-- --------------------------------------------------------

--
-- Estrutura para tabela `orgaos`
--

CREATE TABLE `orgaos` (
  `id` bigint(20) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `tipo` enum('JUNTA_FREGUESIA','ASSEMBLEIA_FREGUESIA','COMISSAO_AVALIACAO','CONSELHO_COORDENADOR','OUTRO') NOT NULL,
  `ativo` tinyint(1) DEFAULT 1,
  `criado_em` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `orgaos`
--

INSERT INTO `orgaos` (`id`, `nome`, `tipo`, `ativo`, `criado_em`) VALUES
(1, 'Junta de Freguesia', 'JUNTA_FREGUESIA', 1, '2026-10-20 13:59:31'),
(2, 'Assembleia de Freguesia', 'ASSEMBLEIA_FREGUESIA', 1, '2026-10-20 13:59:31'),
(3, 'Comissao de Avaliacao', 'COMISSAO_AVALIACAO', 1, '2026-10-20 13:59:31');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pontos_ordem_dia`
--

CREATE TABLE `pontos_ordem_dia` (
  `id` bigint(20) NOT NULL,
  `reuniao_id` bigint(20) NOT NULL,
  `ordem_numero` int(11) NOT NULL,
  `tipo` enum('ANTES_ORDEM_DIA','ORDEM_DIA') NOT NULL,
  `titulo` varchar(300) NOT NULL,
  `descricao` text DEFAULT NULL,
  `estado` enum('PENDENTE','EM_DISCUSSAO','EM_VOTACAO','CONCLUIDO') DEFAULT 'PENDENTE',
  `criado_em` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pontos_ordem_dia`
--

INSERT INTO `pontos_ordem_dia` (`id`, `reuniao_id`, `ordem_numero`, `tipo`, `titulo`, `descricao`, `estado`, `criado_em`) VALUES
(1, 1, 1, 'ANTES_ORDEM_DIA', 'Informacoes do Presidente', 'Periodo antes da ordem do dia', 'CONCLUIDO', '2026-10-20 13:59:31'),
(2, 1, 2, 'ORDEM_DIA', 'Aprovacao da Ata Anterior', 'Votacao da ata', 'EM_VOTACAO', '2026-10-20 13:59:31'),
(3, 1, 3, 'ORDEM_DIA', 'Orcamento 2027', 'Discussao e votacao', 'PENDENTE', '2026-10-20 13:59:31');

-- --------------------------------------------------------

--
-- Estrutura para tabela `presencas`
--

CREATE TABLE `presencas` (
  `id` bigint(20) NOT NULL,
  `reuniao_id` bigint(20) NOT NULL,
  `membro_id` bigint(20) NOT NULL,
  `presente` tinyint(1) DEFAULT 0,
  `hora_entrada` datetime DEFAULT NULL,
  `hora_saida` datetime DEFAULT NULL,
  `criado_em` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `presencas`
--

INSERT INTO `presencas` (`id`, `reuniao_id`, `membro_id`, `presente`, `hora_entrada`, `hora_saida`, `criado_em`) VALUES
(1, 1, 1, 1, NULL, NULL, '2026-10-20 13:59:31'),
(2, 1, 2, 1, NULL, NULL, '2026-10-20 13:59:31'),
(3, 1, 3, 1, NULL, NULL, '2026-10-20 13:59:31'),
(4, 2, 1, 1, NULL, NULL, '2026-10-20 13:59:31'),
(5, 2, 2, 1, NULL, NULL, '2026-10-20 13:59:31');

-- --------------------------------------------------------

--
-- Estrutura para tabela `reunioes`
--

CREATE TABLE `reunioes` (
  `id` bigint(20) NOT NULL,
  `orgao_id` bigint(20) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `data_hora` datetime NOT NULL,
  `local_reuniao` varchar(255) DEFAULT NULL,
  `estado` enum('AGENDADA','EM_CURSO','FINALIZADA','CANCELADA') DEFAULT 'AGENDADA',
  `criada_por` bigint(20) DEFAULT NULL,
  `criado_em` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `reunioes`
--

INSERT INTO `reunioes` (`id`, `orgao_id`, `titulo`, `descricao`, `data_hora`, `local_reuniao`, `estado`, `criada_por`, `criado_em`) VALUES
(1, 2, 'Assembleia Ordinaria Novembro', 'Sessao ordinaria da Assembleia', '2026-11-15 21:00:00', 'Sala Assembleia', 'AGENDADA', 2, '2026-10-20 13:59:31'),
(2, 1, 'Reuniao da Junta Novembro', 'Reuniao ordinaria da Junta', '2026-11-05 18:00:00', 'Sala de Reunioes', 'AGENDADA', 2, '2026-10-20 13:59:31');

-- --------------------------------------------------------

--
-- Estrutura para tabela `utilizadores`
--

CREATE TABLE `utilizadores` (
  `id` bigint(20) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `perfil` enum('ADMIN','SECRETARIO','PRESIDENTE','MEMBRO') NOT NULL DEFAULT 'MEMBRO',
  `ativo` tinyint(1) DEFAULT 1,
  `ultimo_login` datetime DEFAULT NULL,
  `criado_em` datetime DEFAULT current_timestamp(),
  `atualizado_em` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `utilizadores`
--

INSERT INTO `utilizadores` (`id`, `nome`, `email`, `password_hash`, `perfil`, `ativo`, `ultimo_login`, `criado_em`, `atualizado_em`) VALUES
(1, 'Administrador', 'admin@gesgov.pt', '$2y$10$admin', 'ADMIN', 1, NULL, '2026-10-20 13:59:31', NULL),
(2, 'Maria Silva', 'secretaria@freguesia.pt', '$2y$10$secretaria', 'SECRETARIO', 1, NULL, '2026-10-20 13:59:31', NULL),
(3, 'Joao Ferreira', 'presidente@freguesia.pt', '$2y$10$presidente', 'PRESIDENTE', 1, NULL, '2026-10-20 13:59:31', NULL),
(4, 'Ana Costa', 'ana@freguesia.pt', '$2y$10$membro', 'MEMBRO', 1, NULL, '2026-10-20 13:59:31', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `votos`
--

CREATE TABLE `votos` (
  `id` bigint(20) NOT NULL,
  `ponto_id` bigint(20) NOT NULL,
  `membro_id` bigint(20) NOT NULL,
  `voto` enum('FAVOR','CONTRA','ABSTENCAO') NOT NULL,
  `documento_declaracao_id` bigint(20) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `criado_em` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `votos`
--

INSERT INTO `votos` (`id`, `ponto_id`, `membro_id`, `voto`, `documento_declaracao_id`, `observacoes`, `criado_em`) VALUES
(1, 2, 1, 'FAVOR', NULL, NULL, '2026-10-20 13:59:31'),
(2, 2, 3, 'FAVOR', NULL, NULL, '2026-10-20 13:59:31');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `configuracoes`
--
ALTER TABLE `configuracoes`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_documento_utilizador` (`carregado_por`),
  ADD KEY `idx_documentos_reuniao` (`reuniao_id`),
  ADD KEY `idx_documentos_ponto` (`ponto_id`);

--
-- Índices de tabela `intervencoes`
--
ALTER TABLE `intervencoes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_intervencao_membro` (`membro_id`),
  ADD KEY `idx_intervencoes_ponto` (`ponto_id`);

--
-- Índices de tabela `logs_auditoria`
--
ALTER TABLE `logs_auditoria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_logs_tabela` (`tabela_nome`),
  ADD KEY `idx_logs_utilizador` (`utilizador_id`),
  ADD KEY `idx_logs_data` (`criado_em`);

--
-- Índices de tabela `membros`
--
ALTER TABLE `membros`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_membros_utilizador` (`utilizador_id`),
  ADD KEY `idx_membros_email` (`email`);

--
-- Índices de tabela `membro_orgao`
--
ALTER TABLE `membro_orgao`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_membro_orgao` (`membro_id`,`orgao_id`),
  ADD KEY `fk_membro_orgao_orgao` (`orgao_id`);

--
-- Índices de tabela `notificacoes`
--
ALTER TABLE `notificacoes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_notificacao_membro` (`membro_id`),
  ADD KEY `idx_notificacoes_reuniao` (`reuniao_id`);

--
-- Índices de tabela `orgaos`
--
ALTER TABLE `orgaos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `pontos_ordem_dia`
--
ALTER TABLE `pontos_ordem_dia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pontos_reuniao` (`reuniao_id`);

--
-- Índices de tabela `presencas`
--
ALTER TABLE `presencas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_presenca` (`reuniao_id`,`membro_id`),
  ADD KEY `fk_presenca_membro` (`membro_id`),
  ADD KEY `idx_presencas_reuniao` (`reuniao_id`);

--
-- Índices de tabela `reunioes`
--
ALTER TABLE `reunioes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_reuniao_utilizador` (`criada_por`),
  ADD KEY `idx_reunioes_orgao` (`orgao_id`);

--
-- Índices de tabela `utilizadores`
--
ALTER TABLE `utilizadores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices de tabela `votos`
--
ALTER TABLE `votos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_voto` (`ponto_id`,`membro_id`),
  ADD KEY `fk_voto_documento` (`documento_declaracao_id`),
  ADD KEY `idx_votos_ponto` (`ponto_id`),
  ADD KEY `idx_votos_membro` (`membro_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `configuracoes`
--
ALTER TABLE `configuracoes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `intervencoes`
--
ALTER TABLE `intervencoes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `logs_auditoria`
--
ALTER TABLE `logs_auditoria`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `membros`
--
ALTER TABLE `membros`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `membro_orgao`
--
ALTER TABLE `membro_orgao`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `notificacoes`
--
ALTER TABLE `notificacoes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `orgaos`
--
ALTER TABLE `orgaos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `pontos_ordem_dia`
--
ALTER TABLE `pontos_ordem_dia`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `presencas`
--
ALTER TABLE `presencas`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `reunioes`
--
ALTER TABLE `reunioes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `utilizadores`
--
ALTER TABLE `utilizadores`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `votos`
--
ALTER TABLE `votos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `documentos`
--
ALTER TABLE `documentos`
  ADD CONSTRAINT `fk_documento_ponto` FOREIGN KEY (`ponto_id`) REFERENCES `pontos_ordem_dia` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_documento_reuniao` FOREIGN KEY (`reuniao_id`) REFERENCES `reunioes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_documento_utilizador` FOREIGN KEY (`carregado_por`) REFERENCES `utilizadores` (`id`) ON DELETE SET NULL;

--
-- Restrições para tabelas `intervencoes`
--
ALTER TABLE `intervencoes`
  ADD CONSTRAINT `fk_intervencao_membro` FOREIGN KEY (`membro_id`) REFERENCES `membros` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_intervencao_ponto` FOREIGN KEY (`ponto_id`) REFERENCES `pontos_ordem_dia` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `logs_auditoria`
--
ALTER TABLE `logs_auditoria`
  ADD CONSTRAINT `fk_log_utilizador` FOREIGN KEY (`utilizador_id`) REFERENCES `utilizadores` (`id`) ON DELETE SET NULL;

--
-- Restrições para tabelas `membros`
--
ALTER TABLE `membros`
  ADD CONSTRAINT `fk_membros_utilizador` FOREIGN KEY (`utilizador_id`) REFERENCES `utilizadores` (`id`) ON DELETE SET NULL;

--
-- Restrições para tabelas `membro_orgao`
--
ALTER TABLE `membro_orgao`
  ADD CONSTRAINT `fk_membro_orgao_membro` FOREIGN KEY (`membro_id`) REFERENCES `membros` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_membro_orgao_orgao` FOREIGN KEY (`orgao_id`) REFERENCES `orgaos` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `notificacoes`
--
ALTER TABLE `notificacoes`
  ADD CONSTRAINT `fk_notificacao_membro` FOREIGN KEY (`membro_id`) REFERENCES `membros` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_notificacao_reuniao` FOREIGN KEY (`reuniao_id`) REFERENCES `reunioes` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `pontos_ordem_dia`
--
ALTER TABLE `pontos_ordem_dia`
  ADD CONSTRAINT `fk_ponto_reuniao` FOREIGN KEY (`reuniao_id`) REFERENCES `reunioes` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `presencas`
--
ALTER TABLE `presencas`
  ADD CONSTRAINT `fk_presenca_membro` FOREIGN KEY (`membro_id`) REFERENCES `membros` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_presenca_reuniao` FOREIGN KEY (`reuniao_id`) REFERENCES `reunioes` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `reunioes`
--
ALTER TABLE `reunioes`
  ADD CONSTRAINT `fk_reuniao_orgao` FOREIGN KEY (`orgao_id`) REFERENCES `orgaos` (`id`),
  ADD CONSTRAINT `fk_reuniao_utilizador` FOREIGN KEY (`criada_por`) REFERENCES `utilizadores` (`id`);

--
-- Restrições para tabelas `votos`
--
ALTER TABLE `votos`
  ADD CONSTRAINT `fk_voto_documento` FOREIGN KEY (`documento_declaracao_id`) REFERENCES `documentos` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_voto_membro` FOREIGN KEY (`membro_id`) REFERENCES `membros` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_voto_ponto` FOREIGN KEY (`ponto_id`) REFERENCES `pontos_ordem_dia` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
