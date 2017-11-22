
#implementation()
#keras:::keras_version()
#backend()$backend()

#tensorflow::tf_config()

install_tensorflow(conda="tf-keras", require=T)


library(tensorflow)
library(keras)
use_condaenv('tf-keras', required = T)



model<-keras_model_sequential()

model%>%
  layer_dense(units=256, activation='relu', input_shape= c(784))


summary(model)

data <- dataset_mnist()
#-------------------------------#

#model

test.1<-keras_model_sequential()
  test.1%>%
    layer_conv_2d(
      filter = 256, kernel_size= c(3,3),padding='same',
      input_shape =c(256,256,1))%>%
    layer_activation("relu")%>%
    layer_conv_2d(
      filter= 256, kernel_size = c(3,3))%>%
      layer_activation("relu")%>%
        layer_max_pooling_2d(pool_size = c(2,2)) %>%
        layer_dropout(0.25) %>%
        layer_conv_2d(filter = 256, kernel_size = c(3,3)) %>%
        layer_activation("relu") %>%
        layer_conv_2d(filter = 150, kernel_size = c(3,3)) %>%
        layer_activation("relu") %>%
        layer_max_pooling_2d(pool_size = c(2,2)) %>%
        layer_dropout(0.25) %>%
        layer_flatten() %>%  
        layer_dense(512) %>%  
        layer_activation("relu") %>%
        layer_dropout(0.5) %>%
        layer_dense(65536)%>%
        layer_activation("relu")
    
  
  
  
  opt<-optimizer_rmsprop(lr = 0.001, rho = 0.9, epsilon = 1e-08, decay = 0,
                         clipnorm = NULL, clipvalue = NULL)
  
  test.1 %>% compile(
    optimizer = opt,
    loss = 'categorical_crossentropy',
    metrics = c('accuracy')
  )

  test.1%>% fit(image.string,sketch.string, epochs=5, batch_size=32)
    