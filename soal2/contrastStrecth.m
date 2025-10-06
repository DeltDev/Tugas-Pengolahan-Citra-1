% NAMA FILE: fungsi_peregangan_kontras.m
function outputImg = contrastStrecth(app, inputImg)
    % Melakukan peregangan kontras. Nilai r_min dan r_max dicari otomatis.
    % Untuk citra berwarna, proses dilakukan pada kanal V (Value) dari HSV
    % untuk menghindari pergeseran warna.
    
    if size(inputImg, 3) == 1 % --- Grayscale ---
        inputImg = im2double(imread(inputImg));
        
        % Cari r_min dan r_max secara otomatis
        r_min = min(inputImg(:));
        r_max = max(inputImg(:));
        
        % Hindari pembagian dengan nol jika citra berwarna solid
        if r_min == r_max
            outputImg = inputImg;
            return;
        end
        
        % Terapkan formula peregangan kontras
        result = (inputImg - r_min) / (r_max - r_min);
        outputImg = im2uint8(result);
        
    else % --- Berwarna (RGB) ---
        % Konversi ke HSV untuk memisahkan intensitas (Value) dari warna (Hue)
        hsv = rgb2hsv(imread(inputImg));
        V = hsv(:, :, 3); % Ambil kanal V (Value/Intensitas)
        
        % Cari v_min dan v_max secara otomatis dari kanal V
        v_min = min(V(:));
        v_max = max(V(:));
    
        if v_min == v_max
            outputImg = inputImg;
            return;
        end
        
        % Lakukan peregangan kontras hanya pada kanal V
        V_stretched = (V - v_min) / (v_max - v_min);
        
        % Gabungkan kembali dengan kanal H dan S yang asli
        hsv_baru = cat(3, hsv(:,:,1), hsv(:,:,2), V_stretched);
        
        % Konversi kembali ke RGB
        outputImg = im2uint8(hsv2rgb(hsv_baru));
    end

    imwrite(uint8(outputImg), 'temp.png');
    app.outputImage.ImageSource = 'temp.png';
    plot(app.outputHist, imhist(uint8(outputImg)));

    app.outputHist.Visible = 'on';
    app.outputImage.Visible = 'on';
    app.outputImageLabel.Visible = 'on';
end