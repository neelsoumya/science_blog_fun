---
name: scientific-ai-super-agent
description: >
  A multi-stage agentic pipeline that takes a scientific hypothesis and
  autonomously performs literature review, rapid Python prototyping,
  result verification, and paper writing. The final deliverable is a
  compile-ready LaTeX manuscript (.tex) and matching BibTeX file (.bib).
  Use this skill whenever the user provides a hypothesis, research question,
  or experimental idea and wants the full research-to-paper pipeline executed
  end-to-end. Trigger phrases include: "run the full pipeline", "write a paper
  on my hypothesis", "prototype and publish", "scientific agent", "AI ideator",
  "do the literature review and write it up".
version: 1.0
---

# Skill: Scientific AI Super-Agent

## Purpose

Given a scientific hypothesis (or research question), this skill orchestrates
a complete research pipeline:

1. Hypothesis clarification and decomposition
2. Literature search and review
3. Rapid Python prototyping and experimentation
4. Results extraction and verification
5. Full paper writing in LaTeX
6. Reference compilation into a BibTeX file
7. Compile verification and author review flags

The final outputs are `paper.tex` and `references.bib`, both compile-ready
under `pdflatex` or `xelatex` with the `natbib` package.

---

## Stage 0: Hypothesis Intake

Before any work begins, parse the user's input to extract:

- **Central hypothesis**: the falsifiable claim being investigated.
- **Domain**: the scientific field (e.g., machine learning, computational
  biology, materials science). Infer from context if not stated.
- **Scope constraints**: any limits the user gives on time, compute, or data.
- **Desired output format**: default to a journal-style IMRaD paper unless
  the user specifies a conference, preprint, or letter format.

If the hypothesis is ambiguous or compound, decompose it into sub-questions
and confirm with the user before proceeding.

Placeholder if hypothesis is underspecified: `[HYPOTHESIS NEEDS CLARIFICATION]`

---

## Stage 1: Literature Review Agent

### 1.1 Search Strategy

Use web search and, where available, connected academic databases (e.g., via
MCP connectors for Google Scholar, Semantic Scholar, arXiv, PubMed) to
retrieve relevant papers. Execute the following searches:

- **Direct search**: query using the hypothesis keywords.
- **Background search**: query foundational methods and prior work the
  hypothesis builds on.
- **Counter-evidence search**: actively look for papers that contradict or
  challenge the hypothesis.
- **Recent work search**: filter to the last 3 years to capture the
  state of the art.

Collect at minimum 10 relevant papers. For each paper, extract:

- Authors, year, title, venue, DOI or URL
- Abstract summary (in your own words, do not copy)
- Relevance to the hypothesis (1-2 sentences)
- Key findings or methods used

### 1.2 Reference Classification

Classify every retrieved reference as:

- **Core**: directly tests or supports a claim in the hypothesis.
- **Background**: provides foundational context.
- **Methodological**: describes a technique used in the prototype.
- **Contrasting**: presents conflicting results or alternative views.

### 1.3 Gap Analysis

After reviewing the literature, produce a structured gap analysis:

- What has been shown experimentally?
- What remains unresolved or contested?
- Where does the current hypothesis sit in relation to existing work?
- What is the novel contribution if the hypothesis is confirmed?

This gap analysis feeds directly into the Introduction and Related Work
sections of the paper.

### 1.4 Hallucination Prevention for References

**Never fabricate a citation.** If a paper cannot be verified through
search, mark it `[VERIFY]` in the BibTeX file and note it in the author
review flags. Do not reconstruct bibliographic details from memory.

---

## Stage 2: Ideation and Experimental Design Agent

### 2.1 Hypothesis Decomposition

Break the hypothesis into testable sub-claims. For each sub-claim:

- State the prediction.
- Identify the independent and dependent variables.
- Describe a minimal experiment that could confirm or refute the prediction.

### 2.2 Experimental Plan

Produce a concise experimental plan covering:

- Dataset or data source (real or synthetic).
- Baseline method to compare against.
- Proposed method or model.
- Evaluation metric(s).
- Expected outcome if hypothesis is true.
- Expected outcome if hypothesis is false.

