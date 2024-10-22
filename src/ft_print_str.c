/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_print_str.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fvon-der <fvon-der@student.42heilbronn.    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/27 12:14:00 by fvon-der          #+#    #+#             */
/*   Updated: 2024/07/01 22:08:57 by fvon-der         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../include/ft_printf.h"

static int	ft_print_string(const char *str, t_flags flags)
{
	int	count;

	count = 0;
	if (flags.precision >= 0)
	{
		count += ft_pad_width(flags.precision, ft_strlen(str), 0);
		count += ft_print_s_pre(str, flags.precision);
	}
	else
		count += ft_print_s_pre(str, ft_strlen(str));
	return (count);
}

int	ft_print_str(const char *str, t_flags flags)
{
	int	count;

	count = 0;
	if (str == NULL)
		str = "(null)";
	if (flags.precision >= 0 && (size_t)flags.precision > ft_strlen(str))
		flags.precision = ft_strlen(str);
	if (flags.left == 1)
		count += ft_print_string(str, flags);
	if (flags.precision >= 0)
		count += ft_pad_width(flags.width, flags.precision, 0);
	else
		count += ft_pad_width(flags.width, ft_strlen(str), 0);
	if (flags.left == 0)
		count += ft_print_string(str, flags);
	return (count);
}

int	ft_print_s_pre(const char *str, int precision)
{
	int	count;

	count = 0;
	while (str[count] && count < precision)
		write(1, &str[count++], 1);
	return (count);
}

int	ft_print_s(const char *str)
{
	int	len;

	if (str == NULL)
	{
		write(1, "(null)", 6);
		return (6);
	}
	len = 0;
	while (str[len])
		len++;
	write(1, str, len);
	return (len);
}
