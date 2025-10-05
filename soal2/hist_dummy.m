% NAMA FILE: buatHistogram.m
function hist_dummy(img)
% Fungsi ini membuat plot histogram untuk citra grayscale atau RGB pada axes
% yang sedang aktif.

% Cek apakah citra grayscale atau berwarna
if size(img, 3) == 1 
    % --- CITRA GRAYSCALE ---
    imhist(img);
    title('Histogram Grayscale');
    xlabel('Tingkat Keabuan (0-255)');
    ylabel('Jumlah Piksel');
    grid on;
    xlim([0 255]); % Atur batas sumbu-x
else 
    % --- CITRA BERWARNA (RGB) ---
    % Pisahkan kanal warna
    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);

    % Hitung histogram untuk setiap kanal
    [countsR, bins] = imhist(R);
    [countsG, ~] = imhist(G);
    [countsB, ~] = imhist(B);
    
    % Plot histogram dalam satu axes
    hold on;
    plot(bins, countsR, 'Red', 'LineWidth', 1.5);
    plot(bins, countsG, 'Green', 'LineWidth', 1.5);
    plot(bins, countsB, 'Blue', 'LineWidth', 1.5);
    hold off;
    
    title('Histogram RGB');
    xlabel('Intensitas Warna (0-255)');
    ylabel('Jumlah Piksel');
    legend('Merah', 'Hijau', 'Biru');
    grid on;
    xlim([0 255]); % Atur batas sumbu-x
    axis tight;
end
end