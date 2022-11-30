FROM rocker/shiny:latest

LABEL name=ContDataSumViz

COPY ./renv.lock ./renv.lock

# install renv & restore packages
RUN Rscript -e 'install.packages("renv")'
RUN Rscript -e 'renv::restore()'

COPY . /app

EXPOSE ${PORT}
CMD ["Rscript", "run.R"]
