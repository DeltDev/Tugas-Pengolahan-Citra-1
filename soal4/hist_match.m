function [matched_image, mapping_table] = hist_match(app, inputImg, refImg)
%HIST_MATCH Melakukan Histogram Specification (Matching) pada sebuah citra.
%   [matched_image, mapping_table] = hist_match(inputImg, refImg)
%   menyesuaikan histogram dari 'inputImg' agar sesuai dengan histogram
%   dari 'refImg'.
%
%   Input:
%       inputImg     - Citra yang akan diubah (grayscale atau RGB).
%       refImg - Citra yang histogramnya menjadi target (grayscale atau RGB).
%
%   Output:
%       matched_image   - Citra hasil dengan histogram yang sudah disesuaikan.
%       mapping_table   - Tabel pemetaan intensitas yang digunakan (opsional).


is_color = size(inputImg, 3) == 3;

if ~is_color % grayscale

    % Langkah 1: Hitung CDF (Cumulative Distribution Function) dari input dan referensi.
    % imhist menghitung histogram, cumsum mengakumulasikannya, dan numel menormalisasi.
    cdfInput = cumsum(custom_image_histogram(inputImg)) / numel(inputImg);
    cdfRef = cumsum(custom_image_histogram(refImg)) / numel(refImg);

    % Langkah 2: Buat tabel pemetaan (lookup table).
    mapping_table = zeros(256, 1);
    for intensity_level = 1:256
        % Untuk setiap tingkat keabuan 'i' pada citra input, cari tingkat
        % keabuan 'j' pada citra referensi yang memiliki nilai CDF terdekat.
        cdf_value = cdfInput(intensity_level);
        [~, nearest_index] = min(abs(cdf_value - cdfRef));
        mapping_table(intensity_level) = nearest_index - 1; % -1 karena nilai piksel 0-255
    end

    % Langkah 3: Terapkan pemetaan ke setiap piksel citra input.
    % Operasi ini tervektorisasi, jauh lebih cepat daripada for-loop.
    matched_image = uint8(mapping_table(double(inputImg) + 1));

else % rgb
    
    % Untuk menghindari pergeseran warna (color shift), kita hanya akan
    % memodifikasi kanal intensitas (Value) dari model warna HSV.
    
    % Konversi kedua citra ke HSV
    hsv_input = rgb2hsv(inputImg);
    hsv_reference = rgb2hsv(refImg);
    
    % Ekstrak kanal V (Value/Intensitas) dari keduanya
    V_input = hsv_input(:, :, 3);
    V_reference = hsv_reference(:, :, 3);
    
    % Karena kanal V berjenis double [0,1], kita ubah ke uint8 [0,255]
    % agar bisa menggunakan imhist.
    V_input_uint8 = uint8(V_input * 255);
    V_reference_uint8 = uint8(V_reference * 255);
    
    % Lakukan proses matching persis seperti pada citra grayscale,
    % tetapi hanya pada kanal V.
    cdfInput_V = cumsum(custom_image_histogram(V_input_uint8)) / numel(V_input_uint8);
    cdfRef_V = cumsum(custom_image_histogram(V_reference_uint8)) / numel(V_reference_uint8);
    
    mapping_table = zeros(256, 1);
    for intensity_level = 1:256
        cdf_value = cdfInput_V(intensity_level);
        [~, nearest_index] = min(abs(cdf_value - cdfRef_V));
        mapping_table(intensity_level) = nearest_index - 1;
    end
    
    % Terapkan mapping ke kanal V dari citra input
    V_matched_uint8 = uint8(mapping_table(V_input_uint8 + 1));
    
    % Kembalikan V yang sudah di-match ke format double [0,1]
    V_matched = double(V_matched_uint8) / 255;
    
    % Gabungkan kembali dengan kanal Hue (H) dan Saturation (S) ASLI dari citra input.
    % Ini adalah kunci untuk mempertahankan warna asli.
    final_hsv = cat(3, hsv_input(:, :, 1), hsv_input(:, :, 2), V_matched);
    
    % Konversi citra HSV hasil kembali ke RGB untuk ditampilkan.
    matched_image = hsv2rgb(final_hsv);

end
end