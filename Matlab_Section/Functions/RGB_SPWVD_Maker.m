function RGB_SPWVD_Maker(Data, Raw_Directory, Type, Image_Size)

arguments

    Data
    Raw_Directory string
    Type string
    Image_Size

end

SubjectWise_Directory = Raw_Directory + "SubjectWise\" + Type + "\";
AllSubject_Directory = Raw_Directory + "AllSubjects\" + Type + "\";

Make_Sure(SubjectWise_Directory)
Make_Sure(AllSubject_Directory)

All_Subjects_Samples = ones(1, length(Data) + 1 );
Previous_Samples = 1;

for i = 1:length(Data)

    All_Subjects_Samples(i + 1) = size(Data(i).Values, 1) + Previous_Samples;
    Previous_Samples = Previous_Samples + size(Data(i).Values, 1);

end
Total_Samples = All_Subjects_Samples(end) - 1;
disp("The Number of All Samples for All Subject is Equal")
disp(Total_Samples)

Time_window = kaiser(31, 5);
Frequency_Window = kaiser(63, 5);
Number_of_Digits = string(numel(num2str(Total_Samples)));
Format_String = "%0" + Number_of_Digits + ".0f";

figure("Position", [350 150 750 500], "Name", "Image")

for i = 1:length(Data)

    Current_Data = Data(i).Values;
    Number_of_Samples = size(Current_Data, 1);
    Sample_Length = size(Current_Data, 3);
    Resize_Scale = Image_Size(1:2);
    Depth = Image_Size(3);
    Mold = zeros([Sample_Length, Sample_Length * 2, Image_Size(3)]);
    
    Sample_Index = All_Subjects_Samples(i);
    Subject_Number = num2str(i, "%02.0f");
    Subjet_Directory = SubjectWise_Directory + "S_" + Subject_Number + "\";
    Make_Sure(Subjet_Directory)

    for j = 1:Number_of_Samples

        for k = 1:Depth

            Signal = reshape(Current_Data(j, k, :), [1, Sample_Length]);
            Mold(:, : , k) = ...
                wvd(Signal, "smoothedPseudo", Time_window, Frequency_Window);

        end

        image(Mold)
        axis off

        Initial_Image = getframe(gcf).cdata;
        Cropped_Image = Cropper(Initial_Image);
        Image = imresize(Cropped_Image, Resize_Scale);

        Sample_Number = num2str(Sample_Index, Format_String);

        SubjectWise_Address = Subjet_Directory + Sample_Number + ".jpg";
        AllSubject_Address = AllSubject_Directory + Sample_Number + ".jpg";

        imwrite(Image, SubjectWise_Address)
        imwrite(Image, AllSubject_Address)

        Sample_Index = Sample_Index + 1;

    end

end

close Image

end

%% The End :)