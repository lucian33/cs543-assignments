% clear everything
close all;
clearvars;

is_normalized = 1;
is_putative_match = 1; % set to 0 to use ground truth matches

%%
%% load images and match files for the first example
%%

I1 = imread('./assignment3_part2_data/house1.jpg');
I2 = imread('./assignment3_part2_data/house2.jpg');

if is_putative_match
    img_left = im2double(rgb2gray(I1));
    img_right = im2double(rgb2gray(I2));
    top_pairs = get_top_pairs(img_left, img_right);
    draw_top_pairs(img_left, top_pairs(:, 1:2));
    draw_top_pairs(img_right, top_pairs(:, 3:4));
    
    matches = zeros(size(top_pairs));
    matches(:, 1) = top_pairs(:, 2);
    matches(:, 2) = top_pairs(:, 1);
    matches(:, 3) = top_pairs(:, 4);
    matches(:, 4) = top_pairs(:, 3);
else
    matches = load('./assignment3_part2_data/house_matches.txt');
end
% this is a N x 4 file where the first two numbers of each row
% are coordinates of corners in the first image and the last two
% are coordinates of corresponding corners in the second image: 
% matches(i,1:2) is a point in the first image
% matches(i,3:4) is a corresponding point in the second image

N = size(matches,1);

%%
%% display two images side-by-side with matches
%% this code is to help you visualize the matches, you don't need
%% to use it to produce the results for the assignment
%%
figure; imshow([I1 I2]); hold on;
plot(matches(:,1), matches(:,2), '+r');
plot(matches(:,3)+size(I1,2), matches(:,4), '+r');
line([matches(:,1) matches(:,3) + size(I1,2)]', matches(:,[2 4])', 'Color', 'r');
% pause;

%%
%% display second image with epipolar lines reprojected 
%% from the first image
%%

% first, fit fundamental matrix to the matches
if is_putative_match
    F = ransac_part2(matches);
    
    % Report the number of inliers and the average residual for the inliers
    [num_inliner, inliner_pairs, avg_residual] = count_inliner_part2(matches, F);
    display(num_inliner)
    display(avg_residual)
    r_left = inliner_pairs(:, 1);
    c_left = inliner_pairs(:, 2);

    figure, imagesc(img_left), axis image, colormap(gray), hold on
    plot(r_left, c_left,'gs'), title('inliners');
else
    F = fit_fundamental(matches, is_normalized);
end

L = get_epipolar_line(F, matches);

[closest_pt, L] = get_closest_pt(L, matches);

display_residual(closest_pt, L, matches, I2);

%%
%% Display the two camera centers and reconstructed points in 3D
%% 

P1 = load('./assignment3_part2_data/house1_camera.txt');
P2 = load('./assignment3_part2_data/house2_camera.txt');

x1 = transpose(matches(:, 1:2));
x2 = transpose(matches(:, 3:4));
x_world = triangulate(x1, x2, P1, P2);

figure; axis equal; hold on;
plot3(x_world(2, :), x_world(1, :), x_world(3, :), 'o');

R1 = P1(:, 1:3);
R2 = P2(:, 1:3);

t1 = P1(:, 4);
t2 = P2(:, 4);

center1 = -inv(R1) * t1;
center2 = -inv(R2) * t2;
plot3(center1(2), center1(1), center1(3), 'rx');
plot3(center2(2), center2(1), center2(3), 'gx');
