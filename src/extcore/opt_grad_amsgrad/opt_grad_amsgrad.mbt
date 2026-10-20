///===
/// extcore/opt_grad_amsgrad

pub(all) struct OptgradamsgradPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_amsgrad_make_point(x : Double, y : Double) -> OptgradamsgradPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_amsgrad_make_point3(x : Double, y : Double, z : Double) -> OptgradamsgradPoint {
  { x, y, z, label: 0 }
}

pub fn OptgradamsgradPoint::x(self : OptgradamsgradPoint) -> Double { self.x }

pub fn OptgradamsgradPoint::y(self : OptgradamsgradPoint) -> Double { self.y }

pub fn OptgradamsgradPoint::z(self : OptgradamsgradPoint) -> Double { self.z }

pub fn OptgradamsgradPoint::label(self : OptgradamsgradPoint) -> Int { self.label }

pub fn OptgradamsgradPoint::dist(self : OptgradamsgradPoint, other : OptgradamsgradPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptgradamsgradPoint::add(self : OptgradamsgradPoint, other : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptgradamsgradPoint::sub(self : OptgradamsgradPoint, other : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptgradamsgradPoint::scale(self : OptgradamsgradPoint, s : Double) -> OptgradamsgradPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptgradamsgradPoint::dot(self : OptgradamsgradPoint, other : OptgradamsgradPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptgradamsgradPoint::cross(self : OptgradamsgradPoint, other : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptgradamsgradPoint::norm(self : OptgradamsgradPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptgradamsgradPoint::normalize(self : OptgradamsgradPoint) -> OptgradamsgradPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradamsgradPoint::negate(self : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptgradamsgradPoint::mid(self : OptgradamsgradPoint, other : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptgradamsgradPoint::lerp(self : OptgradamsgradPoint, other : OptgradamsgradPoint, t : Double) -> OptgradamsgradPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptgradamsgradPoint::to_string(self : OptgradamsgradPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptgradamsgradSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_amsgrad_make_series(vals : Array[Double], name : String) -> OptgradamsgradSeries {
  { vals, name, meta: 0 }
}

pub fn OptgradamsgradSeries::len(self : OptgradamsgradSeries) -> Int { self.vals.length() }

pub fn OptgradamsgradSeries::sum(self : OptgradamsgradSeries) -> Double { @_common.sum(self.vals) }

pub fn OptgradamsgradSeries::mean(self : OptgradamsgradSeries) -> Double { @_common.mean(self.vals) }

pub fn OptgradamsgradSeries::min(self : OptgradamsgradSeries) -> Double { @_common.min(self.vals) }

pub fn OptgradamsgradSeries::max(self : OptgradamsgradSeries) -> Double { @_common.max(self.vals) }

pub fn OptgradamsgradSeries::range(self : OptgradamsgradSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptgradamsgradSeries::variance(self : OptgradamsgradSeries) -> Double { @_common.variance(self.vals) }

pub fn OptgradamsgradSeries::std(self : OptgradamsgradSeries) -> Double { @_common.std(self.vals) }

pub fn OptgradamsgradSeries::median(self : OptgradamsgradSeries) -> Double { @_common.median(self.vals) }

pub fn OptgradamsgradSeries::scale(self : OptgradamsgradSeries, f : Double) -> OptgradamsgradSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptgradamsgradSeries::add(self : OptgradamsgradSeries, other : OptgradamsgradSeries) -> OptgradamsgradSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptgradamsgradSeries::sub(self : OptgradamsgradSeries, other : OptgradamsgradSeries) -> OptgradamsgradSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptgradamsgradSeries::normalize(self : OptgradamsgradSeries) -> OptgradamsgradSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptgradamsgradSeries::cumsum(self : OptgradamsgradSeries) -> OptgradamsgradSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptgradamsgradSeries::to_string(self : OptgradamsgradSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradamsgradMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_amsgrad_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradamsgradMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_amsgrad_matrix_identity(n : Int) -> OptgradamsgradMatrix {
  let m = opt_grad_amsgrad_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptgradamsgradMatrix::get(self : OptgradamsgradMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptgradamsgradMatrix::transpose(self : OptgradamsgradMatrix) -> OptgradamsgradMatrix {
  let result = opt_grad_amsgrad_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptgradamsgradMatrix::add(self : OptgradamsgradMatrix, other : OptgradamsgradMatrix) -> OptgradamsgradMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_grad_amsgrad_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptgradamsgradMatrix::scale(self : OptgradamsgradMatrix, s : Double) -> OptgradamsgradMatrix {
  let result = opt_grad_amsgrad_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptgradamsgradMatrix::multiply(self : OptgradamsgradMatrix, other : OptgradamsgradMatrix) -> OptgradamsgradMatrix {
  if self.cols != other.rows { return opt_grad_amsgrad_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_grad_amsgrad_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptgradamsgradMatrix::trace(self : OptgradamsgradMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptgradamsgradMatrix::det(self : OptgradamsgradMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptgradamsgradMatrix::norm(self : OptgradamsgradMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptgradamsgradMatrix::to_string(self : OptgradamsgradMatrix) -> String {
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

pub(all) struct OptgradamsgradVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_amsgrad_make_vector(comps : Array[Double]) -> OptgradamsgradVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_amsgrad_vector_zero(dim : Int) -> OptgradamsgradVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptgradamsgradVector::add(self : OptgradamsgradVector, other : OptgradamsgradVector) -> OptgradamsgradVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradamsgradVector::sub(self : OptgradamsgradVector, other : OptgradamsgradVector) -> OptgradamsgradVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradamsgradVector::scale(self : OptgradamsgradVector, s : Double) -> OptgradamsgradVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptgradamsgradVector::dot(self : OptgradamsgradVector, other : OptgradamsgradVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptgradamsgradVector::norm(self : OptgradamsgradVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptgradamsgradVector::normalize(self : OptgradamsgradVector) -> OptgradamsgradVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradamsgradVector::dist(self : OptgradamsgradVector, other : OptgradamsgradVector) -> Double {
  self.sub(other).norm()
}

pub fn OptgradamsgradVector::to_string(self : OptgradamsgradVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_amsgrad_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_grad_amsgrad_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_grad_amsgrad_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_grad_amsgrad_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_grad_amsgrad_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_grad_amsgrad_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_grad_amsgrad_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_grad_amsgrad_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_grad_amsgrad_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_grad_amsgrad_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_grad_amsgrad_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_grad_amsgrad_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_grad_amsgrad_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_grad_amsgrad_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_grad_amsgrad_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_grad_amsgrad_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_grad_amsgrad_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_grad_amsgrad_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_grad_amsgrad_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_grad_amsgrad_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_grad_amsgrad_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_grad_amsgrad_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_grad_amsgrad_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_grad_amsgrad_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_grad_amsgrad_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_grad_amsgrad_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_grad_amsgrad_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_grad_amsgrad_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_grad_amsgrad_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptgradamsgradFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_frame_make(size : Int) -> OptgradamsgradFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_frame_len(s : OptgradamsgradFrame) -> Int { s.size }

pub fn opt_grad_amsgrad_frame_get(s : OptgradamsgradFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_frame_set(s : OptgradamsgradFrame, i : Int, v : Double) -> OptgradamsgradFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_frame_sum(s : OptgradamsgradFrame) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_frame_mean(s : OptgradamsgradFrame) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_frame_scale(s : OptgradamsgradFrame, f : Double) -> OptgradamsgradFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_frame_add(a : OptgradamsgradFrame, b : OptgradamsgradFrame) -> OptgradamsgradFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_frame_copy(s : OptgradamsgradFrame) -> OptgradamsgradFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_frame_fill(s : OptgradamsgradFrame, v : Double) -> OptgradamsgradFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_frame_min(s : OptgradamsgradFrame) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_frame_max(s : OptgradamsgradFrame) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_frame_to_string(s : OptgradamsgradFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_table_make(size : Int) -> OptgradamsgradTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_table_len(s : OptgradamsgradTable) -> Int { s.size }

pub fn opt_grad_amsgrad_table_get(s : OptgradamsgradTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_table_set(s : OptgradamsgradTable, i : Int, v : Double) -> OptgradamsgradTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_table_sum(s : OptgradamsgradTable) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_table_mean(s : OptgradamsgradTable) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_table_scale(s : OptgradamsgradTable, f : Double) -> OptgradamsgradTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_table_add(a : OptgradamsgradTable, b : OptgradamsgradTable) -> OptgradamsgradTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_table_copy(s : OptgradamsgradTable) -> OptgradamsgradTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_table_fill(s : OptgradamsgradTable, v : Double) -> OptgradamsgradTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_table_min(s : OptgradamsgradTable) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_table_max(s : OptgradamsgradTable) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_table_to_string(s : OptgradamsgradTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_graphn_make(size : Int) -> OptgradamsgradGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_graphn_len(s : OptgradamsgradGraphN) -> Int { s.size }

pub fn opt_grad_amsgrad_graphn_get(s : OptgradamsgradGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_graphn_set(s : OptgradamsgradGraphN, i : Int, v : Double) -> OptgradamsgradGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_graphn_sum(s : OptgradamsgradGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_graphn_mean(s : OptgradamsgradGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_graphn_scale(s : OptgradamsgradGraphN, f : Double) -> OptgradamsgradGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_graphn_add(a : OptgradamsgradGraphN, b : OptgradamsgradGraphN) -> OptgradamsgradGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_graphn_copy(s : OptgradamsgradGraphN) -> OptgradamsgradGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_graphn_fill(s : OptgradamsgradGraphN, v : Double) -> OptgradamsgradGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_graphn_min(s : OptgradamsgradGraphN) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_graphn_max(s : OptgradamsgradGraphN) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_graphn_to_string(s : OptgradamsgradGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_node_make(size : Int) -> OptgradamsgradNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_node_len(s : OptgradamsgradNode) -> Int { s.size }

pub fn opt_grad_amsgrad_node_get(s : OptgradamsgradNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_node_set(s : OptgradamsgradNode, i : Int, v : Double) -> OptgradamsgradNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_node_sum(s : OptgradamsgradNode) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_node_mean(s : OptgradamsgradNode) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_node_scale(s : OptgradamsgradNode, f : Double) -> OptgradamsgradNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_node_add(a : OptgradamsgradNode, b : OptgradamsgradNode) -> OptgradamsgradNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_node_copy(s : OptgradamsgradNode) -> OptgradamsgradNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_node_fill(s : OptgradamsgradNode, v : Double) -> OptgradamsgradNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_node_min(s : OptgradamsgradNode) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_node_max(s : OptgradamsgradNode) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_node_to_string(s : OptgradamsgradNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_edge_make(size : Int) -> OptgradamsgradEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_edge_len(s : OptgradamsgradEdge) -> Int { s.size }

pub fn opt_grad_amsgrad_edge_get(s : OptgradamsgradEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_edge_set(s : OptgradamsgradEdge, i : Int, v : Double) -> OptgradamsgradEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_edge_sum(s : OptgradamsgradEdge) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_edge_mean(s : OptgradamsgradEdge) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_edge_scale(s : OptgradamsgradEdge, f : Double) -> OptgradamsgradEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_edge_add(a : OptgradamsgradEdge, b : OptgradamsgradEdge) -> OptgradamsgradEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_edge_copy(s : OptgradamsgradEdge) -> OptgradamsgradEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_edge_fill(s : OptgradamsgradEdge, v : Double) -> OptgradamsgradEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_edge_min(s : OptgradamsgradEdge) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_edge_max(s : OptgradamsgradEdge) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_edge_to_string(s : OptgradamsgradEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_path_make(size : Int) -> OptgradamsgradPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_path_len(s : OptgradamsgradPath) -> Int { s.size }

pub fn opt_grad_amsgrad_path_get(s : OptgradamsgradPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_path_set(s : OptgradamsgradPath, i : Int, v : Double) -> OptgradamsgradPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_path_sum(s : OptgradamsgradPath) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_path_mean(s : OptgradamsgradPath) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_path_scale(s : OptgradamsgradPath, f : Double) -> OptgradamsgradPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_path_add(a : OptgradamsgradPath, b : OptgradamsgradPath) -> OptgradamsgradPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_path_copy(s : OptgradamsgradPath) -> OptgradamsgradPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_path_fill(s : OptgradamsgradPath, v : Double) -> OptgradamsgradPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_path_min(s : OptgradamsgradPath) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_path_max(s : OptgradamsgradPath) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_path_to_string(s : OptgradamsgradPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_cluster_make(size : Int) -> OptgradamsgradCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_cluster_len(s : OptgradamsgradCluster) -> Int { s.size }

pub fn opt_grad_amsgrad_cluster_get(s : OptgradamsgradCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_cluster_set(s : OptgradamsgradCluster, i : Int, v : Double) -> OptgradamsgradCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cluster_sum(s : OptgradamsgradCluster) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_cluster_mean(s : OptgradamsgradCluster) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_cluster_scale(s : OptgradamsgradCluster, f : Double) -> OptgradamsgradCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cluster_add(a : OptgradamsgradCluster, b : OptgradamsgradCluster) -> OptgradamsgradCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_cluster_copy(s : OptgradamsgradCluster) -> OptgradamsgradCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cluster_fill(s : OptgradamsgradCluster, v : Double) -> OptgradamsgradCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cluster_min(s : OptgradamsgradCluster) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_cluster_max(s : OptgradamsgradCluster) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_cluster_to_string(s : OptgradamsgradCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_model_make(size : Int) -> OptgradamsgradModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_model_len(s : OptgradamsgradModel) -> Int { s.size }

pub fn opt_grad_amsgrad_model_get(s : OptgradamsgradModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_model_set(s : OptgradamsgradModel, i : Int, v : Double) -> OptgradamsgradModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_model_sum(s : OptgradamsgradModel) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_model_mean(s : OptgradamsgradModel) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_model_scale(s : OptgradamsgradModel, f : Double) -> OptgradamsgradModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_model_add(a : OptgradamsgradModel, b : OptgradamsgradModel) -> OptgradamsgradModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_model_copy(s : OptgradamsgradModel) -> OptgradamsgradModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_model_fill(s : OptgradamsgradModel, v : Double) -> OptgradamsgradModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_model_min(s : OptgradamsgradModel) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_model_max(s : OptgradamsgradModel) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_model_to_string(s : OptgradamsgradModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_layer_make(size : Int) -> OptgradamsgradLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_layer_len(s : OptgradamsgradLayer) -> Int { s.size }

pub fn opt_grad_amsgrad_layer_get(s : OptgradamsgradLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_layer_set(s : OptgradamsgradLayer, i : Int, v : Double) -> OptgradamsgradLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_layer_sum(s : OptgradamsgradLayer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_layer_mean(s : OptgradamsgradLayer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_layer_scale(s : OptgradamsgradLayer, f : Double) -> OptgradamsgradLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_layer_add(a : OptgradamsgradLayer, b : OptgradamsgradLayer) -> OptgradamsgradLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_layer_copy(s : OptgradamsgradLayer) -> OptgradamsgradLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_layer_fill(s : OptgradamsgradLayer, v : Double) -> OptgradamsgradLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_layer_min(s : OptgradamsgradLayer) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_layer_max(s : OptgradamsgradLayer) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_layer_to_string(s : OptgradamsgradLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_buffer_make(size : Int) -> OptgradamsgradBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_buffer_len(s : OptgradamsgradBuffer) -> Int { s.size }

pub fn opt_grad_amsgrad_buffer_get(s : OptgradamsgradBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_buffer_set(s : OptgradamsgradBuffer, i : Int, v : Double) -> OptgradamsgradBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_buffer_sum(s : OptgradamsgradBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_buffer_mean(s : OptgradamsgradBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_buffer_scale(s : OptgradamsgradBuffer, f : Double) -> OptgradamsgradBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_buffer_add(a : OptgradamsgradBuffer, b : OptgradamsgradBuffer) -> OptgradamsgradBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_buffer_copy(s : OptgradamsgradBuffer) -> OptgradamsgradBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_buffer_fill(s : OptgradamsgradBuffer, v : Double) -> OptgradamsgradBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_buffer_min(s : OptgradamsgradBuffer) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_buffer_max(s : OptgradamsgradBuffer) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_buffer_to_string(s : OptgradamsgradBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_cursor_make(size : Int) -> OptgradamsgradCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_cursor_len(s : OptgradamsgradCursor) -> Int { s.size }

pub fn opt_grad_amsgrad_cursor_get(s : OptgradamsgradCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_cursor_set(s : OptgradamsgradCursor, i : Int, v : Double) -> OptgradamsgradCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cursor_sum(s : OptgradamsgradCursor) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_cursor_mean(s : OptgradamsgradCursor) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_cursor_scale(s : OptgradamsgradCursor, f : Double) -> OptgradamsgradCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cursor_add(a : OptgradamsgradCursor, b : OptgradamsgradCursor) -> OptgradamsgradCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_cursor_copy(s : OptgradamsgradCursor) -> OptgradamsgradCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cursor_fill(s : OptgradamsgradCursor, v : Double) -> OptgradamsgradCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cursor_min(s : OptgradamsgradCursor) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_cursor_max(s : OptgradamsgradCursor) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_cursor_to_string(s : OptgradamsgradCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_view_make(size : Int) -> OptgradamsgradView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_view_len(s : OptgradamsgradView) -> Int { s.size }

pub fn opt_grad_amsgrad_view_get(s : OptgradamsgradView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_view_set(s : OptgradamsgradView, i : Int, v : Double) -> OptgradamsgradView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_view_sum(s : OptgradamsgradView) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_view_mean(s : OptgradamsgradView) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_view_scale(s : OptgradamsgradView, f : Double) -> OptgradamsgradView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_view_add(a : OptgradamsgradView, b : OptgradamsgradView) -> OptgradamsgradView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_view_copy(s : OptgradamsgradView) -> OptgradamsgradView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_view_fill(s : OptgradamsgradView, v : Double) -> OptgradamsgradView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_view_min(s : OptgradamsgradView) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_view_max(s : OptgradamsgradView) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_view_to_string(s : OptgradamsgradView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_range_make(size : Int) -> OptgradamsgradRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_range_len(s : OptgradamsgradRange) -> Int { s.size }

pub fn opt_grad_amsgrad_range_get(s : OptgradamsgradRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_range_set(s : OptgradamsgradRange, i : Int, v : Double) -> OptgradamsgradRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_range_sum(s : OptgradamsgradRange) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_range_mean(s : OptgradamsgradRange) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_range_scale(s : OptgradamsgradRange, f : Double) -> OptgradamsgradRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_range_add(a : OptgradamsgradRange, b : OptgradamsgradRange) -> OptgradamsgradRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_range_copy(s : OptgradamsgradRange) -> OptgradamsgradRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_range_fill(s : OptgradamsgradRange, v : Double) -> OptgradamsgradRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_range_min(s : OptgradamsgradRange) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_range_max(s : OptgradamsgradRange) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_range_to_string(s : OptgradamsgradRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_slice_make(size : Int) -> OptgradamsgradSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_slice_len(s : OptgradamsgradSlice) -> Int { s.size }

pub fn opt_grad_amsgrad_slice_get(s : OptgradamsgradSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_slice_set(s : OptgradamsgradSlice, i : Int, v : Double) -> OptgradamsgradSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_slice_sum(s : OptgradamsgradSlice) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_slice_mean(s : OptgradamsgradSlice) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_slice_scale(s : OptgradamsgradSlice, f : Double) -> OptgradamsgradSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_slice_add(a : OptgradamsgradSlice, b : OptgradamsgradSlice) -> OptgradamsgradSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_slice_copy(s : OptgradamsgradSlice) -> OptgradamsgradSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_slice_fill(s : OptgradamsgradSlice, v : Double) -> OptgradamsgradSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_slice_min(s : OptgradamsgradSlice) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_slice_max(s : OptgradamsgradSlice) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_slice_to_string(s : OptgradamsgradSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

