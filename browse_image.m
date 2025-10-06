function img = browse_image()
    % input citra lewat browse file 
    [file, path] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg'}, 'Pilih citra'); 
    %periksa apakah ada gambar yang dipilih 
    if isequal(file,0) 
        disp('Tidak ada file dipilih.');
        img = [];
        return; 
    end

    % baca citra dan ubah jadi matriks
    img = imread(fullfile(path, file));

end