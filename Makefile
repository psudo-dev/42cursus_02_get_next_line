# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rsetoue <rsetoue@student.42sp.org.br>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/08/19 20:40:41 by rsetoue           #+#    #+#              #
#    Updated: 2021/11/23 03:29:25 by rsetoue          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME :=				get_next_line.a

BIN_DIR :=			bin
SRC_DIR :=			src
OBJ_DIR :=			build
INC_DIR :=			inc
ALL_DIR :=			${BIN_DIR} \
					${SRC_DIR} \
					${OBJ_DIR} \
					${INC_DIR}

SRC_FILES =			get_next_line.c \
					get_next_line_utils.c
SRC :=				${addprefix ${SRC_DIR}/,${SRC_FILES}}
OBJ :=				${addprefix ${OBJ_DIR}/,${SRC_FILES:.c=.o}}
GNL_H =				${INC_DIR}/get_next_line.h

BONUS :=			${BIN_DIR}/bonus.a
BONUS_FILES =		get_next_line_bonus.c \
					get_next_line_utils_bonus.c
SRC_BONUS :=		${addprefix ${SRC_DIR}/,${BONUS_FILES}}
OBJ_BONUS :=		${addprefix ${OBJ_DIR}/,${BONUS_FILES:.c=.o}}
GNL_BONUS_H =		${INC_DIR}/get_next_line_bonus.h

CC =				@clang
CFLAGS =			-Wall -Wextra -Werror
AR =				@ar -rc
RANLIB =			@ranlib
RM =				@rm -f
MSG =				@echo

# < RECIPES
${NAME}: ${ALL_DIR} ${OBJ}
	${MSG} ${FG_YELLOW} "Compiling Mandatory..." ${RESET} ${NO_NL}
	${AR} ${NAME} ${OBJ}
	${DONE}
	${MSG_INDEX_LIB}
	${RANLIB} ${NAME}
	${DONE}
	${MSG_FINISHED}

${OBJ_DIR}/%.o: ${SRC_DIR}/%.c ${GNL_H} ${GNL_BONUS_H}
	${CC} ${CFLAGS} -I${INC_DIR} -c $< -o $@

${BONUS}: ${ALL_DIR} ${OBJ_BONUS}
	${MSG} ${FG_YELLOW} "Compiling Bonus..." ${RESET} ${NO_NL}
	${AR} ${BONUS} ${OBJ_BONUS}
	${DONE}
	${MSG_INDEX_LIB}
	${RANLIB} ${BONUS}
	${DONE}
	@cp ${BONUS} ${NAME}
	${MSG_FINISHED}
bonus: ${BONUS}

all: ${NAME}

${ALL_DIR}:
	@mkdir -p ${ALL_DIR}

clean: clean_build
	${MSG_FINISHED}

fclean: clean_build clean_program
	${MSG_FINISHED}

re: msg_rebuilding clean_build clean_program all

.PHONY: all clean fclean re

# : CLEANING
clean_build: msg_cleaning
	${RM} ${OBJ} ${OBJ_BONUS}
	${DONE}

clean_program: msg_fcleaning
	${RM} ${NAME} ${BONUS}
	${DONE}

# ~ MESSAGES
FG_GREEN :=			"\033[38;2;73;242;73m"
FG_BLUE :=			"\033[38;2;80;182;255m"
FG_YELLOW :=		"\033[38;2;230;230;72m"
FG_GREY :=			"\033[38;2;144;150;160m"
FG_PINK :=			"\033[38;2;255;102;204m"
FG_LAV :=			"\033[38;2;170;128;255m"
FG_ORANGE :=		"\033[38;2;255;167;64m"

MSG :=				@echo
RESET :=			"\033[0m"
NO_NL :=			| tr -d '\n'
DONE :=				${MSG} ${FG_GREEN} "✔" ${RESET}

# : 				"code[
# ~ 				48;2 (background color)
# ~ 				38;2 (foreground color)
# > 				;R;G;B
# < 				m
# ? 				\033[0m" (reset)

MSG_INDEX_LIB =		${MSG} ${FG_GREY} "Indexing ${GNL} library..." \
					${RESET} ${NO_NL}
MSG_BUILD_LIB =		${MSG} ${FG_YELLOW} "Building ${GNL} library..." \
					${RESET} ${NO_NL}
MSG_COMPILING =		${MSG} ${FG_YELLOW} "Compiling ${GNL}..." \
					${RESET} ${NO_NL}
MSG_BUILDING =		${MSG} ${FG_ORANGE} "Building ${GNL} files..." \
					${RESET}
MSG_REBUILDING =	${MSG} ${FG_PINK} "Rebuilding executable..." \
					${RESET}
MSG_CLEANING =		${MSG} ${FG_BLUE} "Cleaning ${GNL} Build..." \
					${RESET} ${NO_NL}
MSG_FCLEANING =		${MSG} ${FG_BLUE} "Cleaning ${GNL} Program..." \
					${RESET} ${NO_NL}
MSG_FINISHED	=	${MSG} ${FG_GREEN} "Finished!" \
					${RESET}

msg_compiling:
	${MSG_COMPILING}
msg_building:
	${MSG_BUILDING}
msg_rebuilding:
	${MSG_REBUILDING}
msg_cleaning:
	${MSG_CLEANING}
msg_fcleaning:
	${MSG_FCLEANING}
msg_create_dir:
	${MSG_CREATE_DIR}
done:
	${DONE}
