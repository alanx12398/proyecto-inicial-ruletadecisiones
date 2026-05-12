# 📱 Plan de Implementación Maestro: "Antigravity" 

Este plan está diseñado para un entorno multiplataforma (Android, iOS, Web, Windows) utilizando el patrón de arquitectura **Feature-First + Provider**.

## 📊 1. Modelo de Datos Relacional (Tablas en Firestore)

La base de datos se estructurará en **Cloud Firestore** siguiendo fielmente las imágenes proporcionadas:

| Tabla | Campos Clave | Propósito |
| --- | --- | --- |
| **USUARIO** | `id`, `nombre`, `email`, `contrasena_hash`, `activo`, `creado_en` | Perfiles de usuario y credenciales. |
| **CATEGORIA** | `id`, `nombre`, `descripcion`, `icono_url`, `activo` | Clasificación temática (imágenes desde la web). |
| **RULETA** | `id`, `usuario_id`, `categoria_id`, `titulo`, `es_publica`, `creado_en` | Entidad de decisión creada por el usuario. |
| **OPCION** | `id`, `ruleta_id`, `nombre`, `peso`, `color_hex`, `imagen_url`, `activo` | Sectores dinámicos (imágenes desde la web). |
| **CONFIGURACION** | `id`, `ruleta_id`, `duracion_giro_ms`, `sonido_activado`, `esquema` | Parámetros físicos y estéticos del motor de giro. |
| **HISTORIAL** | `id`, `ruleta_id`, `opcion_ganadora_id`, `usuario_id`, `fecha_giro`, `ip` | Auditoría de resultados y estadísticas de uso. |

---

## 📂 2. Estructura de Carpetas Profesional

```text
lib/
├── core/
│   ├── theme/              # Diseño Space-Dark y Glassmorphism
│   ├── network/            # Gestor de caché para imágenes externas (Web)
│   └── utils/              # MathEngine.dart (Cálculo de grados según pesos)
├── data/
│   ├── models/             # Mapeo de las 6 tablas (Usuario, Ruleta, etc.)
│   └── repositories/       # Servicios CRUD para Firebase
├── providers/              # Lógica de Estado (ChangeNotifiers)
│   ├── auth_provider.dart
│   ├── roulette_provider.dart
│   ├── config_provider.dart
│   └── history_provider.dart
├── ui/
│   ├── features/
│   │   ├── auth/           # Login y Registro (Tabla USUARIO)
│   │   ├── dashboard/      # Lista de CATEGORIAS y RULETAS
│   │   ├── editor/         # Configuración de pesos y URLs de imágenes
│   │   └── roulette/       # Componente CustomPaint con carga de imágenes web
│   └── shared/             # Widgets globales (ShimmerLoaders, CustomModals)
└── app.dart                # Configuración de rutas y MultiProvider

```

---

## 📋 3. Plan de Implementación por Fases

### 🔹 Fase 1: Cimientos y Configuración Multiplataforma

* **Firebase Setup:** Crear el proyecto y registrar las aplicaciones para Android, iOS, Web y Windows.
* **Seguridad Firestore:** Escribir reglas para que los usuarios solo editen sus propias ruletas, pero puedan leer las marcadas como `es_publica == true`.
* **SDKs:** Instalación de Flutter y configuración de los binarios para escritorio (Windows) y web.

### 🔹 Fase 2: Modelado Atómico de Datos

* **Data Models:** Crear clases Dart para las 6 tablas con métodos `fromFirestore()` y `toFirestore()`.
* **Manejo de UUIDs:** Implementar la generación de IDs únicos para asegurar que cada `RULETA` y `OPCION` sea rastreable globalmente.

### 🔹 Fase 3: Motor de Carga de Imágenes Web

* **Caché Avanzado:** Implementar `CachedNetworkImage` para los campos `icono_url` y `imagen_url`.
* **Feedback Visual:** Crear un widget personalizado con **Shimmer Effect** que se muestre mientras la imagen se descarga de la web, evitando saltos de diseño.

