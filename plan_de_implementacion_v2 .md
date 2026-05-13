# 📱 Plan de Implementación: "Ruleta de Decisiones" (Flutter + Firebase)

> **Nota importante:** Flutter es inherentemente multiplataforma (Android, Web, Windows, iOS). VS Code es el IDE recomendado con sus extensiones oficiales. *"Antigravity"* no es un entorno estándar para desarrollo Flutter; se asume que trabajas con **VS Code** o **Android Studio**. Este plan no incluye código, solo arquitectura, estructura y configuración.

---

## 🛠️ Herramientas Requeridas

| Categoría | Herramienta | Propósito |
|-----------|-------------|-----------|
| **IDE** | VS Code + Extensiones (Flutter, Dart, Firebase, GitLens, Error Lens, Bracket Pair Colorizer) | Desarrollo, depuración y formateo |
| **SDKs** | Flutter SDK 3.16+, Dart SDK 3.2+ | Compilación y ejecución multiplataforma |
| **Firebase** | Firebase Console, Firebase CLI, FlutterFire CLI | Backend, Auth, Firestore, Storage |
| **Control de Versiones** | Git + GitHub/GitLab | Historial, ramas, colaboración |
| **Diseño UI/UX** | Figma (gratuito) | Wireframes, prototipos, sistema de diseño |
| **Emuladores/Dispositivos** | Android Emulator (API 33+), Chrome (Web), Windows Build | Pruebas multiplataforma |
| **Debug & Performance** | Flutter DevTools | Profiling, logs, inspección de widgets |
| **Gestión de Estado** | Provider (paquete oficial) | Estado reactivo e inyección |

---

## 🎨 UI/UX: Sistema de Diseño

### Paleta de Colores

| Rol | Color | Código Hex | Uso |
|-----|-------|------------|-----|
| **Primario** | Azul vibrante | `#3B82F6` | Botones principales, FAB, enlaces |
| **Secundario** | Púrpura | `#8B5CF6` | Elementos destacados, bordes activos |
| **Acento** | Ámbar | `#F59E0B` | Resultado ganador, notificaciones |
| **Éxito** | Verde esmeralda | `#10B981` | Confirmaciones, operaciones exitosas |
| **Error** | Rojo coral | `#EF4444` | Mensajes de error, eliminación |
| **Fondo claro** | Blanco/gris muy claro | `#F9FAFB` | Fondo principal modo claro |
| **Fondo oscuro** | Gris carbón | `#1F2937` | Fondo principal modo oscuro |
| **Texto primario** | Gris oscuro | `#111827` | Texto principal |
| **Texto secundario** | Gris medio | `#6B7280` | Subtítulos, ayudas |

### Tipografía

| Elemento | Fuente | Tamaño | Peso |
|----------|--------|--------|------|
| **Títulos H1** | Roboto / SF Pro | 28px | Bold |
| **Títulos H2** | Roboto / SF Pro | 22px | SemiBold |
| **Subtítulos** | Roboto / SF Pro | 18px | Medium |
| **Cuerpo** | Roboto / SF Pro | 14px | Regular |
| **Texto pequeño** | Roboto / SF Pro | 12px | Regular |
| **Botones** | Roboto / SF Pro | 16px | Medium |

### Espaciado (Escala de 8px)

```
xs: 4px
sm: 8px
md: 16px
lg: 24px
xl: 32px
xxl: 48px
```

### Bordes y Sombras

- **Radio de borde:** 8px (componentes pequeños), 12px (tarjetas), 16px (modales)
- **Sombras:** Elevación 1-5 (material design)
- **Animaciones:** 200-300ms con curvas easeInOut

### Flujo de Usuario Principal

```
Splash Screen → Login/Registro → Dashboard (lista de ruletas) 
    → Crear/Editar Ruleta → Configurar opciones 
    → Pantalla de Giro → Animación → Resultado 
    → Historial de giros
```

---

## 📁 Estructura de Carpetas (lib/)

