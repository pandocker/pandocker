FROM k4zuki/pandocker-base

MAINTAINER k4zuki

ENV PANDOC_MISC_VERSION pandocker-0.0.7
ENV TZ JST

WORKDIR /usr/local/bin

RUN wget -c https://github.com/tcnksm/ghr/releases/download/v0.5.4/ghr_v0.5.4_linux_amd64.zip && \
    unzip -e ghr_v0.5.4_linux_amd64.zip && rm ghr_v0.5.4_linux_amd64.zip

WORKDIR /var
RUN git clone --recursive --depth=1 -b $PANDOC_MISC_VERSION https://github.com/K4zuki/pandoc_misc.git

WORKDIR /workspace

VOLUME ["/workspace"]

CMD ["bash"]
