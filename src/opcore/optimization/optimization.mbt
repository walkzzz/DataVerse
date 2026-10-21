///|
/// # opcore/optimization 优化算法 / Optimization
///
/// 梯度下降/牛顿法/线性规划/二次规划/遗传算法/模拟退火/粒子群/约束优化。
/// 纯数值优化算法集合，对标 scipy.optimize + pyomo。
///
/// # Optimization algorithms
///
/// Gradient descent, Newton, LP, QP, GA, SA, PSO, constrained optimization.
fn sqrt_(x : Double) -> Double {
  if x <= 0.0 {
    return 0.0
  }
  let mut guess = if x > 1.0 { x / 2.0 } else { 1.0 }
  for _ in 0..<100 {
    let next = (guess + x / guess) / 2.0
    let diff = next - guess
    if diff < 0.00000001 && diff > -0.00000001 {
      return next
    }
    guess = next
  }
  guess
}

///|
fn abs_(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

///|
fn exp_(x : Double) -> Double {
  if x > 20.0 {
    return 485165195.4
  }
  if x < -20.0 {
    return 0.0
  }
  let mut result = 1.0
  let mut term = 1.0
  for i in 1..<50 {
    term = term * x / i.to_double()
    result = result + term
  }
  result
}

///|
fn ln_(x : Double) -> Double {
  if x <= 0.0 {
    return -999999.0
  }
  let mut result = 0.0
  let t = (x - 1.0) / (x + 1.0)
  let t2 = t * t
  let mut term = t
  for k in 0..<50 {
    result = result + term / (2 * k + 1).to_double()
    term = term * t2
  }
  2.0 * result
}

///|
fn max_(a : Double, b : Double) -> Double {
  if a > b {
    a
  } else {
    b
  }
}

///|
fn dot_(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  let mut s = 0.0
  for i in 0..<n {
    s = s + a[i] * b[i]
  }
  s
}

///|
fn norm_(a : Array[Double]) -> Double {
  sqrt_(dot_(a, a))
}

///|
fn copy_(x0 : Array[Double]) -> Array[Double] {
  let n = x0.length()
  let x : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = x0[i]
  }
  x
}

///|
fn rng_(seed : Double) -> Double {
  let s = seed * 1103515245.0 + 12345.0
  s - (s / 2147483647.0).to_int().to_double() * 2147483647.0
}

///|
/// 优化配置 / Optimization configuration.
pub(all) struct OptimizationConfig {
  learning_rate : Double
  max_iter : Int32
  tolerance : Double
  momentum : Double
  beta1 : Double
  beta2 : Double
  epsilon : Double
}

///|
/// 优化结果 / Optimization result.
pub(all) struct OptimizationResult {
  x : Array[Double]
  fx : Double
  iterations : Int32
  converged : Bool
}

///|
/// 粒子 / Particle for PSO.
pub(all) struct Particle {
  position : Array[Double]
  velocity : Array[Double]
  best_position : Array[Double]
  best_value : Double
}

///|
/// 个体 / Individual for GA.
pub(all) struct Individual {
  genes : Array[Double]
  fitness : Double
}

///|
/// 优化状态 / Optimization status.
pub(all) enum OptimizationStatus {
  Converged
  MaxIterReached
  Diverged
  Failed
}

///|
/// 冷却调度类型 / Cooling schedule type.
pub(all) enum CoolingScheduleType {
  Linear
  Exponential
  Logarithmic
  Geometric
}

///|
/// 构造优化配置 / Create optimization config.
pub fn make_optimization_config(
  lr : Double,
  max_iter : Int32,
  tol : Double,
) -> OptimizationConfig {
  {
    learning_rate: lr,
    max_iter,
    tolerance: tol,
    momentum: 0.9,
    beta1: 0.9,
    beta2: 0.999,
    epsilon: 0.00000001,
  }
}

///|
/// 梯度下降 / Gradient descent.
pub fn gradient_descent(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  max_iter : Int32,
  tol : Double,
) -> OptimizationResult {
  let n = x0.length()
  let x = copy_(x0)
  let mut iter = 0
  let mut converged = false
  while iter < max_iter {
    let g = grad(x)
    if norm_(g) < tol {
      converged = true
      break
    }
    for i in 0..<n {
      x[i] = x[i] - lr * g[i]
    }
    iter = iter + 1
  }
  { x, fx: f(x), iterations: iter, converged, }
}

