ARG JUPYTER_MINIMAL_NOTEBOOK_IMAGE=jupyter/minimal-notebook:678ada768ab1
FROM $JUPYTER_MINIMAL_NOTEBOOK_IMAGE

ARG RSTUDIO_VERSION
ARG R_VERSION

USER 0

RUN mkdir -p /opt/r-studio && \
    mkdir -p /opt/r-lang && \
    wget -O /opt/rstudio.tar.gz https://github.com/rstudio/rstudio/archive/v$RSTUDIO_VERSION.tar.gz && \
    wget -O /opt/R.tar.gz       https://cran.r-project.org/src/base/R-3/R-$R_VERSION.tar.gz && \
    tar -xf /opt/rstudio.tar.gz -C /opt/r-studio && \
    tar -xf /opt/R.tar.gz       -C /opt/r-lang && \
    apt-get update && \
    cd /opt/r-studio/*/dependencies/linux/ && \
    ./install-dependencies-debian --exclude-qt-sdk && \
    apt-get install -y gfortran libreadline-dev libxt-dev liblzma-dev openjdk-8-jdk && \
    update-java-alternatives -s java-1.8.0-openjdk-amd64 && \
    cd /opt/r-lang/*/ && \
    ln -s /lib/x86_64-linux-gnu/libreadline.so.7 /lib/x86_64-linux-gnu/libreadline.so.8 && \
    LDFLAGS='-L/opt/conda/lib -licui18n -licuuc -licudata' ./configure --enable-R-shlib=yes --with-blas --with-lapack && \
    make && \
    make install && \
    cd /opt/r-studio/*/ && \
    mkdir build && cd build  && \
    cmake .. -DRSTUDIO_TARGET=Server -DCMAKE_BUILD_TYPE=Release && \
    make install && \
    useradd -r rstudio-server && \
    mkdir -p /var/run/rstudio-server && \
    mkdir -p /var/lock/rstudio-server && \
    mkdir -p /var/log/rstudio-server && \
    mkdir -p /var/lib/rstudio-server && \
    ln -f -s /usr/local/lib/rstudio-server/bin/rserver /usr/sbin/rserver && \
    ln -f -s /usr/local/lib/rstudio-server/bin/rsession /usr/sbin/rsession && \
    cp /usr/local/lib/R/lib/*.so /usr/lib && \
    mkdir -p /etc/rstudio && \
    touch /etc/rstudio/repos.conf

USER 1000
