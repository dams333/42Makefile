#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
ORANGE='\033[0;33m'
BOLD='\033[1m'
NO_COLOR='\033[0m' # No Color
DEFAULT_FILE="https://raw.githubusercontent.com/dams333/42Makefile/master/Makefile.default"

printf "${BLUE}"
printf "  _  _ ___                    _         __ _ _      \n"
printf " | || |__ \                  | |       / _(_) |     \n"
printf " | || |_ ) |  _ __ ___   __ _| | _____| |_ _| | ___ \n"
printf " |__   _/ /  | '_ \` _ \ / _\` | |/ / _ \  _| | |/ _ \\ \n"
printf "    | |/ /_  | | | | | | (_| |   <  __/ | | | |  __/\n"
printf "    |_|____| |_| |_| |_|\__,_|_|\_\___|_| |_|_|\___|\n"
printf "                                         by dhubleur\n"
printf "${NO_COLOR}"

printf "${CYAN}Choose the ${UNDERLINE}project's name${CYAN}: \n ${GREEN}${BOLD}  > ${NO_COLOR}";
read EXEC_NAME;
if [ -z "$EXEC_NAME" ]; then
	printf "${BOLD}[${RED}${BOLD}ERROR${NO_COLOR}${BOLD}]${NO_COLOR} Executable's name cannot be empty.\n";
	exit 1;
fi

printf "${CYAN}Choose the ${UNDERLINE}compilator${CYAN} (leave empty to choose gcc): \n ${GREEN}${BOLD}  > ${NO_COLOR}";
read CC_NAME;
if [ -z "$CC_NAME" ]; then
	CC_NAME='gcc';
fi

printf "${CYAN}Choose the ${UNDERLINE}default compilation flags${CYAN} (like '-lm' or '-pthread'): \n ${GREEN}${BOLD}  > ${NO_COLOR}";
read FLAGS;
if [ -z "$FLAGS" ]; then
	FLAGS=' ';
fi

printf "${CYAN}Choose the ${UNDERLINE}default arguments gived to the executable${CYAN} (use for 'run' rule): \n ${GREEN}${BOLD}  > ${NO_COLOR}";
read ARGS;
if [ -z "$ARGS" ]; then
	ARGS=' ';
fi

printf "${CYAN}Choose the ${UNDERLINE}sources' extension${CYAN} (leave empty to choose .c): \n ${GREEN}${BOLD}  > ${NO_COLOR}";
read SRCS_EXT;
if [ -z "$SRCS_EXT" ]; then
	SRCS_EXT='.c';
fi

printf "${CYAN}Choose the ${UNDERLINE}sources' directory${CYAN} (leave empty to choose './srcs'): \n ${GREEN}${BOLD}  > ${NO_COLOR}";
read SRCS_DIR;
if [ -z "$SRCS_DIR" ]; then
	SRCS_DIR='./srcs';
fi

printf "${CYAN}Choose the ${UNDERLINE}name of the main, total path include${CYAN} (leave empty to choose './main.c'): \n ${GREEN}${BOLD}  > ${NO_COLOR}";
read MAIN_PATH;
if [ -z "$MAIN_PATH" ]; then
	MAIN_PATH='main.c';
fi

printf "${CYAN}Choose all the ${UNDERLINE}headers' directories${CYAN} (leave empty to choose './includes'): \n ${GREEN}${BOLD}  > ${NO_COLOR}";
read INCL_DIR;
if [ -z "$INCL_DIR" ]; then
	INCL_DIR='./includes';
fi

printf "${CYAN}Do you want to use your ${UNDERLINE}libft${CYAN} (y/n) (default is: 'no'): \n ${GREEN}${BOLD}  > ${NO_COLOR}";
read IS_LIBFT;
if [ -z "$IS_LIBFT" ]; then
	IS_LIBFT='n';
fi
if [ "$IS_LIBFT" != "y" ] && [ "$IS_LIBFT" != "Y" ] && [ "$IS_LIBFT" != "n" ] && [ "$IS_LIBFT" != "N" ]; then
	IS_LIBFT='n';
