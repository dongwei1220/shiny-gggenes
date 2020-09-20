# shiny-gggenes
This is a shiny implementation deployed with docker of the [gggenes](https://github.com/wilkox/gggenes) R package for drawing gene arrow maps.

# Running using Docker
To run shiny-gggenes on a Cloud please create a Docker image of it using the Dockerfile provided. Once the image is ready it can be run either locally or on a Cloud.

## Building the image
Then go into this folder and build your image, giving it a name by using this command :
```
docker build -t gggenes . 
```

## Starting a container
After you have built the image, you can create a container and run it locally:
```
docker run --rm -p 3838:3838 gggenes
```
Finally, the shiny-gggenes app will be accessible at http://localhost:3838

# Online availability
The shiny-gggenes App is freely available at
> https://dongwei.shinyapps.io/gggenes

or

> https://hiplot.com.cn/advance/gggenes

![image.png](https://upload-images.jianshu.io/upload_images/8723194-d940ed8f2ad849fb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# Support
If you have any questions, or found any bug in the program, please write to us at dongw26@mail2.sysu.edu.cn
