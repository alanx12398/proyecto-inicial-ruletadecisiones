Este es el plan de ingeniería más exhaustivo para **Antigravity**. Se ha diseñado para ser una guía de referencia técnica completa, integrando el modelo de datos relacional de las imágenes directamente en el flujo de trabajo de Flutter y Firebase.

---

# 📱 Plan de Implementación Maestro: "Antigravity"

Este plan está optimizado para un entorno multiplataforma (Android, iOS, Web, Windows) utilizando **VS Code** y el patrón de arquitectura **Feature-First + Provider**.

## 🎨 1. Estética y Diseño (Concepto "Zero-G")

* **Colores Primarios:** `#0A0E21` (Azul Espacial Profundo), `#00E5FF` (Cian Neón), `#7000FF` (Violeta Cósmico).
* **Diseño de Interfaz:** Glassmorphism (efecto de cristal) para tarjetas, con bordes de neón sutiles.
* **Gestión de Imágenes Web:** Uso de `CachedNetworkImage` con animaciones de carga (Shimmer) para evitar parpadeos al recuperar iconos de categorías u opciones desde URLs externas.

---

## 📊 2. Modelo de Datos (Estructura de Tablas)

A continuación, se detallan las tablas que se implementarán en **Cloud Firestore**, respetando la lógica de las imágenes proporcionadas:

| Tabla | Campos Clave | Propósito |
| --- | --- | --- |
| **USUARIO** | `id`, `nombre`, `email`, `contrasena_hash`, `activo`, `creado_en` | Gestión de perfiles y sesiones. |
| **CATEGORIA** | `id`, `nombre`, `descripcion`, `icono_url`, `activo` | Clasificación web de las ruletas. |
| **RULETA** | `id`, `usuario_id`, `categoria_id`, `titulo`, `es_publica`, `creado_en` | Entidad principal de la decisión. |
| **OPCION** | `id`, `ruleta_id`, `nombre`, `peso`, `color_hex`, `imagen_url`, `activo` | Sectores de la ruleta (pesos determinan el tamaño). |
| **CONFIGURACION** | `id`, `ruleta_id`, `duracion_giro_ms`, `sonido_activado`, `repeticion`, `esquema` | Parámetros físicos y estéticos del giro. |
| **HISTORIAL** | `id`, `ruleta_id`, `opcion_ganadora_id`, `usuario_id`, `fecha_giro`, `ip_origen` | Auditoría y trazabilidad de resultados. |

---

## 📂 3. Estructura de Carpetas (Arquitectura Profesional)

```text
lib/
├── core/
│   ├── theme/              # Configuración de colores y fuentes (Orbitron/Inter)
│   ├── network/            # Gestor de caché para imágenes web y conexión
│   └── utils/              # MathEngine (Cálculo de sectores según pesos)
├── data/
│   ├── models/             # Clases Dart para cada tabla (Usuario, Ruleta, etc.)
│   └── repositories/       # Abstracción de Firestore (CRUD puro)
├── providers/              # Lógica de Estado (ChangeNotifiers)
│   ├── auth_provider.dart
│   ├── roulette_provider.dart  # Motor de giro y gestión de opciones
│   └── history_provider.dart   # Registro de resultados
├── ui/
│   ├── features/
│   │   ├── auth/           # Vistas de acceso basado en tabla USUARIO
│   │   ├── dashboard/      # Lista de CATEGORIAS y RULETAS
│   │   ├── editor/         # Configuración de pesos y URLs de imágenes
│   │   └── roulette/       # El componente CustomPaint interactivo
│   └── shared/             # Widgets globales (ShimmerLoaders, WebImage)
└── main.dart               # Inicialización Multi-plataforma

```

---

## 📋 4. Plan de Implementación por Fases (Extenso)

### 🔹 Fase 1: Infraestructura y Modelado (Días 1-3)

1. **Configuración de Firebase:** Crear proyecto y registrar apps para Android, iOS, Web y Windows.
2. **Generación de Modelos:** Crear las clases Dart que espejen las tablas. Implementar métodos `toFirestore()` y `fromFirestore()`.
3. **Seguridad:** Configurar las *Rules* de Firestore para proteger los datos de `USUARIO` y permitir lectura pública de `CATEGORIA`.

