% =================================================================
% SCRIPT UTAMA PENGUJIAN SEMUA FUNGSI
% =================================================================
function main_test_all()
    % Membersihkan environment
    close all; 
    clear; 
    clc;

    disp('Membaca gambar sampel...');
    % GANTI NAMA FILE INI DENGAN NAMA GAMBAR MILIKMU
    % Pastikan gambar ini ada di folder yang sama dengan file .m ini
    try
        colorImg = imread('img1.png');
    catch
        disp('File "gambar_berwarna.jpg" tidak ditemukan. Membuat gambar sampel.');
        colorImg = uint8(rand(100, 100, 3) * 255);
    end

    try
        grayImg = rgb2gray(colorImg); % Membuat versi grayscale dari gambar warna
    catch
        disp('Gagal membuat gambar grayscale. Membuat gambar sampel.');
        grayImg = uint8(rand(100, 100) * 255);
    end

    % --- PENGUJIAN FUNGSI 1: HISTOGRAM ---
    disp('Menjalankan Tes 1: main_1_histogram...');
    main_1_histogram(grayImg, colorImg);
    disp('Tes 1 Selesai. Tekan Enter untuk lanjut...');
    pause;

    % --- PENGUJIAN FUNGSI 2A: BRIGHTENER ---
    disp('Menjalankan Tes 2A: brightener...');
    [brightB, brightAB] = pure_brightener(colorImg, 1.5, 50);
    figure('Name', 'Tes 2A: Brightener');
    subplot(1, 3, 1); imshow(colorImg); title('Asli');
    subplot(1, 3, 2); imshow(brightB); title('Hasil (f + 50)');
    subplot(1, 3, 3); imshow(brightAB); title('Hasil (1.5*f + 50)');
    disp('Tes 2A Selesai. Tekan Enter untuk lanjut...');
    pause;

    % --- PENGUJIAN FUNGSI 2B: NEGATIVE ---
    disp('Menjalankan Tes 2B: negative...');
    [negImg, reverseNegImg] = pure_negative(colorImg);
    figure('Name', 'Tes 2B: Negative');
    subplot(1, 3, 1); imshow(colorImg); title('Asli');
    subplot(1, 3, 2); imshow(negImg); title('Citra Negatif');
    subplot(1, 3, 3); imshow(reverseNegImg); title('Negatif dari Negatif');
    disp('Tes 2B Selesai. Tekan Enter untuk lanjut...');
    pause;

    % --- PENGUJIAN FUNGSI 2C: LOG TRANSFORM ---
    disp('Menjalankan Tes 2C: logTransform...');
    logImg = pure_logTransform(colorImg, 30);
    figure('Name', 'Tes 2C: Log Transform');
    subplot(1, 2, 1); imshow(colorImg); title('Asli');
    subplot(1, 2, 2); imshow(logImg); title('Hasil Log (c=30)');
    disp('Tes 2C Selesai. Tekan Enter untuk lanjut...');
    pause;
    
    % --- PENGUJIAN FUNGSI 2D: POWER TRANSFORM ---
    disp('Menjalankan Tes 2D: powerTransform...');
    powerImg = pure_powerTransform(colorImg, 1, 0.6); % Gamma < 1 mencerahkan
    figure('Name', 'Tes 2D: Power Transform');
    subplot(1, 2, 1); imshow(colorImg); title('Asli');
    subplot(1, 2, 2); imshow(powerImg); title('Hasil Pangkat (gamma=0.6)');
    disp('Tes 2D Selesai. Tekan Enter untuk lanjut...');
    pause;
    
    % --- PENGUJIAN FUNGSI 2E: CONTRAST STRETCH ---
    disp('Menjalankan Tes 2E: contrastStrecth...');
    stretchedImg = pure_contrastStrecth(colorImg);
    figure('Name', 'Tes 2E: Contrast Stretch');
    subplot(1, 2, 1); imshow(colorImg); title('Asli');
    subplot(1, 2, 2); imshow(stretchedImg); title('Hasil Peregangan Kontras');
    disp('Tes 2E Selesai. Tekan Enter untuk lanjut...');
    pause;

    % --- PENGUJIAN FUNGSI 4: HISTOGRAM MATCHING ---
    % Kita akan coba match gambar grayscale ke gambar warna (hanya V channel-nya)
    disp('Menjalankan Tes 4: hist_match...');
    matchedImg = pure_hist_match(grayImg, colorImg); % Match grayscale ke citra referensi warna
    figure('Name', 'Tes 4: Histogram Matching');
    subplot(1, 3, 1); imshow(grayImg); title('Input Grayscale');
    subplot(1, 3, 2); imshow(colorImg); title('Referensi Warna');
    subplot(1, 3, 3); imshow(matchedImg); title('Hasil Matching');
    disp('Semua tes selesai.');

end

% =================================================================
% KUMPULAN FUNGSI MURNI (TANPA UI)
% =================================================================

% --- FUNGSI 1: HISTOGRAM (SAYA PERBAIKI & GABUNGKAN) ---
function main_1_histogram(grayImg, colorImg)
    % proses gambar grayscale
    counts_gray = custom_image_histogram(grayImg);
    bins = 0:255;
    figure('Name','Tes 1: Histogram');
    subplot(2,2,1); imshow(grayImg); title('Citra Grayscale Asli');
    subplot(2,2,2); bar(bins, counts_gray, 'k'); title('Histogram Grayscale');
    
    % proses gambar berwarna
    R = colorImg(:,:,1);
    G = colorImg(:,:,2);
    B = colorImg(:,:,3);
    countR = custom_image_histogram(R);
    countG = custom_image_histogram(G);
    countB = custom_image_histogram(B);
    
    % Gabungkan R,G,B dalam satu plot untuk perbandingan
    subplot(2,2,3); imshow(colorImg); title('Citra Warna Asli');
    subplot(2,2,4); 
    hold on;
    bar(bins, countR, 'r');
    bar(bins, countG, 'g');
    bar(bins, countB, 'b');
    hold off;
    title('Histogram RGB Gabungan');
    legend('Red', 'Green', 'Blue');
