#!/bin/bash

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
REL_DIR="${DIR/#$HOME/~}"

GIT_BRANCH=""
if git rev-parse --git-dir > /dev/null 2>&1; then
  BRANCH=$(git branch --show-current 2>/dev/null)

  # Check for uncommitted changes once
  HAS_CHANGES=false
  if ! git diff-index --quiet HEAD -- 2>/dev/null; then
    HAS_CHANGES=true
  fi

  if [ -n "$BRANCH" ]; then
    # Check for PR information (with per-branch caching)
    REPO_PATH=$(git rev-parse --show-toplevel 2>/dev/null)
    CACHE_KEY=$(echo "${REPO_PATH}_${BRANCH}" | md5)
    CACHE_FILE="/tmp/claude_statusline_pr_${CACHE_KEY}.cache"
    CACHE_TTL=300  # 5 minutes

    PR_DATA=""
    if [ -f "$CACHE_FILE" ]; then
      # Get file modification time (macOS and Linux compatible)
      if [ "$(uname)" = "Darwin" ]; then
        FILE_TIME=$(stat -f %m "$CACHE_FILE" 2>/dev/null)
      else
        FILE_TIME=$(stat -c %Y "$CACHE_FILE" 2>/dev/null)
      fi
      CURRENT_TIME=$(date +%s)
      AGE=$((CURRENT_TIME - FILE_TIME))

      if [ $AGE -lt $CACHE_TTL ]; then
        # Cache is valid, use it
        PR_DATA=$(cat "$CACHE_FILE" 2>/dev/null)
        # Validate cache data (check if it's valid JSON)
        if ! echo "$PR_DATA" | jq -e . >/dev/null 2>&1; then
          PR_DATA=""  # Cache is corrupted, invalidate it
        fi
      fi
    fi

    # Fetch fresh data if cache is invalid or doesn't exist
    if [ -z "$PR_DATA" ] || [ "$PR_DATA" = "null" ]; then
      PR_DATA=$(gh pr view --json number,state,reviewDecision,statusCheckRollup 2>/dev/null)
      # Save to cache
      if [ -n "$PR_DATA" ] && [ "$PR_DATA" != "null" ]; then
        echo "$PR_DATA" > "$CACHE_FILE" 2>/dev/null
      fi
    fi

    if [ -n "$PR_DATA" ] && [ "$PR_DATA" != "null" ]; then
      # Extract PR details
      PR_NUMBER=$(echo "$PR_DATA" | jq -r '.number')
      STATE=$(echo "$PR_DATA" | jq -r '.state')
      REVIEW=$(echo "$PR_DATA" | jq -r '.reviewDecision // "PENDING"')

      # Status icon
      case "$STATE" in
        OPEN) STATE_ICON="🟢" ;;
        MERGED) STATE_ICON="🟣" ;;
        CLOSED) STATE_ICON="🔴" ;;
        *) STATE_ICON="●" ;;
      esac

      # Review decision icon
      case "$REVIEW" in
        APPROVED) REVIEW_ICON="✅" ;;
        CHANGES_REQUESTED) REVIEW_ICON="⚠️" ;;
        REVIEW_REQUIRED) REVIEW_ICON="👀" ;;
        *) REVIEW_ICON="⏳" ;;
      esac

      # CI checks status - aggregate all checks
      CHECK_ICON=""
      CHECKS_JSON=$(echo "$PR_DATA" | jq -r '.statusCheckRollup // [] | map(.state) | join(",")')
      if [ -n "$CHECKS_JSON" ] && [ "$CHECKS_JSON" != "" ]; then
        # Check for any failures first
        if echo "$CHECKS_JSON" | grep -qE "(FAILURE|ERROR)"; then
          CHECK_ICON=" ✗"
        # Then check for any pending/in-progress
        elif echo "$CHECKS_JSON" | grep -qE "(PENDING|EXPECTED|IN_PROGRESS)"; then
          CHECK_ICON=" ⋯"
        # All success
        elif echo "$CHECKS_JSON" | grep -q "SUCCESS"; then
          CHECK_ICON=" ✓"
        fi
      fi

      # Build PR info with dirty marker if needed
      if [ "$HAS_CHANGES" = true ]; then
        GIT_BRANCH=$(printf ' | %s #%s %s%s \033[38;5;208m*\033[0m' "$STATE_ICON" "$PR_NUMBER" "$REVIEW_ICON" "$CHECK_ICON")
      else
        GIT_BRANCH=$(printf ' | %s #%s %s%s' "$STATE_ICON" "$PR_NUMBER" "$REVIEW_ICON" "$CHECK_ICON")
      fi
    else
      # Not on a PR branch, show branch name
      if [ "$HAS_CHANGES" = true ]; then
        GIT_BRANCH=$(printf ' | \033[38;5;208m🌿 %s*\033[0m' "$BRANCH")
      else
        GIT_BRANCH=$(printf ' | 🌿 %s' "$BRANCH")
      fi
    fi
  fi
fi

pct_color() {
  local pct_int=${1%.*}
  if [ "$pct_int" -gt 70 ]; then
    echo "\033[38;5;196m"
  elif [ "$pct_int" -gt 40 ]; then
    echo "\033[38;5;220m"
  else
    echo ""
  fi
}

PERCENT=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
PERCENT_INT=${PERCENT%.*}
[ -z "$PERCENT_INT" ] && PERCENT_INT=0
CTX_COLOR=$(pct_color "$PERCENT_INT")

FIVE_HOUR=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
SEVEN_DAY=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

printf '[%s] 📁 %s%b | Context: %b%.1f%%\033[0m' "$MODEL" "$REL_DIR" "$GIT_BRANCH" "$CTX_COLOR" "$PERCENT"

if [ -n "$FIVE_HOUR" ] || [ -n "$SEVEN_DAY" ]; then
  RATE_LIMIT_STR=""
  if [ -n "$FIVE_HOUR" ]; then
    FH_COLOR=$(pct_color "${FIVE_HOUR%.*}")
    RATE_LIMIT_STR=$(printf '5h: %b%.1f%%\033[0m' "$FH_COLOR" "$FIVE_HOUR")
  fi
  if [ -n "$SEVEN_DAY" ]; then
    SD_COLOR=$(pct_color "${SEVEN_DAY%.*}")
    [ -n "$RATE_LIMIT_STR" ] && RATE_LIMIT_STR="${RATE_LIMIT_STR} | "
    RATE_LIMIT_STR="${RATE_LIMIT_STR}$(printf '7d: %b%.1f%%\033[0m' "$SD_COLOR" "$SEVEN_DAY")"
  fi
  printf '\n%s' "$RATE_LIMIT_STR"
fi
printf '\n'