```
lib/
├── main.dart
├── firebase_options.dart          # Generado por FlutterFire
│
├── core/                          # Núcleo de la aplicación
│   ├── constants/
│   │   ├── app_constants.dart     # Strings, rutas, keys
│   │   ├── design_constants.dart  # Colores, tamaños, tipografía
│   │   └── regex_patterns.dart    # Patrones de validación
│   ├── routes/
│   │   └── app_routes.dart        # Definición de rutas nombradas
│   ├── services/
│   │   ├── firebase_service.dart  # Inicialización Firebase
│   │   ├── auth_service.dart      # Lógica de autenticación
│   │   └── navigation_service.dart # Navegación global
│   ├── utils/
│   │   ├── validators.dart        # Validaciones de formularios
│   │   ├── helpers.dart           # Funciones auxiliares
│   │   └── extensions.dart        # Extensiones útiles
│   └── themes/
│       ├── app_theme.dart         # Tema claro/oscuro
│       └── theme_provider.dart    # Provider del tema
│
├── models/                        # Modelos de datos
│   ├── usuario_model.dart         # Tabla: USUARIO
│   ├── categoria_model.dart       # Tabla: CATEGORIA
│   ├── ruleta_model.dart          # Tabla: RULETA
│   ├── opcion_model.dart          # Tabla: OPCION
│   ├── configuracion_model.dart   # Tabla: CONFIGURACION
│   └── historial_model.dart       # Tabla: HISTORIAL
│
├── providers/                     # Gestión de estado (Provider)
│   ├── auth_provider.dart         # Autenticación (login/registro/logout)
│   ├── ruleta_provider.dart       # CRUD de ruletas
│   ├── opcion_provider.dart       # Gestión de opciones por ruleta
│   ├── configuracion_provider.dart # Configuración de ruleta (1:1)
│   ├── historial_provider.dart    # Historial de giros
│   ├── categoria_provider.dart    # Categorías disponibles
│   └── giro_provider.dart         # Lógica de giro y animación
│
├── views/                         # Pantallas (screens)
│   ├── splash/
│   │   └── splash_screen.dart
│   ├── auth/
│   │   ├── login_screen.dart
│   │   ├── registro_screen.dart
│   │   └── recuperar_password_screen.dart
│   ├── dashboard/
│   │   ├── dashboard_screen.dart  # Lista de ruletas del usuario
│   │   ├── ruleta_card.dart       # Widget de tarjeta de ruleta
│   │   └── filtro_categorias.dart # Filtro por categoría
│   ├── ruleta/
│   │   ├── crear_ruleta_screen.dart
│   │   ├── editar_ruleta_screen.dart
│   │   ├── detalle_ruleta_screen.dart
│   │   ├── configurar_opciones_screen.dart
│   │   └── configurar_apariencia_screen.dart
│   ├── giro/
│   │   ├── ruleta_giro_screen.dart # Animación de la ruleta
│   │   ├── ruleta_canvas.dart     # CustomPaint de la ruleta
│   │   └── resultado_dialog.dart  # Modal de resultado
│   ├── historial/
│   │   └── historial_screen.dart
│   └── perfil/
│       ├── perfil_screen.dart
│       └── editar_perfil_screen.dart
│
├── widgets/                       # Widgets reutilizables
│   ├── common/
│   │   ├── app_button.dart
│   │   ├── app_textfield.dart
│   │   ├── loading_indicator.dart
│   │   ├── error_widget.dart
│   │   ├── empty_state.dart
│   │   ├── confirmation_dialog.dart
│   │   └── bottom_nav_bar.dart
│   └── ruleta/
│       ├── color_picker.dart
│       ├── opcion_list_item.dart
│       └── peso_slider.dart
│
├── repositories/                  # Acceso a Firestore
│   ├── auth_repository.dart       # Firebase Auth
│   ├── ruleta_repository.dart     # CRUD ruletas
│   ├── opcion_repository.dart     # CRUD opciones
│   ├── configuracion_repository.dart
│   ├── historial_repository.dart
│   └── categoria_repository.dart
│
└── firebase/                      # Configuración Firebase
    ├── firestore_rules.md         # Reglas de seguridad documentadas
    └── indexes.md                 # Índices compuestos requeridos
```

