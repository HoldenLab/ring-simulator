function im= generateGaussPSFIm(pos,sigmaPSF,imSize)

a(1) = 1;
a(2) = sigmaPSF;%width
a(3) = pos(1);%xpos
a(4) = pos(2);%ypos

im = zeros(imSize,imSize);
sizex= size(im,2);
sizey= size(im,1);

[X,Y]= meshgrid(1:sizex,1:sizey);
grid = [X Y];

im = a(1)*exp(    -((X-a(3)).^2/(2*a(2)^2)+(Y-a(4)).^2/(2*a(2)^2))   );


