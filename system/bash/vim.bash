#!/bin/bash

vim_wrap_help(){
  echo "vim_wrap <file> [-E|--show-ends]"
  echo "  -E, --show-ends: Display $ at end of each line"
}

# Wrap text with Vim in console.
vim_wrap(){
  [[ -z "$1" ]] && vim_wrap_help && return 1
  [[ "$1" == '-h' ]] && vim_wrap_help && return 1
  # Work on a copy of the file.
  cp "$1" "$1".bak
  # Use Vim to wrap the text.
  vim -c "call Wrap()" -c "qa!" "$1".bak
  # Display the wrapped text.
  cat $2 "$1".bak
  # Remove the backup file.
  rm -f "$1".bak
}

# Convert Vim syntax highlighted file to HTML and extract the content.
vim2html(){
  vim -E -s \
    -c "let g:html_no_progress=1" \
    -c "syntax on" -c "runtime syntax/2html.vim" \
    -c "colorscheme thistle" \
    -c "hi Type ctermfg=6" \
    -c "hi Statement ctermfg=10" \
    -c "hi Identifier ctermfg=13" \
    -cwqa "$1" >/dev/null
  sed -n '/<pre.*/,/<\/pre.*/{//!p;}' "$1".html
  rm -rf "$1".html
}

# Convert HTML content to LaTeX format.
html2tex(){
  while IFS= read -r line;do
    line="${line//'\*'/*}"
    line="${line//'&quot;'/\"}"
    line="${line//'&amp;'/\&}"
    line="${line//'&gt;'/\>}"
    line="${line//'&lt;'/\<}"
    line="${line//'\'/\\textbackslash}"
    line="${line//'{'/\\\{}"
    line="${line//'}'/\\\}}"
    line="${line//\\textbackslash/\{\\textbackslash\}}"
    line="${line//'<span class="'/\\textcolor\{}"
    line="${line//'">'/\}\{}"
    line="${line//'</span>'/\}}"
    echo "${line}"
  done
}

# Convert Vim syntax highlighted file to LaTeX format.
vim2tex(){
  vim2html "$1" | html2tex
}

# Create a Vim syntax highlighted HTML file.
vim2web(){
  fn="${1##*/}" # Extract filename from the path.
  fn="${fn%.*}_${fn##*.}" # Extract filename without extension.
  mkdir "$fn" 2>/dev/null # Create directory if it doesn't exist.
  fp="$fn/$fn" # Set the file path without extension.
  rsync -aHog ~/.vim/web/ "$fn"/ # Copy web resources to the directory.
  mv "$fn/vim.html" "$fp.html" # Rename the HTML file to the new path.
  sed -i "s|_filename_|${1##*/}|" "$fp.html" # Update the filename in the HTML file.
  echo >> "$fp.html" # Add a newline to the HTML file.
  vim2html "$1" >> "$fp.html"
  cat >> "$fp.html" <<EOF
    </pre>
  </body>
</html>
EOF
  echo "HTML file created: $fp.html"
}
