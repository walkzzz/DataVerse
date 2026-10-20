///===
/// extcore/nlp_parse_cfg

pub(all) struct NlpparsecfgPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_cfg_make_point(x : Double, y : Double) -> NlpparsecfgPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_cfg_make_point3(x : Double, y : Double, z : Double) -> NlpparsecfgPoint {
  { x, y, z, label: 0 }
}

pub fn NlpparsecfgPoint::x(self : NlpparsecfgPoint) -> Double { self.x }

pub fn NlpparsecfgPoint::y(self : NlpparsecfgPoint) -> Double { self.y }

pub fn NlpparsecfgPoint::z(self : NlpparsecfgPoint) -> Double { self.z }

pub fn NlpparsecfgPoint::label(self : NlpparsecfgPoint) -> Int { self.label }

pub fn NlpparsecfgPoint::dist(self : NlpparsecfgPoint, other : NlpparsecfgPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpparsecfgPoint::add(self : NlpparsecfgPoint, other : NlpparsecfgPoint) -> NlpparsecfgPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpparsecfgPoint::sub(self : NlpparsecfgPoint, other : NlpparsecfgPoint) -> NlpparsecfgPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpparsecfgPoint::scale(self : NlpparsecfgPoint, s : Double) -> NlpparsecfgPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpparsecfgPoint::dot(self : NlpparsecfgPoint, other : NlpparsecfgPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpparsecfgPoint::cross(self : NlpparsecfgPoint, other : NlpparsecfgPoint) -> NlpparsecfgPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpparsecfgPoint::norm(self : NlpparsecfgPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpparsecfgPoint::normalize(self : NlpparsecfgPoint) -> NlpparsecfgPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparsecfgPoint::negate(self : NlpparsecfgPoint) -> NlpparsecfgPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpparsecfgPoint::mid(self : NlpparsecfgPoint, other : NlpparsecfgPoint) -> NlpparsecfgPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpparsecfgPoint::lerp(self : NlpparsecfgPoint, other : NlpparsecfgPoint, t : Double) -> NlpparsecfgPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpparsecfgPoint::to_string(self : NlpparsecfgPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpparsecfgSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_cfg_make_series(vals : Array[Double], name : String) -> NlpparsecfgSeries {
  { vals, name, meta: 0 }
}

pub fn NlpparsecfgSeries::len(self : NlpparsecfgSeries) -> Int { self.vals.length() }

pub fn NlpparsecfgSeries::sum(self : NlpparsecfgSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpparsecfgSeries::mean(self : NlpparsecfgSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpparsecfgSeries::min(self : NlpparsecfgSeries) -> Double { @_common.min(self.vals) }

pub fn NlpparsecfgSeries::max(self : NlpparsecfgSeries) -> Double { @_common.max(self.vals) }

pub fn NlpparsecfgSeries::range(self : NlpparsecfgSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpparsecfgSeries::variance(self : NlpparsecfgSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpparsecfgSeries::std(self : NlpparsecfgSeries) -> Double { @_common.std(self.vals) }

pub fn NlpparsecfgSeries::median(self : NlpparsecfgSeries) -> Double { @_common.median(self.vals) }

pub fn NlpparsecfgSeries::scale(self : NlpparsecfgSeries, f : Double) -> NlpparsecfgSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpparsecfgSeries::add(self : NlpparsecfgSeries, other : NlpparsecfgSeries) -> NlpparsecfgSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpparsecfgSeries::sub(self : NlpparsecfgSeries, other : NlpparsecfgSeries) -> NlpparsecfgSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpparsecfgSeries::normalize(self : NlpparsecfgSeries) -> NlpparsecfgSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpparsecfgSeries::cumsum(self : NlpparsecfgSeries) -> NlpparsecfgSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpparsecfgSeries::to_string(self : NlpparsecfgSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsecfgMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_cfg_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsecfgMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_cfg_matrix_identity(n : Int) -> NlpparsecfgMatrix {
  let m = nlp_parse_cfg_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpparsecfgMatrix::get(self : NlpparsecfgMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpparsecfgMatrix::transpose(self : NlpparsecfgMatrix) -> NlpparsecfgMatrix {
  let result = nlp_parse_cfg_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpparsecfgMatrix::add(self : NlpparsecfgMatrix, other : NlpparsecfgMatrix) -> NlpparsecfgMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_parse_cfg_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpparsecfgMatrix::scale(self : NlpparsecfgMatrix, s : Double) -> NlpparsecfgMatrix {
  let result = nlp_parse_cfg_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpparsecfgMatrix::multiply(self : NlpparsecfgMatrix, other : NlpparsecfgMatrix) -> NlpparsecfgMatrix {
  if self.cols != other.rows { return nlp_parse_cfg_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_parse_cfg_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpparsecfgMatrix::trace(self : NlpparsecfgMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpparsecfgMatrix::det(self : NlpparsecfgMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpparsecfgMatrix::norm(self : NlpparsecfgMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpparsecfgMatrix::to_string(self : NlpparsecfgMatrix) -> String {
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

pub(all) struct NlpparsecfgVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_cfg_make_vector(comps : Array[Double]) -> NlpparsecfgVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_cfg_vector_zero(dim : Int) -> NlpparsecfgVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpparsecfgVector::add(self : NlpparsecfgVector, other : NlpparsecfgVector) -> NlpparsecfgVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparsecfgVector::sub(self : NlpparsecfgVector, other : NlpparsecfgVector) -> NlpparsecfgVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparsecfgVector::scale(self : NlpparsecfgVector, s : Double) -> NlpparsecfgVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpparsecfgVector::dot(self : NlpparsecfgVector, other : NlpparsecfgVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpparsecfgVector::norm(self : NlpparsecfgVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpparsecfgVector::normalize(self : NlpparsecfgVector) -> NlpparsecfgVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparsecfgVector::dist(self : NlpparsecfgVector, other : NlpparsecfgVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpparsecfgVector::to_string(self : NlpparsecfgVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_cfg_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_parse_cfg_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_parse_cfg_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_parse_cfg_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_parse_cfg_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_parse_cfg_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_parse_cfg_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_parse_cfg_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_parse_cfg_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_parse_cfg_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_parse_cfg_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_parse_cfg_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_parse_cfg_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_parse_cfg_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_parse_cfg_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_parse_cfg_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_parse_cfg_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_parse_cfg_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_parse_cfg_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_parse_cfg_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_parse_cfg_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_parse_cfg_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_parse_cfg_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_parse_cfg_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_parse_cfg_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_parse_cfg_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_parse_cfg_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_parse_cfg_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_parse_cfg_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpparsecfgFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_frame_make(size : Int) -> NlpparsecfgFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_frame_len(s : NlpparsecfgFrame) -> Int { s.size }

pub fn nlp_parse_cfg_frame_get(s : NlpparsecfgFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_frame_set(s : NlpparsecfgFrame, i : Int, v : Double) -> NlpparsecfgFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_frame_sum(s : NlpparsecfgFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_frame_mean(s : NlpparsecfgFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_frame_scale(s : NlpparsecfgFrame, f : Double) -> NlpparsecfgFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_frame_add(a : NlpparsecfgFrame, b : NlpparsecfgFrame) -> NlpparsecfgFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_frame_copy(s : NlpparsecfgFrame) -> NlpparsecfgFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_frame_fill(s : NlpparsecfgFrame, v : Double) -> NlpparsecfgFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_frame_min(s : NlpparsecfgFrame) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_frame_max(s : NlpparsecfgFrame) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_frame_to_string(s : NlpparsecfgFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_table_make(size : Int) -> NlpparsecfgTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_table_len(s : NlpparsecfgTable) -> Int { s.size }

pub fn nlp_parse_cfg_table_get(s : NlpparsecfgTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_table_set(s : NlpparsecfgTable, i : Int, v : Double) -> NlpparsecfgTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_table_sum(s : NlpparsecfgTable) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_table_mean(s : NlpparsecfgTable) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_table_scale(s : NlpparsecfgTable, f : Double) -> NlpparsecfgTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_table_add(a : NlpparsecfgTable, b : NlpparsecfgTable) -> NlpparsecfgTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_table_copy(s : NlpparsecfgTable) -> NlpparsecfgTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_table_fill(s : NlpparsecfgTable, v : Double) -> NlpparsecfgTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_table_min(s : NlpparsecfgTable) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_table_max(s : NlpparsecfgTable) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_table_to_string(s : NlpparsecfgTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_graphn_make(size : Int) -> NlpparsecfgGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_graphn_len(s : NlpparsecfgGraphN) -> Int { s.size }

pub fn nlp_parse_cfg_graphn_get(s : NlpparsecfgGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_graphn_set(s : NlpparsecfgGraphN, i : Int, v : Double) -> NlpparsecfgGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_graphn_sum(s : NlpparsecfgGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_graphn_mean(s : NlpparsecfgGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_graphn_scale(s : NlpparsecfgGraphN, f : Double) -> NlpparsecfgGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_graphn_add(a : NlpparsecfgGraphN, b : NlpparsecfgGraphN) -> NlpparsecfgGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_graphn_copy(s : NlpparsecfgGraphN) -> NlpparsecfgGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_graphn_fill(s : NlpparsecfgGraphN, v : Double) -> NlpparsecfgGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_graphn_min(s : NlpparsecfgGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_graphn_max(s : NlpparsecfgGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_graphn_to_string(s : NlpparsecfgGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_node_make(size : Int) -> NlpparsecfgNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_node_len(s : NlpparsecfgNode) -> Int { s.size }

pub fn nlp_parse_cfg_node_get(s : NlpparsecfgNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_node_set(s : NlpparsecfgNode, i : Int, v : Double) -> NlpparsecfgNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_node_sum(s : NlpparsecfgNode) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_node_mean(s : NlpparsecfgNode) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_node_scale(s : NlpparsecfgNode, f : Double) -> NlpparsecfgNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_node_add(a : NlpparsecfgNode, b : NlpparsecfgNode) -> NlpparsecfgNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_node_copy(s : NlpparsecfgNode) -> NlpparsecfgNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_node_fill(s : NlpparsecfgNode, v : Double) -> NlpparsecfgNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_node_min(s : NlpparsecfgNode) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_node_max(s : NlpparsecfgNode) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_node_to_string(s : NlpparsecfgNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_edge_make(size : Int) -> NlpparsecfgEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_edge_len(s : NlpparsecfgEdge) -> Int { s.size }

pub fn nlp_parse_cfg_edge_get(s : NlpparsecfgEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_edge_set(s : NlpparsecfgEdge, i : Int, v : Double) -> NlpparsecfgEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_edge_sum(s : NlpparsecfgEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_edge_mean(s : NlpparsecfgEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_edge_scale(s : NlpparsecfgEdge, f : Double) -> NlpparsecfgEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_edge_add(a : NlpparsecfgEdge, b : NlpparsecfgEdge) -> NlpparsecfgEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_edge_copy(s : NlpparsecfgEdge) -> NlpparsecfgEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_edge_fill(s : NlpparsecfgEdge, v : Double) -> NlpparsecfgEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_edge_min(s : NlpparsecfgEdge) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_edge_max(s : NlpparsecfgEdge) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_edge_to_string(s : NlpparsecfgEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_path_make(size : Int) -> NlpparsecfgPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_path_len(s : NlpparsecfgPath) -> Int { s.size }

pub fn nlp_parse_cfg_path_get(s : NlpparsecfgPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_path_set(s : NlpparsecfgPath, i : Int, v : Double) -> NlpparsecfgPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_path_sum(s : NlpparsecfgPath) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_path_mean(s : NlpparsecfgPath) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_path_scale(s : NlpparsecfgPath, f : Double) -> NlpparsecfgPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_path_add(a : NlpparsecfgPath, b : NlpparsecfgPath) -> NlpparsecfgPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_path_copy(s : NlpparsecfgPath) -> NlpparsecfgPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_path_fill(s : NlpparsecfgPath, v : Double) -> NlpparsecfgPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_path_min(s : NlpparsecfgPath) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_path_max(s : NlpparsecfgPath) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_path_to_string(s : NlpparsecfgPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_cluster_make(size : Int) -> NlpparsecfgCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_cluster_len(s : NlpparsecfgCluster) -> Int { s.size }

pub fn nlp_parse_cfg_cluster_get(s : NlpparsecfgCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_cluster_set(s : NlpparsecfgCluster, i : Int, v : Double) -> NlpparsecfgCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cluster_sum(s : NlpparsecfgCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_cluster_mean(s : NlpparsecfgCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_cluster_scale(s : NlpparsecfgCluster, f : Double) -> NlpparsecfgCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cluster_add(a : NlpparsecfgCluster, b : NlpparsecfgCluster) -> NlpparsecfgCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_cluster_copy(s : NlpparsecfgCluster) -> NlpparsecfgCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cluster_fill(s : NlpparsecfgCluster, v : Double) -> NlpparsecfgCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cluster_min(s : NlpparsecfgCluster) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_cluster_max(s : NlpparsecfgCluster) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_cluster_to_string(s : NlpparsecfgCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_model_make(size : Int) -> NlpparsecfgModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_model_len(s : NlpparsecfgModel) -> Int { s.size }

pub fn nlp_parse_cfg_model_get(s : NlpparsecfgModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_model_set(s : NlpparsecfgModel, i : Int, v : Double) -> NlpparsecfgModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_model_sum(s : NlpparsecfgModel) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_model_mean(s : NlpparsecfgModel) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_model_scale(s : NlpparsecfgModel, f : Double) -> NlpparsecfgModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_model_add(a : NlpparsecfgModel, b : NlpparsecfgModel) -> NlpparsecfgModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_model_copy(s : NlpparsecfgModel) -> NlpparsecfgModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_model_fill(s : NlpparsecfgModel, v : Double) -> NlpparsecfgModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_model_min(s : NlpparsecfgModel) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_model_max(s : NlpparsecfgModel) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_model_to_string(s : NlpparsecfgModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_layer_make(size : Int) -> NlpparsecfgLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_layer_len(s : NlpparsecfgLayer) -> Int { s.size }

pub fn nlp_parse_cfg_layer_get(s : NlpparsecfgLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_layer_set(s : NlpparsecfgLayer, i : Int, v : Double) -> NlpparsecfgLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_layer_sum(s : NlpparsecfgLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_layer_mean(s : NlpparsecfgLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_layer_scale(s : NlpparsecfgLayer, f : Double) -> NlpparsecfgLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_layer_add(a : NlpparsecfgLayer, b : NlpparsecfgLayer) -> NlpparsecfgLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_layer_copy(s : NlpparsecfgLayer) -> NlpparsecfgLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_layer_fill(s : NlpparsecfgLayer, v : Double) -> NlpparsecfgLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_layer_min(s : NlpparsecfgLayer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_layer_max(s : NlpparsecfgLayer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_layer_to_string(s : NlpparsecfgLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_buffer_make(size : Int) -> NlpparsecfgBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_buffer_len(s : NlpparsecfgBuffer) -> Int { s.size }

pub fn nlp_parse_cfg_buffer_get(s : NlpparsecfgBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_buffer_set(s : NlpparsecfgBuffer, i : Int, v : Double) -> NlpparsecfgBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_buffer_sum(s : NlpparsecfgBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_buffer_mean(s : NlpparsecfgBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_buffer_scale(s : NlpparsecfgBuffer, f : Double) -> NlpparsecfgBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_buffer_add(a : NlpparsecfgBuffer, b : NlpparsecfgBuffer) -> NlpparsecfgBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_buffer_copy(s : NlpparsecfgBuffer) -> NlpparsecfgBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_buffer_fill(s : NlpparsecfgBuffer, v : Double) -> NlpparsecfgBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_buffer_min(s : NlpparsecfgBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_buffer_max(s : NlpparsecfgBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_buffer_to_string(s : NlpparsecfgBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_cursor_make(size : Int) -> NlpparsecfgCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_cursor_len(s : NlpparsecfgCursor) -> Int { s.size }

pub fn nlp_parse_cfg_cursor_get(s : NlpparsecfgCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_cursor_set(s : NlpparsecfgCursor, i : Int, v : Double) -> NlpparsecfgCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cursor_sum(s : NlpparsecfgCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_cursor_mean(s : NlpparsecfgCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_cursor_scale(s : NlpparsecfgCursor, f : Double) -> NlpparsecfgCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cursor_add(a : NlpparsecfgCursor, b : NlpparsecfgCursor) -> NlpparsecfgCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_cursor_copy(s : NlpparsecfgCursor) -> NlpparsecfgCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cursor_fill(s : NlpparsecfgCursor, v : Double) -> NlpparsecfgCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cursor_min(s : NlpparsecfgCursor) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_cursor_max(s : NlpparsecfgCursor) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_cursor_to_string(s : NlpparsecfgCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_view_make(size : Int) -> NlpparsecfgView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_view_len(s : NlpparsecfgView) -> Int { s.size }

pub fn nlp_parse_cfg_view_get(s : NlpparsecfgView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_view_set(s : NlpparsecfgView, i : Int, v : Double) -> NlpparsecfgView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_view_sum(s : NlpparsecfgView) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_view_mean(s : NlpparsecfgView) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_view_scale(s : NlpparsecfgView, f : Double) -> NlpparsecfgView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_view_add(a : NlpparsecfgView, b : NlpparsecfgView) -> NlpparsecfgView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_view_copy(s : NlpparsecfgView) -> NlpparsecfgView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_view_fill(s : NlpparsecfgView, v : Double) -> NlpparsecfgView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_view_min(s : NlpparsecfgView) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_view_max(s : NlpparsecfgView) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_view_to_string(s : NlpparsecfgView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_range_make(size : Int) -> NlpparsecfgRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_range_len(s : NlpparsecfgRange) -> Int { s.size }

pub fn nlp_parse_cfg_range_get(s : NlpparsecfgRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_range_set(s : NlpparsecfgRange, i : Int, v : Double) -> NlpparsecfgRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_range_sum(s : NlpparsecfgRange) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_range_mean(s : NlpparsecfgRange) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_range_scale(s : NlpparsecfgRange, f : Double) -> NlpparsecfgRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_range_add(a : NlpparsecfgRange, b : NlpparsecfgRange) -> NlpparsecfgRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_range_copy(s : NlpparsecfgRange) -> NlpparsecfgRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_range_fill(s : NlpparsecfgRange, v : Double) -> NlpparsecfgRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_range_min(s : NlpparsecfgRange) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_range_max(s : NlpparsecfgRange) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_range_to_string(s : NlpparsecfgRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_slice_make(size : Int) -> NlpparsecfgSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_slice_len(s : NlpparsecfgSlice) -> Int { s.size }

pub fn nlp_parse_cfg_slice_get(s : NlpparsecfgSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_slice_set(s : NlpparsecfgSlice, i : Int, v : Double) -> NlpparsecfgSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_slice_sum(s : NlpparsecfgSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_slice_mean(s : NlpparsecfgSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_slice_scale(s : NlpparsecfgSlice, f : Double) -> NlpparsecfgSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_slice_add(a : NlpparsecfgSlice, b : NlpparsecfgSlice) -> NlpparsecfgSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_slice_copy(s : NlpparsecfgSlice) -> NlpparsecfgSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_slice_fill(s : NlpparsecfgSlice, v : Double) -> NlpparsecfgSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_slice_min(s : NlpparsecfgSlice) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_slice_max(s : NlpparsecfgSlice) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_slice_to_string(s : NlpparsecfgSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

