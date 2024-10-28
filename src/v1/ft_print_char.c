/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_print_char.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fvon-der <fvon-der@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/10/22 11:10:16 by fvon-de           #+#    #+#             */
/*   Updated: 2024/10/28 19:14:29 by fvon-der         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_printf.h"

int	ft_print_c(char c)
{
	write(1, &c, 1);
	return (1);
}

int	ft_print_char(char c, t_flags flags)
{
	int	count;
	int	add;

	add = 0;
	count = 0;
	if (flags.left == 1)
		add = ft_print_c(c);
	count += add;
	if (add < 0)
		return (-1);
	add = ft_pad_width(flags.width, 1, flags.zero);
	if (add < 0)
		return (-1);
	count += add;
	if (flags.left == 0)
	{
		add = ft_print_c(c);
		count += add;
		if (add < 0)
			return (-1);
	}
	return (count);
}
