
(dolist (mode
         '(tool-bar-mode                ; No toolbars, more room for text
           menu-bar-mode                ; No menu bar
           scroll-bar-mode              ; No scroll bars either
           blink-cursor-mode))          ; The blinking cursor gets old
  (funcall mode 0))
