## 📱 Plan de Implementación Extenso: "Antigravity"

### 🎨 1. Concepto Visual y UI/UX (Gravity-Zero Design)

El diseño se basa en la idea de elementos que flotan en el espacio profundo.

* **Paleta de Colores:**
* **Fondo Base:** `#050505` (Negro absoluto para resaltar el contraste).
* **Superficies (Cards/Glass):** `#1A1A1A` con opacidad del 80% y desenfoque (BackdropFilter).
* **Acento Primario:** `#00E5FF` (Cian Eléctrico) para acciones de giro.
* **Acento Secundario:** `#7000FF` (Púrpura Galáctico) para categorías.


* **Tratamiento de Imágenes:** Las imágenes se obtendrán vía URL. Se implementará un **Shimmer Effect** (efecto de carga) mientras la imagen se descarga de la web para evitar saltos visuales.
* **Interactividad:** La ruleta no solo girará; tendrá una animación de "entrada" con escalado y opacidad (Fade-in Scale).

---

### 📂 2. Estructura de Carpetas (Arquitectura Profesional)

```text
lib/
├── core/
│   ├── theme/              # AntigravityTheme (Light/Dark configs)
│   ├── constants/          # AppConstants, FirebaseKeys
│   ├── network/            # Verificador de conexión y helpers de imagen
│   └── utils/              # MathEngine (Cálculos de grados y pesos)
├── data/                   # Capa de datos pura (Modelos + Repositorios)
│   ├── models/             # Clases con fromFirestore() y toFirestore()
│   └── repositories/       # Abstracción de llamadas a Firebase
├── providers/              # Gestores de estado (Lógica de Negocio)
│   ├── auth_provider.dart
│   ├── roulette_manager.dart
│   ├── history_provider.dart
│   └── theme_provider.dart
├── ui/                     # Capa de presentación
│   ├── features/
│   │   ├── auth/           # LoginView, RegisterView
│   │   ├── dashboard/      # RouletteListView, CategoryFilter
│   │   ├── editor/         # EditRouletteView, OptionList
│   │   └── roulette/       # SpinView (La ruleta interactiva)
│   ├── shared/             # Widgets globales (CustomButtons, WebImageLoader)
│   └── history/            # HistoryListView
└── app.dart                # Configuración de MaterialApp y Router

```

---

### 📦 3. Configuración Técnica (`pubspec.yaml`)

```yaml
dependencies:
  flutter:
    sdk: flutter
  # Backend & Auth
  firebase_core: ^latest
  firebase_auth: ^latest
  cloud_firestore: ^latest
  # State Management
  provider: ^latest
  # Imágenes y Recursos Web
  cached_network_image: ^latest  # Fundamental para imágenes web con caché
  flutter_svg: ^latest           # Para los iconos de la tabla CATEGORIA
  # Utilidades
  uuid: ^latest                  # Para generar los ids de las tablas
  intl: ^latest                  # Formateo de fechas para HISTORIAL
  # Animaciones y UI
  google_fonts: ^latest
  shimmer: ^latest               # Efecto de carga para imágenes web
  confetti: ^latest              # Celebración al obtener resultado

```

---

### 📋 4. Fases de Implementación Paso a Paso

#### 🔹 Fase 1: Infraestructura de Datos y Firebase

1. **Configuración Multiplataforma:** Configurar Firebase para los 4 entornos (Android, iOS, Web, Windows). En Windows, asegurar el soporte de Firebase mediante `firebase_core_desktop`.
2. **Repositorios de Datos:** Crear la lógica de "CRUD" para las 6 tablas.
* *Importante:* Las imágenes de las categorías (`icono` en la tabla CATEGORIA) se almacenarán como strings de URL.


3. **Modelado de Pesos:** Implementar la lógica donde el `peso` (int) de la tabla OPCION determine el tamaño del arco en la ruleta (Grados = $360 * (peso / peso\_total)$).

#### 🔹 Fase 2: Autenticación y Perfil de Usuario

1. **Firebase Auth:** Implementar login con Email y Password.
2. **Sincronización:** Al registrarse, se crea automáticamente la entrada en la tabla USUARIO con el campo `creado_en` y el `id` vinculado al UID de Firebase.
3. **Estado Global:** El `AuthProvider` expondrá el objeto `Usuario` a toda la aplicación.

#### 🔹 Fase 3: El Motor de la Ruleta (Antigravity Engine)

1. **CustomPainter:** Desarrollar el widget que dibuja la ruleta.
2. **Carga de Imágenes Web:** Implementar un widget `UniversalImage` que use `cached_network_image` para mostrar los iconos de las categorías y las imágenes de las opciones sin recargar la red constantemente.
3. **Lógica de Giro:**
* Uso de `AnimationController` con `CurvedAnimation(parent: ..., curve: Curves.decelerate)`.
* Cálculo del ganador: El ángulo final se divide por los sectores para identificar la `id` de la `OPCION` ganadora.



#### 🔹 Fase 4: Editor y Configuraciones Personalizadas

1. **Sincronización 1:1:** Implementar la lógica para que cada RULETA tenga su propia fila en la tabla CONFIGURACION.
2. **Personalización:** Permitir al usuario cambiar la `duracion_giro_ms` y el `color_esquema` desde el editor.
3. **Gestión de Opciones:** CRUD dinámico para añadir/quitar opciones antes de guardar la ruleta.

#### 🔹 Fase 5: Historial y Auditoría Local

1. **Registro Automático:** Crear un trigger en el Provider que, al finalizar la animación de giro, inserte un documento en la colección `historial`.
2. **Vista de Historial:** Pantalla que cargue de forma paginada los últimos giros, mostrando la imagen de la opción ganadora recuperada de la web.

#### 🔹 Fase 6: Pulido Multiplataforma y Lanzamiento

1. **Web/Windows:** Implementar "Hover effects" en las tarjetas de las ruletas.
2. **Responsividad:** Asegurar que la ruleta se adapte de un círculo pequeño en móvil a uno grande en escritorio sin perder resolución.
3. **Pruebas sin Analíticas:** Verificar el rendimiento de la carga de imágenes web mediante el DevTools de Flutter (Network tab) para asegurar que el caché funcione correctamente.

---

### 📌 Notas Críticas de Implementación

* **Imágenes Web:** Debido a que las imágenes vienen de la web, se recomienda usar el formato **WebP** o **SVG** para los iconos de categorías para garantizar velocidad.
* **Seguridad Firestore:** Las reglas deben impedir que un usuario vea el `historial` de otro, a menos que la ruleta sea pública.
* **Offline Support:** Habilitar `persistenceEnabled: true` en Firestore para que la app funcione en túneles o zonas de baja señal (común en móviles).

