% image_histogram - fungsi untuk mengubah matriks gambar menjadi histogram
function counts = image_histogram(img)
    % inisialisasi array counts untuk perhitungan histogram
    counts = zeros(256,1);
    
    % menghitung panjang baris dan kolom dari gambar
    [rows,cols] = size(img);

    %periksa semua piksel dari gambar
    for r = 1:rows
        for c = 1:cols
            %ambil nilai value (0-255) dari piksel pada kolom ke-c dan baris ke-r pada matriks gambar
            %(grayscale,R,G,B)
            value = img(r,c);
            %hitung kemunculan piksel dengan value tersebut
            counts(value+1) = counts(value+1) + 1;
        end
    end
end
clc; clear; close all;

% input citra lewat browse file
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg'}, 'Pilih citra');
%periksa apakah ada gambar yang dipilih
if isequal(filename,0)
    disp('Tidak ada file dipilih.');
    return;
end

% baca citra dan ubah jadi matriks
img = imread(fullfile(pathname, filename));

% tampilkan citra
figure;
imshow(img);
title('Citra Asli');

% cek apakah gambar grayscale atau berwarna

if size(img, 3) == 1
    disp('Citra adalah gambar grayscale.');
    
    % hitung histogram grayscale (hanya sekali)
    counts = image_histogram(img)
    bins = 0:255;

    %tampilkan histogram citra grayscale
    figure;
    bar(bins, counts, 'k');
    title('Histogram Citra Grayscale');
    xlabel('Intensitas (0-255)');
    ylabel('Jumlah Piksel');
else
    disp('Citra adalah gambar berwarna.');
    %pisah matriks gambar RGB yang terdiri atas 3 channel menjadi matriks R, G, dan B
    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);

    % Hitung histogram tiap channel R,G,B (3 kali)
    binsR = 0:255;
    binsG = 0:255;
    binsB = 0:255;
    countR = image_histogram(R);
    countG = image_histogram(G);
    countB = image_histogram(B);
    
    % Tampilkan histogram RGB
    figure;
    bar(binsR, countR, 'r');
    title('Histogram Citra R');
    xlabel('Intensitas (0-255)');
    ylabel('Jumlah Piksel');
    figure;
    bar(binsG, countG, 'g');
    title('Histogram Citra G');
    xlabel('Intensitas (0-255)');
    ylabel('Jumlah Piksel');
    figure;
    bar(binsB, countB, 'b');
    title('Histogram Citra B');
    xlabel('Intensitas (0-255)');
    ylabel('Jumlah Piksel');
end