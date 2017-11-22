library(jpeg)
library(imager)

path.image = "C:/Users/Kushin/Desktop/Modelling Project/256x256/photo/tx_000000000000/airplane"
path.sket = "C:/Users/Kushin/Desktop/Modelling Project/256x256/sketch/tx_000000000000/airplane"
folder.image= "256x256/photo/tx_000000000000/airplane/"
folder.sketch="256x256/sketch/tx_000000000000/airplane/"

image.files <- list.files(path = path.image, pattern = "*.jpg") 

image.files

sket.files.1<- list.files(path = path.sket, pattern = "*-1.png")
sket.files.2<- list.files(path = path.sket, pattern = "*-2.png")
sket.files.3<- list.files(path = path.sket, pattern = "*-3.png")
sket.files.4<- list.files(path = path.sket, pattern = "*-4.png")
sket.files.5<- list.files(path = path.sket, pattern = "*-5.png")

single.image<-load.image("256x256/photo/tx_000000000000/airplane/n02691156_507.jpg")
plot(single.image)
single.sketch<-load.image("C:/Users/Kushin/Desktop/Modelling Project/256x256/sketch/tx_000000000000/airplane/n02691156_507-1.png")
plot(single.sketch)

single.sketch<-grayscale(single.sketch)

single.image<-grayscale(single.image)

single.image<-as.matrix(single.image)
single.sketch<-as.matrix(single.sketch)
single.image



image.string<- array(0, c(15,5,256,256,1,1))
for(i in 1:15){
  image.string[i,,,,,]<- grayscale(load.image(paste(folder.image,image.files[i], sep="")))
  
} 
dim(image.string)<- c(dim(image.string)[1]*dim(image.string)[2],256,256,dim(image.string)[5]*dim(image.string)[6])

sketch.string<- array(0,c(15,5,256,256,1))
for(i in 1:15){
  sketch.string[i,1,,,]<-grayscale(load.image(paste(folder.sketch,sket.files.1[i],sep="")))
  sketch.string[i,2,,,]<-grayscale(load.image(paste(folder.sketch,sket.files.2[i],sep="")))
  sketch.string[i,3,,,]<-grayscale(load.image(paste(folder.sketch,sket.files.3[i],sep="")))
  sketch.string[i,4,,,]<-grayscale(load.image(paste(folder.sketch,sket.files.4[i],sep="")))
  sketch.string[i,5,,,]<-grayscale(load.image(paste(folder.sketch,sket.files.5[i],sep="")))
  
}
#dim(image.string)<- c(256,256,dim(image.string)[3]*dim(image.string)[4])
#dim(sketch.string)<- c(256,256,dim(sketch.string)[3]*dim(sketch.string)[4])

#dim(image.string)<- c(dim(image.string)[1]*dim(image.string)[2],dim(image.string)[3]*dim(image.string)[4])
dim(sketch.string)<- c(dim(sketch.string)[1]*dim(sketch.string)[2],dim(sketch.string)[3]*dim(sketch.string)[4]*dim(sketch.string)[5])


plot(as.cimg(image.string[,,70]))
plot(as.cimg(sketch.string[,,70]))





# generate dummy data
x_train <- array(runif(100 * 100 * 100 * 3), dim = c(100, 100, 100, 3))

y_train <- runif(100, min = 0, max = 9) %>% 
  round() %>%
  matrix(nrow = 100, ncol = 1) %>% 
  to_categorical(num_classes = 10)

