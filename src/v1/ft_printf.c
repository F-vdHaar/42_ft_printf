/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_printf.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fvon-de <fvon-der@student.42heilbronn.d    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/10/22 10:48:08 by fvon-de           #+#    #+#             */
/*   Updated: 2024/10/22 21:09:17 by fvon-de          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../include/ft_printf.h"

static int	ft_parse_flags(const char *s, int i, va_list a, t_flags *f);
static int	ft_parse(char *str, va_list args);

int	ft_printf(const char *format, ...)
{
	va_list		args;
	int			count;
	char		*str;

	if (!format || *format == '\0')
		return (0);
	str = ft_strdup(format);
	if (!str || *str == '\0')
		return (0);
	count = 0;
	va_start(args, format);
	count = ft_parse(str, args);
	va_end(args);
	free(str);
	return (count);
}

static int	ft_parse_flags(const char *str, int i, va_list args, t_flags *flags)
{
	while (str[++i] && ft_isflag(str[i]))
	{
		if (str[i] == '#')
			flags->hash = 1;
		if (str[i] == ' ')
			flags->space = 1;
		if (str[i] == '+')
			flags->plus = 1;
		if (str[i] == '0' && flags->left == 0 && flags->width == 0)
			flags->zero = 1;
		if (str[i] == '-')
			*flags = ft_flag_left(*flags);
		if (str[i] == '.')
			i = ft_flag_precision(str, i, args, flags);
		if (str[i] == '*')
			*flags = ft_flag_width(args, *flags);
		if (ft_isdigit(str[i]))
			*flags = ft_flag_digit(str[i], *flags);
		if (ft_istype(str[i]))
		{
			flags->spec = str[i];
			break ;
		}
	}
	return (i);
}

static int	ft_parse(char *str, va_list args)
{
	int		i;
	int		count;
	t_flags	flags;

	i = -1;
	count = 0;
	while (str[++i])
	{
		flags = ft_flags_init();
		if (str[i] == '%' && str[i + 1] != '\0')
		{
			i = ft_parse_flags(str, i, args, &flags);
			if (str[i] != '\0' && flags.spec > 0 && ft_istype(str[i]))
				count += ft_print_arg(str[i], args, flags);
		}
		else
			count += ft_print_c(str[i]);
	}
	return (count);
}

int	ft_print_arg(char type, va_list args, t_flags flags)
{
	int	count;

	count = 0;
	if (type == '%')
		count += ft_print_char('%', flags);
	else if (type == 'c')
		count += ft_print_char(va_arg(args, int), flags);
	else if (type == 's')
		count += ft_print_str(va_arg(args, const char *), flags);
	else if (type == 'd' || type == 'i')
		count += ft_print_number(va_arg(args, int), flags);
	else if (type == 'x')
		count += ft_print_hex_low(va_arg(args, unsigned int), flags);
	else if (type == 'X')
		count += ft_print_hex_up(va_arg(args, unsigned int), flags);
	else if (type == 'u')
		count += ft_print_unsigned(va_arg(args, unsigned int), flags);
	else if (type == 'p')
		count += ft_print_ptr((unsigned long int)va_arg(args, void *), flags);
	return (count);
}
