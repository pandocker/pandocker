FROM ubuntu:16.04

ENV PLANTUML_VERSION 1.2017.18
ENV PLANTUML_DOWNLOAD_URL https://sourceforge.net/projects/plantuml/files/plantuml.$PLANTUML_VERSION.jar/download

ENV PANDOC_VERSION 2.0.1.1
ENV PANDOC_DOWNLOAD_URL https://github.com/jgm/pandoc/releases/download/$PANDOC_VERSION/pandoc-$PANDOC_VERSION-1-amd64.deb
ENV PANDOC_ROOT /usr/local/pandoc

RUN echo "deb http://ftp.jaist.ac.jp/pub/Linux/ubuntu/ xenial main restricted universe multiverse" > /etc/apt/sources.list \
    && echo "deb http://ftp.jaist.ac.jp/pub/Linux/ubuntu/ xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb http://ftp.jaist.ac.jp/pub/Linux/ubuntu/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list \
    && apt-get -y update \
    && apt-get install -y wget curl \
    python3 python3-pip \
    cabal-install \
    nodejs-legacy npm \
    librsvg2-bin gpp \
    graphviz \
    && curl -fsSL "$PLANTUML_DOWNLOAD_URL" -o /usr/local/plantuml.jar \
    && echo "#!/bin/bash" > /usr/local/bin/plantuml \
    && echo "java -jar /usr/local/plantuml.jar \"$@\"" >> /usr/local/bin/plantuml \
    && chmod +x /usr/local/bin/plantuml \
    && wget -c $PANDOC_DOWNLOAD_URL \
    && dpkg -i pandoc-$PANDOC_VERSION-1-amd64.deb \
    && wget -c https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.0.0-beta3/linux-ghc8-pandoc-2-0.tar.gz \
        && tar zxf linux-ghc8-pandoc-2-0.tar.gz \
        && mv pandoc-crossref /usr/local/bin/ \
    && pip3 install pyyaml pillow \
    pantable csv2table \
    six pandoc-imagine \
    svgutils \
    && npm install -g phantomjs-prebuilt wavedrom-cli \
    fs-extra yargs onml bit-field \
    && apt-get -y remove *-doc curl wget python3-pip cabal-install ghc \
    && apt-get clean && apt autoremove \
    && rm pandoc-$PANDOC_VERSION-1-amd64.deb \
    && rm linux*.gz \
    && echo "pandocker"

RUN echo "deb http://ftp.jaist.ac.jp/pub/Linux/ubuntu/ xenial main restricted universe multiverse" > /etc/apt/sources.list \
    && echo "deb http://ftp.jaist.ac.jp/pub/Linux/ubuntu/ xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb http://ftp.jaist.ac.jp/pub/Linux/ubuntu/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list \
    && apt-get -y update \
    && apt-get install -y wget curl \
   texlive-xetex \
   xzdec texlive-lang-japanese \
   && tlmgr init-usertree \
   && tlmgr option repository ftp://tug.org/historic/systems/texlive/2015/tlnet-final \
   && mkdir -p /usr/share/texlive/texmf-dist/tex/latex/BXptool/ \
   && wget -c https://github.com/zr-tex8r/BXptool/archive/v0.4.zip \
   && unzip v0.4.zip \
   && cp BXptool-0.4/bx*.{sty,def} /usr/share/texlive/texmf-dist/tex/latex/BXptool/ \
   && mktexlsr \
   && tlmgr install oberdiek \
   && wget -c https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip \
       && unzip -e 1.050R-it.zip && cp source-code-pro-2.030R-ro-1.050R-it/TTF/SourceCodePro-*.ttf /usr/local/share/fonts/ \
   && wget -c https://github.com/adobe-fonts/source-sans-pro/archive/2.020R-ro/1.075R-it.zip \
       && unzip -e 1.075R-it.zip && cp source-sans-pro-2.020R-ro-1.075R-it/TTF/SourceSansPro-*.ttf /usr/local/share/fonts/ \
   && wget -c https://github.com/mzyy94/RictyDiminished-for-Powerline/archive/3.2.4-powerline-early-2016.zip \
       && unzip -e 3.2.4-powerline-early-2016.zip \
       && cp RictyDiminished-for-Powerline-3.2.4-powerline-early-2016/RictyDiminished-*.ttf /usr/local/share/fonts/
