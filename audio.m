% Read the WAV file
% Replace input.wav with the name of your audio file 
% Make sure to upload the .wav file to same folder as the this audio.m file 
[y, fs] = audioread('input.wav');

% Convert audio data to integer values
y_int = int32(y * (2^31 - 1));

% Write C array to a text file
fid = fopen('output.txt', 'w');
fprintf(fid, '#include <stdint.h>\n\n');
fprintf(fid, 'const int32_t audio_data[] = {\n');
fprintf(fid, '    %d', y_int(1));
for i = 2:length(y_int)
    if mod(i-1, 10) == 0
        fprintf(fid, ',\n    %d', y_int(i));
    else
        fprintf(fid, ', %d', y_int(i));
    end
end
fprintf(fid, '\n};\n');
fprintf(fid, 'const int audio_data_size = %d;\n', length(y_int));
fclose(fid);
