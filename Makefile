start: compile

compile:
	cl65 src/main.s -Oi --verbose -Iassets/ --target nes -o main.nes
	fceux main.nes

clean: remove compile

remove:
	rm src/main.o
	rm main.nes