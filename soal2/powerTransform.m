function outputImg = powerTransform(app,inputImg, c, gamma)

    img = im2double(imread(inputImg));
    hasil = c * (img .^ gamma);
    outputImg = im2uint8(hasil);
    
    imwrite(uint8(outputImg), 'temp.png');
    app.outputImage.ImageSource = 'temp.png';
    plot(app.outputHist, imhist(uint8(outputImg)));

    app.outputHist.Visible = 'on';
    app.outputImage.Visible = 'on';
    app.outputImageLabel.Visible = 'on';

end