for f in $(cat FILES); do
    ln -sfn $(realpath $f) $HOME/$f
done
