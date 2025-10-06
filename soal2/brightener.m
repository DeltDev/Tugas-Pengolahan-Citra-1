
function  brightener(app, inputImg, a, b)

    img = im2double(imread(inputImg));
    b = b / 255.0;
    
        % --- Proses tanpa dan dengan a ---
    hasil = img + b;
    hasilWithA = a * img + b;

    % --- Clipping manual (mirip C) ---
    hasil(hasil < 0) = 0;
    hasil(hasil > 1) = 1;
    hasilWithA(hasilWithA < 0) = 0;
    hasilWithA(hasilWithA > 1) = 1;

    % --- Kembali ke uint8 ---
    outputImg = im2uint8(hasil);
    outputImgWithA = im2uint8(hasilWithA);
    
    imwrite(outputImg, 'temp.png');
    imwrite(outputImgWithA, 'tempWithA.png');
    



    app.outputImage.ImageSource = 'temp.png';
    histData = imhist(outputImg);
    plot(app.outputHist, histData);
    
    app.outputImage2.ImageSource = 'tempWithA.png';
    histData2 = imhist(outputImgWithA);
    plot(app.outputHist2, histData2);
    
    
    app.outputHist.Visible = 'on';
    app.outputImage.Visible = 'on';
    app.outputImageLabel.Visible = 'on';
    
    app.outputHist2.Visible = 'on';
    app.outputImage2.Visible = 'on';
    app.outputImageLabel2.Visible = 'on';
end


% function [outputImg, outputImgWithA] =  brightener( inputImg, a, b)
% 
% inputImg = im2double(inputImg);
% b = b / 255.0;
% fprintf('b :     %g',b);
% 
% hasil =  inputImg + b;
% hasilWithA = a * inputImg + b;
% 
% outputImg = im2uint8(hasil);
% outputImgWithA = im2uint8(hasilWithA);
% 
% 
% end