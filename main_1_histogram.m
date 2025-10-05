function main_1_histogram()
    img = browse_image();

    if isempty(img)
        return;
    end
    % tampilkan citra
    figure;
    imshow(img);
    title('Citra Asli');
    % cek apakah gambar grayscale atau berwarna

    if size(img, 3) == 1
        disp('Citra adalah gambar grayscale.');
    
        % hitung histogram grayscale (hanya sekali)
        counts = custom_image_histogram(img);
        bins = 0:255;

        %tampilkan histogram citra grayscale
        figure;
        bar(bins, counts, 'k');
        title('Histogram Citra Grayscale (fungsi histogram dibuat sendiri)');
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
        countR = custom_image_histogram(R);
        countG = custom_image_histogram(G);
        countB = custom_image_histogram(B);
    
        % Tampilkan histogram RGB
        figure;
        bar(binsR, countR, 'r');
        title('Histogram Citra R/Merah (fungsi histogram dibuat sendiri)');
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        figure;
        bar(binsG, countG, 'g');
        title('Histogram Citra G/Hijau (fungsi histogram dibuat sendiri)');
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        figure;
        bar(binsB, countB, 'b');
        title('Histogram Citra B/Biru (fungsi histogram dibuat sendiri)');
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
    end
end




