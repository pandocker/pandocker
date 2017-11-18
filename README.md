# pandocker
Yet another ubuntu 16.04 based Docker image for pandoc

## For the first time to build your book
#### make repository and cd to it
```sh
mkdir /path/to/your/workspace
cd /path/to/your/workspace
```

#### git setup
```sh
git init
```

#### installation
```sh
docker run --rm -it -v $PWD:/workspace k4zuki/pandocker cp /var/pandoc_misc/Makefile.txt ./Makefile
docker run --rm -it -v $PWD:/workspace k4zuki/pandocker make init
> mkdir -p ./
> mkdir -p ./Out
> mkdir -p ./data
> mkdir -p ./markdown
> mkdir -p ./images
> mkdir -p ./data/waves
> mkdir -p ./data/bitfields
> mkdir -p ./data/bitfield16
> cp -i /var/pandoc_misc/Makefile.txt ./Makefile
> cp: overwrite './Makefile'? y
> cp -i /var/pandoc_misc/config.txt ./markdown/config.yaml
> touch ./markdown/TITLE.md
> echo "Out/" > .gitignore

git add .
git commit -m"initial commit"
```

## Afterwards

- HTML output `docker run --rm -it -v $PWD:/workspace k4zuki/pandocker make html`
- PDF output `docker run --rm -it -v $PWD:/workspace k4zuki/pandocker make pdf`
- HTML and PDF output `docker run --rm -it -v $PWD:/workspace k4zuki/pandocker make html pdf`
