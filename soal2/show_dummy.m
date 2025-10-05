% NAMA FILE: tampilkanHasil.m
function show_dummy(citra_input, citra_output, judul_operasi)
% Menampilkan citra input, histogram input, citra output, dan histogram
% output dalam satu figure dengan layout 2x2.

figure('Name', ['Hasil: ' judul_operasi], 'NumberTitle', 'off', 'WindowState', 'maximized');

% 1. Citra Masukan
subplot(2, 2, 1);
imshow(citra_input);
title('Citra Masukan');

% 2. Histogram Citra Masukan
subplot(2, 2, 2);
hist_dummy(citra_input);
title('Histogram Citra Masukan');

% 3. Citra Luaran
subplot(2, 2, 3);
imshow(citra_output);
title(['Citra Luaran: ' judul_operasi]);

% 4. Histogram Citra Luaran
subplot(2, 2, 4);
hist_dummy(citra_output);
title('Histogram Citra Luaran');

end