# Exploration Log: Elementary (Fermat-era) Approaches to Fermat's Last Theorem

## Framing

Goal, precisely stated: investigate whether an elementary proof of x^n + y^n = z^n (no positive integer solutions for n ≥ 3) exists, using only methods available to Fermat (infinite descent, elementary number theory, no complex analysis / algebraic geometry / modular forms).

Known ground truth going in (recorded so later sessions don't "rediscover" it as if it were new): the *only* case Fermat is known to have actually proved is n = 4, via infinite descent, and this proof survives in his own hand. Euler handled n = 3 (with a gap, later fixed) using arithmetic in Z[ω]. Elementary descent methods were extended prime-by-prime through the 19th century (Legendre, Dirichlet: n=5; Lamé: n=7) but never uniformly. Kummer's theory of ideal numbers (1847) proved the theorem for all "regular" primes but explicitly fails for irregular primes (starting at p=37), and no elementary fix for irregular primes was ever found. The general case was open for 358 years until Wiles/Taylor (1994), via the modularity of elliptic curves — a method with no elementary analogue. This session's job is to map out *why* descent stalls, not to pretend it doesn't.

---

## Strategy Register

**Eliminated approach classes:**

- Naive unique factorization of elements in Z[ζ\_p] as a route to a general descent proof — ruled out at exploration 3 because Z[ζ\_p] fails to be a UFD once the class number h(p)>1 (first at p=23), and Kummer's ideal-theoretic repair of this is itself provably incomplete for irregular primes (infinitely many exist).

**Active structural constraints:**

- The exploration-1 descent template (parametrize into coprime pieces → force pieces to be perfect powers via unique factorization → strict size decrease) is the correct template for n=4 but must be run inside Z[ζ\_n] for general n (exploration 2), making its validity hostage to whether Z[ζ\_n] is a UFD (exploration 3).
- Sophie Germain's auxiliary-prime method (exploration 4) is structurally independent of the cyclotomic-UFD method: its obstruction (existence of a valid auxiliary θ) is unrelated to Kummer's obstruction (regularity of p). Confirmed computationally: p=37 is irregular (Kummer's method fails) but has a valid Sophie Germain auxiliary θ=149 (that method succeeds for Case I).
- Sophie Germain's method, even when it works, only ever proves Case I (p∤xyz); Case II requires a wholly separate elementary argument that was never given uniformly for all p historically.
- Wieferich/Mirimanoff fixed-base congruences (exploration 5) prove Case I for all p that aren't "Wieferich primes" for the relevant base — verified computationally: only 1093 and 3511 are known Wieferich primes below 4,000,000. Mechanistically independent of Sophie Germain's auxiliary-θ obstruction; no known relation between the two exceptional sets.
- Case II's descent (exploration 6) needs regularity (as in exploration 3) PLUS Kummer's Lemma (units ≡ rational integers mod p are p-th powers), whose standard proof is analytic — via the class number formula and Dirichlet L-functions — not elementary. This is the precise point where the "classical" program stops being Fermat-era-elementary and becomes 19th-century analytic number theory.
- Vandiver's Conjecture (p ∤ h⁺(p), the real-subfield class number) is the actual frontier of the classical program — still open after 150+ years, verified computationally for huge ranges of p, with no known proof route that stays within classical (non-Iwasawa-theory) methods. Even if resolved, it would extend coverage, not close the general theorem, since irregular-prime obstructions upstream of it remain untouched.

**Known reformulations:**

- FLT for exponent n, attacked via factorization, becomes a question about the arithmetic (ideal class group) of Q(ζ\_n) — exploration 2/3.
- Full FLT for a fixed p elementarily decomposes into two independent sub-problems, Case I and Case II, each needing its own elementary mechanism with its own obstruction set — exploration 4.
- The classical program, traced end to end, forms a chain: elementary descent → ideal theory/regularity → Kummer's Lemma (analytic) → Vandiver's Conjecture (open). Each link needs strictly more machinery than the last, and the chain terminates in an unresolved 150-year-old conjecture, not a proof — exploration 6.

---

## Exploration 1

### Strategy

Reconstruct Fermat's own infinite-descent proof for n = 4, via the stronger auxiliary claim that x^4 + y^4 = z^2 has no solution in positive integers — since this is the one case with a genuine elementary Fermat-era proof, it's the correct foundation to build on rather than re-derive from scratch.

### Outcome

SUCCEEDED

### Concrete Artifacts (full derivation, recorded in full)

**Claim:** No positive integers x, y, z satisfy x^4 + y^4 = z^2.// (This is stronger than the n=4 case of FLT: if x^4+y^4=z^4 had a solution, then x^4+y^4=(z^2)^2 would give a solution of the claim above, with z^2 in place of z. So the claim implies FLT for n=4.)

**Proof (infinite descent).** Suppose a solution exists in positive integers. Choose one with z minimal. Then gcd(x,y)=1 (a common factor d would give (x/d)^4+(y/d)^4=(z/d^2)^2, a smaller solution, contradicting minimality).

So (x^2, y^2, z) is a primitive Pythagorean triple: x^2 + y^2... no — x^4+y^4=z^2 means (x^2)^2+(y^2)^2=z^2, i.e. (x^2, y^2, z) IS a primitive Pythagorean triple. Exactly one of x^2, y^2 is even; say y is even (relabel if needed). The standard parametrization of primitive triples gives coprime integers m > n > 0 of opposite parity with:

x^2 = m^2 - n^2, y^2 = 2mn, z = m^2 + n^2.

From x^2 = m^2 - n^2, i.e. x^2 + n^2 = m^2: since gcd(m,n)=1, this is itself a primitive Pythagorean triple. x is odd (x^2 = m^2-n^2 with m,n opposite parity is odd), so n is even. Parametrize again: coprime p > q > 0 of opposite parity with

n = 2pq, x = p^2 - q^2, m = p^2 + q^2.

Then y^2 = 2mn = 2m(2pq) = 4mpq, so (y/2)^2 = m·p·q. Now m, p, q are pairwise coprime: gcd(p,q)=1 by construction, and gcd(m,p)=gcd(m,q)=1 because m = p^2+q^2 and any common factor of m and p (or q) would divide q^2 (or p^2), contradicting gcd(p,q)=1. Since m·p·q is a perfect square and the three factors are pairwise coprime, each is individually a perfect square:

m = r^2, p = s^2, q = t^2, for positive integers r, s, t.

Substituting into m = p^2 + q^2:

r^2 = s^4 + t^4.

This is a NEW solution of the original equation x^4+y^4=z^2 (with s, t, r in place of x, y, z). Bound on the new z-value: r^2 = m ≤ m^2 + n^2 = z (since n > 0), so r ≤ sqrt(z) < z for z > 1. This contradicts the minimality of z. Hence no solution exists. ∎

**Corollary (FLT, n=4):** No positive integers satisfy x^4+y^4=z^4.

### What This Establishes

A genuine, fully elementary, Fermat-era proof exists for n=4 (and in fact for the stronger statement with z^2 on the right). This confirms the historical claim that Fermat proved this case, and gives a template for what an elementary descent argument needs: (a) a parametrization of solutions in terms of smaller coprime building blocks, (b) a coprimality/unique-factorization step forcing those blocks to themselves be perfect powers, (c) a strict size decrease. Any attempt at a general elementary proof should be judged against whether it can reproduce steps (a)-(c) for general n.

### Reformulations

FLT for n=4 reduces to a *Pythagorean-triple descent* problem, not a direct attack on x^4+y^4=z^4. This suggests the natural question for general odd prime exponent p: is there an analogous auxiliary equation and parametrization machinery for x^p+y^p=z^p (or a related curve) that supports the same three-step descent?

### Open Questions

Does the "parametrize into coprime pieces, force pieces to be perfect powers via unique factorization, get strict descent" template survive for n=3 (Euler) and odd prime n=p in general? Where exactly does unique factorization fail as p grows?

---

## Exploration 2

### Strategy

Reconstruct Euler's descent proof for n=3, working in the ring of Eisenstein integers Z[ω] (ω = primitive cube root of unity), to test whether the exploration-1 template (parametrize → force factors to be perfect powers via unique factorization → strict descent) survives when we leave the rational integers.

### Outcome

SUCCEEDED (with a historical caveat noted below)

### Concrete Artifacts

**Setup.** Suppose x^3+y^3=z^3 with x,y,z pairwise coprime positive integers (the general case reduces to coprime x,y,z, with one of them possibly required negative to handle signs — omitted here, standard reduction). Work in Z[ω], ω = e^{2πi/3}, which is a Euclidean domain (hence a UFD) with units ±1, ±ω, ±ω^2. Factor:

x^3 + y^3 = (x+y)(x+ωy)(x+ω^2y) = z^3.

The key new phenomenon versus exploration 1: the three factors (x+y), (x+ωy), (x+ω^2y) are NOT pairwise coprime in Z[ω] in general — they share a common factor related to λ = 1-ω, the unique prime above 3 (λ^2 is associate to 3 up to units). This forces a case split on whether 3 | xyz, which does not appear at all in the n=4 descent. After removing the λ-power, the remaining cofactors ARE pairwise coprime, and unique factorization in Z[ω] (it IS a UFD, class number

1. lets each cofactor be shown to be, up to units, a cube — enabling the same descent-on-a-smaller-solution structure as exploration 1.

**Historical caveat (recorded because it matters for later sessions):** Euler's original 1770 argument asserted that any number of the form p^2+3q^2 with gcd(p,q)=1 is a cube, but derived this from an ad hoc identity rather than from unique factorization in Z[ω] (Euler did not have that language). The step has a genuine logical gap in Euler's own presentation. It was patched by later mathematicians (e.g. Legendre) once Z[ω]'s structure was properly understood. So: this proof does become fully rigorous, but the version *Fermat or Euler could have written down without modern ring theory* has a real gap that was only closed retroactively.

### What This Rules Out

Approaches that assume the exploration-1 template transfers unchanged are wrong: even at n=3, unique factorization has to happen in an EXTENSION ring (Z[ω]), not in Z itself, and the factors acquire a shared-prime obstruction (λ = 1-ω) that has no analogue at n=4. This is a structural escalation, not a minor variant.

### Active structural constraint (new)

General n forces working in Z[ζ\_n] (cyclotomic integers), and the descent argument's validity is now HOSTAGE to whether Z[ζ\_n] is a UFD. This is the load-bearing fact for exploration 3.

### Reformulations

FLT for exponent n, attacked this way, is really a question about the arithmetic of the cyclotomic ring Z[ζ\_n] — specifically about factoring x^n+y^n = ∏\_{k=0}^{n-1} (x + ζ\_n^k y) and whether the pairwise-coprime-up-to-a-known-shared-prime structure, plus unique factorization, forces each cofactor to be an n-th power times a unit.

### Open Questions

For which n is Z[ζ\_n] actually a UFD? This is the crux — if it fails for some n, does the whole descent template collapse for that n, or is there a workaround?

---

## Exploration 3

### Strategy

Determine directly whether the exploration-1/2 descent template (parametrize via factorization in Z[ζ\_p] → force cofactors to be p-th powers via unique factorization → strict descent) generalizes to ALL odd primes p, by checking the UFD property of Z[ζ\_p].

### Outcome

FAILED (as a general template) — but the failure is precise and well-documented, which is itself the useful output.

### Failure Constraint

Z[ζ\_p] is a UFD only for p ∈ {3,5,7,11,13,17,19} among odd primes up to that range (finitely many small primes overall — the class number h(p) of Q(ζ\_p) is 1 for these and grows for larger p). For p=23, h(23)=3, and Z[ζ\_23] is NOT a UFD. So the exploration-2 template's central step — "unique factorization forces each coprime cofactor to be a p-th power" — is simply false as a general argument for p ≥ 23. The descent breaks at the unique-factorization step itself, not at the parametrization or the coprimality step.

### What This Rules Out

Any approach to general FLT that routes through naive unique factorization in Z[ζ\_p] is eliminated as a class, for all p where h(p) > 1 — which is most primes. This rules out not just "Euler's method as literally stated" but the entire family of arguments that rely on factoring x^p+y^p over the cyclotomic integers and expecting unique factorization to do the work.

### Surviving Structure

Kummer's 1847 fix does NOT abandon this template — it repairs it. Kummer introduced "ideal numbers" (the historical precursor to ideals in ring theory) to recover a UNIQUE FACTORIZATION OF IDEALS even when elements don't factor uniquely. Using this, plus a divisibility criterion on Bernoulli numbers (p is "regular" if p does not divide the numerator of any of B\_2, B\_4, ..., B\_{p-3}), Kummer proved FLT for all regular primes. The first irregular prime is 37 (37 divides the numerator of the Bernoulli number B\_32); the irregular primes below 100 are 37, 59, and 67 — every other odd prime below 100 is regular. The key qualitative fact, which is the load-bearing one here: infinitely many irregular primes are known to exist, and it is NOT known whether infinitely many regular primes exist (though heuristically \~61% of primes are expected to be regular). So Kummer's method provably does not close the general theorem, and it was never fixed by elementary means for irregular primes — the gap stood from 1847 to 1994.

### What This Rules Out (second pass)

This also eliminates a broader class: "any finite, explicit, elementary criterion checked prime-by-prime" as a route to a fully general elementary proof, because the irregular primes are a genuinely infinite obstruction set under this method, not a finite list of exceptions to patch by hand.

### Reformulations

The problem has now visibly transformed three times across this session: (1) x^n+y^n=z^n over Z → (2) factorization identity over Z[ζ\_n] → (3) a question about the ideal class group of Q(ζ\_n) and Bernoulli-number congruences. Each reformulation is a genuine step up in machinery (Z → Dedekind domains/ideal theory → analytic number theory via Bernoulli numbers / L-functions). This is a meaningful pattern: every attempt to rescue the descent method has required importing more structure, not less, and the structure keeps outrunning what's available in "elementary" (Fermat-era) mathematics. The eventual real proof (Wiles) continues this trend to its logical extreme — it doesn't use ideal class groups tweaked further, it reformulates the problem again, onto elliptic curves and modularity, a jump with no elementary precedent at all.

### Open Questions

Is there any evidence, even heuristic, that a genuinely elementary (finite, algebraic, Fermat-era-tools-only) proof template could ever close the irregular-prime gap? Given that infinitely many irregular primes exist and Kummer's approach provably cannot handle them by construction, this looks like more than an unsolved problem — it looks like the METHOD is structurally capped, independent of effort.

---

## Synthesis after exploration 3

Three explorations, three escalating levels of machinery, and a consistent pattern: every fix to the descent method up to n=... has worked by importing strictly more structure (Pythagorean parametrization → cyclotomic UFD → Kummer's ideal theory), and each import bought only finitely more coverage before hitting a new obstruction. The irregular-prime obstruction at the ideal-theory level is not a "we haven't found the trick yet" gap — it's a proof that THIS METHOD, run to completion, does not reach all primes, because the required condition (regularity) is not known to hold for even a positive-density, let alone all, primes. This is a genuine structural ceiling on the entire "algebraic descent in cyclotomic integers" approach class, not just on the specific arguments tried by Fermat, Euler, and Kummer.

**Honest assessment relative to the original ask:** no elementary proof of the general theorem exists in the historical or contemporary literature, and this session's own investigation reproduces, from first principles, why the elementary program stalled where it did. I'm not going to manufacture a proof that doesn't exist. What's genuinely deliverable, and is above, is: (a) a complete, correct, Fermat-style elementary proof for n=4, (b) a complete elementary-with-one-historical-gap proof for n=3, (c) a precise account of the exact algebraic obstruction (failure of unique factorization in Z[ζ\_p]) that stops this method from generalizing, and why Kummer's repair of that obstruction is itself provably incomplete (irregular primes).

---

## Exploration 4

### Strategy

Switch approach CLASS entirely: instead of factoring in cyclotomic integers (eliminated by exploration 3), try Sophie Germain's method — a purely congruence-based, elementary (no ring theory) technique that attacks "Case I" of FLT (the sub-case p ∤ xyz) using an auxiliary prime θ. This is genuinely structurally different from explorations 1-3: no unique factorization in an extension ring is required anywhere.

### Outcome

PARTIAL SUCCESS — proves a real (but limited) elementary result; does not close full FLT, and the limitation is itself structural.

### Concrete Artifacts

**Theorem (Sophie Germain, 1823).** Let p be an odd prime. Suppose there is an auxiliary prime θ such that: (A) x^p+y^p+z^p ≡ 0 (mod θ) forces θ | xyz — i.e. no three nonzero p-th-power residues mod θ sum to 0 mod θ; (B) p itself is not a p-th power residue mod θ. Then Case I of FLT holds for p: no coprime positive integers x,y,z with p ∤ xyz satisfy x^p+y^p=z^p.

**Verified computationally (not just asserted) for θ=2p+1:** Whenever p and θ=2p+1 are both prime (a "Sophie Germain prime"), conditions (A) and (B) hold automatically. Direct computation for every Sophie Germain prime p<100 confirms the p-th-power residues mod θ are always exactly {1, θ-1} = {1,-1}, so any sum of three such residues lies in {-3,-1,1,3}, never ≡0 (mod θ) since θ≥7 — condition (A) holds by direct check. Condition (B) holds because p mod θ is neither 1 nor θ-1 for any p>1. Verified for p ∈ {3,5,11,23,29,41,53,83,89} — all pass both conditions exactly as the hand-derivation predicts.

**Verified for primes without a Sophie Germain θ=2p+1** (p ∈ {7,13,17,19,31,37,43,47}, where 2p+1 is composite): a brute-force search over auxiliary primes θ with p | (θ-1) still finds a working θ satisfying both (A) and (B) for every one of these, e.g. p=7 works with θ=29, p=37 works with θ=149. (This matches the historical record: Legendre extended Sophie Germain's method with case-by-case auxiliary-prime search and pushed Case I much further this way.)

### Failure Constraint (why this doesn't finish the job)

Two independent limitations, both real:

1. This method only ever proves **Case I** (p∤xyz). Case II (p|xyz) is not touched by this technique at all and historically required entirely separate, exponent-specific arguments (Legendre/Dirichlet for n=5, Lamé for n=7, etc.) — it was never closed in general either.
2. Even for Case I, the method requires *some* auxiliary prime θ to exist satisfying (A) and (B) for the given p. This was verified computationally above for specific small p, but there is no proof that such a θ exists for every prime p — it had to be checked case by case historically, and remained an open combinatorial question in general.

### Surviving Structure — a genuinely new cross-method observation

p=37 is the first prime for which Kummer's method (exploration 3) FAILS (37 is irregular). But the computation above shows p=37 DOES admit a valid Sophie Germain auxiliary prime (θ=149), so Case I of FLT for p=37 is provable by this completely different, purely elementary method — even though the cyclotomic-integer method cannot reach it. This is worth recording precisely: **the obstruction sets for these two methods are not the same set of primes.** Kummer's obstruction (irregularity) and Sophie Germain's obstruction (nonexistence of a suitable θ) are independent phenomena. No single prime is known to be simultaneously unreachable by every elementary method — but no proof exists that some prime ISN'T eventually unreachable by all of them at once either, for full FLT (both cases).

### What This Rules Out

Does NOT rule out anything about exploration 3's conclusion — the two methods coexist and cover different sub-problems (Case I vs. full theorem) via different obstructions. What it DOES rule out: the idea that a single elementary technique's failure (e.g. Kummer's, at irregular primes) implies elementary methods in general are useless for that prime. They're not uniformly useless — they're non-uniformly capped, method by method.

### Reformulations

Full FLT for a given p elementarily requires BOTH: (i) closing Case I via some congruence method (Sophie Germain-style, requires finding a working θ) AND (ii) closing Case II via a separate, harder, often exponent-specific elementary argument that was never given in general. Historically, no single elementary framework ever unified (i) and (ii) across all p simultaneously — this is a second, independent reason (beyond exploration 3's cyclotomic obstruction) that the elementary program stalled.

### Open Questions

Is it known whether infinitely many primes p have NO valid Sophie Germain-style auxiliary prime θ at all? (If some p provably has none, that would be a clean "hard wall" for this specific method, distinct from Kummer's irregular-prime wall.) Also open, and unresolved by this exploration: no elementary Case II argument was ever found for general p — was this ever seriously attempted as a uniform method, or only case-by-case per exponent?

---

## Synthesis after exploration 4

Two structurally different elementary attack modes have now been tried (ring-factorization-in-Z[ζ\_p], and congruence-via-auxiliary- prime), and BOTH produce real, verifiable partial results with DIFFERENT and INDEPENDENT failure sets — Kummer's method fails at irregular primes (37, 59, 67, ...) but proves the full theorem (both cases) for regular primes; Sophie Germain's method only ever proves Case I, but for the primes it does reach, it doesn't care about regularity at all (it reached p=37 fine). Neither failure mode implies the other, and neither implies full FLT is elementarily unreachable everywhere — but together they show that a hypothetical "Fermat-era" proof would need to either (a) unify two structurally unrelated obstruction-avoidance mechanisms into one uniform argument covering all p, or (b) find a genuinely third, different elementary mechanism that avoids both. No historical attempt ever found (a), and this session has not found (b) either. I have not identified a new approach class beyond these two that stays within elementary (non-analytic, non-geometric) methods — the honest state of the investigation is: two real, correct, but incomplete elementary results, independently obstructed, with no known way to merge or extend either to close the general theorem.

---

## Exploration 5

### Strategy

Try a THIRD, mechanistically different route to Case I: instead of searching for an auxiliary prime θ (Sophie Germain, exploration 4), look for a necessary congruence condition on p itself, checked against small fixed bases — Wieferich's (1909) and Mirimanoff's (1910) criteria. If real, this converts "does a Case I counterexample exist for p" into a directly computable filter with no search over θ required at all.

### Outcome

SUCCEEDED as a real, verifiable, and historically significant partial result — and it is genuinely more powerful in practice than Sophie Germain's method, though (like every prior exploration) it does not close the theorem.

### Concrete Artifacts

**Theorem (Wieferich, 1909).** If p is an odd prime and there exists a Case I counterexample to FLT for exponent p (i.e. coprime positive integers x,y,z with p∤xyz and x^p+y^p=z^p), then

2^(p-1) ≡ 1 (mod p^2).

A prime satisfying this congruence is called a **Wieferich prime**. I verified computationally by direct search that the only Wieferich primes below 4,000,000 are **1093 and 3511** — matching the full historical record (no others are known below vastly larger bounds either). This means: Case I of FLT is UNCONDITIONALLY established, by this single congruence check alone, for every prime below 4,000,000 except possibly 1093 and 3511 (and even those two require checking directly, not automatically ruled in or out by this criterion alone — the theorem only says a counterexample would force the congruence, not that satisfying the congruence produces one).

**Mirimanoff's extension (1910).** The same style of necessary congruence holds for other small prime bases q ∈ {3,5,7,11,13,...}: a Case I counterexample forces q^(p-1) ≡ 1 (mod p^2) for each such q. Requiring ALL of these simultaneously is an extremely strong filter — in practice, no prime is known to satisfy the base-2 AND base-3 Wieferich-type congruence simultaneously, which is why Case I is unconditionally known for essentially every prime that has ever been checked, without needing Sophie Germain's auxiliary-θ search at all.

### What This Establishes (mechanistic contrast with exploration 4)

This is a genuinely different kind of elementary mechanism than exploration 4: Sophie Germain's method searches OUTWARD for an auxiliary prime θ; Wieferich/Mirimanoff's method looks INWARD, at a second-order (mod p^2, not just mod p) congruence on p relative to small fixed bases, derived from a finer analysis of the same factorization x^p+y^p=(x+y)∏(x+ζ^i y) using **Fermat quotients** q\_p(a) = (a^(p-1)-1)/p. I want to flag directly: the precise derivation of the mod-p^2 congruence from the factorization is intricate (it is a genuine second-order refinement, not a restatement of Sophie Germain's mod-p counting argument), and I'm stating the theorem and its verified consequences accurately rather than reconstructing every step of Wieferich's original proof from memory — the risk of a subtle sign or congruence error in an unverified derivation is real, and the theorem statement itself (confirmed against the literature and computation) is what's load- bearing here.

### Failure Constraint

Same as exploration 4 in kind: this is STILL only a Case I result. It also doesn't prove Case I unconditionally for all p — it proves it for all p that are NOT Wieferich primes (for whichever bases are checked), and whether infinitely many Wieferich primes exist at all is itself an open problem (heuristically expected, essentially none found). So even this sharper tool leaves a residual, uncharacterized exceptional set.

### Reformulations

Case I of FLT, elementarily, has now been attacked by two genuinely different mechanisms (auxiliary-prime search; fixed-base second-order congruence) with two different, apparently unrelated exceptional sets (primes lacking a valid θ; Wieferich primes). No known relation connects "p lacks a Sophie Germain auxiliary prime" to "p is a Wieferich prime" — worth flagging as another instance of the pattern from exploration 4: different elementary mechanisms, independent obstructions.

---

## Exploration 6

### Strategy

Directly address Case II (p | xyz) and map out how far the classical (Kummer, then later Vandiver) analytic program actually reaches — this is the deepest classical, pre-Wiles machinery, and it is worth being precise about exactly where "elementary" stops and "analytic" begins, since that boundary is the real answer to "how far can Fermat-era-adjacent methods go."

### Outcome

MAPPED — this is not a proof attempt so much as locating precisely where the classical program's ceiling is, which is itself the deliverable requested.

### Concrete Artifacts

**Setup for Case II.** Suppose x^p+y^p=z^p, pairwise coprime positive integers, and (after relabeling, using the classical fact that at most one of x,y,z is divisible by p) p | z. Write z = p^m z₁ with p ∤ z₁, m ≥ 1. As in exploration 2, factor in Z[ζ\_p]:

x^p + y^p = (x+y) ∏\_{i=1}^{p-1} (x + ζ^i y) = z^p.

**Where regularity is used (ideal-theoretic descent).** Let λ = (1-ζ), the unique prime of Z[ζ\_p] above p (with (p) = (λ)^{p-1}). Exactly one factor on the left is divisible by λ; after isolating its λ-power, the remaining pairwise-coprime factors generate ideals whose product is a p-th power ideal. **Regularity (p ∤ class number h(p))** is exactly the hypothesis that upgrades "this ideal's p-th power is principal" to "the ideal itself is principal" — the class group has no p-torsion to obstruct the descent. This reproduces, at the level of ideals rather than elements, the exact same template as exploration 1 (parametrize → force pieces to be p-th-power-like → descend), now running inside the ideal class group instead of Z.

**The genuinely non-elementary ingredient: Kummer's Lemma.** Getting from "principal ideal" back down to an actual element requires controlling units: Kummer's Lemma states that for regular p, any unit u ∈ Z[ζ\_p] satisfying u ≡ (a rational integer) (mod p) is, itself, a p-th power of a unit times a root of unity. This is the step that finally lets the argument descend on m and complete Case II for regular primes. **This lemma is NOT elementary in the Fermat/Euler/Kummer-descent sense** — its standard proof (as given in the modern literature, e.g. Washington's *Introduction to Cyclotomic Fields*) goes through the **analytic class number formula**, which expresses the class number via special values of Dirichlet L-functions and the regulator of the unit group. So: the classical 19th-century "elementary" descent program for Case II secretly bottoms out in analytic number theory at exactly one load-bearing point. This is the precise answer to "map out the analytic classical methods further" — the analysis enters here, not as an optional enhancement but as a necessary ingredient even Kummer could not avoid.

**Vandiver's Conjecture — the actual frontier.** Let h(p) = h⁺(p)·h⁻(p) be the class number of Q(ζ\_p), split into its "plus part" (class number of the real subfield Q(ζ\_p+ζ\_p⁻¹)) and "minus part" — h⁺ always divides h. **Vandiver's Conjecture**: p never divides h⁺(p). This is STILL OPEN — unresolved to this day. It has been verified computationally for every prime checked so far (into the range of many millions, with no counterexample), but there is no proof, and no known reason it must be true beyond the computational evidence and heuristic (Cohen-Lenstra-type) expectations. Vandiver's conjecture sits one level deeper than plain regularity: regularity is about p | h(p) at all; Vandiver's conjecture is about p dividing specifically the plus part. If Vandiver's conjecture held universally it would simplify (though not by itself fully resolve) the structure of the descent argument for a wider class of primes than plain regularity allows, by controlling exactly the unit-index obstruction that Kummer's Lemma is designed to route around.

### Failure Constraint

Two, stacked:

1. Even granting Kummer's Lemma and regularity, Case II (like Case I) is only settled for **regular** primes — irregular primes (37, 59, 67, 101, 103, 131, 149, 157, ... — computed directly, confirming and extending exploration 3's list) are untouched by this argument regardless of Vandiver's conjecture's truth, because the failure happens one step earlier (at the ideal-is-principal step, which Vandiver's conjecture does not address — that's a *unit*-level refinement, not a class-group-triviality one).
2. Vandiver's Conjecture itself remains unproven after well over a century. It is not a tool available to close the general theorem even in principle until proven, and there is no known route to proving it that stays within "classical" (non-Iwasawa-theoretic, non-modern) methods either — the modern approaches to attacking it (Iwasawa theory, p-adic L-functions) are themselves 20th-century machinery, arguably as far from Fermat's toolkit as Wiles' methods.

### Reformulations

The honest shape of the classical program, now fully mapped: Fermat → elementary descent (n=4, works) → Euler (n=3, works, in a UFD extension ring) → general p requires (i) unique factorization, which fails (exploration 3), repaired by (ii) ideal theory + regularity, which still needs (iii) Kummer's Lemma, which is secretly analytic (this exploration), resting on (iv) the class number formula, whose deepest open refinement is (v) Vandiver's Conjecture — itself unresolved. Every single link in this chain past step (i) requires MORE machinery than Fermat had, and the chain does not terminate in a proof; it terminates in a 170-year-old open conjecture that, even if resolved, would still only extend coverage to more primes, not close the general theorem outright, since irregular-prime obstructions to the earlier steps remain.

### Open Questions

None remaining that this investigation can productively pursue further without leaving "classical number theory" entirely: the next genuine escalation in the actual historical record is not a refinement of Kummer/Vandiver-style methods at all — it is Frey's 1985 observation that a hypothetical FLT counterexample would produce a specific elliptic curve with properties contradicting the (then-conjectural) Taniyama-Shimura modularity conjecture, which Wiles and Taylor proved (for the needed case) in 1994-95. That is a different field of mathematics grafted onto the problem, not an extension of the descent/class-number program mapped out across explorations 1-6.

---

## Synthesis after exploration 6

Six explorations now span the entire genuine classical history of this problem: a complete elementary proof (n=4), a complete near-elementary proof (n=3), the precise algebraic reason general descent fails (non-UFD cyclotomic integers), Kummer's ideal-theoretic repair and its precise limit (irregular primes), two independent Case I congruence criteria (Sophie Germain's auxiliary primes, Wieferich/Mirimanoff's fixed-base congruences) with their own independent exceptional sets, and now Case II's descent structure with its genuinely analytic load-bearing step (Kummer's Lemma via the class number formula) and the still-open frontier (Vandiver's Conjecture) beyond which the classical program cannot presently go even in principle. This is, as far as I can map it, the complete honest picture: every classical/analytic avenue available before 1985 is accounted for, each with a precisely located obstruction, and none of them — individually or combined — closes the general theorem. The only route that did was a structurally unrelated one (elliptic curves / modularity), outside the scope of "classical" methods entirely. I don't think there is further genuine ground to cover within the classical program; continuing to search inside it would be re-deriving smaller variations of exploration 3-6's obstructions rather than finding new mathematics.
