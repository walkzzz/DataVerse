///===
/// extcore/p1925 - Extended core package #1925

pub(all) struct P1925Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn p1925_make_point(x : Double, y : Double) -> P1925Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn p1925_make_point3(x : Double, y : Double, z : Double) -> P1925Point {
  { x, y, z, label: 0 }
}

pub fn p1925_make_labeled_point(x : Double, y : Double, label : Int) -> P1925Point {
  { x, y, z: 0.0, label }
}

pub fn p1925_point_x(pt : P1925Point) -> Double { pt.x }

pub fn p1925_point_y(pt : P1925Point) -> Double { pt.y }

pub fn p1925_point_z(pt : P1925Point) -> Double { pt.z }

pub fn p1925_point_label(pt : P1925Point) -> Int { pt.label }

pub fn p1925_point_dist(a : P1925Point, b : P1925Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  p1925_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn p1925_point_dist2d(a : P1925Point, b : P1925Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  p1925_sqrt(dx * dx + dy * dy)
}

pub fn p1925_point_add(a : P1925Point, b : P1925Point) -> P1925Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn p1925_point_sub(a : P1925Point, b : P1925Point) -> P1925Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn p1925_point_scale(pt : P1925Point, s : Double) -> P1925Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn p1925_point_dot(a : P1925Point, b : P1925Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn p1925_point_cross(a : P1925Point, b : P1925Point) -> P1925Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn p1925_point_norm(pt : P1925Point) -> Double {
  p1925_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn p1925_point_normalize(pt : P1925Point) -> P1925Point {
  let n = p1925_point_norm(pt)
  if n < 0.0000001 { pt } else {
    p1925_point_scale(pt, 1.0 / n)
  }
}

pub fn p1925_point_negate(pt : P1925Point) -> P1925Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn p1925_point_mid(a : P1925Point, b : P1925Point) -> P1925Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn p1925_point_lerp(a : P1925Point, b : P1925Point, t : Double) -> P1925Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn p1925_point_angle(a : P1925Point, b : P1925Point) -> Double {
  let na = p1925_point_norm(a)
  let nb = p1925_point_norm(b)
  if na < 0.0000001 || nb < 0.0000001 { 0.0 } else { p1925_acos(p1925_point_dot(a, b) / (na * nb)) }
}

pub fn p1925_point_to_string(pt : P1925Point) -> String {
  "(" + p1925_dbl(pt.x) + ", " + p1925_dbl(pt.y) + ", " + p1925_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct P1925Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn p1925_make_series(vals : Array[Double], name : String) -> P1925Series {
  { vals, name, meta: 0 }
}

pub fn p1925_make_series_meta(vals : Array[Double], name : String, meta : Int) -> P1925Series {
  { vals, name, meta }
}

pub fn p1925_series_len(s : P1925Series) -> Int { s.vals.length() }

pub fn p1925_series_sum(s : P1925Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn p1925_series_mean(s : P1925Series) -> Double {
  let n = p1925_series_len(s)
  if n == 0 { 0.0 } else { p1925_series_sum(s) / n.to_double() }
}

pub fn p1925_series_min(s : P1925Series) -> Double {
  let n = p1925_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn p1925_series_max(s : P1925Series) -> Double {
  let n = p1925_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn p1925_series_range(s : P1925Series) -> Double {
  p1925_series_max(s) - p1925_series_min(s)
}

pub fn p1925_series_var(s : P1925Series) -> Double {
  let n = p1925_series_len(s)
  if n == 0 { 0.0 } else {
    let m = p1925_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn p1925_series_std(s : P1925Series) -> Double { p1925_sqrt(p1925_series_var(s)) }

pub fn p1925_series_median(s : P1925Series) -> Double {
  let n = p1925_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = p1925_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn p1925_series_skew(s : P1925Series) -> Double {
  let n = p1925_series_len(s)
  if n < 3 { 0.0 } else {
    let m = p1925_series_mean(s)
    let sd = p1925_series_std(s)
    if sd < 0.0000001 { 0.0 } else {
      let mut total = 0.0
      for i in 0..<n { let d = (s.vals[i] - m) / sd; total = total + d * d * d }
      total / n.to_double()
    }
  }
}

pub fn p1925_series_kurt(s : P1925Series) -> Double {
  let n = p1925_series_len(s)
  if n < 4 { 0.0 } else {
    let m = p1925_series_mean(s)
    let sd = p1925_series_std(s)
    if sd < 0.0000001 { 0.0 } else {
      let mut total = 0.0
      for i in 0..<n { let d = (s.vals[i] - m) / sd; total = total + d * d * d * d }
      total / n.to_double() - 3.0
    }
  }
}

pub fn p1925_series_scale(s : P1925Series, f : Double) -> P1925Series {
  let mut result = []
  for i in 0..<s.vals.length() { result = p1925_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn p1925_series_add(a : P1925Series, b : P1925Series) -> P1925Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = p1925_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn p1925_series_sub(a : P1925Series, b : P1925Series) -> P1925Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = p1925_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn p1925_series_mul(a : P1925Series, b : P1925Series) -> P1925Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = p1925_push(result, a.vals[i] * b.vals[i]) }
  { vals: result, name: a.name + "*" + b.name, meta: a.meta }
}

pub fn p1925_series_normalize(s : P1925Series) -> P1925Series {
  let mn = p1925_series_min(s)
  let mx = p1925_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = p1925_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn p1925_series_standardize(s : P1925Series) -> P1925Series {
  let m = p1925_series_mean(s)
  let sd = p1925_series_std(s)
  if sd < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = p1925_push(result, (s.vals[i] - m) / sd) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn p1925_series_cumsum(s : P1925Series) -> P1925Series {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = p1925_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn p1925_series_cumprod(s : P1925Series) -> P1925Series {
  let mut result = []
  let mut total = 1.0
  for i in 0..<s.vals.length() { total = total * s.vals[i]; result = p1925_push(result, total) }
  { vals: result, name: s.name + "_cumprod", meta: s.meta }
}

pub fn p1925_series_diff(s : P1925Series) -> P1925Series {
  let n = s.vals.length()
  if n < 2 { { vals: [], name: s.name + "_diff", meta: s.meta } } else {
    let mut result = []
    for i in 1..<n { result = p1925_push(result, s.vals[i] - s.vals[i - 1]) }
    { vals: result, name: s.name + "_diff", meta: s.meta }
  }
}

pub fn p1925_series_to_string(s : P1925Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + p1925_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct P1925Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn p1925_make_matrix(rows : Int, cols : Int, val : Double) -> P1925Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn p1925_matrix_identity(n : Int) -> P1925Matrix {
  let m = p1925_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn p1925_matrix_get(m : P1925Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn p1925_matrix_set(m : P1925Matrix, i : Int, j : Int, v : Double) -> P1925Matrix {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { m } else {
    m.data[i][j] = v
    m
  }
}

pub fn p1925_matrix_transpose(m : P1925Matrix) -> P1925Matrix {
  let result = p1925_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn p1925_matrix_add(a : P1925Matrix, b : P1925Matrix) -> P1925Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = p1925_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn p1925_matrix_sub(a : P1925Matrix, b : P1925Matrix) -> P1925Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = p1925_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] - b.data[i][j] } }
  result
}

pub fn p1925_matrix_scale(m : P1925Matrix, s : Double) -> P1925Matrix {
  let result = p1925_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn p1925_matrix_multiply(a : P1925Matrix, b : P1925Matrix) -> P1925Matrix {
  if a.cols != b.rows { return p1925_make_matrix(a.rows, b.cols, 0.0) }
  let result = p1925_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn p1925_matrix_trace(m : P1925Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn p1925_matrix_det(m : P1925Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn p1925_matrix_norm(m : P1925Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  p1925_sqrt(sum)
}

pub fn p1925_matrix_frobenius(m : P1925Matrix) -> Double { p1925_matrix_norm(m) }

pub fn p1925_matrix_row_sum(m : P1925Matrix, i : Int) -> Double {
  if i < 0 || i >= m.rows { 0.0 } else {
    let mut s = 0.0
    for j in 0..<m.cols { s = s + m.data[i][j] }
    s
  }
}

pub fn p1925_matrix_col_sum(m : P1925Matrix, j : Int) -> Double {
  if j < 0 || j >= m.cols { 0.0 } else {
    let mut s = 0.0
    for i in 0..<m.rows { s = s + m.data[i][j] }
    s
  }
}

pub fn p1925_matrix_to_string(m : P1925Matrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + p1925_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct P1925Vector {
  comps : Array[Double]
  dim : Int
}

pub fn p1925_make_vector(comps : Array[Double]) -> P1925Vector {
  { comps, dim: comps.length() }
}

pub fn p1925_vector_zero(dim : Int) -> P1925Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn p1925_vector_ones(dim : Int) -> P1925Vector {
  { comps: Array::make(dim, 1.0), dim }
}

pub fn p1925_vector_add(a : P1925Vector, b : P1925Vector) -> P1925Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = p1925_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn p1925_vector_sub(a : P1925Vector, b : P1925Vector) -> P1925Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = p1925_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn p1925_vector_scale(v : P1925Vector, s : Double) -> P1925Vector {
  let mut result = []
  for i in 0..<v.dim { result = p1925_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn p1925_vector_dot(a : P1925Vector, b : P1925Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn p1925_vector_norm(v : P1925Vector) -> Double { p1925_sqrt(p1925_vector_dot(v, v)) }

pub fn p1925_vector_normalize(v : P1925Vector) -> P1925Vector {
  let n = p1925_vector_norm(v)
  if n < 0.0000001 { v } else { p1925_vector_scale(v, 1.0 / n) }
}

pub fn p1925_vector_dist(a : P1925Vector, b : P1925Vector) -> Double {
  p1925_vector_norm(p1925_vector_sub(a, b))
}

pub fn p1925_vector_l1_norm(v : P1925Vector) -> Double {
  let mut s = 0.0
  for i in 0..<v.dim { s = s + p1925_abs(v.comps[i]) }
  s
}

pub fn p1925_vector_linf_norm(v : P1925Vector) -> Double {
  let mut m = 0.0
  for i in 0..<v.dim { let a = p1925_abs(v.comps[i]); if a > m { m = a } }
  m
}

pub fn p1925_vector_to_string(v : P1925Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + p1925_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct P1925Tensor3D {
  data : Array[Array[Array[Double]]]
  d0 : Int
  d1 : Int
  d2 : Int
}

pub fn p1925_make_tensor3(d0 : Int, d1 : Int, d2 : Int, val : Double) -> P1925Tensor3D {
  let data = Array::make(d0, Array::make(d1, Array::make(d2, val)))
  for i in 0..<d0 {
    let layer = Array::make(d1, Array::make(d2, val))
    for j in 0..<d1 { layer[j] = Array::make(d2, val) }
    data[i] = layer
  }
  { data, d0, d1, d2 }
}

pub fn p1925_tensor3_get(t : P1925Tensor3D, i : Int, j : Int, k : Int) -> Double {
  if i < 0 || i >= t.d0 || j < 0 || j >= t.d1 || k < 0 || k >= t.d2 { 0.0 } else { t.data[i][j][k] }
}

pub fn p1925_tensor3_sum(t : P1925Tensor3D) -> Double {
  let mut s = 0.0
  for i in 0..<t.d0 { for j in 0..<t.d1 { for k in 0..<t.d2 { s = s + t.data[i][j][k] } } }
  s
}

pub fn p1925_tensor3_scale(t : P1925Tensor3D, f : Double) -> P1925Tensor3D {
  let result = p1925_make_tensor3(t.d0, t.d1, t.d2, 0.0)
  for i in 0..<t.d0 { for j in 0..<t.d1 { for k in 0..<t.d2 { result.data[i][j][k] = t.data[i][j][k] * f } } }
  result
}

pub(all) struct P1925Graph {
  n : Int
  adj : Array[Array[Double]]
}

pub fn p1925_make_graph(n : Int) -> P1925Graph {
  let adj = Array::make(n, Array::make(n, 0.0))
  for i in 0..<n { adj[i] = Array::make(n, 0.0) }
  { n, adj }
}

pub fn p1925_graph_add_edge(g : P1925Graph, u : Int, v : Int, w : Double) -> P1925Graph {
  if u < 0 || u >= g.n || v < 0 || v >= g.n { g } else {
    g.adj[u][v] = w
    g
  }
}

pub fn p1925_graph_degree(g : P1925Graph, u : Int) -> Int {
  if u < 0 || u >= g.n { 0 } else {
    let mut d = 0
    for v in 0..<g.n { if g.adj[u][v] != 0.0 { d = d + 1 } }
    d
  }
}

pub fn p1925_graph_edge_count(g : P1925Graph) -> Int {
  let mut c = 0
  for i in 0..<g.n { for j in 0..<g.n { if g.adj[i][j] != 0.0 { c = c + 1 } } }
  c
}

pub(all) struct P1925TreeNode {
  val : Double
  left : Int
  right : Int
}

pub fn p1925_make_node(val : Double) -> P1925TreeNode {
  { val, left: -1, right: -1 }
}

pub fn p1925_node_set_left(n : P1925TreeNode, l : Int) -> P1925TreeNode {
  { val: n.val, left: l, right: n.right }
}

pub fn p1925_node_set_right(n : P1925TreeNode, r : Int) -> P1925TreeNode {
  { val: n.val, left: n.left, right: r }
}

pub(all) struct P1925LinkedList {
  data : Array[Double]
  size : Int
}

pub fn p1925_make_linked_list() -> P1925LinkedList {
  { data: [], size: 0 }
}

pub fn p1925_ll_push(lst : P1925LinkedList, v : Double) -> P1925LinkedList {
  let nd = p1925_push(lst.data, v)
  { data: nd, size: lst.size + 1 }
}

pub fn p1925_ll_get(lst : P1925LinkedList, i : Int) -> Double {
  if i < 0 || i >= lst.size { 0.0 } else { lst.data[i] }
}

pub fn p1925_ll_sum(lst : P1925LinkedList) -> Double {
  let mut s = 0.0
  for i in 0..<lst.size { s = s + lst.data[i] }
  s
}

pub fn p1925_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn p1925_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = p1925_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn p1925_std(data : Array[Double]) -> Double { p1925_sqrt(p1925_var(data)) }

pub fn p1925_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = p1925_mean(a); let mb = p1925_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn p1925_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = p1925_std(a); let sb = p1925_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { p1925_cov(a, b) / (sa * sb) }
}

pub fn p1925_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = p1925_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn p1925_quantile(data : Array[Double], q : Double) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = p1925_sort(data)
    let idx = q * (n - 1).to_double()
    let lo = p1925_int(idx)
    let hi = if lo + 1 < n { lo + 1 } else { lo }
    let frac = idx - lo.to_double()
    sorted[lo] + (sorted[hi] - sorted[lo]) * frac
  }
}

pub fn p1925_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn p1925_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn p1925_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  p1925_sqrt(p1925_mse(pred, labels))
}

pub fn p1925_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + p1925_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn p1925_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = p1925_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn p1925_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn p1925_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn p1925_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = p1925_precision(pred, labels, pos); let r = p1925_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn p1925_log_loss(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n {
      let p = if pred[i] < 0.0000001 { 0.0000001 } else if pred[i] > 0.9999999 { 0.9999999 } else { pred[i] }
      sum = sum + -(labels[i] * p1925_log(p) + (1.0 - labels[i]) * p1925_log(1.0 - p))
    }
    sum / n.to_double()
  }
}

pub fn p1925_hinge_loss(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let h = 1.0 - labels[i] * pred[i]; sum = sum + (if h > 0.0 { h } else { 0.0 }) }
    sum / n.to_double()
  }
}

pub fn p1925_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn p1925_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = p1925_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn p1925_argsort(arr : Array[Double]) -> Array[Int] {
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

pub fn p1925_rank(arr : Array[Double]) -> Array[Double] {
  let sorted = p1925_sort(arr)
  let n = arr.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    let mut r = 0
    for j in 0..<n { if sorted[j] < arr[i] { r = r + 1 } }
    result[i] = r.to_double()
  }
  result
}

pub fn p1925_binary_search(arr : Array[Double], target : Double) -> Int {
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

pub fn p1925_linear_search(arr : Array[Double], target : Double) -> Int {
  let mut result = -1
  for i in 0..<arr.length() { if arr[i] == target { result = i } }
  result
}

pub fn p1925_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn p1925_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn p1925_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = p1925_gcd(a, b)
    (a / g) * b
  }
}

pub fn p1925_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn p1925_fibonacci(n : Int) -> Int {
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

pub fn p1925_binomial(n : Int, k : Int) -> Double {
  if k < 0 || k > n { 0.0 } else if k == 0 || k == n { 1.0 } else {
    p1925_factorial(n) / (p1925_factorial(k) * p1925_factorial(n - k))
  }
}

pub fn p1925_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = p1925_min(data); let mx = p1925_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn p1925_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = p1925_mean(data); let sd = p1925_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn p1925_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn p1925_bin(data : Array[Double], n_bins : Int) -> Array[Int] {
  let n = data.length()
  if n == 0 || n_bins <= 0 { [] } else {
    let mn = p1925_min(data); let mx = p1925_max(data)
    let r = mx - mn
    let result = Array::make(n, 0)
    for i in 0..<n { if r < 0.0000001 { result[i] = 0 } else { let b = p1925_int((data[i] - mn) / r * n_bins.to_double()); result[i] = if b >= n_bins { n_bins - 1 } else { b } } }
    result
  }
}

pub fn p1925_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn p1925_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn p1925_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn p1925_cumprod(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 1.0
  for i in 0..<n { total = total * data[i]; result[i] = total }
  result
}

pub fn p1925_diff(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n < 2 { [] } else {
    let result = Array::make(n - 1, 0.0)
    for i in 1..<n { result[i - 1] = data[i] - data[i - 1] }
    result
  }
}

pub fn p1925_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn p1925_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub fn p1925_slice(data : Array[Double], start : Int, end : Int) -> Array[Double] {
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

fn p1925_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn p1925_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn p1925_log(x : Double) -> Double {
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

fn p1925_exp(x : Double) -> Double {
  let mut result = 1.0
  let mut term = 1.0
  for k in 1..<50 {
    term = term * x / k.to_double()
    result = result + term
  }
  result
}

fn p1925_acos(x : Double) -> Double {
  let cx = if x < -1.0 { -1.0 } else if x > 1.0 { 1.0 } else { x }
  1.5707963267948966 - cx - cx * cx * cx / 6.0 - 3.0 * cx * cx * cx * cx * cx / 40.0
}

fn p1925_dbl(x : Double) -> String {
  let i = if x >= 0.0 { p1925_int(x) } else { -p1925_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { p1925_int(f * 1000000.0) } else { p1925_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn p1925_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn p1925_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

