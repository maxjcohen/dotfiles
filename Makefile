cleanflag =
simulateflag =

install:
	cd .. && stow -v --adopt --ignore='.git' --ignore='Makefile' --ignore='README.md' --ignore='.gitignore' --ignore='.gitmodules' -t $(HOME) $(cleanflag) dotfiles $(simulateflag)

clean: cleanflag += -D
clean: install

simulate: simulateflag += --simulate
simulate: install
