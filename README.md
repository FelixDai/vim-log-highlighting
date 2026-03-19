# Vim Log Highlighting

![Log highlighting example](doc/screenshot.jpg)

## Overview

Provides syntax highlighting for generic log files in VIM.

Some of the highlighted elements are:
- **Dates and times**: `2026-03-19`, `12/03/2026`, `19/Mar/2026`, `14:32:05`, `00:03:38.129Z`
- **Common log level keywords**: `ERROR`, `FATAL`, `WARN`, `INFO`, `DEBUG`, `TRACE`, `EMERG`, `CRIT`
- **Numbers**: integers (`1234`), floats (`3.14`), hex (`0x1A2B`)
- **Booleans and strings**: `true`, `false`, `enabled`, `"quoted text"`, `'single quotes'`
- **URLs and file paths**:
  - URLs: `https://example.com/path`, `file://local/file`
  - Absolute paths: `/var/log/messages`, `/home/user/.ssh`
  - Relative paths: `package/base-files/clean`, `var/log/app.log`
  - With prefixes: `./scripts/test.sh`, `../config/file`, `~/.vimrc`
- **IP and MAC addresses**:
  - IPv4: `192.168.1.1`, `10.0.0.1`
  - IPv6: `2001:db8::1`, `::1`, `fe80::1/64`
  - MAC: `00:1A:2B:3C:4D:5E`
- **SysLog format columns**: hostname, program name, process ID
- **XML tags**: `<tag>`, `</closing>`, `<self-closed/>`
- **Exception keywords**: `Exception`, `Throwable`, `Caused by`



## Installation

### [VimPlug](https://github.com/junegunn/vim-plug)

Add `Plug 'mtdl9/vim-log-highlighting'` to your `~/.vimrc` and run `PlugInstall`.

### [Vundle](https://github.com/gmarik/Vundle.vim)

Add `Plugin 'mtdl9/vim-log-highlighting'` to your `~/.vimrc` and run `PluginInstall`.

### [Pathogen](https://github.com/tpope/vim-pathogen)

    $ git clone https://github.com/FelixDai/vim-log-highlighting ~/.vim/bundle/vim-log-highlighting

### Vim8+ Package (Native)

Vim 8.0+ supports native package management without requiring any plugin manager:

    $ mkdir -p ~/.vim/pack/syntax/start
    $ git clone https://github.com/FelixDai/vim-log-highlighting ~/.vim/pack/syntax/start/vim-log-highlighting

Or for an optional/on-demand package (loaded manually with `:packadd log-highlighting`):

    $ mkdir -p ~/.vim/pack/syntax/opt
    $ git clone https://github.com/FelixDai/vim-log-highlighting ~/.vim/pack/syntax/opt/vim-log-highlighting

### Manual Install

Copy the contents of the `ftdetect` and `syntax` folders in their respective ~/.vim/\* counterparts.



## Configuration

Once installed, the syntax highlighting will be enabled by default for files ending with `.log` and `_log` suffixes.

By default only uppercase keywords are recognized as level indicators in the log files.
You can add additional log level keywords using the standard VIM syntax functions, for example by adding this to your `.vimrc` file:

```viml
" Add custom level identifiers
au rc Syntax log syn keyword logLevelError MY_CUSTOM_ERROR_KEYWORD
```

Likewise you can disable highlighting for elements you don't need:

```viml
" Remove highlighting for URLs
au rc Syntax log syn clear logUrl
```



## Related Projects

* VIM Built-in /var/log/messages highlighting
* [vim-log-syntax](https://github.com/dzeban/vim-log-syntax) by dzeban
* [vim-log4j](https://github.com/tetsuo13/Vim-log4j) by tetsuo13
* [ccze](https://github.com/cornet/ccze) by cornet