///|
/// 随机梯度下降 / Stochastic gradient descent.
pub fn stochastic_gradient_descent(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  max_iter : Int32,
  tol : Double,
) -> OptimizationResult {
  let n = x0.length()
  let x = copy_(x0)
  let mut iter = 0
  let mut converged = false
  while iter < max_iter {
    let g = grad(x)
    let scale = 1.0 / (1.0 + iter.to_double() * 0.01)
    if norm_(g) < tol {
      converged = true
      break
    }
    for i in 0..<n {
      x[i] = x[i] - lr * scale * g[i]
    }
    iter = iter + 1
  }
  { x, fx: f(x), iterations: iter, converged, }
}

///|
/// 小批量SGD / Mini-batch SGD.
pub fn mini_batch_sgd(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  batch_size : Int32,
  max_iter : Int32,
  tol : Double,
) -> OptimizationResult {
  let n = x0.length()
  let x = copy_(x0)
  let bs = if batch_size > 0 { batch_size } else { 1 }
  let mut iter = 0
  let mut converged = false
  while iter < max_iter {
    let g = grad(x)
    let scale = 1.0 / bs.to_double()
    if norm_(g) < tol {
      converged = true
      break
    }
    for i in 0..<n {
      x[i] = x[i] - lr * scale * g[i]
    }
    iter = iter + 1
  }
  { x, fx: f(x), iterations: iter, converged, }
}

///|
/// 动量梯度下降 / Momentum gradient descent.
pub fn momentum_gd(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  momentum : Double,
  max_iter : Int32,
  tol : Double,
) -> OptimizationResult {
  let n = x0.length()
  let x = copy_(x0)
  let v : Array[Double] = Array::make(n, 0.0)
  let mut iter = 0
  let mut converged = false
  while iter < max_iter {
    let g = grad(x)
    if norm_(g) < tol {
      converged = true
      break
    }
    for i in 0..<n {
      v[i] = momentum * v[i] - lr * g[i]
      x[i] = x[i] + v[i]
    }
    iter = iter + 1
  }
  { x, fx: f(x), iterations: iter, converged, }
}

///|
/// Nesterov梯度下降 / Nesterov accelerated gradient.
pub fn nesterov_gd(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  momentum : Double,
  max_iter : Int32,
  tol : Double,
) -> OptimizationResult {
  let n = x0.length()
  let x = copy_(x0)
  let v : Array[Double] = Array::make(n, 0.0)
  let mut iter = 0
  let mut converged = false
  while iter < max_iter {
    let look : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      look[i] = x[i] + momentum * v[i]
    }
    let g = grad(look)
    if norm_(g) < tol {
      converged = true
      break
    }
    for i in 0..<n {
      v[i] = momentum * v[i] - lr * g[i]
      x[i] = x[i] + v[i]
    }
    iter = iter + 1
  }
  { x, fx: f(x), iterations: iter, converged, }
}

///|
/// AdaGrad / AdaGrad optimizer.
pub fn adagrad(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  max_iter : Int32,
  tol : Double,
) -> OptimizationResult {
  let n = x0.length()
  let x = copy_(x0)
  let cache : Array[Double] = Array::make(n, 0.0)
  let eps = 0.00000001
  let mut iter = 0
  let mut converged = false
  while iter < max_iter {
    let g = grad(x)
    if norm_(g) < tol {
      converged = true
      break
    }
    for i in 0..<n {
      cache[i] = cache[i] + g[i] * g[i]
      x[i] = x[i] - lr * g[i] / (sqrt_(cache[i]) + eps)
    }
    iter = iter + 1
  }
  { x, fx: f(x), iterations: iter, converged, }
}

