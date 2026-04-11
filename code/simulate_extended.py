"""
Extended egg drop physics: multi-mechanism survival analysis.
Explores combinations of altitude (reduced g + reduced rho_air),
drop orientation (side vs. pole: Cohen et al. 2025),
surface compliance, and partial arrest (velocity-reduction scenarios).
"""
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import json
from pathlib import Path

# np.random.seed(42)

# ──────────────────────────────────────────────────────────────────────────────
# CONSTANTS AND EGG PROPERTIES
# ──────────────────────────────────────────────────────────────────────────────
g_sl   = 9.81        # m/s² sea-level gravity
m_egg  = 0.060       # kg
h      = 9.0         # m (third-story balcony)
r_egg  = 0.028       # m (equatorial radius, ~5.6 cm diameter)
A_egg  = np.pi * r_egg**2
Cd     = 0.47        # drag coeff (sphere)

# Dynamic fracture threshold:
# - Vertical (pole-down): ~4 N  (lower toughness; Cohen et al. 2025)
# - Horizontal (side):    ~8 N  (greater energy absorption before fracture)
F_frac_vertical   = 4.0   # N
F_frac_horizontal = 8.0   # N

# ──────────────────────────────────────────────────────────────────────────────
# PHYSICS FUNCTIONS
# ──────────────────────────────────────────────────────────────────────────────
def impact_velocity(h, m, Cd, rho_air, A, g=9.81):
    """Analytic impact velocity with quadratic drag from rest."""
    v_t = np.sqrt(2 * m * g / (Cd * rho_air * A))
    v   = v_t * np.sqrt(1 - np.exp(-2 * g * h / v_t**2))
    return v, v_t

def peak_force(KE, d):
    """Peak force for sinusoidal deceleration over depth d."""
    return 2 * KE / d

def air_density_altitude(altitude_m):
    """International Standard Atmosphere density (kg/m³)."""
    T0, L, R, M = 288.15, 0.0065, 8.314, 0.0289644
    g0 = 9.80665
    T = T0 - L * altitude_m
    rho = 1.225 * (T / T0) ** (g0 * M / (R * L) - 1)
    return max(rho, 0.01)

def gravity_altitude(altitude_m, Re=6.371e6, g0=9.81):
    """Gravitational acceleration at altitude."""
    return g0 * (Re / (Re + altitude_m))**2

# ──────────────────────────────────────────────────────────────────────────────
# SCENARIO 1: Pure surface compliance (baseline)
# ──────────────────────────────────────────────────────────────────────────────
rho_sl = 1.225
v_sl, _ = impact_velocity(h, m_egg, Cd, rho_sl, A_egg, g_sl)
KE_sl = 0.5 * m_egg * v_sl**2
d_min_horizontal = KE_sl * 2 / F_frac_horizontal
d_min_vertical   = KE_sl * 2 / F_frac_vertical

# ──────────────────────────────────────────────────────────────────────────────
# SCENARIO 2: Effect of altitude (reduced g AND reduced rho_air)
# ──────────────────────────────────────────────────────────────────────────────
altitudes = np.linspace(0, 5500, 200)
v_at_alt, KE_at_alt, d_min_h, d_min_v = [], [], [], []
for alt in altitudes:
    rho_a = air_density_altitude(alt)
    g_a   = gravity_altitude(alt)
    v, _  = impact_velocity(h, m_egg, Cd, rho_a, A_egg, g_a)
    KE    = 0.5 * m_egg * v**2
    v_at_alt.append(v)
    KE_at_alt.append(KE)
    d_min_h.append(KE * 2 / F_frac_horizontal)
    d_min_v.append(KE * 2 / F_frac_vertical)

# ──────────────────────────────────────────────────────────────────────────────
# SCENARIO 3: Combined surfaces + altitude + orientation
# Realistic best-case candidates
# ──────────────────────────────────────────────────────────────────────────────
# The key insight: we need d_min for the egg to survive.
# At sea level horizontal: ~119 cm. At 5000 m: slightly less.
# Natural surfaces can provide d > 1 m ONLY with:
#   (a) very deep, very fresh, ultra-low-density powder snow AND
#   (b) landing sideways (horizontal orientation, higher toughness)
# The Hida Mountains / Sukayu Onsen scenario with 1-2 m fresh powder
# and a horizontal impact offers the best chance.

