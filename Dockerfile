FROM k4zuki/pandocker-base:22.04-2.19

MAINTAINER k4zuki

ENV TZ JST-9

pip3 install -U pandocker-lua-filters docx-coreprop-writer

RUN pip3 install git+https://github.com/k4zuki/pandoc_misc.git@2.16.2

RUN apt install -y fonts-freefont-ttf fonts-liberation2 cli-spinner

WORKDIR /workdir

VOLUME ["/workdir"]

CMD ["bash"]
