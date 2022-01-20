# RoadMap
- Make the library addition system cleaner and scalable
- Add a progress bar during compilation
# Generator script
The `generate.sh` script is a util script to init a project's directory. Start it in the folder where you want the project's folder wil be created and follow the instructions !
# Documentation
## Compilation
### Basic
- You can choose the name of your executable with the variable `name` 
- You can choose your compiler in the variable `CC`
- You can add some compilation flags (like `-l` flags to add standard libraries) in the variable `CFLAGS` _(The classic flags are managed in the options of the make command, see below)_
### Make command options
- By default the Makefile compile with `-Wall -Wextra -Werror`
- With `make [rule] noflag`, you can disable `-Werror`
- With `make [rule] debug`, you can add `-g3`
- With `make [rule] sanadd`, you can add `-fsanitize=address`
- With `make [rule] santhread`, you can add `-fsanitize=thread`
- If you don't specify a rule, `make noflag` is equal to `make all noflag`
- All these flags are cumulativee _(`make re noflag debug sanadd` is valid)_
---
## Files
### Sources
- Use `SRCS_EXTENSION` to define the file type of your sources _(.c/.cpp/...)_
- Your main must be defined in the variable `MAIN` _(If it is in the sources folder, called `SRCS_PATH`, you must add it like this `srcs/main.c`)_
- Add all other sources in `SRCS` _(without the folder defined in `SRCS_PATH`)_
### Includes
- Use `INCLUDE_DIRS` to select all the folders where your headers are located
---
## Libs
- You can enable the use of certain libraries in the corresponding sections. For each:
- `[LIB]_DIR` is the directory where the Makefile of the library is located
- `[LIB]_INCLUDE_DIR` is the directory where the headers' files of the library are located
- `[LIB]_NAME` is the name of the library with her extension, normally `.a` _(she needs to be at the root of the `[LIB]_DIR` folder)_
---
## Rules
- `$(NAME)` compile the executable
- `all` call `$(NAME)`
- `clean` remove all compiled objects
- `fclean` call `clean` and remove the executable
- `re` call `fclean` and `all`
- `fcleanlib` call `fclean` and execute `fclean` rule in the libraries' folders
- `relib` call `fcleanlib` and `all`
- `run` call `all` and launch the executable _(You can precise some argument to give to the executable at launch in `RUN_PARAM`)_
- `show` show some useful informations about the Makefile's variables