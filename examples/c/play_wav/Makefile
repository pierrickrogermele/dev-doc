WAV=$(HOME)/data/sounds/gong.wav
CFLAGS=-g

all: play_wav_file play_embedded_wav

play_wav_file: play_wav_file.o
	$(CC) -lSDL2 -o $@ $^

play_embedded_wav: play_embedded_wav.o wav_data.o
	$(CC) -lSDL2 -o $@ $^

play_embedded_wav.c: play_embedded_wav.h

wav_data.c: $(WAV)
	./generate_wav_data $(WAV) >$@

clean:
	$(RM) play_embedded_wav play_wav_file *.o wav_data.c

.PHONY: all clean
