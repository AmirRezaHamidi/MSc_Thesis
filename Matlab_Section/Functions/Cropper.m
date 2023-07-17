function Cropped_Image = Cropper(Image)

gray = ones(1, 1, 3) * 240;
Rect_1 = 0;Rect_2 = 0;
Rect_3 = 0;Rect_4 = 0;

%% Horizontal Crop
for i = 1:size(Image, 2)

    if sum(Image(round(size(Image, 1) / 2), i , :) == gray, "all") ~= 3

        Rect_1 = i;
        break
    end
end

for i = size(Image, 2):-1:1

    if sum(Image(round(size(Image, 1) / 2), i , :) == gray, "all") ~= 3

        Rect_3 = i - Rect_1;
        break

    end
end

%% Vertical Crop
for i = 1:size(Image, 1)

    if sum(Image(i, round(size(Image, 2) / 2), :) == gray, "all") ~= 3

        Rect_2 = i;
        break

    end

end

for i = size(Image, 1):-1:1

    if sum(Image(i, round(size(Image, 2) / 2), :) == gray, "all") ~= 3

        Rect_4 = i - Rect_2;
        break

    end

end

Rect = [Rect_1 Rect_2 Rect_3 Rect_4];
Cropped_Image = imcrop(Image, Rect);

end

%% The End :)

