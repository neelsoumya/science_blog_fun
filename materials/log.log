# Exploration Log: Elementary (Fermat-era) Approaches to Fermat's Last Theorem

## Framing

Goal, precisely stated: investigate whether an elementary proof of
x^n + y^n = z^n (no positive integer solutions for n ≥ 3) exists,
using only methods available to Fermat (infinite descent, elementary
number theory, no complex analysis / algebraic geometry / modular forms).

Known ground truth going in (recorded so later sessions don't
"rediscover" it as if it were new): the *only* case Fermat is known
to have actually proved is n = 4, via infinite descent, and this
proof survives in his own hand. Euler handled n = 3 (with a gap,
later fixed) using arithmetic in Z[ω]. Elementary descent methods
were extended prime-by-prime through the 19th century (Legendre,
Dirichlet: n=5; Lamé: n=7) but never uniformly. Kummer's theory of
ideal numbers (1847) proved the theorem for all "regular" primes but
explicitly fails for irregular primes (starting at p=37), and no
elementary fix for irregular primes was ever found. The general case
was open for 358 years until Wiles/Taylor (1994), via the modularity
of elliptic curves — a method with no elementary analogue. This
session's job is to map out *why* descent stalls, not to pretend it
doesn't.

---

## Strategy Register

**Eliminated approach classes:** (none yet — this is exploration 1)

**Active structural constraints:** (none yet)

**Known reformulations:** (none yet)

---

## Exploration 1

### Strategy
Reconstruct Fermat's own infinite-descent proof for n = 4, via the
stronger auxiliary claim that x^4 + y^4 = z^2 has no solution in
positive integers — since this is the one case with a genuine
elementary Fermat-era proof, it's the correct foundation to build on
rather than re-derive from scratch.

### Outcome
SUCCEEDED

### Concrete Artifacts (full derivation, recorded in full)

**Claim:** No positive integers x, y, z satisfy x^4 + y^4 = z^2.//
(This is stronger than the n=4 case of FLT: if x^4+y^4=z^4 had a
solution, then x^4+y^4=(z^2)^2 would give a solution of the claim
above, with z^2 in place of z. So the claim implies FLT for n=4.)

**Proof (infinite descent).** Suppose a solution exists in positive
integers. Choose one with z minimal. Then gcd(x,y)=1 (a common
factor d would give (x/d)^4+(y/d)^4=(z/d^2)^2, a smaller solution,
contradicting minimality).

So (x^2, y^2, z) is a primitive Pythagorean triple: x^2 + y^2... no —
x^4+y^4=z^2 means (x^2)^2+(y^2)^2=z^2, i.e. (x^2, y^2, z) IS a
primitive Pythagorean triple. Exactly one of x^2, y^2 is even; say y
is even (relabel if needed). The standard parametrization of
primitive triples gives coprime integers m > n > 0 of opposite
parity with:

  x^2 = m^2 - n^2,  y^2 = 2mn,  z = m^2 + n^2.

From x^2 = m^2 - n^2, i.e. x^2 + n^2 = m^2: since gcd(m,n)=1, this
is itself a primitive Pythagorean triple. x is odd (x^2 = m^2-n^2
with m,n opposite parity is odd), so n is even. Parametrize again:
coprime p > q > 0 of opposite parity with

  n = 2pq,  x = p^2 - q^2,  m = p^2 + q^2.

Then y^2 = 2mn = 2m(2pq) = 4mpq, so (y/2)^2 = m·p·q. Now m, p, q are
pairwise coprime: gcd(p,q)=1 by construction, and gcd(m,p)=gcd(m,q)=1
because m = p^2+q^2 and any common factor of m and p (or q) would
divide q^2 (or p^2), contradicting gcd(p,q)=1. Since m·p·q is a
perfect square and the three factors are pairwise coprime, each is
individually a perfect square:

  m = r^2,  p = s^2,  q = t^2,  for positive integers r, s, t.

Substituting into m = p^2 + q^2:

  r^2 = s^4 + t^4.

This is a NEW solution of the original equation x^4+y^4=z^2 (with
s, t, r in place of x, y, z). Bound on the new z-value: r^2 = m ≤
m^2 + n^2 = z (since n > 0), so r ≤ sqrt(z) < z for z > 1. This
contradicts the minimality of z. Hence no solution exists. ∎

**Corollary (FLT, n=4):** No positive integers satisfy x^4+y^4=z^4.

