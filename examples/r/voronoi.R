# Look at the vignette
vignette("ggvoronoi", package="ggvoronoi")

# 100 random points
x <- sample(1:200,100)
y <- sample(1:200,100)

# 20 random names
names <- paste("name", 1:20, sep='_')

# Set points data frame
n <- names[sample(rep(1:20, 5), 100)]
points <- data.frame(x, y, name=n)

# Draw
ggplot2::ggplot(points) + ggvoronoi::geom_voronoi(ggplot2::aes(x=x,y=y,fill=name))
