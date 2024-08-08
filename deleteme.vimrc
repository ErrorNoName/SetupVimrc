" Activer Vim-Plug (gestionnaire de plugins)
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Auto-complétion
Plug 'dense-analysis/ale'  " Linter
Plug 'sheerun/vim-polyglot'  " Support de syntaxe amélioré
Plug 'jiangmiao/auto-pairs'  " Fermeture automatique des parenthèses, etc.
Plug 'tpope/vim-surround'  " Manipulation facile des paires de caractères
Plug 'preservim/nerdtree'  " Explorateur de fichiers
Plug 'vim-airline/vim-airline'  " Barre de statut améliorée
Plug 'vim-airline/vim-airline-themes'

call plug#end()

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
inoremap <C-s> <Esc>:w<CR>
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

" Afficher les raccourcis (Ctrl-H)
nnoremap <C-h> :call ShowShortcuts()<CR>

" Fonction pour afficher les raccourcis
function! ShowShortcuts()
  let shortcuts = [
    \ 'Ctrl-S : Sauvegarder',
    \ 'Ctrl-X : Quitter sans sauvegarder',
    \ 'Ctrl-A : Tout sélectionner',
    \ 'Ctrl-C : Copier (en mode visuel)',
    \ 'Ctrl-X : Couper (en mode visuel)',
    \ 'Ctrl-V : Coller',
    \ 'Ctrl-F : Rechercher',
    \ 'Ctrl-N : Toggle NERDTree',
    \ 'Ctrl-H : Afficher cette aide',
    \ 'Espace : Plier/déplier le code',
    \ '< ou > : Indenter (en mode visuel)',
    \ 'Ctrl-D : Supprimer le fichier'
    \ ]
  echo join(shortcuts, "\n")
endfunction

set lazyredraw
set updatetime=300

" Activer la coloration syntaxique complète
autocmd BufEnter * :syntax sync fromstart
