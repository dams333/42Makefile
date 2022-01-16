# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dhubleur <dhubleur@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/12/08 10:05:58 by dhubleur          #+#    #+#              #
#    Updated: 2022/01/16 16:04:58 by dhubleur         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

################################################################################
#									Utils									   #
################################################################################

NAME		= 	philo

CC			= 	gcc
ifeq (noflag, $(filter noflag,$(MAKECMDGOALS)))
	CFLAGS	=	-Wall
else
	CFLAGS	=	-Wall -Wextra -Werror
endif
ifeq (debug, $(filter debug,$(MAKECMDGOALS)))
	CFLAGS	+=	-g3
endif
ifeq (sanadd, $(filter sanadd,$(MAKECMDGOALS)))
	CFLAGS	+=	-fsanitize=address
endif
ifeq (santhread, $(filter santhread,$(MAKECMDGOALS)))
	CFLAGS	+=	-fsanitize=thread
endif

################################################################################
#									Sources									   #
################################################################################

SRCS_EXTENSION	=	.c
SRCS_PATH		=	./srcs
MAIN			=	maintest.c
SRCS			=	

################################################################################
#									Includes								   #
################################################################################

INCLUDE_EXTENSION	=	.h
INCLUDE_DIRS		=	./includes 

################################################################################
#									Libft									   #
################################################################################

IS_LIBFT			=	false

LIBFT_DIR			=	./libft
LIBFT_INCLUDE_DIR	=	./libft
LIBFT_NAME			=	libft.a

################################################################################
#									MiniLibX								   #
################################################################################

IS_MLX				=	false

MLX_DIR				=	./minilibx-linux
MLX_INCLUDE_DIR		=	./minilibx-linux
MLX_NAME			=	minilibx.a

#                          /!\ Don't touch next /!\ 

################################################################################
#									Objects									   #
################################################################################

OBJS_PATH		=	./objs

OBJS			=	$(addprefix $(OBJS_PATH)/, ${SRCS:$(SRCS_EXTENSION)=.o})
OBJ_MAIN		=	$(addprefix $(OBJS_PATH)/, ${MAIN:$(SRCS_EXTENSION)=.o})

################################################################################
#									Constants								   #
################################################################################

BLUE		=	\033[1;34m
CYAN		=	\033[0;36m
GREEN		=	\033[0;32m
ORANGE  	=	\033[0;33m
NO_COLOR	=	\033[m

################################################################################
#									Makefile								   #
################################################################################

INCLUDE_FLAGS 	=	$(addprefix -I , ${INCLUDE_DIRS})

LIBFT_COMPLETE	=	$(LIBFT_DIR)/${LIBFT_NAME}
MLX_COMPLETE	=	$(LIBFT_DIR)/${LIBFT_NAME}

ifeq ($(IS_LIBFT),true)
	INCLUDE_FLAGS	+=	$(addprefix -I , ${LIBFT_INCLUDE_DIR})
	ALL_LIBS		+=	$(LIBFT_COMPLETE)
endif

ifeq ($(IS_MLX),true)
	INCLUDE_FLAGS	+=	$(addprefix -I , ${MLX_INCLUDE_DIR})
	ALL_LIBS		+=	$(MLX_COMPLETE)
endif

################################################################################
#									Rules									   #
################################################################################

all:	header $(NAME)

header:
		@echo -n "${BLUE}"
		@echo "  _  _ ___                    _         __ _ _      "
		@echo " | || |__ \                  | |       / _(_) |     "
		@echo " | || |_ ) |  _ __ ___   __ _| | _____| |_ _| | ___ "
		@echo " |__   _/ /  | '_ \` _ \ / _\` | |/ / _ \  _| | |/ _ \\"
		@echo "    | |/ /_  | | | | | | (_| |   <  __/ | | | |  __/"
		@echo "    |_|____| |_| |_| |_|\__,_|_|\_\___|_| |_|_|\___|"
		@echo "                                     by dhubleur    "
		@echo -n "${NO_COLOR}"

#Compilation
$(OBJS_PATH)/%.o:	$(SRCS_PATH)/%$(SRCS_EXTENSION)
			@mkdir -p ${OBJS_PATH}
			@$(CC) $(CFLAGS) -c $< -o $@ ${INCLUDE_FLAGS}
$(OBJS_PATH)/%.o:	%$(SRCS_EXTENSION)
			@mkdir -p ${OBJS_PATH}
			@echo "$(CYAN)Compiling $(BLUE)$@ ...$(NO_COLOR)"
			@$(CC) $(CFLAGS) -c $< -o $@ ${INCLUDE_FLAGS}

$(LIBFT_COMPLETE):
ifeq ($(IS_LIBFT),true)
			@make -C $(LIBFT_DIR) all
			@echo "$(GREEN)Compiled libft !$(NO_COLOR)"
endif
$(MLX_COMPLETE):
ifeq ($(IS_MLX),true)
			@make -C $(MLX_DIR) all
			@echo "$(GREEN)Compiled MLX !$(NO_COLOR)"
endif

#Link
$(NAME):	${OBJS} ${OBJ_MAIN} ${ALL_LIBS}
		@echo "$(ORANGE)Linking $(BLUE)$@ ...$(NO_COLOR)"
		@$(CC) $(CFLAGS) $(INCLUDE_FLAGS) -o $@ ${OBJS} ${OBJ_MAIN} ${ALL_LIBS}
		@echo "$(GREEN)$@ created !$(NO_COLOR)"

#clean
clean:		header
		@rm -rf $(OBJS_PATH)
		@echo "$(GREEN)Removed objects !$(NO_COLOR)"

fclean:		header clean
		@rm -f $(NAME)
		@echo "$(GREEN)Removed $(NAME) !$(NO_COLOR)"

fcleanlib:	header fclean
ifeq ($(IS_LIBFT),true)
		make -C $(LIBFT_DIR) fclean
endif
ifeq ($(IS_MLX),true)
		make -C $(MLX_DIR) fclean
endif

re:			header fclean all

relib:		header fcleanlib all

#test
run:		header all
		@echo "$(BLUE)Executing...$(NO_COLOR)"
		@echo ""
		@./$(NAME)

noflag:
		@echo -n ""
debug:
		@echo -n ""
sanadd:
		@echo -n ""
santhread:
		@echo -n ""
		
.PHONY:		all header clean fclean re run fcleanlib relib noflag debug sanadd santhread