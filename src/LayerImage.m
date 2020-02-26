function [OutputImage] = LayerImage(Layer1, Layer2)

[height, width] = size(Layer1);

OutputImage = Layer2;

for y = 1:height
    for x = 1:width
        if Layer1 (y,x) > 0
            OutputImage(y,x,3) = 0;
            OutputImage(y,x,2) = 0;
            OutputImage(y,x,1) = 255;
        end
    end
end

end