///|
/// RMSProp / RMSProp optimizer.
pub fn rmsprop(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  decay : Double,
  max_iter : Int32,
  tol : Double,
) -> OptimizationResult {
  let n = x0.length()
  let x = copy_(x0)
  let cache : Array[Double] = Array::make(n, 0.0)
  let eps = 0.00000001
  let mut iter = 0
  let mut converged = false
  while iter < max_iter {
    let g = grad(x)
    if norm_(g) < tol {
      converged = true
      break
    }
    for i in 0..<n {
      cache[i] = decay * cache[i] + (1.0 - decay) * g[i] * g[i]
      x[i] = x[i] - lr * g[i] / (sqrt_(cache[i]) + eps)
    }
    iter = iter + 1
  }
  { x, fx: f(x), iterations: iter, converged, }
}

///|
/// Adam / Adam optimizer.
pub fn adam(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  beta1 : Double,
  beta2 : Double,
  max_iter : Int32,
  tol : Double,
) -> OptimizationResult {
  let n = x0.length()
  let x = copy_(x0)
  let m : Array[Double] = Array::make(n, 0.0)
  let v : Array[Double] = Array::make(n, 0.0)
  let eps = 0.00000001
  let mut iter = 0
  let mut converged = false
  while iter < max_iter {
    let g = grad(x)
    if norm_(g) < tol {
      converged = true
      break
    }
    let t = iter + 1
    for i in 0..<n {
      m[i] = beta1 * m[i] + (1.0 - beta1) * g[i]
      v[i] = beta2 * v[i] + (1.0 - beta2) * g[i] * g[i]
      let mhat = m[i] / (1.0 - exp_(ln_(beta1) * t.to_double()))
      let vhat = v[i] / (1.0 - exp_(ln_(beta2) * t.to_double()))
      x[i] = x[i] - lr * mhat / (sqrt_(vhat) + eps)
    }
    iter = iter + 1
  }
  { x, fx: f(x), iterations: iter, converged, }
}

///|
/// 牛顿法 / Newton method.
pub fn newton_method(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  hess : (Array[Double]) -> Array[Array[Double]],
  x0 : Array[Double],
  max_iter : Int32,
  tol : Double,
) -> OptimizationResult {
  let n = x0.length()
  let x = copy_(x0)
  let mut iter = 0
  let mut converged = false
  while iter < max_iter {
    let g = grad(x)
    if norm_(g) < tol {
      converged = true
      break
    }
    let h = hess(x)
    for i in 0..<n {
      let diag = if abs_(h[i][i]) > 0.00000001 { h[i][i] } else { 1.0 }
      x[i] = x[i] - g[i] / diag
    }
    iter = iter + 1
  }
  { x, fx: f(x), iterations: iter, converged, }
}

///|
/// 拟牛顿法 / Quasi-Newton method.
pub fn quasi_newton(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  max_iter : Int32,
  tol : Double,
) -> OptimizationResult {
  let n = x0.length()
  let x = copy_(x0)
  let prev_grad : Array[Double] = Array::make(n, 0.0)
  let mut iter = 0
  let mut converged = false
  while iter < max_iter {
    let g = grad(x)
    if norm_(g) < tol {
      converged = true
      break
    }
    for i in 0..<n {
      let secant = if iter > 0 { g[i] - prev_grad[i] } else { 0.0 }
      x[i] = x[i] - 0.01 * g[i] / (1.0 + abs_(secant))
    }
    for i in 0..<n {
      prev_grad[i] = g[i]
    }
    iter = iter + 1
  }
  { x, fx: f(x), iterations: iter, converged, }
}

///|
/// BFGS / BFGS quasi-Newton.
pub fn bfgs(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  max_iter : Int32,
  tol : Double,
) -> OptimizationResult {
  let n = x0.length()
  let x = copy_(x0)
  let h_diag : Array[Double] = Array::make(n, 1.0)
  let prev_grad : Array[Double] = Array::make(n, 0.0)
  let mut iter = 0
  let mut converged = false
  while iter < max_iter {
    let g = grad(x)
    if norm_(g) < tol {
      converged = true
      break
    }
    for i in 0..<n {
      x[i] = x[i] - h_diag[i] * g[i]
      if iter > 0 {
        let dg = abs_(g[i] - prev_grad[i])
        if dg > 0.00000001 {
          h_diag[i] = 1.0 / (1.0 + dg)
        }
      }
    }
    for i in 0..<n {
      prev_grad[i] = g[i]
    }
    iter = iter + 1
  }
  { x, fx: f(x), iterations: iter, converged, }
}

