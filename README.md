# JavaScript Bookmarklet Builder

This is a port from the Perl script [make_boomarklet.pl](https://gist.github.com/gruber/8658935) by [John Gruber](https://github.com/gruber).

Read the related [article here](http://daringfireball.net/2007/03/javascript_bookmarklet_builder).

# Usage:

```
$ coffee make_bookmarklet.coffee source.js
```

or

```
$ node make_bookmarklet.js source.js
```

# TODO
* Remove spaces before and after the equal sign
* Compare source and target AST
* Add Tests
* Create a Desktop app based on Electron for quick drag-n-drop functionality?
* Create a browser version
