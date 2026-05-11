-- ============================================================
--  BASE DE DATOS: bdruletadecisiones
--  Proyecto: Ruleta de Decisiones
--  Motor: PostgreSQL 15+
--  Generado por: DBA Assistant
-- ============================================================

-- Crear y conectar a la base de datos
CREATE DATABASE bdruletadecisiones
    WITH ENCODING = 'UTF8'
    LC_COLLATE = 'es_ES.UTF-8'
    LC_CTYPE   = 'es_ES.UTF-8'
    TEMPLATE   = template0;

\connect bdruletadecisiones;

-- ============================================================
--  EXTENSION
-- ============================================================
CREATE EXTENSION IF NOT EXISTS "pgcrypto";   -- gen_random_uuid()

-- ============================================================
--  1. CATEGORIA
-- ============================================================
CREATE TABLE categoria (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    nombre      VARCHAR(80)  NOT NULL,
    icono       VARCHAR(50),
    color_hex   CHAR(7),
    descripcion TEXT,
    activa      BOOLEAN      NOT NULL DEFAULT TRUE,
    creado_en   TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_categoria     PRIMARY KEY (id),
    CONSTRAINT uk_categoria_nom UNIQUE (nombre),
    CONSTRAINT ck_color_hex     CHECK (color_hex ~ '^#[0-9A-Fa-f]{6}$')
);

-- ============================================================
--  2. USUARIO
-- ============================================================
CREATE TABLE usuario (
    id              UUID         NOT NULL DEFAULT gen_random_uuid(),
    nombre          VARCHAR(100) NOT NULL,
    email           VARCHAR(255) NOT NULL,
    contrasena_hash CHAR(60)     NOT NULL,
    rol             VARCHAR(20)  NOT NULL DEFAULT 'usuario',
    activo          BOOLEAN      NOT NULL DEFAULT TRUE,
    creado_en       TIMESTAMP    NOT NULL DEFAULT NOW(),
    ultimo_acceso   TIMESTAMP,
    CONSTRAINT pk_usuario     PRIMARY KEY (id),
    CONSTRAINT uk_usuario_email UNIQUE (email),
    CONSTRAINT ck_usuario_rol   CHECK (rol IN ('admin','usuario','invitado'))
);

-- ============================================================
--  3. RULETA
-- ============================================================
CREATE TABLE ruleta (
    id             UUID         NOT NULL DEFAULT gen_random_uuid(),
    usuario_id     UUID         NOT NULL,
    categoria_id   UUID,
    titulo         VARCHAR(120) NOT NULL,
    descripcion    TEXT,
    es_publica     BOOLEAN      NOT NULL DEFAULT FALSE,
    veces_girada   INTEGER      NOT NULL DEFAULT 0,
    creado_en      TIMESTAMP    NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_ruleta            PRIMARY KEY (id),
    CONSTRAINT fk_ruleta_usuario    FOREIGN KEY (usuario_id)   REFERENCES usuario (id)   ON DELETE CASCADE,
    CONSTRAINT fk_ruleta_categoria  FOREIGN KEY (categoria_id) REFERENCES categoria (id) ON DELETE SET NULL,
    CONSTRAINT ck_veces_girada      CHECK (veces_girada >= 0)
);

-- ============================================================
--  4. OPCION
-- ============================================================
CREATE TABLE opcion (
    id         UUID         NOT NULL DEFAULT gen_random_uuid(),
    ruleta_id  UUID         NOT NULL,
    texto      VARCHAR(200) NOT NULL,
    peso       SMALLINT     NOT NULL DEFAULT 1,
    color_hex  CHAR(7),
    activa     BOOLEAN      NOT NULL DEFAULT TRUE,
    orden      SMALLINT,
    CONSTRAINT pk_opcion        PRIMARY KEY (id),
    CONSTRAINT fk_opcion_ruleta FOREIGN KEY (ruleta_id) REFERENCES ruleta (id) ON DELETE CASCADE,
    CONSTRAINT ck_peso          CHECK (peso BETWEEN 1 AND 100),
    CONSTRAINT ck_opcion_color  CHECK (color_hex ~ '^#[0-9A-Fa-f]{6}$')
);

