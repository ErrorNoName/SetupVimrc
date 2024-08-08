# Guide Complet pour Configurer Vim à l'École 42

Ce guide explique comment configurer Vim à l'École 42, en utilisant les outils et plugins nécessaires, ainsi que les configurations spécifiques.

## 1. Prérequis

Avant de commencer, assurez-vous d'avoir les outils suivants installés :

1. **Vérifiez la version de Vim** :
   ```bash
   vim --version
   ```

2. **Installer nvm (Node Version Manager)** :
   ```bash
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
   source ~/.bashrc  # ou ~/.zshrc si vous utilisez zsh
   nvm install node
   ```

3. **Installer rbenv et Ruby** :
   ```bash
   git clone https://github.com/rbenv/rbenv.git ~/.rbenv
   echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
   echo 'eval "$(rbenv init -)"' >> ~/.bashrc
   source ~/.bashrc
   git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
   rbenv install 3.0.0  # ou la version la plus récente disponible
   rbenv global 3.0.0
   ```

## 2. Installation de Vim-Plug

Vim-Plug est un gestionnaire de plugins pour Vim.

1. **Installer Vim-Plug** :
   ```bash
   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   ```

## 3. Configuration de Base de Vim

1. **Ouvrir ou créer votre fichier de configuration Vim** :
   ```bash
   vim ~/.vimrc
   ```

2. **Ajouter la configuration de base et des plugins** :
   Copiez et collez la configuration suivante dans votre fichier `.vimrc` :

   ```vim
   "" Activer Vim-Plug (gestionnaire de plugins)
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

   " Afficher les raccourcis (Ctrl-H)
   nnoremap <C-h> :call ShowShortcuts()<CR>

   " Fonction pour afficher les raccourcis avec des émoticônes
   function! ShowShortcuts()
     let shortcuts = [
       \ '📝 Ctrl-S : Sauvegarder',
       \ '❌ Ctrl-X : Quitter sans sauvegarder',
       \ '🔲 Ctrl-A : Tout sélectionner',
       \ '📋 Ctrl-C : Copier (en mode visuel)',
       \ '✂️ Ctrl-X : Couper (en mode visuel)',
       \ '📌 Ctrl-V : Coller',
       \ '🔍 Ctrl-F : Rechercher',
       \ '📂 Ctrl-N : Toggle NERDTree',
       \ '🆘 Ctrl-H : Afficher cette aide',
       \ '↔️ Espace : Plier/déplier le code',
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

   " Activer la coloration syntaxique complète
   autocmd BufEnter * :syntax sync fromstart
   ```

## 4. Installation des Plugins et Extensions

1. **Installer les gems Ruby nécessaires** :
   ```bash
   gem install rubocop solargraph
   ```

2. **Installer les plugins Vim** :
   Ouvrez Vim et exécutez :
   ```vim
   :PlugInstall
   ```

3. **Installer l'extension CoC pour Solargraph** :
   Dans Vim, exécutez :
   ```vim
   :CocInstall coc-solargraph
   ```

## 5. Configuration Terminal

1. **Désactiver le contrôle de flux XON/XOFF** (permet l'utilisation de Ctrl+S) :
   Ajoutez cette ligne à votre `~/.bashrc` ou `~/.zshrc` :
   ```bash
   stty -ixon
   ```

2. **Recharger la configuration du shell** :
   ```bash
   source ~/.bashrc  # ou ~/.zshrc
   ```

## 6. Vérification et Dépannage

### Problèmes avec la Version de Vim

1. **Vér

ifier la version de Vim** :
   ```bash
   vim --version
   ```

2. **Mettre à jour Vim si nécessaire** :
   - Vous pouvez mettre à jour Vim si vous avez les privilèges nécessaires.
   - Utiliser une version portable de Vim.
   - Désactiver temporairement l'avertissement en ajoutant cette ligne à votre `.vimrc` :
     ```vim
     let g:coc_disable_startup_warning = 1
     ```

### Problèmes avec Node.js

1. **Vérifier si Node.js est installé** :
   ```bash
   node --version
   ```

2. **Installer Node.js via nvm** :
   ```bash
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
   source ~/.bashrc  # ou ~/.zshrc
   nvm install node
   ```

3. **Ajouter Node.js au PATH** :
   Ajoutez ces lignes à votre `~/.bashrc` ou `~/.zshrc` :
   ```bash
   export NVM_DIR="$HOME/.nvm"
   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
   [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
   ```

4. **Recharger la configuration du shell** :
   ```bash
   source ~/.bashrc  # ou ~/.zshrc
   ```

5. **Installer une alternative à coc.nvim si nécessaire** :
   - `YouCompleteMe`
   - `Supertab`
   - Complétion intégrée de Vim (`:help omnicomplete`)

   Pour désactiver temporairement coc.nvim, modifiez votre `.vimrc` :
   ```vim
   " Désactiver coc.nvim temporairement
   let g:coc_disable_startup_warning = 1

   " Configuration des plugins
   call plug#begin('~/.vim/plugged')
   " Commentez ou supprimez la ligne suivante :
   " Plug 'neoclide/coc.nvim', {'branch': 'release'}
   " Gardez les autres plugins...
   call plug#end()
   ```

### Installation de `python3-pip` localement

1. **Téléchargez le script d'installation de `pip`** :
   ```bash
   curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
   ```

2. **Exécutez le script d'installation pour installer `pip` localement** :
   ```bash
   python3 get-pip.py --user
   ```

3. **Ajouter le chemin des binaires locaux à votre variable `PATH`** :
   ```bash
   export PATH=$HOME/.local/bin:$PATH
   ```

4. **Vérifiez l'installation de `pip3`** :
   ```bash
   pip3 --version
   ```

### Installation de `c-formatter-42` avec `pip3`

Une fois `pip3` installé, installez `c-formatter-42` localement :

1. **Installer `c-formatter-42`** :
   ```bash
   pip3 install --user c-formatter-42
   ```

## Conclusion

En suivant ces étapes, vous devriez avoir une configuration Vim fonctionnelle et optimisée pour l'École 42. Si vous rencontrez des problèmes, référez-vous à la section de dépannage ci-dessus pour obtenir des solutions. N'oubliez pas de vérifier les mises à jour de Vim et des plugins pour garantir la meilleure expérience de développement.
