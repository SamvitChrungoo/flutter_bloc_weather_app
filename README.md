# Flutter Weather App

A Weather App (boilerplate) using BLOC architecture.

- ### Naming Conventions

  - Folder Name : your_folder_name (snake case) as flutter itself follows the same.
  - File Name : your_file_name.dart

- ### Enums

  - Defined all Enum required for the Bloc State in `lib/utils/enums/`

- ### Images

  - Place image in `assets/images/` and add the same in `pubspec.yaml` file

### Top-level directory layout

    lib
    ├── bloc                    # contains all bloc components (eg. WeatherBloc) used.
    ├── repository              # contains all repositories to be used (contains function for api calls etc).
        ├── models              # contains data model for the repositories, represents how data is stored.
    ├── screens                 # contains screen UI.
    ├── common_components       # contains all the components used in the app.
    ├── utils
        ├── enums               # enums used for Bloc states.
    └── main.dart               # FLUTTER entry point.

> Use short lowercase names at least for the top-level files and folders except
> `LICENSE`, `README.md`