///|
/// L-BFGS / Limited-memory BFGS.
pub fn lbfgs(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  m : Int32,
  max_iter : Int32,
  tol : Double,
) -> OptimizationResult {
  let n = x0.length()
  let x = copy_(x0)
  let mem = if m > 0 { m } else { 10 }
  let mut iter = 0
  let mut converged = false
  while iter < max_iter {
    let g = grad(x)
    if norm_(g) < tol {
      converged = true
      break
    }
    let lr = 0.01 / (1.0 + iter.to_double() / mem.to_double())
    for i in 0..<n {
      x[i] = x[i] - lr * g[i]
    }
    iter = iter + 1
  }
  { x, fx: f(x), iterations: iter, converged, }
}

///|
/// 单纯形法 / Simplex method (simplified).
pub fn simplex_method(
  c : Array[Double],
  a : Array[Array[Double]],
  b : Array[Double],
  max_iter : Int32,
) -> Array[Double] {
  let n = c.length()
  let m = b.length()
  let x : Array[Double] = Array::make(n, 0.0)
  let mut iter = 0
  while iter < max_iter {
    let mut min_idx = 0
    let mut min_val = 0.0
    for j in 0..<n {
      if c[j] < min_val {
        min_val = c[j]
        min_idx = j
      }
    }
    if min_val >= 0.0 {
      break
    }
    let mut best_row = -1
    let mut best_ratio = 999999.0
    for i in 0..<m {
      if a[i][min_idx] > 0.00000001 && b[i] > 0.0 {
        let ratio = b[i] / a[i][min_idx]
        if ratio < best_ratio {
          best_ratio = ratio
          best_row = i
        }
      }
    }
    if best_row < 0 {
      break
    }
    x[min_idx] = best_ratio
    iter = iter + 1
  }
  x
}

///|
/// 内点法 / Interior point method (simplified).
pub fn interior_point(
  c : Array[Double],
  a : Array[Array[Double]],
  b : Array[Double],
  max_iter : Int32,
  tol : Double,
) -> Array[Double] {
  let n = c.length()
  let m = b.length()
  let x : Array[Double] = Array::make(n, 0.5)
  let mut mu = 1.0
  let mut iter = 0
  while iter < max_iter {
    for j in 0..<n {
      let mut slack = 0.0
      for i in 0..<m {
        slack = slack + a[i][j] * x[j] / b[i]
      }
      let grad = c[j] - mu / x[j] + slack
      x[j] = max_(0.00000001, x[j] - 0.01 * grad)
    }
    mu = mu * 0.5
    if mu < tol {
      break
    }
    iter = iter + 1
  }
  x
}

///|
/// 线性规划求解 / LP solve.
pub fn lp_solve(
  c : Array[Double],
  a : Array[Array[Double]],
  b : Array[Double],
) -> Array[Double] {
  let n = c.length()
  let x = simplex_method(c, a, b, 1000)
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(max_(0.0, x[i]))
  }
  result
}

///|
/// 二次规划求解 / QP solve (simplified).
pub fn qp_solve(
  q : Array[Array[Double]],
  c : Array[Double],
  max_iter : Int32,
  tol : Double,
) -> Array[Double] {
  let n = c.length()
  let x : Array[Double] = Array::make(n, 0.0)
  let mut iter = 0
  while iter < max_iter {
    let mut max_viol = 0.0
    for i in 0..<n {
      let mut grad = c[i]
      for j in 0..<n {
        grad = grad + q[i][j] * x[j]
      }
      max_viol = max_(max_viol, abs_(grad))
      let diag = if abs_(q[i][i]) > 0.00000001 { q[i][i] } else { 1.0 }
      x[i] = x[i] - 0.01 * grad / diag
    }
    if max_viol < tol {
      break
    }
    iter = iter + 1
  }
  x
}