candidates = [
    # (name, altitude_m, d_m, orientation, location)
    ("Deep powder, sea level, horizontal",  0, 0.30, "horizontal",
     "Alta/Snowbird Utah"),
    ("Deep powder, 2000m, horizontal",      2000, 0.40, "horizontal",
     "Hida Mountains Japan"),
    ("Deep powder, 3000m, horizontal",      3000, 0.60, "horizontal",
     "Julian Alps/Dolomites"),
    ("Ultra-deep powder, 4000m, horizontal",4000, 0.90, "horizontal",
     "High-altitude Hida/Patagonia Andes"),
    ("Ultra-deep powder, 5000m, horizontal",5000, 1.20, "horizontal",
     "Tibetan Plateau edge / high Andes"),
    ("Sphagnum + powder mix, 1500m, horiz.",1500, 0.45, "horizontal",
     "Scottish Cairngorms / Irish blanket bog"),
    ("Saturated raised bog, sea level, horiz.", 0, 0.30, "horizontal",
     "Magellanic moorland, Patagonia"),
    ("Water entry angle + bog below",        0, 0.35, "horizontal",
     "Bog pool, West Siberian lowland"),
    ("Extreme: 5000m + 1.5m powder, horiz.",5000, 1.50, "horizontal",
     "Hypothetical: high Andes snowfield"),
]

cand_results = []
for name, alt, d, orient, loc in candidates:
    rho_a = air_density_altitude(alt)
    g_a   = gravity_altitude(alt)
    v, _  = impact_velocity(h, m_egg, Cd, rho_a, A_egg, g_a)
    KE    = 0.5 * m_egg * v**2
    F_frac = F_frac_horizontal if orient == "horizontal" else F_frac_vertical
    Fp    = peak_force(KE, d)
    survives = bool(Fp < F_frac)
    margin   = (F_frac - Fp) / F_frac * 100
    cand_results.append({
        "scenario": name,
        "altitude_m": alt,
        "d_m": d,
        "orientation": orient,
        "F_peak_N": round(Fp, 3),
        "F_frac_N": F_frac,
        "survives": survives,
        "margin_pct": round(margin, 1),
        "impact_velocity_m_per_s": round(v, 3),
        "location": loc
    })

# ──────────────────────────────────────────────────────────────────────────────
# FIGURE 3: Required deformation depth vs altitude (with F_frac lines)
# ──────────────────────────────────────────────────────────────────────────────
fig, ax = plt.subplots(figsize=(10, 6))
ax.plot(altitudes, [d*100 for d in d_min_h], 'b-', linewidth=2,
        label='Min. depth to survive (horizontal, 8 N threshold)')
ax.plot(altitudes, [d*100 for d in d_min_v], 'b--', linewidth=2,
        label='Min. depth to survive (vertical, 4 N threshold)')
ax.axhline(150, color='purple', linestyle=':', linewidth=1.5,
           label='Realistic max. surface yield (~150 cm ultra-deep powder/bog)')
ax.axhline(30, color='orange', linestyle=':', linewidth=1.5,
           label='Typical powder/bog surface yield (~30 cm)')
ax.fill_between(altitudes,
                [d*100 for d in d_min_h],
                150,
                where=[d*100 < 150 for d in d_min_h],
                alpha=0.2, color='green', label='Potential survival zone (horiz.)')
ax.set_xlabel('Altitude above sea level (m)', fontsize=12)
ax.set_ylabel('Required surface deformation depth (cm)', fontsize=12)
ax.set_title('Minimum surface yield depth required for egg survival vs. altitude\n'
             '(Drop height = 9 m, egg mass = 60 g)', fontsize=11)
