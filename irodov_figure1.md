# Irodov problem Figure 1

- Small ball thrown at an initial velocity vo at an angle $\alpha$ to the horizontal strikes a vertical wall moving towards it at a horizontal velocity v and is bounced to the point from which it was thrown. Determine the time t from the beginning of motion to the moment of impact, neglecting friction losses.

## Solution by ChatGPT

Neat little projectile + moving-wall trick.  I will assume

* the ball is thrown from the origin at (t=0) with (v_0) at angle (\alpha) (so (u_x=v_0\cos\alpha,;u_y=v_0\sin\alpha));
* the vertical acceleration is ( -g);
* the wall is a plane perpendicular to the (x)-axis, initially at (x=D) and moving toward the origin with speed (v) (so wall velocity (=-v));
* the collision is perfectly elastic and instantaneous (no change to vertical component at impact).

Let (t) be the time from launch to impact.  The collision position satisfies
[
x_{\text{ball}}(t)=u_x t,\qquad x_{\text{wall}}(t)=D - v t,
]
so
[
u_x t = D - v t \quad\Rightarrow\quad (u_x+v)t = D. \tag{1}
]

In the wall frame the horizontal velocity of the ball before impact is (u_x+v); an elastic bounce reverses that horizontal component, so transforming back to the lab frame the horizontal velocity immediately after impact is
[
v_x' = -\big(u_x+2v\big).
]
Thus the time from impact until the ball returns to the origin (horizontal condition (x_{\text{collision}}+v_x' t_r=0)) is
[
t_r=\frac{u_x t}{u_x+2v}. \tag{2}
]

Vertical motion is unaffected by the collision.  Let the collision height be
[
y_c = u_y t-\tfrac12 g t^2,
]
and the vertical velocity just after collision (v_{y,c}=u_y-gt).  Requiring the ball to return to (y=0) after time (t_r) gives
[
0 = y_c + v_{y,c}t_r -\tfrac12 g t_r^2.
]
This simplifies (collecting terms) to
[
u_y(t+t_r) - \tfrac12 g (t+t_r)^2 = 0
\quad\Rightarrow\quad t+t_r=\frac{2u_y}{g}. \tag{3}
]

Substitute (t_r) from (2) into (3):
[
t + \frac{u_x t}{u_x+2v} = \frac{2u_y}{g}.
]
Solve for (t).  Noting (1+\dfrac{u_x}{u_x+2v}=\dfrac{2(u_x+v)}{u_x+2v}) we get
[
t\frac{2(u_x+v)}{u_x+2v}=\frac{2u_y}{g}
\quad\Rightarrow\quad
t=\frac{u_y}{g},\frac{u_x+2v}{u_x+v}.
]

Finally substitute (u_x=v_0\cos\alpha,;u_y=v_0\sin\alpha):
[
\boxed{ ; t ;=; \frac{v_0\sin\alpha}{g},\frac{v_0\cos\alpha+2v}{,v_0\cos\alpha+v,};. }
]

(Checks: for (v=0) this gives (t=v_0\sin\alpha/g) — the half flight time as expected; the formula requires (v_0\cos\alpha+v\neq0).)
