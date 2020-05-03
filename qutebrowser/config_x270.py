import sys, os

# CONFIGURATION {{{
config.load_autoconfig()
# c.backend = 'webkit'
c.new_instance_open_target = 'window'
c.new_instance_open_target_window = 'last-focused'
#c.scrolling.bar = True
c.scrolling.smooth = True
c.auto_save.session = True
c.session.lazy_restore = True
c.downloads.location.suggestion = 'both'
c.downloads.location.directory = '~/Downloads'
c.downloads.location.prompt = False
c.downloads.remove_finished = 5000
# Search Engines
c.url.default_page = 'about:blank'
c.url.searchengines = {
        'DEFAULT' : 'https://duckduckgo.com/?q={}',
        'wk' : 'https://en.wikipedia.org/wiki/{}',
        'yt' : 'https://www.youtube.com/results?search_query={}',
        'g' : 'https://www.google.com/search?q={}',
        'gmaps' : 'https://www.google.com/maps/place/{}',
        'img' : 'https://imgur.com/search?q={}',
        'tpb' : 'https://thepiratebay.org/s/?q={}&=on&page=0&orderby=99',
        'am' : 'https://www.amazon.com/s/field-keywords={}',
        'ml' : 'https://lista.mercadolivre.com.br/{}',
        'ud' : 'http://www.urbandictionary.com/define.php?term={}',
        'aw' : 'https://wiki.archlinux.org/index.php?search={}',
        }
# Tabs
c.tabs.background = True
c.tabs.last_close = 'close'
# c.tabs.title.format = '{private}{index}: {title}'
c.window.title_format = '{private}{perc}{host}'
# Contents
c.content.headers.user_agent = 'Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101 Firefox/57.0'
c.content.headers.custom = {'accept': 'text/html, */*; q=0.01'}
c.content.headers.accept_language = 'en-US,en;q=0.5'
c.content.geolocation = False
c.content.headers.do_not_track = True
c.content.host_blocking.enabled = True
c.content.javascript.enabled = True
c.content.plugins = True
# Zoom
c.zoom.default = '125%'

# BINDINGS
# read mode
config.bind('<Ctrl-r>', 'spawn --userscript readability', mode='normal')
# poket # sp Save Pocket
config.bind('sp', "spawn --userscript qutepocket")
# mpv
mpv_command = 'spawn mpv --ontop --autofit 30% --geometry 100%:100%'
config.bind(';p', 'hint links ' + mpv_command + ' {hint-url}', mode='normal')
config.bind(';P', mpv_command + ' {url}', mode='normal')
# }}}
# LEADER UNITE/DENITE LIKE {{{
config.bind(',b', 'set-cmd-text -s :buffer ', mode='normal')
config.bind('b', 'set-cmd-text -s :buffer', mode='normal')
config.bind(',h', 'set-cmd-text -s :help ', mode='normal')
config.bind(',q', 'set-cmd-text :quickmark-', mode='normal')
config.bind(',m', 'set-cmd-text :bookmark-', mode='normal')
config.bind(',d', 'set-cmd-text :download', mode='normal')
config.bind(',e', 'set-cmd-text :session-load ', mode='normal')
config.bind(',j', 'set-cmd-text :set content.javascript.enabled false', mode='normal')
config.bind(',J', 'set-cmd-text :set content.javascript.enabled true', mode='normal')
# }}}
# Hints{{{
config.bind('f', 'hint', mode='normal')
config.bind('F', 'hint all tab', mode='normal')
config.bind(';f', 'hint all tab-fg', mode='normal')
config.bind(';b', 'hint all tab-bg', mode='normal')
config.bind(';r', 'hint --rapid links tab-bg')
config.bind(';R', 'hint --rapid links window')
config.bind(';w', 'hint all window', mode='normal')
config.bind(';y', 'hint links yank', mode='normal')
config.bind(';a', 'hint inputs', mode='normal')
config.bind(';i', 'hint images', mode='normal')
config.bind(';I', 'hint images tab', mode='normal')
config.bind(';d', 'hint links download', mode='normal')
config.bind(';h', 'hint links hover', mode='normal')
# }}}
# Command Mode {{{
config.bind('<Ctrl-A>', 'rl-beginning-of-line', mode='command')
config.bind('<Ctrl-E>', 'rl-end-of-line', mode='command')
config.bind('<Ctrl-K>', 'rl-unix-line-discard', mode='command')
config.bind('<Ctrl-J>', 'rl-kill-line', mode='command')

config.bind('<Ctrl-B>', 'rl-backward-word', mode='command')
config.bind('<Ctrl-F>', 'rl-forward-word', mode='command')
config.bind('<Ctrl-W>', 'rl-backward-kill-word', mode='command')
# config.bind('<Ctrl->', 'rl-kill-word', mode='command')

config.bind('<Ctrl-D>', 'completion-item-del', mode='command')
config.bind('<Ctrl-H>', 'rl-unix-filename-rubout', mode='command')
config.bind('<Ctrl-Y>', 'rl-yank', mode='command')

