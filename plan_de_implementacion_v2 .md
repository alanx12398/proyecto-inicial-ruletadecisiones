# 📱 Plan de Implementación: "Antigravity" (Flutter + Firebase)

> **Nota preliminar:** Flutter es inherentemente multiplataforma. VS Code es el IDE recomendado (con extensiones oficiales). *"Antigravity"* se refiere al nombre de la aplicación. Este plan está optimizado para **VS Code** y desarrollo multiplataforma (Android, Web, Windows, iOS).

---

## 🛠️ Herramientas Requeridas

| Categoría | Herramienta | Propósito |
|-----------|-------------|-----------|
| **IDE** | VS Code + Extensiones (Flutter, Dart, Firebase, GitLens, Pubspec Assist) | Desarrollo, depuración y formateo |
| **SDKs** | Flutter SDK (stable), Dart SDK (última versión) | Compilación y ejecución multiplataforma |
| **Firebase** | Firebase Console, Firebase CLI (`flutterfire`), emulators suite | Backend, Auth, Firestore, Storage |
| **Control de Versiones** | Git + GitHub/GitLab | Historial, ramas, colaboración |
| **Diseño UI/UX** | Figma | Wireframes, prototipos, sistema de diseño |
| **Emuladores/Dispositivos** | Android Emulator (Pixel 6), iOS Simulator (macOS), Chrome/Web, Windows VM | Pruebas multiplataforma |
| **Debug** | Flutter DevTools | Profiling, logs, inspección de widgets |
| **Base de Datos** | Firebase Emulator Suite | Desarrollo offline de Firestore |

---

## 🎨 UI/UX: Sistema de Diseño "Antigravity"

### Paleta de Colores

| Rol | Color | Hex | Uso |
|-----|-------|-----|-----|
| **Primary** | Gravedad Violeta | `#6C63FF` | Botones principales, FAB, tabs activos |
| **Primary Dark** | Espacio Profundo | `#4A42C4` | Hover, estados presionados |
| **Secondary** | Antimateria Coral | `#FF6584` | Acentos, badges, errores sutiles |
| **Background Light** | Estrella Blanca | `#F8F9FF` | Fondo principal (modo claro) |
| **Background Dark** | Vacío Estelar | `#0A0E27` | Fondo principal (modo oscuro) |
| **Surface** | Nebulosa | `#1A1F3D` | Tarjetas, modales (modo oscuro) |
| **Success** | Gravedad Verde | `#00D897` | Confirmaciones, éxito |
| **Warning** | Destello Ámbar | `#FFB800` | Advertencias |
| **Text Primary** | Núcleo Blanco | `#FFFFFF` / `#1A1F3D` | Texto principal |
| **Text Secondary** | Polvo Estelar | `#A0A5C0` | Subtítulos, placeholders |

### Tipografía

| Elemento | Fuente | Tamaño | Peso |
|----------|--------|--------|------|
| **Títulos H1** | Poppins / Montserrat | 32sp | Bold |
| **Títulos H2** | Poppins / Montserrat | 24sp | SemiBold |
| **Body** | Inter / Roboto | 14-16sp | Regular |
| **Botones** | Inter / Roboto | 16sp | Medium |
| **Código/Stats** | JetBrains Mono | 12sp | Regular |

### Espaciado y Grid

| Unidad | Valor | Uso |
|--------|-------|-----|
| **XS** | 4px | Entre iconos pequeños |
| **S** | 8px | Entre elementos relacionados |
| **M** | 16px | Entre secciones |
| **L** | 24px | Márgenes de pantalla |
| **XL** | 32px | Separación grande |
| **XXL** | 48px | Secciones completas |

### Efectos Visuales

- **Gradientes:** Degradado primario `6C63FF → 4A42C4` para botones principales
- **Sombras:** `elevation: 4` con opacidad 0.15 del color primario
- **Bordes:** Radio `12px` en tarjetas, `24px` en FAB
- **Animaciones:** Curva estándar `easeInOutCubic` duración 250ms

### Iconografía

- **Paquete:** `flutter_svg` + `phosphor_flutter` o `feather_icons`
- **Estilo:** Lineal con grosor consistente, redondeado en esquinas
- **Tamaños:** 20px, 24px, 32px (con área táctil de 48px mínimo)

### Flujos de Pantalla

```
Splash (carga inicial)
    ↓
Onboarding (opcional, primera vez)
    ↓
Login / Registro
    ↓
Dashboard Principal
    ├── Lista de "Gravity Wells" (proyectos/espacios)
    ├── FAB para crear nuevo
    └── Bottom navigation (opcional)
    ↓
Detalle de Gravity Well
    ├── Vista principal (tabla/datos)
    ├── Editor de campos
    ├── Historial de cambios
    └── Acciones (editar, eliminar, compartir)
```

### Estados de UI

| Estado | Representación |
|--------|----------------|
| **Carga inicial** | Skeleton shimmer + indicador circular |
| **Carga parcial** | Indicador lineal en parte superior |
| **Éxito** | Snackbar con borde color success + icono |
| **Error** | Snackbar destructivo con acción "Reintentar" |
| **Vacío** | Ilustración SVG + texto + botón CTA |
| **Offline** | Banner persistente + datos cacheados |
| **Sin permisos** | Pantalla informativa con botón de solicitud |

---

## 📦 Dependencias Conceptuales para `pubspec.yaml`

### Core Firebase (sin analytics)

