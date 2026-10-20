///===
/// extcore/opt_grad_rmsprop

pub(all) struct OptgradrmspropPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_rmsprop_make_point(x : Double, y : Double) -> OptgradrmspropPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_rmsprop_make_point3(x : Double, y : Double, z : Double) -> OptgradrmspropPoint {
  { x, y, z, label: 0 }
}

pub fn OptgradrmspropPoint::x(self : OptgradrmspropPoint) -> Double { self.x }

pub fn OptgradrmspropPoint::y(self : OptgradrmspropPoint) -> Double { self.y }

pub fn OptgradrmspropPoint::z(self : OptgradrmspropPoint) -> Double { self.z }

pub fn OptgradrmspropPoint::label(self : OptgradrmspropPoint) -> Int { self.label }

pub fn OptgradrmspropPoint::dist(self : OptgradrmspropPoint, other : OptgradrmspropPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptgradrmspropPoint::add(self : OptgradrmspropPoint, other : OptgradrmspropPoint) -> OptgradrmspropPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptgradrmspropPoint::sub(self : OptgradrmspropPoint, other : OptgradrmspropPoint) -> OptgradrmspropPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptgradrmspropPoint::scale(self : OptgradrmspropPoint, s : Double) -> OptgradrmspropPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptgradrmspropPoint::dot(self : OptgradrmspropPoint, other : OptgradrmspropPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptgradrmspropPoint::cross(self : OptgradrmspropPoint, other : OptgradrmspropPoint) -> OptgradrmspropPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptgradrmspropPoint::norm(self : OptgradrmspropPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptgradrmspropPoint::normalize(self : OptgradrmspropPoint) -> OptgradrmspropPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradrmspropPoint::negate(self : OptgradrmspropPoint) -> OptgradrmspropPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptgradrmspropPoint::mid(self : OptgradrmspropPoint, other : OptgradrmspropPoint) -> OptgradrmspropPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptgradrmspropPoint::lerp(self : OptgradrmspropPoint, other : OptgradrmspropPoint, t : Double) -> OptgradrmspropPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptgradrmspropPoint::to_string(self : OptgradrmspropPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptgradrmspropSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_rmsprop_make_series(vals : Array[Double], name : String) -> OptgradrmspropSeries {
  { vals, name, meta: 0 }
}

pub fn OptgradrmspropSeries::len(self : OptgradrmspropSeries) -> Int { self.vals.length() }

pub fn OptgradrmspropSeries::sum(self : OptgradrmspropSeries) -> Double { @_common.sum(self.vals) }

pub fn OptgradrmspropSeries::mean(self : OptgradrmspropSeries) -> Double { @_common.mean(self.vals) }

pub fn OptgradrmspropSeries::min(self : OptgradrmspropSeries) -> Double { @_common.min(self.vals) }

pub fn OptgradrmspropSeries::max(self : OptgradrmspropSeries) -> Double { @_common.max(self.vals) }

pub fn OptgradrmspropSeries::range(self : OptgradrmspropSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptgradrmspropSeries::variance(self : OptgradrmspropSeries) -> Double { @_common.variance(self.vals) }

pub fn OptgradrmspropSeries::std(self : OptgradrmspropSeries) -> Double { @_common.std(self.vals) }

pub fn OptgradrmspropSeries::median(self : OptgradrmspropSeries) -> Double { @_common.median(self.vals) }

pub fn OptgradrmspropSeries::scale(self : OptgradrmspropSeries, f : Double) -> OptgradrmspropSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptgradrmspropSeries::add(self : OptgradrmspropSeries, other : OptgradrmspropSeries) -> OptgradrmspropSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptgradrmspropSeries::sub(self : OptgradrmspropSeries, other : OptgradrmspropSeries) -> OptgradrmspropSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptgradrmspropSeries::normalize(self : OptgradrmspropSeries) -> OptgradrmspropSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptgradrmspropSeries::cumsum(self : OptgradrmspropSeries) -> OptgradrmspropSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptgradrmspropSeries::to_string(self : OptgradrmspropSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradrmspropMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_rmsprop_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradrmspropMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_rmsprop_matrix_identity(n : Int) -> OptgradrmspropMatrix {
  let m = opt_grad_rmsprop_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptgradrmspropMatrix::get(self : OptgradrmspropMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptgradrmspropMatrix::transpose(self : OptgradrmspropMatrix) -> OptgradrmspropMatrix {
  let result = opt_grad_rmsprop_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptgradrmspropMatrix::add(self : OptgradrmspropMatrix, other : OptgradrmspropMatrix) -> OptgradrmspropMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_grad_rmsprop_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptgradrmspropMatrix::scale(self : OptgradrmspropMatrix, s : Double) -> OptgradrmspropMatrix {
  let result = opt_grad_rmsprop_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptgradrmspropMatrix::multiply(self : OptgradrmspropMatrix, other : OptgradrmspropMatrix) -> OptgradrmspropMatrix {
  if self.cols != other.rows { return opt_grad_rmsprop_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_grad_rmsprop_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptgradrmspropMatrix::trace(self : OptgradrmspropMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptgradrmspropMatrix::det(self : OptgradrmspropMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptgradrmspropMatrix::norm(self : OptgradrmspropMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptgradrmspropMatrix::to_string(self : OptgradrmspropMatrix) -> String {
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

pub(all) struct OptgradrmspropVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_rmsprop_make_vector(comps : Array[Double]) -> OptgradrmspropVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_rmsprop_vector_zero(dim : Int) -> OptgradrmspropVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptgradrmspropVector::add(self : OptgradrmspropVector, other : OptgradrmspropVector) -> OptgradrmspropVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradrmspropVector::sub(self : OptgradrmspropVector, other : OptgradrmspropVector) -> OptgradrmspropVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradrmspropVector::scale(self : OptgradrmspropVector, s : Double) -> OptgradrmspropVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptgradrmspropVector::dot(self : OptgradrmspropVector, other : OptgradrmspropVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptgradrmspropVector::norm(self : OptgradrmspropVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptgradrmspropVector::normalize(self : OptgradrmspropVector) -> OptgradrmspropVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradrmspropVector::dist(self : OptgradrmspropVector, other : OptgradrmspropVector) -> Double {
  self.sub(other).norm()
}

pub fn OptgradrmspropVector::to_string(self : OptgradrmspropVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_rmsprop_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_grad_rmsprop_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_grad_rmsprop_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_grad_rmsprop_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_grad_rmsprop_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_grad_rmsprop_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_grad_rmsprop_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_grad_rmsprop_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_grad_rmsprop_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_grad_rmsprop_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_grad_rmsprop_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_grad_rmsprop_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_grad_rmsprop_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_grad_rmsprop_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_grad_rmsprop_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_grad_rmsprop_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_grad_rmsprop_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_grad_rmsprop_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_grad_rmsprop_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_grad_rmsprop_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_grad_rmsprop_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_grad_rmsprop_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_grad_rmsprop_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_grad_rmsprop_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_grad_rmsprop_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_grad_rmsprop_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_grad_rmsprop_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_grad_rmsprop_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_grad_rmsprop_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptgradrmspropFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_frame_make(size : Int) -> OptgradrmspropFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_frame_len(s : OptgradrmspropFrame) -> Int { s.size }

pub fn opt_grad_rmsprop_frame_get(s : OptgradrmspropFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_frame_set(s : OptgradrmspropFrame, i : Int, v : Double) -> OptgradrmspropFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_frame_sum(s : OptgradrmspropFrame) -> Double { @_common.sum(s.data) }

pub fn opt_grad_rmsprop_frame_mean(s : OptgradrmspropFrame) -> Double { @_common.mean(s.data) }

pub fn opt_grad_rmsprop_frame_scale(s : OptgradrmspropFrame, f : Double) -> OptgradrmspropFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_frame_add(a : OptgradrmspropFrame, b : OptgradrmspropFrame) -> OptgradrmspropFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_rmsprop_frame_copy(s : OptgradrmspropFrame) -> OptgradrmspropFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_frame_fill(s : OptgradrmspropFrame, v : Double) -> OptgradrmspropFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_frame_min(s : OptgradrmspropFrame) -> Double { @_common.min(s.data) }

pub fn opt_grad_rmsprop_frame_max(s : OptgradrmspropFrame) -> Double { @_common.max(s.data) }

pub fn opt_grad_rmsprop_frame_to_string(s : OptgradrmspropFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_table_make(size : Int) -> OptgradrmspropTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_table_len(s : OptgradrmspropTable) -> Int { s.size }

pub fn opt_grad_rmsprop_table_get(s : OptgradrmspropTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_table_set(s : OptgradrmspropTable, i : Int, v : Double) -> OptgradrmspropTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_table_sum(s : OptgradrmspropTable) -> Double { @_common.sum(s.data) }

pub fn opt_grad_rmsprop_table_mean(s : OptgradrmspropTable) -> Double { @_common.mean(s.data) }

pub fn opt_grad_rmsprop_table_scale(s : OptgradrmspropTable, f : Double) -> OptgradrmspropTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_table_add(a : OptgradrmspropTable, b : OptgradrmspropTable) -> OptgradrmspropTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_rmsprop_table_copy(s : OptgradrmspropTable) -> OptgradrmspropTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_table_fill(s : OptgradrmspropTable, v : Double) -> OptgradrmspropTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_table_min(s : OptgradrmspropTable) -> Double { @_common.min(s.data) }

pub fn opt_grad_rmsprop_table_max(s : OptgradrmspropTable) -> Double { @_common.max(s.data) }

pub fn opt_grad_rmsprop_table_to_string(s : OptgradrmspropTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_graphn_make(size : Int) -> OptgradrmspropGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_graphn_len(s : OptgradrmspropGraphN) -> Int { s.size }

pub fn opt_grad_rmsprop_graphn_get(s : OptgradrmspropGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_graphn_set(s : OptgradrmspropGraphN, i : Int, v : Double) -> OptgradrmspropGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_graphn_sum(s : OptgradrmspropGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_grad_rmsprop_graphn_mean(s : OptgradrmspropGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_grad_rmsprop_graphn_scale(s : OptgradrmspropGraphN, f : Double) -> OptgradrmspropGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_graphn_add(a : OptgradrmspropGraphN, b : OptgradrmspropGraphN) -> OptgradrmspropGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_rmsprop_graphn_copy(s : OptgradrmspropGraphN) -> OptgradrmspropGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_graphn_fill(s : OptgradrmspropGraphN, v : Double) -> OptgradrmspropGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_graphn_min(s : OptgradrmspropGraphN) -> Double { @_common.min(s.data) }

pub fn opt_grad_rmsprop_graphn_max(s : OptgradrmspropGraphN) -> Double { @_common.max(s.data) }

pub fn opt_grad_rmsprop_graphn_to_string(s : OptgradrmspropGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_node_make(size : Int) -> OptgradrmspropNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_node_len(s : OptgradrmspropNode) -> Int { s.size }

pub fn opt_grad_rmsprop_node_get(s : OptgradrmspropNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_node_set(s : OptgradrmspropNode, i : Int, v : Double) -> OptgradrmspropNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_node_sum(s : OptgradrmspropNode) -> Double { @_common.sum(s.data) }

pub fn opt_grad_rmsprop_node_mean(s : OptgradrmspropNode) -> Double { @_common.mean(s.data) }

pub fn opt_grad_rmsprop_node_scale(s : OptgradrmspropNode, f : Double) -> OptgradrmspropNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_node_add(a : OptgradrmspropNode, b : OptgradrmspropNode) -> OptgradrmspropNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_rmsprop_node_copy(s : OptgradrmspropNode) -> OptgradrmspropNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_node_fill(s : OptgradrmspropNode, v : Double) -> OptgradrmspropNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_node_min(s : OptgradrmspropNode) -> Double { @_common.min(s.data) }

pub fn opt_grad_rmsprop_node_max(s : OptgradrmspropNode) -> Double { @_common.max(s.data) }

pub fn opt_grad_rmsprop_node_to_string(s : OptgradrmspropNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_edge_make(size : Int) -> OptgradrmspropEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_edge_len(s : OptgradrmspropEdge) -> Int { s.size }

pub fn opt_grad_rmsprop_edge_get(s : OptgradrmspropEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_edge_set(s : OptgradrmspropEdge, i : Int, v : Double) -> OptgradrmspropEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_edge_sum(s : OptgradrmspropEdge) -> Double { @_common.sum(s.data) }

pub fn opt_grad_rmsprop_edge_mean(s : OptgradrmspropEdge) -> Double { @_common.mean(s.data) }

pub fn opt_grad_rmsprop_edge_scale(s : OptgradrmspropEdge, f : Double) -> OptgradrmspropEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_edge_add(a : OptgradrmspropEdge, b : OptgradrmspropEdge) -> OptgradrmspropEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_rmsprop_edge_copy(s : OptgradrmspropEdge) -> OptgradrmspropEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_edge_fill(s : OptgradrmspropEdge, v : Double) -> OptgradrmspropEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_edge_min(s : OptgradrmspropEdge) -> Double { @_common.min(s.data) }

pub fn opt_grad_rmsprop_edge_max(s : OptgradrmspropEdge) -> Double { @_common.max(s.data) }

pub fn opt_grad_rmsprop_edge_to_string(s : OptgradrmspropEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_path_make(size : Int) -> OptgradrmspropPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_path_len(s : OptgradrmspropPath) -> Int { s.size }

pub fn opt_grad_rmsprop_path_get(s : OptgradrmspropPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_path_set(s : OptgradrmspropPath, i : Int, v : Double) -> OptgradrmspropPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_path_sum(s : OptgradrmspropPath) -> Double { @_common.sum(s.data) }

pub fn opt_grad_rmsprop_path_mean(s : OptgradrmspropPath) -> Double { @_common.mean(s.data) }

pub fn opt_grad_rmsprop_path_scale(s : OptgradrmspropPath, f : Double) -> OptgradrmspropPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_path_add(a : OptgradrmspropPath, b : OptgradrmspropPath) -> OptgradrmspropPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_rmsprop_path_copy(s : OptgradrmspropPath) -> OptgradrmspropPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_path_fill(s : OptgradrmspropPath, v : Double) -> OptgradrmspropPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_path_min(s : OptgradrmspropPath) -> Double { @_common.min(s.data) }

pub fn opt_grad_rmsprop_path_max(s : OptgradrmspropPath) -> Double { @_common.max(s.data) }

pub fn opt_grad_rmsprop_path_to_string(s : OptgradrmspropPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_cluster_make(size : Int) -> OptgradrmspropCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_cluster_len(s : OptgradrmspropCluster) -> Int { s.size }

pub fn opt_grad_rmsprop_cluster_get(s : OptgradrmspropCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_cluster_set(s : OptgradrmspropCluster, i : Int, v : Double) -> OptgradrmspropCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_cluster_sum(s : OptgradrmspropCluster) -> Double { @_common.sum(s.data) }

pub fn opt_grad_rmsprop_cluster_mean(s : OptgradrmspropCluster) -> Double { @_common.mean(s.data) }

pub fn opt_grad_rmsprop_cluster_scale(s : OptgradrmspropCluster, f : Double) -> OptgradrmspropCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_cluster_add(a : OptgradrmspropCluster, b : OptgradrmspropCluster) -> OptgradrmspropCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_rmsprop_cluster_copy(s : OptgradrmspropCluster) -> OptgradrmspropCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_cluster_fill(s : OptgradrmspropCluster, v : Double) -> OptgradrmspropCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_cluster_min(s : OptgradrmspropCluster) -> Double { @_common.min(s.data) }

pub fn opt_grad_rmsprop_cluster_max(s : OptgradrmspropCluster) -> Double { @_common.max(s.data) }

pub fn opt_grad_rmsprop_cluster_to_string(s : OptgradrmspropCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_model_make(size : Int) -> OptgradrmspropModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_model_len(s : OptgradrmspropModel) -> Int { s.size }

pub fn opt_grad_rmsprop_model_get(s : OptgradrmspropModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_model_set(s : OptgradrmspropModel, i : Int, v : Double) -> OptgradrmspropModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_model_sum(s : OptgradrmspropModel) -> Double { @_common.sum(s.data) }

pub fn opt_grad_rmsprop_model_mean(s : OptgradrmspropModel) -> Double { @_common.mean(s.data) }

pub fn opt_grad_rmsprop_model_scale(s : OptgradrmspropModel, f : Double) -> OptgradrmspropModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_model_add(a : OptgradrmspropModel, b : OptgradrmspropModel) -> OptgradrmspropModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_rmsprop_model_copy(s : OptgradrmspropModel) -> OptgradrmspropModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_model_fill(s : OptgradrmspropModel, v : Double) -> OptgradrmspropModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_model_min(s : OptgradrmspropModel) -> Double { @_common.min(s.data) }

pub fn opt_grad_rmsprop_model_max(s : OptgradrmspropModel) -> Double { @_common.max(s.data) }

pub fn opt_grad_rmsprop_model_to_string(s : OptgradrmspropModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_layer_make(size : Int) -> OptgradrmspropLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_layer_len(s : OptgradrmspropLayer) -> Int { s.size }

pub fn opt_grad_rmsprop_layer_get(s : OptgradrmspropLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_layer_set(s : OptgradrmspropLayer, i : Int, v : Double) -> OptgradrmspropLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_layer_sum(s : OptgradrmspropLayer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_rmsprop_layer_mean(s : OptgradrmspropLayer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_rmsprop_layer_scale(s : OptgradrmspropLayer, f : Double) -> OptgradrmspropLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_layer_add(a : OptgradrmspropLayer, b : OptgradrmspropLayer) -> OptgradrmspropLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_rmsprop_layer_copy(s : OptgradrmspropLayer) -> OptgradrmspropLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_layer_fill(s : OptgradrmspropLayer, v : Double) -> OptgradrmspropLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_layer_min(s : OptgradrmspropLayer) -> Double { @_common.min(s.data) }

pub fn opt_grad_rmsprop_layer_max(s : OptgradrmspropLayer) -> Double { @_common.max(s.data) }

pub fn opt_grad_rmsprop_layer_to_string(s : OptgradrmspropLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_buffer_make(size : Int) -> OptgradrmspropBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_buffer_len(s : OptgradrmspropBuffer) -> Int { s.size }

pub fn opt_grad_rmsprop_buffer_get(s : OptgradrmspropBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_buffer_set(s : OptgradrmspropBuffer, i : Int, v : Double) -> OptgradrmspropBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_buffer_sum(s : OptgradrmspropBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_rmsprop_buffer_mean(s : OptgradrmspropBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_rmsprop_buffer_scale(s : OptgradrmspropBuffer, f : Double) -> OptgradrmspropBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_buffer_add(a : OptgradrmspropBuffer, b : OptgradrmspropBuffer) -> OptgradrmspropBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_rmsprop_buffer_copy(s : OptgradrmspropBuffer) -> OptgradrmspropBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_buffer_fill(s : OptgradrmspropBuffer, v : Double) -> OptgradrmspropBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_buffer_min(s : OptgradrmspropBuffer) -> Double { @_common.min(s.data) }

pub fn opt_grad_rmsprop_buffer_max(s : OptgradrmspropBuffer) -> Double { @_common.max(s.data) }

pub fn opt_grad_rmsprop_buffer_to_string(s : OptgradrmspropBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_cursor_make(size : Int) -> OptgradrmspropCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_cursor_len(s : OptgradrmspropCursor) -> Int { s.size }

pub fn opt_grad_rmsprop_cursor_get(s : OptgradrmspropCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_cursor_set(s : OptgradrmspropCursor, i : Int, v : Double) -> OptgradrmspropCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_cursor_sum(s : OptgradrmspropCursor) -> Double { @_common.sum(s.data) }

pub fn opt_grad_rmsprop_cursor_mean(s : OptgradrmspropCursor) -> Double { @_common.mean(s.data) }

pub fn opt_grad_rmsprop_cursor_scale(s : OptgradrmspropCursor, f : Double) -> OptgradrmspropCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_cursor_add(a : OptgradrmspropCursor, b : OptgradrmspropCursor) -> OptgradrmspropCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_rmsprop_cursor_copy(s : OptgradrmspropCursor) -> OptgradrmspropCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_cursor_fill(s : OptgradrmspropCursor, v : Double) -> OptgradrmspropCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_cursor_min(s : OptgradrmspropCursor) -> Double { @_common.min(s.data) }

pub fn opt_grad_rmsprop_cursor_max(s : OptgradrmspropCursor) -> Double { @_common.max(s.data) }

pub fn opt_grad_rmsprop_cursor_to_string(s : OptgradrmspropCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_view_make(size : Int) -> OptgradrmspropView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_view_len(s : OptgradrmspropView) -> Int { s.size }

pub fn opt_grad_rmsprop_view_get(s : OptgradrmspropView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_view_set(s : OptgradrmspropView, i : Int, v : Double) -> OptgradrmspropView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_view_sum(s : OptgradrmspropView) -> Double { @_common.sum(s.data) }

pub fn opt_grad_rmsprop_view_mean(s : OptgradrmspropView) -> Double { @_common.mean(s.data) }

pub fn opt_grad_rmsprop_view_scale(s : OptgradrmspropView, f : Double) -> OptgradrmspropView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_view_add(a : OptgradrmspropView, b : OptgradrmspropView) -> OptgradrmspropView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_rmsprop_view_copy(s : OptgradrmspropView) -> OptgradrmspropView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_view_fill(s : OptgradrmspropView, v : Double) -> OptgradrmspropView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_view_min(s : OptgradrmspropView) -> Double { @_common.min(s.data) }

pub fn opt_grad_rmsprop_view_max(s : OptgradrmspropView) -> Double { @_common.max(s.data) }

pub fn opt_grad_rmsprop_view_to_string(s : OptgradrmspropView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_range_make(size : Int) -> OptgradrmspropRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_range_len(s : OptgradrmspropRange) -> Int { s.size }

pub fn opt_grad_rmsprop_range_get(s : OptgradrmspropRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_range_set(s : OptgradrmspropRange, i : Int, v : Double) -> OptgradrmspropRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_range_sum(s : OptgradrmspropRange) -> Double { @_common.sum(s.data) }

pub fn opt_grad_rmsprop_range_mean(s : OptgradrmspropRange) -> Double { @_common.mean(s.data) }

pub fn opt_grad_rmsprop_range_scale(s : OptgradrmspropRange, f : Double) -> OptgradrmspropRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_range_add(a : OptgradrmspropRange, b : OptgradrmspropRange) -> OptgradrmspropRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_rmsprop_range_copy(s : OptgradrmspropRange) -> OptgradrmspropRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_range_fill(s : OptgradrmspropRange, v : Double) -> OptgradrmspropRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_range_min(s : OptgradrmspropRange) -> Double { @_common.min(s.data) }

pub fn opt_grad_rmsprop_range_max(s : OptgradrmspropRange) -> Double { @_common.max(s.data) }

pub fn opt_grad_rmsprop_range_to_string(s : OptgradrmspropRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_slice_make(size : Int) -> OptgradrmspropSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_slice_len(s : OptgradrmspropSlice) -> Int { s.size }

pub fn opt_grad_rmsprop_slice_get(s : OptgradrmspropSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_slice_set(s : OptgradrmspropSlice, i : Int, v : Double) -> OptgradrmspropSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_slice_sum(s : OptgradrmspropSlice) -> Double { @_common.sum(s.data) }

pub fn opt_grad_rmsprop_slice_mean(s : OptgradrmspropSlice) -> Double { @_common.mean(s.data) }

pub fn opt_grad_rmsprop_slice_scale(s : OptgradrmspropSlice, f : Double) -> OptgradrmspropSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_slice_add(a : OptgradrmspropSlice, b : OptgradrmspropSlice) -> OptgradrmspropSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_rmsprop_slice_copy(s : OptgradrmspropSlice) -> OptgradrmspropSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_slice_fill(s : OptgradrmspropSlice, v : Double) -> OptgradrmspropSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_rmsprop_slice_min(s : OptgradrmspropSlice) -> Double { @_common.min(s.data) }

pub fn opt_grad_rmsprop_slice_max(s : OptgradrmspropSlice) -> Double { @_common.max(s.data) }

pub fn opt_grad_rmsprop_slice_to_string(s : OptgradrmspropSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

