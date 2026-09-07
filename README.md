# paws (Profile AWS Switcher)

A lightning-fast, lightweight, and prompt-agnostic Zsh plugin for switching AWS profiles.

`paws` is heavily inspired by and based on [suonto/awsp-zsh-plugin](https://github.com/suonto/awsp-zsh-plugin), refactored from the ground up to eliminate legacy dependencies, maximize performance, and work seamlessly across any shell prompt setup.

## Highlights

* **Prompt-Agnostic:** Operates purely through standard `AWS_PROFILE` environment variables. Works out of the box with Starship, Powerlevel10k, Oh My Zsh, or plain Zsh prompts without hijacking your right prompt (`RPROMPT`).

* **Zero-Overhead Architecture:** Pure Zsh implementation with no external runtime dependencies (no Python, Node.js, or AWS CLI subprocess calls). Adds 0ms to your shell startup time when lazy-loaded and executes in sub-milliseconds.

* **Single Command Workflow:** Switch profiles, view active configs, or unset variables using one simple command.

* **Tab Completion:** Native Zsh completion (`_paws`) built in for profile names and options.

## Installation

Choose the installation method corresponding to your Zsh setup or framework:

### Oh My Zsh

1. Clone the repository into Oh My Zsh's custom plugin directory:

   ```zsh
   git clone https://github.com/dbaber/paws-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/paws-zsh-plugin
   ```

2. Add `paws-zsh-plugin` to your plugin array in `~/.zshrc`:

   ```zsh
   plugins=(
     ...
     paws-zsh-plugin
   )
   ```

### Zinit

Add the following to your `~/.zshrc`:

```zsh
zinit light dbaber/paws-zsh-plugin
```

Or with turbo-mode/lazy-loading:

```zsh
zinit wait lucid for \
  dbaber/paws-zsh-plugin
```

### Antigen

Add the following line to your `~/.zshrc` where other plugins are loaded:

```zsh
antigen bundle dbaber/paws-zsh-plugin
```

### Zplug

Add the following to your `~/.zshrc`:

```zsh
zplug "dbaber/paws-zsh-plugin", defer:2
```

### Znap

Add the following to your `~/.zshrc`:

```zsh
znap source dbaber/paws-zsh-plugin
```

### Manual Installation

1. Clone the repository into your preferred plugins directory:

   ```zsh
   git clone https://github.com/dbaber/paws-zsh-plugin.git "${ZDOTDIR:-$HOME/.config/zsh}/plugins/paws-zsh-plugin"
   ```

2. Add the directory to `fpath` and source the plugin in `~/.zshrc`:

   ```zsh
   fpath=("${ZDOTDIR:-$HOME/.config/zsh}/plugins/paws-zsh-plugin" $fpath)
   source "${ZDOTDIR:-$HOME/.config/zsh}/plugins/paws-zsh-plugin/paws.plugin.zsh"
   autoload -Uz _paws
   ```

## Usage

```text
Usage: paws [PROFILE | -s | -u | -h]

Options:
  <profile>   Switch to specified AWS profile (e.g., paws production)
  -s, --show  Show config block for active AWS_PROFILE
  -u, --unset Unset current AWS_PROFILE environment variable
  -h, --help  Display help message
```

### Examples

* **List available profiles:** Run `paws` with no arguments to list all profiles defined in `~/.aws/config`.

  ```text
  $ paws
  default
  staging
  production
  ```

* **Switch profile:**

  ```text
  $ paws production
  Switched to AWS Profile: production
  ```

* **Inspect active configuration:**

  ```text
  $ paws -s
  [profile production]
  region = us-east-1
  output = json
  ```

* **Unset current profile:**

  ```text
  $ paws -u
  AWS_PROFILE unset.
  ```

### Tab Completion

`paws` includes built-in Zsh autocompletion powered by `_paws`.

Pressing `<TAB>` completes profile names extracted directly from your `~/.aws/config` file as well as command flags:

```text
$ paws <TAB>
default     staging     production   -- -s  -u  -h
```

## License

[MIT](LICENSE) © [dbaber](https://github.com/dbaber)

Based on [suonto/awsp-zsh-plugin](https://github.com/suonto/awsp-zsh-plugin).