| Paquete | Versión recomendada | Función |
|---------|---------------------|---------|
| `firebase_core` | ^3.12.1 | Inicialización del ecosistema Firebase |
| `firebase_auth` | ^5.5.1 | Autenticación email/password y Google |
| `cloud_firestore` | ^5.6.5 | Base de datos NoSQL en tiempo real |
| `firebase_storage` | ^12.4.4 | Almacenamiento de archivos/imágenes |

### Gestión de Estado

| Paquete | Versión | Función |
|---------|---------|---------|
| `provider` | ^6.1.2 | Gestión de estado reactivo |
| `provider_shopper` | ^1.0.0 | Patrón de consumo optimizado |

### UI y Animaciones

| Paquete | Versión | Función |
|---------|---------|---------|
| `flutter_svg` | ^2.0.17 | Iconos e ilustraciones vectoriales |
| `google_fonts` | ^6.2.1 | Fuentes Poppins, Inter, Montserrat |
| `shimmer` | ^3.0.0 | Efectos de carga skeleton |
| `lottie` | ^3.3.0 | Animaciones complejas (alternativa a Rive) |
| `page_transition` | ^2.2.1 | Transiciones entre pantallas |

### Utilidades

| Paquete | Versión | Función |
|---------|---------|---------|
| `intl` | ^0.20.2 | Formateo de fechas, monedas, localización |
| `shared_preferences` | ^2.5.3 | Cache ligero (tema, onboarding, última sesión) |
| `image_picker` | ^1.1.2 | Selección de imágenes desde galería/cámara |
| `permission_handler` | ^11.4.0 | Gestión de permisos multiplataforma |
| `connectivity_plus` | ^6.1.3 | Detección de estado de red |
| `flutter_native_splash` | ^2.4.5 | Pantalla de splash nativa |
| `flutter_launcher_icons` | ^0.14.3 | Iconos adaptativos multiplataforma |
| `path_provider` | ^2.1.5 | Acceso a directorios del sistema |
| `equatable` | ^2.0.7 | Comparación de objetos simplificada |

### Calidad y Desarrollo

| Paquete | Versión | Función |
|---------|---------|---------|
| `flutter_lints` | ^5.0.0 | Reglas de calidad y estilo (estándar) |
| `build_runner` | ^2.4.15 | Generación de código |
| `json_serializable` | ^6.9.4 | Serialización/desserialización JSON |
| `mockito` | ^5.4.5 | Mocks para pruebas |

> **Nota:** No se incluye `firebase_analytics` ni `firebase_crashlytics` según especificación.

---

## 📂 Estructura de Carpetas (Feature-First + Provider)

```
lib/
├── main.dart                          # Punto de entrada, MultiProvider setup
├── firebase_options.dart              # Generado por flutterfire configure
│
├── core/                              # Capa de infraestructura compartida
│   ├── constants/
│   │   ├── app_constants.dart         # Strings, rutas, configuraciones
│   │   ├── theme_constants.dart       # Colores, spacing, tipografía
│   │   └── assets_constants.dart      # Rutas de assets (SVG, Lottie, imágenes)
│   ├── themes/
│   │   ├── app_theme.dart             # ThemeData light/dark
│   │   └── theme_provider.dart        # Provider para cambio de tema
│   ├── routes/
│   │   ├── app_routes.dart            # Enum de rutas
│   │   └── route_generator.dart       # Navegación declarativa (go_router opcional)
│   ├── utils/
│   │   ├── validators.dart            # Validadores de email, password, etc.
│   │   ├── formatters.dart            # Formatos de fecha, número, etc.
│   │   ├── error_handler.dart         # Mapeo de errores Firebase a texto legible
│   │   └── network_utils.dart         # Chequeo de conectividad
│   └── widgets/
│       ├── loading_widget.dart        # Indicadores de carga reutilizables
│       ├── error_widget.dart          # Widgets de error personalizados
│       ├── empty_state_widget.dart    # Estado vacío con ilustración
│       ├── custom_snackbar.dart       # Snackbar con diseño consistente
│       └── gradient_button.dart       # Botón con degradado primario
│
├── features/                          # Organización por característica
│   │
│   ├── auth/                          # Autenticación
│   │   ├── models/
│   │   │   └── user_model.dart        # User class (uid, email, displayName, etc.)
│   │   ├── providers/
│   │   │   └── auth_provider.dart     # AuthNotifier con métodos login/register/logout
│   │   ├── screens/
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   └── forgot_password_screen.dart
│   │   ├── widgets/
│   │   │   ├── auth_form_field.dart   # Input decorado para auth
│   │   │   └── social_login_buttons.dart
│   │   └── services/
│   │       └── auth_service.dart      # Wrapper de Firebase Auth
│   │
│   ├── gravity_well/                  # Entidad principal (similar a "proyecto")
│   │   ├── models/
│   │   │   ├── gravity_well_model.dart       # ID, nombre, descripción, created_at
│   │   │   └── gravity_field_model.dart      # Campos personalizables dentro del well
│   │   ├── providers/
│   │   │   ├── gravity_well_provider.dart    # CRUD de wells + streams
│   │   │   └── gravity_field_provider.dart   # CRUD de fields
│   │   ├── screens/
│   │   │   ├── dashboard_screen.dart         # Lista de gravity wells del usuario
│   │   │   ├── well_detail_screen.dart       # Vista detalle con campos
│   │   │   ├── create_well_screen.dart       # Crear nuevo well
│   │   │   └── edit_well_screen.dart         # Editar well
│   │   ├── widgets/
│   │   │   ├── well_card.dart                # Tarjeta en dashboard
│   │   │   ├── field_builder.dart            # Constructor dinámico de campos
│   │   │   ├── field_editor.dart             # Editor inline de campos
│   │   │   └── field_type_selector.dart      # Selector de tipo (text, number, date)
│   │   └── services/
│   │       └── firestore_well_service.dart   # Operaciones Firestore específicas
│   │
│   ├── history/                       # Historial de cambios/actividad
│   │   ├── models/
│   │   │   └── activity_log_model.dart       # Tipo, timestamp, metadata
│   │   ├── providers/
│   │   │   └── history_provider.dart         # Stream de logs
│   │   ├── screens/
│   │   │   └── history_screen.dart           # Timeline de actividades
│   │   └── widgets/
│   │       ├── activity_timeline.dart
│   │       └── activity_filter_chips.dart
│   │
│   ├── profile/                       # Perfil de usuario
│   │   ├── providers/
│   │   │   └── profile_provider.dart
│   │   ├── screens/
│   │   │   ├── profile_screen.dart
│   │   │   └── edit_profile_screen.dart
│   │   └── widgets/
│   │       └── avatar_widget.dart
│   │
│   └── onboarding/                    # Onboarding (primera ejecución)
│       ├── screens/
│       │   └── onboarding_screen.dart
│       └── widgets/
│           ├── onboarding_page.dart
│           └── page_indicator.dart
│
├── services/                         # Servicios globales
│   ├── firebase/
│   │   ├── firebase_init.dart         # Inicialización centralizada
│   │   └── firestore_helpers.dart     # Helpers para operaciones Firestore
│   ├── storage/
│   │   └── local_storage_service.dart # Wrapper de shared_preferences
│   └── network/
│       └── connectivity_service.dart  # Monitoreo de conectividad con Provider
│
└── shared/                           # Recursos estáticos
    ├── assets/
    │   ├── images/
    │   ├── svg/
    │   └── lottie/
    └── translations/                  # (Opcional) i18n si se requiere
        ├── en.json
        └── es.json
```

