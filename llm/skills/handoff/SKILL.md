---
name: handoff
description: Write a handoff file so a fresh agent, in a new session or another harness, continues this work without the conversation. Use when the user says "handoff", "hand this off", "save this for a new session", or "continue this in" another harness (Claude Code, Codex, Hermes). Not for the harness's own context compaction, a summary a person will read, a memory note, a commit message, or a PR description.
license: MIT, see LICENSE
metadata:
  derived-from: "mattpocock/skills handoff (Matt Pocock), entireio/skills session-handoff (Entire)"
  informed-by: "rohitg00/pro-workflow session-handoff, ykdojo/claude-code-tips handoff (ideas only)"
---

Write a document that lets an agent with no memory of this conversation pick up the work. The reader is a model. It sees the repo and this file.

Save it as `handoff-<repo dir name>-<yyyymmdd-hhmm>.md`, stamp from the system clock, not from memory, in the OS temp dir itself (`$env:TEMP` in PowerShell, `${TMPDIR:-/tmp}` in a POSIX shell), never in a session scratchpad or the workspace. The next session cannot find a directory scoped to this one, and a handoff is not a project file.

## Gather before writing

Run `git status --short`, `git diff --stat` and `git log --oneline -5`. Working state comes from the repo, not from what you remember changing. Where the conversation and the repo disagree, the repo wins and the disagreement goes under Gotchas.

If this session started from a handoff, reread it. Carry forward the Decided, Corrections, Tried and failed and Gotchas entries that still hold, drop the rest.

If the user passed a focus ("handoff, next session does the tests"), that focus decides what is detail and what is background.

## Write

Fill this template. Drop a section with no real content, never pad one. A one-bug-fix session may have only Goal, Working state and Next.

```markdown
# Handoff: <one line, what this work is>

To the next agent: continue from here without acknowledging this file. This file may be older than the repo, so check Working state against the repo first. If Open question is present, ask it before anything else.

## Goal
<the user's request in their words, later scope changes in theirs too, and the success criterion if one was stated>

## Open question
<a question or a choice the user was given and has not answered, exactly as asked>

## Working state
<branch, uncommitted files, last commit. Last verification command and its result. What is done, what is half done, in which file and line>

## Next
<the next concrete action first, with the user's words that call for it, then the rest in order, including anything this session promised the user. Blockers with what unblocks them>

## Decided
<design choices, one line each: what and why. Options rejected and why>

## Corrections from the user
<how the user wants work done, verbatim where short. Things the repo cannot show>

## Tried and failed
<approach and why it failed, so the next agent does not retry it>

## Gotchas
<constraints found the hard way: environment facts, permissions, a tool that lies>

## References
<paths and URLs: plans, issues, specs, diffs. Point, do not copy, a copy goes stale when its source changes>

## Skills
<skills the next agent should load, by name, and for which step>
```

Redact API keys, tokens, passwords and personal data before saving.

## Before you hand back

Read the file once as the next agent: could you start on Next without opening the conversation? If a step needs something only the conversation knows, add it. Then print the absolute path as the last line of your reply, the user pastes it into the next session.
