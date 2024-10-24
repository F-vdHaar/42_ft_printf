/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   printf_tests.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fvon-de <fvon-der@student.42heilbronn.d    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/10/24 15:03:37 by fvon-de           #+#    #+#             */
/*   Updated: 2024/10/24 15:04:21 by fvon-de          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>
#include "../include/ft_printf.h"  // Include your library header if necessary

void run_tests() {
    // Test cases
    printf("Running Tests...\n");

    // Test 1: Simple string
    printf("Test 1: Simple String\n");
    ft_printf("Hello, World!\n");

    // Test 2: Integer
    printf("Test 2: Integer\n");
    ft_printf("Integer: %d\n", 42);

    // Test 3: Unsigned Integer
    printf("Test 3: Unsigned Integer\n");
    ft_printf("Unsigned Integer: %u\n", 42u);

    // Test 4: Hexadecimal
    printf("Test 4: Hexadecimal\n");
    ft_printf("Hexadecimal: %x\n", 255);

    // Test 5: Pointer
    int value = 42;
    printf("Test 5: Pointer\n");
    ft_printf("Pointer: %p\n", (void*)&value);

    // Test 6: String
    printf("Test 6: String\n");
    ft_printf("String: %s\n", "Hello, ft_printf!");

    // Test 7: Multiple format specifiers
    printf("Test 7: Multiple Format Specifiers\n");
    ft_printf("Mixed: %d, %s, %x\n", 42, "Test", 255);

    // Test 8: Edge Cases
    printf("Test 8: Edge Cases\n");
    ft_printf("Empty string: '%s'\n", "");
    ft_printf("NULL pointer: %s\n", NULL);
}

int main() {
    run_tests();
    return 0;
}