config.bind('<Tab>', 'completion-item-focus next', mode='command')
config.bind('<Shift-Tab>', 'completion-item-focus prev', mode='command')

config.bind('<Ctrl-P>', 'command-history-prev', mode='command')
config.bind('<Ctrl-N>', 'command-history-next', mode='command')
config.bind('<Escape>', 'leave-mode', mode='command')
config.bind('<Return>', 'command-accept', mode='command')
# }}}
# Caret Mode {{{
config.bind('<Escape>', 'leave-mode', mode='caret')
config.bind('c', 'enter-mode normal', mode='caret')
config.bind('v', 'toggle-selection', mode='caret')
config.bind('<Space>', 'toggle-selection', mode='caret')
config.bind('<Ctrl-Space>', 'drop-selection', mode='caret')

config.bind('y', 'yank selection', mode='caret')
config.bind('Y', 'yank selection -s', mode='caret')
config.bind('<Return>', 'yank selection', mode='caret')

config.bind('G', 'move-to-end-of-document', mode='caret')
config.bind('gg', 'move-to-start-of-document', mode='caret')
config.bind('[', 'move-to-start-of-prev-block', mode='caret')
config.bind(']', 'move-to-start-of-next-block', mode='caret')
config.bind('{', 'move-to-end-of-prev-block', mode='caret')
config.bind('}', 'move-to-end-of-next-block', mode='caret')
config.bind('$', 'move-to-end-of-line', mode='caret')
config.bind('0', 'move-to-start-of-line', mode='caret')
config.bind('h', 'move-to-prev-char', mode='caret')
config.bind('j', 'move-to-next-line', mode='caret')
config.bind('k', 'move-to-prev-line', mode='caret')
config.bind('l', 'move-to-next-char', mode='caret')
config.bind('w', 'move-to-next-word', mode='caret')
config.bind('b', 'move-to-prev-word', mode='caret')
config.bind('e', 'move-to-end-of-word', mode='caret')
config.bind('H', 'scroll left', mode='caret')
config.bind('J', 'scroll down', mode='caret')
config.bind('K', 'scroll up', mode='caret')
config.bind('L', 'scroll right', mode='caret')
# }}}
# Hint Mode {{{
config.bind('<Ctrl-B>', 'hint all tab-bg', mode='hint')
config.bind('<Ctrl-F>', 'hint links', mode='hint')
config.bind('<Ctrl-R>', 'hint --rapid links tab-bg', mode='hint')
config.bind('<Escape>', 'leave-mode', mode='hint')
config.bind('<Return>', 'follow-hint', mode='hint')
# }}}
# Insert: {{{
config.bind('<Ctrl-E>', 'open-editor', mode='insert')
config.bind('<Escape>', 'leave-mode', mode='insert')
config.bind('<Shift-Ins>', 'insert-text {primary}', mode='insert')
# }}}
# NORMAL MODE {{{
config.bind(':', 'set-cmd-text :', mode='normal')
#Navigation {{{
config.bind('<Ctrl-A>', 'navigate increment', mode='normal')
config.bind('<Ctrl-X>', 'navigate decrement', mode='normal')
config.bind('h', 'scroll left', mode='normal')
config.bind('j', 'scroll down', mode='normal')
config.bind('k', 'scroll up', mode='normal')
config.bind('l', 'scroll right', mode='normal')
config.bind('<Ctrl-B>', 'scroll-page 0 -1', mode='normal')
config.bind('<Ctrl-F>', 'scroll-page 0 1', mode='normal')
config.bind('<Ctrl-D>', 'scroll-page 0 0.5', mode='normal')
config.bind('<Ctrl-U>', 'scroll-page 0 -0.5', mode='normal')
config.bind('G', 'scroll-to-perc 100', mode='normal')
config.bind('gg', 'scroll-to-perc 0', mode='normal')
config.bind('H', 'back', mode='normal')
config.bind('L', 'forward', mode='normal')
config.bind('[[', 'navigate prev', mode='normal')
config.bind(']]', 'navigate next', mode='normal')
config.bind('{{', 'navigate prev -t', mode='normal')
config.bind('}}', 'navigate next -t', mode='normal')
config.bind('r', 'reload', mode='normal')
config.bind('R', 'reload -f', mode='normal')
config.bind('ZQ', 'quit', mode='normal')
config.bind('ZZ', 'quit --save', mode='normal')
config.bind('<Escape>', 'clear-keychain ;; search ;; fullscreen --leave', mode='normal')
config.bind('<Return>', 'follow-selected', mode='normal')
# }}}
# Search {{{
config.bind('/', 'set-cmd-text /', mode='normal')
config.bind('?','set-cmd-text ?', mode='normal')
config.bind('N', 'search-prev', mode='normal')
config.bind('n', 'search-next', mode='normal')
# }}}
# Utils {{{
config.bind('q', 'record-macro', mode='normal')
config.bind('@', 'run-macro', mode='normal')
config.bind('=', 'zoom', mode='normal')
config.bind('+', 'zoom-in', mode='normal')
config.bind('-', 'zoom-out', mode='normal')
# }}}
# Modes {{{
config.bind('i', 'enter-mode insert', mode='normal')
config.bind('v', 'enter-mode caret', mode='normal')
config.bind('`', 'enter-mode set_mark', mode='normal')
config.bind("''", 'enter-mode jump_mark', mode='normal')
config.bind('<Ctrl-V>', 'enter-mode passthrough', mode='normal')
# }}}
#TABS{{{
config.bind('T', 'tab-focus', mode='normal')
config.bind('go', 'tab-only', mode='normal')
config.bind('J', 'tab-next', mode='normal')
config.bind('K', 'tab-prev', mode='normal')
config.bind('th', 'back -t', mode='normal')
config.bind('tl', 'forward -t', mode='normal')
config.bind('D', 'tab-close -o', mode='normal')
config.bind('d', 'tab-close', mode='normal')
config.bind('g$', 'tab-focus -1', mode='normal')
config.bind('g0', 'tab-focus 1', mode='normal')
config.bind('g^', 'tab-focus 1', mode='normal')
config.bind('gC', 'tab-clone', mode='normal')
config.bind('gm', 'tab-move', mode='normal')
config.bind('gl', 'tab-move +', mode='normal')
config.bind('gh', 'tab-move -', mode='normal')
config.bind('gu', 'navigate up', mode='normal')
config.bind('gU', 'navigate up -t', mode='normal')
config.bind('go', 'set-cmd-text :open {url:pretty}', mode='normal')
config.bind('gO', 'set-cmd-text :open -t -r {url:pretty}', mode='normal')
config.bind('u', 'undo', mode='normal')
# }}}
# Paste to{{{
config.bind('po', 'open -- {clipboard}', mode='normal')
config.bind('pb', 'open -b -- {clipboard}', mode='normal')
config.bind('pt', 'open -t -- {clipboard}', mode='normal')
config.bind('pw', 'open -w -- {clipboard}', mode='normal')
# }}}
# Open{{{
config.bind('o', 'set-cmd-text -s :open', mode='normal')
config.bind('O', 'set-cmd-text -s :open -t', mode='normal')
config.bind('wo', 'set-cmd-text -s :open -w', mode='normal')
config.bind('wp', 'set-cmd-text -s :open -p', mode='normal')
config.bind('wh', 'back -w', mode='normal')
config.bind('wl', 'forward -w', mode='normal')
# }}}
# Yanks{{{
config.bind('yd', 'yank domain', mode='normal')
config.bind('yp', 'yank pretty-url', mode='normal')
config.bind('yt', 'yank title', mode='normal')
config.bind('yy', 'yank', mode='normal')
config.bind('yD', 'yank domain -s', mode='normal')
config.bind('yP', 'yank pretty-url -s', mode='normal')
config.bind('yT', 'yank title -s', mode='normal')
config.bind('yY', 'yank -s', mode='normal')
# }}}
# passthrough:
config.bind('Ctrl-V', 'leave-mode', mode='normal')
# Prompt Bindings {{{:
config.bind('<Alt-B>', 'rl-backward-word', mode='prompt')
config.bind('<Alt-Backspace>', 'rl-backward-kill-word', mode='prompt')
config.bind('<Alt-D>', 'rl-kill-word', mode='prompt')
config.bind('<Alt-F>', 'rl-forward-word', mode='prompt')
config.bind('<Ctrl-?>', 'rl-delete-char', mode='prompt')
config.bind('<Ctrl-A>', 'rl-beginning-of-line', mode='prompt')
config.bind('<Ctrl-B>', 'rl-backward-char', mode='prompt')
config.bind('<Ctrl-E>', 'rl-end-of-line', mode='prompt')
config.bind('<Ctrl-F>', 'rl-forward-char', mode='prompt')
config.bind('<Ctrl-H>', 'rl-backward-delete-char', mode='prompt')
config.bind('<Ctrl-K>', 'rl-kill-line', mode='prompt')
config.bind('<Ctrl-U>', 'rl-unix-line-discard', mode='prompt')
config.bind('<Ctrl-W>', 'rl-unix-word-rubout', mode='prompt')
config.bind('<Ctrl-X>', 'prompt-open-download', mode='prompt')
config.bind('<Ctrl-Y>', 'rl-yank', mode='prompt')
config.bind('<Down>', 'prompt-item-focus next', mode='prompt')
config.bind('<Escape>', 'leave-mode', mode='prompt')
config.bind('<Return>', 'prompt-accept', mode='prompt')
config.bind('<Shift-Tab>', 'prompt-item-focus prev', mode='prompt')
config.bind('<Tab>', 'prompt-item-focus next', mode='prompt')
config.bind('<Up>', 'prompt-item-focus prev', mode='prompt')
# }}}
# register:
config.bind('<Escape>', 'leave-mode', mode='register')

# vim: fo=tcq fdm=marker tw=0
