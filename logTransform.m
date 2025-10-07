function outputImg = logTransform (app,inputImg, c)

    img= double(inputImg); 
    hasil = c * log(1 + img);
    outputImg = im2uint8(hasil);
    
        % Simpan sementara
    imwrite(uint8(outputImg), 'temp.png');

    % Tampilkan gambar dan histogram
    app.outputImage.ImageSource = 'temp.png';
    app.outputImageLabel.Text = 'Hasil Transformasi Log';
    app.plotFourHistograms(outputImg, 'outputHist_2');
    app.outputImage.Visible = 'on';
    app.outputImageLabel.Visible = 'on';

        % Sembunyikan set output kedua
    app.outputImage_2.Visible = 'off';
    app.outputImageLabel_2.Visible = 'off';
    app.outputHist_2G.Visible = 'off';
    app.outputHist_2B.Visible = 'off';
    app.outputHist_2R.Visible = 'off';
    app.outputHist_2Gabungan.Visible = 'off';
    
      
end