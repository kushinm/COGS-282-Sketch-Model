library(keras)


mnist <- dataset_mnist()
data <- lapply(mnist, function(m){
  m$x= m$x /255
  dim(m$x) = c(dim(m$x)[1], c(28,28,1))
}
)


x_train<-mnist$train$x
x_train<-x_train/255
dim(x_train)<-c(60000,28,28,1)



MNIST<- keras_model_sequential()

MNIST%>%
  layer_conv_2d(filter=16, kernel_size= c(3,3),padding='same', input_shape=c(28,28,1), data_format="channels_last", name ="1")%>%
  layer_activation("relu", name="11")%>%
  layer_average_pooling_2d(pool_size= c(2,2),padding='same')%>%
  layer_conv_2d(filter=8, kernel_size= c(3,3),padding='same',name ="2")%>%
  layer_activation("relu",name="12")%>%
  layer_average_pooling_2d(pool_size= c(2,2),padding='same')%>%
  layer_conv_2d(filter=8, kernel_size= c(3,3),padding='same', name ="3")%>%
  layer_activation("relu", name="13")%>%
  layer_average_pooling_2d(pool_size= c(2,2),padding='same',name="4")%>%
  
  
  layer_conv_2d(filter=8, kernel_size= c(3,3),padding='same',name="5")%>%
  layer_activation("relu", name="14")%>%
  layer_upsampling_2d(size =c(2,2))%>%
  layer_conv_2d(filter=8, kernel_size= c(3,3),name="6", padding="same")%>%
  layer_activation("relu",name="15")%>%
  layer_upsampling_2d(size=c(2,2))%>%
  layer_conv_2d(filter=16, kernel_size= c(3,3),name="7")%>%
  layer_activation("relu", name="16")%>%
  layer_upsampling_2d(size =c(2,2))%>%
  layer_conv_2d(filter=1,kernel_size=c(3,3), padding= 'same',name="8")%>%
  layer_activation("sigmoid", name="17")

MNIST%>%compile(
  optimizer = 'adadelta',
  loss = 'binary_crossentropy')

MNIST%>%fit(x_train, x_train, epochs = 2, batch_size = 32)

library(ggplot2)
library(dplyr)

  
  