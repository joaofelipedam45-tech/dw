-- =====================================================
-- Banco de Dados: Loja de Videogames
-- Descrição: Sistema simples de catálogo de jogos
-- =====================================================

-- Criar banco de dados (comentado para evitar erros)
-- CREATE DATABASE loja_videogames;

-- =====================================================
-- TABELA 1: DESENVOLVEDORAS
-- =====================================================
CREATE TABLE desenvolvedoras (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    pais VARCHAR(50) NOT NULL,
    ano_fundacao INTEGER NOT NULL,
    website VARCHAR(200),
    descricao TEXT
);

-- =====================================================
-- TABELA 2: JOGOS
-- (Relacionamento N:1 com desenvolvedoras)
-- =====================================================
CREATE TABLE jogos (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL UNIQUE,
    desenvolvedora_id INTEGER NOT NULL,
    ano_lancamento INTEGER NOT NULL,
    genero VARCHAR(50) NOT NULL,
    plataforma VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    classificacao_etaria INTEGER,
    descricao TEXT,
    imagem_url VARCHAR(300),
    FOREIGN KEY (desenvolvedora_id) REFERENCES desenvolvedoras(id) ON DELETE CASCADE
);

-- =====================================================
-- ÍNDICES (Melhoria de performance)
-- =====================================================
CREATE INDEX idx_jogos_desenvolvedora ON jogos(desenvolvedora_id);
CREATE INDEX idx_jogos_genero ON jogos(genero);
CREATE INDEX idx_jogos_plataforma ON jogos(plataforma);

-- =====================================================
-- POPULANDO TABELA: DESENVOLVEDORAS
-- =====================================================
INSERT INTO desenvolvedoras (nome, pais, ano_fundacao, website, descricao) VALUES
(
    'Nintendo',
    'Japão',
    1889,
    'https://www.nintendo.com',
    'Maior desenvolvedora de consoles e jogos, conhecida por Mario, Zelda e Pokemon'
),
(
    'Sony Interactive Entertainment',
    'Japão',
    1993,
    'https://www.playstation.com',
    'Desenvolvedora da série PlayStation, conhecida por God of War e The Last of Us'
),
(
    'Microsoft Game Studios',
    'Estados Unidos',
    2000,
    'https://www.xbox.com',
    'Dona da série Xbox, conhecida por Halo, Gears of War e Forza'
),
(
    'Rockstar Games',
    'Estados Unidos',
    1998,
    'https://www.rockstargames.com',
    'Criadora da série Grand Theft Auto, uma das maiores franquias de todos os tempos'
),
(
    'Valve Corporation',
    'Estados Unidos',
    1996,
    'https://www.valvesoftware.com',
    'Desenvolvedora de Half-Life, Counter-Strike e proprietária da plataforma Steam'
),
(
    'CD Projekt Red',
    'Polônia',
    2002,
    'https://www.cdprojektred.com',
    'Criadora da série The Witcher e Cyberpunk 2077'
),
(
    'Bandcamp Entertainment',
    'Japão',
    1980,
    'https://www.bandai-namco.com',
    'Produtora de Pac-Man, Dark Souls, Tekken e muitos outros sucessos'
);

-- =====================================================
-- POPULANDO TABELA: JOGOS
-- =====================================================
INSERT INTO jogos (titulo, desenvolvedora_id, ano_lancamento, genero, plataforma, preco, classificacao_etaria, descricao, imagem_url) VALUES

-- Nintendo
(
    'The Legend of Zelda: Breath of the Wild',
    1,
    2017,
    'Aventura',
    'Nintendo Switch',
    299.90,
    10,
    'Um clássico de ação-aventura com mundo aberto revolucionário. Explore, resolva puzzles e derrote inimigos',
    'https://via.placeholder.com/300x400?text=Zelda'
),
(
    'Super Mario Odyssey',
    1,
    2017,
    'Plataforma',
    'Nintendo Switch',
    279.90,
    7,
    'Mario em sua aventura mais criativa, onde pode possuir (capture) qualquer inimigo para usá-lo como poder especial',
    'https://via.placeholder.com/300x400?text=Mario'
),
(
    'Animal Crossing: New Horizons',
    1,
    2020,
    'Simulação',
    'Nintendo Switch',
    299.90,
    3,
    'Viva em sua própria ilha paradisíaca, decora, pesca, coleciona fósseis e faz amizades com personagens encantadores',
    'https://via.placeholder.com/300x400?text=AnimalCrossing'
),
(
    'Pokemon Scarlet',
    1,
    2022,
    'RPG',
    'Nintendo Switch',
    329.90,
    7,
    'A primeira geração de Pokemon com mundo totalmente aberto. Capture e treine criaturas poderosas nesta aventura épica',
    'https://via.placeholder.com/300x400?text=Pokemon'
),

-- Sony
(
    'God of War Ragnarök',
    2,
    2022,
    'Ação-Aventura',
    'PlayStation 5',
    349.90,
    18,
    'A conclusão épica da saga nórdica. Kratos e Atreus enfrentam destinos em conflito no Ragnarök',
    'https://via.placeholder.com/300x400?text=GodOfWar'
),
(
    'The Last of Us Part I',
    2,
    2022,
    'Ação-Aventura',
    'PlayStation 5',
    279.90,
    18,
    'Remake do clássico: Joel e Ellie em uma jornada épica de sobrevivência em um mundo pós-apocalíptico',
    'https://via.placeholder.com/300x400?text=LastOfUs'
),
(
    'Spider-Man: Miles Morales',
    2,
    2020,
    'Ação-Aventura',
    'PlayStation 5',
    269.90,
    16,
    'Miles Morales assume o manto de Homem-Aranha em uma aventura eletrizante em Nova York',
    'https://via.placeholder.com/300x400?text=SpiderMan'
),
(
    'Horizon Zero Dawn',
    2,
    2017,
    'RPG Ação',
    'PlayStation 5',
    199.90,
    16,
    'Explore um mundo onde a natureza retomou conta e máquinas dominam. Descubra mistérios e derrote titãs mecânicos',
    'https://via.placeholder.com/300x400?text=Horizon'
),

