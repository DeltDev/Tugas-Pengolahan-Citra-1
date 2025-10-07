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

    app.outputImage_2.Visible = 'off';
    app.outputImageLabel_2.Visible = 'off';
    app.outputHist_2G.Visible = 'off';
    app.outputHist_2B.Visible = 'off';
    app.outputHist_2R.Visible = 'off';
    app.outputHist_2Gabungan.Visible = 'off';

end