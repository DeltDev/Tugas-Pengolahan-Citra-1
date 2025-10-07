function hist_match_test()
    % Fungsi untuk menguji histogram matching
    
    % Minta user memilih citra input
    disp('=== HISTOGRAM MATCHING TEST ===');
    disp('Pilih citra INPUT (yang akan diubah):');
    inputImg = browse_image();
    if isempty(inputImg)
        disp('Tidak ada citra input yang dipilih.');
        return;
    end
    
    % Minta user memilih citra referensi
    disp('Pilih citra REFERENSI (target histogram):');
    refImg = browse_image();
    if isempty(refImg)
        disp('Tidak ada citra referensi yang dipilih.');
        return;
    end
    
    % Tampilkan citra asli
    figure('Name', 'Input dan Referensi', 'NumberTitle', 'off');
    subplot(1,2,1);
    imshow(inputImg);
    title('Citra Input (akan diubah)');
    
    subplot(1,2,2);
    imshow(refImg);
    title('Citra Referensi (target)');
    
    % Deteksi jenis citra
    is_color = size(inputImg, 3) == 3;
    
    if ~is_color
        % === GRAYSCALE ===
        disp('Kedua citra adalah grayscale.');
        
        % Hitung histogram asli
        countInput = custom_image_histogram(inputImg);
        countRef = custom_image_histogram(refImg);
        bins = 0:255;
        
        % Tampilkan histogram asli
        figure('Name', 'Histogram Asli', 'NumberTitle', 'off');
        subplot(2,1,1);
        bar(bins, countInput, 'k');
        title('Histogram Input Asli');
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        
        subplot(2,1,2);
        bar(bins, countRef, 'r');
        title('Histogram Referensi');
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        
        % Lakukan histogram matching
        disp('Melakukan histogram matching...');
        [matched_image, mapping_table] = hist_match(inputImg, refImg);
        
        % Tampilkan hasil
        figure('Name', 'Hasil Histogram Matching', 'NumberTitle', 'off');
        subplot(1,3,1);
        imshow(inputImg);
        title('Input Asli');
        
        subplot(1,3,2);
        imshow(refImg);
        title('Referensi');
        
        subplot(1,3,3);
        imshow(matched_image);
        title('Hasil Matching');
        
        % Hitung histogram hasil
        countMatched = custom_image_histogram(matched_image);
        
        % Tampilkan perbandingan histogram
        figure('Name', 'Perbandingan Histogram', 'NumberTitle', 'off');
        subplot(3,1,1);
        bar(bins, countInput, 'k');
        title('Histogram Input Asli');
        xlabel('Intensitas');
        ylabel('Jumlah Piksel');
        
        subplot(3,1,2);
        bar(bins, countRef, 'r');
        title('Histogram Referensi (Target)');
        xlabel('Intensitas');
        ylabel('Jumlah Piksel');
        
        subplot(3,1,3);
        bar(bins, countMatched, 'b');
        title('Histogram Hasil Matching');
        xlabel('Intensitas');
        ylabel('Jumlah Piksel');
        
        % Tampilkan mapping table
        figure('Name', 'Mapping Table', 'NumberTitle', 'off');
        plot(0:255, mapping_table, 'LineWidth', 2);
        title('Fungsi Transformasi (Mapping Table)');
        xlabel('Intensitas Input');
        ylabel('Intensitas Output');
        grid on;
        
    else
        % === RGB ===
        disp('Kedua citra adalah berwarna (RGB).');
        
        % Pisahkan channel untuk histogram asli
        R_in = inputImg(:,:,1);
        G_in = inputImg(:,:,2);
        B_in = inputImg(:,:,3);
        
        R_ref = refImg(:,:,1);
        G_ref = refImg(:,:,2);
        B_ref = refImg(:,:,3);
        
        countR_in = custom_image_histogram(R_in);
        countG_in = custom_image_histogram(G_in);
        countB_in = custom_image_histogram(B_in);
        
        countR_ref = custom_image_histogram(R_ref);
        countG_ref = custom_image_histogram(G_ref);
        countB_ref = custom_image_histogram(B_ref);
        
        bins = 0:255;
        
        % Tampilkan histogram asli
        figure('Name', 'Histogram RGB Input', 'NumberTitle', 'off');
        subplot(3,1,1); bar(bins, countR_in, 'r'); title('Histogram R Input');
        subplot(3,1,2); bar(bins, countG_in, 'g'); title('Histogram G Input');
        subplot(3,1,3); bar(bins, countB_in, 'b'); title('Histogram B Input');
        
        figure('Name', 'Histogram RGB Referensi', 'NumberTitle', 'off');
        subplot(3,1,1); bar(bins, countR_ref, 'r'); title('Histogram R Referensi');
        subplot(3,1,2); bar(bins, countG_ref, 'g'); title('Histogram G Referensi');
        subplot(3,1,3); bar(bins, countB_ref, 'b'); title('Histogram B Referensi');
        
        % Lakukan histogram matching
        disp('Melakukan histogram matching pada citra RGB (HSV method)...');
        [matched_image, mapping_table] = hist_match(inputImg, refImg);
        
        % Tampilkan hasil
        figure('Name', 'Hasil Histogram Matching RGB', 'NumberTitle', 'off');
        subplot(1,3,1);
        imshow(inputImg);
        title('Input Asli');
        
        subplot(1,3,2);
        imshow(refImg);
        title('Referensi');
        
        subplot(1,3,3);
        imshow(matched_image);
        title('Hasil Matching');
        
        % Hitung histogram hasil
        matched_uint8 = uint8(matched_image * 255);
        R_match = matched_uint8(:,:,1);
        G_match = matched_uint8(:,:,2);
        B_match = matched_uint8(:,:,3);
        
        countR_match = custom_image_histogram(R_match);
        countG_match = custom_image_histogram(G_match);
        countB_match = custom_image_histogram(B_match);
        
        % Tampilkan histogram hasil
        figure('Name', 'Histogram RGB Hasil', 'NumberTitle', 'off');
        subplot(3,1,1); bar(bins, countR_match, 'r'); title('Histogram R Hasil');
        subplot(3,1,2); bar(bins, countG_match, 'g'); title('Histogram G Hasil');
        subplot(3,1,3); bar(bins, countB_match, 'b'); title('Histogram B Hasil');
        
        % Tampilkan mapping table
        figure('Name', 'Mapping Table (V Channel)', 'NumberTitle', 'off');
        plot(0:255, mapping_table, 'LineWidth', 2);
        title('Fungsi Transformasi Value Channel (HSV)');
        xlabel('Intensitas Input');
        ylabel('Intensitas Output');
        grid on;
    end
    
    disp('=== PROSES SELESAI ===');
end