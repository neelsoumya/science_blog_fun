/-
Lean formalization: projectile + moving vertical wall bounce.

This file proves the algebraic solution for the impact time

  t = (u_y / g) * (u_x + 2*v) / (u_x + v)

under the standard assumptions used in the physics derivation: gravity g ≠ 0,
no vertical impulse at collision (so vertical velocity is unchanged), and the
algebraic equations

  (u_x + v) * t = D   -- collision occurs when projectile and wall meet,
                       -- D is the wall initial x-position (cancels out)
  t_r = u_x * t / (u_x + 2*v)  -- return time to origin after elastic bounce
  t + t_r = 2 * u_y / g        -- total time to return to y=0

We formalize the last algebraic relation and solve it for t.
-/

import data.real.basic
import tactic

/- We do the purely algebraic lemma: if
     t + (u_x * t) / (u_x + 2*v) = 2*u_y / g
  and denominators are nonzero, then
     t = (u_y/g) * (u_x + 2*v) / (u_x + v).
  This captures the algebraic core of the physics derivation.
-/

variables {u_x u_y v g t : ℝ}

theorem solve_time_of_impact
  (hg : g ≠ 0)
  (h_uv_nonzero : u_x + v ≠ 0)
  (h_u2v_nonzero : u_x + 2*v ≠ 0)
  (h : t + u_x * t / (u_x + 2*v) = 2 * u_y / g) :
  t = (u_y / g) * (u_x + 2*v) / (u_x + v) :=
begin
  -- Factor t from the left-hand side
  have fact : t * (1 + u_x / (u_x + 2*v)) = 2 * u_y / g,
  { convert h, simp only [mul_one, add_comm], ring, },

  -- Simplify 1 + u_x/(u_x+2*v)
  have denom_simp : 1 + u_x / (u_x + 2*v) = (2 * (u_x + v)) / (u_x + 2*v),
  { field_simp [h_u2v_nonzero], ring, },

  -- Substitute into the factored equation
  rw denom_simp at fact,
  -- Now we have: t * (2*(u_x+v)/(u_x+2*v)) = 2*u_y/g
  -- Multiply both sides by (u_x+2*v)/(2*(u_x+v)) (valid because denominators are nonzero)
  have : t = (2 * u_y / g) * (u_x + 2*v) / (2 * (u_x + v)),
  { field_simp [hg, h_uv_nonzero, h_u2v_nonzero] at fact,
    -- `fact` has the form t * (2*(u_x+v)/(u_x+2*v)) = 2*u_y/g; we isolate t
    field_simp [hg, h_uv_nonzero, h_u2v_nonzero] at fact,
    symmetry, exact (eq_div_of_mul_eq _ _ _ fact).symm },

  -- Cancel the factor 2 to obtain the desired closed form
  simp only [mul_assoc, mul_comm (2 : ℝ), mul_left_comm] at this,
  field_simp [hg, h_uv_nonzero, h_u2v_nonzero] at this,
  -- final simplification
  have final : (2 * u_y / g) * (u_x + 2*v) / (2 * (u_x + v)) = (u_y / g) * (u_x + 2*v) / (u_x + v),
  { field_simp [hg, h_uv_nonzero, h_u2v_nonzero], ring, },
  calc t = (2 * u_y / g) * (u_x + 2*v) / (2 * (u_x + v)) : this
     ... = (u_y / g) * (u_x + 2*v) / (u_x + v) : final
end

/- A short remark lemma: under the frictionless (smooth) vertical wall assumption,
   the wall exerts only a horizontal impulse so the vertical component of
   velocity is unchanged. We encode this as a lemma statement (axiomatic)
   rather than a dynamical derivation.
-/

lemma vertical_velocity_unchanged (v_y_before v_y_after : ℝ) (J_y : ℝ) :
  -- impulse-momentum in vertical direction: m*(v_after - v_before) = J_y
  -- if J_y = 0 (no vertical impulse), then v_after = v_before
  J_y = 0 -> v_y_after = v_y_before :=
begin
  intro hJ,
  have : v_y_after - v_y_before = 0, by { simpa [sub_eq_iff_eq_add] using (by simp [hJ]) },
  simpa using this
end

/- Usage note:
   To connect this formal algebraic lemma back to the physical notation in the
   original problem, set u_x = v0 * cos α and u_y = v0 * sin α and supply the
   non-vanishing assumptions (e.g. g ≠ 0 and u_x + v ≠ 0, u_x + 2*v ≠ 0). The
   algebraic lemma then yields the closed-form expression for the impact time t.
-/
