function Forger(Data, Folder, Image_Size)

Time_window = kaiser(31, 5);
Frequency_Window = kaiser(63, 5);
TFR = containers.Map;

for i = 1:Image_Size(3)

    TFR(string(i)) = 1;

end

Resize_Scale = Image_Size(1:2);
figure("Position", [350 150 750 500], "Name", "Image")

for i = 1:size(Data, 1)

    for j = 1:Image_Size(3)

        signal = reshape(Data(i, j, :), [1, size(Data, 3)]);
        TFR(string(j)) = wvd(signal, "smoothedPseudo", ...
            Time_window, Frequency_Window);

    end

    Temp_Image = ones([size(TFR("1")), Image_Size(3)]);

    for j = 1:Image_Size(3)

        Temp_Image(:, : , j) = TFR(string(j));

    end

    image(Temp_Image)
    axis off
    colorbar off

    Initial_Image = getframe(gcf).cdata;
    Cropped_Image = Cropper(Initial_Image);
    Image = imresize(Cropped_Image, Resize_Scale);
    Address = Folder + string(i) + ".jpg";
    imwrite(Image, Address)

end

close Image

end

%% The End :)