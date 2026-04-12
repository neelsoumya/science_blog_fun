---
name: long-horizon-math-investigator
description: Solve hard, long-horizon mathematical and physics problems through structured multi-session exploration. Maintains a persistent exploration log, strategy register, and periodic synthesis protocol to ensure each session builds on previous work rather than starting from scratch.
version: 1.0
---

# Skill: Long-Horizon Mathematical Investigation

## Purpose

Solve hard mathematical and physics problems that may require many attempts across multiple sessions. This skill enforces a strict logging protocol so that every session begins with full context from prior work and every failed attempt leaves a recoverable artifact — not a dead end.

---

## Session Startup Protocol

At the start of every session, before doing anything else:

1. Read `exploration_log.md` in full.
2. Read the Strategy Register at the top of the log.
3. State aloud which exploration number you are resuming from and what you plan to try next, grounded in what has already been established.

Do not start from scratch. Do not re-derive things already established. Prior sessions left notes — use them.

---

## The Exploration Log

Maintain a file called `exploration_log.md`. After every substantive attempt — successful, failed, or abandoned — update this file **before doing anything else**. Do not start a new attempt until the previous one is logged.

Use the **full format** for substantive attempts (a new strategy, a deep computation, anything that took more than a few minutes). Use the **short format** for quick probes (checking a small example, testing a single property, verifying a side question).

### Short Format (quick probes)

```
## Exploration [number] (probe)

### Strategy
[One sentence.]

### Outcome
[SUCCEEDED / FAILED / ABANDONED]

### Concrete Artifacts
[What you computed or observed. Record in full.]
```

### Full Format (substantive attempts)

```
## Exploration [number]

### Strategy
[One sentence: what approach you tried and why.]

### Outcome
[SUCCEEDED / FAILED / ABANDONED]

### Failure Constraint
[If failed: the specific structural reason it failed. Not "it didn't work" but
"the inductive step requires X to be finite, and we cannot establish finiteness
in this setting." Be precise enough that you could grep for this constraint later.]

### What This Rules Out
[What CLASS of approaches does this failure eliminate? Not just "this specific
attempt" but "any approach that relies on [property] will hit the same obstacle
because [reason]." If you're unsure of the scope, say so and state your best guess.]

### Surviving Structure
[What partial results, constructions, or observations survived even though the
strategy failed? Intermediate lemmas that were proved. Specific examples that
were computed. Structural patterns that were observed. Record as retrievable
artifacts, not as narrative.]

### Reformulations
[Did this attempt reveal an alternative way to state the problem, or make a
hidden structure visible? Record representational insights separately from results —
they are reusable even when the strategy that produced them is not.]

### Concrete Artifacts
[Any specific computed examples, counterexamples, parameter values, or objects
generated during this attempt. Record them in full, not by reference. These are
the raw material for future pattern recognition.]

### Key Parameters
[What parameter ranges, configurations, or settings were tested? What worked
and what did not within those ranges?]

### Open Questions
[What did this attempt make you curious about? What would you check next if
you were continuing in this direction?]
```

---

## The Strategy Register

Maintain a section at the **top** of `exploration_log.md` called **Strategy Register**. Update it after every exploration. It contains three lists:

**Eliminated approach classes:** Approach *types* (not specific attempts) that have been ruled out, with the exploration number and structural reason.
Example: "Approaches requiring cyclic symmetry — ruled out at exploration 12 because the problem lacks Z_n invariance for even n."

**Active structural constraints:** Facts discovered about the problem through attempts, whether or not those attempts succeeded.
Example: "The map must be injective on the fiber over s=0 (discovered exploration 7, confirmed exploration 14)."

**Known reformulations:** Alternative representations of the problem discovered during exploration.
Example: "Fiber coordinates (i,j) with k = (s-i-j) mod m — makes quotient map visible (exploration 15)."

---

## Periodic Synthesis

Every 5 explorations, regardless of whether you are stuck, do the following:

1. Scan **Concrete Artifacts** across all previous explorations for patterns not yet commented on — structural similarities, recurring values, shared substructures across different strategies.
2. Check whether any **Reformulation** suggests an approach not yet tried.
3. Write a synthesis entry in the log, labeled `## Synthesis after exploration [N]`.

This is routine maintenance, not a signal that something is wrong. The most useful cross-pollination often happens before you are stuck.

---

## When You Are Stuck

If you have failed three consecutive attempts and cannot identify a new approach class that is not already eliminated in the Strategy Register, do the following before trying anything else:

1. Re-read the **Concrete Artifacts** from all previous explorations.
2. Look for patterns *across* artifacts from different strategies — structural similarities, recurring values, shared substructures.
3. Re-read the **Surviving Structure** and **Reformulations** from all previous explorations and ask whether any partial result from one strategy could serve as a component in a different strategy.
4. Write a brief synthesis in the log before proceeding.

This is not optional. The solution may be in the residue of previous failures. Check before generating new attempts.

---

## When to Escalate

If the Strategy Register has not changed in 5 explorations — no new eliminated classes, no new structural constraints, no new reformulations — state this explicitly in the log. Then assess:

- Are you generating minor variations of approaches already eliminated? If so, stop.
- Is the periodic synthesis producing new observations? If not, you are grinding.
- Can you articulate what *kind* of insight you are missing? If so, state it — this is the most valuable thing you can hand off to a collaborator.

If you determine you are no longer making structural progress, say so clearly. Do not continue past the point of diminishing returns. A well-documented dead end is more useful than an undocumented spiral.

---

## Logging Rules

- **Log before continuing.** Never start a new attempt without logging the previous one.
- **Record artifacts in full.** Do not refer back to prior entries for computed values — copy them. The log must be self-contained.
- **Distinguish failure types.** A failure due to a missing lemma is different from a failure due to a wrong strategy. Say which.
- **Short format is not a shortcut.** Even quick probes require recording what was actually computed or observed, not just the conclusion.
- **Reformulations are first-class entries.** A new way to see the problem is a result, even if no theorem was proved.

---

## Quality Checklist

Before ending any session, verify:

- The exploration log has been updated for the current attempt.
- The Strategy Register reflects any new eliminated classes, constraints, or reformulations.
- All computed examples, counterexamples, or partial results are recorded in full under **Concrete Artifacts**.
- If 5 explorations have elapsed since the last synthesis, a synthesis entry has been written.
- If stuck, the stuck protocol has been followed before generating any further attempts.
- If escalating, the escalation diagnosis is written explicitly in the log.

---

## Output Expectations

The primary output of each session is an updated `exploration_log.md`. Progress is measured not by theorems proved but by:

- structural constraints discovered
- approach classes definitively eliminated
- partial results preserved as retrievable artifacts
- reformulations that open new directions

A session that ends with a well-documented failure and a sharper Strategy Register is a successful session.
