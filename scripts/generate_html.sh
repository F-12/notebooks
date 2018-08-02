#! /bin/zsh

root=$(pwd);
ipynb="ipynb";
generated="generated";

# param: path current working file
relativePathToRevealJs() {
    f_c=$1;
    f_dir=$(dirname f_c);
    prefix='';
    while (( ! "$f_dir" = '.' ));do
        prefix="../$prefix";
        f_dir=$(dirname "$f_dir");
    done
    echo "$prefix"
}


echo "generation start..."

# convert ipynb
for nb in **/*.ipynb;do
    echo "generating $nb";

    nb_dir=$(dirname "$nb");
    nb_basename=$(basename "$nb");
    nb_output_dir="$root/$generated/$nb_dir"

#    mkdir -p "$nb_output_dir";
    jupyter nbconvert "$nb" --to slides --output-dir="$nb_output_dir";

    # create reveal.js link if not exist
    if [ ! -f "$nb_output_dir/reveal.js" ];then
        ln -s "$root/reveal.js" "$nb_output_dir/reveal.js";
        echo "create $nb_output_dir/reveal.js link";
    fi

    echo "finish $nb";
done


# create index.html link
