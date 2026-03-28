# How many candidates should you interview for a job?

> If there are (n) candidates and you can only rank them relative to the ones already seen, the optimal strategy is to **reject the first (\approx n/e)** candidates, then **accept the first one who is better than all previous candidates**.

It is not “accept after (e) attempts” exactly; it is “**wait through about a (1/e) fraction of the pool**.”

## Light proof sketch

Assume:

1. There are (n) candidates.
2. They arrive in random order.
3. After each interview, you only know whether this candidate is the best so far.
4. If you reject a candidate, you cannot return to them.
5. Your goal is to maximize the chance of selecting the single best candidate overall.

Let (r) be the number of candidates you deliberately reject at the start. After that, you accept the first candidate who is better than everyone seen so far.

Now ask: what is the probability that this strategy succeeds?

For you to succeed, the best overall candidate must appear at some position (k>r), and among the first (k-1) candidates, the best one must lie in the first (r) candidates. Why? Because then when the best candidate appears at position (k), they will beat all earlier candidates, so you will hire them.

* Probability the overall best candidate is in position (k): (1/n).
* Given that, the best among the first (k-1) candidates is equally likely to be in any of the first (k-1) positions, so the probability it lies in the first (r) positions is (r/(k-1)).

So the success probability is

[
P(r)=\sum_{k=r+1}^{n}\frac{1}{n}\cdot\frac{r}{k-1}
=\frac{r}{n}\sum_{k=r}^{n-1}\frac{1}{k}
]

That is,

[
P(r)=\frac{r}{n}\big(H_{n-1}-H_{r-1}\big)
]

where (H_m) is the (m)-th harmonic number.

For large (n), use the approximation

[
H_m \approx \log m + \gamma
]

so

[
P(r)\approx \frac{r}{n}\log!\left(\frac{n}{r}\right).
]

Now maximize this with respect to (r). Let (x=r/n). Then

[
P(x)\approx x\log(1/x).
]

Differentiate:

[
\frac{d}{dx}\big(x\log(1/x)\big)
= \log(1/x)-1.
]

Set this equal to zero:

[
\log(1/x)=1
\quad\Rightarrow\quad
x=e^{-1}.
]

So the optimum is

[
r \approx \frac{n}{e}.
]

That is the famous (1/e) rule.

## Intuition

You are balancing two forces:

* If you wait too long, you may miss the best candidate.
* If you stop too early, you have not learned enough to recognize a great candidate.

The choice (n/e) is the sweet spot where you learn enough from the early sample, but still leave enough candidates for a good one to appear later.

## One-line takeaway

The optimal stopping rule is: **reject the first (37%) or so of candidates, then take the first one who is better than all previous candidates.**


## Where does the e come from in this?


The constant (e) shows up because the optimization reduces to a function whose maximum is controlled by the **natural logarithm**—and (e) is the base where logarithms behave “cleanly” under differentiation.

Let me show you the key step cleanly.

---

## Where (e) appears

From the sketch before, the success probability (for large (n)) is approximated by

[
P(r) \approx \frac{r}{n}\log!\left(\frac{n}{r}\right).
]

Let (x = r/n). Then:

[
P(x) \approx x \log(1/x).
]

---

## The crucial optimization step

Differentiate:

[
\frac{d}{dx}\big(x \log(1/x)\big)
= \log(1/x) - 1.
]

Now set derivative to zero:

[
\log(1/x) - 1 = 0
\quad\Rightarrow\quad
\log(1/x) = 1.
]

Now exponentiate:

[
1/x = e
\quad\Rightarrow\quad
x = \frac{1}{e}.
]

---

## So what is really going on?

The appearance of (e) is **not accidental**—it comes from two deep facts:

### 1. Harmonic sums behave like logarithms

The sum

[
\sum_{k=r}^{n} \frac{1}{k}
]

is approximately

[
\log(n) - \log(r) = \log(n/r).
]

This is why logarithms enter the problem at all.

---

### 2. The derivative of (\log) is especially simple

The natural logarithm satisfies:

[
\frac{d}{dx} \log x = \frac{1}{x}.
]

Because of this, when you optimize expressions like

[
x \log(1/x),
]

you get a clean equation:

[
\log(1/x) = 1.
]

And the number whose logarithm is 1 is exactly:

[
e.
]

---

## Intuition (non-symbolic)

You are solving a tradeoff:

* (x): how much you **wait**
* (\log(1/x)): how much **information** you gain from that waiting

The optimal point is where:

> “marginal benefit of waiting = marginal cost of waiting”

That balance mathematically becomes:

[
\log(1/x) = 1,
]

and the number that makes “log = 1” true is (e).

---

## Deeper interpretation

This same structure shows up all over probability and optimal stopping:

* exponential decay
* continuous-time waiting processes
* entropy-like tradeoffs

So (e) appears because this problem is really about **continuous scaling and relative growth**, not discrete counting.

---

## One-line answer

> (e) appears because the success probability reduces to maximizing (x\log(1/x)), and the point where its derivative vanishes is exactly (x = 1/e), due to the defining property (\log e = 1).

---

