![.github/workflows/main.yml](https://github.com/odahu/odahu-rstudio/workflows/.github/workflows/main.yml/badge.svg?branch=develop&event=push&text=build)

![RStudio Version](https://img.shields.io/badge/dynamic/yaml?label=RStudio%20Version&query=%24.jobs[%22build-docker-image%22].env.RSTUDIO_VERSION&url=https%3A%2F%2Fraw.githubusercontent.com%2Fodahu%2Fodahu-rstudio%2Fdevelop%2F.github%2Fworkflows%2Fmain.yml)

![R Version](https://img.shields.io/badge/dynamic/yaml?label=R%20Version&query=%24.jobs[%22build-docker-image%22].env.R_VERSION&url=https%3A%2F%2Fraw.githubusercontent.com%2Fodahu%2Fodahu-rstudio%2Fdevelop%2F.github%2Fworkflows%2Fmain.yml)

# RStudio Docker Image for Jupyter stack

This repository contains ODAHU Docker images with RStudio and R. These images are prepared to be run in Jupyter stack (they are built on top of minimal jupyter images). 

Versions of RStudio and R Language are set in the label of image (e.g. 1.2.5033r3.6.3 means RStudio v. 1.2.5033 and R v. 3.6.3)


## Base Docker image

[![](https://images.microbadger.com/badges/version/odahu/odahu-rstudio.svg)](https://hub.docker.com/r/odahu/odahu-rstudio/tags "odahu-rstudio image version") 
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/odahu/odahu-rstudio?sort=date)


Base docker image contains RStudio and R Language. 


## Datascience Docker image

[![](https://images.microbadger.com/badges/version/odahu/odahu-rstudio-datascience.svg)](https://hub.docker.com/r/odahu/odahu-rstudio-datascience/tags "odahu-rstudio-datascience image version") 
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/odahu/odahu-rstudio-datascience?sort=date)


Docker image, built on top of Base Docker image with datascience packages installed. [List of packages is in file install.R](https://raw.githubusercontent.com/odahu/odahu-rstudio/develop/install.R).