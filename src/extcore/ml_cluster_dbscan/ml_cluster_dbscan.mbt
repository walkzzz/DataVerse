///===
/// extcore/ml_cluster_dbscan

pub(all) struct MlclusterdbscanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_dbscan_make_point(x : Double, y : Double) -> MlclusterdbscanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_dbscan_make_point3(x : Double, y : Double, z : Double) -> MlclusterdbscanPoint {
  { x, y, z, label: 0 }
}

pub fn MlclusterdbscanPoint::x(self : MlclusterdbscanPoint) -> Double { self.x }

pub fn MlclusterdbscanPoint::y(self : MlclusterdbscanPoint) -> Double { self.y }

pub fn MlclusterdbscanPoint::z(self : MlclusterdbscanPoint) -> Double { self.z }

pub fn MlclusterdbscanPoint::label(self : MlclusterdbscanPoint) -> Int { self.label }

pub fn MlclusterdbscanPoint::dist(self : MlclusterdbscanPoint, other : MlclusterdbscanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclusterdbscanPoint::add(self : MlclusterdbscanPoint, other : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclusterdbscanPoint::sub(self : MlclusterdbscanPoint, other : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclusterdbscanPoint::scale(self : MlclusterdbscanPoint, s : Double) -> MlclusterdbscanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclusterdbscanPoint::dot(self : MlclusterdbscanPoint, other : MlclusterdbscanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclusterdbscanPoint::cross(self : MlclusterdbscanPoint, other : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclusterdbscanPoint::norm(self : MlclusterdbscanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclusterdbscanPoint::normalize(self : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterdbscanPoint::negate(self : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclusterdbscanPoint::mid(self : MlclusterdbscanPoint, other : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclusterdbscanPoint::lerp(self : MlclusterdbscanPoint, other : MlclusterdbscanPoint, t : Double) -> MlclusterdbscanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclusterdbscanPoint::to_string(self : MlclusterdbscanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclusterdbscanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_dbscan_make_series(vals : Array[Double], name : String) -> MlclusterdbscanSeries {
  { vals, name, meta: 0 }
}

pub fn MlclusterdbscanSeries::len(self : MlclusterdbscanSeries) -> Int { self.vals.length() }

pub fn MlclusterdbscanSeries::sum(self : MlclusterdbscanSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclusterdbscanSeries::mean(self : MlclusterdbscanSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclusterdbscanSeries::min(self : MlclusterdbscanSeries) -> Double { @_common.min(self.vals) }

pub fn MlclusterdbscanSeries::max(self : MlclusterdbscanSeries) -> Double { @_common.max(self.vals) }

pub fn MlclusterdbscanSeries::range(self : MlclusterdbscanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclusterdbscanSeries::variance(self : MlclusterdbscanSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclusterdbscanSeries::std(self : MlclusterdbscanSeries) -> Double { @_common.std(self.vals) }

pub fn MlclusterdbscanSeries::median(self : MlclusterdbscanSeries) -> Double { @_common.median(self.vals) }

pub fn MlclusterdbscanSeries::scale(self : MlclusterdbscanSeries, f : Double) -> MlclusterdbscanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclusterdbscanSeries::add(self : MlclusterdbscanSeries, other : MlclusterdbscanSeries) -> MlclusterdbscanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclusterdbscanSeries::sub(self : MlclusterdbscanSeries, other : MlclusterdbscanSeries) -> MlclusterdbscanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclusterdbscanSeries::normalize(self : MlclusterdbscanSeries) -> MlclusterdbscanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclusterdbscanSeries::cumsum(self : MlclusterdbscanSeries) -> MlclusterdbscanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclusterdbscanSeries::to_string(self : MlclusterdbscanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusterdbscanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_dbscan_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusterdbscanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_dbscan_matrix_identity(n : Int) -> MlclusterdbscanMatrix {
  let m = ml_cluster_dbscan_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclusterdbscanMatrix::get(self : MlclusterdbscanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclusterdbscanMatrix::transpose(self : MlclusterdbscanMatrix) -> MlclusterdbscanMatrix {
  let result = ml_cluster_dbscan_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclusterdbscanMatrix::add(self : MlclusterdbscanMatrix, other : MlclusterdbscanMatrix) -> MlclusterdbscanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_dbscan_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclusterdbscanMatrix::scale(self : MlclusterdbscanMatrix, s : Double) -> MlclusterdbscanMatrix {
  let result = ml_cluster_dbscan_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclusterdbscanMatrix::multiply(self : MlclusterdbscanMatrix, other : MlclusterdbscanMatrix) -> MlclusterdbscanMatrix {
  if self.cols != other.rows { return ml_cluster_dbscan_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_dbscan_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclusterdbscanMatrix::trace(self : MlclusterdbscanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclusterdbscanMatrix::det(self : MlclusterdbscanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclusterdbscanMatrix::norm(self : MlclusterdbscanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclusterdbscanMatrix::to_string(self : MlclusterdbscanMatrix) -> String {
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

pub(all) struct MlclusterdbscanVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_dbscan_make_vector(comps : Array[Double]) -> MlclusterdbscanVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_dbscan_vector_zero(dim : Int) -> MlclusterdbscanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclusterdbscanVector::add(self : MlclusterdbscanVector, other : MlclusterdbscanVector) -> MlclusterdbscanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterdbscanVector::sub(self : MlclusterdbscanVector, other : MlclusterdbscanVector) -> MlclusterdbscanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterdbscanVector::scale(self : MlclusterdbscanVector, s : Double) -> MlclusterdbscanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclusterdbscanVector::dot(self : MlclusterdbscanVector, other : MlclusterdbscanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclusterdbscanVector::norm(self : MlclusterdbscanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclusterdbscanVector::normalize(self : MlclusterdbscanVector) -> MlclusterdbscanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterdbscanVector::dist(self : MlclusterdbscanVector, other : MlclusterdbscanVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclusterdbscanVector::to_string(self : MlclusterdbscanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_dbscan_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_cluster_dbscan_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_cluster_dbscan_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_cluster_dbscan_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_cluster_dbscan_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_cluster_dbscan_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_cluster_dbscan_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_cluster_dbscan_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_cluster_dbscan_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_cluster_dbscan_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_cluster_dbscan_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_cluster_dbscan_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_cluster_dbscan_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_cluster_dbscan_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_cluster_dbscan_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_cluster_dbscan_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_cluster_dbscan_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_cluster_dbscan_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_cluster_dbscan_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_cluster_dbscan_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_cluster_dbscan_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_cluster_dbscan_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_cluster_dbscan_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_cluster_dbscan_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_cluster_dbscan_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_cluster_dbscan_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_cluster_dbscan_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_cluster_dbscan_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_cluster_dbscan_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclusterdbscanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_frame_make(size : Int) -> MlclusterdbscanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterdbscanFrame::len(self : MlclusterdbscanFrame) -> Int { self.size }

pub fn MlclusterdbscanFrame::get(self : MlclusterdbscanFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterdbscanFrame::set(self : MlclusterdbscanFrame, i : Int, v : Double) -> MlclusterdbscanFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanFrame::sum(self : MlclusterdbscanFrame) -> Double { @_common.sum(self.data) }

pub fn MlclusterdbscanFrame::mean(self : MlclusterdbscanFrame) -> Double { @_common.mean(self.data) }

pub fn MlclusterdbscanFrame::scale(self : MlclusterdbscanFrame, f : Double) -> MlclusterdbscanFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanFrame::add(self : MlclusterdbscanFrame, other : MlclusterdbscanFrame) -> MlclusterdbscanFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterdbscanFrame::copy(self : MlclusterdbscanFrame) -> MlclusterdbscanFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanFrame::fill(self : MlclusterdbscanFrame, v : Double) -> MlclusterdbscanFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanFrame::min(self : MlclusterdbscanFrame) -> Double { @_common.min(self.data) }

pub fn MlclusterdbscanFrame::max(self : MlclusterdbscanFrame) -> Double { @_common.max(self.data) }

pub fn MlclusterdbscanFrame::to_string(self : MlclusterdbscanFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_table_make(size : Int) -> MlclusterdbscanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterdbscanTable::len(self : MlclusterdbscanTable) -> Int { self.size }

pub fn MlclusterdbscanTable::get(self : MlclusterdbscanTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterdbscanTable::set(self : MlclusterdbscanTable, i : Int, v : Double) -> MlclusterdbscanTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanTable::sum(self : MlclusterdbscanTable) -> Double { @_common.sum(self.data) }

pub fn MlclusterdbscanTable::mean(self : MlclusterdbscanTable) -> Double { @_common.mean(self.data) }

pub fn MlclusterdbscanTable::scale(self : MlclusterdbscanTable, f : Double) -> MlclusterdbscanTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanTable::add(self : MlclusterdbscanTable, other : MlclusterdbscanTable) -> MlclusterdbscanTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterdbscanTable::copy(self : MlclusterdbscanTable) -> MlclusterdbscanTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanTable::fill(self : MlclusterdbscanTable, v : Double) -> MlclusterdbscanTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanTable::min(self : MlclusterdbscanTable) -> Double { @_common.min(self.data) }

pub fn MlclusterdbscanTable::max(self : MlclusterdbscanTable) -> Double { @_common.max(self.data) }

pub fn MlclusterdbscanTable::to_string(self : MlclusterdbscanTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_graphn_make(size : Int) -> MlclusterdbscanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterdbscanGraphN::len(self : MlclusterdbscanGraphN) -> Int { self.size }

pub fn MlclusterdbscanGraphN::get(self : MlclusterdbscanGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterdbscanGraphN::set(self : MlclusterdbscanGraphN, i : Int, v : Double) -> MlclusterdbscanGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanGraphN::sum(self : MlclusterdbscanGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclusterdbscanGraphN::mean(self : MlclusterdbscanGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclusterdbscanGraphN::scale(self : MlclusterdbscanGraphN, f : Double) -> MlclusterdbscanGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanGraphN::add(self : MlclusterdbscanGraphN, other : MlclusterdbscanGraphN) -> MlclusterdbscanGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterdbscanGraphN::copy(self : MlclusterdbscanGraphN) -> MlclusterdbscanGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanGraphN::fill(self : MlclusterdbscanGraphN, v : Double) -> MlclusterdbscanGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanGraphN::min(self : MlclusterdbscanGraphN) -> Double { @_common.min(self.data) }

pub fn MlclusterdbscanGraphN::max(self : MlclusterdbscanGraphN) -> Double { @_common.max(self.data) }

pub fn MlclusterdbscanGraphN::to_string(self : MlclusterdbscanGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_node_make(size : Int) -> MlclusterdbscanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterdbscanNode::len(self : MlclusterdbscanNode) -> Int { self.size }

pub fn MlclusterdbscanNode::get(self : MlclusterdbscanNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterdbscanNode::set(self : MlclusterdbscanNode, i : Int, v : Double) -> MlclusterdbscanNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanNode::sum(self : MlclusterdbscanNode) -> Double { @_common.sum(self.data) }

pub fn MlclusterdbscanNode::mean(self : MlclusterdbscanNode) -> Double { @_common.mean(self.data) }

pub fn MlclusterdbscanNode::scale(self : MlclusterdbscanNode, f : Double) -> MlclusterdbscanNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanNode::add(self : MlclusterdbscanNode, other : MlclusterdbscanNode) -> MlclusterdbscanNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterdbscanNode::copy(self : MlclusterdbscanNode) -> MlclusterdbscanNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanNode::fill(self : MlclusterdbscanNode, v : Double) -> MlclusterdbscanNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanNode::min(self : MlclusterdbscanNode) -> Double { @_common.min(self.data) }

pub fn MlclusterdbscanNode::max(self : MlclusterdbscanNode) -> Double { @_common.max(self.data) }

pub fn MlclusterdbscanNode::to_string(self : MlclusterdbscanNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_edge_make(size : Int) -> MlclusterdbscanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterdbscanEdge::len(self : MlclusterdbscanEdge) -> Int { self.size }

pub fn MlclusterdbscanEdge::get(self : MlclusterdbscanEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterdbscanEdge::set(self : MlclusterdbscanEdge, i : Int, v : Double) -> MlclusterdbscanEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanEdge::sum(self : MlclusterdbscanEdge) -> Double { @_common.sum(self.data) }

pub fn MlclusterdbscanEdge::mean(self : MlclusterdbscanEdge) -> Double { @_common.mean(self.data) }

pub fn MlclusterdbscanEdge::scale(self : MlclusterdbscanEdge, f : Double) -> MlclusterdbscanEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanEdge::add(self : MlclusterdbscanEdge, other : MlclusterdbscanEdge) -> MlclusterdbscanEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterdbscanEdge::copy(self : MlclusterdbscanEdge) -> MlclusterdbscanEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanEdge::fill(self : MlclusterdbscanEdge, v : Double) -> MlclusterdbscanEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanEdge::min(self : MlclusterdbscanEdge) -> Double { @_common.min(self.data) }

pub fn MlclusterdbscanEdge::max(self : MlclusterdbscanEdge) -> Double { @_common.max(self.data) }

pub fn MlclusterdbscanEdge::to_string(self : MlclusterdbscanEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_path_make(size : Int) -> MlclusterdbscanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterdbscanPath::len(self : MlclusterdbscanPath) -> Int { self.size }

pub fn MlclusterdbscanPath::get(self : MlclusterdbscanPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterdbscanPath::set(self : MlclusterdbscanPath, i : Int, v : Double) -> MlclusterdbscanPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanPath::sum(self : MlclusterdbscanPath) -> Double { @_common.sum(self.data) }

pub fn MlclusterdbscanPath::mean(self : MlclusterdbscanPath) -> Double { @_common.mean(self.data) }

pub fn MlclusterdbscanPath::scale(self : MlclusterdbscanPath, f : Double) -> MlclusterdbscanPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanPath::add(self : MlclusterdbscanPath, other : MlclusterdbscanPath) -> MlclusterdbscanPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterdbscanPath::copy(self : MlclusterdbscanPath) -> MlclusterdbscanPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanPath::fill(self : MlclusterdbscanPath, v : Double) -> MlclusterdbscanPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanPath::min(self : MlclusterdbscanPath) -> Double { @_common.min(self.data) }

pub fn MlclusterdbscanPath::max(self : MlclusterdbscanPath) -> Double { @_common.max(self.data) }

pub fn MlclusterdbscanPath::to_string(self : MlclusterdbscanPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_cluster_make(size : Int) -> MlclusterdbscanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterdbscanCluster::len(self : MlclusterdbscanCluster) -> Int { self.size }

pub fn MlclusterdbscanCluster::get(self : MlclusterdbscanCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterdbscanCluster::set(self : MlclusterdbscanCluster, i : Int, v : Double) -> MlclusterdbscanCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanCluster::sum(self : MlclusterdbscanCluster) -> Double { @_common.sum(self.data) }

pub fn MlclusterdbscanCluster::mean(self : MlclusterdbscanCluster) -> Double { @_common.mean(self.data) }

pub fn MlclusterdbscanCluster::scale(self : MlclusterdbscanCluster, f : Double) -> MlclusterdbscanCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanCluster::add(self : MlclusterdbscanCluster, other : MlclusterdbscanCluster) -> MlclusterdbscanCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterdbscanCluster::copy(self : MlclusterdbscanCluster) -> MlclusterdbscanCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanCluster::fill(self : MlclusterdbscanCluster, v : Double) -> MlclusterdbscanCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanCluster::min(self : MlclusterdbscanCluster) -> Double { @_common.min(self.data) }

pub fn MlclusterdbscanCluster::max(self : MlclusterdbscanCluster) -> Double { @_common.max(self.data) }

pub fn MlclusterdbscanCluster::to_string(self : MlclusterdbscanCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_model_make(size : Int) -> MlclusterdbscanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterdbscanModel::len(self : MlclusterdbscanModel) -> Int { self.size }

pub fn MlclusterdbscanModel::get(self : MlclusterdbscanModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterdbscanModel::set(self : MlclusterdbscanModel, i : Int, v : Double) -> MlclusterdbscanModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanModel::sum(self : MlclusterdbscanModel) -> Double { @_common.sum(self.data) }

pub fn MlclusterdbscanModel::mean(self : MlclusterdbscanModel) -> Double { @_common.mean(self.data) }

pub fn MlclusterdbscanModel::scale(self : MlclusterdbscanModel, f : Double) -> MlclusterdbscanModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanModel::add(self : MlclusterdbscanModel, other : MlclusterdbscanModel) -> MlclusterdbscanModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterdbscanModel::copy(self : MlclusterdbscanModel) -> MlclusterdbscanModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanModel::fill(self : MlclusterdbscanModel, v : Double) -> MlclusterdbscanModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanModel::min(self : MlclusterdbscanModel) -> Double { @_common.min(self.data) }

pub fn MlclusterdbscanModel::max(self : MlclusterdbscanModel) -> Double { @_common.max(self.data) }

pub fn MlclusterdbscanModel::to_string(self : MlclusterdbscanModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_layer_make(size : Int) -> MlclusterdbscanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterdbscanLayer::len(self : MlclusterdbscanLayer) -> Int { self.size }

pub fn MlclusterdbscanLayer::get(self : MlclusterdbscanLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterdbscanLayer::set(self : MlclusterdbscanLayer, i : Int, v : Double) -> MlclusterdbscanLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanLayer::sum(self : MlclusterdbscanLayer) -> Double { @_common.sum(self.data) }

pub fn MlclusterdbscanLayer::mean(self : MlclusterdbscanLayer) -> Double { @_common.mean(self.data) }

pub fn MlclusterdbscanLayer::scale(self : MlclusterdbscanLayer, f : Double) -> MlclusterdbscanLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanLayer::add(self : MlclusterdbscanLayer, other : MlclusterdbscanLayer) -> MlclusterdbscanLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterdbscanLayer::copy(self : MlclusterdbscanLayer) -> MlclusterdbscanLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanLayer::fill(self : MlclusterdbscanLayer, v : Double) -> MlclusterdbscanLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanLayer::min(self : MlclusterdbscanLayer) -> Double { @_common.min(self.data) }

pub fn MlclusterdbscanLayer::max(self : MlclusterdbscanLayer) -> Double { @_common.max(self.data) }

pub fn MlclusterdbscanLayer::to_string(self : MlclusterdbscanLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_buffer_make(size : Int) -> MlclusterdbscanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterdbscanBuffer::len(self : MlclusterdbscanBuffer) -> Int { self.size }

pub fn MlclusterdbscanBuffer::get(self : MlclusterdbscanBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterdbscanBuffer::set(self : MlclusterdbscanBuffer, i : Int, v : Double) -> MlclusterdbscanBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanBuffer::sum(self : MlclusterdbscanBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclusterdbscanBuffer::mean(self : MlclusterdbscanBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclusterdbscanBuffer::scale(self : MlclusterdbscanBuffer, f : Double) -> MlclusterdbscanBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanBuffer::add(self : MlclusterdbscanBuffer, other : MlclusterdbscanBuffer) -> MlclusterdbscanBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterdbscanBuffer::copy(self : MlclusterdbscanBuffer) -> MlclusterdbscanBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanBuffer::fill(self : MlclusterdbscanBuffer, v : Double) -> MlclusterdbscanBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanBuffer::min(self : MlclusterdbscanBuffer) -> Double { @_common.min(self.data) }

pub fn MlclusterdbscanBuffer::max(self : MlclusterdbscanBuffer) -> Double { @_common.max(self.data) }

pub fn MlclusterdbscanBuffer::to_string(self : MlclusterdbscanBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_cursor_make(size : Int) -> MlclusterdbscanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterdbscanCursor::len(self : MlclusterdbscanCursor) -> Int { self.size }

pub fn MlclusterdbscanCursor::get(self : MlclusterdbscanCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterdbscanCursor::set(self : MlclusterdbscanCursor, i : Int, v : Double) -> MlclusterdbscanCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanCursor::sum(self : MlclusterdbscanCursor) -> Double { @_common.sum(self.data) }

pub fn MlclusterdbscanCursor::mean(self : MlclusterdbscanCursor) -> Double { @_common.mean(self.data) }

pub fn MlclusterdbscanCursor::scale(self : MlclusterdbscanCursor, f : Double) -> MlclusterdbscanCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanCursor::add(self : MlclusterdbscanCursor, other : MlclusterdbscanCursor) -> MlclusterdbscanCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterdbscanCursor::copy(self : MlclusterdbscanCursor) -> MlclusterdbscanCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanCursor::fill(self : MlclusterdbscanCursor, v : Double) -> MlclusterdbscanCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanCursor::min(self : MlclusterdbscanCursor) -> Double { @_common.min(self.data) }

pub fn MlclusterdbscanCursor::max(self : MlclusterdbscanCursor) -> Double { @_common.max(self.data) }

pub fn MlclusterdbscanCursor::to_string(self : MlclusterdbscanCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_view_make(size : Int) -> MlclusterdbscanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterdbscanView::len(self : MlclusterdbscanView) -> Int { self.size }

pub fn MlclusterdbscanView::get(self : MlclusterdbscanView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterdbscanView::set(self : MlclusterdbscanView, i : Int, v : Double) -> MlclusterdbscanView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanView::sum(self : MlclusterdbscanView) -> Double { @_common.sum(self.data) }

pub fn MlclusterdbscanView::mean(self : MlclusterdbscanView) -> Double { @_common.mean(self.data) }

pub fn MlclusterdbscanView::scale(self : MlclusterdbscanView, f : Double) -> MlclusterdbscanView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanView::add(self : MlclusterdbscanView, other : MlclusterdbscanView) -> MlclusterdbscanView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterdbscanView::copy(self : MlclusterdbscanView) -> MlclusterdbscanView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanView::fill(self : MlclusterdbscanView, v : Double) -> MlclusterdbscanView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanView::min(self : MlclusterdbscanView) -> Double { @_common.min(self.data) }

pub fn MlclusterdbscanView::max(self : MlclusterdbscanView) -> Double { @_common.max(self.data) }

pub fn MlclusterdbscanView::to_string(self : MlclusterdbscanView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_range_make(size : Int) -> MlclusterdbscanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterdbscanRange::len(self : MlclusterdbscanRange) -> Int { self.size }

pub fn MlclusterdbscanRange::get(self : MlclusterdbscanRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterdbscanRange::set(self : MlclusterdbscanRange, i : Int, v : Double) -> MlclusterdbscanRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanRange::sum(self : MlclusterdbscanRange) -> Double { @_common.sum(self.data) }

pub fn MlclusterdbscanRange::mean(self : MlclusterdbscanRange) -> Double { @_common.mean(self.data) }

pub fn MlclusterdbscanRange::scale(self : MlclusterdbscanRange, f : Double) -> MlclusterdbscanRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanRange::add(self : MlclusterdbscanRange, other : MlclusterdbscanRange) -> MlclusterdbscanRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterdbscanRange::copy(self : MlclusterdbscanRange) -> MlclusterdbscanRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanRange::fill(self : MlclusterdbscanRange, v : Double) -> MlclusterdbscanRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanRange::min(self : MlclusterdbscanRange) -> Double { @_common.min(self.data) }

pub fn MlclusterdbscanRange::max(self : MlclusterdbscanRange) -> Double { @_common.max(self.data) }

pub fn MlclusterdbscanRange::to_string(self : MlclusterdbscanRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_slice_make(size : Int) -> MlclusterdbscanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterdbscanSlice::len(self : MlclusterdbscanSlice) -> Int { self.size }

pub fn MlclusterdbscanSlice::get(self : MlclusterdbscanSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterdbscanSlice::set(self : MlclusterdbscanSlice, i : Int, v : Double) -> MlclusterdbscanSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanSlice::sum(self : MlclusterdbscanSlice) -> Double { @_common.sum(self.data) }

pub fn MlclusterdbscanSlice::mean(self : MlclusterdbscanSlice) -> Double { @_common.mean(self.data) }

pub fn MlclusterdbscanSlice::scale(self : MlclusterdbscanSlice, f : Double) -> MlclusterdbscanSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanSlice::add(self : MlclusterdbscanSlice, other : MlclusterdbscanSlice) -> MlclusterdbscanSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterdbscanSlice::copy(self : MlclusterdbscanSlice) -> MlclusterdbscanSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanSlice::fill(self : MlclusterdbscanSlice, v : Double) -> MlclusterdbscanSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterdbscanSlice::min(self : MlclusterdbscanSlice) -> Double { @_common.min(self.data) }

pub fn MlclusterdbscanSlice::max(self : MlclusterdbscanSlice) -> Double { @_common.max(self.data) }

pub fn MlclusterdbscanSlice::to_string(self : MlclusterdbscanSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

