ARG JUPYTER_MINIMAL_NOTEBOOK_IMAGE=jupyter/minimal-notebook:678ada768ab1
FROM $JUPYTER_MINIMAL_NOTEBOOK_IMAGE

USER 0

RUN mkdir r-studio && \
    mkdir r-lang && \
    wget -O rstudio.tar.gz https://github.com/rstudio/rstudio/archive/v1.2.5033.tar.gz && \
    wget -O R.tar.gz       https://cran.r-project.org/src/base/R-3/R-3.6.3.tar.gz && \
    tar -xf rstudio.tar.gz -C ./r-studio && \
    tar -xf R.tar.gz       -C ./r-lang && \
    apt-get update && \
    cd ./r-studio/*/dependencies/linux/ && \
    ./install-dependencies-debian --exclude-qt-sdk && \
    apt-get install -y gfortran libreadline-dev libxt-dev liblzma-dev openjdk-8-jdk && \
    update-java-alternatives -s java-1.8.0-openjdk-amd64 && \
    cd ~/r-lang/*/ && \
    ln -s /lib/x86_64-linux-gnu/libreadline.so.7 /lib/x86_64-linux-gnu/libreadline.so.8 && \
    LDFLAGS='-L/opt/conda/lib -licui18n -licuuc -licudata' ./configure --enable-R-shlib=yes --with-blas --with-lapack && \
    make && \
    make install && \
    cd ~/r-studio/*/ && \
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
