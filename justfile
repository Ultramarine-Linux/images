build: mkosi-build
    sudo ./postprocess.sh

mkosi-build:
    sudo mkosi build --force
clean:
    mkosi clean