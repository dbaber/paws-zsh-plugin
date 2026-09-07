#!/bin/zsh
# =========================================================
# paws - Profile AWS Switcher
# Lightweight, prompt-agnostic Zsh plugin
# =========================================================

function paws() {
  local profiles
  profiles=$(grep '\[profile' ~/.aws/config 2>/dev/null | sed 's/profile\ //; s/\[//; s/\]//' | sort)

  case "$1" in
    -s|--show)
      if [[ -n "$AWS_PROFILE" ]]; then
        sed -n -e "/\[profile $AWS_PROFILE\]/,/\[/p" ~/.aws/config 2>/dev/null | sed -e '$d'
      else
        echo "AWS_PROFILE is unset" >&2
        return 1
      fi
      ;;
    -u|--unset)
      unset AWS_PROFILE
      echo "AWS_PROFILE unset."
      ;;
    -h|--help)
      echo "Usage: paws [PROFILE | -s | -u | -h]"
      echo ""
      echo "Options:"
      echo "  <profile>   Switch to specified AWS profile"
      echo "  -s, --show  Show configuration for active AWS_PROFILE"
      echo "  -u, --unset Unset the current AWS_PROFILE variable"
      echo "  -h, --help  Show this help message"
      ;;
    "")
      if [[ -z "$profiles" ]]; then
        echo "No profiles found in ~/.aws/config" >&2
        return 1
      fi
      echo "$profiles"
      ;;
    *)
      if ! echo "$profiles" | grep -q -x "$1"; then
        echo "Profile '$1' not found in ~/.aws/config" >&2
        return 1
      fi
      export AWS_PROFILE="$1"
      echo "Switched to AWS Profile: $AWS_PROFILE"
      ;;
  esac
}
