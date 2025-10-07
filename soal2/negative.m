function negative(app, inputImg)  
    % Konversi ke tipe double untuk perhitungan
    inputImg = double(inputImg)*255 ;
    [M, N, C] = size(inputImg);

    outputImg = zeros(M, N, C);

    for i = 1:M
        for j = 1:N
            for k = 1:C
                outputImg(i, j, k) = 255 - inputImg(i, j, k);
            end
        end
    end

    % Reverse output (negatif dari negatif)
    reverseOutputImg = 255 - outputImg;

        % --- Update UI Output 1 ---
    app.outputImage.ImageSource = outputImg;
    app.outputImage.Visible = 'on';
    app.outputImageLabel.Visible = 'on';
    app.outputImageLabel.Text = 'Citra Negatif';
    app.plotFourHistograms(outputImg, 'outputHist');

    % --- Update UI Output 2 ---
    app.outputImage_2.ImageSource = reverseOutputImg;
    app.outputImage_2.Visible = 'on';
    app.outputImageLabel_2.Visible = 'on';
    app.outputImageLabel_2.Text = 'Negatif dari Negatif (Asli)';
    app.plotFourHistograms(reverseOutputImg, 'outputHist_2');
    % 
    % % Simpan sementara
    % imwrite(uint8(outputImg), 'temp.png');
    % imwrite(uint8(reverseOutputImg), 'tempreverse.png');

    % % Tampilkan gambar dan histogram
    % app.outputImage.ImageSource = 'temp.png';
    % plot(app.outputHist, imhist(uint8(outputImg)));
    % 
    % app.outputImage2.ImageSource = 'tempreverse.png';
    % plot(app.outputHist2, imhist(uint8(reverseOutputImg)));
    % 
    % % Tampilkan semua komponen
    % app.outputHist.Visible = 'on';
    % app.outputImage.Visible = 'on';
    % app.outputImageLabel.Visible = 'on';
    % 
    % app.outputHist2.Visible = 'on';
    % app.outputImage2.Visible = 'on';
    % app.outputImageLabel2.Visible = 'on';
end
