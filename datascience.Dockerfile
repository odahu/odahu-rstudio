ARG BASE_RSTUDIO_IMAGE
FROM $BASE_RSTUDIO_IMAGE

USER 0

COPY install.R /opt/

RUN R CMD javareconf && \
    apt-get update && apt-get install -y libzmq3-dev libssl-dev libcurl4-openssl-dev libxml2-dev && \
    ln -sf /usr/lib/x86_64-linux-gnu/libicui18n.so.64.2 /usr/lib/x86_64-linux-gnu/libicui18n.so.64 && \
    ln -sf /usr/lib/x86_64-linux-gnu/libicui18n.so.64.2 /usr/lib/x86_64-linux-gnu/libicui18n.so && \
    Rscript /opt/install.R --save && \
    chown -R jovyan /usr/local/lib/R/ && \
    Rscript -e "installed.packages()" > /opt/installed.packages.txt && \
    cat /opt/installed.packages.txt

USER 1000
