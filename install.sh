for f in $(ls -A); do
    ln -sf $(realpath $f) $HOME/$f
done
