# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rsetoue <rsetoue@student.42sp.org.br>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/08/19 20:40:41 by rsetoue           #+#    #+#              #
#    Updated: 2021/12/03 22:25:30 by rsetoue          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME :=				get_next_line.a

BIN_DIR :=			bin
SRC_DIR :=			src
OBJ_DIR :=			build
INC_DIR :=			inc
TEST_DIR :=			test
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
RM_FILE :=			@rm -f
RM_FOLDER :=		@rm -rf
MSG =				@echo

# < RECIPES
${NAME}: ${ALL_DIR} ${OBJ}
	${MSG} ${FG_YELLOW} "Compiling Mandatory..." ${RESET} ${NO_NL}
	${AR} ${NAME} ${OBJ}
	${DONE}
	${MSG_INDEX_LIB}
	${RANLIB} ${NAME}
	${DONE}
	@cp ${NAME} ${BIN_DIR}
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
	@cp -p ${NAME} ${BIN_DIR}
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

norm:
	${MSG} ${FG_LAV} "running norminette" ${RESET}
	@norminette -R CheckForbiddenSourceHeader
	${MSG_FINISHED}
	${MSG}
	${MSG}
	${MSG}

.PHONY: all clean fclean re

# : CLEANING
clean_build: msg_cleaning
	${RM_FILE} build/*.o
	${DONE}

clean_program: msg_fcleaning
	${RM_FILE} ${NAME} ${BIN_DIR}/*.a
	${DONE}

# ? TESTS

TRIPOUILLE_DIR :=	${TEST_DIR}/tripouille

${TRIPOUILLE_DIR}:
	@git clone \
	https://github.com/Tripouille/gnlTester.git \
	${TRIPOUILLE_DIR}
	${MSG_FINISHED}

test: norm ${TRIPOUILLE_DIR}
	@cp ${INC_DIR}/*.h ${TEST_DIR}
	@cp ${SRC_DIR}/*.c ${TEST_DIR}
t: test

mandatory_tests: test ${TRIPOUILLE_DIR}
	${MSG} ${FG_LAV} "running tripouille tests: MANDATORY" ${RESET}
	${MAKE} m -C ${TRIPOUILLE_DIR}
m: mandatory_tests

bonus_tests: test ${TRIPOUILLE_DIR}
	${MSG} ${FG_LAV} "running tripouille tests: BONUS" ${RESET}
	${MAKE} b -C ${TRIPOUILLE_DIR}
b: bonus_tests

all_tests: test ${TRIPOUILLE_DIR}
	${MSG} ${FG_LAV} "running tripouille tests: ALL" ${RESET}
	${MAKE} a -C ${TRIPOUILLE_DIR}
a: all_tests

clean_test:
	${MSG} ${FG_PINK} "make clean_test tests" ${RESET}
	${RM_FILE} ${TEST_DIR}/*.o
c: clean_test

fclean_test: clean_test
	${MSG} ${FG_PINK} "make fclean_test tests" ${RESET}
	${RM_FILE} ${TEST_DIR}/*.*
f: fclean_test

rebuild_test: fclean_test test
	${MSG} ${FG_PINK} "make rebuild_test tests" ${RESET}
	${MSG_FINISHED}
r: rebuild_test

delete_test: fclean_test
	${MSG} ${FG_PINK} "Removing ${TRIPOUILLE_DIR} Folder" ${RESET}
	${RM_FOLDER} ${TRIPOUILLE_DIR}
	${MSG_FINISHED}
d: delete_test

exit: fclean delete_test
e: exit

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
