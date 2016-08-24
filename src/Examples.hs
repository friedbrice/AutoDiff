import AutoDiff

-- Works for single-variable functions
-- x^2 - 3x, derivative should be 2x - 3
f x = x ** 2 - 3 * x
-- `d f 2` should be `1`

-- Works for functions of several variables
-- f(x,y) = x^2 - 3xy + 2y^2
-- D_x(f)(x,y) = 2x - 3y
-- D_y(f)(x,y) = -3x + 4y
-- grad(f)(x,y) = (2x - 3y, -3x + 4y)
g x y = x ** 2 - 3 * x * y + 2 * y ** 2
-- `g (Dual 2 1) (Dual 1 0)` should be `Dual 0.0 1.0`
-- `g (Dual 2 0) (Dual 1 1)` should be `Dual 0.0 (-2.0)`
-- `g (Dual 2 (-1)) (Dual 1 3)` should be `Dual 0.0 (-7.0)`

-- Works for non-symbolic algorithms
-- Example pulled from
-- https://justindomke.wordpress.com/2009/02/17/
-- automatic-differentiation-the-most-criminally-underused-
-- tool-in-the-potential-machine-learning-toolbox/
h x = foldr (\_ z -> sin (x + z)) x [1..100]
-- who the hell knows what `d h 2` should be?
-- that's kind of the point :-p

-- Works with recursive functions, as well...
-- ... for some definitions of "works"
fib x
  | x < 0 = 0
  | x <= 2 = x
  | otherwise = fib(x - 1) + fib(x - 2)
-- `d fib 1.5` should be `1.0`, and it is
-- `d fib 2.5` should be `2.0`, and it is
-- `d fib 0` is `0`, but technically it shouldn't be...
-- mathematically, `d fib` should fail for any integer input
-- this is a problem in my implementation of autodiff, but for another day
-- For the mathematically inclined, `d f` agrees with the derivative of `f`
-- wherever `f` is differentiable, but `d f` is potentially defined on a
-- larger set, as this example illustrates.
