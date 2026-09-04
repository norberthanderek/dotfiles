---
name: grill-me
description: Interview the user about a plan or design. Use when the user says "grill me", "interview me", or "poke holes in my plan", or hands over a new subsystem with who, why, or the success criterion missing. Not for code review, mechanical edits, or information questions.
license: MIT, see LICENSE
metadata:
  derived-from: "mattpocock/skills grilling (Matt Pocock), addyosmani/agent-skills interview-me (Addy Osmani), obra/superpowers brainstorming (Jesse Vincent), neurofoo/agent-skills socratic"
---

Interview the user relentlessly. Map the work as a design tree, every decision branches into the decisions that hang off it. Needs a live user: in a non-interactive run, report the gaps as a blocker and stop.

## Start with a hypothesis

Read the project (files, docs, recent commits) only until you can state in one sentence what you think the user wants and name which lines of the restate below you cannot fill yet. If the request spans several independent subsystems, name them and ask which one to grill first before anything else. Open every later round with one line on how the picture changed.

## Work in rounds

The **frontier** is every decision whose prerequisites are already settled: the questions you can ask now without guessing at answers you have not heard. Ask at most three frontier questions per round, the ones whose answers could invalidate the most other questions, each with your best guess attached:

```
Q1 <title>: <question, with options where they exist>
Guess: <your answer and the reasoning behind it>
```

For "add a caching layer to our API" a first question looks like:

```
Q1 What hurts: p95 latency, upstream load, or cost?
Guess: latency, because you said "API" and not "bill", and only latency is something callers notice.
```

When two answers are close, guess the one you expect pushback on. A user agreeing with every guess is a signal, not a success.

A question whose answer depends on another question still open belongs to a later round. Wait for the answers, recompute the frontier, ask the next round.

Facts are your job, decisions are the user's. Look facts up (or dispatch a subagent) and keep asking the questions that do not depend on the result.

Dig where the user has not looked: failure modes, who else depends on the interface, what is explicitly out of scope, the strongest argument against the current direction, what it costs if this turns out wrong, and what would change their mind.

## Listen for "should want"

When an answer sounds like best-practice talk ("scalable", "clean architecture", "the standard way") rather than a specific outcome, ask: "If you didn't have to justify this to anyone, what would you actually want?"

## Stop

Stop when no open frontier question could still change the restate, or when you can predict the user's answer to the next three questions you would ask. If three rounds pass without the picture changing, say so and ask whether to step back or restate only what is settled. Do not keep asking.

## Restate and confirm

Write back what you now understand, in the user's own words:

```
Outcome:
User:
Why now:
Success:
Constraint:
Decided:
Out of scope:
Assumed:
```

"Decided" holds every design choice settled in the rounds, one per line. "Out of scope" is never skipped. Where the user answered "I don't know" to a decision, record your guess under `Assumed:` so it is agreed, not smuggled in. The gate is an explicit yes. "Whatever you think" is delegation: re-ask with two concrete options. "Sounds good" is ambiguous: ask what they would refine. Fold corrections in and restate until the yes is explicit. The confirmed restate is the deliverable. Stop there and hand back, planning is a separate request.
