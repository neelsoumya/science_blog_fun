'''
This code creates an interactive plot to visualize the relationship between the parameters x, A, B and the resulting lambda (λ) in the context of Ramanujan's work. The plot shows how the value of λ affects the function e^(-λ), which is relevant to understanding certain mathematical properties. Users can adjust the parameters using sliders to see how they influence the curve.
'''

import numpy as np
import matplotlib.pyplot as plt
from ipywidgets import interact, FloatLogSlider

def plot_curve(x=1e4, A=1e6, B=1e7):
    lam = x * A / B
    grid = np.linspace(max(lam / 20, 1e-6), lam * 2, 200)
    vals = np.exp(-grid)
    plt.figure(figsize=(5, 3.2))
    plt.plot(grid, vals, color="#1f77b4")
    plt.axvline(lam, color="#d62728", linestyle="--", label=f"lambda = {lam:.3g}")
    plt.yscale("log")
    plt.xlabel(r"$\lambda$")
    plt.ylabel(r"$e^{-\lambda}$")
    plt.title("None-Probability vs. $\\lambda$")
    plt.legend()
    plt.grid(True, which="both", linestyle="--", linewidth=0.5, alpha=0.6)
    plt.tight_layout()
    plt.show()

interact(
    plot_curve,
    x=FloatLogSlider(value=1e4, base=10, min=2, max=8, step=0.1, description="x"),
    A=FloatLogSlider(value=1e6, base=10, min=2, max=12, step=0.1, description="A"),
    B=FloatLogSlider(value=1e7, base=10, min=6, max=16, step=0.1, description="B"),
);