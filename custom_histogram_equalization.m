function eq_img = custom_histogram_equalization(app,img)
    % ubah ke double untuk perhitungan
    img = double(img);
    
    % total pixel
    total_pixels = numel(img);
    
    % hitung PDF (probability density function)
    pdf = custom_image_histogram(img) / total_pixels;
    
    % hitung CDF (cumulative distribution function)
    cdf = cumsum(pdf);
    
    % normalisasi CDF ke rentang 0–255 (TANPA mengurangi cdf_min)
    cdf_scaled = round(cdf * 255);
    
    % buat citra baru berdasarkan nilai CDF
    eq_img = img;
    [rows, cols] = size(img);
    for r = 1:rows
        for c = 1:cols
            old_val = img(r,c);
            eq_img(r,c) = cdf_scaled(old_val+1);
        end
    end
    
        % --- Update UI ---
    app.outputImage.ImageSource = eq_img;
    app.outputImage.Visible = 'on';
    app.outputImageLabel.Visible = 'on';
    app.outputImageLabel.Text = 'Hasil equalisasi histogram';
    app.plotFourHistograms(eq_img, 'outputHist');

    app.outputImage_2.Visible = 'off';
    app.outputImageLabel_2.Visible = 'off';
    app.outputHist_2G.Visible = 'off';
    app.outputHist_2B.Visible = 'off';
    app.outputHist_2R.Visible = 'off';
    app.outputHist_2Gabungan.Visible = 'off';

end