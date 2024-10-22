# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fvon-de <fvon-der@student.42heilbronn.d    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/22 10:41:34 by fvon-de           #+#    #+#              #
#    Updated: 2024/10/22 13:22:23 by fvon-de          ###   ########.fr        #
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
SRC_FILES = \
    ft_flags.c \
    ft_print_char.c \
    ft_print_flag.c \
    ft_print_hex.c \
    ft_print_str.c \
    ft_flags_utils.c \
    ft_printf.c \
    ft_printf_utoa.c \
    ft_print_int.c \
    ft_print_unsigned.c \
    ft_nbr_len.c \
    ft_printf_itoa.c \
    ft_printf_xtoa.c \
    ft_print_ptr.c

# Define object files manually
OBJS = $(OBJ_DIR)/ft_flags.o \
       $(OBJ_DIR)/ft_print_char.o \
       $(OBJ_DIR)/ft_print_flag.o \
       $(OBJ_DIR)/ft_print_hex.o \
       $(OBJ_DIR)/ft_print_str.o \
       $(OBJ_DIR)/ft_flags_utils.o \
       $(OBJ_DIR)/ft_printf.o \
       $(OBJ_DIR)/ft_printf_utoa.o \
       $(OBJ_DIR)/ft_print_int.o \
       $(OBJ_DIR)/ft_print_unsigned.o \
       $(OBJ_DIR)/ft_nbr_len.o \
       $(OBJ_DIR)/ft_printf_itoa.o \
       $(OBJ_DIR)/ft_printf_xtoa.o \
       $(OBJ_DIR)/ft_print_ptr.o

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

# Rule for building normal object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule for building debug object files
$(OBJ_DIR)/debug_%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(DEBUG_CFLAGS) -c $< -o $@

# Make LIBFT
$(LIBFT)/libft.a:
	@$(MAKE) -C $(LIBFT)

# bonus target
# TODO Implmente bonus.
bonus: all

# Clean object files
clean:
	@echo "$(BLUE)Cleaning object files in $(OBJ_DIR)...$(RESET_COLOR)"
	@rm -rf $(OBJ_DIR) $(NAME)_debug.a
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

# Debug build target
debug: $(DEBUG_OBJS)
	@echo "$(YELLOW)Creating debug library $(NAME)_debug.a...$(RESET_COLOR)"
	@$(AR) rcs $(NAME)_debug.a $(DEBUG_OBJS)
	@echo "$(GREEN)Debug library $(NAME)_debug.a created!$(RESET_COLOR)"

# Version targets for different builds
v1: 
	@$(MAKE) VERSION=v1

# v2: 
# 	@$(MAKE) VERSION=v2

# v3: 
# 	@$(MAKE) VERSION=v3

.PHONY: all clean fclean re norm debug bonus v1 # v2 v3
