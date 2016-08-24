-- Adapted from http://5outh.blogspot.in/2013/05/symbolic-calculus-in-haskell.html

import AutoDiff

infixl 4 :+:
infixl 5 :*:

-- Type for representing algebraic expressions
data Expr a
  = Var Char
  | Const a
  | (Expr a) :+: (Expr a)
  | (Expr a) :*: (Expr a)
  deriving (Eq, Read, Show)

-- `Num a` implies `Num (Expr a)`
instance Num a => Num (Expr a) where
  u + v         = u :+: v
  u * v         = u :*: v
  u - v         = u :+: Const (-1) :*: v
  fromInteger n = Const $ fromInteger n
  abs u         = undefined
  signum u      = undefined

-- some stock `Expr a`s to play around with
-- remember to only use `(+)`, `(-)`, `(*)`, and `fromInteger`
f = 3 * Var 'x' + 4 -- represents `\x -> 3 * x + 4`
g = 4 - Var 'x' * Var 'x' -- represents `\x -> 4 - x * x`

-- `d` will find the derivative of a haskell function. We need a way to
-- turn an `Expr a` into a haskell function. `applyExpr` helps us do that.

-- applies `expr` to argument `x`
applyExpr :: Expr a -> a -> a
applyExpr expr x = undefined -- exercise left to the reader ;-)

-- once `applyExpr` is implemented, we can differentiate
-- functions symbolically as follows:
--
--     d (\x -> applyExpr f x) (Var 'x')
--     d (\x -> applyExpr g x) (Var 'x')
--
-- as a proof of concept, we can write out function literals instead
-- of using `applyExpr`
--
--     d (\x -> 3 * x + 4) (Var 'x')
--     d (\x -> 4 - x * x) (Var 'x')
--
-- success!
