# eventos_app

Eventos App es una aplicación móvil desarrollada con Flutter que permite a los usuarios visualizar una lista de eventos próximos, buscar eventos por nombre o descripción, ver información detallada de cada uno, marcar sus favoritos y mantenerlos guardados localmente entre sesiones. La aplicación cuenta con una navegación inferior que permite alternar fácilmente entre la pantalla principal de eventos y la sección de favoritos.

La arquitectura de la aplicación está basada en una estructura limpia simplificada, que divide el proyecto en capas claras: data (fuente de datos, modelos y servicios), domain (entidades y lógica de negocio), presentation (pantallas y componentes de interfaz), y core (utilidades generales). Esta organización permite un desarrollo más limpio, escalable y mantenible. Se aplicaron principios de diseño como SOLID, DRY y KISS, promoviendo una separación adecuada de responsabilidades.

La funcionalidad implementada incluye el listado de eventos con imagen, nombre, ubicación y fecha; navegación a una pantalla de detalle con información completa; búsqueda interactiva por nombre o descripción; y la posibilidad de marcar eventos como favoritos. Los favoritos se almacenan utilizando la librería shared_preferences, lo que permite su persistencia en el dispositivo del usuario.

La interfaz está construida con Flutter y utiliza componentes de Material Design. La lógica de estado se maneja con setState y FutureBuilder, lo cual es suficiente dada la simplicidad actual del proyecto. La fuente de datos se basa en eventos mockeados desde una clase local (FakeEventDatasource), pero la estructura está pensada para permitir una transición sencilla a una API REST real en el futuro.

Para ejecutar la aplicación, se debe clonar el repositorio, ejecutar flutter pub get para instalar dependencias y luego correr flutter run. Si se desea generar un archivo .apk instalable para Android, puede ejecutarse flutter build apk --release y el archivo resultante estará disponible en build/app/outputs/flutter-apk/app-release.apk.

Autor Alejandro Bravo Morteo

