# Planteamiento del Problema

## 🔍 Introducción

La seguridad personal en espacios urbanos es un problema cotidiano, especialmente en zonas con altos niveles de criminalidad o movilidad frecuente. Las aplicaciones actuales ofrecen reportes de delitos en ciertas regiones, pero no logran cubrir la inmediatez ni la personalización que requieren los usuarios para evitar riesgos en tiempo real.

## 💡 Definición del problema

Hoy en día, las personas enfrentan limitaciones críticas para mantenerse seguras en sus entornos cotidianos:

- ⚠️ No existe una forma accesible y confiable de identificar zonas de peligro o recibir información sobre incidentes en tiempo real sin estar físicamente en el lugar.

- 🗺️ Es imposible saber con certeza si se está acercando a un área de riesgo, especialmente en zonas desconocidas.

- 🤝 No hay canales comunitarios simples que permitan a las personas reportar, validar o consultar incidentes locales de manera colaborativa.

## 🚀 Solución Propuesta

**SensazionApp** combina:

- **Google Maps + PostGIS:** Para geolocalización precisa y gestión de zonas seguras (puntos y polígonos).
- **Spring Boot:** Para gestionar la lógica del backend y la seguridad mediante OAuth2.
- **WebSockets:** Para difusión en tiempo real de nuevos reportes.

Esta combinación permite mostrar información relevante y personalizada a cada usuario según su ubicación, mejorando la prevención de incidentes.

## ⚡ Riesgos Identificados

- **Falsos reportes:** Mitigación mediante moderación y sistema de votos.
- **Carga de WebSockets:** Uso de grupos geoespaciales para distribuir eventos según ubicación en futuras versiones.
- **Privacidad:** Encriptación de datos sensibles y estricta autenticación con Spring Authorization Server.

## 🏆 Fortalezas

- Datos geoespaciales altamente optimizados gracias a PostGIS.
- Bajo tiempo de latencia en eventos con WebSockets.
- Escalabilidad natural con colas de mensajería en futuras versiones.

## ✅ Conclusión

La solución propuesta se adecua al problema por su enfoque en la inmediatez, precisión y facilidad de uso para el usuario promedio. Aunque los riesgos existen, se han considerado mecanismos de mitigación que garantizan una experiencia fiable y segura desde el MVP.
