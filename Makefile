# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dhubleur <dhubleur@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/12/08 10:05:58 by dhubleur          #+#    #+#              #
#    Updated: 2022/01/16 15:01:27 by dhubleur         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

################################################################################
#									Utils									   #
################################################################################

NAME		= 	philo

CC			= 	gcc
CFLAGS		=	-Wall -Wextra -Werror
#CFLAGS		+=	-g3
#CFLAGS		+=	-fsanitize=address
#CFLAGS		+=	-fsanitize=thread

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

INCLUDE_FLAGS = $(addprefix -I , ${INCLUDE_DIRS})

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

#Link
$(NAME):	${OBJS} ${OBJ_MAIN}
		@echo ""
		@echo "$(ORANGE)Linking $(BLUE)$@ ...$(NO_COLOR)"
		@$(CC) $(CFLAGS) $(INCLUDE_FLAGS) -o $@ ${OBJS} ${OBJ_MAIN}
		@echo "$(GREEN)$@ created !$(NO_COLOR)"

#clean
clean:		header
		@rm -rf $(OBJS_PATH)
		@echo "$(GREEN)Removed objects !$(NO_COLOR)"

fclean:		header clean
		@rm -f $(NAME)
		@echo "$(GREEN)Removed $(NAME) !$(NO_COLOR)"

re:			header fclean all

#test
run:		header all
		@echo "$(BLUE)Executing...$(NO_COLOR)"
		@echo ""
		@./$(NAME)
		
.PHONY:		all header clean fclean re run