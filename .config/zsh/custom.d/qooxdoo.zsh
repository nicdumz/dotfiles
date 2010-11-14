function qooxdoomake() {
    SAVEDIR=$(pwd);
    while [ ! -x generate.py ]; do
        cd ..;
    done
    ./generate.py source
    cd $SAVEDIR
}
