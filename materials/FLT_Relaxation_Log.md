# Relaxed Fermat's Last Theorem: Exploration Log

## Framing

**Goal:** weaken FLT slightly so that it becomes provable, using only tools available to Fermat (integer arithmetic, congruences, gcds, inequalities, polynomial algebra and the formal derivative of Hudde/Fermat's adequality). Then see exactly which hypothesis of the original theorem carries the difficulty.

**Honest scope:** FLT is already proven (Wiles–Taylor, 1995). Nothing here proves the original theorem. The value is diagnostic: each relaxation that becomes easy tells us what the hard part of FLT actually is.

**Companion file:** `exploration_log.md` (explorations 1–10: descent, cyclotomic factorization, Sophie Germain, Wieferich, Kummer, local obstruction census).

---

## Strategy Register

**Relaxations proved:**

- R1. Consecutive terms, odd n: no solutions to x^n + (x+1)^n = (x+2)^n for odd n ≥ 3.
- R2. Polynomials instead of integers: no coprime nonconstant polynomial solutions to a^n + b^n = c^n for n ≥ 3 (Mason–Stothers argument).

**Relaxations not completed:**

- R1 for even n (the congruence argument gives no information).

**Key diagnostic finding:** R2 works because polynomials have a degree and a derivative; the integers have neither. The integer analogue of Mason's inequality is the abc conjecture, which is open in general.

---

## Relaxation R1: Consecutive terms

### Statement

For odd n ≥ 3, there is no positive integer x with x^n + (x+1)^n = (x+2)^n.

### Proof (congruence, fully elementary)

Reduce modulo x+1. Then x ≡ −1 and x+2 ≡ 1, so the equation becomes (−1)^n + 0 ≡ 1^n. For odd n this reads −1 ≡ 1 (mod x+1), so (x+1) divides 2. Hence x = 1, and the equation becomes 1 + 2^n = 3^n, which is false for every n ≥ 2 (since 3^n > 1 + 2^n).

### Verification

Brute force for odd n from 3 to 15 and x \< 20000 found no solutions, as the proof predicts.

### Limitation (recorded plainly)

For even n the same reduction gives 1 ≡ 1 and says nothing. Reducing modulo x+2 gives (x+2) | 2^n + 1, and reducing modulo x gives x | 2^n − 1, which are constraints but not a contradiction. So the congruence argument does not settle even n by itself.

What still holds for even n: a consecutive solution is in particular a solution of the original equation. Exponents n = 2^k with k ≥ 2 are therefore excluded by Fermat's own n = 4 descent (a solution for n gives one for exponent 4). Even n with an odd prime factor p reduce to exponent p, which is excluded elementarily only for the small primes treated in exploration log 1 (p = 3, and others via later methods). The n = 2 case really does have a consecutive solution, (3, 4, 5).

---

## Relaxation R2: Polynomials instead of integers

### Statement

Over the complex numbers, there are no pairwise coprime polynomials a, b, c, not all constant, with a^n + b^n = c^n for n ≥ 3. (For n = 2 there are solutions, e.g. (t²−1)² + (2t)² = (t²+1)².)

### Lemma (Mason–Stothers)

Let A + B = C with A, B, C pairwise coprime polynomials over a field of characteristic 0, not all constant. Then

max(deg A, deg B, deg C) ≤ deg rad(ABC) − 1,

where rad is the product of the distinct irreducible factors.

### Proof of the lemma

1. Let W = A·B′ − A′·B. It is nonzero: if W = 0 then A/B has zero derivative, so A/B is constant, contradicting coprimality unless both are constant.
2. Because C = A + B, also W = C·B′ − C′·B = A·C′ − A′·C.
3. gcd(A, A′) divides A·B′ and A′·B, hence divides W. The same argument shows gcd(B, B′) and gcd(C, C′) divide W, using the other two expressions for W.
4. These three gcds are pairwise coprime (A, B, C are), so their product divides W.
5. In characteristic 0, deg gcd(A, A′) = deg A − deg rad(A), and likewise for B and C. So the product has degree deg A + deg B + deg C − deg rad(ABC).
6. Leading terms cancel in W, so deg W ≤ deg A + deg B − 1.
7. Combining 4–6: deg A + deg B + deg C − deg rad(ABC) ≤ deg A + deg B − 1, i.e. deg C ≤ deg rad(ABC) − 1. The roles of A, B, C are symmetric, so the same holds for each, hence for the maximum. ∎

### Application to FLT

Set A = a^n, B = b^n, C = c^n and let d = max(deg a, deg b, deg c). Since rad(a^n) = rad(a), we have deg rad(ABC) ≤ deg a + deg b + deg c ≤ 3d. The lemma gives

n·d ≤ 3d − 1,

so n \< 3. Hence no solutions exist for n ≥ 3. ∎

### Verification

- 285 random coprime polynomial triples A + B = C: zero violations of the Mason–Stothers inequality.
- Sharpness at n = 2: a = t²−1, b = 2t, c = t²+1 gives A = a², B = b², C = c² with deg C = 4, while rad(ABC) has degree 5. So 4 ≤ 5 − 1 holds with equality.

### Tools check

Everything used is available in the 17th century in spirit: polynomial gcds (Euclid's algorithm), the formal derivative of a polynomial (Hudde's rule, 1650s, closely tied to Fermat's own method of adequality), and degree counting. The proof as written is a 20th-century discovery (Stothers 1981, Mason 1984), but nothing in it needs later machinery.

---

## Diagnostic Synthesis

| Ingredient | Polynomials k\[t\] | Integers Z |
| --- | --- | --- |
| Size / degree | deg, exact | absolute value, no exactness |
| Derivative | formal d/dt | none |
| Wronskian trick | works | no analogue |
| Radical bound on solutions of A + B = C | **proved** (Mason–Stothers) | **open** (abc conjecture) |
| FLT for n ≥ 3 | **proved in one page** | needs Wiles–Taylor |

The relaxation shows that the hard part of FLT is not the exponent or the factoring of x^n + y^n. It is that the integers lack a derivation, so the clean "radical controls size" mechanism available for polynomials has no known elementary counterpart. The abc conjecture is exactly that missing statement, and it is known to imply FLT for all sufficiently large n.

---

## Open items

- R1 for even n.
- Other candidate relaxations not yet attempted: x, y, z in arithmetic progression; Gaussian-integer version; replacing the equality by a bounded error |x^n + y^n − z^n| ≤ K (this is closely tied to the abc conjecture and is open).

---

## Appendix: verification script

```python
import random
from sympy import symbols, gcd, degree, sqf_part, expand

# R1: consecutive terms, odd n
bad = [(n, x) for n in range(3, 16, 2) for x in range(1, 20000)
       if x**n + (x+1)**n == (x+2)**n]
print("R1 solutions found:", bad)

# R2: Mason-Stothers on random coprime A+B=C
t = symbols('t'); random.seed(1); viol = tested = 0
def rp(d):
    return sum(random.randint(-3, 3)*t**i for i in range(d)) + t**d + random.randint(1, 3)
for _ in range(300):
    A = rp(random.randint(1, 5)); B = rp(random.randint(1, 5)); C = expand(A + B)
    if degree(C, t) <= 0 or gcd(A, B) != 1: continue
    tested += 1
    r = degree(expand(sqf_part(expand(A*B*C))), t)
    if max(degree(A, t), degree(B, t), degree(C, t)) > r - 1: viol += 1
print("R2 tested:", tested, "violations:", viol)
```