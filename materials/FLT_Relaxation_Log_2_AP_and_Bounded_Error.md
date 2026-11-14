# Relaxed FLT, Part 2: Arithmetic Progressions and Bounded Error

## Framing

**Goal:** two further relaxations of x^n + y^n = z^n, attacked with elementary tools (congruences, gcds, binomial expansion, inequalities).

**Honest scope:** FLT is already proven (Wiles–Taylor, 1995), so every relaxation below is a special case of a known theorem. The point is which elementary arguments work and where they stop.

**Companion files:** `exploration_log.md` (explorations 1–10) and `flt_relaxation_log.md` (consecutive terms; polynomial version via Mason–Stothers).

---

## Strategy Register

| Relaxation | Status |
| --- | --- |
| AP: x, y, z in arithmetic progression, odd n | **Proved, fully elementary** |
| AP, even n | Reduced to a finite window per n; no solutions found for even n ≤ 4000 (computation, not a proof for all n). Powers of 2: covered by Fermat's n = 4 descent |
| Bounded error, n = 3, error exactly ±1 | **Relaxed statement is FALSE**: explicit infinite family (proved by polynomial identity) |
| Bounded error, n ≥ 4 | Open as a proof. Search finds no small nontrivial near misses for n = 6, 7, 8; heuristic predicts finitely many for n ≥ 4 |

---

## Relaxation AP: x, y, z in arithmetic progression

### Setup

Since z is the largest term it must be an end of the progression. Rename x and y if necessary so the middle term is y: x = y − d, z = y + d with d > 0. The equation becomes

(y − d)^n + y^n = (y + d)^n.

### Lemma 1 (reduce to d = 1)

If g = gcd(y, d) then g divides x, y, z. Dividing through gives a solution with the same shape, so assume gcd(y, d) = 1. Expand:

y^n = (y+d)^n − (y−d)^n = 2·Σ\_{k odd} C(n,k)·y^(n−k)·d^k,

and every term on the right is divisible by d. So d | y^n, and since gcd(d, y) = 1, d = 1. The equation is now

(y−1)^n + y^n = (y+1)^n.

### Theorem (odd n)

For odd n ≥ 3 there is no solution.

**Proof.** Reduce modulo y. Then (y−1)^n ≡ (−1)^n = −1 and (y+1)^n ≡ 1, so the left side is −1 and the right side is 1: y | 2. Hence y = 1 or y = 2. y = 1 gives x = 0, which is not positive. y = 2 gives 1 + 2^n = 3^n, false for n ≥ 2. ∎

### Constraints for even n (all proved)

1. **y is even.** If y were odd, then y ± 1 are even, so the right side of y^n = (y+1)^n − (y−1)^n is even while y^n is odd.
2. **y ≥ 2n.** The expansion above with d = 1 gives y^n ≥ 2n·y^(n−1).
3. **y ≤ 3.3n.** By the mean value theorem (y+1)^n − (y−1)^n ≤ 2n(y+1)^(n−1), so y ≤ 2n(1 + 1/y)^(n−1) \< 2n·e^((n−1)/y) ≤ 2n·e^(1/2) \< 3.3n, using y ≥ 2n.
4. **(y − 1) | 2^n − 1.** Modulo y−1 the equation reads 0 + 1 ≡ 2^n.
5. **(y + 1) | 2^n + 1.** Modulo y+1 (n even) it reads 2^n + 1 ≡ 0.

So for each even n there are at most about 0.65n candidate values of y, each tested by two divisibility conditions.

### Verification

- Brute force with d = 1, n \< 60, y \< 3000: the only solution is n = 2, y = 4, the Pythagorean triple (3, 4, 5).
- Even n from 4 to 4000: window 2n ≤ y ≤ 3.3n, even y, divisibility conditions 4 and 5, then an exact check. **No solutions.** For n = 10, 100, 1000, 3000 the two congruence conditions alone already eliminate every candidate in the window.

### Status

- Odd n: fully proved, elementary.
- Even n: no proof for all n. Powers of 2 (n ≥ 4) are excluded by Fermat's own n = 4 descent. For general even n the problem reduces to a finite window per n, but the window moves with n, so computation to 4000 is evidence, not proof.

### Diagnostic