Flag any experiment that requires resources not available in the current
environment with `[RESOURCE NEEDED: ...]`.

---

## Stage 3: Python Prototyping Agent

### 3.1 Code Requirements

Write clean, self-contained Python code that implements the experimental
plan. The code must:

- Run end-to-end without errors.
- Use only standard scientific Python libraries unless the user specifies
  otherwise: `numpy`, `scipy`, `pandas`, `matplotlib`, `scikit-learn`,
  `torch` or `tensorflow` for deep learning tasks.
- Include clear section comments: data loading, preprocessing, model/method,
  evaluation, and visualisation.
- Save all outputs (figures, tables, numeric results) to disk so they can be
  referenced in the paper.
- Print a structured results summary to stdout.

### 3.2 Code Style

- PEP 8 compliant.
- Functions documented with single-line docstrings.
- No hardcoded absolute paths; use relative paths or `pathlib`.
- Random seeds set explicitly for reproducibility.

### 3.3 Output Artefacts

The prototype must produce at minimum:

- `results/results_summary.json` — key numeric results.
- `results/figures/` — one figure per major finding.
- `results/tables/` — LaTeX-formatted tables of results (using
  `tabular` or `booktabs` format).

### 3.4 Error Handling

If the code cannot run due to missing data or compute, do not silently
generate fake results. Instead:

- Produce the code with a clear `[RUN THIS TO GENERATE RESULTS]` comment.
- Insert `[DATA NEEDED]` placeholders in the results sections of the paper.
- List the missing runtime conditions in the author review flags.

---

## Stage 4: Results Verification Agent

### 4.1 Sanity Checks

Before writing the Results section, verify:

- Numeric results are plausible given the domain (e.g., accuracy cannot
  exceed 1.0, loss cannot be negative for standard losses).
- Figures match the reported numbers.
- The baseline comparison is fair (same data split, same evaluation metric).
- No result has been copy-pasted incorrectly from code output.

### 4.2 Statistical Validity

Where applicable, check:

- Results include standard deviation or confidence intervals.
- Sample sizes are reported.
- If statistical tests are used, the test name and p-value are both reported.
- Effect sizes are reported where relevant.

### 4.3 Reproducibility Check

Confirm that the code, with the fixed random seed, produces the same results
on re-run. If stochastic variance is high, report the mean and standard
deviation over multiple runs.

### 4.4 Discrepancy Handling

If any result does not pass a sanity check:

- Flag it with `[VERIFY RESULT: ...]` in the paper draft.
- Note the discrepancy in the author review flags.
- Do not silently round or adjust numbers.

---

## Stage 5: Paper Writing Agent

### 5.1 Output Files

Produce exactly two files:

- `paper.tex` — the main LaTeX manuscript.
- `references.bib` — all BibTeX entries.

Both files must be compile-ready. The command `pdflatex paper.tex` followed
by `bibtex paper` followed by two more `pdflatex paper.tex` runs must
complete without fatal errors.

### 5.2 Document Class and Packages

Use the following default preamble unless the user specifies a journal class:

```latex
\documentclass[12pt,a4paper]{article}

\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{lmodern}
\usepackage{microtype}
\usepackage{amsmath, amssymb}
\usepackage{graphicx}
\usepackage{booktabs}
\usepackage{hyperref}
\usepackage[round]{natbib}
\bibliographystyle{plainnat}
```

If the user specifies a journal (e.g., NeurIPS, ICML, Nature, PLOS ONE),
switch to that class and adjust citation style accordingly. Common overrides:

| Venue         | Class                        | Citation style       |
|---------------|------------------------------|----------------------|
| NeurIPS       | `neurips_2024`               | `\citep{}`           |
| ICML          | `icml2024`                   | `\citep{}`           |
| Nature family | `article` + `unsrtnat`       | numbered             |
| PLOS ONE      | `article` + `plos2015`       | numbered             |
| IEEE          | `IEEEtran`                   | `\cite{}`            |

### 5.3 Manuscript Structure (Default: IMRaD)

1. **Title** — informative and specific; include the key method or finding.
2. **Authors** — use `[AUTHOR NAME]` if not provided.
3. **Abstract** — 150 to 250 words; state the problem, method, key result,
   and implication. No citations in the abstract.