---

## 🗄️ Esquema de Firebase Firestore

### Colecciones y Documentos

```
users/{userId}
    ├── email: string
    ├── displayName: string
    ├── photoURL: string (opcional)
    ├── createdAt: timestamp
    ├── lastLoginAt: timestamp
    └── settings: map
        ├── theme: string ("light" | "dark" | "system")
        └── notificationsEnabled: boolean

gravity_wells/{wellId}
    ├── userId: string (referencia al owner)
    ├── name: string
    ├── description: string (opcional)
    ├── createdAt: timestamp
    ├── updatedAt: timestamp
    ├── isArchived: boolean
    ├── coverImageURL: string (opcional)
    └── metadata: map (opcional - extensible)

gravity_fields/{fieldId}
    ├── wellId: string (referencia al well padre)
    ├── name: string
    ├── fieldType: enum ("text" | "number" | "date" | "checkbox" | "select")
    ├── value: any (dinámico según tipo)
    ├── order: number (para ordenamiento)
    ├── isRequired: boolean
    ├── options: array<string> (solo para tipo "select")
    └── createdAt: timestamp

activity_logs/{logId}
    ├── userId: string
    ├── wellId: string (opcional)
    ├── actionType: enum ("create_well", "update_well", "update_field", "delete_well")
    ├── metadata: map (detalles del cambio)
    ├── timestamp: timestamp
    └── ipHash: string (opcional, hash de IP para auditoría)
```

