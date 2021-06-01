img=imread('5.jpg');
img1=oilpainting(img,11);
imwrite(img1,'5_oilpainting.jpg');

img0=imread('7.jpg');
img2=sketch_processing_better(img0,16,8,0.06,0.37,0.57);
imwrite(img2,'7_sketch_processing_better.jpg');

img3=sketch_processing('4.jpg');
imwrite(img3,'4_sketch_processing.jpg');