---

## 📊 Modelos de Datos (Firestore)

### Colección: `usuarios`

| Campo | Tipo Firestore | Mapeo a Modelo |
|-------|----------------|----------------|
| `uid` (documentId) | string | id: String |
| `nombre` | string | nombre: String |
| `email` | string | email: String |
| `contraseña_hash` | string | contraseñaHash: String |
| `activo` | boolean | activo: bool |
| `creado_en` | timestamp | creadoEn: DateTime |
| `ultimo_acceso` | timestamp | ultimoAcceso: DateTime? |

### Colección: `categorias`

| Campo | Tipo Firestore | Mapeo a Modelo |
|-------|----------------|----------------|
| `id` (documentId) | string | id: String |
| `nombre` | string | nombre: String |
| `icono` | string | icono: String? |
| `color_hex` | string | colorHex: String? |

### Subcolección: `usuarios/{uid}/ruletas`

| Campo | Tipo Firestore | Mapeo a Modelo |
|-------|----------------|----------------|
| `ruletaId` (documentId) | string | id: String |
| `usuario_id` | string | usuarioId: String |
| `categoria_id` | string | categoriaId: String? |
| `titulo` | string | titulo: String |
| `descripcion` | string | descripcion: String? |
| `es_publica` | boolean | esPublica: bool |
| `creado_en` | timestamp | creadoEn: DateTime |
| `actualizado_en` | timestamp | actualizadoEn: DateTime |

### Subcolección: `usuarios/{uid}/ruletas/{ruletaId}/opciones`

| Campo | Tipo Firestore | Mapeo a Modelo |
|-------|----------------|----------------|
| `opcionId` (documentId) | string | id: String |
| `ruleta_id` | string | ruletaId: String |
| `texto` | string | texto: String |
| `peso` | integer | peso: int (1-100) |
| `color_hex` | string | colorHex: String? |
| `activa` | boolean | activa: bool |
| `orden` | integer | orden: int? |

### Subcolección: `usuarios/{uid}/ruletas/{ruletaId}/configuracion` (documento único)

| Campo | Tipo Firestore | Mapeo a Modelo |
|-------|----------------|----------------|
| `id` (documentId) | string | id: String |
| `ruleta_id` | string | ruletaId: String |
| `duracion_giro_ms` | integer | duracionGiroMs: int |
| `permitir_repetir` | boolean | permitirRepetir: bool |
| `sonido_activo` | boolean | sonidoActivo: bool |
| `color_esquema` | string | colorEsquema: String? |
| `mostrar_ganador_ms` | integer | mostrarGanadorMs: int |

### Subcolección: `usuarios/{uid}/historial`

| Campo | Tipo Firestore | Mapeo a Modelo |
|-------|----------------|----------------|
| `historialId` (documentId) | string | id: String |
| `ruleta_id` | string | ruletaId: String |
| `opcion_id` | string | opcionId: String |
| `usuario_id` | string | usuarioId: String? |
| `girado_en` | timestamp | giradoEn: DateTime |
| `duracion_ms` | integer | duracionMs: int? |

---

