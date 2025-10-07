function main_brightener_analysis()
    % Fungsi untuk menganalisis hasil brightener dengan tampilan lengkap
    % seperti histogram equalization
    
    % Pilih gambar
    img = browse_image();
    if isempty(img)
        return;
    end
    
    % Input parameter a dan b
    prompt = {'Masukkan nilai a (kontras):', 'Masukkan nilai b (brightness):'};
    dlgtitle = 'Parameter Brightener';
    dims = [1 35];
    definput = {'1.5', '50'};
    answer = inputdlg(prompt, dlgtitle, dims, definput);
    
    if isempty(answer)
        return;
    end
    
    a = str2double(answer{1});
    b = str2double(answer{2});
    
    % Proses gambar
    img_double = im2double(img);
    b_norm = b / 255.0;
    
    % Hitung kedua hasil
    outputB = img_double + b_norm;
    outputAB = a * img_double + b_norm;
    
    outputImg_B = im2uint8(outputB);
    outputImg_AB = im2uint8(outputAB);
    
    % ========================================================================
    % TAMPILAN UNTUK CITRA GRAYSCALE
    % ========================================================================
    if size(img, 3) == 1
        disp('Citra adalah gambar grayscale.');
        
        % Hitung histogram asli
        counts_original = custom_image_histogram(img);
        counts_B = custom_image_histogram(outputImg_B);
        counts_AB = custom_image_histogram(outputImg_AB);
        bins = 0:255;
        
        % === FIGURE 1: Perbandingan Citra ===
        figure('Name', 'Perbandingan Citra Grayscale', 'NumberTitle', 'off');
        
        subplot(1,3,1);
        imshow(img);
        title('Citra Asli');
        
        subplot(1,3,2);
        imshow(outputImg_B);
        title(sprintf('Hasil (f + %.2f)', b_norm));
        
        subplot(1,3,3);
        imshow(outputImg_AB);
        title(sprintf('Hasil (%.2f*f + %.2f)', a, b_norm));
        
        % === FIGURE 2: Perbandingan Histogram ===
        figure('Name', 'Perbandingan Histogram Grayscale', 'NumberTitle', 'off');
        
        subplot(3,1,1);
        bar(bins, counts_original, 'k');
        title('Histogram Citra Asli');
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        xlim([0 255]);
        grid on;
        
        subplot(3,1,2);
        bar(bins, counts_B, 'b');
        title(sprintf('Histogram Hasil (f + %.2f)', b_norm));
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        xlim([0 255]);
        grid on;
        
        subplot(3,1,3);
        bar(bins, counts_AB, 'r');
        title(sprintf('Histogram Hasil (%.2f*f + %.2f)', a, b_norm));
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        xlim([0 255]);
        grid on;
        
    % ========================================================================
    % TAMPILAN UNTUK CITRA RGB
    % ========================================================================
    else
        disp('Citra adalah gambar berwarna.');
        
        % Pisahkan channel untuk citra asli
        R_orig = img(:,:,1);
        G_orig = img(:,:,2);
        B_orig = img(:,:,3);
        
        % Pisahkan channel untuk hasil (f + b)
        R_B = outputImg_B(:,:,1);
        G_B = outputImg_B(:,:,2);
        B_B = outputImg_B(:,:,3);
        
        % Pisahkan channel untuk hasil (a*f + b)
        R_AB = outputImg_AB(:,:,1);
        G_AB = outputImg_AB(:,:,2);
        B_AB = outputImg_AB(:,:,3);
        
        % Hitung histogram tiap channel
        countR_orig = custom_image_histogram(R_orig);
        countG_orig = custom_image_histogram(G_orig);
        countB_orig = custom_image_histogram(B_orig);
        
        countR_B = custom_image_histogram(R_B);
        countG_B = custom_image_histogram(G_B);
        countB_B = custom_image_histogram(B_B);
        
        countR_AB = custom_image_histogram(R_AB);
        countG_AB = custom_image_histogram(G_AB);
        countB_AB = custom_image_histogram(B_AB);
        
        bins = 0:255;
        
        % === FIGURE 1: Perbandingan Citra ===
        figure('Name', 'Perbandingan Citra RGB', 'NumberTitle', 'off');
        
        subplot(1,3,1);
        imshow(img);
        title('Citra Asli');
        
        subplot(1,3,2);
        imshow(outputImg_B);
        title(sprintf('Hasil (f + %.0f)', b));
        
        subplot(1,3,3);
        imshow(outputImg_AB);
        title(sprintf('Hasil (%.2f*f + %.0f)', a, b));
        
        % === FIGURE 2: Histogram Citra Asli ===
        figure('Name', 'Histogram RGB Asli', 'NumberTitle', 'off');
        
        subplot(3,1,1);
        bar(bins, countR_orig, 'r', 'EdgeColor', 'none');
        title('Histogram Red Channel Asli');
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        xlim([0 255]);
        grid on;
        
        subplot(3,1,2);
        bar(bins, countG_orig, 'g', 'EdgeColor', 'none');
        title('Histogram Green Channel Asli');
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        xlim([0 255]);
        grid on;
        
        subplot(3,1,3);
        bar(bins, countB_orig, 'b', 'EdgeColor', 'none');
        title('Histogram Blue Channel Asli');
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        xlim([0 255]);
        grid on;
        
        % === FIGURE 3: Histogram Hasil (f + b) ===
        figure('Name', sprintf('Histogram RGB Hasil (f + %.0f)', b), 'NumberTitle', 'off');
        
        subplot(3,1,1);
        bar(bins, countR_B, 'r', 'EdgeColor', 'none');
        title(sprintf('Histogram Red Channel (f + %.0f)', b));
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        xlim([0 255]);
        grid on;
        
        subplot(3,1,2);
        bar(bins, countG_B, 'g', 'EdgeColor', 'none');
        title(sprintf('Histogram Green Channel (f + %.0f)', b));
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        xlim([0 255]);
        grid on;
        
        subplot(3,1,3);
        bar(bins, countB_B, 'b', 'EdgeColor', 'none');
        title(sprintf('Histogram Blue Channel (f + %.0f)', b));
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        xlim([0 255]);
        grid on;
        
        % === FIGURE 4: Histogram Hasil (a*f + b) ===
        figure('Name', sprintf('Histogram RGB Hasil (%.2f*f + %.0f)', a, b), 'NumberTitle', 'off');
        
        subplot(3,1,1);
        bar(bins, countR_AB, 'r', 'EdgeColor', 'none');
        title(sprintf('Histogram Red Channel (%.2f*f + %.0f)', a, b));
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        xlim([0 255]);
        grid on;
        
        subplot(3,1,2);
        bar(bins, countG_AB, 'g', 'EdgeColor', 'none');
        title(sprintf('Histogram Green Channel (%.2f*f + %.0f)', a, b));
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        xlim([0 255]);
        grid on;
        
        subplot(3,1,3);
        bar(bins, countB_AB, 'b', 'EdgeColor', 'none');
        title(sprintf('Histogram Blue Channel (%.2f*f + %.0f)', a, b));
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        xlim([0 255]);
        grid on;
        
        % === FIGURE 5: Histogram Gabungan (Overlay) ===
        figure('Name', 'Perbandingan Histogram Overlay', 'NumberTitle', 'off');
        
        % Subplot untuk hasil (f + b)
        subplot(2,1,1);
        hold on;
        plot(bins, countR_B, 'r', 'LineWidth', 1.5);
        plot(bins, countG_B, 'g', 'LineWidth', 1.5);
        plot(bins, countB_B, 'b', 'LineWidth', 1.5);
        hold off;
        legend({'Red', 'Green', 'Blue'}, 'Location', 'best');
        title(sprintf('Histogram Gabungan (f + %.0f)', b));
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        xlim([0 255]);
        grid on;
        
        % Subplot untuk hasil (a*f + b)
        subplot(2,1,2);
        hold on;
        plot(bins, countR_AB, 'r', 'LineWidth', 1.5);
        plot(bins, countG_AB, 'g', 'LineWidth', 1.5);
        plot(bins, countB_AB, 'b', 'LineWidth', 1.5);
        hold off;
        legend({'Red', 'Green', 'Blue'}, 'Location', 'best');
        title(sprintf('Histogram Gabungan (%.2f*f + %.0f)', a, b));
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        xlim([0 255]);
        grid on;
    end
    
    disp('=== ANALISIS SELESAI ===');
    fprintf('Parameter: a = %.2f, b = %.0f\n', a, b);
    fprintf('Total figures dibuat: %d\n', get(groot, 'CurrentFigure').Number);
end