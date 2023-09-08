### Cargamos la multilibrería "tidyverse" que contine los paquetes que necesitaremos

library(tidyverse)



### Guardamos en una variable la URL del archivo que contiene los datos y cargamos estos en R 

githubURL <- ("https://raw.githubusercontent.com/Curso-programacion/Tarea_1/master/Protected_Areas.rds")
download.file(githubURL, "PA.rds", method = "curl")
PA <- readRDS("PA.rds")



### Empezamos a graficar con ggplot2

p <- ggplot(PA, aes(x = STATUS_YR, y = TERR_AREA)) + 
  geom_point(aes(color=DESIG)) + 
  theme_classic()

p



#### Probamos con otra base de datos por ejemplo "diamonds" para poner de manifiesto la funcion "alpha"

data("diamonds")
view(diamonds)

ggplot (diamonds, aes(x= carat, y= price))+
  geom_point(aes(color=cut),alpha=.2)



### Arreglamos un poco la gráfica p

## Antes modificamos el data.frame para añadir la nueva variable al eje y

PA <- readRDS("PA.rds") %>% mutate(LogArea=log(TERR_AREA))

str(PA) # Comprobamos que se ha añadido la nueva columna

c <- ggplot(PA, aes(x = STATUS_YR, y = LogArea)) + 
  geom_point(aes(color=DESIG)) + 
  theme_bw()
c

## Se puede hacer de una manera que visualmente es mejor y dentro del propio ggplot2; con la orden scale y scales

d <- ggplot(PA, aes(x = STATUS_YR, y = TERR_AREA)) + 
  geom_point(aes(color=DESIG)) + 
  theme_bw() +
  scale_y_continuous(labels=scales::comma)
d

## Vamos a hacer otra transformación del eje Y. Esta vez vamos a hacerle una transformación logarítmica.

e <- ggplot(PA, aes(x = STATUS_YR, y = TERR_AREA)) + 
  geom_point(aes(color=DESIG)) + 
  theme_bw() +
  scale_y_log10(labels=scales::comma) +  # Aquí hacemos la transformacion
  labs(x= "Año", y="Área en hectáreas", title="Áreas protegidas de Chile", subtitle="Prácticas con 'ggplo2'")
e



### Tamaño de puntos con otra base de datos


data("mtcars")

f <- ggplot(data=mtcars, aes(x=wt, y=mpg)) +
  geom_point(aes(size=hp), color="blue")


f

### Aqui agrupamos por IUNC_CAT mediante simbolos y los coloreamos


g <- ggplot(PA, aes(x = STATUS_YR, y = TERR_AREA)) + 
  geom_point(aes(shape=IUCN_CAT, color=IUCN_CAT)) + 
  theme_bw() +
  scale_y_log10(labels=scales::comma) +  
  labs(x= "Año", y="Área en hectáreas", title="Áreas protegidas de Chile", subtitle="Prácticas con 'ggplo2'")
g


## Tambien podríamos agrupar por otra columna

h <- ggplot(PA, aes(x = STATUS_YR, y = TERR_AREA)) + 
  geom_point(aes(shape=IUCN_CAT, color=DESIG)) + 
  theme_bw() +
  scale_y_log10(labels=scales::comma) +  
  labs(x= "Año", y="Área en hectáreas", title="Áreas protegidas de Chile", subtitle="Prácticas con 'ggplo2'")
h



### Probamos con la función "fill" y cambiamos de base de datos para hacerlo más evidente

data("iris")
view(iris)

i <- ggplot(data=iris, aes(x= Species, y= Sepal.Length)) +
  geom_boxplot(aes(fill=Species)) +
  # geom_point(aes(color=Species), color="black", alpha=.3)
  # scale_fill_viridis_d()
  # scale_fill_manual(values=c("red", "black", "green"))
  scale_fill_manual(values = c('#f7fcb9','#addd8e','#31a354'))
i
  
  
### Otras formas de presentación "jitter", "violin", ...


j <- ggplot(data=iris, aes(x= Species, y= Sepal.Length)) +
  geom_jitter(aes(color=Species)) +
  scale_color_manual(values = c('#f7fcb9','#addd8e','#31a354'))
j
  
j <- ggplot(data=iris, aes(x= Species, y= Sepal.Length)) +
  geom_violin(aes(fill=Species, color=Species)) +
  geom_jitter(aes(color=Species), color="black") +
  scale_fill_manual(values = c('#f7fcb9','#addd8e','#31a354')) +
  scale_color_manual(values = c('#f7fcb9','#addd8e','#31a354'))
j

### Trabajamos con un conjunto de datos, para ver que "violin" es como un histograma vertical, 
### la función ".fun" nos dice por que funcion ordenamos

Setosa <-  iris %>% dplyr::filter(Species=="setosa")

ggplot(data=Setosa, aes(y= Sepal.Length))+
  geom_density()


### Reordenar una variable

ggplot(iris, aes(x= fct_reorder(Species, Sepal.Width), y= Sepal.Width))+
  geom_boxplot(aes(fill=Species), notch=T)+
  theme_bw()

ggplot(PA, aes(x= fct_reorder(IUCN_CAT, TERR_AREA, .fun = max), y= TERR_AREA))+
  geom_boxplot(aes(fill=IUCN_CAT), notch=TRUE)+
  theme_bw()+
  scale_y_log10(labels=scales::comma, breaks= c(1, 10, 100, 1000, 10000, 1000000))






