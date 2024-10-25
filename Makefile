# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fvon-der <fvon-der@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/22 10:41:34 by fvon-de           #+#    #+#              #
#    Updated: 2024/10/25 19:22:44 by fvon-der         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Colors for output
RESET_COLOR = \033[0;39m
YELLOW		= \033[0;93m
BLUE		= \033[0;94m
GREEN		= \033[0;92m
RED			= \033[1;31m

# Project settings
NAME		= libftprintf.a
INCLUDE		= include
LIBFT_DIR	= lib/libft
CC			= cc
CFLAGS 		= -Wall -Wextra -Werror -Wunused -I$(INCLUDE) -I$(LIBFT_DIR)/$(INCLUDE)
DEBUG_FLAGS = $(CFLAGS) -g -O0 -fsanitize=address -fsanitize=undefined -fno-strict-aliasing -fno-omit-frame-pointer -fstack-protector -DDEBUG -fno-inline
AR			= ar rcs
MAKE		= make
# Linker flags
# lib<library_name>.a 
# -lft -> - lib ft , lib is assumed, so the library name is actually ft?
# this is just necessary for my own tests make test
LDFLAGS = -L$(LIBFT_DIR) -lft

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

# Define object files
OBJS = $(addprefix $(OBJ_DIR)/, $(SRC_FILES:.c=.o))

# Debug object files
DEBUG_OBJS = $(addprefix $(OBJ_DIR)/, $(addprefix debug_, $(SRC_FILES:.c=.o)))

# Default rule to build 
all: $(NAME) $(LIBFT_DIR)/libft.a

# Debug build target
debug: $(DEBUG_OBJS) | $(OBJ_DIR)
	@echo "$(YELLOW)FT_PRINTF : Creating debug library libdebug.a...$(RESET_COLOR)"
	@cp $(LIBFT_DIR)/libft.a libdebug.a
	@$(AR) libdebug.a $(DEBUG_OBJS) $(LIBFT_DIR)/libft.a
	@echo "$(GREEN)Debug library libdebug.a created!$(RESET_COLOR)"

test: $(NAME)
	$(CC) tests/printf_tests.c -o test_program -Ilib/libft/include -L. -lftprintf

# Ensure object directory exists
$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# Ensure libft.a exists
$(LIBFT_DIR)/libft.a:
	@$(MAKE) -C $(LIBFT_DIR)

#  build rule
$(NAME):  $(OBJS) $(LIBFT_DIR)/libft.a  | $(OBJ_DIR)
	@echo "$(YELLOW)FT_PRINTF : Creating library $(NAME)...$(RESET_COLOR)"
	@cp $(LIBFT_DIR)/libft.a $(NAME)
	@$(AR) $(NAME) $(OBJS) $(LIBFT_DIR)/libft.a
	@echo "$(GREEN)$(NAME) creation finished!$(RESET_COLOR)"

# Rule for building normal object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	@echo "$(YELLOW)FT_PRINTF : Compiling object file: $< to $@...$(RESET_COLOR)"
	@$(CC) $(CFLAGS) -c $< -o $@ 

# Rule for building debug object files
$(OBJ_DIR)/debug_%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	@echo "$(YELLOW)FT_PRINTF : Compiling debug object file: $< to $@...$(RESET_COLOR)"
	@$(CC) $(DEBUG_FLAGS) -c $< -o $@

# bonus target
# TODO Implmente bonus.
bonus: all

# Clean object files
clean:
	@echo "$(RED)FT_PRINTF : Cleaning object files in $(OBJ_DIR)...$(RESET_COLOR)"
	@rm -rf $(OBJ_DIR) debug.a

# Clean everything
fclean: clean 
	@echo "$(RED)FT_PRINTF : Removing library...$(RESET_COLOR)"
	@rm -f $(NAME)
	@$(MAKE) fclean -C $(LIBFT_DIR)

# Rebuild everything
re: fclean all

# Norminette target
norm:
	@echo "$(BLUE)FT_PRINTF : Running Norminette...$(RESET_COLOR)"
	@norminette $(SRCS) | grep -v 'OK!' || true
	@echo "$(GREEN)Norminette check complete!$(RESET_COLOR)"


# Version targets for different builds
v1: 
	@$(MAKE) VERSION=v1

# v2: 
# 	@$(MAKE) VERSION=v2

# v3: 
# 	@$(MAKE) VERSION=v3

.PHONY: all clean fclean re norm debug bonus v1 # v2 v3
