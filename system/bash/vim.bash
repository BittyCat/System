#!/bin/bash

vim2html(){
  [[ "$@" == *"-h"* || -z "$1" ]] && {
    echo "vim2html <file> [options]"
    echo "        Converts a Vim syntax highlighted file to HTML format."
    echo "  -h    Show this help message."
    return 0
  }

  vim -E -s \
    -c "let g:html_no_progress=1" \
    -c "syntax on" -c "runtime syntax/2html.vim" \
    -c "colorscheme thistle" \
    -c "hi Type ctermfg=6" \
    -c "hi Statement ctermfg=10" \
    -c "hi Identifier ctermfg=13" \
    -cwqa "$1" >/dev/null

  sed -n '/<pre.*/,/<\/pre.*/{//!p;}' "$1".html # extract <pre> content
  rm -rf "$1".html # remove temp html file
}

html2tex(){
  [[ "$@" == *"-h"* ]] && {
    echo "html2tex <file> [options]"
    echo "        Converts HTML content to LaTeX format."
    echo "  -h    Show this help message."
    return 0
  }

  while IFS= read -r line;do
    line="${line//'\*'/*}"
    line="${line//'&quot;'/\"}"
    line="${line//'&amp;'/\&}"
    line="${line//'&gt;'/\>}"
    line="${line//'&lt;'/\<}"
    line="${line//'\'/\{\\textbackslash\}}"
    line="${line//'{'/\\\{}"
    line="${line//'}'/\\\}}"
    line="${line//'<span class="'/\\textcolor\{}"
    line="${line//'">'/\}\{}"
    line="${line//'</span>'/\}}"
    echo "${line}"
  done
}

vim2tex(){
  [[ "$@" == *"-h"* || -z "$1" ]] && {
    echo "vim2tex <file> [options]"
    echo "        Converts a Vim syntax highlighted file to LaTeX format."
    echo "  -h    Show this help message."
    return 0
  }

  vim2html "$1" | html2tex
}

vim2web(){
  [[ "$@" == *"-h"* || -z "$1" ]] && {
    echo "vim2web <file> [options]"
    echo "        Converts a Vim syntax highlighted file to a web format."
    echo "  -h    Show this help message."
    return 0
  }

  dirname="${1//./_}"
  basename="${dirname##*/}"
  filepath="${dirname}/${basename}.html"

  mkdir -p "${dirname}" 2>/dev/null
  rsync -aHog ~/.vim/web/ "${dirname}/"

  mv "${dirname}/vim.html" "${filepath}"
  sed -i "s|_filename_|${1##*/}|" "${filepath}"
  vim2html "$1" >> "${filepath}"
  cat >> "${filepath}" <<EOF
    </pre>
  </body>
</html>
EOF

  echo "HTML file created: ${filepath}"
}
