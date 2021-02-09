// vi: fdm=marker

#include <SDL2/SDL.h>
#include <unistd.h> // for getopt()
#include <stdlib.h> // for strtol()
#include <string.h>
#include <stdbool.h>
#include "play_embedded_wav.h"

#define DEFAULT_SOUND_INDEX 0

extern const wav_sound_data_t sound_data[];
extern const size_t sound_data_length;

typedef struct my_user_data my_user_data;
struct my_user_data {
	Uint8 *audio_pos; // global pointer to the audio buffer to be played
	Uint32 audio_len; // remaining length of the sample we have to play
};

// Audio callback {{{1
////////////////////////////////////////////////////////////////

void my_audio_callback(void *userdata, Uint8 *stream, int len) {

	if (((my_user_data*)userdata)->audio_len ==0)
		return;

	len = ( len > ((my_user_data*)userdata)->audio_len ? ((my_user_data*)userdata)->audio_len : len );

	SDL_memcpy (stream, ((my_user_data*)userdata)->audio_pos, len);

	((my_user_data*)userdata)->audio_pos += len;
	((my_user_data*)userdata)->audio_len -= len;
}

// Main {{{1
////////////////////////////////////////////////////////////////

int main(int argc, char* argv[]) {

	// Read arguments
	int sound_index = DEFAULT_SOUND_INDEX;

	// Initialize SDL.
	if (SDL_Init(SDL_INIT_AUDIO) < 0) {
		fprintf(stderr, "Failure while initializing SDL.\n");
		return 1;
	}

	// Load WAV data
	Uint32 wav_length;
	Uint8 *wav_buffer;
	SDL_AudioSpec wav_spec;
	SDL_RWops *rwops = SDL_RWFromConstMem(sound_data[sound_index].wav_data, sound_data[sound_index].wav_data_length);
	if ( ! rwops) {
		fprintf(stderr, "Failure while opening WAV const data %s, index %d: %s.\n", sound_data[sound_index].name, sound_index, SDL_GetError());
		return 2;
	}
	if ( ! SDL_LoadWAV_RW(rwops, 1, &wav_spec, &wav_buffer, &wav_length)) {
		fprintf(stderr, "Failure while loading WAV const data %s, index %d: %s.\n", sound_data[sound_index].name, sound_index, SDL_GetError());
		return 3;
	}

	// Open audio device and set callback
	my_user_data userdata;
	userdata.audio_pos = wav_buffer; // copy sound buffer
	userdata.audio_len = wav_length; // copy file length
	wav_spec.callback = my_audio_callback;
	wav_spec.userdata = (void*)&userdata;
	if (SDL_OpenAudio(&wav_spec, NULL) < 0) {
		fprintf(stderr, "Couldn't open audio: %s.\n", SDL_GetError());
		return 4;
	}
	
	/* Start playing */
	SDL_PauseAudio(0);

	// wait until we're done playing
	while (userdata.audio_len > 0)
		SDL_Delay(100); 

	// Deallocate resources
	SDL_CloseAudio();
	SDL_FreeWAV(wav_buffer);

	return 0;
}