## 🔐 Reglas de Seguridad (Firestore)

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Usuarios - solo lectura/escritura del propio usuario
    match /usuarios/{uid} {
      allow read, write: if request.auth != null && request.auth.uid == uid;
    }
    
    // Ruletas - solo el dueño puede CRUD
    match /usuarios/{uid}/ruletas/{ruletaId} {
      allow read, write: if request.auth != null && request.auth.uid == uid;
      
      // Opciones - hereda reglas de la ruleta
      match /opciones/{opcionId} {
        allow read, write: if request.auth != null && request.auth.uid == uid;
      }
      
      // Configuración - hereda reglas de la ruleta
      match /configuracion/{configId} {
        allow read, write: if request.auth != null && request.auth.uid == uid;
      }
    }
    
    // Historial - solo el dueño puede leer/escribir su historial
    match /usuarios/{uid}/historial/{historialId} {
      allow read, write: if request.auth != null && request.auth.uid == uid;
    }
    
    // Categorías - lectura pública, escritura solo admin
    match /categorias/{categoriaId} {
      allow read: if true;
      allow write: if false; // Solo desde Firebase Console
    }
  }
}
```

---

## 📦 Dependencias (`pubspec.yaml`)

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Firebase
  firebase_core: ^2.24.2
  firebase_auth: ^4.16.0
  cloud_firestore: ^4.14.0
  
  # UI
  flutter_svg: ^2.0.9
  google_fonts: ^6.1.0
  animations: ^2.0.8
  lottie: ^2.7.0
  
  # Estado y utilidades
  provider: ^6.1.1
  intl: ^0.18.1
  shared_preferences: ^2.2.2
  equatable: ^2.0.5
  
  # Feedback
  vibration: ^1.8.4
  
  # Validación
  flutter_form_builder: ^9.1.1
  
  # Navegación
  go_router: ^13.0.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  flutter_launcher_icons: ^0.13.1
```

---

## 📋 Plan de Implementación Paso a Paso

### 🔹 Fase 0: Configuración del Entorno (Día 1)

1. **Instalar Flutter SDK** (versión 3.16+) y ejecutar `flutter doctor`
2. **Instalar VS Code** y extensiones:
   - Flutter
   - Dart
   - Firebase
   - Error Lens
   - Dart Data Class Generator
3. **Crear proyecto Flutter:**
   ```bash
   flutter create ruleta_decisiones --platforms android,web,windows,ios
   cd ruleta_decisiones
   ```
4. **Inicializar Git:**
   ```bash
   git init
   echo "*.lock" >> .gitignore
   echo ".dart_tool/" >> .gitignore
   echo "build/" >> .gitignore
   ```
5. **Configurar Firebase:**
   - Crear proyecto en Firebase Console
   - Registrar app Android, iOS, Web
   - Instalar Firebase CLI: `npm install -g firebase-tools`
   - Login: `firebase login`
   - Instalar FlutterFire CLI: `dart pub global activate flutterfire_cli`
   - Configurar: `flutterfire configure`
6. **Validar compilación:** `flutter run -d chrome`

---

### 🔹 Fase 1: Estructura Base y Core (Días 2-3)

1. **Crear estructura de carpetas** (ver sección completa arriba)
2. **Implementar modelos de datos** en `lib/models/` (6 modelos)
3. **Configurar tema claro/oscuro** en `core/themes/`
4. **Implementar constantes globales** en `core/constants/`
5. **Configurar rutas nombradas** con `go_router` o `MaterialPageRoute`
6. **Crear splash screen** con logo y verificación de autenticación
7. **Configurar Provider** en `main.dart` con `MultiProvider`

---

### 🔹 Fase 2: Autenticación (Días 4-5)

1. **Habilitar Email/Password** en Firebase Console → Authentication
2. **Implementar AuthService** en `core/services/auth_service.dart`
3. **Crear AuthProvider** en `providers/auth_provider.dart`
4. **Diseñar pantallas:**
   - Login (email + contraseña)
   - Registro (nombre + email + contraseña + confirmar)
   - Recuperar contraseña (email + enviar enlace)
5. **Implementar validaciones:**
   - Email válido (regex)
   - Contraseña mínimo 6 caracteres
   - Coincidencia de contraseñas
6. **Manejar estados:** cargando, error, éxito
7. **Proteger rutas:** redirigir a login si `user == null`
8. **Persistencia de sesión:** automática con Firebase
9. **Implementar logout** con confirmación

---

### 🔹 Fase 3: Repositorios y CRUD de Categorías (Días 6-7)

1. **Implementar CategoriaRepository:**
   - `getAllCategorias()` → stream/lista
   - `getCategoriaById(id)`
2. **Crear CategoriaProvider** con `ChangeNotifier`
3. **Cargar categorías desde Firestore** (colección pública)
4. **Mostrar categorías** en filtros del dashboard
5. **Validar Firestore offline persistence** habilitada

---

### 🔹 Fase 4: CRUD de Ruletas (Días 8-10)

