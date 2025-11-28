INPUT_DIR="./"

for input_file in "$INPUT_DIR"/*.in; do
    base_name=$(basename "$input_file" .in)
    mpirun -np 2 pw.x < "$input_file" > "${base_name}.out"
done
