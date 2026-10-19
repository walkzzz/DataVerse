///===
/// extcore/p2285 - Extended core package #2285

pub(all) struct P2285Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn p2285_make_point(x : Double, y : Double) -> P2285Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn p2285_make_point3(x : Double, y : Double, z : Double) -> P2285Point {
  { x, y, z, label: 0 }
}

pub fn p2285_make_labeled_point(x : Double, y : Double, label : Int) -> P2285Point {
  { x, y, z: 0.0, label }
}

pub fn p2285_point_x(pt : P2285Point) -> Double { pt.x }

pub fn p2285_point_y(pt : P2285Point) -> Double { pt.y }

pub fn p2285_point_z(pt : P2285Point) -> Double { pt.z }

pub fn p2285_point_label(pt : P2285Point) -> Int { pt.label }

pub fn p2285_point_dist(a : P2285Point, b : P2285Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  p2285_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn p2285_point_dist2d(a : P2285Point, b : P2285Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  p2285_sqrt(dx * dx + dy * dy)
}

pub fn p2285_point_add(a : P2285Point, b : P2285Point) -> P2285Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn p2285_point_sub(a : P2285Point, b : P2285Point) -> P2285Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn p2285_point_scale(pt : P2285Point, s : Double) -> P2285Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn p2285_point_dot(a : P2285Point, b : P2285Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn p2285_point_cross(a : P2285Point, b : P2285Point) -> P2285Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn p2285_point_norm(pt : P2285Point) -> Double {
  p2285_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn p2285_point_normalize(pt : P2285Point) -> P2285Point {
  let n = p2285_point_norm(pt)
  if n < 0.0000001 { pt } else {
    p2285_point_scale(pt, 1.0 / n)
  }
}

pub fn p2285_point_negate(pt : P2285Point) -> P2285Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn p2285_point_mid(a : P2285Point, b : P2285Point) -> P2285Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn p2285_point_lerp(a : P2285Point, b : P2285Point, t : Double) -> P2285Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn p2285_point_angle(a : P2285Point, b : P2285Point) -> Double {
  let na = p2285_point_norm(a)
  let nb = p2285_point_norm(b)
  if na < 0.0000001 || nb < 0.0000001 { 0.0 } else { p2285_acos(p2285_point_dot(a, b) / (na * nb)) }
}

pub fn p2285_point_to_string(pt : P2285Point) -> String {
  "(" + p2285_dbl(pt.x) + ", " + p2285_dbl(pt.y) + ", " + p2285_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct P2285Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn p2285_make_series(vals : Array[Double], name : String) -> P2285Series {
  { vals, name, meta: 0 }
}

pub fn p2285_make_series_meta(vals : Array[Double], name : String, meta : Int) -> P2285Series {
  { vals, name, meta }
}

pub fn p2285_series_len(s : P2285Series) -> Int { s.vals.length() }

pub fn p2285_series_sum(s : P2285Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn p2285_series_mean(s : P2285Series) -> Double {
  let n = p2285_series_len(s)
  if n == 0 { 0.0 } else { p2285_series_sum(s) / n.to_double() }
}

pub fn p2285_series_min(s : P2285Series) -> Double {
  let n = p2285_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn p2285_series_max(s : P2285Series) -> Double {
  let n = p2285_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn p2285_series_range(s : P2285Series) -> Double {
  p2285_series_max(s) - p2285_series_min(s)
}

pub fn p2285_series_var(s : P2285Series) -> Double {
  let n = p2285_series_len(s)
  if n == 0 { 0.0 } else {
    let m = p2285_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn p2285_series_std(s : P2285Series) -> Double { p2285_sqrt(p2285_series_var(s)) }

pub fn p2285_series_median(s : P2285Series) -> Double {
  let n = p2285_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = p2285_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn p2285_series_skew(s : P2285Series) -> Double {
  let n = p2285_series_len(s)
  if n < 3 { 0.0 } else {
    let m = p2285_series_mean(s)
    let sd = p2285_series_std(s)
    if sd < 0.0000001 { 0.0 } else {
      let mut total = 0.0
      for i in 0..<n { let d = (s.vals[i] - m) / sd; total = total + d * d * d }
      total / n.to_double()
    }
  }
}

pub fn p2285_series_kurt(s : P2285Series) -> Double {
  let n = p2285_series_len(s)
  if n < 4 { 0.0 } else {
    let m = p2285_series_mean(s)
    let sd = p2285_series_std(s)
    if sd < 0.0000001 { 0.0 } else {
      let mut total = 0.0
      for i in 0..<n { let d = (s.vals[i] - m) / sd; total = total + d * d * d * d }
      total / n.to_double() - 3.0
    }
  }
}

pub fn p2285_series_scale(s : P2285Series, f : Double) -> P2285Series {
  let mut result = []
  for i in 0..<s.vals.length() { result = p2285_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn p2285_series_add(a : P2285Series, b : P2285Series) -> P2285Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = p2285_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn p2285_series_sub(a : P2285Series, b : P2285Series) -> P2285Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = p2285_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn p2285_series_mul(a : P2285Series, b : P2285Series) -> P2285Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = p2285_push(result, a.vals[i] * b.vals[i]) }
  { vals: result, name: a.name + "*" + b.name, meta: a.meta }
}

pub fn p2285_series_normalize(s : P2285Series) -> P2285Series {
  let mn = p2285_series_min(s)
  let mx = p2285_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = p2285_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn p2285_series_standardize(s : P2285Series) -> P2285Series {
  let m = p2285_series_mean(s)
  let sd = p2285_series_std(s)
  if sd < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = p2285_push(result, (s.vals[i] - m) / sd) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn p2285_series_cumsum(s : P2285Series) -> P2285Series {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = p2285_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn p2285_series_cumprod(s : P2285Series) -> P2285Series {
  let mut result = []
  let mut total = 1.0
  for i in 0..<s.vals.length() { total = total * s.vals[i]; result = p2285_push(result, total) }
  { vals: result, name: s.name + "_cumprod", meta: s.meta }
}

pub fn p2285_series_diff(s : P2285Series) -> P2285Series {
  let n = s.vals.length()
  if n < 2 { { vals: [], name: s.name + "_diff", meta: s.meta } } else {
    let mut result = []
    for i in 1..<n { result = p2285_push(result, s.vals[i] - s.vals[i - 1]) }
    { vals: result, name: s.name + "_diff", meta: s.meta }
  }
}

pub fn p2285_series_to_string(s : P2285Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + p2285_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct P2285Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn p2285_make_matrix(rows : Int, cols : Int, val : Double) -> P2285Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn p2285_matrix_identity(n : Int) -> P2285Matrix {
  let m = p2285_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn p2285_matrix_get(m : P2285Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn p2285_matrix_set(m : P2285Matrix, i : Int, j : Int, v : Double) -> P2285Matrix {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { m } else {
    m.data[i][j] = v
    m
  }
}

pub fn p2285_matrix_transpose(m : P2285Matrix) -> P2285Matrix {
  let result = p2285_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn p2285_matrix_add(a : P2285Matrix, b : P2285Matrix) -> P2285Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = p2285_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn p2285_matrix_sub(a : P2285Matrix, b : P2285Matrix) -> P2285Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = p2285_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] - b.data[i][j] } }
  result
}

pub fn p2285_matrix_scale(m : P2285Matrix, s : Double) -> P2285Matrix {
  let result = p2285_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn p2285_matrix_multiply(a : P2285Matrix, b : P2285Matrix) -> P2285Matrix {
  if a.cols != b.rows { return p2285_make_matrix(a.rows, b.cols, 0.0) }
  let result = p2285_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn p2285_matrix_trace(m : P2285Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn p2285_matrix_det(m : P2285Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn p2285_matrix_norm(m : P2285Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  p2285_sqrt(sum)
}

pub fn p2285_matrix_frobenius(m : P2285Matrix) -> Double { p2285_matrix_norm(m) }

pub fn p2285_matrix_row_sum(m : P2285Matrix, i : Int) -> Double {
  if i < 0 || i >= m.rows { 0.0 } else {
    let mut s = 0.0
    for j in 0..<m.cols { s = s + m.data[i][j] }
    s
  }
}

pub fn p2285_matrix_col_sum(m : P2285Matrix, j : Int) -> Double {
  if j < 0 || j >= m.cols { 0.0 } else {
    let mut s = 0.0
    for i in 0..<m.rows { s = s + m.data[i][j] }
    s
  }
}

pub fn p2285_matrix_to_string(m : P2285Matrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + p2285_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct P2285Vector {
  comps : Array[Double]
  dim : Int
}

pub fn p2285_make_vector(comps : Array[Double]) -> P2285Vector {
  { comps, dim: comps.length() }
}

pub fn p2285_vector_zero(dim : Int) -> P2285Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn p2285_vector_ones(dim : Int) -> P2285Vector {
  { comps: Array::make(dim, 1.0), dim }
}

pub fn p2285_vector_add(a : P2285Vector, b : P2285Vector) -> P2285Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = p2285_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn p2285_vector_sub(a : P2285Vector, b : P2285Vector) -> P2285Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = p2285_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn p2285_vector_scale(v : P2285Vector, s : Double) -> P2285Vector {
  let mut result = []
  for i in 0..<v.dim { result = p2285_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn p2285_vector_dot(a : P2285Vector, b : P2285Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn p2285_vector_norm(v : P2285Vector) -> Double { p2285_sqrt(p2285_vector_dot(v, v)) }

pub fn p2285_vector_normalize(v : P2285Vector) -> P2285Vector {
  let n = p2285_vector_norm(v)
  if n < 0.0000001 { v } else { p2285_vector_scale(v, 1.0 / n) }
}

pub fn p2285_vector_dist(a : P2285Vector, b : P2285Vector) -> Double {
  p2285_vector_norm(p2285_vector_sub(a, b))
}

pub fn p2285_vector_l1_norm(v : P2285Vector) -> Double {
  let mut s = 0.0
  for i in 0..<v.dim { s = s + p2285_abs(v.comps[i]) }
  s
}

pub fn p2285_vector_linf_norm(v : P2285Vector) -> Double {
  let mut m = 0.0
  for i in 0..<v.dim { let a = p2285_abs(v.comps[i]); if a > m { m = a } }
  m
}

pub fn p2285_vector_to_string(v : P2285Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + p2285_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct P2285Tensor3D {
  data : Array[Array[Array[Double]]]
  d0 : Int
  d1 : Int
  d2 : Int
}

pub fn p2285_make_tensor3(d0 : Int, d1 : Int, d2 : Int, val : Double) -> P2285Tensor3D {
  let data = Array::make(d0, Array::make(d1, Array::make(d2, val)))
  for i in 0..<d0 {
    let layer = Array::make(d1, Array::make(d2, val))
    for j in 0..<d1 { layer[j] = Array::make(d2, val) }
    data[i] = layer
  }
  { data, d0, d1, d2 }
}

pub fn p2285_tensor3_get(t : P2285Tensor3D, i : Int, j : Int, k : Int) -> Double {
  if i < 0 || i >= t.d0 || j < 0 || j >= t.d1 || k < 0 || k >= t.d2 { 0.0 } else { t.data[i][j][k] }
}

pub fn p2285_tensor3_sum(t : P2285Tensor3D) -> Double {
  let mut s = 0.0
  for i in 0..<t.d0 { for j in 0..<t.d1 { for k in 0..<t.d2 { s = s + t.data[i][j][k] } } }
  s
}

pub fn p2285_tensor3_scale(t : P2285Tensor3D, f : Double) -> P2285Tensor3D {
  let result = p2285_make_tensor3(t.d0, t.d1, t.d2, 0.0)
  for i in 0..<t.d0 { for j in 0..<t.d1 { for k in 0..<t.d2 { result.data[i][j][k] = t.data[i][j][k] * f } } }
  result
}

pub(all) struct P2285Graph {
  n : Int
  adj : Array[Array[Double]]
}

pub fn p2285_make_graph(n : Int) -> P2285Graph {
  let adj = Array::make(n, Array::make(n, 0.0))
  for i in 0..<n { adj[i] = Array::make(n, 0.0) }
  { n, adj }
}

pub fn p2285_graph_add_edge(g : P2285Graph, u : Int, v : Int, w : Double) -> P2285Graph {
  if u < 0 || u >= g.n || v < 0 || v >= g.n { g } else {
    g.adj[u][v] = w
    g
  }
}

pub fn p2285_graph_degree(g : P2285Graph, u : Int) -> Int {
  if u < 0 || u >= g.n { 0 } else {
    let mut d = 0
    for v in 0..<g.n { if g.adj[u][v] != 0.0 { d = d + 1 } }
    d
  }
}

pub fn p2285_graph_edge_count(g : P2285Graph) -> Int {
  let mut c = 0
  for i in 0..<g.n { for j in 0..<g.n { if g.adj[i][j] != 0.0 { c = c + 1 } } }
  c
}

pub(all) struct P2285TreeNode {
  val : Double
  left : Int
  right : Int
}

pub fn p2285_make_node(val : Double) -> P2285TreeNode {
  { val, left: -1, right: -1 }
}

pub fn p2285_node_set_left(n : P2285TreeNode, l : Int) -> P2285TreeNode {
  { val: n.val, left: l, right: n.right }
}

pub fn p2285_node_set_right(n : P2285TreeNode, r : Int) -> P2285TreeNode {
  { val: n.val, left: n.left, right: r }
}

pub(all) struct P2285LinkedList {
  data : Array[Double]
  size : Int
}

pub fn p2285_make_linked_list() -> P2285LinkedList {
  { data: [], size: 0 }
}

pub fn p2285_ll_push(lst : P2285LinkedList, v : Double) -> P2285LinkedList {
  let nd = p2285_push(lst.data, v)
  { data: nd, size: lst.size + 1 }
}

pub fn p2285_ll_get(lst : P2285LinkedList, i : Int) -> Double {
  if i < 0 || i >= lst.size { 0.0 } else { lst.data[i] }
}

pub fn p2285_ll_sum(lst : P2285LinkedList) -> Double {
  let mut s = 0.0
  for i in 0..<lst.size { s = s + lst.data[i] }
  s
}

pub fn p2285_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn p2285_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = p2285_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn p2285_std(data : Array[Double]) -> Double { p2285_sqrt(p2285_var(data)) }

pub fn p2285_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = p2285_mean(a); let mb = p2285_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn p2285_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = p2285_std(a); let sb = p2285_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { p2285_cov(a, b) / (sa * sb) }
}

pub fn p2285_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = p2285_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn p2285_quantile(data : Array[Double], q : Double) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = p2285_sort(data)
    let idx = q * (n - 1).to_double()
    let lo = p2285_int(idx)
    let hi = if lo + 1 < n { lo + 1 } else { lo }
    let frac = idx - lo.to_double()
    sorted[lo] + (sorted[hi] - sorted[lo]) * frac
  }
}

pub fn p2285_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn p2285_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn p2285_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  p2285_sqrt(p2285_mse(pred, labels))
}

pub fn p2285_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + p2285_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn p2285_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = p2285_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn p2285_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn p2285_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn p2285_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = p2285_precision(pred, labels, pos); let r = p2285_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn p2285_log_loss(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n {
      let p = if pred[i] < 0.0000001 { 0.0000001 } else if pred[i] > 0.9999999 { 0.9999999 } else { pred[i] }
      sum = sum + -(labels[i] * p2285_log(p) + (1.0 - labels[i]) * p2285_log(1.0 - p))
    }
    sum / n.to_double()
  }
}

pub fn p2285_hinge_loss(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let h = 1.0 - labels[i] * pred[i]; sum = sum + (if h > 0.0 { h } else { 0.0 }) }
    sum / n.to_double()
  }
}

pub fn p2285_sort(arr : Array[Double]) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  for i in 0..<n {
    let mut min_idx = i
    let start = i + 1
    for j in start..<n { if result[j] < result[min_idx] { min_idx = j } }
    let tmp = result[i]; result[i] = result[min_idx]; result[min_idx] = tmp
  }
  result
}

pub fn p2285_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = p2285_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn p2285_argsort(arr : Array[Double]) -> Array[Int] {
  let n = arr.length()
  let idx = Array::make(n, 0)
  for i in 0..<n { idx[i] = i }
  for i in 0..<n {
    let mut min_idx = i
    let start = i + 1
    for j in start..<n { if arr[idx[j]] < arr[idx[min_idx]] { min_idx = j } }
    let tmp = idx[i]; idx[i] = idx[min_idx]; idx[min_idx] = tmp
  }
  idx
}

pub fn p2285_rank(arr : Array[Double]) -> Array[Double] {
  let sorted = p2285_sort(arr)
  let n = arr.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    let mut r = 0
    for j in 0..<n { if sorted[j] < arr[i] { r = r + 1 } }
    result[i] = r.to_double()
  }
  result
}

pub fn p2285_binary_search(arr : Array[Double], target : Double) -> Int {
  let mut lo = 0
  let mut hi = arr.length() - 1
  let mut result = -1
  while lo <= hi {
    let mid = (lo + hi) / 2
    if arr[mid] < target { lo = mid + 1 }
    else if arr[mid] > target { hi = mid - 1 }
    else { result = mid; lo = mid + 1 }
  }
  result
}

pub fn p2285_linear_search(arr : Array[Double], target : Double) -> Int {
  let mut result = -1
  for i in 0..<arr.length() { if arr[i] == target { result = i } }
  result
}

pub fn p2285_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn p2285_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn p2285_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = p2285_gcd(a, b)
    (a / g) * b
  }
}

pub fn p2285_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn p2285_fibonacci(n : Int) -> Int {
  if n < 2 {
    n
  } else {
    let mut a = 0
    let mut b = 1
    let end = n + 1
    for _ in 2..<end {
      let c = a + b
      a = b
      b = c
    }
    b
  }
}

pub fn p2285_binomial(n : Int, k : Int) -> Double {
  if k < 0 || k > n { 0.0 } else if k == 0 || k == n { 1.0 } else {
    p2285_factorial(n) / (p2285_factorial(k) * p2285_factorial(n - k))
  }
}

pub fn p2285_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = p2285_min(data); let mx = p2285_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn p2285_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = p2285_mean(data); let sd = p2285_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn p2285_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn p2285_bin(data : Array[Double], n_bins : Int) -> Array[Int] {
  let n = data.length()
  if n == 0 || n_bins <= 0 { [] } else {
    let mn = p2285_min(data); let mx = p2285_max(data)
    let r = mx - mn
    let result = Array::make(n, 0)
    for i in 0..<n { if r < 0.0000001 { result[i] = 0 } else { let b = p2285_int((data[i] - mn) / r * n_bins.to_double()); result[i] = if b >= n_bins { n_bins - 1 } else { b } } }
    result
  }
}

pub fn p2285_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn p2285_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn p2285_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn p2285_cumprod(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 1.0
  for i in 0..<n { total = total * data[i]; result[i] = total }
  result
}

pub fn p2285_diff(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n < 2 { [] } else {
    let result = Array::make(n - 1, 0.0)
    for i in 1..<n { result[i - 1] = data[i] - data[i - 1] }
    result
  }
}

pub fn p2285_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn p2285_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub fn p2285_slice(data : Array[Double], start : Int, end : Int) -> Array[Double] {
  let n = data.length()
  let s = if start < 0 { 0 } else { start }
  let e = if end > n { n } else { end }
  if s >= e { [] } else {
    let len = e - s
    let result = Array::make(len, 0.0)
    for i in 0..<len { result[i] = data[s + i] }
    result
  }
}

fn p2285_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn p2285_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn p2285_log(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut y = (x - 1.0) / (x + 1.0)
    let mut result = 0.0
    let y2 = y * y
    for k in 0..<50 {
      let coeff = 1.0 / (2 * k + 1).to_double()
      result = result + coeff * y
      y = y * y2
    }
    2.0 * result
  }
}

fn p2285_exp(x : Double) -> Double {
  let mut result = 1.0
  let mut term = 1.0
  for k in 1..<50 {
    term = term * x / k.to_double()
    result = result + term
  }
  result
}

fn p2285_acos(x : Double) -> Double {
  let cx = if x < -1.0 { -1.0 } else if x > 1.0 { 1.0 } else { x }
  1.5707963267948966 - cx - cx * cx * cx / 6.0 - 3.0 * cx * cx * cx * cx * cx / 40.0
}

fn p2285_dbl(x : Double) -> String {
  let i = if x >= 0.0 { p2285_int(x) } else { -p2285_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { p2285_int(f * 1000000.0) } else { p2285_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn p2285_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn p2285_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

