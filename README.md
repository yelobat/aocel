# aocel.el - Advent Of Code tooling for Emacs.

## Table of contents

- [Installation](#installation)
  - [Manual (Clone)](#manual-clone)
  - [Using straight.el](#straightel)
  - [Doom Emacs](#doom-emacs)
- [Examples](#examples)
- [License](#license)

## Installation

### Manual (Clone)

Execute the following in your terminal:

``` shell
git clone https://github.com/yelobat/aocel.git ~/.emacs.d/aocel
```

Add the directory to your Emacs `load-path` and require the package in your init file:

``` emacs-lisp
(add-to-list 'load-path "~/.emacs.d/aocel")
(require 'aocel)
```

Use `C-c C-e (elisp-eval-region-or-buffer)` or simply restart Emacs for the changes to take effect.

### **`straight.el`**

If you have `straight.el`, simply add the repo via `straight-use-package`:

``` emacs-lisp
(straight-use-package
 '(aocel
   :type git
   :host github
   :repo "yelobat/aocel"))
(require 'aocel)
```

Use `C-c C-e (elisp-eval-region-or-buffer)` or simply restart Emacs for the changes to take effect.

### Doom Emacs

Add the following to your packages.el file:

``` emacs-lisp
(package! aocel
  :recipe (:host github :repo "yelobat/aocel"))
```

And the following to your config.el:

``` emacs-lisp
(use-package! aocel)
```

Run `doom sync` and restart Emacs for the changes to take effect.

## Examples

## License

This project is released under the `MIT License`. See `LICENSE` for more details.

