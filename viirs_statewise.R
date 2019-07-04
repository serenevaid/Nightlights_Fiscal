rm(list=ls())
gc()

# ===========================
library(rgdal)
library(sp)
library(tiff)
library(raster)
library(maps)
library(maptools)
library(rgeos)
# ===========================

# ind <- map(database = "world", regions = "India", plot = F)
# map(databse = "world", regions = "India", project = "albers", par = c(39,45))
# map.grid(ind)

st1 <- readShapeSpatial("/Users/Serene/Desktop/Work/Urbanization/Boundary Files/All India states/AllIndiaStatesV4.shp")
dim(st1)

# f1 <- readGDAL("/Users/Serene/Desktop/Work/Urbanization/VIIRS India/SVDNB_npp_20150101-20151231_75N060E_v10_c201701311200/SVDNB_npp_20150101-20151231_75N060E_vcm_v10_c201701311200.avg_rade9.tif")
# str(f1)
# f2 <- mask(f1, st1)

f2 <- readGDAL("/Users/Serene/Desktop/Work/Urbanization/VIIRS India/India_2015_viirs.tif")
f0 <- raster(f2)

# Extent Computations
# ---------------------
x_min <- extent(f2)[1]
x_max <- extent(f2)[2]
y_min <- extent(f2)[3]
y_max <- extent(f2)[4]
cell_res <- 0.0008333333  # 10 km GRID

# Number of Columns & Rows : Computations
# ---------------------
x_extent <- as.integer((x_max-x_min)/cell_res)
x_extent.1 <- (((x_max-x_min)/cell_res)-as.integer((x_max-x_min)/cell_res))  #Long
y_extent <- as.integer((y_max-y_min)/cell_res)
y_extent.1 <- (((y_max-y_min)/cell_res)-as.integer((y_max-y_min)/cell_res))  #Lat
n_row <- ifelse(y_extent.1>0.5,(y_extent+2),(y_extent+1))    #lat
n_col <- ifelse(x_extent.1>0.5,(x_extent+2),(x_extent+1))    #long

# Empty Raster
# ---------------------
f3 <- raster(nrow=n_row,ncol=n_col)
extent(f3) <- extent(f0)

# Resampling from 750m to 10km
f4 <- resample(f0,f3,method='bilinear')
extent(ras2) <- extent(ras)