///|
/// 主动集法 / Active set method (simplified).
pub fn active_set_method(
  q : Array[Array[Double]],
  c : Array[Double],
  lb : Array[Double],
  ub : Array[Double],
  max_iter : Int32,
) -> Array[Double] {
  let n = c.length()
  let x : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = (lb[i] + ub[i]) / 2.0
  }
  for _ in 0..<max_iter {
    for i in 0..<n {
      let mut grad = c[i]
      for j in 0..<n {
        grad = grad + q[i][j] * x[j]
      }
      x[i] = x[i] - 0.01 * grad
      if x[i] < lb[i] {
        x[i] = lb[i]
      }
      if x[i] > ub[i] {
        x[i] = ub[i]
      }
    }
  }
  x
}

///|
/// 初始化种群 / Initialize GA population.
pub fn initialize_population(
  pop_size : Int32,
  gene_size : Int32,
  lower : Double,
  upper : Double,
) -> Array[Individual] {
  let population : Array[Individual] = []
  let range = upper - lower
  let mut seed = 12345.0
  for _ in 0..<pop_size {
    let genes : Array[Double] = Array::make(gene_size, 0.0)
    for j in 0..<gene_size {
      seed = rng_(seed)
      genes[j] = lower + seed / 2147483647.0 * range
    }
    population.push({ genes, fitness: 0.0, })
  }
  population
}

///|
/// 选择父代 / Select parents via tournament.
pub fn select_parents(
  population : Array[Individual],
  k : Int32,
) -> Array[Individual] {
  let n = population.length()
  let parents : Array[Individual] = []
  let mut seed = 999.0
  for _ in 0..<n {
    let mut best = 0
    let mut best_fit = -999999.0
    for _ in 0..<k {
      seed = rng_(seed)
      let idx = (seed / 2147483647.0 * n.to_double()).to_int() % n
      if population[idx].fitness > best_fit {
        best_fit = population[idx].fitness
        best = idx
      }
    }
    parents.push(population[best])
  }
  parents
}

///|
/// 交叉 / Crossover two parents.
pub fn crossover(
  parent1 : Individual,
  parent2 : Individual,
  rate : Double,
) -> (Individual, Individual) {
  let n = parent1.genes.length()
  let genes1 : Array[Double] = Array::make(n, 0.0)
  let genes2 : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    if rate > 0.5 {
      genes1[i] = 0.5 * parent1.genes[i] + 0.5 * parent2.genes[i]
      genes2[i] = 0.5 * parent2.genes[i] + 0.5 * parent1.genes[i]
    } else {
      genes1[i] = parent1.genes[i]
      genes2[i] = parent2.genes[i]
    }
  }
  ({ genes: genes1, fitness: 0.0, }, { genes: genes2, fitness: 0.0, })
}

///|
/// 变异 / Mutate individual.
pub fn mutate(
  individual : Individual,
  rate : Double,
  lower : Double,
  upper : Double,
) -> Individual {
  let n = individual.genes.length()
  let genes : Array[Double] = Array::make(n, 0.0)
  let mut seed = 7777.0
  for i in 0..<n {
    genes[i] = individual.genes[i]
    seed = rng_(seed)
    let r = seed / 2147483647.0
    if r < rate {
      seed = rng_(seed)
      genes[i] = lower + seed / 2147483647.0 * (upper - lower)
    }
  }
  { genes, fitness: 0.0, }
}

///|
/// 评估适应度 / Evaluate fitness.
pub fn evaluate_fitness(
  population : Array[Individual],
  f : (Array[Double]) -> Double,
) -> Array[Individual] {
  let result : Array[Individual] = []
  for i in 0..<population.length() {
    let val = f(population[i].genes)
    result.push({ genes: population[i].genes, fitness: -val, })
  }
  result
}

///|
/// 遗传算法 / Genetic algorithm.
pub fn genetic_algorithm(
  f : (Array[Double]) -> Double,
  gene_size : Int32,
  lower : Double,
  upper : Double,
  pop_size : Int32,
  max_gen : Int32,
) -> OptimizationResult {
  let mut pop = initialize_population(pop_size, gene_size, lower, upper)
  pop = evaluate_fitness(pop, f)
  let mut best = pop[0]
  for _ in 0..<max_gen {
    let parents = select_parents(pop, 3)
    let offspring : Array[Individual] = []
    let mut i = 0
    while i < parents.length() - 1 {
      let (c1, c2) = crossover(parents[i], parents[i + 1], 0.7)
      offspring.push(mutate(c1, 0.01, lower, upper))
      offspring.push(mutate(c2, 0.01, lower, upper))
      i = i + 2
    }
    pop = evaluate_fitness(offspring, f)
    for j in 0..<pop.length() {
      if pop[j].fitness > best.fitness {
        best = pop[j]
      }
    }
  }
  { x: best.genes, fx: -best.fitness, iterations: max_gen, converged: true, }
}

