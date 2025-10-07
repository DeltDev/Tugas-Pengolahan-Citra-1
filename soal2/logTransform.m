function outputImg = logTransform (app,inputImg, c)

    img= double(inputImg); 
    hasil = c * log(1 + img);
    outputImg = im2uint8(hasil);
    
        % Simpan sementara
    imwrite(uint8(outputImg), 'temp.png');

    % Tampilkan gambar dan histogram
    app.outputImage.ImageSource = 'temp.png';
    app.outputImageLabel.Text = 'Hasil Transformasi Log';
    app.plotFourHistograms(outputImg, 'outputHist');
    app.outputImage.Visible = 'on';
    app.outputImageLabel.Visible = 'on';
    
      
end