### 🔹 Fase 2: Gestión de Recursos Web (Días 4-6)

1. **Carga Optimizada:** Implementar el componente `AntigravityImage` que gestione URLs externas de las tablas `OPCION` y `CATEGORIA`.
2. **Caché:** Configurar `flutter_cache_manager` para que las imágenes de la web persistan en el dispositivo tras la primera carga.

### 🔹 Fase 3: Autenticación y Perfil (Días 7-9)

1. **Login/Registro:** Conectar con Firebase Auth y sincronizar datos con la tabla `USUARIO`.
2. **Persistencia:** Manejar el estado del usuario para que la sesión se mantenga activa entre reinicios de la app.

### 🔹 Fase 4: El Motor de la Ruleta (Días 10-14)

1. **Lógica Matemática:** Programar el algoritmo que toma los `peso` de la tabla `OPCION` y genera los ángulos: $Grados = 360 \times (\frac{peso}{peso\_total})$.
2. **CustomPaint:** Desarrollar el renderizador que dibuja los sectores usando el `color_hex`.
3. **Animación Física:** Integrar `AnimationController` usando la `duracion_giro_ms` de la tabla `CONFIGURACION`.

### 🔹 Fase 5: Editor y Personalización (Días 15-18)

1. **Editor de Opciones:** Pantalla para añadir ítems, definir pesos y pegar URLs de imágenes web.
2. **Configuración:** Panel para activar/desactivar `sonido_activado` y elegir el `esquema_color`.

### 🔹 Fase 6: Historial y Auditoría (Días 19-21)

1. **Registro de Giros:** Implementar la inserción automática en la tabla `HISTORIAL` al finalizar la animación.
2. **Vista de Resultados:** Pantalla para que el usuario consulte sus decisiones previas, recuperando los nombres de las opciones ganadoras.

### 🔹 Fase 7: Optimización y Lanzamiento (Días 22-25)

1. **Performance Web:** Habilitar CanvasKit para una renderización fluida en navegadores.
2. **Builds:** Generar `.apk` (Android), `.ipa` (iOS), `.exe` (Windows) y despliegue en Firebase Hosting (Web).

---

## 📦 5. Dependencias Técnicas (`pubspec.yaml`)

* **Firebase:** `firebase_core`, `firebase_auth`, `cloud_firestore`.
* **Estado:** `provider`.
* **Imágenes Web:** `cached_network_image`, `shimmer`.
* **Utilidades:** `uuid` (para IDs de tablas), `intl` (fechas), `audioplayers` (feedback sonoro).

---

## 🎯 Prompt Profesional de Desarrollo (Copia este texto)

> Actúa como un Arquitecto de Software Senior experto en Flutter y Firebase. Debo desarrollar la aplicación "Antigravity", una plataforma multiplataforma de toma de decisiones. El sistema debe basarse estrictamente en las siguientes tablas de base de datos en Cloud Firestore: **USUARIO** (id, nombre, email, contrasena_hash, activo, creado_en), **CATEGORIA** (id, nombre, descripcion, icono_url, activo), **RULETA** (id, usuario_id, categoria_id, titulo, es_publica, creado_en), **OPCION** (id, ruleta_id, nombre, peso, color_hex, imagen_url, activo), **CONFIGURACION** (id, ruleta_id, duracion_giro_ms, sonido_activado, repeticion, esquema) e **HISTORIAL** (id, ruleta_id, opcion_ganadora_id, usuario_id, fecha_giro, ip_origen). Implementa una arquitectura Feature-First con Provider para la gestión de estado. La aplicación debe recuperar imágenes desde URLs web de forma optimizada con caché y renderizar una ruleta dinámica mediante CustomPaint, calculando los sectores según el 'peso' de cada opción. No utilices analíticas de terceros ni herramientas de rastreo; utiliza logs estándar y asegura la funcionalidad offline mediante la persistencia de Firestore. Genera una estructura de código limpia, modular y preparada para Android, iOS, Web y Windows.
