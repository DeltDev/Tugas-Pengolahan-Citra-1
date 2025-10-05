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

% cek apakah gambar grayscale atau berwarna

if size(img, 3) == 1
    disp('Citra adalah gambar grayscale.');
    
    % hitung histogram
    [counts, bins] = imhist(img,256);
    figure;
    bar(bins, counts, 'k');
    title('Histogram Citra Grayscale (menggunakan imhist)');
    xlabel('Intensitas (0-255)');
    ylabel('Jumlah Piksel');
else
    disp('Citra adalah gambar berwarna.');

    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);

    % Hitung histogram tiap channel R,G,B
    [countR, binsR] = imhist(R, 256);
    [countG, binsG]   = imhist(G, 256);
    [countB, binsB]   = imhist(B, 256);
    
    % Tampilkan histogram RGB
    figure;
    bar(binsR, countR, 'r');
    title('Histogram Citra R/Merah (menggunakan imhist)');
    xlabel('Intensitas (0-255)');
    ylabel('Jumlah Piksel');
    figure;
    bar(binsG, countG, 'g');
    title('Histogram Citra G/Hijau (menggunakan imhist)');
    xlabel('Intensitas (0-255)');
    ylabel('Jumlah Piksel');
    figure;
    bar(binsB, countB, 'b');
    title('Histogram Citra B/Biru (menggunakan imhist)');
    xlabel('Intensitas (0-255)');
    ylabel('Jumlah Piksel');
end