4. **Introduction** — motivate the problem, state the hypothesis, summarise
   contributions, and outline the paper structure.
5. **Related Work** — synthesise the literature review from Stage 1; group
   by theme, not by paper. Cite using `\citet{}` or `\citep{}`.
6. **Methods** — describe the experimental design from Stage 2 and the
   implementation from Stage 3. Enough detail for reproducibility.
7. **Results** — report findings from Stage 3 and verified in Stage 4.
   Use tables and figures produced by the prototype. Reference them with
   `\ref{}`. Do not interpret here; only report.
8. **Discussion** — interpret results, connect back to the hypothesis, discuss
   limitations, and suggest future work.
9. **Conclusion** — restate the hypothesis, summarise what was shown, and
   state the main implication. No new content.
10. **Acknowledgements** — use `[ACKNOWLEDGEMENTS]` placeholder if not provided.
11. **References** — generated by BibTeX; do not write manually.
12. **Appendices** — include full code listings and supplementary figures if
    the paper is long-form.

### 5.4 Writing Rules

- Semiformal academic English.
- No en dashes or em dashes anywhere. Use commas, colons, semicolons, or
  parentheses instead.
- Oxford commas throughout.
- No bullet points in the body prose of the paper.
- Active voice preferred; passive voice acceptable in Methods.
- Define every acronym on first use.
- Consistent terminology: choose one term per concept and use it throughout.
- No hype, no overclaiming, no unsupported superlatives.
- Every quantitative claim must be sourced from either the prototype results
  or a cited reference.

### 5.5 Figures and Tables

- Every figure must have a `\caption{}` and a `\label{}`.
- Every table must use `booktabs` (`\toprule`, `\midrule`, `\bottomrule`).
- Refer to every figure and table in the text before it appears.
- Figures are saved as `.pdf` or `.png` in a `figures/` subdirectory.
- Include `\graphicspath{{figures/}}` in the preamble.

---

## Stage 6: Reference Compilation Agent

### 6.1 BibTeX File Rules

- One entry per unique reference.
- Keys follow the format `firstauthorYEARkeyword` (e.g.,
  `vaswani2017attention`, `lecun1989backprop`).
- All entries use correct BibTeX types: `@article`, `@inproceedings`,
  `@book`, `@misc`, `@preprint`.
- Every entry that could not be fully verified is marked with a comment:
  `% [VERIFY] Missing: <fields>`.
- No entry is fabricated. If a reference from Stage 1 cannot be confirmed,
  include a stub with all unknown fields set to `{[UNKNOWN]}`.

### 6.2 Required BibTeX Fields by Entry Type

| Type             | Required fields                                      |
|------------------|------------------------------------------------------|
| `@article`       | author, title, journal, year, volume, pages, doi     |
| `@inproceedings` | author, title, booktitle, year, pages                |
| `@book`          | author or editor, title, publisher, year             |
| `@misc`          | author, title, year, howpublished or url, note       |

### 6.3 Citation Consistency Check

Before finalising:

- Every `\cite{}` key in `paper.tex` must have a matching entry in
  `references.bib`.
- Every entry in `references.bib` must be cited at least once in `paper.tex`.
- Orphaned entries are removed or moved to a commented-out block.

---

## Stage 7: Compile Verification

### 7.1 Compile Sequence

Run the following sequence and confirm no fatal errors:

```bash
pdflatex paper.tex
bibtex paper
pdflatex paper.tex
pdflatex paper.tex
```

### 7.2 Common Errors to Resolve Before Delivery

- Undefined references (`\ref{}` or `\cite{}` with no matching label or key).
- Missing `\end{}` for any opened environment.
- Figures not found (check path and extension).
- BibTeX warnings about missing fields (fix or mark `[VERIFY]`).
- `Overfull \hbox` warnings in tables (use `\small` or adjust column widths).

### 7.3 If Compilation Cannot Be Run

If the bash environment is unavailable, perform a manual syntax check:

- Every `\begin{...}` has a matching `\end{...}`.
- Every `{` has a matching `}`.
- All `\cite{}` keys exist in the `.bib` file.
- All `\ref{}` labels exist in the `.tex` file.
- No raw Unicode characters outside of properly loaded packages.

