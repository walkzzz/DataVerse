///===
/// extcore/opt_meta_evolution

pub(all) struct OptmetaevolutionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_evolution_make_point(x : Double, y : Double) -> OptmetaevolutionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_evolution_make_point3(x : Double, y : Double, z : Double) -> OptmetaevolutionPoint {
  { x, y, z, label: 0 }
}

pub fn OptmetaevolutionPoint::x(self : OptmetaevolutionPoint) -> Double { self.x }

pub fn OptmetaevolutionPoint::y(self : OptmetaevolutionPoint) -> Double { self.y }

pub fn OptmetaevolutionPoint::z(self : OptmetaevolutionPoint) -> Double { self.z }

pub fn OptmetaevolutionPoint::label(self : OptmetaevolutionPoint) -> Int { self.label }

pub fn OptmetaevolutionPoint::dist(self : OptmetaevolutionPoint, other : OptmetaevolutionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptmetaevolutionPoint::add(self : OptmetaevolutionPoint, other : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptmetaevolutionPoint::sub(self : OptmetaevolutionPoint, other : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptmetaevolutionPoint::scale(self : OptmetaevolutionPoint, s : Double) -> OptmetaevolutionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptmetaevolutionPoint::dot(self : OptmetaevolutionPoint, other : OptmetaevolutionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptmetaevolutionPoint::cross(self : OptmetaevolutionPoint, other : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptmetaevolutionPoint::norm(self : OptmetaevolutionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptmetaevolutionPoint::normalize(self : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetaevolutionPoint::negate(self : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptmetaevolutionPoint::mid(self : OptmetaevolutionPoint, other : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptmetaevolutionPoint::lerp(self : OptmetaevolutionPoint, other : OptmetaevolutionPoint, t : Double) -> OptmetaevolutionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptmetaevolutionPoint::to_string(self : OptmetaevolutionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptmetaevolutionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_evolution_make_series(vals : Array[Double], name : String) -> OptmetaevolutionSeries {
  { vals, name, meta: 0 }
}

pub fn OptmetaevolutionSeries::len(self : OptmetaevolutionSeries) -> Int { self.vals.length() }

pub fn OptmetaevolutionSeries::sum(self : OptmetaevolutionSeries) -> Double { @_common.sum(self.vals) }

pub fn OptmetaevolutionSeries::mean(self : OptmetaevolutionSeries) -> Double { @_common.mean(self.vals) }

pub fn OptmetaevolutionSeries::min(self : OptmetaevolutionSeries) -> Double { @_common.min(self.vals) }

pub fn OptmetaevolutionSeries::max(self : OptmetaevolutionSeries) -> Double { @_common.max(self.vals) }

pub fn OptmetaevolutionSeries::range(self : OptmetaevolutionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptmetaevolutionSeries::variance(self : OptmetaevolutionSeries) -> Double { @_common.variance(self.vals) }

pub fn OptmetaevolutionSeries::std(self : OptmetaevolutionSeries) -> Double { @_common.std(self.vals) }

pub fn OptmetaevolutionSeries::median(self : OptmetaevolutionSeries) -> Double { @_common.median(self.vals) }

pub fn OptmetaevolutionSeries::scale(self : OptmetaevolutionSeries, f : Double) -> OptmetaevolutionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptmetaevolutionSeries::add(self : OptmetaevolutionSeries, other : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptmetaevolutionSeries::sub(self : OptmetaevolutionSeries, other : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptmetaevolutionSeries::normalize(self : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptmetaevolutionSeries::cumsum(self : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptmetaevolutionSeries::to_string(self : OptmetaevolutionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetaevolutionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_evolution_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetaevolutionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_evolution_matrix_identity(n : Int) -> OptmetaevolutionMatrix {
  let m = opt_meta_evolution_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptmetaevolutionMatrix::get(self : OptmetaevolutionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptmetaevolutionMatrix::transpose(self : OptmetaevolutionMatrix) -> OptmetaevolutionMatrix {
  let result = opt_meta_evolution_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptmetaevolutionMatrix::add(self : OptmetaevolutionMatrix, other : OptmetaevolutionMatrix) -> OptmetaevolutionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_meta_evolution_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptmetaevolutionMatrix::scale(self : OptmetaevolutionMatrix, s : Double) -> OptmetaevolutionMatrix {
  let result = opt_meta_evolution_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptmetaevolutionMatrix::multiply(self : OptmetaevolutionMatrix, other : OptmetaevolutionMatrix) -> OptmetaevolutionMatrix {
  if self.cols != other.rows { return opt_meta_evolution_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_meta_evolution_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptmetaevolutionMatrix::trace(self : OptmetaevolutionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptmetaevolutionMatrix::det(self : OptmetaevolutionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptmetaevolutionMatrix::norm(self : OptmetaevolutionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptmetaevolutionMatrix::to_string(self : OptmetaevolutionMatrix) -> String {
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

pub(all) struct OptmetaevolutionVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_evolution_make_vector(comps : Array[Double]) -> OptmetaevolutionVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_evolution_vector_zero(dim : Int) -> OptmetaevolutionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptmetaevolutionVector::add(self : OptmetaevolutionVector, other : OptmetaevolutionVector) -> OptmetaevolutionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetaevolutionVector::sub(self : OptmetaevolutionVector, other : OptmetaevolutionVector) -> OptmetaevolutionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetaevolutionVector::scale(self : OptmetaevolutionVector, s : Double) -> OptmetaevolutionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptmetaevolutionVector::dot(self : OptmetaevolutionVector, other : OptmetaevolutionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptmetaevolutionVector::norm(self : OptmetaevolutionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptmetaevolutionVector::normalize(self : OptmetaevolutionVector) -> OptmetaevolutionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetaevolutionVector::dist(self : OptmetaevolutionVector, other : OptmetaevolutionVector) -> Double {
  self.sub(other).norm()
}

pub fn OptmetaevolutionVector::to_string(self : OptmetaevolutionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_evolution_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_evolution_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_evolution_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_evolution_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_evolution_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_evolution_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_evolution_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_evolution_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_evolution_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_evolution_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_evolution_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_evolution_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_evolution_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_evolution_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_evolution_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_evolution_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_evolution_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_evolution_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_evolution_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_evolution_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_evolution_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_evolution_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_evolution_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_evolution_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_evolution_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_evolution_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_evolution_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_evolution_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_evolution_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetaevolutionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_frame_make(size : Int) -> OptmetaevolutionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_frame_len(s : OptmetaevolutionFrame) -> Int { s.size }

pub fn opt_meta_evolution_frame_get(s : OptmetaevolutionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_frame_set(s : OptmetaevolutionFrame, i : Int, v : Double) -> OptmetaevolutionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_frame_sum(s : OptmetaevolutionFrame) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_frame_mean(s : OptmetaevolutionFrame) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_frame_scale(s : OptmetaevolutionFrame, f : Double) -> OptmetaevolutionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_frame_add(a : OptmetaevolutionFrame, b : OptmetaevolutionFrame) -> OptmetaevolutionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_frame_copy(s : OptmetaevolutionFrame) -> OptmetaevolutionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_frame_fill(s : OptmetaevolutionFrame, v : Double) -> OptmetaevolutionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_frame_min(s : OptmetaevolutionFrame) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_frame_max(s : OptmetaevolutionFrame) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_frame_to_string(s : OptmetaevolutionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_table_make(size : Int) -> OptmetaevolutionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_table_len(s : OptmetaevolutionTable) -> Int { s.size }

pub fn opt_meta_evolution_table_get(s : OptmetaevolutionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_table_set(s : OptmetaevolutionTable, i : Int, v : Double) -> OptmetaevolutionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_table_sum(s : OptmetaevolutionTable) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_table_mean(s : OptmetaevolutionTable) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_table_scale(s : OptmetaevolutionTable, f : Double) -> OptmetaevolutionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_table_add(a : OptmetaevolutionTable, b : OptmetaevolutionTable) -> OptmetaevolutionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_table_copy(s : OptmetaevolutionTable) -> OptmetaevolutionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_table_fill(s : OptmetaevolutionTable, v : Double) -> OptmetaevolutionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_table_min(s : OptmetaevolutionTable) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_table_max(s : OptmetaevolutionTable) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_table_to_string(s : OptmetaevolutionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_graphn_make(size : Int) -> OptmetaevolutionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_graphn_len(s : OptmetaevolutionGraphN) -> Int { s.size }

pub fn opt_meta_evolution_graphn_get(s : OptmetaevolutionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_graphn_set(s : OptmetaevolutionGraphN, i : Int, v : Double) -> OptmetaevolutionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_graphn_sum(s : OptmetaevolutionGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_graphn_mean(s : OptmetaevolutionGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_graphn_scale(s : OptmetaevolutionGraphN, f : Double) -> OptmetaevolutionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_graphn_add(a : OptmetaevolutionGraphN, b : OptmetaevolutionGraphN) -> OptmetaevolutionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_graphn_copy(s : OptmetaevolutionGraphN) -> OptmetaevolutionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_graphn_fill(s : OptmetaevolutionGraphN, v : Double) -> OptmetaevolutionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_graphn_min(s : OptmetaevolutionGraphN) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_graphn_max(s : OptmetaevolutionGraphN) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_graphn_to_string(s : OptmetaevolutionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_node_make(size : Int) -> OptmetaevolutionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_node_len(s : OptmetaevolutionNode) -> Int { s.size }

pub fn opt_meta_evolution_node_get(s : OptmetaevolutionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_node_set(s : OptmetaevolutionNode, i : Int, v : Double) -> OptmetaevolutionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_node_sum(s : OptmetaevolutionNode) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_node_mean(s : OptmetaevolutionNode) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_node_scale(s : OptmetaevolutionNode, f : Double) -> OptmetaevolutionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_node_add(a : OptmetaevolutionNode, b : OptmetaevolutionNode) -> OptmetaevolutionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_node_copy(s : OptmetaevolutionNode) -> OptmetaevolutionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_node_fill(s : OptmetaevolutionNode, v : Double) -> OptmetaevolutionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_node_min(s : OptmetaevolutionNode) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_node_max(s : OptmetaevolutionNode) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_node_to_string(s : OptmetaevolutionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_edge_make(size : Int) -> OptmetaevolutionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_edge_len(s : OptmetaevolutionEdge) -> Int { s.size }

pub fn opt_meta_evolution_edge_get(s : OptmetaevolutionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_edge_set(s : OptmetaevolutionEdge, i : Int, v : Double) -> OptmetaevolutionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_edge_sum(s : OptmetaevolutionEdge) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_edge_mean(s : OptmetaevolutionEdge) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_edge_scale(s : OptmetaevolutionEdge, f : Double) -> OptmetaevolutionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_edge_add(a : OptmetaevolutionEdge, b : OptmetaevolutionEdge) -> OptmetaevolutionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_edge_copy(s : OptmetaevolutionEdge) -> OptmetaevolutionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_edge_fill(s : OptmetaevolutionEdge, v : Double) -> OptmetaevolutionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_edge_min(s : OptmetaevolutionEdge) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_edge_max(s : OptmetaevolutionEdge) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_edge_to_string(s : OptmetaevolutionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_path_make(size : Int) -> OptmetaevolutionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_path_len(s : OptmetaevolutionPath) -> Int { s.size }

pub fn opt_meta_evolution_path_get(s : OptmetaevolutionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_path_set(s : OptmetaevolutionPath, i : Int, v : Double) -> OptmetaevolutionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_path_sum(s : OptmetaevolutionPath) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_path_mean(s : OptmetaevolutionPath) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_path_scale(s : OptmetaevolutionPath, f : Double) -> OptmetaevolutionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_path_add(a : OptmetaevolutionPath, b : OptmetaevolutionPath) -> OptmetaevolutionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_path_copy(s : OptmetaevolutionPath) -> OptmetaevolutionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_path_fill(s : OptmetaevolutionPath, v : Double) -> OptmetaevolutionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_path_min(s : OptmetaevolutionPath) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_path_max(s : OptmetaevolutionPath) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_path_to_string(s : OptmetaevolutionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_cluster_make(size : Int) -> OptmetaevolutionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_cluster_len(s : OptmetaevolutionCluster) -> Int { s.size }

pub fn opt_meta_evolution_cluster_get(s : OptmetaevolutionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_cluster_set(s : OptmetaevolutionCluster, i : Int, v : Double) -> OptmetaevolutionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_cluster_sum(s : OptmetaevolutionCluster) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_cluster_mean(s : OptmetaevolutionCluster) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_cluster_scale(s : OptmetaevolutionCluster, f : Double) -> OptmetaevolutionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_cluster_add(a : OptmetaevolutionCluster, b : OptmetaevolutionCluster) -> OptmetaevolutionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_cluster_copy(s : OptmetaevolutionCluster) -> OptmetaevolutionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_cluster_fill(s : OptmetaevolutionCluster, v : Double) -> OptmetaevolutionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_cluster_min(s : OptmetaevolutionCluster) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_cluster_max(s : OptmetaevolutionCluster) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_cluster_to_string(s : OptmetaevolutionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_model_make(size : Int) -> OptmetaevolutionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_model_len(s : OptmetaevolutionModel) -> Int { s.size }

pub fn opt_meta_evolution_model_get(s : OptmetaevolutionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_model_set(s : OptmetaevolutionModel, i : Int, v : Double) -> OptmetaevolutionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_model_sum(s : OptmetaevolutionModel) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_model_mean(s : OptmetaevolutionModel) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_model_scale(s : OptmetaevolutionModel, f : Double) -> OptmetaevolutionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_model_add(a : OptmetaevolutionModel, b : OptmetaevolutionModel) -> OptmetaevolutionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_model_copy(s : OptmetaevolutionModel) -> OptmetaevolutionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_model_fill(s : OptmetaevolutionModel, v : Double) -> OptmetaevolutionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_model_min(s : OptmetaevolutionModel) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_model_max(s : OptmetaevolutionModel) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_model_to_string(s : OptmetaevolutionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_layer_make(size : Int) -> OptmetaevolutionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_layer_len(s : OptmetaevolutionLayer) -> Int { s.size }

pub fn opt_meta_evolution_layer_get(s : OptmetaevolutionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_layer_set(s : OptmetaevolutionLayer, i : Int, v : Double) -> OptmetaevolutionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_layer_sum(s : OptmetaevolutionLayer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_layer_mean(s : OptmetaevolutionLayer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_layer_scale(s : OptmetaevolutionLayer, f : Double) -> OptmetaevolutionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_layer_add(a : OptmetaevolutionLayer, b : OptmetaevolutionLayer) -> OptmetaevolutionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_layer_copy(s : OptmetaevolutionLayer) -> OptmetaevolutionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_layer_fill(s : OptmetaevolutionLayer, v : Double) -> OptmetaevolutionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_layer_min(s : OptmetaevolutionLayer) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_layer_max(s : OptmetaevolutionLayer) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_layer_to_string(s : OptmetaevolutionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_buffer_make(size : Int) -> OptmetaevolutionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_buffer_len(s : OptmetaevolutionBuffer) -> Int { s.size }

pub fn opt_meta_evolution_buffer_get(s : OptmetaevolutionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_buffer_set(s : OptmetaevolutionBuffer, i : Int, v : Double) -> OptmetaevolutionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_buffer_sum(s : OptmetaevolutionBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_buffer_mean(s : OptmetaevolutionBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_buffer_scale(s : OptmetaevolutionBuffer, f : Double) -> OptmetaevolutionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_buffer_add(a : OptmetaevolutionBuffer, b : OptmetaevolutionBuffer) -> OptmetaevolutionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_buffer_copy(s : OptmetaevolutionBuffer) -> OptmetaevolutionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_buffer_fill(s : OptmetaevolutionBuffer, v : Double) -> OptmetaevolutionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_buffer_min(s : OptmetaevolutionBuffer) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_buffer_max(s : OptmetaevolutionBuffer) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_buffer_to_string(s : OptmetaevolutionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_cursor_make(size : Int) -> OptmetaevolutionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_cursor_len(s : OptmetaevolutionCursor) -> Int { s.size }

pub fn opt_meta_evolution_cursor_get(s : OptmetaevolutionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_cursor_set(s : OptmetaevolutionCursor, i : Int, v : Double) -> OptmetaevolutionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_cursor_sum(s : OptmetaevolutionCursor) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_cursor_mean(s : OptmetaevolutionCursor) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_cursor_scale(s : OptmetaevolutionCursor, f : Double) -> OptmetaevolutionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_cursor_add(a : OptmetaevolutionCursor, b : OptmetaevolutionCursor) -> OptmetaevolutionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_cursor_copy(s : OptmetaevolutionCursor) -> OptmetaevolutionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_cursor_fill(s : OptmetaevolutionCursor, v : Double) -> OptmetaevolutionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_cursor_min(s : OptmetaevolutionCursor) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_cursor_max(s : OptmetaevolutionCursor) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_cursor_to_string(s : OptmetaevolutionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_view_make(size : Int) -> OptmetaevolutionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_view_len(s : OptmetaevolutionView) -> Int { s.size }

pub fn opt_meta_evolution_view_get(s : OptmetaevolutionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_view_set(s : OptmetaevolutionView, i : Int, v : Double) -> OptmetaevolutionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_view_sum(s : OptmetaevolutionView) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_view_mean(s : OptmetaevolutionView) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_view_scale(s : OptmetaevolutionView, f : Double) -> OptmetaevolutionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_view_add(a : OptmetaevolutionView, b : OptmetaevolutionView) -> OptmetaevolutionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_view_copy(s : OptmetaevolutionView) -> OptmetaevolutionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_view_fill(s : OptmetaevolutionView, v : Double) -> OptmetaevolutionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_view_min(s : OptmetaevolutionView) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_view_max(s : OptmetaevolutionView) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_view_to_string(s : OptmetaevolutionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_range_make(size : Int) -> OptmetaevolutionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_range_len(s : OptmetaevolutionRange) -> Int { s.size }

pub fn opt_meta_evolution_range_get(s : OptmetaevolutionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_range_set(s : OptmetaevolutionRange, i : Int, v : Double) -> OptmetaevolutionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_range_sum(s : OptmetaevolutionRange) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_range_mean(s : OptmetaevolutionRange) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_range_scale(s : OptmetaevolutionRange, f : Double) -> OptmetaevolutionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_range_add(a : OptmetaevolutionRange, b : OptmetaevolutionRange) -> OptmetaevolutionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_range_copy(s : OptmetaevolutionRange) -> OptmetaevolutionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_range_fill(s : OptmetaevolutionRange, v : Double) -> OptmetaevolutionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_range_min(s : OptmetaevolutionRange) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_range_max(s : OptmetaevolutionRange) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_range_to_string(s : OptmetaevolutionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_slice_make(size : Int) -> OptmetaevolutionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_slice_len(s : OptmetaevolutionSlice) -> Int { s.size }

pub fn opt_meta_evolution_slice_get(s : OptmetaevolutionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_slice_set(s : OptmetaevolutionSlice, i : Int, v : Double) -> OptmetaevolutionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_slice_sum(s : OptmetaevolutionSlice) -> Double { @_common.sum(s.data) }

pub fn opt_meta_evolution_slice_mean(s : OptmetaevolutionSlice) -> Double { @_common.mean(s.data) }

pub fn opt_meta_evolution_slice_scale(s : OptmetaevolutionSlice, f : Double) -> OptmetaevolutionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_slice_add(a : OptmetaevolutionSlice, b : OptmetaevolutionSlice) -> OptmetaevolutionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_evolution_slice_copy(s : OptmetaevolutionSlice) -> OptmetaevolutionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_slice_fill(s : OptmetaevolutionSlice, v : Double) -> OptmetaevolutionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_evolution_slice_min(s : OptmetaevolutionSlice) -> Double { @_common.min(s.data) }

pub fn opt_meta_evolution_slice_max(s : OptmetaevolutionSlice) -> Double { @_common.max(s.data) }

pub fn opt_meta_evolution_slice_to_string(s : OptmetaevolutionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

