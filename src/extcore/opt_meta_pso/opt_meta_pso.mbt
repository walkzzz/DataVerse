///===
/// extcore/opt_meta_pso

pub(all) struct OptmetapsoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_pso_make_point(x : Double, y : Double) -> OptmetapsoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_pso_make_point3(x : Double, y : Double, z : Double) -> OptmetapsoPoint {
  { x, y, z, label: 0 }
}

pub fn OptmetapsoPoint::x(self : OptmetapsoPoint) -> Double { self.x }

pub fn OptmetapsoPoint::y(self : OptmetapsoPoint) -> Double { self.y }

pub fn OptmetapsoPoint::z(self : OptmetapsoPoint) -> Double { self.z }

pub fn OptmetapsoPoint::label(self : OptmetapsoPoint) -> Int { self.label }

pub fn OptmetapsoPoint::dist(self : OptmetapsoPoint, other : OptmetapsoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptmetapsoPoint::add(self : OptmetapsoPoint, other : OptmetapsoPoint) -> OptmetapsoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptmetapsoPoint::sub(self : OptmetapsoPoint, other : OptmetapsoPoint) -> OptmetapsoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptmetapsoPoint::scale(self : OptmetapsoPoint, s : Double) -> OptmetapsoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptmetapsoPoint::dot(self : OptmetapsoPoint, other : OptmetapsoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptmetapsoPoint::cross(self : OptmetapsoPoint, other : OptmetapsoPoint) -> OptmetapsoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptmetapsoPoint::norm(self : OptmetapsoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptmetapsoPoint::normalize(self : OptmetapsoPoint) -> OptmetapsoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetapsoPoint::negate(self : OptmetapsoPoint) -> OptmetapsoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptmetapsoPoint::mid(self : OptmetapsoPoint, other : OptmetapsoPoint) -> OptmetapsoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptmetapsoPoint::lerp(self : OptmetapsoPoint, other : OptmetapsoPoint, t : Double) -> OptmetapsoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptmetapsoPoint::to_string(self : OptmetapsoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptmetapsoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_pso_make_series(vals : Array[Double], name : String) -> OptmetapsoSeries {
  { vals, name, meta: 0 }
}

pub fn OptmetapsoSeries::len(self : OptmetapsoSeries) -> Int { self.vals.length() }

pub fn OptmetapsoSeries::sum(self : OptmetapsoSeries) -> Double { @_common.sum(self.vals) }

pub fn OptmetapsoSeries::mean(self : OptmetapsoSeries) -> Double { @_common.mean(self.vals) }

pub fn OptmetapsoSeries::min(self : OptmetapsoSeries) -> Double { @_common.min(self.vals) }

pub fn OptmetapsoSeries::max(self : OptmetapsoSeries) -> Double { @_common.max(self.vals) }

pub fn OptmetapsoSeries::range(self : OptmetapsoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptmetapsoSeries::variance(self : OptmetapsoSeries) -> Double { @_common.variance(self.vals) }

pub fn OptmetapsoSeries::std(self : OptmetapsoSeries) -> Double { @_common.std(self.vals) }

pub fn OptmetapsoSeries::median(self : OptmetapsoSeries) -> Double { @_common.median(self.vals) }

pub fn OptmetapsoSeries::scale(self : OptmetapsoSeries, f : Double) -> OptmetapsoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptmetapsoSeries::add(self : OptmetapsoSeries, other : OptmetapsoSeries) -> OptmetapsoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptmetapsoSeries::sub(self : OptmetapsoSeries, other : OptmetapsoSeries) -> OptmetapsoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptmetapsoSeries::normalize(self : OptmetapsoSeries) -> OptmetapsoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptmetapsoSeries::cumsum(self : OptmetapsoSeries) -> OptmetapsoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptmetapsoSeries::to_string(self : OptmetapsoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetapsoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_pso_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetapsoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_pso_matrix_identity(n : Int) -> OptmetapsoMatrix {
  let m = opt_meta_pso_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptmetapsoMatrix::get(self : OptmetapsoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptmetapsoMatrix::transpose(self : OptmetapsoMatrix) -> OptmetapsoMatrix {
  let result = opt_meta_pso_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptmetapsoMatrix::add(self : OptmetapsoMatrix, other : OptmetapsoMatrix) -> OptmetapsoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_meta_pso_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptmetapsoMatrix::scale(self : OptmetapsoMatrix, s : Double) -> OptmetapsoMatrix {
  let result = opt_meta_pso_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptmetapsoMatrix::multiply(self : OptmetapsoMatrix, other : OptmetapsoMatrix) -> OptmetapsoMatrix {
  if self.cols != other.rows { return opt_meta_pso_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_meta_pso_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptmetapsoMatrix::trace(self : OptmetapsoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptmetapsoMatrix::det(self : OptmetapsoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptmetapsoMatrix::norm(self : OptmetapsoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptmetapsoMatrix::to_string(self : OptmetapsoMatrix) -> String {
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

pub(all) struct OptmetapsoVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_pso_make_vector(comps : Array[Double]) -> OptmetapsoVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_pso_vector_zero(dim : Int) -> OptmetapsoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptmetapsoVector::add(self : OptmetapsoVector, other : OptmetapsoVector) -> OptmetapsoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetapsoVector::sub(self : OptmetapsoVector, other : OptmetapsoVector) -> OptmetapsoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetapsoVector::scale(self : OptmetapsoVector, s : Double) -> OptmetapsoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptmetapsoVector::dot(self : OptmetapsoVector, other : OptmetapsoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptmetapsoVector::norm(self : OptmetapsoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptmetapsoVector::normalize(self : OptmetapsoVector) -> OptmetapsoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetapsoVector::dist(self : OptmetapsoVector, other : OptmetapsoVector) -> Double {
  self.sub(other).norm()
}

pub fn OptmetapsoVector::to_string(self : OptmetapsoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_pso_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_pso_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_pso_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_pso_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_pso_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_pso_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_pso_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_pso_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_pso_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_pso_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_pso_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_pso_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_pso_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_pso_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_pso_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_pso_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_pso_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_pso_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_pso_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_pso_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_pso_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_pso_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_pso_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_pso_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_pso_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_pso_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_pso_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_pso_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_pso_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetapsoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_frame_make(size : Int) -> OptmetapsoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_frame_len(s : OptmetapsoFrame) -> Int { s.size }

pub fn opt_meta_pso_frame_get(s : OptmetapsoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_frame_set(s : OptmetapsoFrame, i : Int, v : Double) -> OptmetapsoFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_frame_sum(s : OptmetapsoFrame) -> Double { @_common.sum(s.data) }

pub fn opt_meta_pso_frame_mean(s : OptmetapsoFrame) -> Double { @_common.mean(s.data) }

pub fn opt_meta_pso_frame_scale(s : OptmetapsoFrame, f : Double) -> OptmetapsoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_frame_add(a : OptmetapsoFrame, b : OptmetapsoFrame) -> OptmetapsoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_pso_frame_copy(s : OptmetapsoFrame) -> OptmetapsoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_frame_fill(s : OptmetapsoFrame, v : Double) -> OptmetapsoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_frame_min(s : OptmetapsoFrame) -> Double { @_common.min(s.data) }

pub fn opt_meta_pso_frame_max(s : OptmetapsoFrame) -> Double { @_common.max(s.data) }

pub fn opt_meta_pso_frame_to_string(s : OptmetapsoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_table_make(size : Int) -> OptmetapsoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_table_len(s : OptmetapsoTable) -> Int { s.size }

pub fn opt_meta_pso_table_get(s : OptmetapsoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_table_set(s : OptmetapsoTable, i : Int, v : Double) -> OptmetapsoTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_table_sum(s : OptmetapsoTable) -> Double { @_common.sum(s.data) }

pub fn opt_meta_pso_table_mean(s : OptmetapsoTable) -> Double { @_common.mean(s.data) }

pub fn opt_meta_pso_table_scale(s : OptmetapsoTable, f : Double) -> OptmetapsoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_table_add(a : OptmetapsoTable, b : OptmetapsoTable) -> OptmetapsoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_pso_table_copy(s : OptmetapsoTable) -> OptmetapsoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_table_fill(s : OptmetapsoTable, v : Double) -> OptmetapsoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_table_min(s : OptmetapsoTable) -> Double { @_common.min(s.data) }

pub fn opt_meta_pso_table_max(s : OptmetapsoTable) -> Double { @_common.max(s.data) }

pub fn opt_meta_pso_table_to_string(s : OptmetapsoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_graphn_make(size : Int) -> OptmetapsoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_graphn_len(s : OptmetapsoGraphN) -> Int { s.size }

pub fn opt_meta_pso_graphn_get(s : OptmetapsoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_graphn_set(s : OptmetapsoGraphN, i : Int, v : Double) -> OptmetapsoGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_graphn_sum(s : OptmetapsoGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_meta_pso_graphn_mean(s : OptmetapsoGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_meta_pso_graphn_scale(s : OptmetapsoGraphN, f : Double) -> OptmetapsoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_graphn_add(a : OptmetapsoGraphN, b : OptmetapsoGraphN) -> OptmetapsoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_pso_graphn_copy(s : OptmetapsoGraphN) -> OptmetapsoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_graphn_fill(s : OptmetapsoGraphN, v : Double) -> OptmetapsoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_graphn_min(s : OptmetapsoGraphN) -> Double { @_common.min(s.data) }

pub fn opt_meta_pso_graphn_max(s : OptmetapsoGraphN) -> Double { @_common.max(s.data) }

pub fn opt_meta_pso_graphn_to_string(s : OptmetapsoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_node_make(size : Int) -> OptmetapsoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_node_len(s : OptmetapsoNode) -> Int { s.size }

pub fn opt_meta_pso_node_get(s : OptmetapsoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_node_set(s : OptmetapsoNode, i : Int, v : Double) -> OptmetapsoNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_node_sum(s : OptmetapsoNode) -> Double { @_common.sum(s.data) }

pub fn opt_meta_pso_node_mean(s : OptmetapsoNode) -> Double { @_common.mean(s.data) }

pub fn opt_meta_pso_node_scale(s : OptmetapsoNode, f : Double) -> OptmetapsoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_node_add(a : OptmetapsoNode, b : OptmetapsoNode) -> OptmetapsoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_pso_node_copy(s : OptmetapsoNode) -> OptmetapsoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_node_fill(s : OptmetapsoNode, v : Double) -> OptmetapsoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_node_min(s : OptmetapsoNode) -> Double { @_common.min(s.data) }

pub fn opt_meta_pso_node_max(s : OptmetapsoNode) -> Double { @_common.max(s.data) }

pub fn opt_meta_pso_node_to_string(s : OptmetapsoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_edge_make(size : Int) -> OptmetapsoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_edge_len(s : OptmetapsoEdge) -> Int { s.size }

pub fn opt_meta_pso_edge_get(s : OptmetapsoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_edge_set(s : OptmetapsoEdge, i : Int, v : Double) -> OptmetapsoEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_edge_sum(s : OptmetapsoEdge) -> Double { @_common.sum(s.data) }

pub fn opt_meta_pso_edge_mean(s : OptmetapsoEdge) -> Double { @_common.mean(s.data) }

pub fn opt_meta_pso_edge_scale(s : OptmetapsoEdge, f : Double) -> OptmetapsoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_edge_add(a : OptmetapsoEdge, b : OptmetapsoEdge) -> OptmetapsoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_pso_edge_copy(s : OptmetapsoEdge) -> OptmetapsoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_edge_fill(s : OptmetapsoEdge, v : Double) -> OptmetapsoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_edge_min(s : OptmetapsoEdge) -> Double { @_common.min(s.data) }

pub fn opt_meta_pso_edge_max(s : OptmetapsoEdge) -> Double { @_common.max(s.data) }

pub fn opt_meta_pso_edge_to_string(s : OptmetapsoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_path_make(size : Int) -> OptmetapsoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_path_len(s : OptmetapsoPath) -> Int { s.size }

pub fn opt_meta_pso_path_get(s : OptmetapsoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_path_set(s : OptmetapsoPath, i : Int, v : Double) -> OptmetapsoPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_path_sum(s : OptmetapsoPath) -> Double { @_common.sum(s.data) }

pub fn opt_meta_pso_path_mean(s : OptmetapsoPath) -> Double { @_common.mean(s.data) }

pub fn opt_meta_pso_path_scale(s : OptmetapsoPath, f : Double) -> OptmetapsoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_path_add(a : OptmetapsoPath, b : OptmetapsoPath) -> OptmetapsoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_pso_path_copy(s : OptmetapsoPath) -> OptmetapsoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_path_fill(s : OptmetapsoPath, v : Double) -> OptmetapsoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_path_min(s : OptmetapsoPath) -> Double { @_common.min(s.data) }

pub fn opt_meta_pso_path_max(s : OptmetapsoPath) -> Double { @_common.max(s.data) }

pub fn opt_meta_pso_path_to_string(s : OptmetapsoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_cluster_make(size : Int) -> OptmetapsoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_cluster_len(s : OptmetapsoCluster) -> Int { s.size }

pub fn opt_meta_pso_cluster_get(s : OptmetapsoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_cluster_set(s : OptmetapsoCluster, i : Int, v : Double) -> OptmetapsoCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_cluster_sum(s : OptmetapsoCluster) -> Double { @_common.sum(s.data) }

pub fn opt_meta_pso_cluster_mean(s : OptmetapsoCluster) -> Double { @_common.mean(s.data) }

pub fn opt_meta_pso_cluster_scale(s : OptmetapsoCluster, f : Double) -> OptmetapsoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_cluster_add(a : OptmetapsoCluster, b : OptmetapsoCluster) -> OptmetapsoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_pso_cluster_copy(s : OptmetapsoCluster) -> OptmetapsoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_cluster_fill(s : OptmetapsoCluster, v : Double) -> OptmetapsoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_cluster_min(s : OptmetapsoCluster) -> Double { @_common.min(s.data) }

pub fn opt_meta_pso_cluster_max(s : OptmetapsoCluster) -> Double { @_common.max(s.data) }

pub fn opt_meta_pso_cluster_to_string(s : OptmetapsoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_model_make(size : Int) -> OptmetapsoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_model_len(s : OptmetapsoModel) -> Int { s.size }

pub fn opt_meta_pso_model_get(s : OptmetapsoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_model_set(s : OptmetapsoModel, i : Int, v : Double) -> OptmetapsoModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_model_sum(s : OptmetapsoModel) -> Double { @_common.sum(s.data) }

pub fn opt_meta_pso_model_mean(s : OptmetapsoModel) -> Double { @_common.mean(s.data) }

pub fn opt_meta_pso_model_scale(s : OptmetapsoModel, f : Double) -> OptmetapsoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_model_add(a : OptmetapsoModel, b : OptmetapsoModel) -> OptmetapsoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_pso_model_copy(s : OptmetapsoModel) -> OptmetapsoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_model_fill(s : OptmetapsoModel, v : Double) -> OptmetapsoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_model_min(s : OptmetapsoModel) -> Double { @_common.min(s.data) }

pub fn opt_meta_pso_model_max(s : OptmetapsoModel) -> Double { @_common.max(s.data) }

pub fn opt_meta_pso_model_to_string(s : OptmetapsoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_layer_make(size : Int) -> OptmetapsoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_layer_len(s : OptmetapsoLayer) -> Int { s.size }

pub fn opt_meta_pso_layer_get(s : OptmetapsoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_layer_set(s : OptmetapsoLayer, i : Int, v : Double) -> OptmetapsoLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_layer_sum(s : OptmetapsoLayer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_pso_layer_mean(s : OptmetapsoLayer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_pso_layer_scale(s : OptmetapsoLayer, f : Double) -> OptmetapsoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_layer_add(a : OptmetapsoLayer, b : OptmetapsoLayer) -> OptmetapsoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_pso_layer_copy(s : OptmetapsoLayer) -> OptmetapsoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_layer_fill(s : OptmetapsoLayer, v : Double) -> OptmetapsoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_layer_min(s : OptmetapsoLayer) -> Double { @_common.min(s.data) }

pub fn opt_meta_pso_layer_max(s : OptmetapsoLayer) -> Double { @_common.max(s.data) }

pub fn opt_meta_pso_layer_to_string(s : OptmetapsoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_buffer_make(size : Int) -> OptmetapsoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_buffer_len(s : OptmetapsoBuffer) -> Int { s.size }

pub fn opt_meta_pso_buffer_get(s : OptmetapsoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_buffer_set(s : OptmetapsoBuffer, i : Int, v : Double) -> OptmetapsoBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_buffer_sum(s : OptmetapsoBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_pso_buffer_mean(s : OptmetapsoBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_pso_buffer_scale(s : OptmetapsoBuffer, f : Double) -> OptmetapsoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_buffer_add(a : OptmetapsoBuffer, b : OptmetapsoBuffer) -> OptmetapsoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_pso_buffer_copy(s : OptmetapsoBuffer) -> OptmetapsoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_buffer_fill(s : OptmetapsoBuffer, v : Double) -> OptmetapsoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_buffer_min(s : OptmetapsoBuffer) -> Double { @_common.min(s.data) }

pub fn opt_meta_pso_buffer_max(s : OptmetapsoBuffer) -> Double { @_common.max(s.data) }

pub fn opt_meta_pso_buffer_to_string(s : OptmetapsoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_cursor_make(size : Int) -> OptmetapsoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_cursor_len(s : OptmetapsoCursor) -> Int { s.size }

pub fn opt_meta_pso_cursor_get(s : OptmetapsoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_cursor_set(s : OptmetapsoCursor, i : Int, v : Double) -> OptmetapsoCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_cursor_sum(s : OptmetapsoCursor) -> Double { @_common.sum(s.data) }

pub fn opt_meta_pso_cursor_mean(s : OptmetapsoCursor) -> Double { @_common.mean(s.data) }

pub fn opt_meta_pso_cursor_scale(s : OptmetapsoCursor, f : Double) -> OptmetapsoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_cursor_add(a : OptmetapsoCursor, b : OptmetapsoCursor) -> OptmetapsoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_pso_cursor_copy(s : OptmetapsoCursor) -> OptmetapsoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_cursor_fill(s : OptmetapsoCursor, v : Double) -> OptmetapsoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_cursor_min(s : OptmetapsoCursor) -> Double { @_common.min(s.data) }

pub fn opt_meta_pso_cursor_max(s : OptmetapsoCursor) -> Double { @_common.max(s.data) }

pub fn opt_meta_pso_cursor_to_string(s : OptmetapsoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_view_make(size : Int) -> OptmetapsoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_view_len(s : OptmetapsoView) -> Int { s.size }

pub fn opt_meta_pso_view_get(s : OptmetapsoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_view_set(s : OptmetapsoView, i : Int, v : Double) -> OptmetapsoView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_view_sum(s : OptmetapsoView) -> Double { @_common.sum(s.data) }

pub fn opt_meta_pso_view_mean(s : OptmetapsoView) -> Double { @_common.mean(s.data) }

pub fn opt_meta_pso_view_scale(s : OptmetapsoView, f : Double) -> OptmetapsoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_view_add(a : OptmetapsoView, b : OptmetapsoView) -> OptmetapsoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_pso_view_copy(s : OptmetapsoView) -> OptmetapsoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_view_fill(s : OptmetapsoView, v : Double) -> OptmetapsoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_view_min(s : OptmetapsoView) -> Double { @_common.min(s.data) }

pub fn opt_meta_pso_view_max(s : OptmetapsoView) -> Double { @_common.max(s.data) }

pub fn opt_meta_pso_view_to_string(s : OptmetapsoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_range_make(size : Int) -> OptmetapsoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_range_len(s : OptmetapsoRange) -> Int { s.size }

pub fn opt_meta_pso_range_get(s : OptmetapsoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_range_set(s : OptmetapsoRange, i : Int, v : Double) -> OptmetapsoRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_range_sum(s : OptmetapsoRange) -> Double { @_common.sum(s.data) }

pub fn opt_meta_pso_range_mean(s : OptmetapsoRange) -> Double { @_common.mean(s.data) }

pub fn opt_meta_pso_range_scale(s : OptmetapsoRange, f : Double) -> OptmetapsoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_range_add(a : OptmetapsoRange, b : OptmetapsoRange) -> OptmetapsoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_pso_range_copy(s : OptmetapsoRange) -> OptmetapsoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_range_fill(s : OptmetapsoRange, v : Double) -> OptmetapsoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_range_min(s : OptmetapsoRange) -> Double { @_common.min(s.data) }

pub fn opt_meta_pso_range_max(s : OptmetapsoRange) -> Double { @_common.max(s.data) }

pub fn opt_meta_pso_range_to_string(s : OptmetapsoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_slice_make(size : Int) -> OptmetapsoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_slice_len(s : OptmetapsoSlice) -> Int { s.size }

pub fn opt_meta_pso_slice_get(s : OptmetapsoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_slice_set(s : OptmetapsoSlice, i : Int, v : Double) -> OptmetapsoSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_slice_sum(s : OptmetapsoSlice) -> Double { @_common.sum(s.data) }

pub fn opt_meta_pso_slice_mean(s : OptmetapsoSlice) -> Double { @_common.mean(s.data) }

pub fn opt_meta_pso_slice_scale(s : OptmetapsoSlice, f : Double) -> OptmetapsoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_slice_add(a : OptmetapsoSlice, b : OptmetapsoSlice) -> OptmetapsoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_pso_slice_copy(s : OptmetapsoSlice) -> OptmetapsoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_slice_fill(s : OptmetapsoSlice, v : Double) -> OptmetapsoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_pso_slice_min(s : OptmetapsoSlice) -> Double { @_common.min(s.data) }

pub fn opt_meta_pso_slice_max(s : OptmetapsoSlice) -> Double { @_common.max(s.data) }

pub fn opt_meta_pso_slice_to_string(s : OptmetapsoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

