///===
/// extcore/opt_grad_nesterov

pub(all) struct OptgradnesterovPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_nesterov_make_point(x : Double, y : Double) -> OptgradnesterovPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_nesterov_make_point3(x : Double, y : Double, z : Double) -> OptgradnesterovPoint {
  { x, y, z, label: 0 }
}

pub fn OptgradnesterovPoint::x(self : OptgradnesterovPoint) -> Double { self.x }

pub fn OptgradnesterovPoint::y(self : OptgradnesterovPoint) -> Double { self.y }

pub fn OptgradnesterovPoint::z(self : OptgradnesterovPoint) -> Double { self.z }

pub fn OptgradnesterovPoint::label(self : OptgradnesterovPoint) -> Int { self.label }

pub fn OptgradnesterovPoint::dist(self : OptgradnesterovPoint, other : OptgradnesterovPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptgradnesterovPoint::add(self : OptgradnesterovPoint, other : OptgradnesterovPoint) -> OptgradnesterovPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptgradnesterovPoint::sub(self : OptgradnesterovPoint, other : OptgradnesterovPoint) -> OptgradnesterovPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptgradnesterovPoint::scale(self : OptgradnesterovPoint, s : Double) -> OptgradnesterovPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptgradnesterovPoint::dot(self : OptgradnesterovPoint, other : OptgradnesterovPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptgradnesterovPoint::cross(self : OptgradnesterovPoint, other : OptgradnesterovPoint) -> OptgradnesterovPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptgradnesterovPoint::norm(self : OptgradnesterovPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptgradnesterovPoint::normalize(self : OptgradnesterovPoint) -> OptgradnesterovPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradnesterovPoint::negate(self : OptgradnesterovPoint) -> OptgradnesterovPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptgradnesterovPoint::mid(self : OptgradnesterovPoint, other : OptgradnesterovPoint) -> OptgradnesterovPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptgradnesterovPoint::lerp(self : OptgradnesterovPoint, other : OptgradnesterovPoint, t : Double) -> OptgradnesterovPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptgradnesterovPoint::to_string(self : OptgradnesterovPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptgradnesterovSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_nesterov_make_series(vals : Array[Double], name : String) -> OptgradnesterovSeries {
  { vals, name, meta: 0 }
}

pub fn OptgradnesterovSeries::len(self : OptgradnesterovSeries) -> Int { self.vals.length() }

pub fn OptgradnesterovSeries::sum(self : OptgradnesterovSeries) -> Double { @_common.sum(self.vals) }

pub fn OptgradnesterovSeries::mean(self : OptgradnesterovSeries) -> Double { @_common.mean(self.vals) }

pub fn OptgradnesterovSeries::min(self : OptgradnesterovSeries) -> Double { @_common.min(self.vals) }

pub fn OptgradnesterovSeries::max(self : OptgradnesterovSeries) -> Double { @_common.max(self.vals) }

pub fn OptgradnesterovSeries::range(self : OptgradnesterovSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptgradnesterovSeries::variance(self : OptgradnesterovSeries) -> Double { @_common.variance(self.vals) }

pub fn OptgradnesterovSeries::std(self : OptgradnesterovSeries) -> Double { @_common.std(self.vals) }

pub fn OptgradnesterovSeries::median(self : OptgradnesterovSeries) -> Double { @_common.median(self.vals) }

pub fn OptgradnesterovSeries::scale(self : OptgradnesterovSeries, f : Double) -> OptgradnesterovSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptgradnesterovSeries::add(self : OptgradnesterovSeries, other : OptgradnesterovSeries) -> OptgradnesterovSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptgradnesterovSeries::sub(self : OptgradnesterovSeries, other : OptgradnesterovSeries) -> OptgradnesterovSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptgradnesterovSeries::normalize(self : OptgradnesterovSeries) -> OptgradnesterovSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptgradnesterovSeries::cumsum(self : OptgradnesterovSeries) -> OptgradnesterovSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptgradnesterovSeries::to_string(self : OptgradnesterovSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradnesterovMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_nesterov_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradnesterovMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_nesterov_matrix_identity(n : Int) -> OptgradnesterovMatrix {
  let m = opt_grad_nesterov_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptgradnesterovMatrix::get(self : OptgradnesterovMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptgradnesterovMatrix::transpose(self : OptgradnesterovMatrix) -> OptgradnesterovMatrix {
  let result = opt_grad_nesterov_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptgradnesterovMatrix::add(self : OptgradnesterovMatrix, other : OptgradnesterovMatrix) -> OptgradnesterovMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_grad_nesterov_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptgradnesterovMatrix::scale(self : OptgradnesterovMatrix, s : Double) -> OptgradnesterovMatrix {
  let result = opt_grad_nesterov_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptgradnesterovMatrix::multiply(self : OptgradnesterovMatrix, other : OptgradnesterovMatrix) -> OptgradnesterovMatrix {
  if self.cols != other.rows { return opt_grad_nesterov_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_grad_nesterov_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptgradnesterovMatrix::trace(self : OptgradnesterovMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptgradnesterovMatrix::det(self : OptgradnesterovMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptgradnesterovMatrix::norm(self : OptgradnesterovMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptgradnesterovMatrix::to_string(self : OptgradnesterovMatrix) -> String {
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

pub(all) struct OptgradnesterovVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_nesterov_make_vector(comps : Array[Double]) -> OptgradnesterovVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_nesterov_vector_zero(dim : Int) -> OptgradnesterovVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptgradnesterovVector::add(self : OptgradnesterovVector, other : OptgradnesterovVector) -> OptgradnesterovVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradnesterovVector::sub(self : OptgradnesterovVector, other : OptgradnesterovVector) -> OptgradnesterovVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradnesterovVector::scale(self : OptgradnesterovVector, s : Double) -> OptgradnesterovVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptgradnesterovVector::dot(self : OptgradnesterovVector, other : OptgradnesterovVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptgradnesterovVector::norm(self : OptgradnesterovVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptgradnesterovVector::normalize(self : OptgradnesterovVector) -> OptgradnesterovVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradnesterovVector::dist(self : OptgradnesterovVector, other : OptgradnesterovVector) -> Double {
  self.sub(other).norm()
}

pub fn OptgradnesterovVector::to_string(self : OptgradnesterovVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_nesterov_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_grad_nesterov_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_grad_nesterov_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_grad_nesterov_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_grad_nesterov_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_grad_nesterov_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_grad_nesterov_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_grad_nesterov_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_grad_nesterov_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_grad_nesterov_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_grad_nesterov_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_grad_nesterov_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_grad_nesterov_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_grad_nesterov_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_grad_nesterov_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_grad_nesterov_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_grad_nesterov_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_grad_nesterov_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_grad_nesterov_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_grad_nesterov_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_grad_nesterov_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_grad_nesterov_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_grad_nesterov_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_grad_nesterov_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_grad_nesterov_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_grad_nesterov_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_grad_nesterov_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_grad_nesterov_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_grad_nesterov_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptgradnesterovFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_frame_make(size : Int) -> OptgradnesterovFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_frame_len(s : OptgradnesterovFrame) -> Int { s.size }

pub fn opt_grad_nesterov_frame_get(s : OptgradnesterovFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_frame_set(s : OptgradnesterovFrame, i : Int, v : Double) -> OptgradnesterovFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_frame_sum(s : OptgradnesterovFrame) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nesterov_frame_mean(s : OptgradnesterovFrame) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nesterov_frame_scale(s : OptgradnesterovFrame, f : Double) -> OptgradnesterovFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_frame_add(a : OptgradnesterovFrame, b : OptgradnesterovFrame) -> OptgradnesterovFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nesterov_frame_copy(s : OptgradnesterovFrame) -> OptgradnesterovFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_frame_fill(s : OptgradnesterovFrame, v : Double) -> OptgradnesterovFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_frame_min(s : OptgradnesterovFrame) -> Double { @_common.min(s.data) }

pub fn opt_grad_nesterov_frame_max(s : OptgradnesterovFrame) -> Double { @_common.max(s.data) }

pub fn opt_grad_nesterov_frame_to_string(s : OptgradnesterovFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_table_make(size : Int) -> OptgradnesterovTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_table_len(s : OptgradnesterovTable) -> Int { s.size }

pub fn opt_grad_nesterov_table_get(s : OptgradnesterovTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_table_set(s : OptgradnesterovTable, i : Int, v : Double) -> OptgradnesterovTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_table_sum(s : OptgradnesterovTable) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nesterov_table_mean(s : OptgradnesterovTable) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nesterov_table_scale(s : OptgradnesterovTable, f : Double) -> OptgradnesterovTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_table_add(a : OptgradnesterovTable, b : OptgradnesterovTable) -> OptgradnesterovTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nesterov_table_copy(s : OptgradnesterovTable) -> OptgradnesterovTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_table_fill(s : OptgradnesterovTable, v : Double) -> OptgradnesterovTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_table_min(s : OptgradnesterovTable) -> Double { @_common.min(s.data) }

pub fn opt_grad_nesterov_table_max(s : OptgradnesterovTable) -> Double { @_common.max(s.data) }

pub fn opt_grad_nesterov_table_to_string(s : OptgradnesterovTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_graphn_make(size : Int) -> OptgradnesterovGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_graphn_len(s : OptgradnesterovGraphN) -> Int { s.size }

pub fn opt_grad_nesterov_graphn_get(s : OptgradnesterovGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_graphn_set(s : OptgradnesterovGraphN, i : Int, v : Double) -> OptgradnesterovGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_graphn_sum(s : OptgradnesterovGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nesterov_graphn_mean(s : OptgradnesterovGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nesterov_graphn_scale(s : OptgradnesterovGraphN, f : Double) -> OptgradnesterovGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_graphn_add(a : OptgradnesterovGraphN, b : OptgradnesterovGraphN) -> OptgradnesterovGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nesterov_graphn_copy(s : OptgradnesterovGraphN) -> OptgradnesterovGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_graphn_fill(s : OptgradnesterovGraphN, v : Double) -> OptgradnesterovGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_graphn_min(s : OptgradnesterovGraphN) -> Double { @_common.min(s.data) }

pub fn opt_grad_nesterov_graphn_max(s : OptgradnesterovGraphN) -> Double { @_common.max(s.data) }

pub fn opt_grad_nesterov_graphn_to_string(s : OptgradnesterovGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_node_make(size : Int) -> OptgradnesterovNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_node_len(s : OptgradnesterovNode) -> Int { s.size }

pub fn opt_grad_nesterov_node_get(s : OptgradnesterovNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_node_set(s : OptgradnesterovNode, i : Int, v : Double) -> OptgradnesterovNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_node_sum(s : OptgradnesterovNode) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nesterov_node_mean(s : OptgradnesterovNode) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nesterov_node_scale(s : OptgradnesterovNode, f : Double) -> OptgradnesterovNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_node_add(a : OptgradnesterovNode, b : OptgradnesterovNode) -> OptgradnesterovNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nesterov_node_copy(s : OptgradnesterovNode) -> OptgradnesterovNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_node_fill(s : OptgradnesterovNode, v : Double) -> OptgradnesterovNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_node_min(s : OptgradnesterovNode) -> Double { @_common.min(s.data) }

pub fn opt_grad_nesterov_node_max(s : OptgradnesterovNode) -> Double { @_common.max(s.data) }

pub fn opt_grad_nesterov_node_to_string(s : OptgradnesterovNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_edge_make(size : Int) -> OptgradnesterovEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_edge_len(s : OptgradnesterovEdge) -> Int { s.size }

pub fn opt_grad_nesterov_edge_get(s : OptgradnesterovEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_edge_set(s : OptgradnesterovEdge, i : Int, v : Double) -> OptgradnesterovEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_edge_sum(s : OptgradnesterovEdge) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nesterov_edge_mean(s : OptgradnesterovEdge) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nesterov_edge_scale(s : OptgradnesterovEdge, f : Double) -> OptgradnesterovEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_edge_add(a : OptgradnesterovEdge, b : OptgradnesterovEdge) -> OptgradnesterovEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nesterov_edge_copy(s : OptgradnesterovEdge) -> OptgradnesterovEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_edge_fill(s : OptgradnesterovEdge, v : Double) -> OptgradnesterovEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_edge_min(s : OptgradnesterovEdge) -> Double { @_common.min(s.data) }

pub fn opt_grad_nesterov_edge_max(s : OptgradnesterovEdge) -> Double { @_common.max(s.data) }

pub fn opt_grad_nesterov_edge_to_string(s : OptgradnesterovEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_path_make(size : Int) -> OptgradnesterovPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_path_len(s : OptgradnesterovPath) -> Int { s.size }

pub fn opt_grad_nesterov_path_get(s : OptgradnesterovPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_path_set(s : OptgradnesterovPath, i : Int, v : Double) -> OptgradnesterovPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_path_sum(s : OptgradnesterovPath) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nesterov_path_mean(s : OptgradnesterovPath) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nesterov_path_scale(s : OptgradnesterovPath, f : Double) -> OptgradnesterovPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_path_add(a : OptgradnesterovPath, b : OptgradnesterovPath) -> OptgradnesterovPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nesterov_path_copy(s : OptgradnesterovPath) -> OptgradnesterovPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_path_fill(s : OptgradnesterovPath, v : Double) -> OptgradnesterovPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_path_min(s : OptgradnesterovPath) -> Double { @_common.min(s.data) }

pub fn opt_grad_nesterov_path_max(s : OptgradnesterovPath) -> Double { @_common.max(s.data) }

pub fn opt_grad_nesterov_path_to_string(s : OptgradnesterovPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_cluster_make(size : Int) -> OptgradnesterovCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_cluster_len(s : OptgradnesterovCluster) -> Int { s.size }

pub fn opt_grad_nesterov_cluster_get(s : OptgradnesterovCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_cluster_set(s : OptgradnesterovCluster, i : Int, v : Double) -> OptgradnesterovCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_cluster_sum(s : OptgradnesterovCluster) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nesterov_cluster_mean(s : OptgradnesterovCluster) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nesterov_cluster_scale(s : OptgradnesterovCluster, f : Double) -> OptgradnesterovCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_cluster_add(a : OptgradnesterovCluster, b : OptgradnesterovCluster) -> OptgradnesterovCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nesterov_cluster_copy(s : OptgradnesterovCluster) -> OptgradnesterovCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_cluster_fill(s : OptgradnesterovCluster, v : Double) -> OptgradnesterovCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_cluster_min(s : OptgradnesterovCluster) -> Double { @_common.min(s.data) }

pub fn opt_grad_nesterov_cluster_max(s : OptgradnesterovCluster) -> Double { @_common.max(s.data) }

pub fn opt_grad_nesterov_cluster_to_string(s : OptgradnesterovCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_model_make(size : Int) -> OptgradnesterovModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_model_len(s : OptgradnesterovModel) -> Int { s.size }

pub fn opt_grad_nesterov_model_get(s : OptgradnesterovModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_model_set(s : OptgradnesterovModel, i : Int, v : Double) -> OptgradnesterovModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_model_sum(s : OptgradnesterovModel) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nesterov_model_mean(s : OptgradnesterovModel) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nesterov_model_scale(s : OptgradnesterovModel, f : Double) -> OptgradnesterovModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_model_add(a : OptgradnesterovModel, b : OptgradnesterovModel) -> OptgradnesterovModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nesterov_model_copy(s : OptgradnesterovModel) -> OptgradnesterovModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_model_fill(s : OptgradnesterovModel, v : Double) -> OptgradnesterovModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_model_min(s : OptgradnesterovModel) -> Double { @_common.min(s.data) }

pub fn opt_grad_nesterov_model_max(s : OptgradnesterovModel) -> Double { @_common.max(s.data) }

pub fn opt_grad_nesterov_model_to_string(s : OptgradnesterovModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_layer_make(size : Int) -> OptgradnesterovLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_layer_len(s : OptgradnesterovLayer) -> Int { s.size }

pub fn opt_grad_nesterov_layer_get(s : OptgradnesterovLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_layer_set(s : OptgradnesterovLayer, i : Int, v : Double) -> OptgradnesterovLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_layer_sum(s : OptgradnesterovLayer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nesterov_layer_mean(s : OptgradnesterovLayer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nesterov_layer_scale(s : OptgradnesterovLayer, f : Double) -> OptgradnesterovLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_layer_add(a : OptgradnesterovLayer, b : OptgradnesterovLayer) -> OptgradnesterovLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nesterov_layer_copy(s : OptgradnesterovLayer) -> OptgradnesterovLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_layer_fill(s : OptgradnesterovLayer, v : Double) -> OptgradnesterovLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_layer_min(s : OptgradnesterovLayer) -> Double { @_common.min(s.data) }

pub fn opt_grad_nesterov_layer_max(s : OptgradnesterovLayer) -> Double { @_common.max(s.data) }

pub fn opt_grad_nesterov_layer_to_string(s : OptgradnesterovLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_buffer_make(size : Int) -> OptgradnesterovBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_buffer_len(s : OptgradnesterovBuffer) -> Int { s.size }

pub fn opt_grad_nesterov_buffer_get(s : OptgradnesterovBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_buffer_set(s : OptgradnesterovBuffer, i : Int, v : Double) -> OptgradnesterovBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_buffer_sum(s : OptgradnesterovBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nesterov_buffer_mean(s : OptgradnesterovBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nesterov_buffer_scale(s : OptgradnesterovBuffer, f : Double) -> OptgradnesterovBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_buffer_add(a : OptgradnesterovBuffer, b : OptgradnesterovBuffer) -> OptgradnesterovBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nesterov_buffer_copy(s : OptgradnesterovBuffer) -> OptgradnesterovBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_buffer_fill(s : OptgradnesterovBuffer, v : Double) -> OptgradnesterovBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_buffer_min(s : OptgradnesterovBuffer) -> Double { @_common.min(s.data) }

pub fn opt_grad_nesterov_buffer_max(s : OptgradnesterovBuffer) -> Double { @_common.max(s.data) }

pub fn opt_grad_nesterov_buffer_to_string(s : OptgradnesterovBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_cursor_make(size : Int) -> OptgradnesterovCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_cursor_len(s : OptgradnesterovCursor) -> Int { s.size }

pub fn opt_grad_nesterov_cursor_get(s : OptgradnesterovCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_cursor_set(s : OptgradnesterovCursor, i : Int, v : Double) -> OptgradnesterovCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_cursor_sum(s : OptgradnesterovCursor) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nesterov_cursor_mean(s : OptgradnesterovCursor) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nesterov_cursor_scale(s : OptgradnesterovCursor, f : Double) -> OptgradnesterovCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_cursor_add(a : OptgradnesterovCursor, b : OptgradnesterovCursor) -> OptgradnesterovCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nesterov_cursor_copy(s : OptgradnesterovCursor) -> OptgradnesterovCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_cursor_fill(s : OptgradnesterovCursor, v : Double) -> OptgradnesterovCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_cursor_min(s : OptgradnesterovCursor) -> Double { @_common.min(s.data) }

pub fn opt_grad_nesterov_cursor_max(s : OptgradnesterovCursor) -> Double { @_common.max(s.data) }

pub fn opt_grad_nesterov_cursor_to_string(s : OptgradnesterovCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_view_make(size : Int) -> OptgradnesterovView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_view_len(s : OptgradnesterovView) -> Int { s.size }

pub fn opt_grad_nesterov_view_get(s : OptgradnesterovView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_view_set(s : OptgradnesterovView, i : Int, v : Double) -> OptgradnesterovView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_view_sum(s : OptgradnesterovView) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nesterov_view_mean(s : OptgradnesterovView) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nesterov_view_scale(s : OptgradnesterovView, f : Double) -> OptgradnesterovView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_view_add(a : OptgradnesterovView, b : OptgradnesterovView) -> OptgradnesterovView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nesterov_view_copy(s : OptgradnesterovView) -> OptgradnesterovView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_view_fill(s : OptgradnesterovView, v : Double) -> OptgradnesterovView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_view_min(s : OptgradnesterovView) -> Double { @_common.min(s.data) }

pub fn opt_grad_nesterov_view_max(s : OptgradnesterovView) -> Double { @_common.max(s.data) }

pub fn opt_grad_nesterov_view_to_string(s : OptgradnesterovView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_range_make(size : Int) -> OptgradnesterovRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_range_len(s : OptgradnesterovRange) -> Int { s.size }

pub fn opt_grad_nesterov_range_get(s : OptgradnesterovRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_range_set(s : OptgradnesterovRange, i : Int, v : Double) -> OptgradnesterovRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_range_sum(s : OptgradnesterovRange) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nesterov_range_mean(s : OptgradnesterovRange) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nesterov_range_scale(s : OptgradnesterovRange, f : Double) -> OptgradnesterovRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_range_add(a : OptgradnesterovRange, b : OptgradnesterovRange) -> OptgradnesterovRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nesterov_range_copy(s : OptgradnesterovRange) -> OptgradnesterovRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_range_fill(s : OptgradnesterovRange, v : Double) -> OptgradnesterovRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_range_min(s : OptgradnesterovRange) -> Double { @_common.min(s.data) }

pub fn opt_grad_nesterov_range_max(s : OptgradnesterovRange) -> Double { @_common.max(s.data) }

pub fn opt_grad_nesterov_range_to_string(s : OptgradnesterovRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_slice_make(size : Int) -> OptgradnesterovSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_slice_len(s : OptgradnesterovSlice) -> Int { s.size }

pub fn opt_grad_nesterov_slice_get(s : OptgradnesterovSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_slice_set(s : OptgradnesterovSlice, i : Int, v : Double) -> OptgradnesterovSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_slice_sum(s : OptgradnesterovSlice) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nesterov_slice_mean(s : OptgradnesterovSlice) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nesterov_slice_scale(s : OptgradnesterovSlice, f : Double) -> OptgradnesterovSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_slice_add(a : OptgradnesterovSlice, b : OptgradnesterovSlice) -> OptgradnesterovSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nesterov_slice_copy(s : OptgradnesterovSlice) -> OptgradnesterovSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_slice_fill(s : OptgradnesterovSlice, v : Double) -> OptgradnesterovSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nesterov_slice_min(s : OptgradnesterovSlice) -> Double { @_common.min(s.data) }

pub fn opt_grad_nesterov_slice_max(s : OptgradnesterovSlice) -> Double { @_common.max(s.data) }

pub fn opt_grad_nesterov_slice_to_string(s : OptgradnesterovSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

