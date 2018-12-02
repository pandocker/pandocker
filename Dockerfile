FROM k4zuki/pandocker-base:notex

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

RUN pip3 install git+https://github.com/k4zuki/pandoc_misc.git@pythonize

#WORKDIR /var
#ENV PANDOC_MISC_VERSION -b 0.0.35
#RUN git clone --recursive --depth=1 $PANDOC_MISC_VERSION https://github.com/K4zuki/pandoc_misc.git && \
#    apt install -y --no-install-recommends texlive-pstricks

WORKDIR /workdir

VOLUME ["/workdir"]

CMD ["bash"]
