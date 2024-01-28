# fenvdir

**fenvdir** is a partially compatible clone of
[envdir(1)](https://cr.yp.to/daemontools/envdir.html)
from
[daemontools](https://en.wikipedia.org/wiki/Daemontools)
for the
[fish shell](https://fishshell.com/).

fenvdir sets environment variables
to the contents of the non-hidden files in a directory.

## Contents

- [Requirements](#requirements)
- [Usage](#usage)
- [Installation](#installation)
- [Comparison with envdir](#comparison-with-envdir)
- [Alternatives](#alternatives)
- [License](#license)

## Requirements

fenvdir requires fish 3.4 or later.
Earlier versions will not work.

## Usage

```none
fenvdir dir [-v|--verbose] [command ...]
```

The flag `-v`/`--verbose` prints fish commands
that correspond to setting the environment variables.
It other words,
it converts the directory to a fish script.
For example:

```fish
> fenvdir d/ --verbose
set -e empty
set -gx foo bar
set -gx no_newline 'hello fish world'
set -gx null_sep hello\nfish\nworld
```

## Installation

### Using Fisher

To install fenvdir with
[Fisher](https://github.com/jorgebucaran/fisher),
run the command:

```fish
fisher install dbohdan/fenvdir
```

### Manual

1. Clone the repository
   or download and extract a source archive.
2. Run `install.fish`.

## Comparison with envdir

fenvdir is not identical to envdir.

- Like envdir:
  - fenvdir trims trailing spaces and tabs.
  - fenvdir converts null bytes to line feeds.
- Unlike envdir:
  - fenvdir reads whole files
into environment variables
    instead of just their first lines.
  - fenvdir requires filenames
    to be valid fish shell identifiers.
    This means that `foo-bar`
    is an acceptable filename for envdir but not fenvdir.

## Alternatives

- [ev-fish](https://github.com/joehillen/ev-fish)&thinsp;—&thinsp;“Load environment variables from files and directories using fish shell, like envdir”

## License

MIT.
