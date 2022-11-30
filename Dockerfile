FROM rocker/shiny:latest

LABEL name=ContDataSumViz

RUN apt-get update && apt-get install -y \
    libssl-dev \
    && apt-get clean

COPY ./renv.lock ./renv.lock

# install renv & restore packages
RUN Rscript -e 'install.packages("renv")'
RUN Rscript -e 'renv::restore()'

COPY . /app

EXPOSE ${PORT}
CMD ["Rscript", "run.R"]
