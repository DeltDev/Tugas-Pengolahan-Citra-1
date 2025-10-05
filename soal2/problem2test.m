clear;
clc;
close all;


try
    
    citra_masukan = imread("D:\vrain\Tugas-Pengolahan-Citra-1\soal2\img\acdeimg\img7.jpg"); 
catch
    disp("Gagal memuat citra 'pout.tif'. Pastikan Image Processing Toolbox terinstal.");
    disp("Silakan ganti dengan path citra Anda, contoh: citra_masukan = imread('C:\gambar\uji.jpg');");
    return;
end

% a = 3;
% b = 90; % Nilai positif mencerahkan, negatif menggelapkan
% [citra_hasil1, citra_hasil2] = brighten(citra_masukan, a, b);
% judul1 = sprintf('Brightening (s=r+%g)', b);
% judul2 = sprintf('BRightening (s=%gr+%g)', a,b);
% show_dummy(citra_masukan, citra_hasil1, judul1);
% show_dummy(citra_masukan, citra_hasil2, judul2);

% --- UJI COBA 2: IMAGE BRIGHTENING (s = ar + b) ---
% a = 1.5; % a > 1 meningkatkan kontras
% b = -50;
% citra_hasil = fungsi_brightening(citra_masukan, a, b);
% judul = sprintf('Brightening (s=%gr+%g)', a, b);
% show_dummy(citra_masukan, citra_hasil, judul);


% --- UJI COBA 3: CITRA NEGATIF & BALIKANNYA ---
% disp('Membuat citra negatif...');
% citra_negatif = negative(citra_masukan);
% judul = 'Citra Negatif';
% show_dummy(citra_masukan, citra_negatif, judul);
% % 
% disp('Mengembalikan citra negatif ke citra asli...');
% citra_original = negative(citra_negatif);
% judul_balik = 'Balikan Citra Negatif';
% show_dummy(citra_negatif, citra_original, judul_balik);


%--- UJI COBA 4: TRANSFORMASI LOG ---
% c = 90; % Sesuaikan nilai c untuk mendapatkan kecerahan yang pas
% citra_hasil1 = logTransform(citra_masukan, c);
% judul = sprintf('Transformasi Log (c=%g)', c);
% show_dummy(citra_masukan, citra_hasil1, judul);
% judul2 = sprintf('Transformasi Log (c=%g) 2', c);
% show_dummy(citra_masukan, citra_hasil2, judul);

% --- UJI COBA 5: TRANSFORMASI PANGKAT (GAMMA) ---
c = 2;
gamma = 0.8; % gamma < 1 mencerahkan detail gelap. Coba juga 1.5 untuk menggelapkan.
citra_hasil = powerTransform(citra_masukan, c, gamma);
judul = sprintf('Transformasi Pangkat (c=%g, gamma=%g)', c, gamma);
show_dummy(citra_masukan, citra_hasil, judul);


% --- UJI COBA 6: PEREGANGAN KONTRAS ---
% citra_hasil = fungsi_peregangan_kontras(citra_masukan);
% judul = 'Peregangan Kontras Otomatis';
% show_dummy(citra_masukan, citra_hasil, judul);