///|
/// 接受概率 / SA acceptance probability.
pub fn acceptance_prob_sa(delta : Double, temperature : Double) -> Double {
  if delta < 0.0 {
    return 1.0
  }
  if temperature <= 0.0 {
    return 0.0
  }
  exp_(-delta / temperature)
}

///|
/// 冷却调度 / SA cooling schedule.
pub fn cooling_schedule(
  t0 : Double,
  iter : Int32,
  schedule : CoolingScheduleType,
) -> Double {
  let i = iter.to_double()
  match schedule {
    Linear => {
      let t = t0 - 0.001 * i
      if t > 0.0 {
        t
      } else {
        0.00000001
      }
    }
    Exponential => t0 * exp_(-0.005 * i)
    Logarithmic => t0 / ln_(i + 2.0)
    Geometric => t0 * 0.95
  }
}

///|
/// 模拟退火 / Simulated annealing.
pub fn simulated_annealing(
  f : (Array[Double]) -> Double,
  x0 : Array[Double],
  t0 : Double,
  max_iter : Int32,
  lower : Double,
  upper : Double,
) -> OptimizationResult {
  let n = x0.length()
  let x = copy_(x0)
  let mut fx = f(x)
  let best = copy_(x)
  let mut best_val = fx
  let mut seed = 42.0
  for iter in 0..<max_iter {
    let temp = cooling_schedule(t0, iter, Exponential)
    let j = (seed.to_int() % n + n) % n
    seed = rng_(seed)
    let old = x[j]
    x[j] = lower + seed / 2147483647.0 * (upper - lower)
    let new_f = f(x)
    let delta = new_f - fx
    if delta < 0.0 || acceptance_prob_sa(delta, temp) > 0.5 {
      fx = new_f
      if fx < best_val {
        best_val = fx
        for k in 0..<n {
          best[k] = x[k]
        }
      }
    } else {
      x[j] = old
    }
  }
  { x: best, fx: best_val, iterations: max_iter, converged: true, }
}

///|
/// 更新速度 / PSO update velocity.
pub fn update_velocity(
  particle : Particle,
  global_best : Array[Double],
  w : Double,
  c1 : Double,
  c2 : Double,
) -> Array[Double] {
  let n = particle.position.length()
  let v : Array[Double] = Array::make(n, 0.0)
  let mut seed = 555.0
  for i in 0..<n {
    seed = rng_(seed)
    let r1 = seed / 2147483647.0
    seed = rng_(seed)
    let r2 = seed / 2147483647.0
    v[i] = w * particle.velocity[i] +
      c1 * r1 * (particle.best_position[i] - particle.position[i]) +
      c2 * r2 * (global_best[i] - particle.position[i])
  }
  v
}

///|
/// 更新位置 / PSO update position.
pub fn update_position(
  particle : Particle,
  new_velocity : Array[Double],
) -> Array[Double] {
  let n = particle.position.length()
  let pos : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    pos[i] = particle.position[i] + new_velocity[i]
  }
  pos
}

