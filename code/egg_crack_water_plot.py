import numpy as np
import matplotlib.pyplot as plt

# Physical parameters (simple order-of-magnitude model)
g = 9.81                 # m/s^2
rho_water = 1000.0       # kg/m^3
Cd = 1.0                 # dimensionless, rough impact coefficient
A = 1.5e-3               # m^2, typical egg cross-sectional area
F_crack = 60.0           # N, rough cracking threshold for a typical egg

# Height range
h = np.linspace(0, 15, 400)  # meters

# Effective force model:
# v^2 = 2gh, so drag-like impact force F ~ 1/2 rho Cd A v^2 = rho Cd A g h
F_eff = rho_water * Cd * A * g * h

# Height where the model reaches the cracking force
h_crack = F_crack / (rho_water * Cd * A * g)

# Make figure
plt.figure(figsize=(8, 5))
plt.plot(h, F_eff, label="Effective impact force")
plt.axhline(F_crack, linestyle="--", label="Cracking force")
plt.axvline(h_crack, linestyle="--", label=f"Threshold height ≈ {h_crack:.2f} m")

plt.xlabel("Drop height (m)")
plt.ylabel("Force (N)")
plt.title("Estimated force on an egg dropped onto water")
plt.xlim(0, 15)
plt.ylim(0, max(F_eff.max(), F_crack) * 1.1)
plt.grid(True, alpha=0.3)
plt.legend()
plt.tight_layout()
plt.show()


print(f"Threshold height in this model: {h_crack:.2f} m")