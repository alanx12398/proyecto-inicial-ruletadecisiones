# 📱 Plan de Implementación: "Ruleta de Decisiones" (Flutter + Firebase)

> **Nota preliminar:** Flutter es inherently multiplataforma. VS Code es el IDE recomendado (con extensiones oficiales). *"Antigravity"* no es un entorno estándar para desarrollo Flutter; se asume que te refieres a un editor alternativo o posible error tipográfico. Este plan está optimizado para **VS Code**.

---

## 🛠️ Herramientas Requeridas

| Categoría | Herramienta | Propósito |
|-----------|-------------|-----------|
| **IDE** | VS Code + Extensiones (Flutter, Dart, Firebase, GitLens) | Desarrollo, depuración y formateo |
| **SDKs** | Flutter SDK, Dart SDK | Compilación y ejecución multiplataforma |
| **Firebase** | Firebase Console, Firebase CLI (`flutterfire`) | Backend, Auth, Firestore, Analytics |
| **Control de Versiones** | Git + GitHub/GitLab | Historial, ramas, colaboración |
| **Diseño UI/UX** | Figma o Penpot | Wireframes, prototipos, sistema de diseño |
| **Emuladores/Dispositivos** | Android Emulator, iOS Simulator (macOS), Chrome/Web | Pruebas multiplataforma |
| **Debug & Performance** | Flutter DevTools, Firebase Crashlytics | Profiling, logs, reportes de errores |

---

## 🎨 UI/UX: Principios y Flujo de Usuario

1. **Arquitectura Visual:** Diseño limpio, jerarquía clara, espacio negativo generoso.
2. **Microinteracciones:** Feedback háptico al girar, sonidos sutiles (opcional), transiciones suaves.
3. **Accesibilidad:** Contraste WCAG AA, soporte TalkBack/VoiceOver, textos escalables.
4. **Flujo Principal:**
   - Pantalla de bienvenida → Login/Registro → Dashboard de Ruletas → Crear/Editar Ruleta → Giro → Resultado → Historial.
5. **Estados de UI:** Carga, éxito, error, vacío, offline, sin permisos.
6. **Modos:** Light/Dark automático según sistema.

---

## 📦 Dependencias Conceptuales para `pubspec.yaml`

> *No se incluye código. Lista conceptual organizada por funcionalidad.*

| Paquete | Función |
|---------|---------|
| `firebase_core` | Inicialización del ecosistema Firebase |
| `firebase_auth` | Autenticación email/password, gestión de sesión |
| `cloud_firestore` | Base de datos NoSQL en tiempo real |
| `provider` | Gestión de estado reactivo y inyección de dependencias |
| `intl` | Formateo de fechas, localización |
| `shared_preferences` | Cache ligero de preferencias (tema, última ruleta usada) |
| `flutter_svg` | Renderizado de iconos/ilustraciones vectoriales |
| `animations` | Transiciones y rutas animadas |
| `firebase_analytics` + `firebase_crashlytics` | Métricas de uso y reporte de fallos |
| `haptic_feedback` o `vibration` | Respuesta táctil durante el giro |
| `flutter_lints` | Reglas de calidad y estilo de código |

---

## 📋 Plan de Implementación Paso a Paso

### 🔹 Fase 1: Entorno y Configuración Inicial
1. Instalar Flutter SDK y verificar con `flutter doctor`.
2. Configurar VS Code: instalar extensiones oficiales, habilitar formateo automático y linting.
3. Crear proyecto Flutter: `flutter create ruleta_decisiones --platforms android,ios,web`.
4. Inicializar repositorio Git, crear `.gitignore` estándar y rama `main`.
5. Crear proyecto en Firebase Console (Android, iOS, Web).
6. Instalar `flutterfire_cli` y ejecutar `flutterfire configure` para generar archivos de configuración automática.
7. Validar compilación en al menos 2 plataformas (ej. Android + Web).

### 🔹 Fase 2: Arquitectura y Gestión de Estado
1. Definir estructura de carpetas por características (`lib/features/auth`, `lib/features/roulette`, `lib/features/history`, `lib/core`).
2. Establecer patrón de arquitectura: **MVVM** o **Feature-First + Provider**.
3. Crear clases de modelo para `User`, `DecisionWheel`, `WheelItem`, `SpinResult`.
4. Configurar `ChangeNotifierProvider` global y por característica.
5. Definir rutas de navegación con `MaterialApp.router` o `go_router` (según preferencia).
6. Implementar sistema de temas y localización base.

