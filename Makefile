start: compile

compile:
	cl65 main.s --verbose --target nes -o main.nes
	fceux main.nes

clean: remove compile

remove:
	rm main.nes