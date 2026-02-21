# GoblinHub CodeCasters

Aplicación fullstack desarrollada con tecnologías modernas para el frontend y backend.

## 📚 Stack Tecnológico

### Frontend

- **React Native** - Framework para desarrollo mobile multiplataforma

- **Vite** - Build tool rápido y moderno

- **JavaScript/TypeScript** - Lenguaje de programación

### Backend

- **Nest.js** - Framework progresivo de Node.js para construir aplicaciones del lado del servidor

- **Node.js** - Runtime de JavaScript

- **npm** - Gestor de dependencias

---

## ✅ Requisitos Previos

Antes de comenzar, asegúrate de tener instalados los siguientes programas:

- **Node.js** (versión 16.x o superior)
  - Descargar desde: https://nodejs.org/

- **npm** (incluido con Node.js)

- **Git** para clonar el repositorio

- **Un editor de código** (recomendado: VS Code)

Verifica la instalación ejecutando:

```bash
node --version
npm --version
```

---

## 🚀 Instalación

### 1. Clonar el Repositorio

```bash
git clone <URL_DEL_REPOSITORIO>

cd GoblinHub_CodeCasters
```

### 2. Configurar Backend (Nest.js)

```bash
# Navegar a la carpeta del backend
cd goblinhub-api

# Instalar dependencias
npm install

# Crear archivo de configuración (si es necesario)
cp .env.example .env
```

### 3. Configurar Frontend (React Native + Vite)

```bash
# Navegar a la carpeta del frontend
cd ../goblinhub-web

# Instalar dependencias
npm install

# Crear archivo de configuración (si es necesario)
cp .env.example .env
```

---

## ⚙️ Configuración

### Backend (Nest.js)

1. **Variables de Entorno**
   - Editar el archivo `.env` en la raíz del backend
   - Configurar puertos, bases de datos, claves API, etc.
   Ejemplo de `.env`:
   ```env

   PORT=3000

   DATABASE_URL=mongodb://localhost:27017/goblin-hub

   JWT_SECRET=your_secret_key_here

   NODE_ENV=development
   ```

2. **Base de Datos** (si aplica)
   - Asegúrate de tener MongoDB, PostgreSQL u otra BD ejecutándose

   - Ejecuta las migraciones si es necesario:

     ```bash
     npm run typeorm migration:run
     ```

### Frontend (React Native + Vite)

1. **Variables de Entorno**
   - Editar el archivo `.env` en la raíz del frontend
   - Configurar URL de la API, claves públicas, etc.
   Ejemplo de `.env`:

   ```env
   VITE_API_URL=http://localhost:3000

   VITE_APP_NAME=GoblinHub
   ```

2. **Dependencias Adicionales**
   - Si el proyecto requiere librerías nativas, ejecuta:

     ```bash
     cd ios && pod install && cd ..  # Para iOS (macOS)
     ```

---

## ▶️ Ejecutar la Aplicación

### Backend

```bash
# Desde la carpeta /goblinhub-api

# Modo desarrollo (con hot reload)
npm run start:dev

# Modo producción
npm run build
npm run start:prod

# El servidor estará disponible en: http://localhost:3000
```

### Frontend

```bash
# Desde la carpeta /goblinhub-web

# Modo desarrollo
npm run dev

# Compilar para producción
npm run build

# Preview de la build de producción
npm run preview

# El proyecto estará disponible en: http://localhost:5173 (puerto por defecto de Vite)
```

### Ejecutar Ambos Simultáneamente (Opcional)

Desde la raíz del proyecto, si tienes un script configurado:

```bash
# Si tienes npm workspaces o un script en el package.json principal
npm run dev
```

O abre dos terminales:

**Terminal 1 - Backend:**

```bash
cd goblinhub-api && npm run start:dev
```

**Terminal 2 - Frontend:**

```bash
cd goblinhub-web && npm run dev
```

---

## 📁 Estructura del Proyecto

```
GoblinHub_CodeCasters/
├── goblinhub-api/        # Aplicación Nest.js
│   ├── src/
│   │   ├── main.ts
│   │   ├── app.module.ts
│   │   └── ...módulos
│   ├── .env.example
│   ├── package.json
│   └── tsconfig.json
├── goblinhub-web/        # Aplicación React Native + Vite
│   ├── src/
│   │   ├── main.tsx
│   │   ├── App.tsx
│   │   └── ...componentes
│   ├── .env.example
│   ├── package.json
│   ├── vite.config.ts
│   └── tsconfig.json
├── README.md
└── LICENSE


```

---

## 🔧 Scripts Útiles

### Backend

```bash
npm run start:dev    # Inicia en modo desarrollo

npm run build        # Compila el código

npm run start:prod   # Inicia en modo producción

npm run test         # Ejecuta tests

npm run lint         # Ejecuta linter
```

### Frontend

```bash
npm run dev      # Inicia servidor de desarrollo

npm run build    # Compila para producción

npm run preview  # Previsualiza la compilación

npm run lint     # Ejecuta linter

npm run type     # Verifica tipos (TypeScript)
```

---

## 📝 Notas Importantes

- Asegúrate de que los puertos **3000** (backend) y **5173** (frontend) estén disponibles

- Si usas CORS, configúralo correctamente en el backend

- Revisa los archivos `.env.example` para conocer todas las variables necesarias

- Mantén las dependencias actualizadas ejecutando `npm update`

---

**Actualizado:** 13 de febrero de 2026asasa
