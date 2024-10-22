# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fvon-de <fvon-der@student.42heilbronn.d    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/22 10:41:34 by fvon-de           #+#    #+#              #
#    Updated: 2024/10/22 10:42:25 by fvon-de          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Colors for output
RESET_COLOR = \033[0;39m
YELLOW      = \033[0;93m
BLUE        = \033[0;94m
GREEN       = \033[0;92m
RED         = \033[1;31m

# Project settings
NAME        = libftprintf.a
INCLUDE     = include
LIBFT       = ../libft
CC			= cc
CFLAGS 		= -Wall -Wextra -Werror -Wunused -I$(INCLUDE)
DEBUG_FLAGS = -g -O0 -Wall -Wextra -Werror -fsanitize=address -fsanitize=undefined -fno-strict-aliasing -fno-omit-frame-pointer -fstack-protector -DDEBUG -fno-inline
AR          = ar rcs
MAKE        = make

 # Default version if not specified
VERSION ?= v1
SRC_DIR = src/$(VERSION)
OBJ_DIR = obj/$(VERSION)

# Source files
SRCS = $(SRC_DIR)/ft_printf.c \

# Object files
OBJS = $(OBJS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

# Ensure object directory exists
$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# Default rule to build 
all: $(NAME)

#  build rule
$(NAME): $(OBJ_DIR) $(OBJS)
	@echo "$(YELLOW)Creating library $(NAME)...$(RESET_COLOR)"
	@$(AR) $(NAME) $(OBJS) $(LIBFT)/libft.a
	@echo "$(GREEN)$(NAME) creation finished!$(RESET_COLOR)"

# Rule to compile .o files from .c files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Make LIBFT
$(LIBFT)/libft.a:
	@$(MAKE) -C $(LIBFT)

# bonus target
# TODO Implmente bonus.
bonus: all

# Clean object files
clean:
	@echo "$(BLUE)Cleaning object files in $(OBJ_DIR)...$(RESET_COLOR)"
	rm -rf $(OBJ_DIR)
	@echo "$(GREEN)Object files cleaned!$(RESET_COLOR)"

# Clean everything
fclean: clean 
	@echo "$(BLUE)Removing executables...$(RESET_COLOR)"
	@rm -f $(NAME)
	@$(MAKE) fclean -C $(LIBFT)
	@echo "$(GREEN)Executables removed!$(RESET_COLOR)"

# Rebuild everything
re: fclean all

# Norminette target
norm:
	@echo "$(BLUE)Running Norminette...$(RESET_COLOR)"
	norminette $(SRCS)
	@echo "$(GREEN)Norminette check complete!$(RESET_COLOR)"


# Debug target
debug: debug_objs
	@echo "$(YELLOW)Creating debug library $(NAME)_debug.a...$(RESET_COLOR)"
	@$(AR) $(NAME)_debug.a $(OBJS)
	@echo "$(GREEN)Debug library $(NAME)_debug.a created!$(RESET_COLOR)"

debug_objs: $(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(DEBUG_CFLAGS) -c $< -o $@

# Version targets for different builds
v1: 
 	@$(MAKE) VERSION=v1

# v2: 
# 	@$(MAKE) VERSION=v2

# v3: 
# 	@$(MAKE) VERSION=v3

.PHONY: all clean fclean re norm debug  bonus v1 # v2 v3
