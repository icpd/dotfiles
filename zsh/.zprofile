# protobuf
export PATH="/opt/homebrew/opt/protobuf@3/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/protobuf@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/protobuf@3/include"

# Added by Toolbox App
export PATH="$PATH:/Users/lewis/Library/Application Support/JetBrains/Toolbox/scripts"

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
