#This file is part of rpn-calc:$
# Reverse Polish notation (RPN) calculator written in C++ using flex and bison. $
# Copyright (C) 2013 nikagra <nikagra@gmail.com>$
#
# This program is free software: you can redistribute it and/or modify$
# it under the terms of the GNU General Public License as published by$
# the Free Software Foundation, either version 3 of the License, or$
# (at your option) any later version.$
#
# This program is distributed in the hope that it will be useful,$
# but WITHOUT ANY WARRANTY; without even the implied warranty of$
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the$
# GNU General Public License for more details.$
#
# You should have received a copy of the GNU General Public License$
# along with this program. If not, see <http://www.gnu.org/licenses/>.

CC=g++
CFLAGS=-Wall
LDFLAGS=-lfl
SRCS=main.cpp tokens.cpp boolcalc.cpp
OBJS=$(SRCS:.cpp=.o)
LEX=flex
SYN=bison
PROGRAM=rpn-calc
TESTS=test.txt

all: $(PROGRAM)

$(PROGRAM): $(OBJS)
	$(CC) $^ -o $@ $(LDFLAGS)

.cpp.o:
	$(CC) $(CFLAGS) -c -o $@ $<

tokens.cpp: tokens.l boolcalc.cpp
	$(LEX) -o $@ $<

boolcalc.cpp: boolcalc.y global.h
	$(SYN) -d -o $@ $<

test: $(PROGRAM)
	./$(PROGRAM) $(TESTS)

clean:
	-rm *.o $(PROGRAM) boolcalc.cpp tokens.cpp boolcalc.hpp
