cleanflag =
simulateflag =

install:
	cd .. && stow -v --adopt --ignore='.git' --ignore='Makefile' -t $(HOME) $(cleanflag) dotfiles $(simulateflag)

clean: cleanflag += -D
clean: install

simulate: simulateflag += --simulate
simulate: install
