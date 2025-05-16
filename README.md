# SensazionApp

Una app que busca mejorar la seguridad personal mediante reportes colaborativos en tiempo real y zonas seguras personalizadas y comunitarias.

## 🔖 Tech Stack

- **Frontend:** Flutter
- **Backend:** Supabase
- **Comunicación:** REST API & WebSockets
- **Base de Datos:** Supabase PostgreSQL + PostGIS

## 🌐 Funcionalidades

- Reporta eventos o situaciones peligrosas en tiempo real.
- Recibe notificaciones inmediatas si te acercas a zonas con reportes recientes.
- Crea tus propias zonas seguras (hogar, trabajo, puntos de encuentro).
- Visualiza en el mapa zonas seguras comunitarias (CAI, estaciones de policía).
- Comunicación eficiente: WebSockets para alertas en tiempo real.

## 📊 Arquitectura

- PostGIS para consultas geoespaciales eficientes (puntos y polígonos).
- WebSockets para reportes en tiempo real.
- Supabase para una autenticación robusta.

## 🏆 MVP
### 🗺️ Mapa interactivo
- [ ] Visualización de zonas por niveles de riesgo: verde 🟢, amarillo 🟡, rojo 🔴.
- [ ] Filtro temporal básico (Hoy, Semana, Mes, Históricos).
- [ ] Visualización de la ubicación actual del usuario en tiempo real.

### 🚨 Sistema de reporte de incidentes
- [ ] Formulario simplificado con: tipo de incidente, nivel de riesgo, descripción, ubicación.
- [ ] Opción de reporte anónimo.
- [ ] Confirmación visual tras registrar el reporte.

### 🔐 Funcionalidades esenciales
- [ ] Registro e inicio de sesión simplificados.
- [ ] Zonas seguras públicas predeterminadas: CAIs, estaciones de policía y otros puntos oficiales.
- [ ] Sistema de validación comunitaria: Los usuarios pueden confirmar o desmentir cada reporte para aumentar la confianza en la información.

## 🎓 Roadmap

- [ ] 🏡 Zonas seguras personalizadas: Gestión de zonas privadas como "hogar", "trabajo", "escuela" por usuario.

- [ ] 🔔 Notificaciones de proximidad: Alertas en tiempo real al acercarse a zonas peligrosas.

- [ ] 📊 Estadísticas y analítica de incidentes: Visualización de mapas de calor, picos horarios y análisis por tipo de reporte.

- [ ] 🤝 Sistema de contactos: Permite compartir zonas seguras entre amigos, familiares y contactos.

- [ ] 🆘 Botón de emergencia: Envío rápido de coordenadas y tipo de incidente a contactos o autoridades.

- [ ] 📡 Integración con alertas gubernamentales: Recepción de notificaciones oficiales en caso de desastres, emergencias o disturbios.

- [ ] 🚀 Escalado de distribución en tiempo real: Integración de colas de mensajería como RabbitMQ o Kafka para eficiencia y reducción de carga en el backend.

- [ ] 🧠 Predicción de incidentes con ML: Modelos que estiman riesgo en base a patrones históricos y horarios.

- [ ] 🤖 Integración de GenAI para consejos de seguridad: Sugerencias automáticas sobre rutas y comportamiento seguro.