-- ============================================================
--  5. CONFIGURACION
-- ============================================================
CREATE TABLE configuracion (
    id                  UUID        NOT NULL DEFAULT gen_random_uuid(),
    ruleta_id           UUID        NOT NULL,
    duracion_giro_ms    INTEGER     NOT NULL DEFAULT 3000,
    permitir_repetir    BOOLEAN     NOT NULL DEFAULT TRUE,
    sonido_activo       BOOLEAN     NOT NULL DEFAULT TRUE,
    color_esquema       VARCHAR(30),
    mostrar_ganador_ms  INTEGER     NOT NULL DEFAULT 2000,
    CONSTRAINT pk_configuracion        PRIMARY KEY (id),
    CONSTRAINT fk_configuracion_ruleta FOREIGN KEY (ruleta_id) REFERENCES ruleta (id) ON DELETE CASCADE,
    CONSTRAINT uk_configuracion_ruleta UNIQUE (ruleta_id),
    CONSTRAINT ck_duracion_giro        CHECK (duracion_giro_ms  BETWEEN 500 AND 30000),
    CONSTRAINT ck_mostrar_ganador      CHECK (mostrar_ganador_ms BETWEEN 500 AND 10000)
);

-- ============================================================
--  6. HISTORIAL
-- ============================================================
CREATE TABLE historial (
    id          UUID      NOT NULL DEFAULT gen_random_uuid(),
    ruleta_id   UUID      NOT NULL,
    opcion_id   UUID      NOT NULL,
    usuario_id  UUID,
    girado_en   TIMESTAMP NOT NULL DEFAULT NOW(),
    duracion_ms INTEGER,
    ip_origen   INET,
    CONSTRAINT pk_historial        PRIMARY KEY (id),
    CONSTRAINT fk_historial_ruleta FOREIGN KEY (ruleta_id)  REFERENCES ruleta  (id) ON DELETE CASCADE,
    CONSTRAINT fk_historial_opcion FOREIGN KEY (opcion_id)  REFERENCES opcion  (id) ON DELETE RESTRICT,
    CONSTRAINT fk_historial_usuario FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE SET NULL,
    CONSTRAINT ck_duracion_ms      CHECK (duracion_ms > 0)
);

-- ============================================================
--  7. ETIQUETA  (tags reutilizables entre ruletas)
-- ============================================================
CREATE TABLE etiqueta (
    id        UUID        NOT NULL DEFAULT gen_random_uuid(),
    nombre    VARCHAR(60) NOT NULL,
    color_hex CHAR(7),
    CONSTRAINT pk_etiqueta      PRIMARY KEY (id),
    CONSTRAINT uk_etiqueta_nom  UNIQUE (nombre),
    CONSTRAINT ck_etiq_color    CHECK (color_hex ~ '^#[0-9A-Fa-f]{6}$')
);

-- ============================================================
--  8. RULETA_ETIQUETA  (tabla pivot N:M)
-- ============================================================
CREATE TABLE ruleta_etiqueta (
    ruleta_id   UUID NOT NULL,
    etiqueta_id UUID NOT NULL,
    CONSTRAINT pk_ruleta_etiqueta       PRIMARY KEY (ruleta_id, etiqueta_id),
    CONSTRAINT fk_re_ruleta             FOREIGN KEY (ruleta_id)   REFERENCES ruleta   (id) ON DELETE CASCADE,
    CONSTRAINT fk_re_etiqueta           FOREIGN KEY (etiqueta_id) REFERENCES etiqueta (id) ON DELETE CASCADE
);