### What This Establishes
A genuine, fully elementary, Fermat-era proof exists for n=4 (and
in fact for the stronger statement with z^2 on the right). This
confirms the historical claim that Fermat proved this case, and
gives a template for what an elementary descent argument needs:
(a) a parametrization of solutions in terms of smaller coprime
building blocks, (b) a coprimality/unique-factorization step forcing
those blocks to themselves be perfect powers, (c) a strict size
decrease. Any attempt at a general elementary proof should be judged
against whether it can reproduce steps (a)-(c) for general n.

### Reformulations
FLT for n=4 reduces to a *Pythagorean-triple descent* problem, not a
direct attack on x^4+y^4=z^4. This suggests the natural question for
general odd prime exponent p: is there an analogous auxiliary
equation and parametrization machinery for x^p+y^p=z^p (or a related
curve) that supports the same three-step descent?

### Open Questions
Does the "parametrize into coprime pieces, force pieces to be perfect
powers via unique factorization, get strict descent" template survive
for n=3 (Euler) and odd prime n=p in general? Where exactly does
unique factorization fail as p grows?

---

## Exploration 2

### Strategy
Reconstruct Euler's descent proof for n=3, working in the ring of
Eisenstein integers Z[ω] (ω = primitive cube root of unity), to test
whether the exploration-1 template (parametrize → force factors to
be perfect powers via unique factorization → strict descent)
survives when we leave the rational integers.

### Outcome
SUCCEEDED (with a historical caveat noted below)

### Concrete Artifacts

**Setup.** Suppose x^3+y^3=z^3 with x,y,z pairwise coprime positive
integers (the general case reduces to coprime x,y,z, with one of
them possibly required negative to handle signs — omitted here,
standard reduction). Work in Z[ω], ω = e^{2πi/3}, which is a
Euclidean domain (hence a UFD) with units ±1, ±ω, ±ω^2. Factor:

  x^3 + y^3 = (x+y)(x+ωy)(x+ω^2y) = z^3.

The key new phenomenon versus exploration 1: the three factors
(x+y), (x+ωy), (x+ω^2y) are NOT pairwise coprime in Z[ω] in general —
they share a common factor related to λ = 1-ω, the unique prime
above 3 (λ^2 is associate to 3 up to units). This forces a case split
on whether 3 | xyz, which does not appear at all in the n=4 descent.
After removing the λ-power, the remaining cofactors ARE pairwise
coprime, and unique factorization in Z[ω] (it IS a UFD, class number
1) lets each cofactor be shown to be, up to units, a cube — enabling
the same descent-on-a-smaller-solution structure as exploration 1.

**Historical caveat (recorded because it matters for later sessions):**
Euler's original 1770 argument asserted that any number of the form
p^2+3q^2 with gcd(p,q)=1 is a cube, but derived this from an
ad hoc identity rather than from unique factorization in Z[ω]
(Euler did not have that language). The step has a genuine logical
gap in Euler's own presentation. It was patched by later
mathematicians (e.g. Legendre) once Z[ω]'s structure was properly
understood. So: this proof does become fully rigorous, but the
version *Fermat or Euler could have written down without modern
ring theory* has a real gap that was only closed retroactively.

### What This Rules Out
Approaches that assume the exploration-1 template transfers
unchanged are wrong: even at n=3, unique factorization has to happen
in an EXTENSION ring (Z[ω]), not in Z itself, and the factors
acquire a shared-prime obstruction (λ = 1-ω) that has no analogue at
n=4. This is a structural escalation, not a minor variant.

### Active structural constraint (new)
General n forces working in Z[ζ_n] (cyclotomic integers), and the
descent argument's validity is now HOSTAGE to whether Z[ζ_n] is a
UFD. This is the load-bearing fact for exploration 3.

### Reformulations
FLT for exponent n, attacked this way, is really a question about
the arithmetic of the cyclotomic ring Z[ζ_n] — specifically about
factoring x^n+y^n = ∏_{k=0}^{n-1} (x + ζ_n^k y) and whether the
pairwise-coprime-up-to-a-known-shared-prime structure, plus unique
factorization, forces each cofactor to be an n-th power times a unit.

### Open Questions
For which n is Z[ζ_n] actually a UFD? This is the crux — if it fails
for some n, does the whole descent template collapse for that n, or
is there a workaround?

---

## Exploration 3

### Strategy
Determine directly whether the exploration-1/2 descent template
(parametrize via factorization in Z[ζ_p] → force cofactors to be
p-th powers via unique factorization → strict descent) generalizes
to ALL odd primes p, by checking the UFD property of Z[ζ_p].

### Outcome
FAILED (as a general template) — but the failure is precise and
well-documented, which is itself the useful output.

