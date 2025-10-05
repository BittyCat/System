#!/bin/bash



echo "vimtex [fn] -- convert vim syntax colors to html/tex"

vimtex(){
  [[ "$1" =~ (.*/)?(.*)\.(.*)$ ]]
  fp="${BASH_REMATCH[1]}"
  fn="${BASH_REMATCH[2]}"
  fe="${BASH_REMATCH[3]}"
  renamed="${fp}${fn}_${fe}"
  _vim2html "$1" > "${renamed}".html
  cat "${renamed}".html | _html2tex > "${renamed}".tex
}

_vimclude(){
  while IFS= read -r line;do
    if [[ "${line}" =~ '§ '(.*) ]];then
      file="${2%/}/${BASH_REMATCH[1]//./_}.$3"
      if [ -f "${file}" ];then
        echo "$4"
        cat "${file}"
        echo "$5"
      else
        echo "${line}"
      fi
    else
      echo "${line}"
    fi
  done < "$1"
}

echo "vimclude [fn] [root] [-t] -- include html|tex code snippets"

vimclude(){
  if [[ "$3" == "-t" ]];then
    _vimclude "$1" "$2" 'tex' '\begin{Code}' '\end{Code}' > "${1%.*}".mdtex
  else
    _vimclude "$1" "$2" 'html' '<pre>' '</pre>' > "${1%.*}".markdown
  fi
}

echo "mdtex [fn] -- convert markdown to tex"

mdtex(){
  files=()
  while IFS= read -r line;do
    echo "${line}"
    if [[ "${line}" =~ "# "(.*) ]];then
      files+=("${BASH_REMATCH[1]}".mdtex)
    fi
  done < "${1%.*}".yaml
  pandoc \
    --metadata-file "${1%.*}".yaml \
    --template ~/texmf/tex/latex/template.tex \
    --top-level-division chapter \
    -r markdown-auto_identifiers \
    -o "${1%.*}".tex "${files[@]}"
}
