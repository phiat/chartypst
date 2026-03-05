#!/bin/bash
# Pre-push hook: rebuild everything and stage screenshots before git push

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command')

# Only intercept git push commands
if [[ "$COMMAND" != git\ push* ]]; then
  exit 0
fi

echo "Building all artifacts before push..." >&2

if ! just build; then
  cat <<'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Build failed. Fix errors before pushing."
  }
}
EOF
  exit 0
fi

# Stage any updated screenshots and auto-commit
git add screenshots/
if ! git diff --cached --quiet; then
  git commit -m "Regenerate screenshots" >&2
  echo "Auto-committed updated screenshots." >&2
fi

# Allow the push to proceed
cat <<'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "permissionDecisionReason": "Build passed, screenshots up to date"
  }
}
EOF
exit 0
