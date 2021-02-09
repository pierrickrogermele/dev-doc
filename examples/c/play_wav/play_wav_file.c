// vi: fdm=marker

#include <SDL2/SDL.h>
#include <string.h>
#include <stdbool.h>

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

	// Read argument
	if (argc < 2) {
		fprintf(stderr, "You must pass a WAV file to play.\n");
		return 1;
	}
	char *wav_file = (char*)malloc(strlen(argv[1]) + 1);
	strcpy(wav_file, argv[1]);

	// Initialize SDL
	if (SDL_Init(SDL_INIT_AUDIO) < 0) {
		fprintf(stderr, "Failure while initializing SDL.\n");
		return 2;
	}

	// Load WAV data
	Uint32 wav_length;
	Uint8 *wav_buffer;
	SDL_AudioSpec wav_spec;

	// Load WAV file
	if (SDL_LoadWAV(wav_file, &wav_spec, &wav_buffer, &wav_length) == NULL) {
		fprintf(stderr, "Failure while opening WAV file: %s.\n", SDL_GetError());
		return 3;
	}

	/* Open audio device and set callback */
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

	/* wait until we're done playing */
	while (userdata.audio_len > 0)
		SDL_Delay(100); 

	/* Deallocate resources */
	SDL_CloseAudio();
	SDL_FreeWAV(wav_buffer);
	free(wav_file);

	return 0;
}