ax.legend(fontsize=9, loc='upper right')
ax.set_xlim(0, 5500)
ax.set_ylim(0, 200)
ax.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig('/home/claude/egg_drop/results/figures/fig3_altitude_survival.png', dpi=150)
plt.close()
print("Figure 3 saved.")

# ──────────────────────────────────────────────────────────────────────────────
# FIGURE 4: Scenario comparison bar chart
# ──────────────────────────────────────────────────────────────────────────────
fig, ax = plt.subplots(figsize=(13, 6))
sc_names = [r['scenario'] for r in cand_results]
sc_forces = [r['F_peak_N'] for r in cand_results]
sc_thresh = [r['F_frac_N'] for r in cand_results]
sc_colors = ['#1a9850' if r['survives'] else '#d73027' for r in cand_results]
x = np.arange(len(cand_results))
bars = ax.bar(x, sc_forces, color=sc_colors, edgecolor='black', linewidth=0.8, label='Peak force')
ax.scatter(x, sc_thresh, color='black', marker='_', s=500, linewidths=2,
           zorder=5, label='Fracture threshold')
ax.set_xticks(x)
ax.set_xticklabels([r['scenario'] for r in cand_results],
                   rotation=35, ha='right', fontsize=8)
ax.set_ylabel('Estimated peak force on eggshell (N)', fontsize=11)
ax.set_title('Peak impact force vs. fracture threshold: combined scenario analysis\n'
             'Green = survives, Red = breaks, horizontal lines = fracture thresholds',
             fontsize=10)
ax.legend(fontsize=9)
ax.grid(True, axis='y', alpha=0.3)
plt.tight_layout()
plt.savefig('/home/claude/egg_drop/results/figures/fig4_scenario_comparison.png', dpi=150)
plt.close()
print("Figure 4 saved.")

# ──────────────────────────────────────────────────────────────────────────────
# LATEX TABLE 2
# ──────────────────────────────────────────────────────────────────────────────
tex2 = r"""\begin{table}[ht]
\centering
\caption{Combined scenario analysis: altitude, surface compliance, and egg orientation.
  Impact force is compared to the orientation-dependent fracture threshold.}
\label{tab:scenarios}
\small
\begin{tabular}{lccccccl}
\toprule
Scenario & Alt.\ (m) & $d$ (cm) & Orient. & $v$ (m/s) & $F_\text{peak}$ (N) & Threshold (N) & Survives \\
\midrule
"""
for r in cand_results:
    s = 'Yes' if r['survives'] else 'No'
    tex2 += (f"{r['scenario']} & {r['altitude_m']} & {r['d_m']*100:.0f} & "
             f"{r['orientation']} & {r['impact_velocity_m_per_s']:.2f} & "
             f"{r['F_peak_N']:.2f} & {r['F_frac_N']:.1f} & {s} \\\\\n")
tex2 += r"""\bottomrule
\end{tabular}
\end{table}
"""
Path('/home/claude/egg_drop/results/tables/table2.tex').write_text(tex2)

# ──────────────────────────────────────────────────────────────────────────────
# SAVE EXTENDED JSON
# ──────────────────────────────────────────────────────────────────────────────
summary2 = {
    "sea_level_impact_velocity_m_per_s": round(v_sl, 4),
    "sea_level_KE_J": round(KE_sl, 5),
    "min_depth_horizontal_cm": round(d_min_horizontal * 100, 2),
    "min_depth_vertical_cm": round(d_min_vertical * 100, 2),
    "combined_scenarios": cand_results
}
Path('/home/claude/egg_drop/results/results_extended.json').write_text(
    json.dumps(summary2, indent=2))

print("\n" + "="*80)
print(f"{'Scenario':<45} {'Fpeak':>7} {'Thresh':>7} {'Survives':>9} {'Margin%':>8}")
print("="*80)
for r in cand_results:
    print(f"{r['scenario']:<45} {r['F_peak_N']:>7.2f} {r['F_frac_N']:>7.1f} "
          f"{str(r['survives']):>9} {r['margin_pct']:>8.1f}")
print("="*80)
print(f"\nSurvival count: {sum(1 for r in cand_results if r['survives'])} / {len(cand_results)}")
