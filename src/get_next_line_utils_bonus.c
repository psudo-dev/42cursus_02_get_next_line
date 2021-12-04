/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line_utils_bonus.c                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rsetoue <rsetoue@student.42sp.org.br>      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/09/05 19:42:07 by rsetoue           #+#    #+#             */
/*   Updated: 2021/12/03 22:33:16 by rsetoue          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <get_next_line_bonus.h>

void	*ft_calloc(size_t n_elem, size_t type_size)
{
	void	*ptr;
	size_t	i;

	ptr = malloc(n_elem * type_size);
	if (!ptr)
		return (NULL);
	i = 0;
	while (i < n_elem * type_size)
	{
		((unsigned char *)ptr)[i] = 0;
		i++;
	}
	return (ptr);
}

t_list	*ft_new_node(void)
{
	t_list	*list;
	char	*buffer;

	list = (t_list *) malloc(sizeof(t_list));
	if (!list)
		return (NULL);
	buffer = (char *) ft_calloc(BUFFER_SIZE + 1, sizeof(char));
	if (!buffer && list)
	{
		free(list);
		return (NULL);
	}
	else if (!buffer)
		return (NULL);
	list->buffer = buffer;
	list->counter = 0;
	list->read_return = 0;
	list->full_len = 0;
	list->line_len = 0;
	list->next = NULL;
	return (list);
}

t_list	*ft_clear_node(t_list **head)
{
	t_list	*swap;

	if (!*head)
		return (NULL);
	swap = (*head)->next;
	if ((*head)->buffer)
		free((*head)->buffer);
	(*head)->buffer = NULL;
	free(*head);
	*head = swap;
	if (!*head)
		return (NULL);
	return (*head);
}

t_list	*ft_get_node(int fd, t_list **node, char **leftover)
{
	t_list	*new_node;

	new_node = ft_new_node();
	if (!new_node)
		return (NULL);
	if (*leftover && !*node)
	{
		if (new_node->buffer)
			free(new_node->buffer);
		new_node->buffer = *leftover;
		*leftover = NULL;
		while ((new_node->buffer)[new_node->read_return])
			new_node->read_return++;
	}
	else
		new_node->read_return = read(fd, new_node->buffer, BUFFER_SIZE);
	if (new_node->read_return < 0
		|| (new_node->read_return == 0 && *node == NULL))
	{
		new_node = ft_clear_node(&new_node);
		return (NULL);
	}
	return (new_node);
}

char	*ft_get_line(char **line, t_list **head, char **leftover)
{
	int		i;
	int		i1;
	int		i2;
	int		line_len;

	if (!*head)
		return (NULL);
	i1 = 0;
	i2 = 0;
	line_len = ((*head)->line_len);
	while (*head)
	{
		i = 0;
		while ((*head)->buffer[i])
		{
			if (i1 < line_len)
				(*line)[i1++] = (*head)->buffer[i++];
			else
				(*leftover)[i2++] = (*head)->buffer[i++];
		}
		(*head) = ft_clear_node(&(*head));
	}
	return (*line);
}