Even in this restricted shape the odd and even cases behave differently: for odd n a single congruence kills the problem, because (−1)^n changes sign. For even n that sign disappears and the congruences only give divisibility conditions, with no contradiction.

---

## Relaxation BE: bounded error

### Statement of the relaxation

Replace exact equality by |x^n + y^n − z^n| ≤ K for a fixed K ≥ 1, with x, y, z positive integers. (K = 0 is FLT.)

### Result 1 (n = 3, K = 1): the relaxed statement is false

For every positive integer t, with

x = 9t⁴ − 3t, y = 9t³ − 1, z = 9t⁴,

we have

x³ + y³ = z³ − 1.

**Proof.** This is the polynomial identity (9t⁴)³ + (3t − 9t⁴)³ + (1 − 9t³)³ = 1. I verified it symbolically (x³ + y³ − z³ expands to exactly −1) and by exact integer arithmetic for t = 1…3000. Moving the two negative cubes to the other side gives the statement above.

Examples: t = 1 gives (6, 8, 9), i.e. 6³ + 8³ = 728 = 9³ − 1. t = 2 gives (138, 71, 144), and t = 3 gives (720, 242, 729). For t = 2 the gcds are gcd(x, y) = 1, gcd(y, z) = 1 and gcd(x, z) = 6, so these triples are not simply scalings of one small solution.

So for n = 3 there are **infinitely many** near misses with error exactly 1, and the relative error tends to 0. Bounded error is the wrong relaxation for n = 3 if one hopes for finiteness.

### Result 2 (search, n = 3…8)

All x ≤ y \< z ≤ 1200, counting 0 \< |error| ≤ K:

| n | smallest nonzero error found | count K ≤ 1 | K ≤ 10 | K ≤ 100 |
| --- | --- | --- | --- | --- |
| 3 | 1 at (6, 8, 9) | 14 | 50 | 286 |
| 4 | 14 at (1, 1, 2) (trivial) | 0 | 0 | 7 |
| 5 | 12 at (13, 16, 17) | 0 | 0 | 2 |
| 6 | 62 at (1, 1, 2) (trivial) | 0 | 0 | 1 |
| 7 | 126 at (1, 1, 2) (trivial) | 0 | 0 | 0 |
| 8 | 254 at (1, 1, 2) (trivial) | 0 | 0 | 0 |

For n = 6, 7, 8 the only small-error triple in range is the trivial (1, 1, 2), where the error is 2^n − 2.

### Heuristic (labelled as heuristic, not a proof)

Among triples with z in \[N, 2N\] there are about N² pairs (x, y). The n-th powers near z are spaced about n·z^(n−1) apart, so the chance that a given pair lands within K of an n-th power is about K/N^(n−1). The expected number of near misses at scale N is therefore about K·N^(3−n).

- n = 3: a constant per dyadic scale, so the total over all scales diverges and infinitely many are expected. This matches Result 1.
- n ≥ 4: a decaying power of N per scale, so only finitely many are expected for each K.

This predicts the pattern in the table, but proving that the count is finite for n ≥ 4 is a Diophantine-approximation problem of the same difficulty class as the abc conjecture. I do not have an elementary proof, and I am not claiming one.

### Status

- n = 3, K ≥ 1: relaxed statement is false (infinite family).
- n ≥ 4: unresolved by elementary means; evidence and heuristic point to finitely many near misses for each K.

---

## Synthesis

1. **AP relaxation:** one congruence solves odd n completely. The difficulty returns exactly when (−1)^n loses its sign, i.e. for even n.
2. **Bounded error:** the borderline exponent is n = 3. At n = 3 the heuristic count diverges and a genuine polynomial identity produces infinitely many near misses. From n = 4 onwards the count converges and near misses become rare, but proving finiteness is a hard open-type problem.
3. **Across all relaxations so far** (consecutive terms, polynomials, AP, bounded error), the elementary arguments that work are the ones where an extra structure (a sign, a degree, a derivative) makes a congruence or inequality decisive. The original problem has none of these, which is consistent with the earlier explorations.

## Appendix: scripts

Scripts used: `ap_relax.py` (brute force, window, congruence filters) and `bounded_error.py` (symbolic identity check, exact check for t ≤ 3000, near-miss search with N = 1200 for n = 3…8).