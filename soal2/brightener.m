function brightener(app, inputImgData, a, b)
    % Menghasilkan 2 output, jadi kita tampilkan di 2 set komponen output
    
    img = im2double(inputImgData);
    b_norm = b / 255.0;
    
    % Hitung kedua hasil
    outputB = img + b_norm;
    outputAB = a * img + b_norm;
    
    % Konversi kembali ke uint8 untuk ditampilkan
    outputImg_B = im2uint8(outputB);
    outputImg_AB = im2uint8(outputAB);
    
    % --- Update UI Output 1 ---
    app.outputImage.ImageSource = outputImg_B;
    app.outputImage.Visible = 'on';
    app.outputImageLabel.Visible = 'on';
    app.outputImageLabel.Text = 'Hasil (f + b)';
    app.plotFourHistograms(outputImg_B, 'outputHist'); % Plot 4 histogram untuk hasil 1

    % --- Update UI Output 2 ---
    app.outputImage2.ImageSource = outputImg_AB;
    app.outputImage2.Visible = 'on';
    app.outputImageLabel2.Visible = 'on';
    app.outputImageLabel2.Text = 'Hasil (a*f + b)';
    app.plotFourHistograms(outputImg_AB, 'outputHist2'); % Plot 4 histogram untuk hasil 2
end