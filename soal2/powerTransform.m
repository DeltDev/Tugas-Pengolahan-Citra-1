function outputImg = powerTransform(inputImage, c, gamma)
    img_normalized = im2double(inputImage);
    
    % Transformasi pangkat: s = c * r^gamma
    output_normalized = c * (img_normalized .^ gamma);
    
    % % Clipping ke range [0, 1]
    % output_normalized = max(0, min(1, output_normalized));
    
    % Kembalikan ke range [0, 255]
    outputImg = im2uint8(output_normalized);
    
    % fprintf('Transformasi Pangkat: s = %.2f * r^%.2f\n', c, gamma);
    % if gamma < 1
    %     fprintf('Gamma < 1: Brightening (expand dark regions)\n');
    % elseif gamma > 1
    %     fprintf('Gamma > 1: Darkening (compress dark regions)\n');
    % else
    %     fprintf('Gamma = 1: Linear (no change)\n');
    
end