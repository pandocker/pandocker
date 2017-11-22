FROM k4zuki/pandocker-base

MAINTAINER k4zuki

ENV PANDOC_MISC_VERSION pandocker-0.0.7
ENV TZ JST

WORKDIR /var

RUN git clone --recursive --depth=1 -b $PANDOC_MISC_VERSION https://github.com/K4zuki/pandoc_misc.git

WORKDIR /workspace

VOLUME ["/workspace"]

CMD ["bash"]
