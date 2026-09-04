---
name: writing-for-agents
description: Write a skill, SOUL.md, CLAUDE.md, AGENTS.md, or a reference file a skill points to: text a model executes. Use when the user says "write a skill", "turn this into a skill", "add this to SOUL.md", "the skill didn't trigger", or when a skill misfires (fires on the wrong request, the agent skips a step). Not for prose the user reads or a prompt written once for one run.
license: MIT, see LICENSE
metadata:
  derived-from: "mattpocock/skills writing-for-agents (Matt Pocock), obra/superpowers writing-skills (Jesse Vincent)"
  informed-by: "agentskills.io skill-creation best practices, anthropics/skills skill-creator (ideas only)"
---

The agent runs the same process every time it reads the document, so the document is a program. Always-loaded text (SOUL.md, every skill description) is paid on every turn and earns the hardest pruning. A skill body is paid only when it fires. grill-me and handoff, beside this file, are the worked examples.

## Where it goes

1. A mechanical constraint a check can enforce (lint, hook, test): enforce it, do not write it.
2. A decision tied to one place in code: a WHY comment there.
3. A convention that applies on every turn: one line in SOUL.md.
4. A procedure with steps and a trigger: a skill.
5. Project layout or a repo-specific convention: the project's instruction file, as pointers, not prose.

If the agent already does it without the text, the text is a no-op: delete the whole sentence, not words from it. The test is model-relative, settle it by running, not by debate: before writing, run the task without the skill several times as a fresh agent and read the traces. If the baseline already gets it right, stop.

Scope a skill like a function: one unit of work a request names whole. Too narrow loads two skills per task, too broad fires on the wrong request.

## The description is the trigger

Name and description are all the agent sees before the skill fires, and Claude Code trims descriptions when the listing outgrows its budget, so trigger phrases go before anything else. The description decides when the skill is reached, not how well it works.

- The trigger word first: the verb or noun the model already associates with this job. Then one case per distinct request, with the phrases users actually say for it, several if they differ (grill-me lists four for one case).
- Say when, not how. A workflow summary in the description gets executed instead of the body.
- Name the near misses in a "Not for" clause: a trigger phrase that also fits a different request fires on that request too.
- Fire unasked only on a condition the agent can observe ("two of who, why, success criterion missing"), never on a judgement ("when the task is underspecified").
- The agent reaches for a skill only on work it cannot do offhand, so a description that matches a one-step request may still not fire. Test triggering with realistic multi-step messages, not keywords.

grill-me: `"stress-test my thinking"`, not `"stress-test this"`, which also fits a load test.

## The body is steps

- Source the content from a real run: the steps that worked, the corrections the user made, the facts the baseline got wrong. General knowledge the model already has produces a skill that says "handle errors appropriately".
- Order the steps as the agent performs them. Reference it consults on demand goes below the steps, or into a sibling file with the condition for reading it ("read `MECHANICS.md` when the document is a skill").
- Inline what every path needs, push out what only some paths reach. If a reference file goes unread, sharpen its pointer first and inline the content only if that fails. Keep a concept's definition, rules and caveats under one heading.
- End each step on a criterion the agent can check and that covers the whole task: "every modified model accounted for", not "understanding reached".
- Pick a default. Mention the alternative in one clause, never as a menu.
- One worked example beats another rule. Show output shape as a template, the agent matches a template better than it parses prose about one.
- Keep a gotchas list: facts the agent gets wrong without being told. The second correction of the same mistake is a gotcha.

## Wording

- State the target behaviour. A prohibition drags the banned behaviour into context. Keep a prohibition only as a hard guardrail, and pair it with the positive target.
- Prescribe exactly where the task is fragile or must come out the same each time. Where variation is fine, give the reason and let the agent choose.
- Match the form to the failure:
  - Skips a rule under pressure: a hard rule plus the excuses it will reach for, named.
  - Right task, wrong shape of output: a template.
  - Omits one element: a named slot in the template (grill-me's `Decided:` line, not "remember to list decisions").
  - Depends on a condition: a conditional on an observable predicate. "Unless it matters" reopens the negotiation, and "does not apply to code blocks" still suppresses code blocks, so restructure the rule instead of exempting.
- Pick trigger words and body words the model already holds a strong concept for: "relentless" beats "be thorough". Coin a word only when no existing one fits, and define it once where it first appears.
- The environment is a source of truth. A skill that restates `--help`, package scripts or the directory layout is a cache that goes stale. Write the unwritten convention and the reason behind a choice.
- One place per meaning. A skill that restates SOUL.md doubles the rule's weight and gives it two versions.

## Portability in this base

Claude Code, Codex and Hermes read the same skills directory.

- Frontmatter: agentskills spec fields only (name, description, license, compatibility, metadata, allowed-tools). Claude Code accepts more (`disable-model-invocation` among them) and the validator below passes them, but Hermes ignores them, so every skill must be safe to fire from its description.
- No harness tool names in the body (Read, Edit, skill_view). Say what to do, not which tool.
- No `$ARGUMENTS`. Say "if the user passed a focus".
- Shell and paths in the body work on Windows and Unix, or name both.
- Name equals the directory: lowercase, hyphens, no leading, trailing or double hyphen. From the repo root run `claude plugin validate --strict llm/skills`, which checks Claude Code's view of the frontmatter only.

## Verify by running

Run the task with the skill as many times as the baseline: the runs should converge on one shape. Cut the lines no trace used.