1. **Implementar RuletaRepository:**
   - `createRuleta(ruleta)` → devuelve id
   - `updateRuleta(ruleta)`
   - `deleteRuleta(id)`
   - `getRuletasByUser(uid)` → stream
   - `getRuletaById(id)`
2. **Crear RuletaProvider** con estado y métodos
3. **Diseñar pantallas:**
   - Dashboard (lista de ruletas del usuario)
   - Crear ruleta (título, descripción, categoría, visibilidad)
   - Editar ruleta
4. **Implementar tarjeta de ruleta** con:
   - Título
   - Descripción (truncada)
   - Categoría (badge)
   - Fecha de creación
   - Botones de acción (editar, eliminar, girar)
5. **Confirmación de eliminación** con diálogo
6. **Actualización de actualizado_en** en cada modificación

---

### 🔹 Fase 5: Gestión de Opciones (Días 11-13)

1. **Implementar OpcionRepository:**
   - `createOpcion(opcion, ruletaId)`
   - `updateOpcion(opcion)`
   - `deleteOpcion(id)`
   - `getOpcionesByRuleta(ruletaId)` → stream
   - `reordenarOpciones(listaOpciones)`
2. **Crear OpcionProvider**
3. **Diseñar pantalla de configuración de opciones:**
   - Lista de opciones con orden arrastrable
   - Añadir nueva opción (texto, peso, color)
   - Editar opción existente
   - Eliminar opción con confirmación
   - Slider para peso (1-100)
   - Color picker para sector
   - Checkbox "activa"
4. **Validar:** mínimo 2 opciones activas por ruleta
5. **Calcular suma de pesos** (no obligatorio 100, es relativo)

---

### 🔹 Fase 6: Configuración de Ruleta (Días 14-15)

1. **Implementar ConfiguracionRepository:**
   - `getConfiguracion(ruletaId)` → documento único
   - `createOrUpdateConfiguracion(config)`
2. **Crear ConfiguracionProvider**
3. **Diseñar pantalla de configuración:**
   - Duración del giro (ms) → slider 1000-5000ms
   - Permitir repetir opciones (toggle)
   - Sonido activo (toggle)
   - Esquema de color (selector predefinido)
   - Tiempo mostrar ganador (ms) → slider 1000-5000ms
4. **Valores por defecto** al crear ruleta nueva

---

### 🔹 Fase 7: Lógica de Giro y Animación (Días 16-19)

1. **Implementar GiroProvider** con:
   - `calcularGanador(opcionesActivas)` → según pesos
   - `iniciarGiro()` → animación
   - `guardarResultado(opcion, ruletaId)`
2. **Diseñar pantalla de ruleta con CustomPaint:**
   - Dividir círculo en sectores según opciones activas
   - Colorear según color_hex o esquema
   - Texto de opciones en cada sector (rotado)
3. **Implementar animación de giro:**
   - Usar `AnimationController` con curva de desaceleración
   - Duración según configuración
   - Ángulo final aleatorio pero determinístico (para mostrar resultado correcto)
4. **Feedback al girar:**
   - Vibración opcional (si `vibration` está disponible)
   - Sonido opcional (si se implementa)
5. **Al detenerse:**
   - Calcular sector seleccionado
   - Mostrar diálogo con resultado
   - Guardar en historial
6. **Manejar "permitir_repetir":** si false, desactivar opción ganadora temporalmente

---

### 🔹 Fase 8: Historial de Giros (Días 20-21)

1. **Implementar HistorialRepository:**
   - `guardarGiro(historial)`
   - `getHistorialByUser(uid, limit)` → lista paginada
   - `getHistorialByRuleta(ruletaId, limit)`
2. **Crear HistorialProvider**
3. **Diseñar pantalla de historial:**
   - Lista de giros (fecha, ruleta, opción ganada)
   - Filtro por ruleta
   - Agrupar por fecha
4. **Card de historial:**
   - Nombre de la ruleta
   - Opción ganada (destacada)
   - Fecha y hora formateada
   - Duración del giro

---

