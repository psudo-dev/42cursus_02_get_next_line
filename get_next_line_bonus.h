/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line_bonus.h                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rsetoue <rsetoue@student.42sp.org.br>      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/08/26 22:11:06 by rsetoue           #+#    #+#             */
/*   Updated: 2021/09/19 15:52:10 by rsetoue          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef GET_NEXT_LINE_BONUS_H
# define GET_NEXT_LINE_BONUS_H

# include <unistd.h>
# include <stdlib.h>

# ifndef BUFFER_SIZE
#  define BUFFER_SIZE 1000
# endif

# ifndef FD_SIZE
#  define FD_SIZE 256
# endif

// ~ list
typedef struct s_list
{
	char			*buffer;
	int				counter;
	int				read_return;
	int				full_len;
	int				line_len;
	struct s_list	*next;
}					t_list;

// < get_next_line
char	*get_next_line(int fd);

// > utilities functions
void	*ft_calloc(size_t n_elem, size_t type_size);
t_list	*ft_new_node(void);
t_list	*ft_clear_node(t_list **head);
t_list	*ft_get_node(int fd, t_list **node, char **leftover);
char	*ft_get_line(char **line, t_list **head, char **leftover);

#endif
