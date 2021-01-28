echo "Getting preprocessor output......"

UPPER_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
SAVE_DIR="$UPPER_DIR/out"

echo "Save built output files in $SAVE_DIR"
cp /boot/config-$(uname -r) "$SAVE_DIR/.config" &
wait $!

echo "Build Kernel using $(nproc) processes"
make O=$SAVE_DIR -j $(nproc)
