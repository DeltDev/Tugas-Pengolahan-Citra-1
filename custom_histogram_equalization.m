function eq_img = custom_histogram_equalization(img, counts)
    % ubah ke double untuk perhitungan
    img = double(img);

    % total pixel
    total_pixels = numel(img);

    % hitung PDF (probability density function)
    pdf = counts / total_pixels;

    % hitung CDF (cumulative distribution function)
    cdf = cumsum(pdf);

    % normalisasi cdf agar berada di 0–255
    cdf_min = min(cdf(cdf > 0)); % cdf pertama yang tidak nol
    cdf_normalized = (cdf - cdf_min) / (1 - cdf_min);
    cdf_scaled = round(cdf_normalized * 255);

    % buat citra baru berdasarkan nilai CDF
    eq_img = img;
    [rows, cols] = size(img);
    for r = 1:rows
        for c = 1:cols
            old_val = img(r,c);
            eq_img(r,c) = cdf_scaled(old_val+1);
        end
    end
end
