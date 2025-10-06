function outputImg = logTransform (app,inputImg, c)

    img= im2double(imread(inputImg)); 
    hasil = c * log(1 + img);
    outputImg = im2uint8(hasil);
    
        % Simpan sementara
    imwrite(uint8(outputImg), 'temp.png');

    % Tampilkan gambar dan histogram
    app.outputImage.ImageSource = 'temp.png';
    plot(app.outputHist, imhist(uint8(outputImg)));

    % Tampilkan semua komponen
    app.outputHist.Visible = 'on';
    app.outputImage.Visible = 'on';
    app.outputImageLabel.Visible = 'on';
    
      
end