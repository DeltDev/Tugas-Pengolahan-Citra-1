function output_img = logTransform (input_img, c)
    %cara 1
    img_double = im2double(input_img); % Konversi ke double dengan normalisasi
    % Terapkan transformasi log
    hasil_double = c * log(1 + img_double);
    % Konversi kembali ke uint8
    output_img = im2uint8(hasil_double);
    
    %cara 2
    % img_double = im2double(input_img); % Konversi ke double
    % % Transformasi log: s = c log(1 + r)
    % output_double = c * log(1 + img_double);
    % % Normalisasi ke range [0, 255]
    % output_double = output_double - min(output_double(:));
    % output_double = output_double / max(output_double(:))*255;
    % % Konversi kembali ke uint8
    % output_img = im2uint8(output_double);

      
end