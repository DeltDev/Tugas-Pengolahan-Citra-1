function histogram_equalization_benchmark()
    img = browse_image();
    if isempty(img)
        return;
    end
    
    figure;
    imshow(img);
    title('Citra Asli');
    
    if size(img, 3) == 1
        disp('Citra adalah gambar grayscale.');
        
        % hitung histogram citra asli
        counts = imhist(img);
        bins = 0:255;
        
        % tampilkan histogram asli
        figure;
        bar(bins, counts, 'k');
        title('Histogram Citra Asli (Grayscale)');
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
        
        % lakukan perataan histogram (HAPUS counts!)
        eq_img = histeq(img);
        
        % tampilkan citra hasil perataan
        figure;
        imshow(uint8(eq_img));
        title('Citra Hasil Histogram Equalization (Grayscale)');
        
        % hitung histogram hasil
        eq_counts = custom_image_histogram(eq_img);
        
        % tampilkan histogram hasil
        figure;
        bar(bins, eq_counts, 'k');
        title('Histogram Citra Setelah Equalization (Grayscale)');
        xlabel('Intensitas (0-255)');
        ylabel('Jumlah Piksel');
    else
        disp('Citra adalah gambar berwarna.');
        
        % pisahkan channel R, G, B
        R = img(:,:,1);
        G = img(:,:,2);
        B = img(:,:,3);
        
        % hitung histogram tiap channel
        countR = imhist(R);
        countG = imhist(G);
        countB = imhist(B);
        bins = 0:255;
        
        % tampilkan histogram asli
        figure;
        subplot(3,1,1); bar(bins, countR, 'r'); title('Histogram R Asli');
        subplot(3,1,2); bar(bins, countG, 'g'); title('Histogram G Asli');
        subplot(3,1,3); bar(bins, countB, 'b'); title('Histogram B Asli');
        
        % lakukan perataan histogram per channel (HAPUS countR, countG, countB!)
        R_eq = histeq(R);
        G_eq = histeq(G);
        B_eq = histeq(B);
        
        % gabungkan kembali
        eq_img = cat(3, uint8(R_eq), uint8(G_eq), uint8(B_eq));
        
        % tampilkan citra hasil
        figure;
        imshow(eq_img);
        title('Citra Hasil Histogram Equalization (RGB)');
        
        % hitung histogram hasil
        eq_countR = imhist(R_eq);
        eq_countG = imhist(G_eq);
        eq_countB = imhist(B_eq);
        
        % tampilkan histogram hasil
        figure;
        subplot(3,1,1); bar(bins, eq_countR, 'r'); title('Histogram R Setelah Equalization');
        subplot(3,1,2); bar(bins, eq_countG, 'g'); title('Histogram G Setelah Equalization');
        subplot(3,1,3); bar(bins, eq_countB, 'b'); title('Histogram B Setelah Equalization');
    end
end