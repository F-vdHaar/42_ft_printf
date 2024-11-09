/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_print_flag.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fvon-der <fvon-der@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/10/22 11:05:18 by fvon-de           #+#    #+#             */
/*   Updated: 2024/10/28 19:25:41 by fvon-der         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_printf.h"

int	ft_pad_width(int total_width, int size, int zero)
{
	int	count;
	int	add;

	add = 0;
	count = 0;
	while (total_width - size > 0)
	{
		if (zero)
			add = ft_print_c('0');
		else
			add = ft_print_c(' ');
		if (add < 0)
			return (-1);
		count += add;
		total_width--;
	}
	return (count);
}
