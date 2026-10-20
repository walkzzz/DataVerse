///===
/// extcore/geo_proj_gnomonic

pub(all) struct GeoprojgnomonicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_gnomonic_make_point(x : Double, y : Double) -> GeoprojgnomonicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_gnomonic_make_point3(x : Double, y : Double, z : Double) -> GeoprojgnomonicPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojgnomonicPoint::x(self : GeoprojgnomonicPoint) -> Double { self.x }

pub fn GeoprojgnomonicPoint::y(self : GeoprojgnomonicPoint) -> Double { self.y }

pub fn GeoprojgnomonicPoint::z(self : GeoprojgnomonicPoint) -> Double { self.z }

pub fn GeoprojgnomonicPoint::label(self : GeoprojgnomonicPoint) -> Int { self.label }

pub fn GeoprojgnomonicPoint::dist(self : GeoprojgnomonicPoint, other : GeoprojgnomonicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojgnomonicPoint::add(self : GeoprojgnomonicPoint, other : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojgnomonicPoint::sub(self : GeoprojgnomonicPoint, other : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojgnomonicPoint::scale(self : GeoprojgnomonicPoint, s : Double) -> GeoprojgnomonicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojgnomonicPoint::dot(self : GeoprojgnomonicPoint, other : GeoprojgnomonicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojgnomonicPoint::cross(self : GeoprojgnomonicPoint, other : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojgnomonicPoint::norm(self : GeoprojgnomonicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojgnomonicPoint::normalize(self : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojgnomonicPoint::negate(self : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojgnomonicPoint::mid(self : GeoprojgnomonicPoint, other : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojgnomonicPoint::lerp(self : GeoprojgnomonicPoint, other : GeoprojgnomonicPoint, t : Double) -> GeoprojgnomonicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojgnomonicPoint::to_string(self : GeoprojgnomonicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojgnomonicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_gnomonic_make_series(vals : Array[Double], name : String) -> GeoprojgnomonicSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojgnomonicSeries::len(self : GeoprojgnomonicSeries) -> Int { self.vals.length() }

pub fn GeoprojgnomonicSeries::sum(self : GeoprojgnomonicSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojgnomonicSeries::mean(self : GeoprojgnomonicSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojgnomonicSeries::min(self : GeoprojgnomonicSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojgnomonicSeries::max(self : GeoprojgnomonicSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojgnomonicSeries::range(self : GeoprojgnomonicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojgnomonicSeries::variance(self : GeoprojgnomonicSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojgnomonicSeries::std(self : GeoprojgnomonicSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojgnomonicSeries::median(self : GeoprojgnomonicSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojgnomonicSeries::scale(self : GeoprojgnomonicSeries, f : Double) -> GeoprojgnomonicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojgnomonicSeries::add(self : GeoprojgnomonicSeries, other : GeoprojgnomonicSeries) -> GeoprojgnomonicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojgnomonicSeries::sub(self : GeoprojgnomonicSeries, other : GeoprojgnomonicSeries) -> GeoprojgnomonicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojgnomonicSeries::normalize(self : GeoprojgnomonicSeries) -> GeoprojgnomonicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojgnomonicSeries::cumsum(self : GeoprojgnomonicSeries) -> GeoprojgnomonicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojgnomonicSeries::to_string(self : GeoprojgnomonicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojgnomonicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_gnomonic_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojgnomonicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_gnomonic_matrix_identity(n : Int) -> GeoprojgnomonicMatrix {
  let m = geo_proj_gnomonic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojgnomonicMatrix::get(self : GeoprojgnomonicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojgnomonicMatrix::transpose(self : GeoprojgnomonicMatrix) -> GeoprojgnomonicMatrix {
  let result = geo_proj_gnomonic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojgnomonicMatrix::add(self : GeoprojgnomonicMatrix, other : GeoprojgnomonicMatrix) -> GeoprojgnomonicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_gnomonic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojgnomonicMatrix::scale(self : GeoprojgnomonicMatrix, s : Double) -> GeoprojgnomonicMatrix {
  let result = geo_proj_gnomonic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojgnomonicMatrix::multiply(self : GeoprojgnomonicMatrix, other : GeoprojgnomonicMatrix) -> GeoprojgnomonicMatrix {
  if self.cols != other.rows { return geo_proj_gnomonic_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_gnomonic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeoprojgnomonicMatrix::trace(self : GeoprojgnomonicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojgnomonicMatrix::det(self : GeoprojgnomonicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojgnomonicMatrix::norm(self : GeoprojgnomonicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojgnomonicMatrix::to_string(self : GeoprojgnomonicMatrix) -> String {
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

pub(all) struct GeoprojgnomonicVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_gnomonic_make_vector(comps : Array[Double]) -> GeoprojgnomonicVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_gnomonic_vector_zero(dim : Int) -> GeoprojgnomonicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojgnomonicVector::add(self : GeoprojgnomonicVector, other : GeoprojgnomonicVector) -> GeoprojgnomonicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojgnomonicVector::sub(self : GeoprojgnomonicVector, other : GeoprojgnomonicVector) -> GeoprojgnomonicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojgnomonicVector::scale(self : GeoprojgnomonicVector, s : Double) -> GeoprojgnomonicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojgnomonicVector::dot(self : GeoprojgnomonicVector, other : GeoprojgnomonicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojgnomonicVector::norm(self : GeoprojgnomonicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojgnomonicVector::normalize(self : GeoprojgnomonicVector) -> GeoprojgnomonicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojgnomonicVector::dist(self : GeoprojgnomonicVector, other : GeoprojgnomonicVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojgnomonicVector::to_string(self : GeoprojgnomonicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_gnomonic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_gnomonic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_gnomonic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_gnomonic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_gnomonic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_gnomonic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_gnomonic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_gnomonic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_gnomonic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_gnomonic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_gnomonic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_gnomonic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_gnomonic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_gnomonic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_gnomonic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_gnomonic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_gnomonic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_gnomonic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_gnomonic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_gnomonic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_gnomonic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_gnomonic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_gnomonic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_gnomonic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_gnomonic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_gnomonic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_gnomonic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_gnomonic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_gnomonic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojgnomonicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_frame_make(size : Int) -> GeoprojgnomonicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojgnomonicFrame::len(self : GeoprojgnomonicFrame) -> Int { self.size }

pub fn GeoprojgnomonicFrame::get(self : GeoprojgnomonicFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojgnomonicFrame::set(self : GeoprojgnomonicFrame, i : Int, v : Double) -> GeoprojgnomonicFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicFrame::sum(self : GeoprojgnomonicFrame) -> Double { @_common.sum(self.data) }

pub fn GeoprojgnomonicFrame::mean(self : GeoprojgnomonicFrame) -> Double { @_common.mean(self.data) }

pub fn GeoprojgnomonicFrame::scale(self : GeoprojgnomonicFrame, f : Double) -> GeoprojgnomonicFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicFrame::add(self : GeoprojgnomonicFrame, other : GeoprojgnomonicFrame) -> GeoprojgnomonicFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojgnomonicFrame::copy(self : GeoprojgnomonicFrame) -> GeoprojgnomonicFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicFrame::fill(self : GeoprojgnomonicFrame, v : Double) -> GeoprojgnomonicFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicFrame::min(self : GeoprojgnomonicFrame) -> Double { @_common.min(self.data) }

pub fn GeoprojgnomonicFrame::max(self : GeoprojgnomonicFrame) -> Double { @_common.max(self.data) }

pub fn GeoprojgnomonicFrame::to_string(self : GeoprojgnomonicFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_table_make(size : Int) -> GeoprojgnomonicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojgnomonicTable::len(self : GeoprojgnomonicTable) -> Int { self.size }

pub fn GeoprojgnomonicTable::get(self : GeoprojgnomonicTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojgnomonicTable::set(self : GeoprojgnomonicTable, i : Int, v : Double) -> GeoprojgnomonicTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicTable::sum(self : GeoprojgnomonicTable) -> Double { @_common.sum(self.data) }

pub fn GeoprojgnomonicTable::mean(self : GeoprojgnomonicTable) -> Double { @_common.mean(self.data) }

pub fn GeoprojgnomonicTable::scale(self : GeoprojgnomonicTable, f : Double) -> GeoprojgnomonicTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicTable::add(self : GeoprojgnomonicTable, other : GeoprojgnomonicTable) -> GeoprojgnomonicTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojgnomonicTable::copy(self : GeoprojgnomonicTable) -> GeoprojgnomonicTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicTable::fill(self : GeoprojgnomonicTable, v : Double) -> GeoprojgnomonicTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicTable::min(self : GeoprojgnomonicTable) -> Double { @_common.min(self.data) }

pub fn GeoprojgnomonicTable::max(self : GeoprojgnomonicTable) -> Double { @_common.max(self.data) }

pub fn GeoprojgnomonicTable::to_string(self : GeoprojgnomonicTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_graphn_make(size : Int) -> GeoprojgnomonicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojgnomonicGraphN::len(self : GeoprojgnomonicGraphN) -> Int { self.size }

pub fn GeoprojgnomonicGraphN::get(self : GeoprojgnomonicGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojgnomonicGraphN::set(self : GeoprojgnomonicGraphN, i : Int, v : Double) -> GeoprojgnomonicGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicGraphN::sum(self : GeoprojgnomonicGraphN) -> Double { @_common.sum(self.data) }

pub fn GeoprojgnomonicGraphN::mean(self : GeoprojgnomonicGraphN) -> Double { @_common.mean(self.data) }

pub fn GeoprojgnomonicGraphN::scale(self : GeoprojgnomonicGraphN, f : Double) -> GeoprojgnomonicGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicGraphN::add(self : GeoprojgnomonicGraphN, other : GeoprojgnomonicGraphN) -> GeoprojgnomonicGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojgnomonicGraphN::copy(self : GeoprojgnomonicGraphN) -> GeoprojgnomonicGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicGraphN::fill(self : GeoprojgnomonicGraphN, v : Double) -> GeoprojgnomonicGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicGraphN::min(self : GeoprojgnomonicGraphN) -> Double { @_common.min(self.data) }

pub fn GeoprojgnomonicGraphN::max(self : GeoprojgnomonicGraphN) -> Double { @_common.max(self.data) }

pub fn GeoprojgnomonicGraphN::to_string(self : GeoprojgnomonicGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_node_make(size : Int) -> GeoprojgnomonicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojgnomonicNode::len(self : GeoprojgnomonicNode) -> Int { self.size }

pub fn GeoprojgnomonicNode::get(self : GeoprojgnomonicNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojgnomonicNode::set(self : GeoprojgnomonicNode, i : Int, v : Double) -> GeoprojgnomonicNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicNode::sum(self : GeoprojgnomonicNode) -> Double { @_common.sum(self.data) }

pub fn GeoprojgnomonicNode::mean(self : GeoprojgnomonicNode) -> Double { @_common.mean(self.data) }

pub fn GeoprojgnomonicNode::scale(self : GeoprojgnomonicNode, f : Double) -> GeoprojgnomonicNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicNode::add(self : GeoprojgnomonicNode, other : GeoprojgnomonicNode) -> GeoprojgnomonicNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojgnomonicNode::copy(self : GeoprojgnomonicNode) -> GeoprojgnomonicNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicNode::fill(self : GeoprojgnomonicNode, v : Double) -> GeoprojgnomonicNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicNode::min(self : GeoprojgnomonicNode) -> Double { @_common.min(self.data) }

pub fn GeoprojgnomonicNode::max(self : GeoprojgnomonicNode) -> Double { @_common.max(self.data) }

pub fn GeoprojgnomonicNode::to_string(self : GeoprojgnomonicNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_edge_make(size : Int) -> GeoprojgnomonicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojgnomonicEdge::len(self : GeoprojgnomonicEdge) -> Int { self.size }

pub fn GeoprojgnomonicEdge::get(self : GeoprojgnomonicEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojgnomonicEdge::set(self : GeoprojgnomonicEdge, i : Int, v : Double) -> GeoprojgnomonicEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicEdge::sum(self : GeoprojgnomonicEdge) -> Double { @_common.sum(self.data) }

pub fn GeoprojgnomonicEdge::mean(self : GeoprojgnomonicEdge) -> Double { @_common.mean(self.data) }

pub fn GeoprojgnomonicEdge::scale(self : GeoprojgnomonicEdge, f : Double) -> GeoprojgnomonicEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicEdge::add(self : GeoprojgnomonicEdge, other : GeoprojgnomonicEdge) -> GeoprojgnomonicEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojgnomonicEdge::copy(self : GeoprojgnomonicEdge) -> GeoprojgnomonicEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicEdge::fill(self : GeoprojgnomonicEdge, v : Double) -> GeoprojgnomonicEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicEdge::min(self : GeoprojgnomonicEdge) -> Double { @_common.min(self.data) }

pub fn GeoprojgnomonicEdge::max(self : GeoprojgnomonicEdge) -> Double { @_common.max(self.data) }

pub fn GeoprojgnomonicEdge::to_string(self : GeoprojgnomonicEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_path_make(size : Int) -> GeoprojgnomonicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojgnomonicPath::len(self : GeoprojgnomonicPath) -> Int { self.size }

pub fn GeoprojgnomonicPath::get(self : GeoprojgnomonicPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojgnomonicPath::set(self : GeoprojgnomonicPath, i : Int, v : Double) -> GeoprojgnomonicPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicPath::sum(self : GeoprojgnomonicPath) -> Double { @_common.sum(self.data) }

pub fn GeoprojgnomonicPath::mean(self : GeoprojgnomonicPath) -> Double { @_common.mean(self.data) }

pub fn GeoprojgnomonicPath::scale(self : GeoprojgnomonicPath, f : Double) -> GeoprojgnomonicPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicPath::add(self : GeoprojgnomonicPath, other : GeoprojgnomonicPath) -> GeoprojgnomonicPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojgnomonicPath::copy(self : GeoprojgnomonicPath) -> GeoprojgnomonicPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicPath::fill(self : GeoprojgnomonicPath, v : Double) -> GeoprojgnomonicPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicPath::min(self : GeoprojgnomonicPath) -> Double { @_common.min(self.data) }

pub fn GeoprojgnomonicPath::max(self : GeoprojgnomonicPath) -> Double { @_common.max(self.data) }

pub fn GeoprojgnomonicPath::to_string(self : GeoprojgnomonicPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_cluster_make(size : Int) -> GeoprojgnomonicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojgnomonicCluster::len(self : GeoprojgnomonicCluster) -> Int { self.size }

pub fn GeoprojgnomonicCluster::get(self : GeoprojgnomonicCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojgnomonicCluster::set(self : GeoprojgnomonicCluster, i : Int, v : Double) -> GeoprojgnomonicCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicCluster::sum(self : GeoprojgnomonicCluster) -> Double { @_common.sum(self.data) }

pub fn GeoprojgnomonicCluster::mean(self : GeoprojgnomonicCluster) -> Double { @_common.mean(self.data) }

pub fn GeoprojgnomonicCluster::scale(self : GeoprojgnomonicCluster, f : Double) -> GeoprojgnomonicCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicCluster::add(self : GeoprojgnomonicCluster, other : GeoprojgnomonicCluster) -> GeoprojgnomonicCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojgnomonicCluster::copy(self : GeoprojgnomonicCluster) -> GeoprojgnomonicCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicCluster::fill(self : GeoprojgnomonicCluster, v : Double) -> GeoprojgnomonicCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicCluster::min(self : GeoprojgnomonicCluster) -> Double { @_common.min(self.data) }

pub fn GeoprojgnomonicCluster::max(self : GeoprojgnomonicCluster) -> Double { @_common.max(self.data) }

pub fn GeoprojgnomonicCluster::to_string(self : GeoprojgnomonicCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_model_make(size : Int) -> GeoprojgnomonicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojgnomonicModel::len(self : GeoprojgnomonicModel) -> Int { self.size }

pub fn GeoprojgnomonicModel::get(self : GeoprojgnomonicModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojgnomonicModel::set(self : GeoprojgnomonicModel, i : Int, v : Double) -> GeoprojgnomonicModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicModel::sum(self : GeoprojgnomonicModel) -> Double { @_common.sum(self.data) }

pub fn GeoprojgnomonicModel::mean(self : GeoprojgnomonicModel) -> Double { @_common.mean(self.data) }

pub fn GeoprojgnomonicModel::scale(self : GeoprojgnomonicModel, f : Double) -> GeoprojgnomonicModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicModel::add(self : GeoprojgnomonicModel, other : GeoprojgnomonicModel) -> GeoprojgnomonicModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojgnomonicModel::copy(self : GeoprojgnomonicModel) -> GeoprojgnomonicModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicModel::fill(self : GeoprojgnomonicModel, v : Double) -> GeoprojgnomonicModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicModel::min(self : GeoprojgnomonicModel) -> Double { @_common.min(self.data) }

pub fn GeoprojgnomonicModel::max(self : GeoprojgnomonicModel) -> Double { @_common.max(self.data) }

pub fn GeoprojgnomonicModel::to_string(self : GeoprojgnomonicModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_layer_make(size : Int) -> GeoprojgnomonicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojgnomonicLayer::len(self : GeoprojgnomonicLayer) -> Int { self.size }

pub fn GeoprojgnomonicLayer::get(self : GeoprojgnomonicLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojgnomonicLayer::set(self : GeoprojgnomonicLayer, i : Int, v : Double) -> GeoprojgnomonicLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicLayer::sum(self : GeoprojgnomonicLayer) -> Double { @_common.sum(self.data) }

pub fn GeoprojgnomonicLayer::mean(self : GeoprojgnomonicLayer) -> Double { @_common.mean(self.data) }

pub fn GeoprojgnomonicLayer::scale(self : GeoprojgnomonicLayer, f : Double) -> GeoprojgnomonicLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicLayer::add(self : GeoprojgnomonicLayer, other : GeoprojgnomonicLayer) -> GeoprojgnomonicLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojgnomonicLayer::copy(self : GeoprojgnomonicLayer) -> GeoprojgnomonicLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicLayer::fill(self : GeoprojgnomonicLayer, v : Double) -> GeoprojgnomonicLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicLayer::min(self : GeoprojgnomonicLayer) -> Double { @_common.min(self.data) }

pub fn GeoprojgnomonicLayer::max(self : GeoprojgnomonicLayer) -> Double { @_common.max(self.data) }

pub fn GeoprojgnomonicLayer::to_string(self : GeoprojgnomonicLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_buffer_make(size : Int) -> GeoprojgnomonicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojgnomonicBuffer::len(self : GeoprojgnomonicBuffer) -> Int { self.size }

pub fn GeoprojgnomonicBuffer::get(self : GeoprojgnomonicBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojgnomonicBuffer::set(self : GeoprojgnomonicBuffer, i : Int, v : Double) -> GeoprojgnomonicBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicBuffer::sum(self : GeoprojgnomonicBuffer) -> Double { @_common.sum(self.data) }

pub fn GeoprojgnomonicBuffer::mean(self : GeoprojgnomonicBuffer) -> Double { @_common.mean(self.data) }

pub fn GeoprojgnomonicBuffer::scale(self : GeoprojgnomonicBuffer, f : Double) -> GeoprojgnomonicBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicBuffer::add(self : GeoprojgnomonicBuffer, other : GeoprojgnomonicBuffer) -> GeoprojgnomonicBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojgnomonicBuffer::copy(self : GeoprojgnomonicBuffer) -> GeoprojgnomonicBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicBuffer::fill(self : GeoprojgnomonicBuffer, v : Double) -> GeoprojgnomonicBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicBuffer::min(self : GeoprojgnomonicBuffer) -> Double { @_common.min(self.data) }

pub fn GeoprojgnomonicBuffer::max(self : GeoprojgnomonicBuffer) -> Double { @_common.max(self.data) }

pub fn GeoprojgnomonicBuffer::to_string(self : GeoprojgnomonicBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_cursor_make(size : Int) -> GeoprojgnomonicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojgnomonicCursor::len(self : GeoprojgnomonicCursor) -> Int { self.size }

pub fn GeoprojgnomonicCursor::get(self : GeoprojgnomonicCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojgnomonicCursor::set(self : GeoprojgnomonicCursor, i : Int, v : Double) -> GeoprojgnomonicCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicCursor::sum(self : GeoprojgnomonicCursor) -> Double { @_common.sum(self.data) }

pub fn GeoprojgnomonicCursor::mean(self : GeoprojgnomonicCursor) -> Double { @_common.mean(self.data) }

pub fn GeoprojgnomonicCursor::scale(self : GeoprojgnomonicCursor, f : Double) -> GeoprojgnomonicCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicCursor::add(self : GeoprojgnomonicCursor, other : GeoprojgnomonicCursor) -> GeoprojgnomonicCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojgnomonicCursor::copy(self : GeoprojgnomonicCursor) -> GeoprojgnomonicCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicCursor::fill(self : GeoprojgnomonicCursor, v : Double) -> GeoprojgnomonicCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicCursor::min(self : GeoprojgnomonicCursor) -> Double { @_common.min(self.data) }

pub fn GeoprojgnomonicCursor::max(self : GeoprojgnomonicCursor) -> Double { @_common.max(self.data) }

pub fn GeoprojgnomonicCursor::to_string(self : GeoprojgnomonicCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_view_make(size : Int) -> GeoprojgnomonicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojgnomonicView::len(self : GeoprojgnomonicView) -> Int { self.size }

pub fn GeoprojgnomonicView::get(self : GeoprojgnomonicView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojgnomonicView::set(self : GeoprojgnomonicView, i : Int, v : Double) -> GeoprojgnomonicView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicView::sum(self : GeoprojgnomonicView) -> Double { @_common.sum(self.data) }

pub fn GeoprojgnomonicView::mean(self : GeoprojgnomonicView) -> Double { @_common.mean(self.data) }

pub fn GeoprojgnomonicView::scale(self : GeoprojgnomonicView, f : Double) -> GeoprojgnomonicView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicView::add(self : GeoprojgnomonicView, other : GeoprojgnomonicView) -> GeoprojgnomonicView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojgnomonicView::copy(self : GeoprojgnomonicView) -> GeoprojgnomonicView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicView::fill(self : GeoprojgnomonicView, v : Double) -> GeoprojgnomonicView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicView::min(self : GeoprojgnomonicView) -> Double { @_common.min(self.data) }

pub fn GeoprojgnomonicView::max(self : GeoprojgnomonicView) -> Double { @_common.max(self.data) }

pub fn GeoprojgnomonicView::to_string(self : GeoprojgnomonicView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_range_make(size : Int) -> GeoprojgnomonicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojgnomonicRange::len(self : GeoprojgnomonicRange) -> Int { self.size }

pub fn GeoprojgnomonicRange::get(self : GeoprojgnomonicRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojgnomonicRange::set(self : GeoprojgnomonicRange, i : Int, v : Double) -> GeoprojgnomonicRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicRange::sum(self : GeoprojgnomonicRange) -> Double { @_common.sum(self.data) }

pub fn GeoprojgnomonicRange::mean(self : GeoprojgnomonicRange) -> Double { @_common.mean(self.data) }

pub fn GeoprojgnomonicRange::scale(self : GeoprojgnomonicRange, f : Double) -> GeoprojgnomonicRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicRange::add(self : GeoprojgnomonicRange, other : GeoprojgnomonicRange) -> GeoprojgnomonicRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojgnomonicRange::copy(self : GeoprojgnomonicRange) -> GeoprojgnomonicRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicRange::fill(self : GeoprojgnomonicRange, v : Double) -> GeoprojgnomonicRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicRange::min(self : GeoprojgnomonicRange) -> Double { @_common.min(self.data) }

pub fn GeoprojgnomonicRange::max(self : GeoprojgnomonicRange) -> Double { @_common.max(self.data) }

pub fn GeoprojgnomonicRange::to_string(self : GeoprojgnomonicRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_slice_make(size : Int) -> GeoprojgnomonicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojgnomonicSlice::len(self : GeoprojgnomonicSlice) -> Int { self.size }

pub fn GeoprojgnomonicSlice::get(self : GeoprojgnomonicSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojgnomonicSlice::set(self : GeoprojgnomonicSlice, i : Int, v : Double) -> GeoprojgnomonicSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicSlice::sum(self : GeoprojgnomonicSlice) -> Double { @_common.sum(self.data) }

pub fn GeoprojgnomonicSlice::mean(self : GeoprojgnomonicSlice) -> Double { @_common.mean(self.data) }

pub fn GeoprojgnomonicSlice::scale(self : GeoprojgnomonicSlice, f : Double) -> GeoprojgnomonicSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicSlice::add(self : GeoprojgnomonicSlice, other : GeoprojgnomonicSlice) -> GeoprojgnomonicSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojgnomonicSlice::copy(self : GeoprojgnomonicSlice) -> GeoprojgnomonicSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicSlice::fill(self : GeoprojgnomonicSlice, v : Double) -> GeoprojgnomonicSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojgnomonicSlice::min(self : GeoprojgnomonicSlice) -> Double { @_common.min(self.data) }

pub fn GeoprojgnomonicSlice::max(self : GeoprojgnomonicSlice) -> Double { @_common.max(self.data) }

pub fn GeoprojgnomonicSlice::to_string(self : GeoprojgnomonicSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

