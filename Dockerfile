FROM k4zuki/pandocker-base

MAINTAINER k4zuki

ENV TZ JST-9

WORKDIR /usr/local/bin
RUN wget -c https://github.com/tcnksm/ghr/releases/download/v0.5.4/ghr_v0.5.4_linux_amd64.zip && \
    unzip -e ghr_v0.5.4_linux_amd64.zip && rm ghr_v0.5.4_linux_amd64.zip

RUN pip3 install bitfieldpy pandoc-pandocker-filters \
      git+https://github.com/pandocker/removalnotes.git \
      git+https://github.com/pandocker/tex-landscape.git \
      git+https://github.com/pandocker/pandoc-blockdiag-filter.git \
      git+https://github.com/pandocker/pandoc-docx-pagebreak-py.git \
      git+https://github.com/pandocker/pandoc-docx-utils-py.git \
      git+https://github.com/pandocker/pandoc-svgbob-filter.git

RUN pip3 install git+https://github.com/k4zuki/pandoc_misc.git@pandocker

WORKDIR /workdir

VOLUME ["/workdir"]

CMD ["bash"]
