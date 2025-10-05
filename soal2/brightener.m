
function  brightener(app, inputImg, a, b)

inputImg = im2double(imread(inputImg));
b = b / 255.0;

hasil =  inputImg + b;
hasilWithA = a * inputImg + b;

outputImg = im2uint8(hasil);
outputImgWithA = im2uint8(hasilWithA);

imwrite(outputImg, 'temp.png');
imwrite(outputImgWithA, 'tempWithA.png');

app.outputImage.ImageSource = 'temp.png';
histData = imhist(outputImg);
plot(app.outputHist, histData);

app.outputImage2.ImageSource = 'tempWithA.png';
histData1 = imhist(outputImgWithA);
plot(app.outputHist2, histData1);


app.outputHist.Visible = 'on';
app.outputImage.Visible = 'on';
app.outputImageLabel.Visible = 'on';

app.outputHist2.Visible = 'on';
app.outputImage2.Visible = 'on';
app.outputImageLabel2.Visible = 'on';
end