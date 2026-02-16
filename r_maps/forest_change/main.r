#############################################
# Mapping deforestation height with R
# From Milos Popovic 2024/09/09
#############################################

# 1. Install helper packages (only if missing)
if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")

# 2. Install CRAN dependencies for rgeoboundaries
cran_packages <- c("hoardr", "crul", "jsonlite", "dplyr", "purrr", "stringr", 
                   "terra", "sf", "tidyverse", "tidyterra")

pacman::p_load(char = cran_packages, install = TRUE)
# 3. Install GitHub packages with better error handling
try(remotes::install_github("wmgeolab/rgeoboundaries", force = FALSE))
try(remotes::install_github("riatelab/maptiles", force = FALSE))

# 4. Load everything with pacman
pacman::p_load(
  rgeoboundaries,
  maptiles,
  terra,
  sf,
  tidyverse,
  tidyterra,
  install = FALSE
)

# Install and load packages (terra = raster files, sf = polygons, tidyverse = visualization, tidyterra = map rasters without turning to data frame)

# 1. COUNTRY SF (Fetch polygon for AOI)
#--------------

region_sf <- rgeoboundaries::gb_adm1(
    country = "ESP"
) |>
    dplyr::filter(
        grepl(
            "Galicia", shapeName
        )
    )

plot(sf::st_geometry(region_sf))

# 2. FOREST DATA
#---------------

variable <- c(
    "treecover2000", "lossyear"
)

urls <- paste0(
    "https://storage.googleapis.com/earthenginepartners-hansen/GFC-2023-v1.11/Hansen_GFC-2023-v1.11_",
    variable,
    "_50N_010W.tif"
)

forest_data <- lapply(
    urls, terra::rast
)

# 3. CROP DATA
#-------------

forest_region <- lapply(
    forest_data,
    function(x) {
        terra::crop(
            x,
            terra::vect(region_sf)
        )
    }
)

terra::plot(
    forest_region[[1]]
)

# 4. DEFORESTATION YEARS TO BINARY VALUE
#---------------------------------------

breaks <- c(
    0, 1, 23
)

forest_loss_region <- terra::classify(
    forest_region[[2]],
    rcl = breaks
)

forest_loss_region <- as.factor(
    forest_loss_region
)

terra::plot(
    forest_loss_region
)

# 5. FOREST COVER
#----------------

forest_cover_region <- terra::ifel(
    forest_region[[1]] > 0,
    1,
    NA
)

pal <- c(
    "#575E43",
    # "#ffff00",
    "#fe2200"
)

cols <- pal[[1]]

from <- 1
to <- t(
    col2rgb(
        cols
    )
)

forest_cover_region <- na.omit(
    forest_cover_region
)

forest_cover_col <- terra::subst(
    forest_cover_region,
    from = from,
    to = to,
    names = cols
)

terra::plotRGB(
    forest_cover_col
)

# 6. BACKGROUND MAP
#------------------

bbox <- sf::st_bbox(
    region_sf
)

bg_map <- maptiles::get_tiles(
    x = bbox,
    provider = "Esri.NatGeoWorldMap",
    zoom = 10,
    crop = TRUE,
    project = FALSE
)

# 7. FOREST LOSS AREA
#--------------------

cell_areas_forest <- terra::cellSize(
    x = forest_cover_region,
    unit = "ha"
)

forest_cover_region_zonal <- terra::zonal(
    cell_areas_forest,
    forest_cover_region,
    fun = "sum"
)

cell_areas_deforest <- terra::cellSize(
    x = forest_loss_region,
    unit = "ha"
)

forest_loss_region_zonal <- terra::zonal(
    cell_areas_deforest,
    forest_loss_region,
    fun = "sum"
)

# 8. MAP
#-------

proj <- "EPSG:3857"

map <- ggplot() +
    tidyterra::geom_spatraster_rgb(
        data = bg_map,
        maxcell = terra::ncell(
            bg_map
        ),
        alpha = 1
    ) +
    tidyterra::geom_spatraster_rgb(
        data = forest_cover_col,
        maxcell = terra::ncell(
            bg_map
        ),
        alpha = .85
    ) +
    tidyterra::geom_spatraster(
        data = as.factor(
            forest_loss_region
        ),
        maxcell = terra::ncell(
            bg_map
        ),
        alpha = .85
    ) +
    coord_sf(crs = proj) +
    scale_fill_manual(
        name = "",
        labels = c(
            "Forest cover in 2000",
            # "Forest loss (2001-2012)",
            "Forest loss (2013-2023)"
        ),
        values = pal,
        na.translate = FALSE
    ) +
    theme_void() +
    theme(
        legend.position = c(.2, .9), # should be .9
        plot.margin = unit(
            c(
                t = -1, b = -1,
                l = -1, r = -1
            ), "cm"
        )
    )