fi
if [ "$IS_LIBFT" != "y" ] || [ "$IS_LIBFT" != "Y" ]; then
	IS_LIBFT='true';
fi
if [ "$IS_LIBFT" != "n" ] || [ "$IS_LIBFT" != "n" ]; then
	IS_LIBFT='false';
fi

printf "${CYAN}Do you want to use the ${UNDERLINE}MiniLibX${CYAN} (y/n) (default is: 'no'): \n ${GREEN}${BOLD}  > ${NO_COLOR}";
read IS_MLX;
if [ -z "$IS_MLX" ]; then
	IS_MLX='n';
fi
if [ "$IS_MLX" != "y" ] && [ "$IS_MLX" != "Y" ] && [ "$IS_MLX" != "n" ] && [ "$IS_MLX" != "N" ]; then
	IS_MLX='n';
fi
if [ "$IS_MLX" != "y" ] || [ "$IS_MLX" != "Y" ]; then
	IS_MLX='true';
fi
if [ "$IS_MLX" != "n" ] || [ "$IS_MLX" != "n" ]; then
	IS_MLX='false';
fi

printf "${RED}Please confirm all the information below:\n${NO_COLOR}"
printf "${GREEN}Project's name: ${BOLD}${CYAN}${EXEC_NAME}${NO_COLOR}\n"
printf "${GREEN}Compilator: ${BOLD}${CYAN}${CC_NAME}${NO_COLOR}\n"
printf "${GREEN}Default compilation flags: ${BOLD}${CYAN}${FLAGS}${NO_COLOR}\n"
printf "${GREEN}Default run arguments: ${BOLD}${CYAN}${ARGS}${NO_COLOR}\n"
printf "${GREEN}Sources' extension: ${BOLD}${CYAN}${SRCS_EXT}${NO_COLOR}\n"
printf "${GREEN}Sources' directory: ${BOLD}${CYAN}${SRCS_DIR}${NO_COLOR}\n"
printf "${GREEN}Main path: ${BOLD}${CYAN}${MAIN_PATH}${NO_COLOR}\n"
printf "${GREEN}Headers' directoryies ${BOLD}${CYAN}${INCL_DIR}${NO_COLOR}\n"
printf "${GREEN}Use of Libft ${BOLD}${CYAN}${IS_LIBFT}${NO_COLOR}\n"
printf "${GREEN}Use of Mlx ${BOLD}${CYAN}${IS_MLX}${NO_COLOR}\n"
printf "${ORANGE}Are you okay with this informations ? (y/n)\n ${GREEN}${BOLD}  > ${NO_COLOR}"

read CONFIRM;
if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ] && [ "$CONFIRM" != "n" ] && [ "$CONFIRM" != "N" ]; then
	CONFIRM="y";
fi
if [ "$CONFIRM" == "n" ] || [ "$CONFIRM" == "N" ]; then
	printf "${BLUE}Process succesfully canceled !\n";
	exit 1;
fi

mkdir -p $EXEC_NAME;
cd $EXEC_NAME;
echo "int	main(void) {}" > $MAIN_PATH;
curl -s $DEFAULT_FILE	| sed 's%default_name%'"$EXEC_NAME"'%g' \
					| sed 's%default_comp%'"$CC_NAME"'%g' \
					| sed 's%default_flags%'"$FLAGS"'%g' \
					| sed 's%default_args%'"$ARGS"'%g' \
					| sed 's%default_srcs_ext%'"$SRCS_EXT"'%g' \
					| sed 's%default_srcs_path%'"$SRCS_DIR"'%g' \
					| sed 's%default_main%'"$MAIN_PATH"'%g' \
					| sed 's%default_incl_path%'"$INCL_DIR"'%g' \
					| sed 's%default_libft%'"$IS_LIBFT"'%g' \
					| sed 's%default_mlx%'"$IS_MLX"'%g'  \
					> Makefile
mkdir -p $SRCS_DIR;
mkdir -p $INCL_DIR;

printf "${BOLD}${GREEN}All files succesfully created !\n";
exit 0;