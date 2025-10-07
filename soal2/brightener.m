function brightener(app, inputImgData, a, b)


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
app.outputImage.ImageSource = ['temp_outputB.png' app.exte];
app.outputImage_2.ImageSource = ['temp_outputAB.png' app.exte];

% --- Update UI Output 1 ---
% 
% app.outputImage.ImageSource = outputImg_B;

app.outputImage.Visible = 'on';

app.outputImageLabel.Visible = 'on';

app.outputImageLabel.Text = 'Hasil (f + b)';

app.plotFourHistograms(outputImg_B, 'outputHist'); % Plot 4 histogram untuk hasil 1

% --- Update UI Output 2 ---

% app.outputImage_2.ImageSource = outputImg_AB;

app.outputImage_2.Visible = 'on';

app.outputImageLabel_2.Visible = 'on';

app.outputImageLabel_2.Text = 'Hasil (a*f + b)';

app.plotFourHistograms(outputImg_AB, 'outputHist_2'); % Plot 4 histogram untuk hasil 2

end