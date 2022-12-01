FROM rocker/shiny:latest

LABEL name=ContDataSumViz

# Reset mirror
RUN sed -i -e 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//mirror:\/\/mirrors\.ubuntu\.com\/mirrors\.txt/' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    libssl-dev \
    libxml2-dev \
    libgit2-dev \
    default-jdk \
    r-cran-rjava \
    r-base-dev dh-r automake \
    libharfbuzz-dev  libfribidi-dev \
    libfreetype-dev \
    && apt-get clean

WORKDIR /app

# install renv & restore packages
COPY renv.lock renv.lock
RUN mkdir -p renv
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.dcf renv/settings.dcf
RUN Rscript -e 'install.packages("renv")'
RUN Rscript -e 'renv::restore()'

COPY . /app

CMD ["Rscript", "run.R"]
