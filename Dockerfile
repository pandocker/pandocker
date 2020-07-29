FROM k4zuki/pandocker-base:20.04

MAINTAINER k4zuki

ENV TZ JST-9

RUN pip3 install pandoc-pandocker-filters \
    git+https://github.com/pandocker/pandoc-blockdiag-filter.git \
    git+https://github.com/pandocker/pandoc-docx-utils-py.git \
    git+https://github.com/pandocker/pandoc-svgbob-filter.git \
    git+https://github.com/pandocker/pandocker-lua-filters.git

RUN pip3 install git+https://github.com/k4zuki/pandoc_misc.git@2.8 \
      git+https://github.com/k4zuki/docx-core-property-writer.git

RUN apt install -y fonts-freefont-ttf fonts-liberation2 cli-spinner

WORKDIR /workdir

VOLUME ["/workdir"]

CMD ["bash"]