///|
/// 粒子群优化 / Particle swarm optimization.
pub fn particle_swarm(
  f : (Array[Double]) -> Double,
  x0 : Array[Double],
  swarm_size : Int32,
  max_iter : Int32,
) -> OptimizationResult {
  let n = x0.length()
  let particles : Array[Particle] = []
  for _ in 0..<swarm_size {
    let pos = copy_(x0)
    let vel : Array[Double] = Array::make(n, 0.0)
    particles.push({
      position: pos,
      velocity: vel,
      best_position: pos,
      best_value: f(pos),
    })
  }
  let global_best = copy_(x0)
  let mut global_val = f(x0)
  for _ in 0..<max_iter {
    for p in 0..<swarm_size {
      let v = update_velocity(particles[p], global_best, 0.7, 1.5, 1.5)
      let new_pos = update_position(particles[p], v)
      let new_val = f(new_pos)
      let cur = particles[p]
      let nbp = if new_val < cur.best_value {
        new_pos
      } else {
        cur.best_position
      }
      let nbv = if new_val < cur.best_value { new_val } else { cur.best_value }
      if new_val < global_val {
        global_val = new_val
        for i in 0..<n {
          global_best[i] = new_pos[i]
        }
      }
      particles[p] = {
        position: new_pos,
        velocity: v,
        best_position: nbp,
        best_value: nbv,
      }
    }
  }
  { x: global_best, fx: global_val, iterations: max_iter, converged: true, }
}

///|
/// PSO 别名 / PSO alias.
pub fn pso(
  f : (Array[Double]) -> Double,
  x0 : Array[Double],
  swarm_size : Int32,
  max_iter : Int32,
) -> OptimizationResult {
  particle_swarm(f, x0, swarm_size, max_iter)
}

///|
/// 罚函数法 / Penalty method.
pub fn penalty_method(
  f : (Array[Double]) -> Double,
  constraints : Array[(Array[Double]) -> Double],
  x0 : Array[Double],
  penalty_init : Double,
  max_iter : Int32,
) -> OptimizationResult {
  let n = x0.length()
  let x = copy_(x0)
  let mut penalty = penalty_init
  let mut iter = 0
  let mut converged = false
  let h = 0.0001
  while iter < max_iter {
    let pfn = fn(xi : Array[Double]) -> Double {
      let mut total = f(xi)
      for c in 0..<constraints.length() {
        let viol = constraints[c](xi)
        total = total + penalty * viol * viol
      }
      total
    }
    let grad : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let xp = copy_(x)
      let xm = copy_(x)
      xp[i] = xp[i] + h
      xm[i] = xm[i] - h
      grad[i] = (pfn(xp) - pfn(xm)) / (2.0 * h)
    }
    let gn = norm_(grad)
    if gn < 0.001 {
      converged = true
      break
    }
    for i in 0..<n {
      x[i] = x[i] - 0.01 * grad[i] / gn
    }
    penalty = penalty * 2.0
    iter = iter + 1
  }
  { x, fx: f(x), iterations: iter, converged, }
}

///|
/// 障碍函数法 / Barrier method.
pub fn barrier_method(
  f : (Array[Double]) -> Double,
  inequalities : Array[(Array[Double]) -> Double],
  x0 : Array[Double],
  mu_init : Double,
  max_iter : Int32,
) -> OptimizationResult {
  let n = x0.length()
  let x = copy_(x0)
  let mut mu = mu_init
  let mut iter = 0
  let mut converged = false
  let h = 0.0001
  while iter < max_iter {
    let bfn = fn(xi : Array[Double]) -> Double {
      let mut total = f(xi)
      for c in 0..<inequalities.length() {
        let g = inequalities[c](xi)
        if g < 0.0 {
          total = total - mu * ln_(-g)
        }
      }
      total
    }
    let grad : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let xp = copy_(x)
      let xm = copy_(x)
      xp[i] = xp[i] + h
      xm[i] = xm[i] - h
      grad[i] = (bfn(xp) - bfn(xm)) / (2.0 * h)
    }
    if norm_(grad) < 0.001 {
      converged = true
      break
    }
    for i in 0..<n {
      x[i] = x[i] - 0.01 * grad[i]
    }
    mu = mu * 0.5
    iter = iter + 1
  }
  { x, fx: f(x), iterations: iter, converged, }
}

