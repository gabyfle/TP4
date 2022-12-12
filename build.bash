# Building assembly using as Assembler with -g flag

# Creating build directory if not exists
mkdir -p build

if [[ -z $1 && -z $2 ]]; then
    echo "Usage: build.bash <source file> <output file>"
    exit 1
fi
# Assembling the file name given in argument $1
as -g $1 -o build/$1.o
# Linking the object file
gcc build/$1.o -o build/$2 -nostdlib -fPIE -pie -no-pie -g

# Deleting object files
rm build/$1.o
