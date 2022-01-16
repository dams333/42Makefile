# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dhubleur <dhubleur@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/12/08 10:05:58 by dhubleur          #+#    #+#              #
#    Updated: 2022/01/16 22:34:52 by dhubleur         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

################################################################################
#								  Utils										   #
################################################################################

NAME		= 	test
CC			= 	gcc
CFLAGS		=

################################################################################
#								  Sources									   #
################################################################################

SRCS_EXTENSION	=	.c
SRCS_PATH		=	./srcs
MAIN			=	main.c
SRCS			=	

################################################################################
#								  Includes									   #
################################################################################

INCLUDE_EXTENSION	=	.h
INCLUDE_DIRS		=	./includes 
DEPENDS				=	

################################################################################
#								  Libft										   #
################################################################################

IS_LIBFT			=	false

LIBFT_DIR			=	./libft
LIBFT_INCLUDE_DIR	=	./libft
LIBFT_NAME			=	libft.a

################################################################################
#								  MiniLibX									   #
################################################################################

IS_MLX				=	false

MLX_DIR				=	./minilibx-linux
MLX_INCLUDE_DIR		=	./minilibx-linux
MLX_NAME			=	minilibx.a

#               /!\ Do not touch the rest of the file /!\ 

################################################################################
#								  Objects									   #
################################################################################

OBJS_PATH		=	./objs

OBJS			=	$(addprefix $(OBJS_PATH)/, ${SRCS:$(SRCS_EXTENSION)=.o})
OBJ_MAIN		=	$(addprefix $(OBJS_PATH)/, ${MAIN:$(SRCS_EXTENSION)=.o})
OBJS_DEPEND		=	$(addprefix $(OBJS_PATH)/, ${DEPENDS:$(INCLUDE_EXTENSION)=.d})

################################################################################
#								  Constants									   #
################################################################################

BLUE		=	\033[1;34m
CYAN		=	\033[0;36m
GREEN		=	\033[0;32m
ORANGE  	=	\033[0;33m
NO_COLOR	=	\033[m

################################################################################
#								  Makefile									   #
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

ifeq (noflag, $(filter noflag,$(MAKECMDGOALS)))
	CFLAGS	+=	-Wall -Wextra
else
	CFLAGS	+=	-Wall -Wextra -Werror
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
#								  Rules										   #
################################################################################

all:	header message $(NAME)

#beautiful
header:
		@echo -n "${BLUE}"
		@echo "  _  _ ___                    _         __ _ _      "
		@echo " | || |__ \                  | |       / _(_) |     "
		@echo " | || |_ ) |  _ __ ___   __ _| | _____| |_ _| | ___ "
		@echo " |__   _/ /  | '_ \` _ \ / _\` | |/ / _ \  _| | |/ _ \\"
		@echo "    | |/ /_  | | | | | | (_| |   <  __/ | | | |  __/"
		@echo "    |_|____| |_| |_| |_|\__,_|_|\_\___|_| |_|_|\___|"
		@echo "                                         by dhubleur"
		@echo -n "${NO_COLOR}"

message:
		@make -q $(NAME) && echo "$(GREEN)Everything is already up to date ! No work for me$(NO_COLOR)" || true

#Compilation
$(OBJS_PATH)/%.o:	$(SRCS_PATH)/%$(SRCS_EXTENSION)
			@mkdir -p $(dir $@)
			@echo "$(CYAN)Compiling $(BLUE)$@ ...$(NO_COLOR)"
			@$(CC) $(CFLAGS) -MMD -MF $(@:.o=.d)  ${INCLUDE_FLAGS} -c $< -o $@
$(OBJS_PATH)/%.o:	%$(SRCS_EXTENSION)
			@mkdir -p $(dir $@)
			@echo "$(CYAN)Compiling $(BLUE)$@ ...$(NO_COLOR)"
			@$(CC) $(CFLAGS) -MMD -MF $(@:.o=.d)  ${INCLUDE_FLAGS} -c $< -o $@

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
-include $(OBJS_DEPEND)
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

show:		header
		@echo "$(CYAN)Compilator: $(GREEN)$(CC)$(NO_COLOR)"
		@echo "$(CYAN)Flags: $(GREEN)$(CFLAGS)$(NO_COLOR)"
		@echo "$(CYAN)Includes: $(GREEN)$(INCLUDE_FLAGS)$(NO_COLOR)"
		@echo ""
		@echo "$(CYAN)Sources:$(NO_COLOR)"
		@echo "$(GREEN)$(MAIN) ${addprefix $(SRCS_PATH)/, $(SRCS)}$(NO_COLOR)"
		@echo ""
		@echo "$(CYAN)Libs:$(NO_COLOR)"
		@echo "$(GREEN)$(ALL_LIBS)$(NO_COLOR)"

#do nothing
noflag: 	all
		@echo -n ""
debug:		all
		@echo -n ""
sanadd:		all
		@echo -n ""
santhread:	all
		@echo -n ""
		
.PHONY:		all header clean fclean re run fcleanlib relib noflag debug sanadd santhread show