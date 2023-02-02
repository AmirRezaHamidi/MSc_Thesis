averages = zeros(22,3);
N = 1;
first = 0;
second = 0;

for i=1:22

    a = Processed_PR(i).Values(:, end - 256*60*N + 1:end);
    
    averages(i, 1) = sum(a,"all")/1e4;
    
    b = Processed_PR(i).Values(:, end - 256*60*2*N + 1:end - 256*60*N);
    
    averages(i, 2) = sum(b, "all")/1e4;
    
    [g , averages(i, 3)] = max(averages(i,:));

end

for i = 1:22

    if averages(i, 3) == 2

        first = first+ 1;
    else

        second = second + 1;
    end

end

first
second
