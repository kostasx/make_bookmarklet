fs       = require 'fs'
filename = process.argv.slice(2)[0]
source   = fs.readFileSync filename, "utf8"

pbcopy = (data)->
    proc = require('child_process').spawn('pbcopy') 
    proc.stdin.write data 
    proc.stdin.end() 

bookmarklet = source.replace /^\s?javascript:/gm, ""            # s{^// ?javascript:.+\n}{};  # Zap the first line if there's already a bookmarklet comment:
bookmarklet = bookmarklet.replace /^\s*\/\/.+/gm, ""            # s{(^\s*//.+\n)}{}gm;  # Kill commented lines
bookmarklet = bookmarklet.replace /^\s*\/\*[^]+?\*\/\n?/gm, ""  # s{^\s*/\*.+?\*/\n?}{}gms; # Kill block comments
bookmarklet = bookmarklet.replace /\t/g, " "                    # s{\t}{ }gm;       # Tabs to spaces
bookmarklet = bookmarklet.replace /[ ]{2,}/g, " "               # s{[ ]{2,}}{ }gm;  # Space runs to one space
bookmarklet = bookmarklet.replace /^\s+/gm, ""                  # s{^\s+}{}gm;      # Kill line-leading whitespace
bookmarklet = bookmarklet.replace /\s+$/gm, ""                  # s{\s+$}{}gm;      # Kill line-ending whitespace
bookmarklet = bookmarklet.replace /\n/gm, ""                    # s{\n}{}gm;        # Kill newlines
bookmarklet = "javascript:" + encodeURIComponent(bookmarklet)   # Escape single- and double-quotes, spaces, control chars, unicode: # $bookmarklet = "javascript:" . uri_escape_utf8($bookmarklet, qq(%'" \x00-\x1f\x7f-\xff));

# DISPLAY CODE TO CONSOLE
console.log bookmarklet

# COPY CODE TO CLIPBOARD (OSX ONLY)
if /^darwin/.test process.platform then pbcopy bookmarklet

