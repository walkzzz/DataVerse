///===
/// extcore/geo_dist_great_circle

pub(all) struct GeodistgreatcirclePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_great_circle_make_point(x : Double, y : Double) -> GeodistgreatcirclePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_great_circle_make_point3(x : Double, y : Double, z : Double) -> GeodistgreatcirclePoint {
  { x, y, z, label: 0 }
}

pub fn GeodistgreatcirclePoint::x(self : GeodistgreatcirclePoint) -> Double { self.x }

pub fn GeodistgreatcirclePoint::y(self : GeodistgreatcirclePoint) -> Double { self.y }

pub fn GeodistgreatcirclePoint::z(self : GeodistgreatcirclePoint) -> Double { self.z }

pub fn GeodistgreatcirclePoint::label(self : GeodistgreatcirclePoint) -> Int { self.label }

pub fn GeodistgreatcirclePoint::dist(self : GeodistgreatcirclePoint, other : GeodistgreatcirclePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodistgreatcirclePoint::add(self : GeodistgreatcirclePoint, other : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodistgreatcirclePoint::sub(self : GeodistgreatcirclePoint, other : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodistgreatcirclePoint::scale(self : GeodistgreatcirclePoint, s : Double) -> GeodistgreatcirclePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodistgreatcirclePoint::dot(self : GeodistgreatcirclePoint, other : GeodistgreatcirclePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodistgreatcirclePoint::cross(self : GeodistgreatcirclePoint, other : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodistgreatcirclePoint::norm(self : GeodistgreatcirclePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodistgreatcirclePoint::normalize(self : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistgreatcirclePoint::negate(self : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodistgreatcirclePoint::mid(self : GeodistgreatcirclePoint, other : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodistgreatcirclePoint::lerp(self : GeodistgreatcirclePoint, other : GeodistgreatcirclePoint, t : Double) -> GeodistgreatcirclePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodistgreatcirclePoint::to_string(self : GeodistgreatcirclePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodistgreatcircleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_great_circle_make_series(vals : Array[Double], name : String) -> GeodistgreatcircleSeries {
  { vals, name, meta: 0 }
}

pub fn GeodistgreatcircleSeries::len(self : GeodistgreatcircleSeries) -> Int { self.vals.length() }

pub fn GeodistgreatcircleSeries::sum(self : GeodistgreatcircleSeries) -> Double { @_common.sum(self.vals) }

pub fn GeodistgreatcircleSeries::mean(self : GeodistgreatcircleSeries) -> Double { @_common.mean(self.vals) }

pub fn GeodistgreatcircleSeries::min(self : GeodistgreatcircleSeries) -> Double { @_common.min(self.vals) }

pub fn GeodistgreatcircleSeries::max(self : GeodistgreatcircleSeries) -> Double { @_common.max(self.vals) }

pub fn GeodistgreatcircleSeries::range(self : GeodistgreatcircleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodistgreatcircleSeries::variance(self : GeodistgreatcircleSeries) -> Double { @_common.variance(self.vals) }

pub fn GeodistgreatcircleSeries::std(self : GeodistgreatcircleSeries) -> Double { @_common.std(self.vals) }

pub fn GeodistgreatcircleSeries::median(self : GeodistgreatcircleSeries) -> Double { @_common.median(self.vals) }

pub fn GeodistgreatcircleSeries::scale(self : GeodistgreatcircleSeries, f : Double) -> GeodistgreatcircleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodistgreatcircleSeries::add(self : GeodistgreatcircleSeries, other : GeodistgreatcircleSeries) -> GeodistgreatcircleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodistgreatcircleSeries::sub(self : GeodistgreatcircleSeries, other : GeodistgreatcircleSeries) -> GeodistgreatcircleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodistgreatcircleSeries::normalize(self : GeodistgreatcircleSeries) -> GeodistgreatcircleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodistgreatcircleSeries::cumsum(self : GeodistgreatcircleSeries) -> GeodistgreatcircleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodistgreatcircleSeries::to_string(self : GeodistgreatcircleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistgreatcircleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_great_circle_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistgreatcircleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_great_circle_matrix_identity(n : Int) -> GeodistgreatcircleMatrix {
  let m = geo_dist_great_circle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodistgreatcircleMatrix::get(self : GeodistgreatcircleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodistgreatcircleMatrix::transpose(self : GeodistgreatcircleMatrix) -> GeodistgreatcircleMatrix {
  let result = geo_dist_great_circle_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodistgreatcircleMatrix::add(self : GeodistgreatcircleMatrix, other : GeodistgreatcircleMatrix) -> GeodistgreatcircleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_great_circle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodistgreatcircleMatrix::scale(self : GeodistgreatcircleMatrix, s : Double) -> GeodistgreatcircleMatrix {
  let result = geo_dist_great_circle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodistgreatcircleMatrix::multiply(self : GeodistgreatcircleMatrix, other : GeodistgreatcircleMatrix) -> GeodistgreatcircleMatrix {
  if self.cols != other.rows { return geo_dist_great_circle_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_great_circle_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeodistgreatcircleMatrix::trace(self : GeodistgreatcircleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodistgreatcircleMatrix::det(self : GeodistgreatcircleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodistgreatcircleMatrix::norm(self : GeodistgreatcircleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodistgreatcircleMatrix::to_string(self : GeodistgreatcircleMatrix) -> String {
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

pub(all) struct GeodistgreatcircleVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_great_circle_make_vector(comps : Array[Double]) -> GeodistgreatcircleVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_great_circle_vector_zero(dim : Int) -> GeodistgreatcircleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodistgreatcircleVector::add(self : GeodistgreatcircleVector, other : GeodistgreatcircleVector) -> GeodistgreatcircleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistgreatcircleVector::sub(self : GeodistgreatcircleVector, other : GeodistgreatcircleVector) -> GeodistgreatcircleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistgreatcircleVector::scale(self : GeodistgreatcircleVector, s : Double) -> GeodistgreatcircleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodistgreatcircleVector::dot(self : GeodistgreatcircleVector, other : GeodistgreatcircleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodistgreatcircleVector::norm(self : GeodistgreatcircleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodistgreatcircleVector::normalize(self : GeodistgreatcircleVector) -> GeodistgreatcircleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistgreatcircleVector::dist(self : GeodistgreatcircleVector, other : GeodistgreatcircleVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodistgreatcircleVector::to_string(self : GeodistgreatcircleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_great_circle_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_great_circle_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_great_circle_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_great_circle_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_great_circle_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_great_circle_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_great_circle_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_great_circle_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_great_circle_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_great_circle_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_great_circle_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_great_circle_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_great_circle_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_great_circle_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_great_circle_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_great_circle_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_great_circle_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_great_circle_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_great_circle_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_great_circle_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_great_circle_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_great_circle_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_great_circle_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_great_circle_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_great_circle_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_great_circle_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_great_circle_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_great_circle_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_great_circle_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistgreatcircleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_frame_make(size : Int) -> GeodistgreatcircleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgreatcircleFrame::len(self : GeodistgreatcircleFrame) -> Int { self.size }

pub fn GeodistgreatcircleFrame::get(self : GeodistgreatcircleFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgreatcircleFrame::set(self : GeodistgreatcircleFrame, i : Int, v : Double) -> GeodistgreatcircleFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleFrame::sum(self : GeodistgreatcircleFrame) -> Double { @_common.sum(self.data) }

pub fn GeodistgreatcircleFrame::mean(self : GeodistgreatcircleFrame) -> Double { @_common.mean(self.data) }

pub fn GeodistgreatcircleFrame::scale(self : GeodistgreatcircleFrame, f : Double) -> GeodistgreatcircleFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleFrame::add(self : GeodistgreatcircleFrame, other : GeodistgreatcircleFrame) -> GeodistgreatcircleFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgreatcircleFrame::copy(self : GeodistgreatcircleFrame) -> GeodistgreatcircleFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleFrame::fill(self : GeodistgreatcircleFrame, v : Double) -> GeodistgreatcircleFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleFrame::min(self : GeodistgreatcircleFrame) -> Double { @_common.min(self.data) }

pub fn GeodistgreatcircleFrame::max(self : GeodistgreatcircleFrame) -> Double { @_common.max(self.data) }

pub fn GeodistgreatcircleFrame::to_string(self : GeodistgreatcircleFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_table_make(size : Int) -> GeodistgreatcircleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgreatcircleTable::len(self : GeodistgreatcircleTable) -> Int { self.size }

pub fn GeodistgreatcircleTable::get(self : GeodistgreatcircleTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgreatcircleTable::set(self : GeodistgreatcircleTable, i : Int, v : Double) -> GeodistgreatcircleTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleTable::sum(self : GeodistgreatcircleTable) -> Double { @_common.sum(self.data) }

pub fn GeodistgreatcircleTable::mean(self : GeodistgreatcircleTable) -> Double { @_common.mean(self.data) }

pub fn GeodistgreatcircleTable::scale(self : GeodistgreatcircleTable, f : Double) -> GeodistgreatcircleTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleTable::add(self : GeodistgreatcircleTable, other : GeodistgreatcircleTable) -> GeodistgreatcircleTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgreatcircleTable::copy(self : GeodistgreatcircleTable) -> GeodistgreatcircleTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleTable::fill(self : GeodistgreatcircleTable, v : Double) -> GeodistgreatcircleTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleTable::min(self : GeodistgreatcircleTable) -> Double { @_common.min(self.data) }

pub fn GeodistgreatcircleTable::max(self : GeodistgreatcircleTable) -> Double { @_common.max(self.data) }

pub fn GeodistgreatcircleTable::to_string(self : GeodistgreatcircleTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_graphn_make(size : Int) -> GeodistgreatcircleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgreatcircleGraphN::len(self : GeodistgreatcircleGraphN) -> Int { self.size }

pub fn GeodistgreatcircleGraphN::get(self : GeodistgreatcircleGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgreatcircleGraphN::set(self : GeodistgreatcircleGraphN, i : Int, v : Double) -> GeodistgreatcircleGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleGraphN::sum(self : GeodistgreatcircleGraphN) -> Double { @_common.sum(self.data) }

pub fn GeodistgreatcircleGraphN::mean(self : GeodistgreatcircleGraphN) -> Double { @_common.mean(self.data) }

pub fn GeodistgreatcircleGraphN::scale(self : GeodistgreatcircleGraphN, f : Double) -> GeodistgreatcircleGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleGraphN::add(self : GeodistgreatcircleGraphN, other : GeodistgreatcircleGraphN) -> GeodistgreatcircleGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgreatcircleGraphN::copy(self : GeodistgreatcircleGraphN) -> GeodistgreatcircleGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleGraphN::fill(self : GeodistgreatcircleGraphN, v : Double) -> GeodistgreatcircleGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleGraphN::min(self : GeodistgreatcircleGraphN) -> Double { @_common.min(self.data) }

pub fn GeodistgreatcircleGraphN::max(self : GeodistgreatcircleGraphN) -> Double { @_common.max(self.data) }

pub fn GeodistgreatcircleGraphN::to_string(self : GeodistgreatcircleGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_node_make(size : Int) -> GeodistgreatcircleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgreatcircleNode::len(self : GeodistgreatcircleNode) -> Int { self.size }

pub fn GeodistgreatcircleNode::get(self : GeodistgreatcircleNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgreatcircleNode::set(self : GeodistgreatcircleNode, i : Int, v : Double) -> GeodistgreatcircleNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleNode::sum(self : GeodistgreatcircleNode) -> Double { @_common.sum(self.data) }

pub fn GeodistgreatcircleNode::mean(self : GeodistgreatcircleNode) -> Double { @_common.mean(self.data) }

pub fn GeodistgreatcircleNode::scale(self : GeodistgreatcircleNode, f : Double) -> GeodistgreatcircleNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleNode::add(self : GeodistgreatcircleNode, other : GeodistgreatcircleNode) -> GeodistgreatcircleNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgreatcircleNode::copy(self : GeodistgreatcircleNode) -> GeodistgreatcircleNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleNode::fill(self : GeodistgreatcircleNode, v : Double) -> GeodistgreatcircleNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleNode::min(self : GeodistgreatcircleNode) -> Double { @_common.min(self.data) }

pub fn GeodistgreatcircleNode::max(self : GeodistgreatcircleNode) -> Double { @_common.max(self.data) }

pub fn GeodistgreatcircleNode::to_string(self : GeodistgreatcircleNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_edge_make(size : Int) -> GeodistgreatcircleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgreatcircleEdge::len(self : GeodistgreatcircleEdge) -> Int { self.size }

pub fn GeodistgreatcircleEdge::get(self : GeodistgreatcircleEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgreatcircleEdge::set(self : GeodistgreatcircleEdge, i : Int, v : Double) -> GeodistgreatcircleEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleEdge::sum(self : GeodistgreatcircleEdge) -> Double { @_common.sum(self.data) }

pub fn GeodistgreatcircleEdge::mean(self : GeodistgreatcircleEdge) -> Double { @_common.mean(self.data) }

pub fn GeodistgreatcircleEdge::scale(self : GeodistgreatcircleEdge, f : Double) -> GeodistgreatcircleEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleEdge::add(self : GeodistgreatcircleEdge, other : GeodistgreatcircleEdge) -> GeodistgreatcircleEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgreatcircleEdge::copy(self : GeodistgreatcircleEdge) -> GeodistgreatcircleEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleEdge::fill(self : GeodistgreatcircleEdge, v : Double) -> GeodistgreatcircleEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleEdge::min(self : GeodistgreatcircleEdge) -> Double { @_common.min(self.data) }

pub fn GeodistgreatcircleEdge::max(self : GeodistgreatcircleEdge) -> Double { @_common.max(self.data) }

pub fn GeodistgreatcircleEdge::to_string(self : GeodistgreatcircleEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcirclePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_path_make(size : Int) -> GeodistgreatcirclePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgreatcirclePath::len(self : GeodistgreatcirclePath) -> Int { self.size }

pub fn GeodistgreatcirclePath::get(self : GeodistgreatcirclePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgreatcirclePath::set(self : GeodistgreatcirclePath, i : Int, v : Double) -> GeodistgreatcirclePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgreatcirclePath::sum(self : GeodistgreatcirclePath) -> Double { @_common.sum(self.data) }

pub fn GeodistgreatcirclePath::mean(self : GeodistgreatcirclePath) -> Double { @_common.mean(self.data) }

pub fn GeodistgreatcirclePath::scale(self : GeodistgreatcirclePath, f : Double) -> GeodistgreatcirclePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcirclePath::add(self : GeodistgreatcirclePath, other : GeodistgreatcirclePath) -> GeodistgreatcirclePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgreatcirclePath::copy(self : GeodistgreatcirclePath) -> GeodistgreatcirclePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcirclePath::fill(self : GeodistgreatcirclePath, v : Double) -> GeodistgreatcirclePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcirclePath::min(self : GeodistgreatcirclePath) -> Double { @_common.min(self.data) }

pub fn GeodistgreatcirclePath::max(self : GeodistgreatcirclePath) -> Double { @_common.max(self.data) }

pub fn GeodistgreatcirclePath::to_string(self : GeodistgreatcirclePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_cluster_make(size : Int) -> GeodistgreatcircleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgreatcircleCluster::len(self : GeodistgreatcircleCluster) -> Int { self.size }

pub fn GeodistgreatcircleCluster::get(self : GeodistgreatcircleCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgreatcircleCluster::set(self : GeodistgreatcircleCluster, i : Int, v : Double) -> GeodistgreatcircleCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleCluster::sum(self : GeodistgreatcircleCluster) -> Double { @_common.sum(self.data) }

pub fn GeodistgreatcircleCluster::mean(self : GeodistgreatcircleCluster) -> Double { @_common.mean(self.data) }

pub fn GeodistgreatcircleCluster::scale(self : GeodistgreatcircleCluster, f : Double) -> GeodistgreatcircleCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleCluster::add(self : GeodistgreatcircleCluster, other : GeodistgreatcircleCluster) -> GeodistgreatcircleCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgreatcircleCluster::copy(self : GeodistgreatcircleCluster) -> GeodistgreatcircleCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleCluster::fill(self : GeodistgreatcircleCluster, v : Double) -> GeodistgreatcircleCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleCluster::min(self : GeodistgreatcircleCluster) -> Double { @_common.min(self.data) }

pub fn GeodistgreatcircleCluster::max(self : GeodistgreatcircleCluster) -> Double { @_common.max(self.data) }

pub fn GeodistgreatcircleCluster::to_string(self : GeodistgreatcircleCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_model_make(size : Int) -> GeodistgreatcircleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgreatcircleModel::len(self : GeodistgreatcircleModel) -> Int { self.size }

pub fn GeodistgreatcircleModel::get(self : GeodistgreatcircleModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgreatcircleModel::set(self : GeodistgreatcircleModel, i : Int, v : Double) -> GeodistgreatcircleModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleModel::sum(self : GeodistgreatcircleModel) -> Double { @_common.sum(self.data) }

pub fn GeodistgreatcircleModel::mean(self : GeodistgreatcircleModel) -> Double { @_common.mean(self.data) }

pub fn GeodistgreatcircleModel::scale(self : GeodistgreatcircleModel, f : Double) -> GeodistgreatcircleModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleModel::add(self : GeodistgreatcircleModel, other : GeodistgreatcircleModel) -> GeodistgreatcircleModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgreatcircleModel::copy(self : GeodistgreatcircleModel) -> GeodistgreatcircleModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleModel::fill(self : GeodistgreatcircleModel, v : Double) -> GeodistgreatcircleModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleModel::min(self : GeodistgreatcircleModel) -> Double { @_common.min(self.data) }

pub fn GeodistgreatcircleModel::max(self : GeodistgreatcircleModel) -> Double { @_common.max(self.data) }

pub fn GeodistgreatcircleModel::to_string(self : GeodistgreatcircleModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_layer_make(size : Int) -> GeodistgreatcircleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgreatcircleLayer::len(self : GeodistgreatcircleLayer) -> Int { self.size }

pub fn GeodistgreatcircleLayer::get(self : GeodistgreatcircleLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgreatcircleLayer::set(self : GeodistgreatcircleLayer, i : Int, v : Double) -> GeodistgreatcircleLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleLayer::sum(self : GeodistgreatcircleLayer) -> Double { @_common.sum(self.data) }

pub fn GeodistgreatcircleLayer::mean(self : GeodistgreatcircleLayer) -> Double { @_common.mean(self.data) }

pub fn GeodistgreatcircleLayer::scale(self : GeodistgreatcircleLayer, f : Double) -> GeodistgreatcircleLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleLayer::add(self : GeodistgreatcircleLayer, other : GeodistgreatcircleLayer) -> GeodistgreatcircleLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgreatcircleLayer::copy(self : GeodistgreatcircleLayer) -> GeodistgreatcircleLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleLayer::fill(self : GeodistgreatcircleLayer, v : Double) -> GeodistgreatcircleLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleLayer::min(self : GeodistgreatcircleLayer) -> Double { @_common.min(self.data) }

pub fn GeodistgreatcircleLayer::max(self : GeodistgreatcircleLayer) -> Double { @_common.max(self.data) }

pub fn GeodistgreatcircleLayer::to_string(self : GeodistgreatcircleLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_buffer_make(size : Int) -> GeodistgreatcircleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgreatcircleBuffer::len(self : GeodistgreatcircleBuffer) -> Int { self.size }

pub fn GeodistgreatcircleBuffer::get(self : GeodistgreatcircleBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgreatcircleBuffer::set(self : GeodistgreatcircleBuffer, i : Int, v : Double) -> GeodistgreatcircleBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleBuffer::sum(self : GeodistgreatcircleBuffer) -> Double { @_common.sum(self.data) }

pub fn GeodistgreatcircleBuffer::mean(self : GeodistgreatcircleBuffer) -> Double { @_common.mean(self.data) }

pub fn GeodistgreatcircleBuffer::scale(self : GeodistgreatcircleBuffer, f : Double) -> GeodistgreatcircleBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleBuffer::add(self : GeodistgreatcircleBuffer, other : GeodistgreatcircleBuffer) -> GeodistgreatcircleBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgreatcircleBuffer::copy(self : GeodistgreatcircleBuffer) -> GeodistgreatcircleBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleBuffer::fill(self : GeodistgreatcircleBuffer, v : Double) -> GeodistgreatcircleBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleBuffer::min(self : GeodistgreatcircleBuffer) -> Double { @_common.min(self.data) }

pub fn GeodistgreatcircleBuffer::max(self : GeodistgreatcircleBuffer) -> Double { @_common.max(self.data) }

pub fn GeodistgreatcircleBuffer::to_string(self : GeodistgreatcircleBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_cursor_make(size : Int) -> GeodistgreatcircleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgreatcircleCursor::len(self : GeodistgreatcircleCursor) -> Int { self.size }

pub fn GeodistgreatcircleCursor::get(self : GeodistgreatcircleCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgreatcircleCursor::set(self : GeodistgreatcircleCursor, i : Int, v : Double) -> GeodistgreatcircleCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleCursor::sum(self : GeodistgreatcircleCursor) -> Double { @_common.sum(self.data) }

pub fn GeodistgreatcircleCursor::mean(self : GeodistgreatcircleCursor) -> Double { @_common.mean(self.data) }

pub fn GeodistgreatcircleCursor::scale(self : GeodistgreatcircleCursor, f : Double) -> GeodistgreatcircleCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleCursor::add(self : GeodistgreatcircleCursor, other : GeodistgreatcircleCursor) -> GeodistgreatcircleCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgreatcircleCursor::copy(self : GeodistgreatcircleCursor) -> GeodistgreatcircleCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleCursor::fill(self : GeodistgreatcircleCursor, v : Double) -> GeodistgreatcircleCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleCursor::min(self : GeodistgreatcircleCursor) -> Double { @_common.min(self.data) }

pub fn GeodistgreatcircleCursor::max(self : GeodistgreatcircleCursor) -> Double { @_common.max(self.data) }

pub fn GeodistgreatcircleCursor::to_string(self : GeodistgreatcircleCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_view_make(size : Int) -> GeodistgreatcircleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgreatcircleView::len(self : GeodistgreatcircleView) -> Int { self.size }

pub fn GeodistgreatcircleView::get(self : GeodistgreatcircleView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgreatcircleView::set(self : GeodistgreatcircleView, i : Int, v : Double) -> GeodistgreatcircleView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleView::sum(self : GeodistgreatcircleView) -> Double { @_common.sum(self.data) }

pub fn GeodistgreatcircleView::mean(self : GeodistgreatcircleView) -> Double { @_common.mean(self.data) }

pub fn GeodistgreatcircleView::scale(self : GeodistgreatcircleView, f : Double) -> GeodistgreatcircleView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleView::add(self : GeodistgreatcircleView, other : GeodistgreatcircleView) -> GeodistgreatcircleView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgreatcircleView::copy(self : GeodistgreatcircleView) -> GeodistgreatcircleView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleView::fill(self : GeodistgreatcircleView, v : Double) -> GeodistgreatcircleView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleView::min(self : GeodistgreatcircleView) -> Double { @_common.min(self.data) }

pub fn GeodistgreatcircleView::max(self : GeodistgreatcircleView) -> Double { @_common.max(self.data) }

pub fn GeodistgreatcircleView::to_string(self : GeodistgreatcircleView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_range_make(size : Int) -> GeodistgreatcircleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgreatcircleRange::len(self : GeodistgreatcircleRange) -> Int { self.size }

pub fn GeodistgreatcircleRange::get(self : GeodistgreatcircleRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgreatcircleRange::set(self : GeodistgreatcircleRange, i : Int, v : Double) -> GeodistgreatcircleRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleRange::sum(self : GeodistgreatcircleRange) -> Double { @_common.sum(self.data) }

pub fn GeodistgreatcircleRange::mean(self : GeodistgreatcircleRange) -> Double { @_common.mean(self.data) }

pub fn GeodistgreatcircleRange::scale(self : GeodistgreatcircleRange, f : Double) -> GeodistgreatcircleRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleRange::add(self : GeodistgreatcircleRange, other : GeodistgreatcircleRange) -> GeodistgreatcircleRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgreatcircleRange::copy(self : GeodistgreatcircleRange) -> GeodistgreatcircleRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleRange::fill(self : GeodistgreatcircleRange, v : Double) -> GeodistgreatcircleRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleRange::min(self : GeodistgreatcircleRange) -> Double { @_common.min(self.data) }

pub fn GeodistgreatcircleRange::max(self : GeodistgreatcircleRange) -> Double { @_common.max(self.data) }

pub fn GeodistgreatcircleRange::to_string(self : GeodistgreatcircleRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_slice_make(size : Int) -> GeodistgreatcircleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgreatcircleSlice::len(self : GeodistgreatcircleSlice) -> Int { self.size }

pub fn GeodistgreatcircleSlice::get(self : GeodistgreatcircleSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgreatcircleSlice::set(self : GeodistgreatcircleSlice, i : Int, v : Double) -> GeodistgreatcircleSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleSlice::sum(self : GeodistgreatcircleSlice) -> Double { @_common.sum(self.data) }

pub fn GeodistgreatcircleSlice::mean(self : GeodistgreatcircleSlice) -> Double { @_common.mean(self.data) }

pub fn GeodistgreatcircleSlice::scale(self : GeodistgreatcircleSlice, f : Double) -> GeodistgreatcircleSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleSlice::add(self : GeodistgreatcircleSlice, other : GeodistgreatcircleSlice) -> GeodistgreatcircleSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgreatcircleSlice::copy(self : GeodistgreatcircleSlice) -> GeodistgreatcircleSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleSlice::fill(self : GeodistgreatcircleSlice, v : Double) -> GeodistgreatcircleSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgreatcircleSlice::min(self : GeodistgreatcircleSlice) -> Double { @_common.min(self.data) }

pub fn GeodistgreatcircleSlice::max(self : GeodistgreatcircleSlice) -> Double { @_common.max(self.data) }

pub fn GeodistgreatcircleSlice::to_string(self : GeodistgreatcircleSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

