/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rsetoue <rsetoue@student.42sp.org.br>      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/09/02 21:31:57 by rsetoue           #+#    #+#             */
/*   Updated: 2021/12/03 22:33:37 by rsetoue          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <get_next_line_bonus.h>

static t_list	*ft_get_list(int fd, char **leftover)
{
	t_list	*head;
	t_list	*node;

	head = NULL;
	node = ft_get_node(fd, &head, &(*leftover));
	if (!node)
		return (NULL);
	head = node;
	while (node->read_return > 0)
	{
		while (node->buffer[node->counter])
		{
			head->full_len++;
			if (node->buffer[node->counter] == '\n' && !head->line_len)
				head->line_len = head->full_len;
			node->counter++;
		}
		if (head->line_len)
			break ;
		node->next = ft_get_node(fd, &node, &(*leftover));
		if (!node->next)
			return (NULL);
		node = node->next;
	}
	return (head);
}

static char	*ft_make_line(t_list **head, char **leftover)
{
	int		left_len;
	char	*line;

	if (!*head)
		return (NULL);
	if (!(*head)->line_len && (*head)->full_len)
		(*head)->line_len = (*head)->full_len;
	else if (!(*head)->line_len && !(*head)->full_len)
		return (NULL);
	line = (char *)ft_calloc((*head)->line_len + 1, sizeof(char));
	if (!line)
		return (NULL);
	left_len = (*head)->full_len - (*head)->line_len;
	if (left_len)
	{
		*leftover = (char *)ft_calloc(left_len + 1, sizeof(char));
		if (!*leftover)
			return (NULL);
	}
	line = ft_get_line(&line, &(*head), &(*leftover));
	if (!line)
		return (NULL);
	return (line);
}

char	*get_next_line(int fd)
{
	static char	*leftover = NULL;
	char		*line;
	t_list		*head;

	if (fd < 0 || BUFFER_SIZE <= 0)
		return (NULL);
	head = ft_get_list(fd, &leftover);
	if (!head)
		return (NULL);
	if (leftover)
	{
		free(leftover);
		leftover = NULL;
	}
	line = ft_make_line(&head, &leftover);
	return (line);
}
