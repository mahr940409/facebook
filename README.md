# Facebook

Aplicación web tipo red social desarrollada con Ruby on Rails. Permite crear una cuenta, publicar contenido, conectar con otros usuarios e intercambiar mensajes.

## Funcionalidades

- Registro, inicio y cierre de sesión, recuperación de contraseña y gestión de usuarios mediante Devise.
- Página principal con publicaciones propias y de amigos.
- Creación, edición y eliminación de publicaciones de texto.
- Carga y eliminación de imágenes en publicaciones y avatares mediante Active Storage.
- Solicitudes de amistad: enviar, aceptar y rechazar.
- Consulta de perfiles y amistades.
- Comentarios y “likes” en publicaciones.
- Chats individuales con historial de mensajes.
- Diseño responsive basado en Bootstrap.

## Tecnologías

- Ruby on Rails `8.1.3` o superior dentro de la serie 8.1.
- SQLite3, Puma y Devise.
- Hotwire (Turbo y Stimulus) e Importmap.
- Bootstrap 5 y Dart Sass.
- Active Storage para archivos adjuntos.
- Solid Cache, Solid Queue y Solid Cable.

## Requisitos previos

- Ruby y Bundler.
- SQLite3.
- Node.js, si tu instalación de Sass lo requiere.

Comprueba las instalaciones con:

```bash
ruby --version
bundle --version
sqlite3 --version
```

## Instalación local

```bash
git clone https://github.com/mahr940409/facebook.git
cd facebook
bin/setup --skip-server
```

El proyecto utiliza SQLite y crea sus bases de datos dentro de `storage/`. Para reiniciar la base de datos de desarrollo:

```bash
bin/setup --reset --skip-server
```

## Ejecutar la aplicación

Para iniciar el servidor junto con el compilador/watch de estilos:

```bash
bin/dev
```

Abre [http://localhost:3000](http://localhost:3000). También puedes iniciar únicamente Rails con `bin/rails server`.

## Pruebas

```bash
bin/rails test
```

Para ejecutar una prueba específica:

```bash
bin/rails test test/models/user_test.rb
```

## Comandos útiles

```bash
bin/rails db:prepare       # Preparar la base de datos
bin/rails db:migrate       # Ejecutar migraciones pendientes
bin/rails routes            # Revisar las rutas
bin/brakeman               # Analizar seguridad
bin/bundler-audit          # Revisar vulnerabilidades de dependencias
bin/rubocop                # Revisar estilo Ruby
```

## Estructura principal

```text
app/
├── controllers/   # Peticiones y acciones de la aplicación
├── models/        # Usuarios, publicaciones, amistades, chats y mensajes
├── views/         # Plantillas HTML/ERB
└── javascript/    # Importmap y controladores Stimulus
config/            # Rutas y configuración
db/                # Migraciones, esquema y datos iniciales
test/              # Pruebas automatizadas
```

## Base de datos y archivos

En desarrollo, la base de datos principal es `storage/development.sqlite3`. Las imágenes de perfiles y publicaciones se gestionan con Active Storage y se almacenan localmente en desarrollo. En producción, el directorio `storage/` debe mantenerse persistente para no perder la base de datos ni los archivos subidos.

## Producción

El proyecto incluye configuración para despliegue con Docker y Kamal. Antes de desplegar, revisa las credenciales, las variables de producción, la persistencia de `storage/`, Active Storage y la configuración de correo de Devise.

## Estado de la revisión

Esta documentación se generó a partir de las rutas, modelos, controladores, dependencias y configuración actuales. No se modificó la lógica de la aplicación ni sus vistas existentes.

## Licencia

El proyecto no incluye actualmente un archivo de licencia. Añade una antes de publicarlo si quieres definir las condiciones de uso y distribución.
