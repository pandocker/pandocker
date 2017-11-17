FROM k4zuki/pandocker-base

ENV PANDOC_MISC_VERSION pandocker-0.0.1

RUN cd /var && git clone --recursive --depth=1 -b pandocker https://github.com/K4zuki/pandoc_misc.git

WORKDIR /workspace

VOLUME ["/workspace"]

CMD ["bash"]
