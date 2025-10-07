function contrastStrecth(app, inputImg)
    if size(inputImg, 3) == 1
        img_double = double(inputImg);
        r_min = min(img_double(:));
        r_max = max(img_double(:));
        if r_min == r_max, outputImg = inputImg; return; end
        result = (img_double - r_min) / (r_max - r_min);
        outputImg = im2uint8(result);
    else
        hsv = rgb2hsv(inputImg); % Perbaiki: langsung gunakan data gambar
        V = hsv(:, :, 3);
        v_min = min(V(:));
        v_max = max(V(:));
        if v_min == v_max, outputImg = inputImg; return; end
        V_stretched = (V - v_min) / (v_max - v_min);
        hsv_baru = cat(3, hsv(:,:,1), hsv(:,:,2), V_stretched);
        outputImg = im2uint8(hsv2rgb(hsv_baru));
    end
    
    % --- Update UI ---
    
    app.outputImage.ImageSource = outputImg;
    app.outputImage.Visible = 'on';
    app.outputImageLabel.Visible = 'on';
    app.outputImageLabel.Text = 'Hasil Peregangan Kontras';
    app.plotFourHistograms(outputImg, 'outputHist');

    % Sembunyikan set output kedua jika tidak dipakai
    app.outputImage_2.Visible = 'off';
    app.outputImageLabel_2.Visible = 'off';
    app.outputHist_2G.Visible = 'off';
    app.outputHist_2B.Visible = 'off';
    app.outputHist_2R.Visible = 'off';
    app.outputHist_2Gabungan.Visible = 'off';
end