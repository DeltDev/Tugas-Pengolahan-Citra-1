function outputImg = powerTransform(app,inputImg, c, gamma)

    img = double(inputImg);
    hasil = c * (img .^ gamma);
    outputImg = im2uint8(hasil);
    
    % --- Update UI ---
    app.outputImage.ImageSource = outputImg;
    app.outputImage.Visible = 'on';
    app.outputImageLabel.Visible = 'on';
    app.outputImageLabel.Text = 'Hasil Transformasi Pangkat';
    app.plotFourHistograms(outputImg, 'outputHist');

    % Sembunyikan set output kedua
    app.outputImage2.Visible = 'off';

end