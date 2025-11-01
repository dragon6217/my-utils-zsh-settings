
# ------------------------------------------------------------
# 1. 커스텀 별칭 (Aliases)
# ------------------------------------------------------------
alias b='batcat'  # batcat (bat)
alias c='clear'
alias p='python3'
alias python='python3'
alias j='jupyter notebook'
alias g='ghci'
alias fd='fdfind'
alias e='explorer.exe .' # 윈도우 탐색기 열기
alias d='dirs -v'        # dirs_v__namecollision 대체
alias s='pushd 1>/dev/null' # pushd1__namecollision 대체

# ------------------------------------------------------------
# 2. 커스텀 함수 (FZF 3대장)
# ------------------------------------------------------------

# [v] Vim으로 파일 열기
function v1(){
  fd --type f --max-depth 1 --hidden | fzf \
  --border \
  --height 100% \
  --extended \
  --ansi \
  --reverse \
  --bind 'shift-up:preview-page-up,shift-down:preview-page-down' \
  --bind 'alt-up:preview-up,alt-down:preview-down' \
  --bind 'ctrl-s:half-page-up,ctrl-x:half-page-down' \
  --bind '?:toggle-preview,alt-w:toggle-preview-wrap' \
  --bind 'enter:become(vim {})' \
  --preview='batcat --color=always --style=numbers {}' \
  --preview-window=right:70%
}
function v4(){
  cd "$1" && fd --type f --max-depth 1 --hidden | fzf \
  --border \
  --height 100% \
  --extended \
  --ansi \
  --reverse \
  --bind 'shift-up:preview-page-up,shift-down:preview-page-down' \
  --bind 'alt-up:preview-up,alt-down:preview-down' \
  --bind 'ctrl-s:half-page-up,ctrl-x:half-page-down' \
  --bind '?:toggle-preview,alt-w:toggle-preview-wrap' \
  --bind 'enter:become(vim {})' \
  --preview='batcat --color=always --style=numbers {}' \
  --preview-window=right:70%
}
function v(){
  if [ ! "$#" -gt 0 ];
  then
    v1
  else
    v4 "${1/\~/$HOME}";
    cd - 1>/dev/null;
  fi
}

# [f] 파일 내용 검색하기
function f() {
  if [ ! "$#" -gt 0 ];
  then
    echo "검색어를 입력해주세요."; return 1;
  fi
  rg --files-with-matches --no-messages "$1" | \
  fzf \
  --border \
  --height 80% \
  --extended \
  --ansi \
  --reverse \
  --header 'Find in File' \
  --bind 'shift-up:preview-page-up,shift-down:preview-page-down' \
  --bind 'alt-up:preview-up,alt-down:preview-down' \
  --bind '?:toggle-preview,alt-w:toggle-preview-wrap' \
  --bind 'alt-v:execute(vim {} >/dev/tty </dev/tty)' \
  --preview-window=right:70% \
  --preview "batcat --theme='OneHalfDark' --style=numbers --color=always {} | rg --color always --colors 'match:bg:yellow' --ignore-case --context 10 '$1' "
}

# [dd] 디렉터리로 이동하기
# (dd2__namecollision 함수를 'dd'로 이름 변경)
function pparse2_dd() {
  if [[ $3 == "." ]]; then
    dd_nav $1 $2
  else
    if [ $1 -eq 0 ]; then
      dd_nav 1 $2
    else
      if [[ $PWD == $2 ]]; then
        popd -1 1>/dev/null;
        dd_nav 0 $2
      else
        popd -1 1>/dev/null;
        dd_nav 1 $2
      fi
    fi
  fi
}
function dd_nav() {
  local dir
  dir=$( echo . | cat - <(echo ..) | cat - <(fd --type d --max-depth 1 --hidden) | fzf \
  --header 'Search In Directory' \
  --border \
  --height 80% \
  --extended \
  --ansi \
  --reverse \
  --bind '?:toggle-preview,alt-w:toggle-preview-wrap' \
  --bind 'shift-up:preview-page-up,shift-down:preview-page-down' \
  --bind 'alt-up:preview-up,alt-down:preview-down' \
  --preview 'lsd --color=always --tree --depth=1 {} | head -200 2>/dev/null' \
  --preview-window=right:70%) && cd "$dir" && pparse2_dd $1 $2 $dir
}
function dd() {
  pushd . 1>/dev/null
  dd_nav 0 $PWD
}


# ------------------------------------------------------------
# 3. PATH 및 환경 변수 설정
# ------------------------------------------------------------

# 사용자 로컬 바이너리 (fd 등)
export PATH="$HOME/.local/bin:$PATH"
# Rust (Cargo) (lsd 등)
export PATH="$HOME/.cargo/bin:$PATH"
# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
# Haskell (ghcup)
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
