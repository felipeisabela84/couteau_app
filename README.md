# Caja de herramientas

App móvil hecha con **Flutter** que reúne 7 herramientas en una sola aplicación. Cada una consume una API pública distinta.

## Herramientas

| # | Vista | Qué hace | API |
|---|-------|----------|-----|
| 1 | Género | Recibe un nombre y predice el género. Masculino muestra fondo azul y femenino, rosa. | [Genderize](https://api.genderize.io) |
| 2 | Persona | Muestra una persona aleatoria con nombre, apellido, foto, fecha de nacimiento y edad. | [Random User](https://randomuser.me/api/?results=1) |
| 3 | Universidades | Recibe un país en inglés y lista nombre, dominio y página web de sus universidades. | [Adamix proxy](https://adamix.net/proxy.php?country=Dominican+Republic) |
| 4 | Clima RD | Muestra el clima del día en Santo Domingo. | [Open-Meteo](https://open-meteo.com) |
| 5 | Pokémon | Recibe un nombre y muestra foto, experiencia base, habilidades y sonido. | [PokéAPI](https://pokeapi.co/api/v2/pokemon/pikachu) |
| 6 | Noticias | Muestra el logo de TechCrunch y sus 3 últimas noticias, con enlace a la original. | [WordPress REST API](https://techcrunch.com/wp-json/wp/v2/posts?per_page=3) |
| 7 | Acerca de | Foto y datos de contacto del autor. | — |

## Tecnologías

- Flutter y Dart
- Paquetes: `http`, `url_launcher`, `audioplayers`, `intl`
- Control de versiones: Git y GitHub

## Estructura del proyecto

```
lib/
  main.dart                  # Menú principal y navegación
  pantallas/
    genero.dart
    persona.dart
    universidades.dart
    clima.dart
    pokemon.dart
    wordpress.dart
    acerca_de.dart
assets/
  caja.png                   # Imagen del menú principal
  yo.jpg                     # Foto de "Acerca de"
  icono.png                  # Ícono de la app
```

## Cómo ejecutarla

1. Instala [Flutter](https://flutter.dev) y revisa que todo esté bien:
   ```
   flutter doctor
   ```
2. Clona el repositorio:
   ```
   git clone https://github.com/felipeisabela84/TU_REPOSITORIO.git
   cd TU_REPOSITORIO
   ```
3. Instala las dependencias:
   ```
   flutter pub get
   ```
4. Ejecuta la app en un emulador o en tu celular:
   ```
   flutter run
   ```

## Generar el APK

```
flutter build apk
```

El archivo queda en `build/app/outputs/flutter-apk/app-release.apk`.

## Notas

- Se necesita conexión a internet para todas las vistas excepto "Acerca de".
- En Windows hay que activar el **Modo de desarrollador** para compilar con plugins.

## Autora

**Ericka Ranocchi**
Estudiante de Desarrollo de Software, ITLA

- GitHub: [felipeisabela84](https://github.com/felipeisabela84)
- Correo: felipeisabela840@gmail.com