-- CreateEnum
CREATE TYPE "RolUsuario" AS ENUM ('admin', 'empleado', 'jugador');

-- CreateEnum
CREATE TYPE "NivelExperiencia" AS ENUM ('novato', 'intermedio', 'veterano');

-- CreateEnum
CREATE TYPE "TipoInteres" AS ENUM ('Wargames', 'Rol', 'Mesa', 'Pintura', 'TCG', 'Torneos');

-- CreateEnum
CREATE TYPE "DiaDisponibilidad" AS ENUM ('lunes_viernes', 'sabados', 'domingos');

-- CreateEnum
CREATE TYPE "HorarioDisponibilidad" AS ENUM ('tardes', 'noches');

-- CreateEnum
CREATE TYPE "TipoEvento" AS ENUM ('torneo', 'iniciacion', 'taller', 'sesion_rol', 'especial');

-- CreateEnum
CREATE TYPE "EstadoEvento" AS ENUM ('programado', 'en_curso', 'finalizado', 'cancelado');

-- CreateEnum
CREATE TYPE "CategoriaProducto" AS ENUM ('wargames', 'rol', 'mesa', 'pintura', 'accesorios');

-- CreateEnum
CREATE TYPE "CanalCaptacion" AS ENUM ('redes_sociales', 'recomendacion', 'web', 'evento', 'otro');

-- CreateEnum
CREATE TYPE "TipoLog" AS ENUM ('success', 'info', 'warning', 'error');

-- CreateEnum
CREATE TYPE "TipoRecompensa" AS ENUM ('descuento', 'producto_gratis', 'acceso_evento', 'otro');

-- CreateTable
CREATE TABLE "usuarios" (
    "id_usuario" UUID NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,
    "apellidos" VARCHAR(100) NOT NULL,
    "email" VARCHAR(150) NOT NULL,
    "password_hash" VARCHAR(255) NOT NULL,
    "telefono" VARCHAR(20),
    "fecha_nacimiento" DATE NOT NULL,
    "rol" "RolUsuario" NOT NULL DEFAULT 'jugador',
    "nivel_experiencia" "NivelExperiencia" NOT NULL DEFAULT 'novato',
    "puntos_fidelidad" INTEGER NOT NULL DEFAULT 0,
    "bio" TEXT,
    "activo" BOOLEAN NOT NULL DEFAULT true,
    "id_usuario_creador" UUID,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id_usuario")
);

-- CreateTable
CREATE TABLE "intereses" (
    "id_interes" SERIAL NOT NULL,
    "nombre_interes" "TipoInteres" NOT NULL,
    "descripcion" TEXT,

    CONSTRAINT "intereses_pkey" PRIMARY KEY ("id_interes")
);

-- CreateTable
CREATE TABLE "usuario_intereses" (
    "id_usuario" UUID NOT NULL,
    "id_interes" INTEGER NOT NULL,
    "juegos_especificos" TEXT,

    CONSTRAINT "usuario_intereses_pkey" PRIMARY KEY ("id_usuario","id_interes")
);

-- CreateTable
CREATE TABLE "disponibilidades" (
    "id_disponibilidad" SERIAL NOT NULL,
    "id_usuario" UUID NOT NULL,
    "dia_semana" "DiaDisponibilidad" NOT NULL,
    "horario" "HorarioDisponibilidad" NOT NULL,

    CONSTRAINT "disponibilidades_pkey" PRIMARY KEY ("id_disponibilidad")
);

-- CreateTable
CREATE TABLE "eventos" (
    "id_evento" UUID NOT NULL,
    "titulo" VARCHAR(200) NOT NULL,
    "descripcion" TEXT,
    "tipo_evento" "TipoEvento" NOT NULL,
    "fecha" DATE NOT NULL,
    "hora_inicio" TIME NOT NULL,
    "hora_fin" TIME,
    "lugar" VARCHAR(150) NOT NULL,
    "costo" DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    "cupo_maximo" INTEGER NOT NULL,
    "estado" "EstadoEvento" NOT NULL DEFAULT 'programado',
    "sistema_juego" VARCHAR(100),
    "puntos_premio_1" INTEGER NOT NULL DEFAULT 500,
    "puntos_premio_2" INTEGER NOT NULL DEFAULT 300,
    "puntos_premio_3" INTEGER NOT NULL DEFAULT 200,
    "puntos_participacion" INTEGER NOT NULL DEFAULT 50,
    "id_creador" UUID NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "eventos_pkey" PRIMARY KEY ("id_evento")
);

-- CreateTable
CREATE TABLE "inscripciones" (
    "id_inscripcion" UUID NOT NULL,
    "id_evento" UUID NOT NULL,
    "id_usuario" UUID NOT NULL,
    "faccion" VARCHAR(100),
    "nombre_ejercito" VARCHAR(150),
    "asistio" BOOLEAN NOT NULL DEFAULT false,
    "posicion_final" INTEGER,
    "es_ganador" BOOLEAN NOT NULL DEFAULT false,
    "puntos_obtenidos" INTEGER NOT NULL DEFAULT 0,
    "fecha_inscripcion" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "inscripciones_pkey" PRIMARY KEY ("id_inscripcion")
);