end

% --- FUNGSI 2A: BRIGHTENER MURNI ---
function [outputImg_B, outputImg_AB] = pure_brightener(inputImgData, a, b)
    img = im2double(inputImgData);
    b_norm = b / 255.0;
    outputB = img + b_norm;
    outputAB = a * img + b_norm;
    outputImg_B = im2uint8(outputB);
    outputImg_AB = im2uint8(outputAB);
end

% --- FUNGSI 2B: NEGATIVE MURNI (SAYA PERBAIKI) ---
function [outputImg, reverseOutputImg] = pure_negative(inputImg)
    % Perbaikan: Menggunakan 1.0 untuk citra double, dan L-1 (255) untuk uint8
    if isfloat(inputImg) % Jika tipe datanya double/float
        L = 1.0;
    else % Jika tipe datanya integer (seperti uint8)
        L = 255;
    end
    outputImg = L - inputImg;
    reverseOutputImg = L - outputImg;
end

% --- FUNGSI 2C: LOG TRANSFORM MURNI ---
function outputImg = pure_logTransform(inputImg, c)
    img = im2double(inputImg); % Konversi ke double [0,1] untuk operasi log
    hasil = c * log(1 + img);
    outputImg = im2uint8(hasil); % Konversi kembali ke uint8
end

% --- FUNGSI 2D: POWER TRANSFORM MURNI ---
function outputImg = pure_powerTransform(inputImg, c, gamma)
    img = im2double(inputImg); % Konversi ke double [0,1]
    hasil = c * (img .^ gamma);
    outputImg = im2uint8(hasil);
end

% --- FUNGSI 2E: CONTRAST STRETCH MURNI ---
function outputImg = pure_contrastStrecth(inputImg)
    if size(inputImg, 3) == 1 % Grayscale
        img_double = im2double(inputImg);
        r_min = min(img_double(:));
        r_max = max(img_double(:));
        if r_min == r_max, outputImg = inputImg; return; end
        result = (img_double - r_min) / (r_max - r_min);
        outputImg = im2uint8(result);
    else % Warna
        hsv = rgb2hsv(inputImg);
        V = hsv(:, :, 3);
        v_min = min(V(:));
        v_max = max(V(:));
        if v_min == v_max, outputImg = inputImg; return; end
        V_stretched = (V - v_min) / (v_max - v_min);
        hsv_baru = cat(3, hsv(:,:,1), hsv(:,:,2), V_stretched);
        outputImg = hsv2rgb(hsv_baru); % Hasilnya sudah double, im2uint8 nanti
    end
end

% --- FUNGSI 4: HISTOGRAM MATCHING MURNI ---
function matched_image = pure_hist_match(inputImg, refImg)
    % Kode ini sudah cukup baik, hanya perlu dipanggil
    is_color = size(inputImg, 3) == 3;
    if ~is_color % grayscale
        cdfInput = cumsum(custom_image_histogram(inputImg)) / numel(inputImg);
        
        % Perbaikan: jika refImg berwarna, kita match ke luminance-nya (grayscale)
        if size(refImg, 3) == 3
            refImg = rgb2gray(refImg);
        end
        cdfRef = cumsum(custom_image_histogram(refImg)) / numel(refImg);

        mapping_table = zeros(256, 1);
        for intensity_level = 1:256
            cdf_value = cdfInput(intensity_level);
            [~, nearest_index] = min(abs(cdf_value - cdfRef));
            mapping_table(intensity_level) = nearest_index - 1;
        end
        matched_image = uint8(mapping_table(double(inputImg) + 1));
    else % rgb
        hsv_input = rgb2hsv(inputImg);
        if size(refImg, 3) == 1 % Jika ref grayscale
             V_reference = im2double(refImg);
        else % Jika ref warna
            hsv_reference = rgb2hsv(refImg);
            V_reference = hsv_reference(:, :, 3);
        end
        
        V_input = hsv_input(:, :, 3);
        
        V_input_uint8 = uint8(V_input * 255);
        V_reference_uint8 = uint8(V_reference * 255);
        
        cdfInput_V = cumsum(custom_image_histogram(V_input_uint8)) / numel(V_input_uint8);
        cdfRef_V = cumsum(custom_image_histogram(V_reference_uint8)) / numel(V_reference_uint8);
        
        mapping_table = zeros(256, 1);
        for intensity_level = 1:256
            cdf_value = cdfInput_V(intensity_level);
            [~, nearest_index] = min(abs(cdf_value - cdfRef_V));
            mapping_table(intensity_level) = nearest_index - 1;
        end
        
        V_matched_uint8 = uint8(mapping_table(V_input_uint8 + 1));
        V_matched = double(V_matched_uint8) / 255;
        
        final_hsv = cat(3, hsv_input(:, :, 1), hsv_input(:, :, 2), V_matched);
        matched_image = hsv2rgb(final_hsv);
    end
end

% --- FUNGSI PEMBANTU (ASUMSI SUDAH ADA) ---
function counts = custom_image_histogram(img)
    img = double(img);
    if max(img(:)) <= 1
        img = img * 255;
    end
    img(img < 0) = 0;
    img(img > 255) = 255;
    img = round(img);
    counts = zeros(256, 1);
    [rows, cols, ~] = size(img);
    for r = 1:rows
        for c = 1:cols
            value = img(r, c);
            counts(value + 1) = counts(value + 1) + 1;
        end
    end
end