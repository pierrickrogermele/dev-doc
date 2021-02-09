#include <stdlib.h>

// WAV sound data
typedef struct wav_sound_data_t wav_sound_data_t;
struct wav_sound_data_t {
	const char* name;
	const char* wav_data;
	size_t      wav_data_length;
};
