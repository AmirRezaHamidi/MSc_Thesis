function SPWVD_Forger(Data, Folder, Image_Size, Subject_Wise)

Time_window = kaiser(31, 5);
Frequency_Window = kaiser(63, 5);

Number_of_Samples = size(Data, 1);
Sample_Length = size(Data, 3);
Depth = Image_Size(3); 

Mold = zeros([Sample_Length, Sample_Length * 2, Image_Size(3)]);
Resize_Scale = Image_Size(1:2);

figure("Position", [350 150 750 500], "Name", "Image")
Number_of_Digits = string(numel(num2str(size(Data,1))));
Format_String = "%0" + Number_of_Digits + ".0f";



if Subject_Wise
    
    % SubjectWise
    for i = 1:Number_of_Samples

        for j = 1:Depth

            Signal = reshape(Data(i, j, :), [1, Sample_Length]);
            Mold(:, : , j) = wvd(Signal, ...
                "smoothedPseudo", Time_window, Frequency_Window);

        end

        image(Mold)
        axis off

        Initial_Image = getframe(gcf).cdata;
        Cropped_Image = Cropper(Initial_Image);
        Image = imresize(Cropped_Image, Resize_Scale);
        
        Subject_Counter = floor((i-1)/240) + 1;
        Sample_Number = num2str(i, Format_String);

        Address = Folder + "P_" + num2str(Subject_Counter, "%02.0f") +...
            "\" + Sample_Number + ".jpg";
        disp(Sample_Number)
        imwrite(Image, Address)

    end

else
    
    % Overall
    for i = 1:Number_of_Samples
        
        for j = 1:Depth

            Signal = reshape(Data(i, j, :), [1, Sample_Length]);
            Mold(:, : , j) = wvd(Signal, "smoothedPseudo", ...
                Time_window, Frequency_Window);

        end
        
        image(Mold)
        axis off
        
        Initial_Image = getframe(gcf).cdata;
        Cropped_Image = Cropper(Initial_Image);
        Image = imresize(Cropped_Image, Resize_Scale);
        
        Sample_Number = num2str(i, Format_String);
        Address = Folder + Sample_Number + ".jpg";
        
        imwrite(Image, Address)
        
    end
    
end

close Image

end

%% The End :)