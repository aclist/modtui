TOOL = modtui
LOCAL = /usr/local
BIN_DEST = ${LOCAL}/bin/${TOOL}
LIB_DEST = ${LOCAL}/lib/${TOOL}

def:
	@echo 'usage: make {install|uninstall}'
install:
	chmod +x ${TOOL}
	chmod +x lib/*
	sudo cp ${TOOL} ${BIN_DEST}
	sudo mkdir -p ${LIB_DEST}
	sudo cp lib/* ${LIB_DEST}
ifeq (${XDG_STATE_HOME},)
	mkdir -p ${HOME}/.local/state/${TOOL}
else
	mkdir -p ${XDG_STATE_HOME}/${TOOL}
endif
ifeq (${XDG_CACHE_HOME},)
	mkdir -p ${HOME}/.cache/${TOOL}
else
	mkdir -p ${XDG_CACHE_HOME}/${TOOL}
endif
uninstall:
	sudo rm ${BIN_DEST}
	sudo rm -rf ${LIB_DEST}
	@echo Uninstall finished.
