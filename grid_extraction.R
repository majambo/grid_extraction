ocean = rast('~/Documents/connectivity-modeling-system-master-2/cms-master/expt/expt_example/nests/nest_1_20100101000000.nc')
zu = ocean$`zu_Depth=0_Time=87672`

# Get the dimensions of the raster layer
rows <- nrow(zu)
cols <- ncol(zu)

# Define the extent of the raster layer
ext <- ext(zu)

# Define the resolution of the raster layer
res <- res(zu)

# Create an empty list to store polygons
grid_polygons <- vector(mode="list", length=rows*cols)

# Loop through each grid cell and create a polygon
k <- 1
for (i in 1:rows) {
  for (j in 1:cols) {
    xmin <- xmin(ext) + (j-1) * res[1]
    xmax <- xmin(ext) + j * res[1]
    ymin <- ymax(ext) - i * res[2]
    ymax <- ymax(ext) - (i-1) * res[2]
    poly <- rbind(c(xmin, ymin), c(xmax, ymin), c(xmax, ymax), c(xmin, ymax), c(xmin, ymin))
    grid_polygons[[k]] <- Polygons(list(Polygon(poly)), ID = as.character(k))
    k <- k + 1
  }
}

# Create a spatial polygons object
sp_polygons <- SpatialPolygons(grid_polygons)


shapefile(sp_polygons, "~/Documents/connectivity-modeling-system-master-2/grid_polygons.shp")

