% custom_image_histogram - fungsi untuk mengubah matriks gambar menjadi histogram
function counts = custom_image_histogram(img)
    % buat semua ke double
    img = double(img);

    % ubah ke [0,255] dari range [0,1]
    if max(img(:)) <= 1
        img = img * 255;
    end

    % clamp semua nilai agar pasti dalam rentang [0,255]
    img(img < 0) = 0;
    img(img > 255) = 255;

    % bulatkan nilai ke integer terdekat
    img = round(img);

    counts = zeros(256,1);

    % hitung histogram manual
    [rows, cols] = size(img);
    for r = 1:rows
        for c = 1:cols
            value = img(r,c);
            counts(value+1) = counts(value+1) + 1;
        end
    end
end
