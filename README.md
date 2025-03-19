# depsentry

A lightweight file monitoring tool that alerts you when important files change.

## Installation as a globap npm package

`yarn add -g depsentry`

## Installation as project-specific

`yarn add -D depsentry`

## Installation as standalone shell script

```bash
# Clone and link
git clone <repository-url>
cd depsentry
chmod +x bin/depsentry
ln -s "$(pwd)/bin/depsentry" /usr/local/bin/depsentry

# Or copy directly
cp bin/depsentry /usr/local/bin/
```

## Usage

```bash
# Initialize configuration
depsentry init

# Check files for changes (default command)
depsentry
# or explicitly
depsentry check

# Update stored checksums
depsentry update

# Show current state
depsentry status
```

## Configuration

Create a `.depsentry` file in your project with a list of files to watch.
Example file contents:

```
package.json
yarn.lock
```