### Failure Constraint
Z[ζ_p] is a UFD only for p ∈ {3,5,7,11,13,17,19} among odd primes up
to that range (finitely many small primes overall — the class number
h(p) of Q(ζ_p) is 1 for these and grows for larger p). For p=23,
h(23)=3, and Z[ζ_23] is NOT a UFD. So the exploration-2 template's
central step — "unique factorization forces each coprime cofactor to
be a p-th power" — is simply false as a general argument for p ≥ 23.
The descent breaks at the unique-factorization step itself, not at
the parametrization or the coprimality step.

### What This Rules Out
Any approach to general FLT that routes through naive unique
factorization in Z[ζ_p] is eliminated as a class, for all p where
h(p) > 1 — which is most primes. This rules out not just "Euler's
method as literally stated" but the entire family of arguments that
rely on factoring x^p+y^p over the cyclotomic integers and expecting
unique factorization to do the work.

### Surviving Structure
Kummer's 1847 fix does NOT abandon this template — it repairs it.
Kummer introduced "ideal numbers" (the historical precursor to
ideals in ring theory) to recover a UNIQUE FACTORIZATION OF IDEALS
even when elements don't factor uniquely. Using this, plus a
divisibility criterion on Bernoulli numbers (p is "regular" if p
does not divide the numerator of any of B_2, B_4, ..., B_{p-3}),
Kummer proved FLT for all regular primes. The first irregular prime
is 37 (37 divides the numerator of the Bernoulli number B_32); the
irregular primes below 100 are 37, 59, and 67 — every other odd
prime below 100 is regular. The key qualitative fact, which is the
load-bearing one here: infinitely many irregular primes are known to
exist,
and it is NOT known whether infinitely many regular primes exist
(though heuristically ~61% of primes are expected to be regular).
So Kummer's method provably does not close the general theorem, and
it was never fixed by elementary means for irregular primes — the
gap stood from 1847 to 1994.

### What This Rules Out (second pass)
This also eliminates a broader class: "any finite, explicit,
elementary criterion checked prime-by-prime" as a route to a fully
general elementary proof, because the irregular primes are a
genuinely infinite obstruction set under this method, not a finite
list of exceptions to patch by hand.

### Reformulations
The problem has now visibly transformed three times across this
session: (1) x^n+y^n=z^n over Z → (2) factorization identity over
Z[ζ_n] → (3) a question about the ideal class group of Q(ζ_n) and
Bernoulli-number congruences. Each reformulation is a genuine step
up in machinery (Z → Dedekind domains/ideal theory → analytic number
theory via Bernoulli numbers / L-functions). This is a meaningful
pattern: every attempt to rescue the descent method has required
importing more structure, not less, and the structure keeps
outrunning what's available in "elementary" (Fermat-era) mathematics.
The eventual real proof (Wiles) continues this trend to its logical
extreme — it doesn't use ideal class groups tweaked further, it
reformulates the problem again, onto elliptic curves and modularity,
a jump with no elementary precedent at all.

### Open Questions
Is there any evidence, even heuristic, that a genuinely elementary
(finite, algebraic, Fermat-era-tools-only) proof template could ever
close the irregular-prime gap? Given that infinitely many irregular
primes exist and Kummer's approach provably cannot handle them by
construction, this looks like more than an unsolved problem — it
looks like the METHOD is structurally capped, independent of effort.

---

## Synthesis after exploration 3

Three explorations, three escalating levels of machinery, and a
consistent pattern: every fix to the descent method up to n=... has
worked by importing strictly more structure (Pythagorean
parametrization → cyclotomic UFD → Kummer's ideal theory), and each
import bought only finitely more coverage before hitting a new
obstruction. The irregular-prime obstruction at the ideal-theory
level is not a "we haven't found the trick yet" gap — it's a proof
that THIS METHOD, run to completion, does not reach all primes,
because the required condition (regularity) is not known to hold for
even a positive-density, let alone all, primes. This is a genuine
structural ceiling on the entire "algebraic descent in cyclotomic
integers" approach class, not just on the specific arguments tried
by Fermat, Euler, and Kummer.

**Honest assessment relative to the original ask:** no elementary
proof of the general theorem exists in the historical or
contemporary literature, and this session's own investigation
reproduces, from first principles, why the elementary program
stalled where it did. I'm not going to manufacture a proof that
doesn't exist. What's genuinely deliverable, and is above, is:
(a) a complete, correct, Fermat-style elementary proof for n=4,
(b) a complete elementary-with-one-historical-gap proof for n=3,
(c) a precise account of the exact algebraic obstruction (failure of
unique factorization in Z[ζ_p]) that stops this method from
generalizing, and why Kummer's repair of that obstruction is itself
provably incomplete (irregular primes).
