///===
/// extcore/opt_grad_adamax

pub(all) struct OptgradadamaxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_adamax_make_point(x : Double, y : Double) -> OptgradadamaxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_adamax_make_point3(x : Double, y : Double, z : Double) -> OptgradadamaxPoint {
  { x, y, z, label: 0 }
}

pub fn OptgradadamaxPoint::x(self : OptgradadamaxPoint) -> Double { self.x }

pub fn OptgradadamaxPoint::y(self : OptgradadamaxPoint) -> Double { self.y }

pub fn OptgradadamaxPoint::z(self : OptgradadamaxPoint) -> Double { self.z }

pub fn OptgradadamaxPoint::label(self : OptgradadamaxPoint) -> Int { self.label }

pub fn OptgradadamaxPoint::dist(self : OptgradadamaxPoint, other : OptgradadamaxPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptgradadamaxPoint::add(self : OptgradadamaxPoint, other : OptgradadamaxPoint) -> OptgradadamaxPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptgradadamaxPoint::sub(self : OptgradadamaxPoint, other : OptgradadamaxPoint) -> OptgradadamaxPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptgradadamaxPoint::scale(self : OptgradadamaxPoint, s : Double) -> OptgradadamaxPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptgradadamaxPoint::dot(self : OptgradadamaxPoint, other : OptgradadamaxPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptgradadamaxPoint::cross(self : OptgradadamaxPoint, other : OptgradadamaxPoint) -> OptgradadamaxPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptgradadamaxPoint::norm(self : OptgradadamaxPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptgradadamaxPoint::normalize(self : OptgradadamaxPoint) -> OptgradadamaxPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradadamaxPoint::negate(self : OptgradadamaxPoint) -> OptgradadamaxPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptgradadamaxPoint::mid(self : OptgradadamaxPoint, other : OptgradadamaxPoint) -> OptgradadamaxPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptgradadamaxPoint::lerp(self : OptgradadamaxPoint, other : OptgradadamaxPoint, t : Double) -> OptgradadamaxPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptgradadamaxPoint::to_string(self : OptgradadamaxPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptgradadamaxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_adamax_make_series(vals : Array[Double], name : String) -> OptgradadamaxSeries {
  { vals, name, meta: 0 }
}

pub fn OptgradadamaxSeries::len(self : OptgradadamaxSeries) -> Int { self.vals.length() }

pub fn OptgradadamaxSeries::sum(self : OptgradadamaxSeries) -> Double { @_common.sum(self.vals) }

pub fn OptgradadamaxSeries::mean(self : OptgradadamaxSeries) -> Double { @_common.mean(self.vals) }

pub fn OptgradadamaxSeries::min(self : OptgradadamaxSeries) -> Double { @_common.min(self.vals) }

pub fn OptgradadamaxSeries::max(self : OptgradadamaxSeries) -> Double { @_common.max(self.vals) }

pub fn OptgradadamaxSeries::range(self : OptgradadamaxSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptgradadamaxSeries::variance(self : OptgradadamaxSeries) -> Double { @_common.variance(self.vals) }

pub fn OptgradadamaxSeries::std(self : OptgradadamaxSeries) -> Double { @_common.std(self.vals) }

pub fn OptgradadamaxSeries::median(self : OptgradadamaxSeries) -> Double { @_common.median(self.vals) }

pub fn OptgradadamaxSeries::scale(self : OptgradadamaxSeries, f : Double) -> OptgradadamaxSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptgradadamaxSeries::add(self : OptgradadamaxSeries, other : OptgradadamaxSeries) -> OptgradadamaxSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptgradadamaxSeries::sub(self : OptgradadamaxSeries, other : OptgradadamaxSeries) -> OptgradadamaxSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptgradadamaxSeries::normalize(self : OptgradadamaxSeries) -> OptgradadamaxSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptgradadamaxSeries::cumsum(self : OptgradadamaxSeries) -> OptgradadamaxSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptgradadamaxSeries::to_string(self : OptgradadamaxSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradadamaxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_adamax_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradadamaxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_adamax_matrix_identity(n : Int) -> OptgradadamaxMatrix {
  let m = opt_grad_adamax_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptgradadamaxMatrix::get(self : OptgradadamaxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptgradadamaxMatrix::transpose(self : OptgradadamaxMatrix) -> OptgradadamaxMatrix {
  let result = opt_grad_adamax_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptgradadamaxMatrix::add(self : OptgradadamaxMatrix, other : OptgradadamaxMatrix) -> OptgradadamaxMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_grad_adamax_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptgradadamaxMatrix::scale(self : OptgradadamaxMatrix, s : Double) -> OptgradadamaxMatrix {
  let result = opt_grad_adamax_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptgradadamaxMatrix::multiply(self : OptgradadamaxMatrix, other : OptgradadamaxMatrix) -> OptgradadamaxMatrix {
  if self.cols != other.rows { return opt_grad_adamax_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_grad_adamax_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptgradadamaxMatrix::trace(self : OptgradadamaxMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptgradadamaxMatrix::det(self : OptgradadamaxMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptgradadamaxMatrix::norm(self : OptgradadamaxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptgradadamaxMatrix::to_string(self : OptgradadamaxMatrix) -> String {
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

pub(all) struct OptgradadamaxVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_adamax_make_vector(comps : Array[Double]) -> OptgradadamaxVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_adamax_vector_zero(dim : Int) -> OptgradadamaxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptgradadamaxVector::add(self : OptgradadamaxVector, other : OptgradadamaxVector) -> OptgradadamaxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradadamaxVector::sub(self : OptgradadamaxVector, other : OptgradadamaxVector) -> OptgradadamaxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradadamaxVector::scale(self : OptgradadamaxVector, s : Double) -> OptgradadamaxVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptgradadamaxVector::dot(self : OptgradadamaxVector, other : OptgradadamaxVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptgradadamaxVector::norm(self : OptgradadamaxVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptgradadamaxVector::normalize(self : OptgradadamaxVector) -> OptgradadamaxVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradadamaxVector::dist(self : OptgradadamaxVector, other : OptgradadamaxVector) -> Double {
  self.sub(other).norm()
}

pub fn OptgradadamaxVector::to_string(self : OptgradadamaxVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_adamax_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_grad_adamax_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_grad_adamax_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_grad_adamax_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_grad_adamax_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_grad_adamax_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_grad_adamax_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_grad_adamax_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_grad_adamax_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_grad_adamax_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_grad_adamax_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_grad_adamax_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_grad_adamax_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_grad_adamax_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_grad_adamax_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_grad_adamax_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_grad_adamax_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_grad_adamax_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_grad_adamax_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_grad_adamax_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_grad_adamax_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_grad_adamax_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_grad_adamax_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_grad_adamax_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_grad_adamax_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_grad_adamax_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_grad_adamax_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_grad_adamax_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_grad_adamax_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptgradadamaxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_frame_make(size : Int) -> OptgradadamaxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_frame_len(s : OptgradadamaxFrame) -> Int { s.size }

pub fn opt_grad_adamax_frame_get(s : OptgradadamaxFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_frame_set(s : OptgradadamaxFrame, i : Int, v : Double) -> OptgradadamaxFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_frame_sum(s : OptgradadamaxFrame) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adamax_frame_mean(s : OptgradadamaxFrame) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adamax_frame_scale(s : OptgradadamaxFrame, f : Double) -> OptgradadamaxFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_frame_add(a : OptgradadamaxFrame, b : OptgradadamaxFrame) -> OptgradadamaxFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adamax_frame_copy(s : OptgradadamaxFrame) -> OptgradadamaxFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_frame_fill(s : OptgradadamaxFrame, v : Double) -> OptgradadamaxFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_frame_min(s : OptgradadamaxFrame) -> Double { @_common.min(s.data) }

pub fn opt_grad_adamax_frame_max(s : OptgradadamaxFrame) -> Double { @_common.max(s.data) }

pub fn opt_grad_adamax_frame_to_string(s : OptgradadamaxFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_table_make(size : Int) -> OptgradadamaxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_table_len(s : OptgradadamaxTable) -> Int { s.size }

pub fn opt_grad_adamax_table_get(s : OptgradadamaxTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_table_set(s : OptgradadamaxTable, i : Int, v : Double) -> OptgradadamaxTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_table_sum(s : OptgradadamaxTable) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adamax_table_mean(s : OptgradadamaxTable) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adamax_table_scale(s : OptgradadamaxTable, f : Double) -> OptgradadamaxTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_table_add(a : OptgradadamaxTable, b : OptgradadamaxTable) -> OptgradadamaxTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adamax_table_copy(s : OptgradadamaxTable) -> OptgradadamaxTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_table_fill(s : OptgradadamaxTable, v : Double) -> OptgradadamaxTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_table_min(s : OptgradadamaxTable) -> Double { @_common.min(s.data) }

pub fn opt_grad_adamax_table_max(s : OptgradadamaxTable) -> Double { @_common.max(s.data) }

pub fn opt_grad_adamax_table_to_string(s : OptgradadamaxTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_graphn_make(size : Int) -> OptgradadamaxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_graphn_len(s : OptgradadamaxGraphN) -> Int { s.size }

pub fn opt_grad_adamax_graphn_get(s : OptgradadamaxGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_graphn_set(s : OptgradadamaxGraphN, i : Int, v : Double) -> OptgradadamaxGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_graphn_sum(s : OptgradadamaxGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adamax_graphn_mean(s : OptgradadamaxGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adamax_graphn_scale(s : OptgradadamaxGraphN, f : Double) -> OptgradadamaxGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_graphn_add(a : OptgradadamaxGraphN, b : OptgradadamaxGraphN) -> OptgradadamaxGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adamax_graphn_copy(s : OptgradadamaxGraphN) -> OptgradadamaxGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_graphn_fill(s : OptgradadamaxGraphN, v : Double) -> OptgradadamaxGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_graphn_min(s : OptgradadamaxGraphN) -> Double { @_common.min(s.data) }

pub fn opt_grad_adamax_graphn_max(s : OptgradadamaxGraphN) -> Double { @_common.max(s.data) }

pub fn opt_grad_adamax_graphn_to_string(s : OptgradadamaxGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_node_make(size : Int) -> OptgradadamaxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_node_len(s : OptgradadamaxNode) -> Int { s.size }

pub fn opt_grad_adamax_node_get(s : OptgradadamaxNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_node_set(s : OptgradadamaxNode, i : Int, v : Double) -> OptgradadamaxNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_node_sum(s : OptgradadamaxNode) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adamax_node_mean(s : OptgradadamaxNode) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adamax_node_scale(s : OptgradadamaxNode, f : Double) -> OptgradadamaxNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_node_add(a : OptgradadamaxNode, b : OptgradadamaxNode) -> OptgradadamaxNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adamax_node_copy(s : OptgradadamaxNode) -> OptgradadamaxNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_node_fill(s : OptgradadamaxNode, v : Double) -> OptgradadamaxNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_node_min(s : OptgradadamaxNode) -> Double { @_common.min(s.data) }

pub fn opt_grad_adamax_node_max(s : OptgradadamaxNode) -> Double { @_common.max(s.data) }

pub fn opt_grad_adamax_node_to_string(s : OptgradadamaxNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_edge_make(size : Int) -> OptgradadamaxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_edge_len(s : OptgradadamaxEdge) -> Int { s.size }

pub fn opt_grad_adamax_edge_get(s : OptgradadamaxEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_edge_set(s : OptgradadamaxEdge, i : Int, v : Double) -> OptgradadamaxEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_edge_sum(s : OptgradadamaxEdge) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adamax_edge_mean(s : OptgradadamaxEdge) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adamax_edge_scale(s : OptgradadamaxEdge, f : Double) -> OptgradadamaxEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_edge_add(a : OptgradadamaxEdge, b : OptgradadamaxEdge) -> OptgradadamaxEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adamax_edge_copy(s : OptgradadamaxEdge) -> OptgradadamaxEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_edge_fill(s : OptgradadamaxEdge, v : Double) -> OptgradadamaxEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_edge_min(s : OptgradadamaxEdge) -> Double { @_common.min(s.data) }

pub fn opt_grad_adamax_edge_max(s : OptgradadamaxEdge) -> Double { @_common.max(s.data) }

pub fn opt_grad_adamax_edge_to_string(s : OptgradadamaxEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_path_make(size : Int) -> OptgradadamaxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_path_len(s : OptgradadamaxPath) -> Int { s.size }

pub fn opt_grad_adamax_path_get(s : OptgradadamaxPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_path_set(s : OptgradadamaxPath, i : Int, v : Double) -> OptgradadamaxPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_path_sum(s : OptgradadamaxPath) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adamax_path_mean(s : OptgradadamaxPath) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adamax_path_scale(s : OptgradadamaxPath, f : Double) -> OptgradadamaxPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_path_add(a : OptgradadamaxPath, b : OptgradadamaxPath) -> OptgradadamaxPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adamax_path_copy(s : OptgradadamaxPath) -> OptgradadamaxPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_path_fill(s : OptgradadamaxPath, v : Double) -> OptgradadamaxPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_path_min(s : OptgradadamaxPath) -> Double { @_common.min(s.data) }

pub fn opt_grad_adamax_path_max(s : OptgradadamaxPath) -> Double { @_common.max(s.data) }

pub fn opt_grad_adamax_path_to_string(s : OptgradadamaxPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_cluster_make(size : Int) -> OptgradadamaxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_cluster_len(s : OptgradadamaxCluster) -> Int { s.size }

pub fn opt_grad_adamax_cluster_get(s : OptgradadamaxCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_cluster_set(s : OptgradadamaxCluster, i : Int, v : Double) -> OptgradadamaxCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_cluster_sum(s : OptgradadamaxCluster) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adamax_cluster_mean(s : OptgradadamaxCluster) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adamax_cluster_scale(s : OptgradadamaxCluster, f : Double) -> OptgradadamaxCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_cluster_add(a : OptgradadamaxCluster, b : OptgradadamaxCluster) -> OptgradadamaxCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adamax_cluster_copy(s : OptgradadamaxCluster) -> OptgradadamaxCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_cluster_fill(s : OptgradadamaxCluster, v : Double) -> OptgradadamaxCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_cluster_min(s : OptgradadamaxCluster) -> Double { @_common.min(s.data) }

pub fn opt_grad_adamax_cluster_max(s : OptgradadamaxCluster) -> Double { @_common.max(s.data) }

pub fn opt_grad_adamax_cluster_to_string(s : OptgradadamaxCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_model_make(size : Int) -> OptgradadamaxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_model_len(s : OptgradadamaxModel) -> Int { s.size }

pub fn opt_grad_adamax_model_get(s : OptgradadamaxModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_model_set(s : OptgradadamaxModel, i : Int, v : Double) -> OptgradadamaxModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_model_sum(s : OptgradadamaxModel) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adamax_model_mean(s : OptgradadamaxModel) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adamax_model_scale(s : OptgradadamaxModel, f : Double) -> OptgradadamaxModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_model_add(a : OptgradadamaxModel, b : OptgradadamaxModel) -> OptgradadamaxModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adamax_model_copy(s : OptgradadamaxModel) -> OptgradadamaxModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_model_fill(s : OptgradadamaxModel, v : Double) -> OptgradadamaxModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_model_min(s : OptgradadamaxModel) -> Double { @_common.min(s.data) }

pub fn opt_grad_adamax_model_max(s : OptgradadamaxModel) -> Double { @_common.max(s.data) }

pub fn opt_grad_adamax_model_to_string(s : OptgradadamaxModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_layer_make(size : Int) -> OptgradadamaxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_layer_len(s : OptgradadamaxLayer) -> Int { s.size }

pub fn opt_grad_adamax_layer_get(s : OptgradadamaxLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_layer_set(s : OptgradadamaxLayer, i : Int, v : Double) -> OptgradadamaxLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_layer_sum(s : OptgradadamaxLayer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adamax_layer_mean(s : OptgradadamaxLayer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adamax_layer_scale(s : OptgradadamaxLayer, f : Double) -> OptgradadamaxLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_layer_add(a : OptgradadamaxLayer, b : OptgradadamaxLayer) -> OptgradadamaxLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adamax_layer_copy(s : OptgradadamaxLayer) -> OptgradadamaxLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_layer_fill(s : OptgradadamaxLayer, v : Double) -> OptgradadamaxLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_layer_min(s : OptgradadamaxLayer) -> Double { @_common.min(s.data) }

pub fn opt_grad_adamax_layer_max(s : OptgradadamaxLayer) -> Double { @_common.max(s.data) }

pub fn opt_grad_adamax_layer_to_string(s : OptgradadamaxLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_buffer_make(size : Int) -> OptgradadamaxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_buffer_len(s : OptgradadamaxBuffer) -> Int { s.size }

pub fn opt_grad_adamax_buffer_get(s : OptgradadamaxBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_buffer_set(s : OptgradadamaxBuffer, i : Int, v : Double) -> OptgradadamaxBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_buffer_sum(s : OptgradadamaxBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adamax_buffer_mean(s : OptgradadamaxBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adamax_buffer_scale(s : OptgradadamaxBuffer, f : Double) -> OptgradadamaxBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_buffer_add(a : OptgradadamaxBuffer, b : OptgradadamaxBuffer) -> OptgradadamaxBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adamax_buffer_copy(s : OptgradadamaxBuffer) -> OptgradadamaxBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_buffer_fill(s : OptgradadamaxBuffer, v : Double) -> OptgradadamaxBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_buffer_min(s : OptgradadamaxBuffer) -> Double { @_common.min(s.data) }

pub fn opt_grad_adamax_buffer_max(s : OptgradadamaxBuffer) -> Double { @_common.max(s.data) }

pub fn opt_grad_adamax_buffer_to_string(s : OptgradadamaxBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_cursor_make(size : Int) -> OptgradadamaxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_cursor_len(s : OptgradadamaxCursor) -> Int { s.size }

pub fn opt_grad_adamax_cursor_get(s : OptgradadamaxCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_cursor_set(s : OptgradadamaxCursor, i : Int, v : Double) -> OptgradadamaxCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_cursor_sum(s : OptgradadamaxCursor) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adamax_cursor_mean(s : OptgradadamaxCursor) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adamax_cursor_scale(s : OptgradadamaxCursor, f : Double) -> OptgradadamaxCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_cursor_add(a : OptgradadamaxCursor, b : OptgradadamaxCursor) -> OptgradadamaxCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adamax_cursor_copy(s : OptgradadamaxCursor) -> OptgradadamaxCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_cursor_fill(s : OptgradadamaxCursor, v : Double) -> OptgradadamaxCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_cursor_min(s : OptgradadamaxCursor) -> Double { @_common.min(s.data) }

pub fn opt_grad_adamax_cursor_max(s : OptgradadamaxCursor) -> Double { @_common.max(s.data) }

pub fn opt_grad_adamax_cursor_to_string(s : OptgradadamaxCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_view_make(size : Int) -> OptgradadamaxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_view_len(s : OptgradadamaxView) -> Int { s.size }

pub fn opt_grad_adamax_view_get(s : OptgradadamaxView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_view_set(s : OptgradadamaxView, i : Int, v : Double) -> OptgradadamaxView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_view_sum(s : OptgradadamaxView) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adamax_view_mean(s : OptgradadamaxView) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adamax_view_scale(s : OptgradadamaxView, f : Double) -> OptgradadamaxView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_view_add(a : OptgradadamaxView, b : OptgradadamaxView) -> OptgradadamaxView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adamax_view_copy(s : OptgradadamaxView) -> OptgradadamaxView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_view_fill(s : OptgradadamaxView, v : Double) -> OptgradadamaxView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_view_min(s : OptgradadamaxView) -> Double { @_common.min(s.data) }

pub fn opt_grad_adamax_view_max(s : OptgradadamaxView) -> Double { @_common.max(s.data) }

pub fn opt_grad_adamax_view_to_string(s : OptgradadamaxView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_range_make(size : Int) -> OptgradadamaxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_range_len(s : OptgradadamaxRange) -> Int { s.size }

pub fn opt_grad_adamax_range_get(s : OptgradadamaxRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_range_set(s : OptgradadamaxRange, i : Int, v : Double) -> OptgradadamaxRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_range_sum(s : OptgradadamaxRange) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adamax_range_mean(s : OptgradadamaxRange) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adamax_range_scale(s : OptgradadamaxRange, f : Double) -> OptgradadamaxRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_range_add(a : OptgradadamaxRange, b : OptgradadamaxRange) -> OptgradadamaxRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adamax_range_copy(s : OptgradadamaxRange) -> OptgradadamaxRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_range_fill(s : OptgradadamaxRange, v : Double) -> OptgradadamaxRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_range_min(s : OptgradadamaxRange) -> Double { @_common.min(s.data) }

pub fn opt_grad_adamax_range_max(s : OptgradadamaxRange) -> Double { @_common.max(s.data) }

pub fn opt_grad_adamax_range_to_string(s : OptgradadamaxRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_slice_make(size : Int) -> OptgradadamaxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_slice_len(s : OptgradadamaxSlice) -> Int { s.size }

pub fn opt_grad_adamax_slice_get(s : OptgradadamaxSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_slice_set(s : OptgradadamaxSlice, i : Int, v : Double) -> OptgradadamaxSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_slice_sum(s : OptgradadamaxSlice) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adamax_slice_mean(s : OptgradadamaxSlice) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adamax_slice_scale(s : OptgradadamaxSlice, f : Double) -> OptgradadamaxSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_slice_add(a : OptgradadamaxSlice, b : OptgradadamaxSlice) -> OptgradadamaxSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adamax_slice_copy(s : OptgradadamaxSlice) -> OptgradadamaxSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_slice_fill(s : OptgradadamaxSlice, v : Double) -> OptgradadamaxSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adamax_slice_min(s : OptgradadamaxSlice) -> Double { @_common.min(s.data) }

pub fn opt_grad_adamax_slice_max(s : OptgradadamaxSlice) -> Double { @_common.max(s.data) }

pub fn opt_grad_adamax_slice_to_string(s : OptgradadamaxSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

