# Zsh 생산성 설정 (my-utils-zsh-settings)

`fzf`(Fuzzy Finder)를 기반으로, `fd`(파일 찾기), `rg`(내용 검색), `bat`/`lsd`(미리보기) 등 모던 CLI 도구들을 연동하여 WSL(Ubuntu) 셸의 생산성을 극대화하는 개인 설정 모음입니다.

---

## 🌟 주요 기능 (Showcase)

이 설정의 핵심은 셸의 가장 빈번한 작업인 '파일 열기', '내용 검색', '디렉터리 이동'을 강력한 `fzf` 인터페이스로 대체하는 "FZF 3대장" 함수입니다.

1.  **`v` - Fuzzy Vim Opener (파일 열기)**
    * 현재 디렉터리(`v`) 또는 지정한 디렉터리(`v ~/projects`)의 파일을 `fzf`로 검색합니다.
    * `bat`을 이용한 실시간 구문 강조(Syntax Highlighting) 미리보기를 지원합니다.
    * `Enter` 키로 파일을 `vim`에서 바로 열 수 있습니다.

2.  **`f` - Fuzzy Content Search (내용 검색)**
    * `ripgrep(rg)`을 사용하여 현재 디렉터리 하위의 모든 파일에서 **내용**을 검색합니다.
    * `fzf` 목록에 검색어가 포함된 파일들을 표시합니다.
    * 미리보기 창에는 `bat`과 `rg`를 조합하여, **검색된 키워드가 하이라이트된** 실제 파일 내용을 보여줍니다.

3.  **`dd` - Fuzzy Directory Navigator (디렉터리 이동)**
    * `pushd`/`popd` 스택을 활용한 강력한 디렉터리 이동 함수입니다.
    * `fd`로 현재 위치의 하위 디렉터리를 검색하고 `fzf`로 선택합니다.
    * `lsd`를 이용한 트리(tree) 구조의 실시간 미리보기를 지원합니다.

---

## 🛠️ 설치 및 적용 방법 (Setup Guide for Visitors)

이 설정은 `oh-my-zsh` 환경을 기반으로 하며, 여러 핵심 CLI 도구에 의존성을 가집니다.

### 1단계: Zsh 및 Oh My Zsh 설치

가장 먼저 Zsh와 `oh-my-zsh` 프레임워크가 설치되어 있어야 합니다.

```bash
# Zsh 설치 (Ubuntu/Debian)
sudo apt install zsh
# Oh My Zsh 설치 (설치 스크립트 실행)
sh -c "$(curl -fsSL [https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh](https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh))"