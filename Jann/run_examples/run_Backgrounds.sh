# source venv/bin/activate

# Number of lines from input source to use
export NUMTREES='100'
export NUMNEIGHBORS='3'

# Define the environmental variables
export INFILEPATH="data/Backgrounds"
export IMAGEPATH="data/Backgrounds/imgs"
export INFILE="data/Backgrounds/backgrounds.txt"
export TFHUB_CACHE_DIR=data/module

# Extract the raw lines to a single file:
ls ${IMAGEPATH} | grep '.jpg' | sed 's/\.jpg//' | tr '_' ' ' > ${INFILE}

# Embed the lines using the encoder (Universal Sentence Encoder)
python3 embed_lines.py --infile=${INFILE} --verbose &&

# Process the embeddings and save as unique strings and numpy array
python3 process_embeddings.py --infile=${INFILE} --verbose &&

# Index the embeddings using an approximate nearest neighbor (annoy)
python3 index_embeddings.py --infile=${INFILE} --verbose \
--num_trees=${NUMTREES} &&

# Build a simple command line interaction for model testing
python3 interact_with_model.py --infile=${INFILE} --verbose \
--num_neighbors=${NUMNEIGHBORS}
