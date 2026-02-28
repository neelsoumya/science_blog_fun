'''
This code simulates the probability of inhaling "none" of a certain type of molecule in a breath, based on the parameters A (number of molecules breathed by a person), B (number of molecules in the atmosphere), and x (number of molecules in a breath). It compares the simulated probability to the theoretical probability given by the exponential distribution.

'''

import math
import random

def simulate_none_probability(x, f, trials=10000, seed=0):
    rng = random.Random(seed)
    none_count = 0
    for _ in range(trials):
        # Count how many molecules are "hits" in this breath.
        hits = sum(1 for _ in range(x) if rng.random() < f)
        if hits == 0:
            none_count += 1
    return none_count / trials

def compare_to_exp(x, A, B, trials=10000):
    f = A / B
    lam = x * f
    sim = simulate_none_probability(x, f, trials=trials)
    approx = math.exp(-lam)
    return lam, sim, approx

# Example parameters
x = 10_000      # molecules in a breath (toy number for simulation)
A = 1_000_000   # molecules breathed by a person (toy number)
B = 10_000_000  # molecules in the atmosphere (toy number)

lam, sim, approx = compare_to_exp(x, A, B, trials=20000)
print("lambda:", lam)
print("simulated P(none):", sim)
print("exp(-lambda):", approx)