-- ============================================================
--  9. COMPARTIDO  (ruletas compartidas con otros usuarios)
-- ============================================================
CREATE TABLE compartido (
    id              UUID        NOT NULL DEFAULT gen_random_uuid(),
    ruleta_id       UUID        NOT NULL,
    usuario_id      UUID        NOT NULL,
    permiso         VARCHAR(20) NOT NULL DEFAULT 'lectura',
    compartido_en   TIMESTAMP   NOT NULL DEFAULT NOW(),
    expira_en       TIMESTAMP,
    CONSTRAINT pk_compartido         PRIMARY KEY (id),
    CONSTRAINT fk_comp_ruleta        FOREIGN KEY (ruleta_id)  REFERENCES ruleta   (id) ON DELETE CASCADE,
    CONSTRAINT fk_comp_usuario       FOREIGN KEY (usuario_id) REFERENCES usuario  (id) ON DELETE CASCADE,
    CONSTRAINT uk_comp_ruleta_usuario UNIQUE (ruleta_id, usuario_id),
    CONSTRAINT ck_permiso            CHECK (permiso IN ('lectura','edicion','admin'))
);

-- ============================================================
-- 10. NOTIFICACION
-- ============================================================
CREATE TABLE notificacion (
    id          UUID        NOT NULL DEFAULT gen_random_uuid(),
    usuario_id  UUID        NOT NULL,
    tipo        VARCHAR(40) NOT NULL,
    mensaje     TEXT        NOT NULL,
    leida       BOOLEAN     NOT NULL DEFAULT FALSE,
    creado_en   TIMESTAMP   NOT NULL DEFAULT NOW(),
    leida_en    TIMESTAMP,
    CONSTRAINT pk_notificacion        PRIMARY KEY (id),
    CONSTRAINT fk_notif_usuario       FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE CASCADE,
    CONSTRAINT ck_notif_tipo          CHECK (tipo IN ('giro','compartido','comentario','sistema'))
);

-- ============================================================
--  ÍNDICES
-- ============================================================
-- USUARIO
CREATE INDEX idx_usuario_email      ON usuario  (email);

-- RULETA
CREATE INDEX idx_ruleta_usuario     ON ruleta   (usuario_id);
CREATE INDEX idx_ruleta_categoria   ON ruleta   (categoria_id);
CREATE INDEX idx_ruleta_publica     ON ruleta   (es_publica) WHERE es_publica = TRUE;

-- OPCION
CREATE INDEX idx_opcion_ruleta      ON opcion   (ruleta_id);

-- HISTORIAL
CREATE INDEX idx_hist_ruleta        ON historial (ruleta_id);
CREATE INDEX idx_hist_opcion        ON historial (opcion_id);
CREATE INDEX idx_hist_usuario       ON historial (usuario_id);
CREATE INDEX idx_hist_girado_en     ON historial (girado_en DESC);

-- RULETA_ETIQUETA
CREATE INDEX idx_re_etiqueta        ON ruleta_etiqueta (etiqueta_id);

-- COMPARTIDO
CREATE INDEX idx_comp_usuario       ON compartido (usuario_id);

-- NOTIFICACION
CREATE INDEX idx_notif_usuario      ON notificacion (usuario_id);
CREATE INDEX idx_notif_leida        ON notificacion (usuario_id, leida) WHERE leida = FALSE;

-- ============================================================
--  DATOS SEMILLA (seed)
-- ============================================================
INSERT INTO categoria (nombre, icono, color_hex, descripcion) VALUES
  ('Personal',  'ti-user',       '#7F77DD', 'Decisiones de vida personal'),
  ('Trabajo',   'ti-briefcase',  '#1D9E75', 'Decisiones laborales'),
  ('Juegos',    'ti-device-gamepad', '#D85A30', 'Entretenimiento y juegos'),
  ('Comida',    'ti-fork',       '#BA7517', 'Qué comer hoy'),
  ('Educación', 'ti-book',       '#378ADD', 'Estudio y aprendizaje');

-- ============================================================
--  FIN DEL SCRIPT
-- ============================================================
