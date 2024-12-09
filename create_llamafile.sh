gmake -j8 && sudo gmake install PREFIX=/usr/local

FILE="rubra-phi-3-mini-128k-instruct.Q6_K.gguf"

# Check if the file already exists
if [ -f "$FILE" ]; then
    echo "File '$FILE' already exists. Skipping download."
else
    echo "File '$FILE' not found. Downloading..."
    wget "https://huggingface.co/rubra-ai/Phi-3-mini-128k-instruct-GGUF/resolve/main/rubra-phi-3-mini-128k-instruct.Q6_K.gguf"
    if [ $? -eq 0 ]; then
        echo "File downloaded successfully."
    else
        echo "Error downloading file."
        exit 1
    fi
fi
# download model

# copy the base llamafile
cp /usr/local/bin/llamafile rubra.llamafile

npm install jsonrepair

# package everything up
zipalign -j0 \
  rubra.llamafile \
  jsonrepair.ts \
  $FILE \
  .args
