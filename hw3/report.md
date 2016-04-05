# CS 543 Assignment 3
# Chia-Hao Hsieh (chsieh17)

1. Homography estimation:
   1. Describe your solution, including any interesting parameters or implementation choices for feature extraction, putative matching, RANSAC, etc.

      I use the given harris detector code as neighbor descriptor. Its parameters are set as: 
      ```Matlab
      [~, ~, ~] = harris(img_left, 3, 0.005, 1, 0);
      ```
      The size of neighborhood is 15 pixel x 15 pixel. 
      If deteced points are too close to the edges of images, they are removed. 
      
      For RANSAC, I run it about 1500 times with randomly-chosen 4 pairs of points. 
   
   2. For the uttower pair provided, report the number of homography inliers and the average residual for the inliers (squared distance between the point coordinates in one image and the transformed coordinates of the matching point in the other image). Also, display the locations of inlier matches in both images.
    
        ```Matlab
        size(top_pairs, 1) = 160
        num_inliners = 123
        avg_residual = 2.7722
        ```
        Here are the inliners: 
        ![left_inliners]
        ![transformed_inliners]

    [left_inliners]: https://raw.githubusercontent.com/chplushsieh/cs543-assignments/master/hw3/part1outputs/left_inliners.png

    [transformed_inliners]: https://raw.githubusercontent.com/chplushsieh/cs543-assignments/master/hw3/part1outputs/transformed_inliners.png

   3. Display the final result of your stitching.

        Here are the merged image: 
        ![merged]

    [merged]: https://raw.githubusercontent.com/chplushsieh/cs543-assignments/master/hw3/part1outputs/merged.png

2. Fundamental matrix estimation:
   1. For both image pairs, for both unnormalized and normalized estimation using ground truth matches, display your result and report your residual. 
   
        ```Matlab
        % For normalized estimation for house: 
        avg_residual = 
        ```
        Here are the result: 
        ![merged]
        ```Matlab
        % For normalized estimation for library: 
        avg_residual = 
        ```
        Here are the result: 
        ![merged]
        ```Matlab
        % For unnormalized estimation for house: 
        avg_residual = 
        ```
        Here are the result: 
        ![merged]
        ```Matlab
        % For unnormalized estimation for library: 
        avg_residual = 
        ```
        Here are the result: 
        ![merged]
    
   2. For both image pairs, for normalized estimation without ground truth matches, display your result and report your number of inliers and residual for inliers. 
        
        ```Matlab
        % For house without ground truth matches:
        num_inliner = 
        avg_residual = 
        ```
        Here are the result: 
        ![merged]
        ```Matlab
        % For house without ground truth matches:
        num_inliner = 
        avg_residual = 
        ```
        Here are the result: 
        ![merged]
   3. For both image pairs, visualize 3D camera centers and triangulated 3D points.
        
        See Youtube video here for house:
        <https://youtu.be/YAIOC05xYas>
        
        See Youtube video here for library:
        <https://youtu.be/5Ct0F5gd-S0>

