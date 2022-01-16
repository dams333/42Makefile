# RoadMap
- Make the libraries' system more clean and scalable
- Make the command options' system more clean
# Documentation
## Compilation
### Basic
- You can choose your compilator with the variable `CC`
- You can add some compilation flags (like `-l` flags to add standard libraries) with the variable `CFLAGS` _(Classic flags generated by make command's parameters)_
- You can choose the executable's name with the variable `name` 
### Add default compilation's flags
- By default the Makefile compile with `-Wall -Wextra -Werror`
- With `make [rule] noflag`, you can disable `-Wextra -Werror`
- With `make [rule] debug`, you can add `-g3`
- With `make [rule] sanadd`, you can add `-fsanitize=address`
- With `make [rule] santhread`, you can add `-fsanitize=thread`
---
## Files
### Sources
- Use `SRCS_EXTENSION` variable to define tyope of file _(.c/.cpp/...)_
- Your main need to be defined in the variable `MAIN` _(if it's in the srcs folder, please specify it as `srcs/main.c`)_
- Add all the other sources in the variable `SRCS`
### Includes
- Use `INCLUDE_DIRS` to choose all the folders where are the `.h` files
---
## Libs
- You can activate the use of different libraries in the corresponding sections
- `[LIB]_DIR` variable is the directory where is the library's makefile
- `[LIB]_INCLUDE_DIR` variable is the directory where is the `.h` of the library
- `[LIB]_NAME` vairable is the name of the library _(she needs to be at the root of the `[LIB]_DIR` folder)_
---
## Rules
- `$(NAME)` compile the executable
- `all` call `$(NAME)`
- `clean` remove all compiled objects
- `fclean` call `clean` and remove the executable
- `re` call `fclean` and `all`
- `fcleanlib` call `fclean` and execute `fclean` rule in the libraries' folders
- `relib` call `fcleanlib` and `all`
- `run` call `all` and launch the executable
- `show` show some useful informations about the Makefile's variables _(for example, use with command's options to see the activated flags)_ 