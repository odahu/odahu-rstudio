ARG BASE_RSTUDIO_IMAGE
FROM $BASE_RSTUDIO_IMAGE

USER 0

COPY install.R /opt/

RUN R CMD javareconf && \
    Rscript /opt/install.R --save

USER 1000
