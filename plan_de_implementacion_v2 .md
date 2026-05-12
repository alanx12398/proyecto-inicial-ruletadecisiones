## 📋 Plan de Implementación Funcional Extenso: "Antigravity"
🎨 Concepto Visual y UI/UX (Gravity-Zero Design)
El diseño se basa en la idea de elementos que flotan en el espacio profundo.

Paleta de Colores:

Fondo Base: #050505 (Negro absoluto para resaltar el contraste).

Superficies (Cards/Glass): #1A1A1A con opacidad del 80% y desenfoque (BackdropFilter).

Acento Primario: #00E5FF (Cian Eléctrico) para acciones de giro.

Acento Secundario: #7000FF (Púrpura Galáctico) para categorías.

Tratamiento de Imágenes: Las imágenes se obtendrán vía URL. Se implementará un Shimmer Effect (efecto de carga) mientras la imagen se descarga de la web para evitar saltos visuales.

Interactividad: La ruleta no solo girará; tendrá una animación de "entrada" con escalado y opacidad (Fade-in Scale).
### 📂 Estructura de Carpetas (Arquitectura Profesional)


```text
lib/
├── core/
│   ├── api/                # Clientes Firestore y Auth
│   ├── theme/              # Diseño Space-Dark y Glassmorphism
│   ├── network/            # Gestor de conectividad e imágenes web
│   └── utils/              # MathEngine (Lógica de grados/pesos)
├── data/
│   ├── models/             # Mapeo de tablas: USUARIO, CATEGORIA, RULETA...
│   └── repositories/       # Abstracción de datos (Firestore/Local)
├── providers/              # Lógica reactiva (ChangeNotifiers)
│   ├── auth_provider.dart
│   ├── roulette_provider.dart
│   ├── configuration_provider.dart
│   └── history_provider.dart
├── ui/
│   ├── features/
│   │   ├── auth/           # Login, Registro (Tabla USUARIO)
│   │   ├── dashboard/      # Lista de ruletas por CATEGORIA
│   │   ├── editor/         # Configuración de RULETA y OPCION
│   │   └── roulette/       # Pantalla de giro (CustomPaint + Web Images)
│   ├── shared/             # Widgets globales (ShimmerLoaders, CustomModals)
│   └── history/            # Vista de tabla HISTORIAL
└── app.dart                # Configuración de rutas y temas

```

---

### 📋 Fases de Implementación Paso a Paso

#### 🔹 Fase 1: Setup Multiplataforma y Cimientos (Semana 1)

1. **Inicialización:** Crear proyecto Flutter y vincular con Firebase Console para todas las plataformas.
2. **Seguridad Firestore:** Escribir reglas para que las tablas `USUARIO` y `CONFIGURACION` sean privadas, mientras que `CATEGORIA` y `RULETA` (si `es_publica == true`) sean legibles globalmente.
3. **Modelado de Datos:** Generar clases Dart con serialización `toJson` y `fromFirestore` para las 6 tablas, asegurando que los tipos `int` (peso, duracion_ms) y `DateTime` (creado_en, fecha_giro) sean precisos.

#### 🔹 Fase 2: Motor de Carga de Imágenes Web (Semana 1)

1. **Caché de Imágenes:** Implementar `CachedNetworkImage` para todas las URLs de las tablas `CATEGORIA` y `OPCION`.
2. **Fallback Strategy:** Crear un widget `AntigravityImage` que maneje:
* Estado de carga (Shimmer effect).
* Error de URL (Placeholder local de "Antigravity").
* Redimensionamiento dinámico para no saturar la memoria RAM.



#### 🔹 Fase 3: Autenticación y Perfil de Usuario (Semana 2)

1. **Auth Flow:** Implementar Firebase Auth (Email/Password).
2. **Sincronización:** Al crear un usuario, registrar automáticamente en la tabla `USUARIO` de Firestore.
3. **Manejo de Invitados:** Permitir el uso de la app sin registro, almacenando las ruletas solo en local (SQLite o SharedPreferences) y ofreciendo "Migrar a la nube" al registrarse.