### 🔹 Fase 4: Autenticación y Perfil de Usuario

* **Flujo de Sesión:** Registro y Login conectado a la tabla **USUARIO**.
* **Persistencia:** Implementar el guardado del token de Firebase Auth para que el usuario no deba loguearse en cada apertura.

### 🔹 Fase 5: Dashboard y Navegación por Categorías

* **Categorización:** Mostrar el Grid de la tabla **CATEGORIA** recuperando sus iconos de la web.
* **Filtrado:** Lógica para mostrar solo las ruletas vinculadas a la `categoria_id` seleccionada.

### 🔹 Fase 6: El "Antigravity Engine" (Motor de Giro)

* **Lógica de Pesos:** Implementar la función matemática que asigna grados según el campo `peso` de la tabla **OPCION**.
* **Renderizado:** Uso de `CustomPaint` para dibujar los arcos circulares con los colores definidos en `color_hex`.
* **Overlay:** Posicionar las imágenes web sobre cada sector usando coordenadas polares.

### 🔹 Fase 7: Configuración Dinámica y Física

* **Parámetros de Giro:** Vincular el `AnimationController` con el campo `duracion_giro_ms` de la tabla **CONFIGURACION**.
* **Sonido y Esquema:** Aplicar los booleanos de `sonido_activado` y los estilos de `esquema_color` en tiempo real.

### 🔹 Fase 8: Editor de Ruletas y Opciones

* **CRUD de Opciones:** Interfaz para que el usuario añada opciones, asigne pesos y pegue URLs de imágenes externas.
* **Vista Previa:** Generar una miniatura de la ruleta antes de guardar los cambios en Firestore.

### 🔹 Fase 9: Persistencia del Historial y Resultados

* **Registro Atómico:** Al detenerse el giro, el sistema debe registrar automáticamente el resultado en la tabla **HISTORIAL**.
* **Auditoría:** Capturar la fecha exacta (`fecha_giro`) y la IP o dispositivo de origen para estadísticas del usuario.

### 🔹 Fase 10: Optimización, Web CanvasKit y Despliegue

* **Optimización Web:** Forzar el renderizado CanvasKit en la versión Web para asegurar que las animaciones de la ruleta sean fluidas a 60 FPS.
* **Despliegue CI/CD:** Configurar Firebase Hosting para la web y generar ejecutables para Windows y móviles.

---

## 🎯 4. Prompt Profesional de Desarrollo (Copia este texto)

Actúa como un Senior Fullstack Developer y Arquitecto de Software experto en Flutter y Firebase. Debo desarrollar la aplicación multiplataforma "Antigravity", una suite de toma de decisiones. El sistema debe basarse estrictamente en las siguientes tablas de base de datos relacional en Cloud Firestore: **USUARIO** (id, nombre, email, contrasena_hash, activo, creado_en), **CATEGORIA** (id, nombre, descripcion, icono_url, activo), **RULETA** (id, usuario_id, categoria_id, titulo, es_publica, creado_en), **OPCION** (id, ruleta_id, nombre, peso, color_hex, imagen_url, activo), **CONFIGURACION** (id, ruleta_id, duracion_giro_ms, sonido_activado, repeticion, esquema_color) e **HISTORIAL** (id, ruleta_id, opcion_ganadora_id, usuario_id, fecha_giro, ip_origen).

Implementa una arquitectura **Feature-First** con **Provider** para la gestión de estado reactivo. La aplicación debe recuperar imágenes dinámicamente desde URLs web (implementando caché y placeholders tipo Shimmer) para las opciones y categorías. La lógica central debe renderizar una ruleta interactiva mediante **CustomPaint**, calculando el tamaño de los sectores proporcionalmente al campo 'peso' de la tabla OPCION. No incluyas analíticas de terceros ni Crashlytics; utiliza logs de consola estándar y asegura que la aplicación sea responsiva y funcional en Android, iOS, Web y Windows, garantizando la persistencia offline de los datos mediante Firestore.
