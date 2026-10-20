///===
/// extcore/graph_tree_isomorphism

pub(all) struct GraphtreeisomorphismPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_isomorphism_make_point(x : Double, y : Double) -> GraphtreeisomorphismPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_isomorphism_make_point3(x : Double, y : Double, z : Double) -> GraphtreeisomorphismPoint {
  { x, y, z, label: 0 }
}

pub fn GraphtreeisomorphismPoint::x(self : GraphtreeisomorphismPoint) -> Double { self.x }

pub fn GraphtreeisomorphismPoint::y(self : GraphtreeisomorphismPoint) -> Double { self.y }

pub fn GraphtreeisomorphismPoint::z(self : GraphtreeisomorphismPoint) -> Double { self.z }

pub fn GraphtreeisomorphismPoint::label(self : GraphtreeisomorphismPoint) -> Int { self.label }

pub fn GraphtreeisomorphismPoint::dist(self : GraphtreeisomorphismPoint, other : GraphtreeisomorphismPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphtreeisomorphismPoint::add(self : GraphtreeisomorphismPoint, other : GraphtreeisomorphismPoint) -> GraphtreeisomorphismPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphtreeisomorphismPoint::sub(self : GraphtreeisomorphismPoint, other : GraphtreeisomorphismPoint) -> GraphtreeisomorphismPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphtreeisomorphismPoint::scale(self : GraphtreeisomorphismPoint, s : Double) -> GraphtreeisomorphismPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphtreeisomorphismPoint::dot(self : GraphtreeisomorphismPoint, other : GraphtreeisomorphismPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphtreeisomorphismPoint::cross(self : GraphtreeisomorphismPoint, other : GraphtreeisomorphismPoint) -> GraphtreeisomorphismPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphtreeisomorphismPoint::norm(self : GraphtreeisomorphismPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphtreeisomorphismPoint::normalize(self : GraphtreeisomorphismPoint) -> GraphtreeisomorphismPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreeisomorphismPoint::negate(self : GraphtreeisomorphismPoint) -> GraphtreeisomorphismPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphtreeisomorphismPoint::mid(self : GraphtreeisomorphismPoint, other : GraphtreeisomorphismPoint) -> GraphtreeisomorphismPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphtreeisomorphismPoint::lerp(self : GraphtreeisomorphismPoint, other : GraphtreeisomorphismPoint, t : Double) -> GraphtreeisomorphismPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphtreeisomorphismPoint::to_string(self : GraphtreeisomorphismPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_isomorphism_make_series(vals : Array[Double], name : String) -> GraphtreeisomorphismSeries {
  { vals, name, meta: 0 }
}

pub fn GraphtreeisomorphismSeries::len(self : GraphtreeisomorphismSeries) -> Int { self.vals.length() }

pub fn GraphtreeisomorphismSeries::sum(self : GraphtreeisomorphismSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphtreeisomorphismSeries::mean(self : GraphtreeisomorphismSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphtreeisomorphismSeries::min(self : GraphtreeisomorphismSeries) -> Double { @_common.min(self.vals) }

pub fn GraphtreeisomorphismSeries::max(self : GraphtreeisomorphismSeries) -> Double { @_common.max(self.vals) }

pub fn GraphtreeisomorphismSeries::range(self : GraphtreeisomorphismSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphtreeisomorphismSeries::variance(self : GraphtreeisomorphismSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphtreeisomorphismSeries::std(self : GraphtreeisomorphismSeries) -> Double { @_common.std(self.vals) }

pub fn GraphtreeisomorphismSeries::median(self : GraphtreeisomorphismSeries) -> Double { @_common.median(self.vals) }

pub fn GraphtreeisomorphismSeries::scale(self : GraphtreeisomorphismSeries, f : Double) -> GraphtreeisomorphismSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphtreeisomorphismSeries::add(self : GraphtreeisomorphismSeries, other : GraphtreeisomorphismSeries) -> GraphtreeisomorphismSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphtreeisomorphismSeries::sub(self : GraphtreeisomorphismSeries, other : GraphtreeisomorphismSeries) -> GraphtreeisomorphismSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphtreeisomorphismSeries::normalize(self : GraphtreeisomorphismSeries) -> GraphtreeisomorphismSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphtreeisomorphismSeries::cumsum(self : GraphtreeisomorphismSeries) -> GraphtreeisomorphismSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphtreeisomorphismSeries::to_string(self : GraphtreeisomorphismSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreeisomorphismMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_isomorphism_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreeisomorphismMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_isomorphism_matrix_identity(n : Int) -> GraphtreeisomorphismMatrix {
  let m = graph_tree_isomorphism_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphtreeisomorphismMatrix::get(self : GraphtreeisomorphismMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphtreeisomorphismMatrix::transpose(self : GraphtreeisomorphismMatrix) -> GraphtreeisomorphismMatrix {
  let result = graph_tree_isomorphism_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphtreeisomorphismMatrix::add(self : GraphtreeisomorphismMatrix, other : GraphtreeisomorphismMatrix) -> GraphtreeisomorphismMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_tree_isomorphism_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphtreeisomorphismMatrix::scale(self : GraphtreeisomorphismMatrix, s : Double) -> GraphtreeisomorphismMatrix {
  let result = graph_tree_isomorphism_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphtreeisomorphismMatrix::multiply(self : GraphtreeisomorphismMatrix, other : GraphtreeisomorphismMatrix) -> GraphtreeisomorphismMatrix {
  if self.cols != other.rows { return graph_tree_isomorphism_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_tree_isomorphism_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphtreeisomorphismMatrix::trace(self : GraphtreeisomorphismMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphtreeisomorphismMatrix::det(self : GraphtreeisomorphismMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphtreeisomorphismMatrix::norm(self : GraphtreeisomorphismMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphtreeisomorphismMatrix::to_string(self : GraphtreeisomorphismMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GraphtreeisomorphismVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_isomorphism_make_vector(comps : Array[Double]) -> GraphtreeisomorphismVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_isomorphism_vector_zero(dim : Int) -> GraphtreeisomorphismVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphtreeisomorphismVector::add(self : GraphtreeisomorphismVector, other : GraphtreeisomorphismVector) -> GraphtreeisomorphismVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreeisomorphismVector::sub(self : GraphtreeisomorphismVector, other : GraphtreeisomorphismVector) -> GraphtreeisomorphismVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreeisomorphismVector::scale(self : GraphtreeisomorphismVector, s : Double) -> GraphtreeisomorphismVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphtreeisomorphismVector::dot(self : GraphtreeisomorphismVector, other : GraphtreeisomorphismVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphtreeisomorphismVector::norm(self : GraphtreeisomorphismVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphtreeisomorphismVector::normalize(self : GraphtreeisomorphismVector) -> GraphtreeisomorphismVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreeisomorphismVector::dist(self : GraphtreeisomorphismVector, other : GraphtreeisomorphismVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphtreeisomorphismVector::to_string(self : GraphtreeisomorphismVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_isomorphism_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_tree_isomorphism_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_tree_isomorphism_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_tree_isomorphism_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_tree_isomorphism_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_tree_isomorphism_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_tree_isomorphism_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_tree_isomorphism_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_tree_isomorphism_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_tree_isomorphism_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_tree_isomorphism_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_tree_isomorphism_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_tree_isomorphism_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_tree_isomorphism_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_tree_isomorphism_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_tree_isomorphism_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_tree_isomorphism_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_tree_isomorphism_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_tree_isomorphism_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_tree_isomorphism_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_tree_isomorphism_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_tree_isomorphism_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_tree_isomorphism_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_tree_isomorphism_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_tree_isomorphism_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_tree_isomorphism_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_tree_isomorphism_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_tree_isomorphism_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_tree_isomorphism_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphtreeisomorphismFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_frame_make(size : Int) -> GraphtreeisomorphismFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_frame_len(s : GraphtreeisomorphismFrame) -> Int { s.size }

pub fn graph_tree_isomorphism_frame_get(s : GraphtreeisomorphismFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_frame_set(s : GraphtreeisomorphismFrame, i : Int, v : Double) -> GraphtreeisomorphismFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_frame_sum(s : GraphtreeisomorphismFrame) -> Double { @_common.sum(s.data) }

pub fn graph_tree_isomorphism_frame_mean(s : GraphtreeisomorphismFrame) -> Double { @_common.mean(s.data) }

pub fn graph_tree_isomorphism_frame_scale(s : GraphtreeisomorphismFrame, f : Double) -> GraphtreeisomorphismFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_frame_add(a : GraphtreeisomorphismFrame, b : GraphtreeisomorphismFrame) -> GraphtreeisomorphismFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_isomorphism_frame_copy(s : GraphtreeisomorphismFrame) -> GraphtreeisomorphismFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_frame_fill(s : GraphtreeisomorphismFrame, v : Double) -> GraphtreeisomorphismFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_frame_min(s : GraphtreeisomorphismFrame) -> Double { @_common.min(s.data) }

pub fn graph_tree_isomorphism_frame_max(s : GraphtreeisomorphismFrame) -> Double { @_common.max(s.data) }

pub fn graph_tree_isomorphism_frame_to_string(s : GraphtreeisomorphismFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_table_make(size : Int) -> GraphtreeisomorphismTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_table_len(s : GraphtreeisomorphismTable) -> Int { s.size }

pub fn graph_tree_isomorphism_table_get(s : GraphtreeisomorphismTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_table_set(s : GraphtreeisomorphismTable, i : Int, v : Double) -> GraphtreeisomorphismTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_table_sum(s : GraphtreeisomorphismTable) -> Double { @_common.sum(s.data) }

pub fn graph_tree_isomorphism_table_mean(s : GraphtreeisomorphismTable) -> Double { @_common.mean(s.data) }

pub fn graph_tree_isomorphism_table_scale(s : GraphtreeisomorphismTable, f : Double) -> GraphtreeisomorphismTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_table_add(a : GraphtreeisomorphismTable, b : GraphtreeisomorphismTable) -> GraphtreeisomorphismTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_isomorphism_table_copy(s : GraphtreeisomorphismTable) -> GraphtreeisomorphismTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_table_fill(s : GraphtreeisomorphismTable, v : Double) -> GraphtreeisomorphismTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_table_min(s : GraphtreeisomorphismTable) -> Double { @_common.min(s.data) }

pub fn graph_tree_isomorphism_table_max(s : GraphtreeisomorphismTable) -> Double { @_common.max(s.data) }

pub fn graph_tree_isomorphism_table_to_string(s : GraphtreeisomorphismTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_graphn_make(size : Int) -> GraphtreeisomorphismGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_graphn_len(s : GraphtreeisomorphismGraphN) -> Int { s.size }

pub fn graph_tree_isomorphism_graphn_get(s : GraphtreeisomorphismGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_graphn_set(s : GraphtreeisomorphismGraphN, i : Int, v : Double) -> GraphtreeisomorphismGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_graphn_sum(s : GraphtreeisomorphismGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_tree_isomorphism_graphn_mean(s : GraphtreeisomorphismGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_tree_isomorphism_graphn_scale(s : GraphtreeisomorphismGraphN, f : Double) -> GraphtreeisomorphismGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_graphn_add(a : GraphtreeisomorphismGraphN, b : GraphtreeisomorphismGraphN) -> GraphtreeisomorphismGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_isomorphism_graphn_copy(s : GraphtreeisomorphismGraphN) -> GraphtreeisomorphismGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_graphn_fill(s : GraphtreeisomorphismGraphN, v : Double) -> GraphtreeisomorphismGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_graphn_min(s : GraphtreeisomorphismGraphN) -> Double { @_common.min(s.data) }

pub fn graph_tree_isomorphism_graphn_max(s : GraphtreeisomorphismGraphN) -> Double { @_common.max(s.data) }

pub fn graph_tree_isomorphism_graphn_to_string(s : GraphtreeisomorphismGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_node_make(size : Int) -> GraphtreeisomorphismNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_node_len(s : GraphtreeisomorphismNode) -> Int { s.size }

pub fn graph_tree_isomorphism_node_get(s : GraphtreeisomorphismNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_node_set(s : GraphtreeisomorphismNode, i : Int, v : Double) -> GraphtreeisomorphismNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_node_sum(s : GraphtreeisomorphismNode) -> Double { @_common.sum(s.data) }

pub fn graph_tree_isomorphism_node_mean(s : GraphtreeisomorphismNode) -> Double { @_common.mean(s.data) }

pub fn graph_tree_isomorphism_node_scale(s : GraphtreeisomorphismNode, f : Double) -> GraphtreeisomorphismNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_node_add(a : GraphtreeisomorphismNode, b : GraphtreeisomorphismNode) -> GraphtreeisomorphismNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_isomorphism_node_copy(s : GraphtreeisomorphismNode) -> GraphtreeisomorphismNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_node_fill(s : GraphtreeisomorphismNode, v : Double) -> GraphtreeisomorphismNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_node_min(s : GraphtreeisomorphismNode) -> Double { @_common.min(s.data) }

pub fn graph_tree_isomorphism_node_max(s : GraphtreeisomorphismNode) -> Double { @_common.max(s.data) }

pub fn graph_tree_isomorphism_node_to_string(s : GraphtreeisomorphismNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_edge_make(size : Int) -> GraphtreeisomorphismEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_edge_len(s : GraphtreeisomorphismEdge) -> Int { s.size }

pub fn graph_tree_isomorphism_edge_get(s : GraphtreeisomorphismEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_edge_set(s : GraphtreeisomorphismEdge, i : Int, v : Double) -> GraphtreeisomorphismEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_edge_sum(s : GraphtreeisomorphismEdge) -> Double { @_common.sum(s.data) }

pub fn graph_tree_isomorphism_edge_mean(s : GraphtreeisomorphismEdge) -> Double { @_common.mean(s.data) }

pub fn graph_tree_isomorphism_edge_scale(s : GraphtreeisomorphismEdge, f : Double) -> GraphtreeisomorphismEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_edge_add(a : GraphtreeisomorphismEdge, b : GraphtreeisomorphismEdge) -> GraphtreeisomorphismEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_isomorphism_edge_copy(s : GraphtreeisomorphismEdge) -> GraphtreeisomorphismEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_edge_fill(s : GraphtreeisomorphismEdge, v : Double) -> GraphtreeisomorphismEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_edge_min(s : GraphtreeisomorphismEdge) -> Double { @_common.min(s.data) }

pub fn graph_tree_isomorphism_edge_max(s : GraphtreeisomorphismEdge) -> Double { @_common.max(s.data) }

pub fn graph_tree_isomorphism_edge_to_string(s : GraphtreeisomorphismEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_path_make(size : Int) -> GraphtreeisomorphismPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_path_len(s : GraphtreeisomorphismPath) -> Int { s.size }

pub fn graph_tree_isomorphism_path_get(s : GraphtreeisomorphismPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_path_set(s : GraphtreeisomorphismPath, i : Int, v : Double) -> GraphtreeisomorphismPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_path_sum(s : GraphtreeisomorphismPath) -> Double { @_common.sum(s.data) }

pub fn graph_tree_isomorphism_path_mean(s : GraphtreeisomorphismPath) -> Double { @_common.mean(s.data) }

pub fn graph_tree_isomorphism_path_scale(s : GraphtreeisomorphismPath, f : Double) -> GraphtreeisomorphismPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_path_add(a : GraphtreeisomorphismPath, b : GraphtreeisomorphismPath) -> GraphtreeisomorphismPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_isomorphism_path_copy(s : GraphtreeisomorphismPath) -> GraphtreeisomorphismPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_path_fill(s : GraphtreeisomorphismPath, v : Double) -> GraphtreeisomorphismPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_path_min(s : GraphtreeisomorphismPath) -> Double { @_common.min(s.data) }

pub fn graph_tree_isomorphism_path_max(s : GraphtreeisomorphismPath) -> Double { @_common.max(s.data) }

pub fn graph_tree_isomorphism_path_to_string(s : GraphtreeisomorphismPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_cluster_make(size : Int) -> GraphtreeisomorphismCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_cluster_len(s : GraphtreeisomorphismCluster) -> Int { s.size }

pub fn graph_tree_isomorphism_cluster_get(s : GraphtreeisomorphismCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_cluster_set(s : GraphtreeisomorphismCluster, i : Int, v : Double) -> GraphtreeisomorphismCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_cluster_sum(s : GraphtreeisomorphismCluster) -> Double { @_common.sum(s.data) }

pub fn graph_tree_isomorphism_cluster_mean(s : GraphtreeisomorphismCluster) -> Double { @_common.mean(s.data) }

pub fn graph_tree_isomorphism_cluster_scale(s : GraphtreeisomorphismCluster, f : Double) -> GraphtreeisomorphismCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_cluster_add(a : GraphtreeisomorphismCluster, b : GraphtreeisomorphismCluster) -> GraphtreeisomorphismCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_isomorphism_cluster_copy(s : GraphtreeisomorphismCluster) -> GraphtreeisomorphismCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_cluster_fill(s : GraphtreeisomorphismCluster, v : Double) -> GraphtreeisomorphismCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_cluster_min(s : GraphtreeisomorphismCluster) -> Double { @_common.min(s.data) }

pub fn graph_tree_isomorphism_cluster_max(s : GraphtreeisomorphismCluster) -> Double { @_common.max(s.data) }

pub fn graph_tree_isomorphism_cluster_to_string(s : GraphtreeisomorphismCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_model_make(size : Int) -> GraphtreeisomorphismModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_model_len(s : GraphtreeisomorphismModel) -> Int { s.size }

pub fn graph_tree_isomorphism_model_get(s : GraphtreeisomorphismModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_model_set(s : GraphtreeisomorphismModel, i : Int, v : Double) -> GraphtreeisomorphismModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_model_sum(s : GraphtreeisomorphismModel) -> Double { @_common.sum(s.data) }

pub fn graph_tree_isomorphism_model_mean(s : GraphtreeisomorphismModel) -> Double { @_common.mean(s.data) }

pub fn graph_tree_isomorphism_model_scale(s : GraphtreeisomorphismModel, f : Double) -> GraphtreeisomorphismModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_model_add(a : GraphtreeisomorphismModel, b : GraphtreeisomorphismModel) -> GraphtreeisomorphismModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_isomorphism_model_copy(s : GraphtreeisomorphismModel) -> GraphtreeisomorphismModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_model_fill(s : GraphtreeisomorphismModel, v : Double) -> GraphtreeisomorphismModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_model_min(s : GraphtreeisomorphismModel) -> Double { @_common.min(s.data) }

pub fn graph_tree_isomorphism_model_max(s : GraphtreeisomorphismModel) -> Double { @_common.max(s.data) }

pub fn graph_tree_isomorphism_model_to_string(s : GraphtreeisomorphismModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_layer_make(size : Int) -> GraphtreeisomorphismLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_layer_len(s : GraphtreeisomorphismLayer) -> Int { s.size }

pub fn graph_tree_isomorphism_layer_get(s : GraphtreeisomorphismLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_layer_set(s : GraphtreeisomorphismLayer, i : Int, v : Double) -> GraphtreeisomorphismLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_layer_sum(s : GraphtreeisomorphismLayer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_isomorphism_layer_mean(s : GraphtreeisomorphismLayer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_isomorphism_layer_scale(s : GraphtreeisomorphismLayer, f : Double) -> GraphtreeisomorphismLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_layer_add(a : GraphtreeisomorphismLayer, b : GraphtreeisomorphismLayer) -> GraphtreeisomorphismLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_isomorphism_layer_copy(s : GraphtreeisomorphismLayer) -> GraphtreeisomorphismLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_layer_fill(s : GraphtreeisomorphismLayer, v : Double) -> GraphtreeisomorphismLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_layer_min(s : GraphtreeisomorphismLayer) -> Double { @_common.min(s.data) }

pub fn graph_tree_isomorphism_layer_max(s : GraphtreeisomorphismLayer) -> Double { @_common.max(s.data) }

pub fn graph_tree_isomorphism_layer_to_string(s : GraphtreeisomorphismLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_buffer_make(size : Int) -> GraphtreeisomorphismBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_buffer_len(s : GraphtreeisomorphismBuffer) -> Int { s.size }

pub fn graph_tree_isomorphism_buffer_get(s : GraphtreeisomorphismBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_buffer_set(s : GraphtreeisomorphismBuffer, i : Int, v : Double) -> GraphtreeisomorphismBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_buffer_sum(s : GraphtreeisomorphismBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_isomorphism_buffer_mean(s : GraphtreeisomorphismBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_isomorphism_buffer_scale(s : GraphtreeisomorphismBuffer, f : Double) -> GraphtreeisomorphismBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_buffer_add(a : GraphtreeisomorphismBuffer, b : GraphtreeisomorphismBuffer) -> GraphtreeisomorphismBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_isomorphism_buffer_copy(s : GraphtreeisomorphismBuffer) -> GraphtreeisomorphismBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_buffer_fill(s : GraphtreeisomorphismBuffer, v : Double) -> GraphtreeisomorphismBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_buffer_min(s : GraphtreeisomorphismBuffer) -> Double { @_common.min(s.data) }

pub fn graph_tree_isomorphism_buffer_max(s : GraphtreeisomorphismBuffer) -> Double { @_common.max(s.data) }

pub fn graph_tree_isomorphism_buffer_to_string(s : GraphtreeisomorphismBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_cursor_make(size : Int) -> GraphtreeisomorphismCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_cursor_len(s : GraphtreeisomorphismCursor) -> Int { s.size }

pub fn graph_tree_isomorphism_cursor_get(s : GraphtreeisomorphismCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_cursor_set(s : GraphtreeisomorphismCursor, i : Int, v : Double) -> GraphtreeisomorphismCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_cursor_sum(s : GraphtreeisomorphismCursor) -> Double { @_common.sum(s.data) }

pub fn graph_tree_isomorphism_cursor_mean(s : GraphtreeisomorphismCursor) -> Double { @_common.mean(s.data) }

pub fn graph_tree_isomorphism_cursor_scale(s : GraphtreeisomorphismCursor, f : Double) -> GraphtreeisomorphismCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_cursor_add(a : GraphtreeisomorphismCursor, b : GraphtreeisomorphismCursor) -> GraphtreeisomorphismCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_isomorphism_cursor_copy(s : GraphtreeisomorphismCursor) -> GraphtreeisomorphismCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_cursor_fill(s : GraphtreeisomorphismCursor, v : Double) -> GraphtreeisomorphismCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_cursor_min(s : GraphtreeisomorphismCursor) -> Double { @_common.min(s.data) }

pub fn graph_tree_isomorphism_cursor_max(s : GraphtreeisomorphismCursor) -> Double { @_common.max(s.data) }

pub fn graph_tree_isomorphism_cursor_to_string(s : GraphtreeisomorphismCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_view_make(size : Int) -> GraphtreeisomorphismView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_view_len(s : GraphtreeisomorphismView) -> Int { s.size }

pub fn graph_tree_isomorphism_view_get(s : GraphtreeisomorphismView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_view_set(s : GraphtreeisomorphismView, i : Int, v : Double) -> GraphtreeisomorphismView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_view_sum(s : GraphtreeisomorphismView) -> Double { @_common.sum(s.data) }

pub fn graph_tree_isomorphism_view_mean(s : GraphtreeisomorphismView) -> Double { @_common.mean(s.data) }

pub fn graph_tree_isomorphism_view_scale(s : GraphtreeisomorphismView, f : Double) -> GraphtreeisomorphismView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_view_add(a : GraphtreeisomorphismView, b : GraphtreeisomorphismView) -> GraphtreeisomorphismView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_isomorphism_view_copy(s : GraphtreeisomorphismView) -> GraphtreeisomorphismView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_view_fill(s : GraphtreeisomorphismView, v : Double) -> GraphtreeisomorphismView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_view_min(s : GraphtreeisomorphismView) -> Double { @_common.min(s.data) }

pub fn graph_tree_isomorphism_view_max(s : GraphtreeisomorphismView) -> Double { @_common.max(s.data) }

pub fn graph_tree_isomorphism_view_to_string(s : GraphtreeisomorphismView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_range_make(size : Int) -> GraphtreeisomorphismRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_range_len(s : GraphtreeisomorphismRange) -> Int { s.size }

pub fn graph_tree_isomorphism_range_get(s : GraphtreeisomorphismRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_range_set(s : GraphtreeisomorphismRange, i : Int, v : Double) -> GraphtreeisomorphismRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_range_sum(s : GraphtreeisomorphismRange) -> Double { @_common.sum(s.data) }

pub fn graph_tree_isomorphism_range_mean(s : GraphtreeisomorphismRange) -> Double { @_common.mean(s.data) }

pub fn graph_tree_isomorphism_range_scale(s : GraphtreeisomorphismRange, f : Double) -> GraphtreeisomorphismRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_range_add(a : GraphtreeisomorphismRange, b : GraphtreeisomorphismRange) -> GraphtreeisomorphismRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_isomorphism_range_copy(s : GraphtreeisomorphismRange) -> GraphtreeisomorphismRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_range_fill(s : GraphtreeisomorphismRange, v : Double) -> GraphtreeisomorphismRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_range_min(s : GraphtreeisomorphismRange) -> Double { @_common.min(s.data) }

pub fn graph_tree_isomorphism_range_max(s : GraphtreeisomorphismRange) -> Double { @_common.max(s.data) }

pub fn graph_tree_isomorphism_range_to_string(s : GraphtreeisomorphismRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_slice_make(size : Int) -> GraphtreeisomorphismSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_slice_len(s : GraphtreeisomorphismSlice) -> Int { s.size }

pub fn graph_tree_isomorphism_slice_get(s : GraphtreeisomorphismSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_slice_set(s : GraphtreeisomorphismSlice, i : Int, v : Double) -> GraphtreeisomorphismSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_slice_sum(s : GraphtreeisomorphismSlice) -> Double { @_common.sum(s.data) }

pub fn graph_tree_isomorphism_slice_mean(s : GraphtreeisomorphismSlice) -> Double { @_common.mean(s.data) }

pub fn graph_tree_isomorphism_slice_scale(s : GraphtreeisomorphismSlice, f : Double) -> GraphtreeisomorphismSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_slice_add(a : GraphtreeisomorphismSlice, b : GraphtreeisomorphismSlice) -> GraphtreeisomorphismSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_isomorphism_slice_copy(s : GraphtreeisomorphismSlice) -> GraphtreeisomorphismSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_slice_fill(s : GraphtreeisomorphismSlice, v : Double) -> GraphtreeisomorphismSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_isomorphism_slice_min(s : GraphtreeisomorphismSlice) -> Double { @_common.min(s.data) }

pub fn graph_tree_isomorphism_slice_max(s : GraphtreeisomorphismSlice) -> Double { @_common.max(s.data) }

pub fn graph_tree_isomorphism_slice_to_string(s : GraphtreeisomorphismSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

