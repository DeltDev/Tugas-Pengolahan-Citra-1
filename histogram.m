clc; clear; close all;

% input citra lewat browse file
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg'}, 'Pilih citra');
if isequal(filename,0)
    disp('Tidak ada file dipilih.');
    return;
end

% baca citra
img = imread(fullfile(pathname, filename));

% tampilkan citra
figure;
imshow(img);
title('Citra Asli');