function SPWVD_Forger(Data, Folder, Image_Size)

Time_window = kaiser(31, 5);
Frequency_Window = kaiser(63, 5);

Mold_Image = zeros([size(Data, 3), size(Data, 3) * 2, Image_Size(3)]);
Resize_Scale = Image_Size(1:2);

figure("Position", [350 150 750 500], "Name", "Image")

for i = 1:size(Data, 1)
    
    Subject_Counter = floor((i-1)/240) + 1;
        
    for j = 1:Image_Size(3)
        
        Signal = reshape(Data(i, j, :), [1, size(Data, 3)]);
        Mold_Image(:, : , j) = wvd(Signal, "smoothedPseudo", ...
                                   Time_window, Frequency_Window);
        
    end

    image(Mold_Image)
    axis off

    Initial_Image = getframe(gcf).cdata;
    Cropped_Image = Cropper(Initial_Image);
    Image = imresize(Cropped_Image, Resize_Scale);
    Address = Folder + "P_" + num2str(Subject_Counter, "%02.0f") + "\" ... 
          + string(i) + ".jpg";
    imwrite(Image, Address)

end

close Image

end

%% The End :)