### 🔹 Fase 9: Perfil de Usuario (Día 22)

1. **Diseñar pantalla de perfil:**
   - Foto de avatar (iniciales o placeholder)
   - Nombre (editable)
   - Email (no editable, solo mostrar)
   - Fecha de registro
   - Botón de cerrar sesión
   - Opción de eliminar cuenta
2. **Implementar edición de nombre:**
   - Validación (mínimo 2 caracteres)
   - Actualizar en Firestore
3. **Eliminar cuenta:**
   - Confirmación con contraseña
   - Eliminar todas las subcolecciones del usuario

---

### 🔹 Fase 10: Pulido y Multiplataforma (Días 23-25)

1. **Implementar manejo de errores global:**
   - Try-catch en todos los repositorios
   - Snackbars para errores de red
   - Traducción de errores de Firebase
2. **Optimizar rendimiento:**
   - Usar `const` widgets donde sea posible
   - `Selector` en Provider para evitar rebuilds innecesarios
   - Paginación en historial
3. **Validar accesibilidad:**
   - Semántica para lectores de pantalla
   - Contraste de colores (WCAG AA)
   - Tamaños de texto escalables
4. **Probar en todas las plataformas:**
   - `flutter run -d chrome` (Web)
   - `flutter run -d windows` (Windows)
   - `flutter run -d android` (Android)
   - `flutter run -d ios` (iOS - requiere macOS)
5. **Generar iconos y splash screen:**
   - Configurar `flutter_launcher_icons`
   - Ejecutar `flutter pub run flutter_launcher_icons:main`
6. **Build de producción sin analytics:**
   - `flutter build web --release`
   - `flutter build apk --release`
   - `flutter build windows --release`

---

### 🔹 Fase 11: Documentación y Despliegue (Día 26)

1. **Escribir README.md:**
   - Descripción del proyecto
   - Capturas de pantalla
   - Requisitos de instalación
   - Variables de entorno
   - Comandos de build
2. **Documentar reglas de Firestore** en `firebase/firestore_rules.md`
3. **Desplegar Web en Firebase Hosting:**
   ```bash
   flutter build web
   firebase init hosting
   firebase deploy --only hosting
   ```
4. **Preparar APK para distribución:**
   - Firmar APK (keystore generado)
   - Probar en dispositivo real
5. **Subir a repositorio final** (GitHub/GitLab)

---

## 📌 Buenas Prácticas y Recomendaciones

| Área | Recomendación |
|------|---------------|
| **Estado** | Usar Provider para estado compartido, mantener estado local en StatefulWidget cuando sea posible |
| **Firestore** | Activar persistencia offline, usar streams con `listen: false` cuando sea necesario, evitar lecturas excesivas |
| **Rendimiento** | Usar `const` widgets, `ListView.builder` para listas largas, `Image.network` con cache |
| **Seguridad** | Nunca guardar contraseñas en cliente, reglas de Firestore restrictivas, validar inputs |
| **UX** | Siempre mostrar loading states, errores legibles, confirmación antes de acciones destructivas |
| **Código** | Seguir guía de estilo Dart, documentar APIs públicas, pruebas unitarias para lógica compleja |

---

## ✅ Siguientes Pasos

1. **Validar este plan** con el equipo/stakeholder
2. **Configurar herramientas** según Fase 0
3. **Comenzar Fase 1** (estructura de carpetas y core)
4. **Reportar avances** por fase completada

---

# 🎯 PROMPT PROFESIONAL PARA GENERAR CÓDIGO

