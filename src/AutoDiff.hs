module AutoDiff where

data Dual a = Dual a a
  deriving (Eq, Read, Show)

-- Represent a constant `x` as `Dual x 0`
constDual :: Num a => a -> Dual a
constDual x = Dual x 0

-- Represent a variable with current value `x`
-- and current derivative `x'` as `Dual x x'`
seedDual :: a -> a -> Dual a
seedDual x x' = Dual x x'

-- Extract the value `x` from `Dual x _`
evalDual :: Dual a -> a
evalDual (Dual x _) = x

-- Extract the derivative `x'` from `Dual _ x'`
diffDual :: Dual a -> a
diffDual (Dual _ x') = x'

-- `Num a` implies `Num (Dual a)`
instance Num a => Num (Dual a) where
  (Dual u u') + (Dual v v') = Dual (u + v) (u' + v')
  (Dual u u') * (Dual v v') = Dual (u * v) (u' * v + u * v')
  (Dual u u') - (Dual v v') = Dual (u - v) (u' - v')
  abs (Dual u u')           = Dual (abs u) (u' * (signum u))
  signum (Dual u u')        = Dual (signum u) 0
  fromInteger n             = Dual (fromInteger n) 0

-- `Fractional a` implies `Fractional (Dual a)`
instance Fractional a => Fractional (Dual a) where
  (Dual u u') / (Dual v v') = Dual (u / v) ((u' * v - u * v') / (v * v))
  fromRational n            = Dual (fromRational n) 0

-- `Floating a` implies `Floating (Dual a)`
instance (Eq a, Floating a) => Floating (Dual a) where
  pi                = Dual pi 0
  exp (Dual u u')   = Dual (exp u) (u' * (exp u))
  log (Dual u u')   = Dual (log u) (u' / u)
  sqrt (Dual u u')  = Dual (sqrt u) (u' / (2 * sqrt u))
  sin (Dual u u')   = Dual (sin u) (u' * (cos u))
  cos (Dual u u')   = Dual (cos u) (-1 * u' * (sin u))
  tan (Dual u u')   = Dual (tan u) (1 / ((cos u) ** 2))
  asin (Dual u u')  = Dual (asin u) (u' / (sqrt(1 - (u ** 2))))
  acos (Dual u u')  = Dual (acos u) ((- 1) * u' / (sqrt(1 - (u ** 2))))
  atan (Dual u u')  = Dual (atan u) (u' / (1 + (u ** 2)))
  sinh (Dual u u')  = Dual (sinh u) (u' * cosh u)
  cosh (Dual u u')  = Dual (cosh u) (u' * sinh u)
  tanh (Dual u u')  = Dual (tanh u) (u' * (1 - ((tanh u) ** 2)))
  asinh (Dual u u') = Dual (asinh u) (u' / (sqrt(1 + (u ** 2))))
  acosh (Dual u u') = Dual (acosh u) ((u' / (sqrt((u ** 2) - 1))))
  atanh (Dual u u') = Dual (atanh u) (u' / (1 - (u ** 2)))
  (Dual u u') ** (Dual n 0)
    = Dual (u ** n) (u' * n * u ** (n - 1))
  (Dual a 0) ** (Dual v v')
    = Dual (a ** v) (v' * log a * a ** v)
  (Dual u u') ** (Dual v v')
    = Dual (u ** v) ((u ** v) * (v' * (log u) + (v * u' / u)))
  logBase (Dual u u') (Dual v v')
    = Dual (logBase u v) (((log v) * u' / u - (log u) * v' / v) / ((log u) ** 2))

-- `Ord a` implies `Ord (Dual a)`
instance Ord a => Ord (Dual a) where
  (Dual x _) <= (Dual y _) = x <= y

-- Differentiate a single-variable function `f`
d :: Num a => (Dual a -> Dual c) -> a -> c
d f x = diffDual . f $ Dual x 1
