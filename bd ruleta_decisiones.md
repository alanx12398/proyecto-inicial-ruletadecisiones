actua como un administrador de base de datos:proyecto ruleta de decisiones,que entidades se necesita para su gestion
Como DBA, aquí tienes el modelo de entidades para el proyecto **Ruleta de Decisiones**:---
<img width="587" height="800" alt="image" src="https://github.com/user-attachments/assets/14ad0b4a-3470-4be9-be86-9c38da8e0ebd" />


**Entidades y su justificación:**

**`USUARIO`** — Gestiona la autenticación y la propiedad de ruletas. Permite multi-usuario y control de acceso.

**`RULETA`** — Entidad central del sistema. Contiene la referencia al dueño, la categoría y metadatos como si es pública o privada.

**`OPCION`** — Cada ítem que puede aparecer en la ruleta. El campo `peso` es clave: permite que unas opciones tengan mayor probabilidad de ser seleccionadas que otras.

**`HISTORIAL`** — Registra cada giro con timestamp, ruleta, opción ganadora y quién giró. Fundamental para auditoría, analítica y evitar repetición de opciones.

**`CONFIGURACION`** — Separo esta entidad de `RULETA` (relación 1:0..1) para no inflar la tabla principal con columnas de comportamiento. Incluye duración de animación, colores y si se permiten repetidos.

**`CATEGORIA`** — Permite organizar y filtrar ruletas (ej: *Personal*, *Trabajo*, *Juegos*).

---

**Decisiones de diseño relevantes:**

- Usar `uuid` como PK en lugar de `integer` autoincremental facilita sharding y evita enumeración de recursos en APIs.
- El campo `peso` en `OPCION` implementa probabilidad ponderada sin lógica extra en el modelo.
- `HISTORIAL` referencia tanto `ruleta_id` como `opcion_id` para consultas eficientes en ambas direcciones.

¿Quieres que profundice en los índices recomendados, constraints, o el diseño de la lógica del giro ponderado?

las entidades con sus atributos y tipo de forma de tabla para cada una de las entidades

## Tablas
<img width="545" height="709" alt="image" src="https://github.com/user-attachments/assets/3767182d-cf5b-4d7b-bbdf-631f105f4d33" />
<img width="553" height="782" alt="image" src="https://github.com/user-attachments/assets/f403f325-4830-4541-9607-afe243d1aa32" />

## 