-- CreateTable
CREATE TABLE "productos" (
    "id_producto" UUID NOT NULL,
    "nombre" VARCHAR(200) NOT NULL,
    "marca" VARCHAR(100),
    "categoria" "CategoriaProducto" NOT NULL,
    "descripcion" TEXT,
    "precio" DECIMAL(10,2) NOT NULL,
    "precio_original" DECIMAL(10,2),
    "stock" INTEGER NOT NULL DEFAULT 0,
    "stock_minimo" INTEGER NOT NULL DEFAULT 3,
    "popular" BOOLEAN NOT NULL DEFAULT false,
    "es_nuevo" BOOLEAN NOT NULL DEFAULT false,
    "imagen_url" VARCHAR(500),
    "activo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "productos_pkey" PRIMARY KEY ("id_producto")
);

-- CreateTable
CREATE TABLE "captacion_novatos" (
    "id_captacion" UUID NOT NULL,
    "id_usuario" UUID NOT NULL,
    "canal_captacion" "CanalCaptacion" NOT NULL,
    "fecha_primera_visita" DATE NOT NULL,
    "asistio_sesion_demo" BOOLEAN NOT NULL DEFAULT false,
    "fecha_demo" DATE,
    "regreso" BOOLEAN NOT NULL DEFAULT false,
    "realizo_compra" BOOLEAN NOT NULL DEFAULT false,
    "es_recurrente" BOOLEAN NOT NULL DEFAULT false,
    "rating_experiencia" SMALLINT,
    "comentarios" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "captacion_novatos_pkey" PRIMARY KEY ("id_captacion")
);

-- CreateTable
CREATE TABLE "logs_actividad" (
    "id_log" BIGSERIAL NOT NULL,
    "tipo" "TipoLog" NOT NULL,
    "accion" VARCHAR(100) NOT NULL,
    "mensaje" TEXT NOT NULL,
    "id_usuario" UUID,
    "ip_address" VARCHAR(45),
    "datos_extra" JSONB,
    "fecha_hora" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "logs_actividad_pkey" PRIMARY KEY ("id_log")
);

-- CreateTable
CREATE TABLE "recompensas" (
    "id_recompensa" SERIAL NOT NULL,
    "nombre" VARCHAR(150) NOT NULL,
    "descripcion" TEXT,
    "costo_puntos" INTEGER NOT NULL,
    "tipo" "TipoRecompensa" NOT NULL,
    "valor_descuento" DECIMAL(5,2),
    "activa" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "recompensas_pkey" PRIMARY KEY ("id_recompensa")
);

-- CreateTable
CREATE TABLE "canjes" (
    "id_canje" UUID NOT NULL,
    "id_usuario" UUID NOT NULL,
    "id_recompensa" INTEGER NOT NULL,
    "puntos_usados" INTEGER NOT NULL,
    "fecha_canje" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "utilizado" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "canjes_pkey" PRIMARY KEY ("id_canje")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_email_key" ON "usuarios"("email");

-- CreateIndex
CREATE UNIQUE INDEX "intereses_nombre_interes_key" ON "intereses"("nombre_interes");

-- CreateIndex
CREATE UNIQUE INDEX "inscripciones_id_evento_id_usuario_key" ON "inscripciones"("id_evento", "id_usuario");

-- CreateIndex
CREATE UNIQUE INDEX "captacion_novatos_id_usuario_key" ON "captacion_novatos"("id_usuario");

-- AddForeignKey
ALTER TABLE "usuarios" ADD CONSTRAINT "usuarios_id_usuario_creador_fkey" FOREIGN KEY ("id_usuario_creador") REFERENCES "usuarios"("id_usuario") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "usuario_intereses" ADD CONSTRAINT "usuario_intereses_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id_usuario") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "usuario_intereses" ADD CONSTRAINT "usuario_intereses_id_interes_fkey" FOREIGN KEY ("id_interes") REFERENCES "intereses"("id_interes") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "disponibilidades" ADD CONSTRAINT "disponibilidades_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id_usuario") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "eventos" ADD CONSTRAINT "eventos_id_creador_fkey" FOREIGN KEY ("id_creador") REFERENCES "usuarios"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inscripciones" ADD CONSTRAINT "inscripciones_id_evento_fkey" FOREIGN KEY ("id_evento") REFERENCES "eventos"("id_evento") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inscripciones" ADD CONSTRAINT "inscripciones_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id_usuario") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "captacion_novatos" ADD CONSTRAINT "captacion_novatos_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id_usuario") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "logs_actividad" ADD CONSTRAINT "logs_actividad_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id_usuario") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "canjes" ADD CONSTRAINT "canjes_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id_usuario") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "canjes" ADD CONSTRAINT "canjes_id_recompensa_fkey" FOREIGN KEY ("id_recompensa") REFERENCES "recompensas"("id_recompensa") ON DELETE CASCADE ON UPDATE CASCADE;