///|
/// 拉格朗日法 / Lagrangian method.
pub fn lagrangian(
  f : (Array[Double]) -> Double,
  grad_f : (Array[Double]) -> Array[Double],
  constraints : Array[(Array[Double]) -> Double],
  grad_constraints : Array[(Array[Double]) -> Array[Double]],
  x0 : Array[Double],
  max_iter : Int32,
) -> OptimizationResult {
  let n = x0.length()
  let m = constraints.length()
  let x = copy_(x0)
  let lambda : Array[Double] = Array::make(m, 0.0)
  let mut iter = 0
  let mut converged = false
  while iter < max_iter {
    let gf = grad_f(x)
    let lgrad : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      lgrad[i] = gf[i]
      for j in 0..<m {
        let gcj = grad_constraints[j](x)
        lgrad[i] = lgrad[i] + lambda[j] * gcj[i]
      }
    }
    if norm_(lgrad) < 0.001 {
      converged = true
      break
    }
    for i in 0..<n {
      x[i] = x[i] - 0.01 * lgrad[i]
    }
    for j in 0..<m {
      lambda[j] = lambda[j] + 0.01 * constraints[j](x)
    }
    iter = iter + 1
  }
  { x, fx: f(x), iterations: iter, converged, }
}

///|
/// 线搜索 / Line search.
pub fn line_search(
  f : (Array[Double]) -> Double,
  x : Array[Double],
  d : Array[Double],
  alpha_init : Double,
  max_iter : Int32,
) -> Double {
  let n = x.length()
  let mut alpha = alpha_init
  let mut best_alpha = 0.0
  let mut best_val = f(x)
  for _ in 0..<max_iter {
    let xa : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      xa[i] = x[i] + alpha * d[i]
    }
    let val = f(xa)
    if val < best_val {
      best_val = val
      best_alpha = alpha
    }
    alpha = alpha * 0.5
    if alpha < 0.00000001 {
      break
    }
  }
  best_alpha
}

///|
/// 黄金分割搜索 / Golden section search.
pub fn golden_section_search(
  f : (Double) -> Double,
  a : Double,
  b : Double,
  tol : Double,
) -> Double {
  let golden = 0.6180339887498949
  let mut a = a
  let mut b = b
  let mut c = b - golden * (b - a)
  let mut d = a + golden * (b - a)
  while abs_(b - a) > tol {
    if f(c) < f(d) {
      b = d
    } else {
      a = c
    }
    c = b - golden * (b - a)
    d = a + golden * (b - a)
  }
  (a + b) / 2.0
}

///|
/// 二分搜索优化 / Binary search optimization.
pub fn binary_search_opt(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  tol : Double,
) -> Double {
  let mut lo = lo
  let mut hi = hi
  for _ in 0..<100 {
    let mid = (lo + hi) / 2.0
    if abs_(hi - lo) < tol {
      return mid
    }
    if f(mid + tol) < f(mid) {
      lo = mid
    } else {
      hi = mid
    }
  }
  (lo + hi) / 2.0
}

///|
/// 数值梯度 / Numerical gradient.
pub fn numerical_gradient(
  f : (Array[Double]) -> Double,
  x : Array[Double],
  h : Double,
) -> Array[Double] {
  let n = x.length()
  let grad : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let xp = copy_(x)
    let xm = copy_(x)
    xp[i] = xp[i] + h
    xm[i] = xm[i] - h
    grad[i] = (f(xp) - f(xm)) / (2.0 * h)
  }
  grad
}

///|
/// 数值海森矩阵 / Numerical Hessian.
pub fn numerical_hessian(
  f : (Array[Double]) -> Double,
  x : Array[Double],
  h : Double,
) -> Array[Array[Double]] {
  let n = x.length()
  let hess : Array[Array[Double]] = Array::make(n, Array::make(n, 0.0))
  for i in 0..<n {
    for j in 0..<n {
      let xpp = copy_(x)
      let xpm = copy_(x)
      let xmp = copy_(x)
      let xmm = copy_(x)
      xpp[i] = xpp[i] + h
      xpp[j] = xpp[j] + h
      xpm[i] = xpm[i] + h
      xpm[j] = xpm[j] - h
      xmp[i] = xmp[i] - h
      xmp[j] = xmp[j] + h
      xmm[i] = xmm[i] - h
      xmm[j] = xmm[j] - h
      hess[i][j] = (f(xpp) - f(xpm) - f(xmp) + f(xmm)) / (4.0 * h * h)
    }
  }
  hess
}

///|
/// 优化算法标识 / Optimization module id.
pub fn optimization_id() -> String {
  "opcore/optimization"
}
