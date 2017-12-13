
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
  layer_conv_2d(filter = 256, kernel_size= c(3,3),padding='same',
  input_shape =c(256,256,1),name='conv1')%>%
  layer_activation("relu")%>%
  layer_average_pooling_2d(pool_size = c(2,2))%>%
  layer_conv_2d(filter= 256, kernel_size = c(3,3), padding='same',name='conv2')%>%
  layer_activation("relu")%>%
  layer_average_pooling_2d(pool_size = c(2,2)) %>%
  layer_conv_2d(filter = 128, kernel_size = c(3,3), padding='same', name='conv3') %>%
  layer_activation("relu") %>%
  layer_average_pooling_2d(pool_size = c(2,2)) %>%
  layer_conv_2d(filter=64, kernel_size = c(3,3), padding = 'same', name='conv4') %>%
  layer_activation("relu") %>%
  layer_average_pooling_2d(pool_size= c(2,2))%>%
  #convolution complete
  layer_upsampling_2d(size=2)%>%
  layer_conv_2d(filter =64, kernel_size = c(3,3), padding = 'same', name='deconv1')%>%
  layer_activation("relu")%>%
  layer_upsampling_2d(size=2)%>%
  layer_conv_2d(filter =128, kernel_size = c(3,3), padding = 'same',name='deconv2')%>%
  layer_activation("relu")%>%
  layer_upsampling_2d(size=2)%>%
  layer_conv_2d(filter =256, kernel_size = c(3,3), padding = 'same', name='deconv3')%>%
  layer_activation("relu")%>%
  layer_upsampling_2d(size=2)%>%
  layer_conv_2d(filter =256, kernel_size = c(3,3), padding = 'same', name='deconv4')%>%
  layer_conv_2d(filter=1, kernel_size=c(3,3), padding = 'same', name='output')


opt<-optimizer_rmsprop(lr = 0.001, rho = 0.9, epsilon = 1e-08, decay = 0,
                       clipnorm = NULL, clipvalue = NULL)

test.1 %>% compile(
  optimizer = opt,
  loss = 'categorical_crossentropy',
  metrics = c('accuracy')
)

test.1%>% fit(image.string,sketch.string, epochs=5, batch_size=32)

get_weights(test.1)
