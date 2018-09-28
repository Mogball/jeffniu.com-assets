#/bin/bash
js_output_dir=js_out
mkdir -p "$js_output_dir"
js_files=()
while IFS= read -r -d $'\0'; do
    js_files+=("$REPLY")
done < <(find js -type f -name "*.js" -print0)

echo "Minifying JavaScript"
for js_file in "${js_files[@]}"; do
    filename=$(basename -- $js_file)
    echo "--> $filename"
    compiler --js="$js_file" --js_output_file="$js_output_dir"/"$filename" --jscomp_off "*"
done

css_output_dir=css_out
mkdir -p "$css_output_dir"
css_files=()
while IFS= read -r -d $'\0'; do
    css_files+=("$REPLY")
done < <(find css -type f -name "*.css" -print0)

printf "\n"
echo "Minifying CSS"
for css_file in "${css_files[@]}"; do
    filename=$(basename -- $css_file)
    echo "--> $filename"
    postcss "$css_file" > "$css_output_dir"/"$filename"
done
