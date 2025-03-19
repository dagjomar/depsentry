# depsentry

A tool that helps you know when you should run `yarn/npm/pnpm install` when someone else have changed your package.json dependencies.

Generally speaking, it is a lightweight file monitoring tool that alerts you when specific files have changed their hash checksum. This makes it a microtool that can be used as part of your custom workflow/pipeline and help track changes in files that are shared between different collaborators, such as in a git repo.

# Example use case and pain point

- Bob and Alice work together on a NextJS project.
- Alice is working on a new feature on a separate branch
- Bob has merged package.json changes as he has upgraded some packages
- Alice rebases her changes on main, because she likes to keep things clean
- Suddenly Alice gets errors when trying to start her project, and doesn't know why.
- After some time she finds that a package dependency throws errors for functions that does not exist - huh! It turns out her node_modules folder contains the old package that does not support new functionality merged in main.
- She asks Bob and he says she needs to run `yarn install` to get the new packages
  that supports new code in main.
- After doing this she is able to continue working on her project
- ...if only something could have given her a heads up about this potential issue!!!

Enter: `depsentry` - the tool that checks and notifies you when this happens.

- If Bob and Alice had added `depsentry` as part of their workflow start script
  it would have told alice that `package.json` had chagned since last time she ran it, and she would have to take some action before attempting to continue working as normal. She would be able to recognize this particular notification warning and know immediately what to do instead of trying to debug errros unnecessarily.

## Installation and usage as a project specific yarn/npm pacakge

- Add it to the project requirements

  `yarn add -D depsentry`
  `npm install --dev depsentry`

- Run the init command to generate a default config file

  `yarn depsentry init`

- Edit the .depsentry configuration file to suit your needs

  Add the files you want to be checked for changes

  ```
  # Example .depsentry config file
  package.json
  ```

- Now, make depsentry run as part of your default dev/start command in your `package.json` file:

  ```json
  ...
  scripts: {
    start: "depsentry && next dev"
  },
  ...
  ```

- Now, you can run the single command `yarn depsentry update` to set the initial state

- Now you are finished, and if the `package.json` file changes in the repo by anyone, yourself included and you try to run `yarn start` then Depsentry will notify you about it and you can choose how you want to deal with it.

- Example scenario is: someone has changed the package dependencies.

  - Depsentry informs you `⚠️  File package.json has changed!`
  - You run `yarn install`
  - You run `yarn depsentry update`
  - You can continue doing what you were supposed to do

## Installation as standalone CLI executable

You can always clone the github repo and make the bin shell file an executable if you want it accessible across your system, and make it behave the way you want it to without needing `yarn` or `npm`, etc.

```bash
# Clone and link
git clone <repository-url>
cd depsentry
chmod +x bin/depsentry
ln -s "$(pwd)/bin/depsentry" /usr/local/bin/depsentry

# Or copy directly
cp bin/depsentry /usr/local/bin/

# Or make an alias to the downloaded file in your .zprofile or .bashrc
alias depsentry="/PATH/TO/FOLDER/depsentry"
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
```