```
Eres un desarrollador Flutter experto en arquitectura limpia y Firebase. Necesito que generes el código completo para una aplicación llamada "Ruleta de Decisiones", siguiendo EXACTAMENTE el plan de implementación detallado a continuación.

## RESTRICCIONES IMPORTANTES:
- NO usar Firebase Analytics ni Crashlytics
- NO usar modo producción (usar entorno de desarrollo/testing)
- Flutter 3.16+, Dart 3.2+
- Plataformas: Android, Web, Windows, iOS
- Gestión de estado: Provider
- Backend: Firebase Auth + Firestore

## ESTRUCTURA DE CARPETAS EXIGIDA:
[Insertar aquí la estructura de carpetas completa de la sección anterior]

## MODELOS DE DATOS EXIGIDOS:
[Insertar aquí los 6 modelos con sus campos exactos]

## REGLAS DE FIRESTORE EXIGIDAS:
[Insertar aquí las reglas de seguridad completas]

## DEPENDENCIAS EXACTAS (pubspec.yaml):
[Insertar aquí el YAML completo]

## FASES DE IMPLEMENTACIÓN:

### FASE 1: Configuración inicial y core
1. Genera main.dart con MultiProvider y configuración de tema
2. Genera firebase_options.dart (asume configuración básica)
3. Genera todos los archivos de core/constants/ (app_constants, design_constants, regex_patterns)
4. Genera core/themes/app_theme.dart con tema claro y oscuro (usar colores definidos en plan)
5. Genera core/routes/app_routes.dart con go_router

### FASE 2: Modelos
6. Genera los 6 modelos completos en lib/models/ (usuario, categoria, ruleta, opcion, configuracion, historial)
   - Incluir métodos fromFirestore, toFirestore, copyWith, equals/hashCode

### FASE 3: Repositorios
7. Genera core/services/firebase_service.dart (inicialización)
8. Genera core/services/auth_service.dart (métodos login, register, logout, resetPassword, deleteAccount)
9. Genera repositories/ para cada entidad con CRUD completo usando streams donde aplique

### FASE 4: Providers
10. Genera providers/ para cada entidad (auth, ruleta, opcion, configuracion, historial, categoria, giro)
    - Cada provider debe extender ChangeNotifier
    - Incluir estados: loading, error, data

### FASE 5: Pantallas mínimas funcionales
11. SplashScreen (verifica autenticación)
12. LoginScreen (email + password + validaciones)
13. RegistroScreen (nombre + email + password + confirmar)
14. DashboardScreen (lista de ruletas del usuario con streams)
15. CrearRuletaScreen (título, descripción, categoría, visibilidad)
16. ConfigurarOpcionesScreen (CRUD de opciones con orden, peso, color)
17. RuletaGiroScreen (CustomPaint + animación)
18. HistorialScreen (lista de giros)

### FASE 6: Widgets reutilizables
19. Generar todos los widgets comunes: AppButton, AppTextField, LoadingIndicator, EmptyState, ConfirmationDialog, RuletaCanvas

## REQUISITOS DE CALIDAD:
- Manejar todos los estados de carga (isLoading, error, success, empty)
- Validar formularios con mensajes de error específicos
- Manejar errores de Firebase (traducir códigos a mensajes legibles)
- Usar const widgets donde sea posible
- Implementar dispose() en todos los providers y controladores
- Agregar comentarios en métodos públicos
- Usar nomenclatura camelCase para variables y PascalCase para clases

## FORMATO DE RESPUESTA:
Genera el código archivo por archivo, en este orden:
1. pubspec.yaml (completo)
2. firebase_options.dart
3. main.dart
4. lib/core/constants/app_constants.dart
5. lib/core/constants/design_constants.dart
6. lib/core/themes/app_theme.dart
7. lib/core/routes/app_routes.dart
8. lib/models/ (todos los modelos)
9. lib/repositories/ (todos los repositorios)
10. lib/providers/ (todos los providers)
11. lib/views/splash/splash_screen.dart
12. lib/views/auth/login_screen.dart
13. lib/views/auth/registro_screen.dart
14. lib/views/dashboard/dashboard_screen.dart
15. lib/views/ruleta/crear_ruleta_screen.dart
16. lib/views/ruleta/configurar_opciones_screen.dart
17. lib/views/giro/ruleta_giro_screen.dart
18. lib/views/historial/historial_screen.dart
19. lib/widgets/common/ (todos los widgets comunes)

NO incluyas explicaciones, solo el código. Cada archivo debe comenzar con un comentario // RUTA: lib/... y luego el código completo. Asegúrate de que todas las importaciones sean correctas y relativas.
```
