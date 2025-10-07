
function [outputImg_B, outputImg_AB] = brightener( inputImgData, a, b)


img = im2double(inputImgData);

b_norm = b / 255.0;


% Hitung kedua hasil

outputB = img + b_norm;

outputAB = a * img + b_norm;




outputImg_B = im2uint8(outputB);

outputImg_AB = im2uint8(outputAB);


imwrite(outputImg_B, ['temp_outputB.png' app.exte]);
imwrite(outputImg_AB , ['temp_outputAB.png' app.exte]);

% SET IMAGE SOURCE DENGAN PATH


end