Flag any unresolved potential compile errors in the author review section.

---

## Stage 8: Author Review Flags

Append a clearly marked section at the end of `paper.tex` as a LaTeX comment
block (not typeset in the PDF):

```latex
%% ============================================================
%% FLAGS FOR AUTHOR REVIEW — REMOVE BEFORE SUBMISSION
%% ============================================================
```

This block must list:

1. Every `[CITATION NEEDED]` with its location and the claim requiring support.
2. Every `[VERIFY]` BibTeX entry with known and missing fields.
3. Every `[DATA NEEDED]` placeholder with the result that was not generated.
4. Every `[CLARIFY: ...]` note with the ambiguity.
5. Every `[RESOURCE NEEDED]` item from Stage 3.
6. Any structural assumption made during drafting.
7. A compile-readiness summary: "Compiles cleanly" or list of unresolved
   errors.

---

## Hallucination Prevention (Global Rule)

This rule applies to every stage of the pipeline without exception.

- Never invent a result, statistic, figure value, or experimental outcome.
- Never fabricate a citation, author name, journal, volume, page, or DOI.
- Never infer that an experiment "showed X" unless the prototype code
  actually produced that result.
- Never silently paper over a gap with a plausible-sounding claim.
- Use placeholders. Flag everything uncertain. Prefer a shorter, honest
  manuscript over a longer, padded one.

---

## Placeholders Reference

| Placeholder              | Use case                                      |
|--------------------------|-----------------------------------------------|
| `[HYPOTHESIS NEEDS CLARIFICATION]` | Input hypothesis is ambiguous        |
| `[AUTHOR NAME]`          | Author name not provided                      |
| `[YEAR]`                 | Publication year unknown                      |
| `[JOURNAL NAME]`         | Journal or venue unknown                      |
| `[VOLUME/PAGES]`         | Bibliographic detail missing                  |
| `[DOI]`                  | DOI not retrieved                             |
| `[CITATION NEEDED]`      | Claim needs a reference not found             |
| `[DATA NEEDED]`          | Result requires code execution                |
| `[RESOURCE NEEDED: ...]` | Experiment requires unavailable resource      |
| `[VERIFY RESULT: ...]`   | Numeric result failed a sanity check          |
| `[CLARIFY: ...]`         | Ambiguous passage for author to resolve       |
| `[ACKNOWLEDGEMENTS]`     | Acknowledgements not provided                 |
| `[UNKNOWN]`              | BibTeX field cannot be determined             |

---

## Deliverables Checklist

Before closing the pipeline, verify every item:

**Manuscript**
- [ ] `paper.tex` is present and compile-ready.
- [ ] All sections (Title through Conclusion) are present and complete.
- [ ] No fabricated results or citations.
- [ ] All placeholders are present wherever information is missing.
- [ ] No en dashes or em dashes.
- [ ] Oxford commas used throughout.
- [ ] Every figure and table is referenced in the text.

**Code**
- [ ] Prototype code is self-contained and runnable.
- [ ] Results are saved to `results/`.
- [ ] Figures are saved to `results/figures/`.
- [ ] Random seed is fixed.

**References**
- [ ] `references.bib` is present.
- [ ] Every `\cite{}` key in `paper.tex` exists in `references.bib`.
- [ ] Every `references.bib` entry is cited in `paper.tex`.
- [ ] All unverified entries are marked `% [VERIFY]`.

**Compilation**
- [ ] `pdflatex` + `bibtex` sequence completes without fatal errors, or
      all potential errors are listed in the author review flags.

**Author review**
- [ ] Author review flags block is present in `paper.tex`.
- [ ] All gaps, verifications, and assumptions are listed.

---

## Quick-Start Invocation

When a user provides a hypothesis, begin with:

1. Restate the hypothesis in one sentence to confirm understanding.
2. State the domain and paper format you will target.
3. List the stages you are about to execute.
4. Ask for any missing critical information (data source, compute constraints,
   target venue) before starting Stage 1.

If the user says "just go", proceed with best-guess assumptions and flag them
in the author review section.
