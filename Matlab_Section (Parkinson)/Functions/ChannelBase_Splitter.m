function ChannelBase_Splitter(Data, Folder, Seconds)

Fs = 512;
Overall_Data_Size = 0;

for key = string(Data.keys)

    Overall_Data_Size = Overall_Data_Size + size(Data(key), 2);
    
end

Overall_Data = ones(size(Data(key), 1), Overall_Data_Size);
Sample_Numbers = floor(Overall_Data_Size / (Fs * Seconds));
Start = 1;

for key = string(Data.keys)

    End = size(Data(key), 2) + Start - 1;
    Overall_Data(:, Start:End) = Data(key); 
    Start  = End + 1;

end

figure("Position", [350 150 750 500], "Name", "Image")
for i = 0:Sample_Numbers - 1

    k = i + 1;
    Start = (i * (Fs * Seconds) + 1);
    End = (i + 1) * (Fs * Seconds);
    Image = round(Overall_Data(:, Start:End), 4, "decimals");
    Resize_Scale = size(Image);
    image(Image)
    axis off
    colorbar off

    Initial_Image = getframe(gcf).cdata;
    Cropped_Image = Cropper(Initial_Image);
    Image = imresize(Cropped_Image, Resize_Scale);
    Address = Folder + string(k) + ".jpg";
    imwrite(Image, Address)

end

end

