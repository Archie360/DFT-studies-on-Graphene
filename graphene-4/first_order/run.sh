INPUT_DIR="./"

for input_file in "$INPUT_DIR"/scf_*.in; do
    base_name=$(basename "$input_file" .in)
    pw.x < "$input_file" > "${base_name}.out"
done
