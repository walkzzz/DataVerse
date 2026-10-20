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

pub fn NlpparsecfgFrame::len(self : NlpparsecfgFrame) -> Int { self.size }

pub fn NlpparsecfgFrame::get(self : NlpparsecfgFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsecfgFrame::set(self : NlpparsecfgFrame, i : Int, v : Double) -> NlpparsecfgFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsecfgFrame::sum(self : NlpparsecfgFrame) -> Double { @_common.sum(self.data) }

pub fn NlpparsecfgFrame::mean(self : NlpparsecfgFrame) -> Double { @_common.mean(self.data) }

pub fn NlpparsecfgFrame::scale(self : NlpparsecfgFrame, f : Double) -> NlpparsecfgFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgFrame::add(self : NlpparsecfgFrame, other : NlpparsecfgFrame) -> NlpparsecfgFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsecfgFrame::copy(self : NlpparsecfgFrame) -> NlpparsecfgFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgFrame::fill(self : NlpparsecfgFrame, v : Double) -> NlpparsecfgFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgFrame::min(self : NlpparsecfgFrame) -> Double { @_common.min(self.data) }

pub fn NlpparsecfgFrame::max(self : NlpparsecfgFrame) -> Double { @_common.max(self.data) }

pub fn NlpparsecfgFrame::to_string(self : NlpparsecfgFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_table_make(size : Int) -> NlpparsecfgTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsecfgTable::len(self : NlpparsecfgTable) -> Int { self.size }

pub fn NlpparsecfgTable::get(self : NlpparsecfgTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsecfgTable::set(self : NlpparsecfgTable, i : Int, v : Double) -> NlpparsecfgTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsecfgTable::sum(self : NlpparsecfgTable) -> Double { @_common.sum(self.data) }

pub fn NlpparsecfgTable::mean(self : NlpparsecfgTable) -> Double { @_common.mean(self.data) }

pub fn NlpparsecfgTable::scale(self : NlpparsecfgTable, f : Double) -> NlpparsecfgTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgTable::add(self : NlpparsecfgTable, other : NlpparsecfgTable) -> NlpparsecfgTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsecfgTable::copy(self : NlpparsecfgTable) -> NlpparsecfgTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgTable::fill(self : NlpparsecfgTable, v : Double) -> NlpparsecfgTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgTable::min(self : NlpparsecfgTable) -> Double { @_common.min(self.data) }

pub fn NlpparsecfgTable::max(self : NlpparsecfgTable) -> Double { @_common.max(self.data) }

pub fn NlpparsecfgTable::to_string(self : NlpparsecfgTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_graphn_make(size : Int) -> NlpparsecfgGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsecfgGraphN::len(self : NlpparsecfgGraphN) -> Int { self.size }

pub fn NlpparsecfgGraphN::get(self : NlpparsecfgGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsecfgGraphN::set(self : NlpparsecfgGraphN, i : Int, v : Double) -> NlpparsecfgGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsecfgGraphN::sum(self : NlpparsecfgGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpparsecfgGraphN::mean(self : NlpparsecfgGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpparsecfgGraphN::scale(self : NlpparsecfgGraphN, f : Double) -> NlpparsecfgGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgGraphN::add(self : NlpparsecfgGraphN, other : NlpparsecfgGraphN) -> NlpparsecfgGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsecfgGraphN::copy(self : NlpparsecfgGraphN) -> NlpparsecfgGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgGraphN::fill(self : NlpparsecfgGraphN, v : Double) -> NlpparsecfgGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgGraphN::min(self : NlpparsecfgGraphN) -> Double { @_common.min(self.data) }

pub fn NlpparsecfgGraphN::max(self : NlpparsecfgGraphN) -> Double { @_common.max(self.data) }

pub fn NlpparsecfgGraphN::to_string(self : NlpparsecfgGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_node_make(size : Int) -> NlpparsecfgNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsecfgNode::len(self : NlpparsecfgNode) -> Int { self.size }

pub fn NlpparsecfgNode::get(self : NlpparsecfgNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsecfgNode::set(self : NlpparsecfgNode, i : Int, v : Double) -> NlpparsecfgNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsecfgNode::sum(self : NlpparsecfgNode) -> Double { @_common.sum(self.data) }

pub fn NlpparsecfgNode::mean(self : NlpparsecfgNode) -> Double { @_common.mean(self.data) }

pub fn NlpparsecfgNode::scale(self : NlpparsecfgNode, f : Double) -> NlpparsecfgNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgNode::add(self : NlpparsecfgNode, other : NlpparsecfgNode) -> NlpparsecfgNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsecfgNode::copy(self : NlpparsecfgNode) -> NlpparsecfgNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgNode::fill(self : NlpparsecfgNode, v : Double) -> NlpparsecfgNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgNode::min(self : NlpparsecfgNode) -> Double { @_common.min(self.data) }

pub fn NlpparsecfgNode::max(self : NlpparsecfgNode) -> Double { @_common.max(self.data) }

pub fn NlpparsecfgNode::to_string(self : NlpparsecfgNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_edge_make(size : Int) -> NlpparsecfgEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsecfgEdge::len(self : NlpparsecfgEdge) -> Int { self.size }

pub fn NlpparsecfgEdge::get(self : NlpparsecfgEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsecfgEdge::set(self : NlpparsecfgEdge, i : Int, v : Double) -> NlpparsecfgEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsecfgEdge::sum(self : NlpparsecfgEdge) -> Double { @_common.sum(self.data) }

pub fn NlpparsecfgEdge::mean(self : NlpparsecfgEdge) -> Double { @_common.mean(self.data) }

pub fn NlpparsecfgEdge::scale(self : NlpparsecfgEdge, f : Double) -> NlpparsecfgEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgEdge::add(self : NlpparsecfgEdge, other : NlpparsecfgEdge) -> NlpparsecfgEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsecfgEdge::copy(self : NlpparsecfgEdge) -> NlpparsecfgEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgEdge::fill(self : NlpparsecfgEdge, v : Double) -> NlpparsecfgEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgEdge::min(self : NlpparsecfgEdge) -> Double { @_common.min(self.data) }

pub fn NlpparsecfgEdge::max(self : NlpparsecfgEdge) -> Double { @_common.max(self.data) }

pub fn NlpparsecfgEdge::to_string(self : NlpparsecfgEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_path_make(size : Int) -> NlpparsecfgPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsecfgPath::len(self : NlpparsecfgPath) -> Int { self.size }

pub fn NlpparsecfgPath::get(self : NlpparsecfgPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsecfgPath::set(self : NlpparsecfgPath, i : Int, v : Double) -> NlpparsecfgPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsecfgPath::sum(self : NlpparsecfgPath) -> Double { @_common.sum(self.data) }

pub fn NlpparsecfgPath::mean(self : NlpparsecfgPath) -> Double { @_common.mean(self.data) }

pub fn NlpparsecfgPath::scale(self : NlpparsecfgPath, f : Double) -> NlpparsecfgPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgPath::add(self : NlpparsecfgPath, other : NlpparsecfgPath) -> NlpparsecfgPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsecfgPath::copy(self : NlpparsecfgPath) -> NlpparsecfgPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgPath::fill(self : NlpparsecfgPath, v : Double) -> NlpparsecfgPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgPath::min(self : NlpparsecfgPath) -> Double { @_common.min(self.data) }

pub fn NlpparsecfgPath::max(self : NlpparsecfgPath) -> Double { @_common.max(self.data) }

pub fn NlpparsecfgPath::to_string(self : NlpparsecfgPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_cluster_make(size : Int) -> NlpparsecfgCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsecfgCluster::len(self : NlpparsecfgCluster) -> Int { self.size }

pub fn NlpparsecfgCluster::get(self : NlpparsecfgCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsecfgCluster::set(self : NlpparsecfgCluster, i : Int, v : Double) -> NlpparsecfgCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsecfgCluster::sum(self : NlpparsecfgCluster) -> Double { @_common.sum(self.data) }

pub fn NlpparsecfgCluster::mean(self : NlpparsecfgCluster) -> Double { @_common.mean(self.data) }

pub fn NlpparsecfgCluster::scale(self : NlpparsecfgCluster, f : Double) -> NlpparsecfgCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgCluster::add(self : NlpparsecfgCluster, other : NlpparsecfgCluster) -> NlpparsecfgCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsecfgCluster::copy(self : NlpparsecfgCluster) -> NlpparsecfgCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgCluster::fill(self : NlpparsecfgCluster, v : Double) -> NlpparsecfgCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgCluster::min(self : NlpparsecfgCluster) -> Double { @_common.min(self.data) }

pub fn NlpparsecfgCluster::max(self : NlpparsecfgCluster) -> Double { @_common.max(self.data) }

pub fn NlpparsecfgCluster::to_string(self : NlpparsecfgCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_model_make(size : Int) -> NlpparsecfgModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsecfgModel::len(self : NlpparsecfgModel) -> Int { self.size }

pub fn NlpparsecfgModel::get(self : NlpparsecfgModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsecfgModel::set(self : NlpparsecfgModel, i : Int, v : Double) -> NlpparsecfgModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsecfgModel::sum(self : NlpparsecfgModel) -> Double { @_common.sum(self.data) }

pub fn NlpparsecfgModel::mean(self : NlpparsecfgModel) -> Double { @_common.mean(self.data) }

pub fn NlpparsecfgModel::scale(self : NlpparsecfgModel, f : Double) -> NlpparsecfgModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgModel::add(self : NlpparsecfgModel, other : NlpparsecfgModel) -> NlpparsecfgModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsecfgModel::copy(self : NlpparsecfgModel) -> NlpparsecfgModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgModel::fill(self : NlpparsecfgModel, v : Double) -> NlpparsecfgModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgModel::min(self : NlpparsecfgModel) -> Double { @_common.min(self.data) }

pub fn NlpparsecfgModel::max(self : NlpparsecfgModel) -> Double { @_common.max(self.data) }

pub fn NlpparsecfgModel::to_string(self : NlpparsecfgModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_layer_make(size : Int) -> NlpparsecfgLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsecfgLayer::len(self : NlpparsecfgLayer) -> Int { self.size }

pub fn NlpparsecfgLayer::get(self : NlpparsecfgLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsecfgLayer::set(self : NlpparsecfgLayer, i : Int, v : Double) -> NlpparsecfgLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsecfgLayer::sum(self : NlpparsecfgLayer) -> Double { @_common.sum(self.data) }

pub fn NlpparsecfgLayer::mean(self : NlpparsecfgLayer) -> Double { @_common.mean(self.data) }

pub fn NlpparsecfgLayer::scale(self : NlpparsecfgLayer, f : Double) -> NlpparsecfgLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgLayer::add(self : NlpparsecfgLayer, other : NlpparsecfgLayer) -> NlpparsecfgLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsecfgLayer::copy(self : NlpparsecfgLayer) -> NlpparsecfgLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgLayer::fill(self : NlpparsecfgLayer, v : Double) -> NlpparsecfgLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgLayer::min(self : NlpparsecfgLayer) -> Double { @_common.min(self.data) }

pub fn NlpparsecfgLayer::max(self : NlpparsecfgLayer) -> Double { @_common.max(self.data) }

pub fn NlpparsecfgLayer::to_string(self : NlpparsecfgLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_buffer_make(size : Int) -> NlpparsecfgBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsecfgBuffer::len(self : NlpparsecfgBuffer) -> Int { self.size }

pub fn NlpparsecfgBuffer::get(self : NlpparsecfgBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsecfgBuffer::set(self : NlpparsecfgBuffer, i : Int, v : Double) -> NlpparsecfgBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsecfgBuffer::sum(self : NlpparsecfgBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpparsecfgBuffer::mean(self : NlpparsecfgBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpparsecfgBuffer::scale(self : NlpparsecfgBuffer, f : Double) -> NlpparsecfgBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgBuffer::add(self : NlpparsecfgBuffer, other : NlpparsecfgBuffer) -> NlpparsecfgBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsecfgBuffer::copy(self : NlpparsecfgBuffer) -> NlpparsecfgBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgBuffer::fill(self : NlpparsecfgBuffer, v : Double) -> NlpparsecfgBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgBuffer::min(self : NlpparsecfgBuffer) -> Double { @_common.min(self.data) }

pub fn NlpparsecfgBuffer::max(self : NlpparsecfgBuffer) -> Double { @_common.max(self.data) }

pub fn NlpparsecfgBuffer::to_string(self : NlpparsecfgBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_cursor_make(size : Int) -> NlpparsecfgCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsecfgCursor::len(self : NlpparsecfgCursor) -> Int { self.size }

pub fn NlpparsecfgCursor::get(self : NlpparsecfgCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsecfgCursor::set(self : NlpparsecfgCursor, i : Int, v : Double) -> NlpparsecfgCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsecfgCursor::sum(self : NlpparsecfgCursor) -> Double { @_common.sum(self.data) }

pub fn NlpparsecfgCursor::mean(self : NlpparsecfgCursor) -> Double { @_common.mean(self.data) }

pub fn NlpparsecfgCursor::scale(self : NlpparsecfgCursor, f : Double) -> NlpparsecfgCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgCursor::add(self : NlpparsecfgCursor, other : NlpparsecfgCursor) -> NlpparsecfgCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsecfgCursor::copy(self : NlpparsecfgCursor) -> NlpparsecfgCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgCursor::fill(self : NlpparsecfgCursor, v : Double) -> NlpparsecfgCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgCursor::min(self : NlpparsecfgCursor) -> Double { @_common.min(self.data) }

pub fn NlpparsecfgCursor::max(self : NlpparsecfgCursor) -> Double { @_common.max(self.data) }

pub fn NlpparsecfgCursor::to_string(self : NlpparsecfgCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_view_make(size : Int) -> NlpparsecfgView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsecfgView::len(self : NlpparsecfgView) -> Int { self.size }

pub fn NlpparsecfgView::get(self : NlpparsecfgView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsecfgView::set(self : NlpparsecfgView, i : Int, v : Double) -> NlpparsecfgView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsecfgView::sum(self : NlpparsecfgView) -> Double { @_common.sum(self.data) }

pub fn NlpparsecfgView::mean(self : NlpparsecfgView) -> Double { @_common.mean(self.data) }

pub fn NlpparsecfgView::scale(self : NlpparsecfgView, f : Double) -> NlpparsecfgView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgView::add(self : NlpparsecfgView, other : NlpparsecfgView) -> NlpparsecfgView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsecfgView::copy(self : NlpparsecfgView) -> NlpparsecfgView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgView::fill(self : NlpparsecfgView, v : Double) -> NlpparsecfgView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgView::min(self : NlpparsecfgView) -> Double { @_common.min(self.data) }

pub fn NlpparsecfgView::max(self : NlpparsecfgView) -> Double { @_common.max(self.data) }

pub fn NlpparsecfgView::to_string(self : NlpparsecfgView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_range_make(size : Int) -> NlpparsecfgRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsecfgRange::len(self : NlpparsecfgRange) -> Int { self.size }

pub fn NlpparsecfgRange::get(self : NlpparsecfgRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsecfgRange::set(self : NlpparsecfgRange, i : Int, v : Double) -> NlpparsecfgRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsecfgRange::sum(self : NlpparsecfgRange) -> Double { @_common.sum(self.data) }

pub fn NlpparsecfgRange::mean(self : NlpparsecfgRange) -> Double { @_common.mean(self.data) }

pub fn NlpparsecfgRange::scale(self : NlpparsecfgRange, f : Double) -> NlpparsecfgRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgRange::add(self : NlpparsecfgRange, other : NlpparsecfgRange) -> NlpparsecfgRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsecfgRange::copy(self : NlpparsecfgRange) -> NlpparsecfgRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgRange::fill(self : NlpparsecfgRange, v : Double) -> NlpparsecfgRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgRange::min(self : NlpparsecfgRange) -> Double { @_common.min(self.data) }

pub fn NlpparsecfgRange::max(self : NlpparsecfgRange) -> Double { @_common.max(self.data) }

pub fn NlpparsecfgRange::to_string(self : NlpparsecfgRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_slice_make(size : Int) -> NlpparsecfgSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsecfgSlice::len(self : NlpparsecfgSlice) -> Int { self.size }

pub fn NlpparsecfgSlice::get(self : NlpparsecfgSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsecfgSlice::set(self : NlpparsecfgSlice, i : Int, v : Double) -> NlpparsecfgSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsecfgSlice::sum(self : NlpparsecfgSlice) -> Double { @_common.sum(self.data) }

pub fn NlpparsecfgSlice::mean(self : NlpparsecfgSlice) -> Double { @_common.mean(self.data) }

pub fn NlpparsecfgSlice::scale(self : NlpparsecfgSlice, f : Double) -> NlpparsecfgSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgSlice::add(self : NlpparsecfgSlice, other : NlpparsecfgSlice) -> NlpparsecfgSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsecfgSlice::copy(self : NlpparsecfgSlice) -> NlpparsecfgSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgSlice::fill(self : NlpparsecfgSlice, v : Double) -> NlpparsecfgSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsecfgSlice::min(self : NlpparsecfgSlice) -> Double { @_common.min(self.data) }

pub fn NlpparsecfgSlice::max(self : NlpparsecfgSlice) -> Double { @_common.max(self.data) }

pub fn NlpparsecfgSlice::to_string(self : NlpparsecfgSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

