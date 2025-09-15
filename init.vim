
" Activer Vim-Plug (gestionnaire de plugins)
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Auto-complétion
Plug 'dense-analysis/ale'  " Linter
Plug 'sheerun/vim-polyglot'  " Support de syntaxe amélioré
Plug 'jiangmiao/auto-pairs'  " Fermeture automatique des parenthèses, etc.
Plug 'tpope/vim-surround'  " Manipulation facile des paires de caractères
Plug 'preservim/nerdtree'  " Explorateur de fichiers
Plug 'catppuccin/vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" Nouveaux plugins ajoutés
Plug '42Paris/42header'
Plug 'vim-syntastic/syntastic'
Plug 'alexandregv/norminette-vim'

call plug#end()

" Theme cappuccin
syntax enable
set background=dark
colorscheme catppuccin_mocha

let g:airline_theme = 'catppuccin_mocha'

" Config Header42
let g:user42 = 'USERID'
let g:mail42 = 'USERID@student.42lyon.fr'

" Configuration de base
set termguicolors
syntax on
set background=dark
set number
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set mouse=a
set cursorline
set laststatus=2

" Configuration des couleurs
colorscheme default
hi Normal guibg=#1E1E1E guifg=#D4D4D4
hi Comment ctermfg=245 guifg=#608B4E
hi Keyword ctermfg=170 guifg=#C586C0
hi Function ctermfg=114 guifg=#DCDCAA
hi String ctermfg=168 guifg=#CE9178
hi Constant ctermfg=180 guifg=#B5CEA8
hi Type ctermfg=114 guifg=#4EC9B0

" Configuration de CoC (auto-complétion)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Configuration d'ALE (linter)
let g:ale_linters = {
\   'ruby': ['rubocop'],
\}
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

" NERDTree configuration
nnoremap <C-n> :NERDTreeToggle<CR>

" Airline configuration
let g:airline_theme='deus'
let g:airline#extensions#ale#enabled = 1

" Désactiver coc.nvim temporairement
let g:coc_disable_startup_warning = 1

" Autres raccourcis utiles
nnoremap <space> za  " Plier/déplier le code avec la barre d'espace
vnoremap < <gv  " Garder la sélection après indentation
vnoremap > >gv

" Nouveaux raccourcis
inoremap <C-s> <Esc>:w<CR>i
nnoremap <C-x> :q!<CR>
nnoremap <C-a> ggVG
nnoremap <C-f> /
inoremap <C-f> <Esc>/

" Supprimer le fichier
nnoremap <C-d> :!rm %<CR>

" Copier-coller amélioré
" Copier en mode visuel
vnoremap <C-c> y
" Copier la ligne courante en mode normal
nnoremap <C-c> yy
" Coller après le curseur en mode normal
inoremap <C-v> <Esc>pi
" Coller avant le curseur en mode normal
" nnoremap <C-S-v> P
" Coller en mode insertion
" inoremap <C-v> <C-r>+

" Plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Auto-complétion
Plug 'dense-analysis/ale'  " Linter
Plug 'sheerun/vim-polyglot'  " Support de syntaxe amélioré
Plug 'jiangmiao/auto-pairs'  " Fermeture automatique des parenthèses, etc.
Plug 'tpope/vim-surround'  " Manipulation facile des paires de caractères
Plug 'preservim/nerdtree'  " Explorateur de fichiers
Plug 'catppuccin/vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" Nouveaux plugins ajoutés
Plug '42Paris/42header'
Plug 'vim-syntastic/syntastic'
Plug 'alexandregv/norminette-vim'

call plug#end()

" Theme cappuccin
syntax enable
set background=dark
colorscheme catppuccin_mocha

let g:airline_theme = 'catppuccin_mocha'

" Config Header42
let g:user42 = 'USERID'
let g:mail42 = 'USERID@student.42lyon.fr'

" Configuration de base
syntax on
set background=dark
set number
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set mouse=a
set cursorline
set laststatus=2

" Configuration des couleurs
colorscheme default
hi Normal guibg=#1E1E1E guifg=#D4D4D4


" Afficher les raccourcis (Ctrl-H)
nnoremap <C-h> :call ShowShortcuts()<CR>

" Fonction pour afficher les raccourcis avec des émoticônes
function! ShowShortcuts()
  let shortcuts = [
    \ '📝 Ctrl-S : Sauvegarder',
    \ '❌ Ctrl-X : Quitter sans sauvegarder',
    \ '🔲 Ctrl-A : Tout sélectionner',
    \ '📋 Ctrl-C : Copier (en mode visuel)',
    \ '✂️  Ctrl-X : Couper (en mode visuel)',
    \ '📌 Ctrl-V : Coller',
    \ '🔍 Ctrl-F : Rechercher',
    \ '📂 Ctrl-N : Toggle NERDTree',
    \ '🎲 F6     : Mini-moulinette',
    \ '📢 F5     : Discord Commit',
    \ '🆘 Ctrl-H : Afficher cette aide',
    \ '↔️  Espace : Plier/déplier le code',
    \ '🔼 < ou > : Indenter (en mode visuel)',
    \ '🗑️ Ctrl-D : Supprimer le fichier'
    \ ]
  echohl WarningMsg
  echo '🔧 Liste des raccourcis :'
  echohl None
  echo join(shortcuts, "\n")
endfunction

set lazyredraw
set updatetime=300

" Fonction pour exécuter mini-moul.sh avec le nom du répertoire parent
function! RunMiniParentDir()
    " Obtenir le chemin complet du fichier actuel
    let current_file = expand('%:p')
    " Obtenir le répertoire parent du répertoire actuel
    let parent_dir = fnamemodify(current_file, ':h:h:t')
    " Changer vers le répertoire parent
    execute 'lcd ' . fnamemodify(current_file, ':h:h')
    " Exécuter le script mini-moul.sh avec le chemin complet
    execute 'term ~/mini-moulinette/mini-moul.sh ' . parent_dir
    " Revenir au répertoire précédent
    execute 'lcd -'
endfunction

" Mapper la fonction à la touche F6 (vous pouvez changer F6 par une autre touche si vous préférez)
nnoremap <F6> :call RunMiniParentDir()<CR>

function! Dcommit()

  execute '!/bin/bash ~/dcommit/commit.sh %'

endfunction
" discord commit fonction
nnoremap <F5> :call Dcommit()<CR>

" Activer la coloration syntaxique complète
autocmd BufEnter * :syntax sync fromstart