-- Microsoft
(
    'Halo Infinite',
    3,
    2021,
    'FPS',
    'Xbox Series X|S',
    269.90,
    16,
    'O retorno épico do Master Chief em uma luta pela sobrevivência da humanidade contra uma ameaça alienígena',
    'https://via.placeholder.com/300x400?text=Halo'
),
(
    'Forza Horizon 5',
    3,
    2021,
    'Corrida',
    'Xbox Series X|S',
    299.90,
    3,
    'Corridas incríveis no México com gráficos impressionantes e liberdade total de exploração',
    'https://via.placeholder.com/300x400?text=Forza'
),
(
    'Starfield',
    3,
    2023,
    'RPG Ficção Científica',
    'Xbox Series X|S',
    349.90,
    17,
    'Explore o universo em uma aventura épica de ficção científica com possibilidades ilimitadas',
    'https://via.placeholder.com/300x400?text=Starfield'
),

-- Rockstar
(
    'Grand Theft Auto VI',
    4,
    2025,
    'Ação-Aventura',
    'PlayStation 5, Xbox Series X|S',
    349.90,
    18,
    'O próximo capítulo da série mais polêmica e aclamada. Retorna a Vice City em uma nova geração',
    'https://via.placeholder.com/300x400?text=GTA6'
),
(
    'Red Dead Redemption 2',
    4,
    2018,
    'Ação-Aventura',
    'PlayStation 5, Xbox Series X|S',
    199.90,
    18,
    'Explore o Oeste selvagem em uma história épica de sobrevivência, lealdade e redenção. Obra-prima narrativa',
    'https://via.placeholder.com/300x400?text=RedDead'
),

-- Valve
(
    'Half-Life 2',
    5,
    2004,
    'FPS',
    'PC',
    9.99,
    18,
    'Um clássico atemporal de ficção científica. Gordon Freeman enfrenta um regime alienígena em uma metrópole opressiva',
    'https://via.placeholder.com/300x400?text=HalfLife'
),
(
    'Portal 2',
    5,
    2011,
    'Puzzle',
    'PC, PlayStation, Xbox',
    19.99,
    7,
    'Resolva puzzles com portais em primeiro lugar em um laboratório hilariante controlado por uma IA psicótica',
    'https://via.placeholder.com/300x400?text=Portal'
),

-- CD Projekt Red
(
    'The Witcher 3: Wild Hunt',
    6,
    2015,
    'RPG Ação',
    'Multiplatforma',
    149.90,
    18,
    'Encarne Geralt de Rivia em uma aventura épica de fantasia medieval. A melhor RPG de sua geração',
    'https://via.placeholder.com/300x400?text=Witcher'
),
(
    'Cyberpunk 2077',
    6,
    2020,
    'RPG Ficção Científica',
    'Multiplatforma',
    199.90,
    18,
    'Viva como um mercenário futurista em Night City. Um mundo dystópico repleto de possibilidades e consequências',
    'https://via.placeholder.com/300x400?text=Cyberpunk'
),

-- Bandai Namco
(
    'Elden Ring',
    7,
    2022,
    'RPG Ação',
    'Multiplatforma',
    299.90,
    16,
    'Uma colaboração épica que redefiniu o gênero. Derrote titãs e torne-se Lorde do Anel em um mundo aberto',
    'https://via.placeholder.com/300x400?text=EldenRing'
),
(
    'Pac-Man',
    7,
    1980,
    'Arcade',
    'Arcade, Multiplatforma',
    0.25,
    3,
    'Um dos primeiros e maiores sucessos da história dos videogames. Fuja dos fantasmas e coma todos os pontos',
    'https://via.placeholder.com/300x400?text=PacMan'
);

-- =====================================================
-- VERIFICAÇÃO DOS DADOS INSERIDOS
-- =====================================================
SELECT COUNT(*) as total_desenvolvedoras FROM desenvolvedoras;
SELECT COUNT(*) as total_jogos FROM jogos;

-- =====================================================
-- CONSULTAS DE EXEMPLO
-- =====================================================

-- Listar todos os jogos com suas desenvolvedoras
SELECT 
    j.titulo,
    j.ano_lancamento,
    j.genero,
    j.preco,
    d.nome as desenvolvedora
FROM jogos j
JOIN desenvolvedoras d ON j.desenvolvedora_id = d.id
ORDER BY j.titulo;

-- Contar quantos jogos cada desenvolvedora tem
SELECT 
    d.nome,
    COUNT(j.id) as quantidade_jogos
FROM desenvolvedoras d
LEFT JOIN jogos j ON d.id = j.desenvolvedora_id
GROUP BY d.id, d.nome
ORDER BY quantidade_jogos DESC;

-- Jogos de uma desenvolvedora específica (exemplo: Nintendo)
SELECT 
    titulo,
    ano_lancamento,
    genero,
    plataforma,
    preco
FROM jogos
WHERE desenvolvedora_id = (SELECT id FROM desenvolvedoras WHERE nome = 'Nintendo')
ORDER BY ano_lancamento DESC;