#### 🔹 Fase 4: Arquitectura de Categorías y Dashboard (Semana 2)

1. **Inyección de Datos:** Poblar la tabla `CATEGORIA` con datos reales (Nombre, descripción e icono_url de la web).
2. **UI de Dashboard:** Crear un layout responsivo que muestre las categorías. Al seleccionar una, filtrar las ruletas por `categoria_id`.

#### 🔹 Fase 5: El "Antigravity Engine" (Motor de la Ruleta) (Semana 3)

1. **Math Engine:** Crear la lógica que sume los `pesos` de la tabla `OPCION` y asigne un porcentaje del círculo a cada una.
2. **CustomPaint:** Dibujar los arcos dinámicamente usando el `color_hex` de cada opción.
3. **Overlay de Imágenes:** Posicionar las imágenes de la web sobre cada sector usando coordenadas polares convertidas a cartesianas.

#### 🔹 Fase 6: Configuración Dinámica y Física (Semana 3)

1. **Tabla CONFIGURACION:** Crear el módulo para leer los parámetros de giro.
2. **Animation Controller:** Implementar la lógica de desaceleración (Ease-out) basada en el campo `duracion_giro_ms`.
3. **Sonidos:** Integrar `audioplayers` para el efecto de "clic-clic" basado en el campo `sonido_activado`.

#### 🔹 Fase 7: Editor de Ruletas Pro (Semana 4)

1. **CRUD Completo:** Interfaz para crear/editar registros en las tablas `RULETA` y `OPCION`.
2. **Validador de Pesos:** UI que permita ver en tiempo real cómo cambia el tamaño del sector al modificar el `peso`.
3. **Selector de URLs:** Campo para pegar la URL de la imagen de la web y previsualizarla instantáneamente.

#### 🔹 Fase 8: Persistencia y Auditoría de Historial (Semana 4)

1. **Transaction Logic:** Al detenerse la ruleta, realizar una escritura atómica en la tabla `HISTORIAL`.
2. **Auditoría Técnica:** Guardar la `duracion_ms` que tardó el usuario en ver el resultado y la `ip_origen` para detectar patrones de uso multiplataforma.

#### 🔹 Fase 9: Optimización y Performance (Semana 5)

1. **Repaint Boundaries:** Envolver la ruleta en un `RepaintBoundary` para que el resto de la UI no se redibuje durante el giro.
2. **Memory Leaks:** Verificar que los controladores de animación y listeners de Firestore se cierren adecuadamente (`dispose`).
3. **Web CanvasKit:** Forzar el renderizado CanvasKit en la versión Web para asegurar que las sombras y efectos Glassmorphism se vean fluidos a 60 FPS.

#### 🔹 Fase 10: Despliegue y Pruebas Finales (Semana 5)

1. **CI/CD:** Configurar GitHub Actions para generar el APK (Android), el .exe (Windows) y el build web automáticamente.
2. **Smoke Tests:** Validar que una ruleta creada en Android se vea y funcione idénticamente en la versión Web.
3. **Final Delivery:** Generar documentación de las Reglas de Seguridad de Firestore y el esquema de carpetas final.

---

### 📦 Dependencias Finales para `pubspec.yaml`

```yaml
dependencies:
  # Base
  firebase_core: ^latest
  firebase_auth: ^latest
  cloud_firestore: ^latest
  provider: ^latest
  
  # Web & Desktop Images
  cached_network_image: ^latest
  flutter_cache_manager: ^latest
  
  # UI & UX
  shimmer: ^latest
  google_fonts: ^latest
  audioplayers: ^latest
  confetti: ^latest
  
  # Utils
  uuid: ^latest
  intl: ^latest
  http: ^latest # Para obtener la IP de origen (Fase 8)

```