### 🔹 Fase 3: Autenticación (Email/Password)
1. Habilitar método Email/Password en Firebase Console → Authentication.
2. Crear vistas: Login, Registro, Recuperar Contraseña.
3. Implementar validaciones de formulario (regex, longitud, coincidencia).
4. Conectar formularios con `firebase_auth` a través de un `AuthNotifier` (Provider).
5. Manejar estados: cargando, éxito, error específico (contraseña incorrecta, correo existente, red).
6. Persistir sesión: Firebase mantiene el token; añadir logout seguro y redirección a pantalla de login.
7. Proteger rutas: middleware de autenticación que redirija si `currentUser == null`.

### 🔹 Fase 4: Base de Datos y Sincronización (Firestore)
1. Diseñar esquema de colecciones:
   ```
   users/{uid}/wheels/{wheelId}/items/{itemId}
   users/{uid}/history/{spinId}
   ```
2. Configurar `cloud_firestore` con persistencia offline habilitada.
3. Implementar reglas de seguridad en Firebase Console:
   - Solo el dueño puede leer/escribir sus ruletas.
   - Validar tipos y límites de datos (ej. máximo 20 opciones por ruleta).
4. Crear `FirestoreRepository` con métodos: `createWheel`, `updateWheel`, `deleteWheel`, `getWheelsStream`, `saveSpinResult`.
5. Integrar streams con Provider para actualización en tiempo real de la UI.
6. Manejar errores de red y estados offline (cola local o notificación amigable).

### 🔹 Fase 5: Lógica de la Ruleta y Animaciones
1. Modelar matemáticamente la ruleta: división angular equitativa, cálculo de probabilidad ponderada (si aplica).
2. Elegir técnica de renderizado: `CustomPaint` (recomendado para control total) o librería de gráficos.
3. Implementar animación de giro:
   - Curva de desaceleración (`Curves.decelerate` o `easeOutCubic`).
   - Duración variable según peso de resultados o aleatoria controlada.
4. Detectar resultado final: ángulo final mapeado a índice de opciones.
5. Añadir feedback: vibración al detenerse, sonido opcional, resaltado del resultado.
6. Crear vistas: Editor de Ruleta (añadir/eliminar/colorear opciones), Pantalla de Giro, Vista de Resultado.

### 🔹 Fase 6: Testing, Optimización y UX Final
1. **Pruebas unitarias:** lógica de reparto angular, cálculos de probabilidad, validaciones de formularios.
2. **Pruebas de widget:** renderizado de ruleta, estados de carga/error, navegación.
3. **Pruebas de integración:** flujo completo Login → Crear Ruleta → Girar → Guardar en Historial.
4. Optimizar con Flutter DevTools: reducir rebuilds innecesarios, usar `const`, `ValueListenableBuilder`, `Provider.of(context, listen: false)`.
5. Implementar manejo global de errores y estados vacíos.
6. Validar accesibilidad: navegación por teclado, lectores de pantalla, escalado de texto.
7. Pulir microinteracciones, sombras, bordes, y consistencia visual.

### 🔹 Fase 7: Compilación Multiplataforma y Despliegue
1. Generar builds de liberación:
   - `flutter build apk --release`
   - `flutter build ios --release`
   - `flutter build web --release`
2. Configurar firmados digitales (keystore Android, provisioning profile iOS).
3. Añadir metadatos: iconos adaptativos, splash screen, permisos, descripción.
4. Integrar CI/CD opcional con GitHub Actions para builds automáticos y pruebas.
5. Publicar en tiendas (Google Play Console, App Store Connect) o desplegar web en Firebase Hosting/Vercel.
6. Monitorear post-lanzamiento con Crashlytics y Analytics; iterar según feedback.

---

## 📌 Recomendaciones y Buenas Prácticas

- **No acoplar lógica de negocio a la UI:** separar repositorios, notifiers y vistas.
- **Usar streams de Firestore con moderación:** cerrar listeners al salir de pantalla para evitar consumo innecesario.
- **Manejar errores de forma granular:** no mostrar mensajes genéricos; traducir códigos de Firebase a lenguaje humano.
- **Mantener `pubspec.yaml` limpio:** actualizar dependencias periódicamente, evitar paquetes abandonados.
- **Documentar reglas de Firestore y arquitectura** en un `README.md` dentro del repositorio.
- **Realizar revisiones de UI en dispositivos reales** (especialmente para animaciones de ruleta y respuesta táctil).

---

✅ **Siguiente paso:** Una vez validado este plan, puedo proporcionarte la estructura de carpetas detallada, el `pubspec.yaml` listo para copiar, o empezar fase por fase con guías de implementación (sin código si lo prefieres, o con fragmentos comentados cuando lo solicites). ¿Deseas ajustar algún flujo o añadir características antes de continuar?
