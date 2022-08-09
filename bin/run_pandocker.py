import subprocess as sp
import argparse

DOCKER = "cd {}; pwd; docker run --rm -it -v$PWD:/workdir k4zuki/pandocker:{}"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("input")
    parser.add_argument("image_version", default="2.19")
    args = parser.parse_args()
    sp.run(DOCKER.format(args.input, args.image_version), shell=True)


if __name__ == '__main__':
    main()