### Reglas de Seguridad (Firestore)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Usuarios: solo lectura/escritura del propio documento
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Gravity Wells: el owner tiene control total, otros solo lectura si están compartidos
    match /gravity_wells/{wellId} {
      allow read: if request.auth != null && 
        (resource.data.userId == request.auth.uid || resource.data.isShared == true);
      allow create: if request.auth != null && 
        request.resource.data.userId == request.auth.uid;
      allow update, delete: if request.auth != null && 
        resource.data.userId == request.auth.uid;
    }
    
    // Gravity Fields: vinculados al well
    match /gravity_fields/{fieldId} {
      allow read: if request.auth != null && 
        exists(/databases/$(database)/documents/gravity_wells/$(resource.data.wellId)) &&
        get(/databases/$(database)/documents/gravity_wells/$(resource.data.wellId)).data.userId == request.auth.uid;
      allow write: if request.auth != null && 
        get(/databases/$(database)/documents/gravity_wells/$(request.resource.data.wellId)).data.userId == request.auth.uid;
    }
    
    // Activity Logs: solo lectura/escritura del propio usuario
    match /activity_logs/{logId} {
      allow read, write: if request.auth != null && 
        request.resource.data.userId == request.auth.uid;
    }
  }
}
```

### Índices Requeridos

| Colección | Campos ordenados | Campos filtrados | Propósito |
|-----------|------------------|------------------|-----------|
| `gravity_wells` | `createdAt` desc | `userId` | Dashboard ordenado por fecha |
| `gravity_wells` | `updatedAt` desc | `userId` | "Recientemente actualizados" |
| `gravity_fields` | `order` asc | `wellId` | Orden de campos dentro del well |
| `activity_logs` | `timestamp` desc | `userId` | Historial cronológico |

---

## 📋 Plan de Implementación Paso a Paso

### 🔹 Fase 0: Configuración Inicial del Entorno (Día 1)

**Paso 0.1:** Instalación de SDKs y herramientas
1. Descargar e instalar Flutter SDK desde [flutter.dev](https://flutter.dev)
2. Agregar Flutter al PATH del sistema
3. Ejecutar `flutter doctor` y resolver cualquier error (Android Studio, Xcode, Chrome)
4. Instalar VS Code y extensiones:
   - Flutter (Dart Code)
   - Firebase (Google)
   - GitLens
   - Material Icon Theme
   - Prettier (para archivos de configuración)
   - Pubspec Assist (gestión de dependencias)

**Paso 0.2:** Creación del proyecto
```bash
flutter create antigravity_app --platforms android,ios,windows,web --org com.antigravity
cd antigravity_app
```

**Paso 0.3:** Configuración de Git
```bash
git init
git branch -M main
# Crear .gitignore estándar para Flutter
curl -o .gitignore https://raw.githubusercontent.com/flutter/flutter/master/.gitignore
git add .
git commit -m "chore: initial project structure"
```

**Paso 0.4:** Estructura base de carpetas
- Crear toda la jerarquía de `lib/` definida anteriormente
- Crear carpetas de assets: `assets/images/`, `assets/svg/`, `assets/lottie/`
- Configurar `pubspec.yaml` con assets paths

**Paso 0.5:** Configuración de Firebase
1. Crear proyecto en [Firebase Console](https://console.firebase.google.com/)
   - Nombre: "Antigravity"
   - Deshabilitar Google Analytics (importante)
2. Registrar aplicaciones:
   - Android: package `com.antigravity.antigravity_app`
   - iOS: bundle ID `com.antigravity.antigravityApp`
   - Web: nombre "Antigravity Web"
   - Windows: usar configuración web (Firebase SDK vía `firebase_core`)
3. Instalar Firebase CLI:
   ```bash
   npm install -g firebase-tools
   firebase login
   ```
4. Ejecutar `flutterfire configure` y seleccionar el proyecto creado
5. Verificar que se generó `lib/firebase_options.dart`

**Paso 0.6:** Archivos de configuración iniciales
- Crear `lib/core/constants/app_constants.dart` con strings base
- Crear `lib/core/themes/app_theme.dart` con definición light/dark
- Crear `lib/main.dart` con setup inicial de MultiProvider

---

### 🔹 Fase 1: Base de la Aplicación y Tema (Días 2-3)

**Paso 1.1:** Tema y estilos globales
1. Implementar `AppTheme.light()` y `AppTheme.dark()` con paleta definida
2. Crear `theme_provider.dart` con `ChangeNotifier` para toggle entre temas
3. Integrar en `main.dart` con `ChangeNotifierProvider`
4. Configurar `MaterialApp.router` con tema dinámico

**Paso 1.2:** Sistema de rutas
1. Definir `AppRoutes` enum con todas las rutas
2. Crear `RouteGenerator` con `onGenerateRoute`
3. Configurar `UnknownRoute` para manejo de errores

**Paso 1.3:** Widgets base reutilizables
1. `LoadingWidget`: Center + CircularProgressIndicator con color primario
2. `ErrorWidget`: Center + Icon + Text + botón "Reintentar"
3. `EmptyStateWidget`: SVG ilustración + texto descriptivo
4. `CustomSnackbar`: ScaffoldMessenger con diseño personalizado
5. `GradientButton`: ElevatedButton con degradado primario

**Paso 1.4:** Assets iniciales
1. Descargar/crear assets:
   - Logo en SVG (versión light y dark)
   - Íconos de acción (usar Phosphor Icons o Feather)
   - Ilustraciones de onboarding (3-4 Lottie simples)
   - Favicon para web
2. Configurar `flutter_native_splash`:
   - Crear `flutter_native_splash.yaml`
   - Ejecutar `flutter pub run flutter_native_splash:create`
3. Configurar `flutter_launcher_icons`:
   - Crear `flutter_launcher_icons.yaml`
   - Ejecutar `flutter pub run flutter_launcher_icons:main`

**Paso 1.5:** Prueba de compilación
- Ejecutar `flutter run -d chrome` (web)
- Ejecutar `flutter run -d windows` (Windows)
- Verificar que el splash y el tema base se muestran correctamente

---

### 🔹 Fase 2: Autenticación (Días 4-6)

**Paso 2.1:** Configuración de Firebase Auth
1. Habilitar métodos en Firebase Console:
   - Email/Password (obligatorio)
   - Google Sign-In (recomendado como alternativa)
2. Para Google Sign-In:
   - Android: configurar SHA-1 y SHA-256
   - iOS: agregar `GoogleService-Info.plist`
   - Web: habilitar dominio localhost

**Paso 2.2:** Modelos y servicios de autenticación
1. Crear `user_model.dart`:
   ```dart
   class AppUser {
     final String uid;
     final String email;
     final String? displayName;
     final String? photoURL;
     final DateTime createdAt;
     final DateTime lastLoginAt;
   }
   ```
2. Crear `auth_service.dart` (wrapper de FirebaseAuth):
   - `signInWithEmail(email, password)`
   - `signUpWithEmail(email, password, displayName)`
   - `signInWithGoogle()`
   - `sendPasswordResetEmail(email)`
   - `signOut()`
   - Stream de cambios de usuario

**Paso 2.3:** Provider de autenticación
1. Crear `auth_provider.dart` extendiendo `ChangeNotifier`
2. Métodos expuestos con manejo de estados:
   - `isLoading`: bool
   - `currentUser`: AppUser?
   - `errorMessage`: String?
3. Métodos async con `try-catch` y mapeo de errores Firebase a legibles
4. Usar `notifyListeners()` después de cada operación

**Paso 2.4:** Pantallas de autenticación
1. `LoginScreen`:
   - Formulario con email y password
   - Validaciones en tiempo real
   - Botón "Olvidé mi contraseña"
   - Enlace a registro
2. `RegisterScreen`:
   - Campos: nombre, email, password, confirm password
   - Validación de coincidencia de passwords
   - Términos y condiciones (checkbox)
3. `ForgotPasswordScreen`:
   - Campo email + botón enviar
   - Snackbar de confirmación

**Paso 2.5:** Protección de rutas
1. Crear `AuthGuard` como wrapper en `main.dart`
2. Si `auth.currentUser == null`, redirigir a `LoginScreen`
3. Mantener autenticación persistente (Firebase lo maneja por defecto)

**Paso 2.6:** Onboarding (solo primera ejecución)
1. Crear `OnboardingScreen` con 3-4 páginas usando `PageView`
2. Guardar flag `onboardingCompleted` en `shared_preferences`
3. Mostrar solo si no existe flag

---

### 🔹 Fase 3: Modelos de Datos y Firestore (Días 7-9)

**Paso 3.1:** Configuración inicial de Firestore
1. Habilitar Firestore en Firebase Console (modo nativo)
2. Configurar reglas de seguridad (copiar las definidas anteriormente)
3. Habilitar persistencia offline:
   ```dart
   FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
   ```

**Paso 3.2:** Modelos con `json_serializable`
1. Crear `gravity_well_model.dart`:
   ```dart
   @JsonSerializable()
   class GravityWell {
     final String id;
     final String userId;
     final String name;
     final String? description;
     final DateTime createdAt;
     final DateTime updatedAt;
     final bool isArchived;
   }
   ```
2. Crear `gravity_field_model.dart` y `activity_log_model.dart` similares
3. Ejecutar `build_runner`: `flutter pub run build_runner build --delete-conflicting-outputs`

**Paso 3.3:** Servicios Firestore
1. Crear `firestore_well_service.dart`:
   - `createWell(well)`: retorna `Future<String>`
   - `updateWell(well)`: `Future<void>`
   - `deleteWell(wellId)`: `Future<void>`
   - `getWellsStream(userId)`: `Stream<List<GravityWell>>` (con filtro `isArchived == false`)
   - `archiveWell(wellId)`: `Future<void>`

2. Implementar lógica de activity log:
   - Cada operación de escritura guarda documento en `activity_logs`
   - Usar `FieldValue.serverTimestamp()` para timestamps

**Paso 3.4:** Providers de Gravity Well
1. `gravity_well_provider.dart`:
   - `Stream<List<GravityWell>> wells`
   - Métodos CRUD que actualizan Firestore y refrescan stream
   - Manejo de errores de red
2. `gravity_field_provider.dart`:
   - `Stream<List<GravityField>> fieldsForWell(wellId)`
   - Métodos CRUD de fields

**Paso 3.5:** Emuladores de Firebase para desarrollo
1. Inicializar emuladores:
   ```bash
   firebase init emulators
   # Seleccionar Auth, Firestore
   firebase emulators:start
   ```
2. Configurar app para usar emuladores en desarrollo:
   ```dart
   if (kDebugMode) {
     FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
     FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
   }
   ```

---

### 🔹 Fase 4: Dashboard y Listado de Gravity Wells (Días 10-12)

**Paso 4.1:** Dashboard Screen
1. Crear `DashboardScreen` con:
   - `AppBar` con título y acciones (perfil, configuración)
   - `StreamBuilder` conectado a `GravityWellProvider`
   - `SliverList` o `ListView.builder`
   - FAB para crear nuevo well
2. Estados del stream:
   - `ConnectionState.waiting`: mostrar skeleton loading
   - `hasData`: mostrar lista
   - `hasError`: mostrar widget de error con reintento
   - `data.empty`: mostrar `EmptyStateWidget`

**Paso 4.2:** Well Card Widget
1. `WellCard` recibe `GravityWell` y callback `onTap`
2. Diseño:
   - Cover image o placeholder gradiente
   - Título (2 líneas máximo)
   - Descripción truncada
   - Fecha de última modificación
   - Menu overflow (editar, archivar, eliminar)
3. Efectos: shadow sutil, borderRadius 12px, hover animado

**Paso 4.3:** Crear/Editar Well
1. `CreateWellScreen` y `EditWellScreen` (puede ser el mismo widget con flag)
2. Formulario con:
   - Campo nombre (requerido, máx 50 caracteres)
   - Campo descripción (opcional, máx 200, multi-línea)
   - Selector de imagen de portada (opcional, usando `image_picker`)
   - Botón submit
3. Validaciones y feedback visual

**Paso 4.4:** Archivar y eliminar
1. En menu overflow del card:
   - Archivar: mostrar `showModalBottomSheet` con confirmación
   - Eliminar: diálogo destructivo (rojo) + confirmación
2. Al archivar, actualizar `isArchived = true`
3. Opcional: vista separada para wells archivados (segunda pestaña)

---

### 🔹 Fase 5: Detalle del Gravity Well y Campos Dinámicos (Días 13-16)

**Paso 5.1:** Well Detail Screen
1. `WellDetailScreen` recibe `wellId` como parámetro
2. Layout:
   - Header con nombre, descripción y acciones
   - Sección de campos (lista dinámica)
   - FAB para agregar nuevo campo
3. `StreamBuilder` para fields (ordenados por `order` asc)

**Paso 5.2:** Sistema de tipos de campo
1. Definir `FieldType` enum:
   ```dart
   enum FieldType { text, number, date, checkbox, select }
   ```
2. Mapeo de tipo a widget:
   - `text`: `TextFormField`
   - `number`: `TextFormField` con `keyboardType: TextInputType.number`
   - `date`: `DatePicker` (showDatePicker)
   - `checkbox`: `CheckboxListTile`
   - `select`: `DropdownButtonFormField`

**Paso 5.3:** Field Editor
1. `FieldEditor` widget:
   - Modo edición inline o modal
   - Campos: nombre, tipo, requerido, opciones (si es select)
   - Validación de nombre único por well
2. `FieldTypeSelector`:
   - Grid o lista de chips con iconos por tipo

**Paso 5.4:** Field Builder dinámico
1. `FieldBuilder` widget que recibe `GravityField` y devuelve widget correspondiente
2. Manejo de cambios de valor con `StatefulWidget` o `ValueNotifier`
3. Persistencia automática (debounce o botón guardar por campo)

**Paso 5.5:** Ordenamiento de campos
1. Implementar drag & drop usando `reorderable_list` o `flutter_reorderable_list`
2. Actualizar propiedad `order` en Firestore cuando cambie el orden
3. Animar transiciones

---

### 🔹 Fase 6: Historial de Actividad (Días 17-18)

**Paso 6.1:** History Provider
1. `HistoryProvider` con `Stream<List<ActivityLog>> logsForUser`
2. Query en Firestore: ordenado por `timestamp desc`, límite 50 inicial
3. Implementar paginación con `startAfter` (scroll infinito)

**Paso 6.2:** History Screen
1. Timeline vertical con diseño estilo "feed"
2. Cada log tiene:
   - Ícono según tipo de acción
   - Texto descriptivo ("Creaste el well 'Marketing'")
   - Timestamp formateado (relative: "hace 2 horas" con `intl`)
3. Filtros por tipo de acción (chips horizontales)
4. Pull-to-refresh para recargar

**Paso 6.3:** Registro de actividades en servicios
1. En cada método CRUD del `FirestoreWellService`, agregar:
   ```dart
   await _activityLogService.logAction(
     userId: currentUser.uid,
     actionType: 'create_well',
     metadata: {'wellId': wellId, 'wellName': wellName},
   );
   ```

---

### 🔹 Fase 7: Perfil de Usuario y Configuración (Días 19-20)

**Paso 7.1:** Profile Screen
1. Mostrar:
   - Avatar (iniciales o foto)
   - Nombre y email
   - Estadísticas: cantidad de wells, campos creados, última actividad
   - Botón "Cerrar sesión"
   - Botón "Eliminar cuenta" (con diálogo destructivo)
2. Navegación a "Editar perfil" y "Configuración"

**Paso 7.2:** Edit Profile Screen
1. Campos editables:
   - displayName (máx 30 caracteres)
   - photoURL (selector de imagen con recorte)
2. Subir imagen a Firebase Storage:
   - Path: `users/{uid}/avatar.jpg`
   - Actualizar URL en documento de usuario

**Paso 7.3:** Configuración
1. Tema: selector (Light / Dark / System)
2. Notificaciones (toggle, para futura implementación)
3. Datos: botón "Exportar mis datos" (JSON)
4. App info: versión, privacidad, términos

**Paso 7.4:** Eliminación de cuenta
1. Validación: escribir "ELIMINAR" en campo de texto
2. Eliminar en cascada:
   - Todos los gravity_wells del usuario
   - Todos los campos asociados
   - Actividad logs
   - Documento de usuario
   - Cuenta de autenticación

---

### 🔹 Fase 8: Conexión Offline y Manejo de Errores (Días 21-22)

**Paso 8.1:** Detectores de conectividad
1. `ConnectivityService` usando `connectivity_plus`:
   - `Stream<ConnectivityResult> connectivityStream`
   - Método `hasConnection`: ping a Google DNS
2. Provider para exponer estado de red
3. UI: banner persistente cuando offline

**Paso 8.2:** Manejo de caché offline
1. Firestore ya tiene persistencia habilitada (Paso 3.1)
2. Para operaciones offline, Firestore encola escrituras
3. Mostrar indicador "Cambios pendientes de sincronizar"

**Paso 8.3:** Manejo global de errores
1. `ErrorHandler` clase con métodos:
   - `mapFirebaseErrorToMessage(error)`: devuelve string legible
   - `showErrorSnackbar(context, error)`: widget de error
2. Usar `FlutterError.onError` para errores no capturados
3. `runZonedGuarded` en `main()` para errores asíncronos

**Paso 8.4:** Estados de carga optimistas
1. En operaciones CRUD, actualizar UI inmediatamente
2. Revertir en caso de error con Firestore
3. Usar `OptimisticUpdateProvider` pattern

---

### 🔹 Fase 9: Pruebas y Calidad (Días 23-25)

**Paso 9.1:** Pruebas unitarias
1. Configurar `test/` con estructura similar a `lib/`
2. Probar:
   - Modelos (serialización)
   - Validadores (email, password)
   - Formateadores de fecha
   - Lógica de negocio pura
3. Usar `mockito` para mockear Firebase

**Paso 9.2:** Pruebas de widgets
1. Probar:
   - `LoginScreen`: formulario, validaciones
   - `DashboardScreen`: estados de carga, vacío, error
   - `WellCard`: interacciones
2. Usar `WidgetTester` y `pumpAndSettle`

**Paso 9.3:** Pruebas de integración
1. Flujo completo: login → crear well → agregar campo → editarlo → ver historial
2. Usar `integration_test` package
3. Ejecutar en emuladores de Android, iOS, y Chrome

**Paso 9.4:** Linting y formato
1. Configurar `analysis_options.yaml` estricto
2. Ejecutar `dart fix --apply` para correcciones automáticas
3. Configurar pre-commit hooks con `husky` + `lint-staged`

---

### 🔹 Fase 10: Build Multiplataforma y Despliegue (Días 26-30)

**Paso 10.1:** Android
1. Generar keystore: `keytool -genkey -v -keystore antigravity.jks`
2. Configurar `key.properties` en `android/`
3. Build APK: `flutter build apk --release`
4. Build App Bundle: `flutter build appbundle --release`
5. Probar en dispositivo físico

**Paso 10.2:** iOS (requiere macOS)
1. Configurar `ios/Runner.xcodeproj` en Xcode
2. Configurar equipo de desarrollo y certificados
3. Build: `flutter build ios --release`
4. Archivar en Xcode → App Store Connect

**Paso 10.3:** Windows
1. Instalar Visual Studio 2022 con carga de trabajo "Desarrollo de escritorio con C++"
2. Build: `flutter build windows --release`
3. El ejecutable se genera en `build/windows/runner/Release/`
4. Crear installer opcional con Inno Setup o MSIX

**Paso 10.4:** Web
1. Build: `flutter build web --release --base-href "/antigravity/"`
2. Desplegar en Firebase Hosting:
   ```bash
   firebase init hosting
   # Seleccionar build/web como directorio público
   firebase deploy --only hosting
   ```
3. Alternativa: Vercel o Netlify (drag & drop de carpeta build/web)

**Paso 10.5:** CI/CD opcional
1. Configurar GitHub Actions workflow:
   - Trigger: push a `main` o `release/*`
   - Jobs: test (Linux), build (Android, Web), deploy (Firebase Hosting)
2. Usar `actions/checkout`, `subosito/flutter-action`, `firebase-action`

**Paso 10.6:** Documentación final
1. Actualizar `README.md` con:
   - Capturas de pantalla
   - Instrucciones de instalación (cada plataforma)
   - Variables de entorno requeridas
   - Enlaces a tiendas de apps
2. Crear `CONTRIBUTING.md` si es open source
3. Documentar comandos útiles en `docs/`

---

## 📌 Recomendaciones y Buenas Prácticas

### Gestión de Estado con Provider
- **No usar un solo Provider global enorme:** dividir por características
- **Usar `MultiProvider` en `main.dart`**
- **Consumir Providers con `Consumer` o `Selector`** para minimizar rebuilds
- **Provider.of<T>(context, listen: false)** para acciones que no requieren UI reactiva

### Firebase Firestore
- **Desnormalizar datos solo cuando sea necesario para rendimiento**
- **Usar batch writes para operaciones atómicas** (ej. crear well + log juntos)
- **Limitar profundidad de streams:** evitar `StreamBuilder` anidados
- **Cerrar streams en `dispose`** para evitar memory leaks

### Rendimiento
- **Usar `const` widgets siempre que sea posible**
- **ListView.builder para listas largas** (no `ListView(children: [...])`)
- **Evitar funciones anónimas en build** (extraer a métodos o `ValueKey`)
- **Usar `RepaintBoundary` para widgets que se animan independientemente**

### Seguridad
- **Nunca guardar secrets en código cliente**
- **Reglas de Firestore restrictivas** (ver esquema más arriba)
- **Validar inputs tanto en cliente como en reglas**
- **Usar HTTPS en producción para web**

### Accesibilidad
- **Agregar `Semantics` a widgets personalizados**
- **Probar con TalkBack (Android) y VoiceOver (iOS)**
- **Contraste WCAG AA 4.5:1 mínimo**
- **Tamaño táctil mínimo 48x48dp**

### Multiplataforma
- **Probar en todas las plataformas antes de release**
- **Usar `dart:io` solo dentro de `if (kIsWeb)` o `Platform.isXXX`**
- **Evitar plugins que no soporten web/desktop** (verificar `pub.dev`)

---

## 🚫 Exclusiones (Según especificación)

| Elemento | Estado | Razón |
|----------|--------|-------|
| `firebase_analytics` | ❌ No incluido | Especificación: "no utilizar analíticas" |
| `firebase_crashlytics` | ❌ No incluido | Especificación: "no utilizar analíticas" |
| Modo "producción" especial | ❌ No incluido | Usar estándar Flutter `--release` |

---

## ✅ Entregables Finales

| Entregable | Formato | Ubicación |
|------------|---------|------------|
| Código fuente completo | `.dart` | Repositorio GitHub |
| Archivo `pubspec.yaml` | YAML | Raíz del proyecto |
| Configuración Firebase | `.env`, `firebase_options.dart` | `/lib` y `/android` |
| Archivo de reglas Firestore | `.rules` | Firebase Console |
| Documentación técnica | `README.md` | Repositorio |
| Assets (iconos, splash, ilustraciones) | PNG, SVG, Lottie | `/assets` |
| Builds para cada plataforma | `.apk`, `.aab`, `.exe`, `.web` | `/build` o CI/CD artifacts |

---

# 🚀 PROMPT PROFESIONAL PARA GENERAR LA APLICACIÓN

```
Eres un experto desarrollador Flutter especializado en aplicaciones multiplataforma (Android, iOS, Web, Windows) con backend en Firebase. Necesito que desarrolles la aplicación "Antigravity" siguiendo EXACTAMENTE el plan de implementación detallado arriba.

## RESTRICCIONES IMPORTANTES:
1. NO incluyas firebase_analytics ni firebase_crashlytics (sin métricas de ningún tipo)
2. NO utilices modos especiales de "producción" - usa el estándar --release de Flutter
3. Sigue la estructura de carpetas definida en el plan (Feature-First + Provider)
4. Usa la paleta de colores y sistema de diseño especificado
5. Implementa TODAS las fases del 0 al 10 en orden

## LO QUE DEBES GENERAR (PASO A PASO):

### PRIMERA ENTREGA (Fases 0-2):
1. Archivo `pubspec.yaml` completo con todas las dependencias listadas (excluyendo analytics)
2. Estructura completa de carpetas dentro de `/lib`
3. Archivos base:
   - `lib/main.dart` con MultiProvider configurado
   - `lib/firebase_options.dart` (generado por flutterfire configure, pero dime los valores necesarios)
   - `lib/core/themes/app_theme.dart` (light y dark con la paleta definida)
   - `lib/core/themes/theme_provider.dart`
   - `lib/core/routes/app_routes.dart` y `route_generator.dart`
   - `lib/core/widgets/` (loading_widget, error_widget, empty_state_widget, custom_snackbar, gradient_button)
4. Sistema de autenticación completo:
   - `lib/features/auth/models/user_model.dart`
   - `lib/features/auth/services/auth_service.dart`
   - `lib/features/auth/providers/auth_provider.dart`
   - `lib/features/auth/screens/login_screen.dart`
   - `lib/features/auth/screens/register_screen.dart`
   - `lib/features/auth/screens/forgot_password_screen.dart`
5. Onboarding:
   - `lib/features/onboarding/screens/onboarding_screen.dart`
   - Guardar flag en shared_preferences
6. Protección de rutas implementada

### SEGUNDA ENTREGA (Fases 3-5):
7. Modelos de datos con json_serializable:
   - `gravity_well_model.dart`
   - `gravity_field_model.dart`
   - `activity_log_model.dart`
8. Servicios Firestore:
   - `firestore_well_service.dart`
   - `activity_log_service.dart`
9. Providers correspondientes:
   - `gravity_well_provider.dart`
   - `gravity_field_provider.dart`
   - `history_provider.dart`
10. Dashboard:
    - `dashboard_screen.dart` con StreamBuilder y skeleton loading
    - `well_card.dart`
11. Crear/Editar Well:
    - `create_well_screen.dart`
    - `edit_well_screen.dart`
12. Detalle de Well:
    - `well_detail_screen.dart`
    - `field_builder.dart`
    - `field_editor.dart`
13. Sistema de tipos de campo (text, number, date, checkbox, select)

### TERCERA ENTREGA (Fases 6-10):
14. History:
    - `history_screen.dart` con timeline y filtros
15. Perfil:
    - `profile_screen.dart`
    - `edit_profile_screen.dart`
16. Configuración de tema offline:
    - `connectivity_service.dart`
    - `local_storage_service.dart`
17. Manejo global de errores:
    - `error_handler.dart`
18. Pruebas:
    - Tests unitarios para modelos y validadores
    - Tests de widget para login y dashboard
19. Configuración multiplataforma:
    - `flutter_native_splash.yaml`
    - `flutter_launcher_icons.yaml`
20. README.md con instrucciones de instalación para cada plataforma

## FORMATO DE RESPUESTA:
Para cada archivo que generes, usa el formato:
```
### 📄 `ruta/del/archivo.dart`
[CONTENIDO DEL ARCHIVO]
```

Si un archivo requiere configuración adicional (ej. Android keystore, iOS entitlements), indícalo en un bloque de notas.

## REGLAS DE CÓDIGO:
- Usa null-safety en todo momento
- Comenta clases y métodos públicos
- Sigue las convenciones de estilo de Dart (flutter_lints)
- Usa `const` donde sea posible
- Implementa `dispose()` en todos los ChangeNotifier
- Maneja todos los posibles estados de error
- Para strings de UI, usa `AppConstants` (centralizado)

## VERIFICACIÓN FINAL:
Antes de entregar, verifica que:
- [ ] No hay referencias a firebase_analytics o crashlytics
- [ ] El tema light/dark funciona correctamente
- [ ] La autenticación persiste al cerrar la app
- [ ] Firestore tiene reglas de seguridad aplicadas
- [ ] La app compila en web, Android, Windows (al menos conceptualmente)
- [ ] Todos los imports son relativos o usan `package:antigravity_app/...`

Comienza con la PRIMERA ENTREGA (Fases 0-2) proporcionando todos los archivos solicitados en orden.
```
