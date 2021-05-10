# ImageProcecssing-DeNoise-FillBlank
* 先将图像去噪之后再用于填补另一张图片的空缺.比较泛用的一个算法
* 起始图像是img1,img2. 原图是Penguins.jpg. 结果图保存在Result.jpg.  
* 去噪函数用的是BM3D,下载地址：https://github.com/glemaitre/BM3D  
* 这是山东大学控制学院图像处理课（2021）的一次作业。授课老师是Ran.Song  
  <br/>
--------------------------
补充原作业要求：   
First detect the pixels corresponding to the missing areas in img1.jpg.  
Second, resize img2.jpg to the same size as img1.jpg and then remove the noise as much as possible within it.   
Third, replace the detected missing areas in img1.jpg with the corresponding areas in the updated img2.jpg to create the recovered image.   
Optionally, do something to make sure that the replacement is seamless.   
Finally, compute the similarity between the recovered image and Penguins.jpg to check if it is a good recovery.
