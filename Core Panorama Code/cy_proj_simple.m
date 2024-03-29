%This function takes in the raw image and the camera parameters and 
% creates the cylindrical projection which is then input to the SIFT
% matcher
%--------------------------------------------------------------------------
%   Modifiers: Anmol Mohanty
%   CS 766 - Assignment 2 | Panorama
%--------------------------------------------------------------------------
function out = cy_proj_simple(image, f, k1, k2)

ydim=size(image, 1);
xdim=size(image, 2);

xc=xdim/2;
yc=ydim/2;

% Standard affair for creating the cylindrical projection from 3D scene
for y=1:ydim
    for x=1:xdim
        theta = (x - xc)/f;
        h = (y - yc)/f;
        xcap = sin(theta);
        ycap = h;
        zcap = cos(theta);
        xn = xcap / zcap;
        yn = ycap / zcap;
        r = xn^2 + yn^2;
        
        xd = xn * (1 + k1 * r + k2 * r^2);
        yd = yn * (1 + k1 * r + k2 * r^2);
        
        ximg = floor(f * xd + xc);
        yimg = floor(f * yd + yc);
        
        if (ximg > 0 && ximg <= xdim && yimg > 0 && yimg <= ydim)
            out(y, x, :) = [image(yimg, ximg, 1) image(yimg, ximg, 2) image(yimg, ximg, 3)];
        end
                               
    end
end