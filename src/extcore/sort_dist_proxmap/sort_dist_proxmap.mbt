///===
/// extcore/sort_dist_proxmap

pub(all) struct SortdistproxmapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_proxmap_make_point(x : Double, y : Double) -> SortdistproxmapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_proxmap_make_point3(x : Double, y : Double, z : Double) -> SortdistproxmapPoint {
  { x, y, z, label: 0 }
}

pub fn SortdistproxmapPoint::x(self : SortdistproxmapPoint) -> Double { self.x }

pub fn SortdistproxmapPoint::y(self : SortdistproxmapPoint) -> Double { self.y }

pub fn SortdistproxmapPoint::z(self : SortdistproxmapPoint) -> Double { self.z }

pub fn SortdistproxmapPoint::label(self : SortdistproxmapPoint) -> Int { self.label }

pub fn SortdistproxmapPoint::dist(self : SortdistproxmapPoint, other : SortdistproxmapPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortdistproxmapPoint::add(self : SortdistproxmapPoint, other : SortdistproxmapPoint) -> SortdistproxmapPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortdistproxmapPoint::sub(self : SortdistproxmapPoint, other : SortdistproxmapPoint) -> SortdistproxmapPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortdistproxmapPoint::scale(self : SortdistproxmapPoint, s : Double) -> SortdistproxmapPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortdistproxmapPoint::dot(self : SortdistproxmapPoint, other : SortdistproxmapPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortdistproxmapPoint::cross(self : SortdistproxmapPoint, other : SortdistproxmapPoint) -> SortdistproxmapPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortdistproxmapPoint::norm(self : SortdistproxmapPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortdistproxmapPoint::normalize(self : SortdistproxmapPoint) -> SortdistproxmapPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistproxmapPoint::negate(self : SortdistproxmapPoint) -> SortdistproxmapPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortdistproxmapPoint::mid(self : SortdistproxmapPoint, other : SortdistproxmapPoint) -> SortdistproxmapPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortdistproxmapPoint::lerp(self : SortdistproxmapPoint, other : SortdistproxmapPoint, t : Double) -> SortdistproxmapPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortdistproxmapPoint::to_string(self : SortdistproxmapPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortdistproxmapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_proxmap_make_series(vals : Array[Double], name : String) -> SortdistproxmapSeries {
  { vals, name, meta: 0 }
}

pub fn SortdistproxmapSeries::len(self : SortdistproxmapSeries) -> Int { self.vals.length() }

pub fn SortdistproxmapSeries::sum(self : SortdistproxmapSeries) -> Double { @_common.sum(self.vals) }

pub fn SortdistproxmapSeries::mean(self : SortdistproxmapSeries) -> Double { @_common.mean(self.vals) }

pub fn SortdistproxmapSeries::min(self : SortdistproxmapSeries) -> Double { @_common.min(self.vals) }

pub fn SortdistproxmapSeries::max(self : SortdistproxmapSeries) -> Double { @_common.max(self.vals) }

pub fn SortdistproxmapSeries::range(self : SortdistproxmapSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortdistproxmapSeries::variance(self : SortdistproxmapSeries) -> Double { @_common.variance(self.vals) }

pub fn SortdistproxmapSeries::std(self : SortdistproxmapSeries) -> Double { @_common.std(self.vals) }

pub fn SortdistproxmapSeries::median(self : SortdistproxmapSeries) -> Double { @_common.median(self.vals) }

pub fn SortdistproxmapSeries::scale(self : SortdistproxmapSeries, f : Double) -> SortdistproxmapSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortdistproxmapSeries::add(self : SortdistproxmapSeries, other : SortdistproxmapSeries) -> SortdistproxmapSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortdistproxmapSeries::sub(self : SortdistproxmapSeries, other : SortdistproxmapSeries) -> SortdistproxmapSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortdistproxmapSeries::normalize(self : SortdistproxmapSeries) -> SortdistproxmapSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortdistproxmapSeries::cumsum(self : SortdistproxmapSeries) -> SortdistproxmapSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortdistproxmapSeries::to_string(self : SortdistproxmapSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistproxmapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_proxmap_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistproxmapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_proxmap_matrix_identity(n : Int) -> SortdistproxmapMatrix {
  let m = sort_dist_proxmap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortdistproxmapMatrix::get(self : SortdistproxmapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortdistproxmapMatrix::transpose(self : SortdistproxmapMatrix) -> SortdistproxmapMatrix {
  let result = sort_dist_proxmap_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortdistproxmapMatrix::add(self : SortdistproxmapMatrix, other : SortdistproxmapMatrix) -> SortdistproxmapMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_dist_proxmap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortdistproxmapMatrix::scale(self : SortdistproxmapMatrix, s : Double) -> SortdistproxmapMatrix {
  let result = sort_dist_proxmap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortdistproxmapMatrix::multiply(self : SortdistproxmapMatrix, other : SortdistproxmapMatrix) -> SortdistproxmapMatrix {
  if self.cols != other.rows { return sort_dist_proxmap_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_dist_proxmap_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortdistproxmapMatrix::trace(self : SortdistproxmapMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortdistproxmapMatrix::det(self : SortdistproxmapMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortdistproxmapMatrix::norm(self : SortdistproxmapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortdistproxmapMatrix::to_string(self : SortdistproxmapMatrix) -> String {
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

pub(all) struct SortdistproxmapVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_proxmap_make_vector(comps : Array[Double]) -> SortdistproxmapVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_proxmap_vector_zero(dim : Int) -> SortdistproxmapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortdistproxmapVector::add(self : SortdistproxmapVector, other : SortdistproxmapVector) -> SortdistproxmapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistproxmapVector::sub(self : SortdistproxmapVector, other : SortdistproxmapVector) -> SortdistproxmapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistproxmapVector::scale(self : SortdistproxmapVector, s : Double) -> SortdistproxmapVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortdistproxmapVector::dot(self : SortdistproxmapVector, other : SortdistproxmapVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortdistproxmapVector::norm(self : SortdistproxmapVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortdistproxmapVector::normalize(self : SortdistproxmapVector) -> SortdistproxmapVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistproxmapVector::dist(self : SortdistproxmapVector, other : SortdistproxmapVector) -> Double {
  self.sub(other).norm()
}

pub fn SortdistproxmapVector::to_string(self : SortdistproxmapVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_proxmap_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_proxmap_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_proxmap_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_proxmap_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_proxmap_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_proxmap_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_proxmap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_proxmap_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_proxmap_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_proxmap_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_proxmap_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_proxmap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_proxmap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_proxmap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_proxmap_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_proxmap_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_proxmap_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_proxmap_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_proxmap_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_proxmap_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_proxmap_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_proxmap_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_proxmap_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_proxmap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_proxmap_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_proxmap_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_proxmap_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_proxmap_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_proxmap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistproxmapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_frame_make(size : Int) -> SortdistproxmapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistproxmapFrame::len(self : SortdistproxmapFrame) -> Int { self.size }

pub fn SortdistproxmapFrame::get(self : SortdistproxmapFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistproxmapFrame::set(self : SortdistproxmapFrame, i : Int, v : Double) -> SortdistproxmapFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistproxmapFrame::sum(self : SortdistproxmapFrame) -> Double { @_common.sum(self.data) }

pub fn SortdistproxmapFrame::mean(self : SortdistproxmapFrame) -> Double { @_common.mean(self.data) }

pub fn SortdistproxmapFrame::scale(self : SortdistproxmapFrame, f : Double) -> SortdistproxmapFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapFrame::add(self : SortdistproxmapFrame, other : SortdistproxmapFrame) -> SortdistproxmapFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistproxmapFrame::copy(self : SortdistproxmapFrame) -> SortdistproxmapFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapFrame::fill(self : SortdistproxmapFrame, v : Double) -> SortdistproxmapFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapFrame::min(self : SortdistproxmapFrame) -> Double { @_common.min(self.data) }

pub fn SortdistproxmapFrame::max(self : SortdistproxmapFrame) -> Double { @_common.max(self.data) }

pub fn SortdistproxmapFrame::to_string(self : SortdistproxmapFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_table_make(size : Int) -> SortdistproxmapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistproxmapTable::len(self : SortdistproxmapTable) -> Int { self.size }

pub fn SortdistproxmapTable::get(self : SortdistproxmapTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistproxmapTable::set(self : SortdistproxmapTable, i : Int, v : Double) -> SortdistproxmapTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistproxmapTable::sum(self : SortdistproxmapTable) -> Double { @_common.sum(self.data) }

pub fn SortdistproxmapTable::mean(self : SortdistproxmapTable) -> Double { @_common.mean(self.data) }

pub fn SortdistproxmapTable::scale(self : SortdistproxmapTable, f : Double) -> SortdistproxmapTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapTable::add(self : SortdistproxmapTable, other : SortdistproxmapTable) -> SortdistproxmapTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistproxmapTable::copy(self : SortdistproxmapTable) -> SortdistproxmapTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapTable::fill(self : SortdistproxmapTable, v : Double) -> SortdistproxmapTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapTable::min(self : SortdistproxmapTable) -> Double { @_common.min(self.data) }

pub fn SortdistproxmapTable::max(self : SortdistproxmapTable) -> Double { @_common.max(self.data) }

pub fn SortdistproxmapTable::to_string(self : SortdistproxmapTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_graphn_make(size : Int) -> SortdistproxmapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistproxmapGraphN::len(self : SortdistproxmapGraphN) -> Int { self.size }

pub fn SortdistproxmapGraphN::get(self : SortdistproxmapGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistproxmapGraphN::set(self : SortdistproxmapGraphN, i : Int, v : Double) -> SortdistproxmapGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistproxmapGraphN::sum(self : SortdistproxmapGraphN) -> Double { @_common.sum(self.data) }

pub fn SortdistproxmapGraphN::mean(self : SortdistproxmapGraphN) -> Double { @_common.mean(self.data) }

pub fn SortdistproxmapGraphN::scale(self : SortdistproxmapGraphN, f : Double) -> SortdistproxmapGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapGraphN::add(self : SortdistproxmapGraphN, other : SortdistproxmapGraphN) -> SortdistproxmapGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistproxmapGraphN::copy(self : SortdistproxmapGraphN) -> SortdistproxmapGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapGraphN::fill(self : SortdistproxmapGraphN, v : Double) -> SortdistproxmapGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapGraphN::min(self : SortdistproxmapGraphN) -> Double { @_common.min(self.data) }

pub fn SortdistproxmapGraphN::max(self : SortdistproxmapGraphN) -> Double { @_common.max(self.data) }

pub fn SortdistproxmapGraphN::to_string(self : SortdistproxmapGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_node_make(size : Int) -> SortdistproxmapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistproxmapNode::len(self : SortdistproxmapNode) -> Int { self.size }

pub fn SortdistproxmapNode::get(self : SortdistproxmapNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistproxmapNode::set(self : SortdistproxmapNode, i : Int, v : Double) -> SortdistproxmapNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistproxmapNode::sum(self : SortdistproxmapNode) -> Double { @_common.sum(self.data) }

pub fn SortdistproxmapNode::mean(self : SortdistproxmapNode) -> Double { @_common.mean(self.data) }

pub fn SortdistproxmapNode::scale(self : SortdistproxmapNode, f : Double) -> SortdistproxmapNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapNode::add(self : SortdistproxmapNode, other : SortdistproxmapNode) -> SortdistproxmapNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistproxmapNode::copy(self : SortdistproxmapNode) -> SortdistproxmapNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapNode::fill(self : SortdistproxmapNode, v : Double) -> SortdistproxmapNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapNode::min(self : SortdistproxmapNode) -> Double { @_common.min(self.data) }

pub fn SortdistproxmapNode::max(self : SortdistproxmapNode) -> Double { @_common.max(self.data) }

pub fn SortdistproxmapNode::to_string(self : SortdistproxmapNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_edge_make(size : Int) -> SortdistproxmapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistproxmapEdge::len(self : SortdistproxmapEdge) -> Int { self.size }

pub fn SortdistproxmapEdge::get(self : SortdistproxmapEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistproxmapEdge::set(self : SortdistproxmapEdge, i : Int, v : Double) -> SortdistproxmapEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistproxmapEdge::sum(self : SortdistproxmapEdge) -> Double { @_common.sum(self.data) }

pub fn SortdistproxmapEdge::mean(self : SortdistproxmapEdge) -> Double { @_common.mean(self.data) }

pub fn SortdistproxmapEdge::scale(self : SortdistproxmapEdge, f : Double) -> SortdistproxmapEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapEdge::add(self : SortdistproxmapEdge, other : SortdistproxmapEdge) -> SortdistproxmapEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistproxmapEdge::copy(self : SortdistproxmapEdge) -> SortdistproxmapEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapEdge::fill(self : SortdistproxmapEdge, v : Double) -> SortdistproxmapEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapEdge::min(self : SortdistproxmapEdge) -> Double { @_common.min(self.data) }

pub fn SortdistproxmapEdge::max(self : SortdistproxmapEdge) -> Double { @_common.max(self.data) }

pub fn SortdistproxmapEdge::to_string(self : SortdistproxmapEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_path_make(size : Int) -> SortdistproxmapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistproxmapPath::len(self : SortdistproxmapPath) -> Int { self.size }

pub fn SortdistproxmapPath::get(self : SortdistproxmapPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistproxmapPath::set(self : SortdistproxmapPath, i : Int, v : Double) -> SortdistproxmapPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistproxmapPath::sum(self : SortdistproxmapPath) -> Double { @_common.sum(self.data) }

pub fn SortdistproxmapPath::mean(self : SortdistproxmapPath) -> Double { @_common.mean(self.data) }

pub fn SortdistproxmapPath::scale(self : SortdistproxmapPath, f : Double) -> SortdistproxmapPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapPath::add(self : SortdistproxmapPath, other : SortdistproxmapPath) -> SortdistproxmapPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistproxmapPath::copy(self : SortdistproxmapPath) -> SortdistproxmapPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapPath::fill(self : SortdistproxmapPath, v : Double) -> SortdistproxmapPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapPath::min(self : SortdistproxmapPath) -> Double { @_common.min(self.data) }

pub fn SortdistproxmapPath::max(self : SortdistproxmapPath) -> Double { @_common.max(self.data) }

pub fn SortdistproxmapPath::to_string(self : SortdistproxmapPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_cluster_make(size : Int) -> SortdistproxmapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistproxmapCluster::len(self : SortdistproxmapCluster) -> Int { self.size }

pub fn SortdistproxmapCluster::get(self : SortdistproxmapCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistproxmapCluster::set(self : SortdistproxmapCluster, i : Int, v : Double) -> SortdistproxmapCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistproxmapCluster::sum(self : SortdistproxmapCluster) -> Double { @_common.sum(self.data) }

pub fn SortdistproxmapCluster::mean(self : SortdistproxmapCluster) -> Double { @_common.mean(self.data) }

pub fn SortdistproxmapCluster::scale(self : SortdistproxmapCluster, f : Double) -> SortdistproxmapCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapCluster::add(self : SortdistproxmapCluster, other : SortdistproxmapCluster) -> SortdistproxmapCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistproxmapCluster::copy(self : SortdistproxmapCluster) -> SortdistproxmapCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapCluster::fill(self : SortdistproxmapCluster, v : Double) -> SortdistproxmapCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapCluster::min(self : SortdistproxmapCluster) -> Double { @_common.min(self.data) }

pub fn SortdistproxmapCluster::max(self : SortdistproxmapCluster) -> Double { @_common.max(self.data) }

pub fn SortdistproxmapCluster::to_string(self : SortdistproxmapCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_model_make(size : Int) -> SortdistproxmapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistproxmapModel::len(self : SortdistproxmapModel) -> Int { self.size }

pub fn SortdistproxmapModel::get(self : SortdistproxmapModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistproxmapModel::set(self : SortdistproxmapModel, i : Int, v : Double) -> SortdistproxmapModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistproxmapModel::sum(self : SortdistproxmapModel) -> Double { @_common.sum(self.data) }

pub fn SortdistproxmapModel::mean(self : SortdistproxmapModel) -> Double { @_common.mean(self.data) }

pub fn SortdistproxmapModel::scale(self : SortdistproxmapModel, f : Double) -> SortdistproxmapModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapModel::add(self : SortdistproxmapModel, other : SortdistproxmapModel) -> SortdistproxmapModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistproxmapModel::copy(self : SortdistproxmapModel) -> SortdistproxmapModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapModel::fill(self : SortdistproxmapModel, v : Double) -> SortdistproxmapModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapModel::min(self : SortdistproxmapModel) -> Double { @_common.min(self.data) }

pub fn SortdistproxmapModel::max(self : SortdistproxmapModel) -> Double { @_common.max(self.data) }

pub fn SortdistproxmapModel::to_string(self : SortdistproxmapModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_layer_make(size : Int) -> SortdistproxmapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistproxmapLayer::len(self : SortdistproxmapLayer) -> Int { self.size }

pub fn SortdistproxmapLayer::get(self : SortdistproxmapLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistproxmapLayer::set(self : SortdistproxmapLayer, i : Int, v : Double) -> SortdistproxmapLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistproxmapLayer::sum(self : SortdistproxmapLayer) -> Double { @_common.sum(self.data) }

pub fn SortdistproxmapLayer::mean(self : SortdistproxmapLayer) -> Double { @_common.mean(self.data) }

pub fn SortdistproxmapLayer::scale(self : SortdistproxmapLayer, f : Double) -> SortdistproxmapLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapLayer::add(self : SortdistproxmapLayer, other : SortdistproxmapLayer) -> SortdistproxmapLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistproxmapLayer::copy(self : SortdistproxmapLayer) -> SortdistproxmapLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapLayer::fill(self : SortdistproxmapLayer, v : Double) -> SortdistproxmapLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapLayer::min(self : SortdistproxmapLayer) -> Double { @_common.min(self.data) }

pub fn SortdistproxmapLayer::max(self : SortdistproxmapLayer) -> Double { @_common.max(self.data) }

pub fn SortdistproxmapLayer::to_string(self : SortdistproxmapLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_buffer_make(size : Int) -> SortdistproxmapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistproxmapBuffer::len(self : SortdistproxmapBuffer) -> Int { self.size }

pub fn SortdistproxmapBuffer::get(self : SortdistproxmapBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistproxmapBuffer::set(self : SortdistproxmapBuffer, i : Int, v : Double) -> SortdistproxmapBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistproxmapBuffer::sum(self : SortdistproxmapBuffer) -> Double { @_common.sum(self.data) }

pub fn SortdistproxmapBuffer::mean(self : SortdistproxmapBuffer) -> Double { @_common.mean(self.data) }

pub fn SortdistproxmapBuffer::scale(self : SortdistproxmapBuffer, f : Double) -> SortdistproxmapBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapBuffer::add(self : SortdistproxmapBuffer, other : SortdistproxmapBuffer) -> SortdistproxmapBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistproxmapBuffer::copy(self : SortdistproxmapBuffer) -> SortdistproxmapBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapBuffer::fill(self : SortdistproxmapBuffer, v : Double) -> SortdistproxmapBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapBuffer::min(self : SortdistproxmapBuffer) -> Double { @_common.min(self.data) }

pub fn SortdistproxmapBuffer::max(self : SortdistproxmapBuffer) -> Double { @_common.max(self.data) }

pub fn SortdistproxmapBuffer::to_string(self : SortdistproxmapBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_cursor_make(size : Int) -> SortdistproxmapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistproxmapCursor::len(self : SortdistproxmapCursor) -> Int { self.size }

pub fn SortdistproxmapCursor::get(self : SortdistproxmapCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistproxmapCursor::set(self : SortdistproxmapCursor, i : Int, v : Double) -> SortdistproxmapCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistproxmapCursor::sum(self : SortdistproxmapCursor) -> Double { @_common.sum(self.data) }

pub fn SortdistproxmapCursor::mean(self : SortdistproxmapCursor) -> Double { @_common.mean(self.data) }

pub fn SortdistproxmapCursor::scale(self : SortdistproxmapCursor, f : Double) -> SortdistproxmapCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapCursor::add(self : SortdistproxmapCursor, other : SortdistproxmapCursor) -> SortdistproxmapCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistproxmapCursor::copy(self : SortdistproxmapCursor) -> SortdistproxmapCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapCursor::fill(self : SortdistproxmapCursor, v : Double) -> SortdistproxmapCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapCursor::min(self : SortdistproxmapCursor) -> Double { @_common.min(self.data) }

pub fn SortdistproxmapCursor::max(self : SortdistproxmapCursor) -> Double { @_common.max(self.data) }

pub fn SortdistproxmapCursor::to_string(self : SortdistproxmapCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_view_make(size : Int) -> SortdistproxmapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistproxmapView::len(self : SortdistproxmapView) -> Int { self.size }

pub fn SortdistproxmapView::get(self : SortdistproxmapView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistproxmapView::set(self : SortdistproxmapView, i : Int, v : Double) -> SortdistproxmapView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistproxmapView::sum(self : SortdistproxmapView) -> Double { @_common.sum(self.data) }

pub fn SortdistproxmapView::mean(self : SortdistproxmapView) -> Double { @_common.mean(self.data) }

pub fn SortdistproxmapView::scale(self : SortdistproxmapView, f : Double) -> SortdistproxmapView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapView::add(self : SortdistproxmapView, other : SortdistproxmapView) -> SortdistproxmapView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistproxmapView::copy(self : SortdistproxmapView) -> SortdistproxmapView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapView::fill(self : SortdistproxmapView, v : Double) -> SortdistproxmapView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapView::min(self : SortdistproxmapView) -> Double { @_common.min(self.data) }

pub fn SortdistproxmapView::max(self : SortdistproxmapView) -> Double { @_common.max(self.data) }

pub fn SortdistproxmapView::to_string(self : SortdistproxmapView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_range_make(size : Int) -> SortdistproxmapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistproxmapRange::len(self : SortdistproxmapRange) -> Int { self.size }

pub fn SortdistproxmapRange::get(self : SortdistproxmapRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistproxmapRange::set(self : SortdistproxmapRange, i : Int, v : Double) -> SortdistproxmapRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistproxmapRange::sum(self : SortdistproxmapRange) -> Double { @_common.sum(self.data) }

pub fn SortdistproxmapRange::mean(self : SortdistproxmapRange) -> Double { @_common.mean(self.data) }

pub fn SortdistproxmapRange::scale(self : SortdistproxmapRange, f : Double) -> SortdistproxmapRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapRange::add(self : SortdistproxmapRange, other : SortdistproxmapRange) -> SortdistproxmapRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistproxmapRange::copy(self : SortdistproxmapRange) -> SortdistproxmapRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapRange::fill(self : SortdistproxmapRange, v : Double) -> SortdistproxmapRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapRange::min(self : SortdistproxmapRange) -> Double { @_common.min(self.data) }

pub fn SortdistproxmapRange::max(self : SortdistproxmapRange) -> Double { @_common.max(self.data) }

pub fn SortdistproxmapRange::to_string(self : SortdistproxmapRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_slice_make(size : Int) -> SortdistproxmapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistproxmapSlice::len(self : SortdistproxmapSlice) -> Int { self.size }

pub fn SortdistproxmapSlice::get(self : SortdistproxmapSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistproxmapSlice::set(self : SortdistproxmapSlice, i : Int, v : Double) -> SortdistproxmapSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistproxmapSlice::sum(self : SortdistproxmapSlice) -> Double { @_common.sum(self.data) }

pub fn SortdistproxmapSlice::mean(self : SortdistproxmapSlice) -> Double { @_common.mean(self.data) }

pub fn SortdistproxmapSlice::scale(self : SortdistproxmapSlice, f : Double) -> SortdistproxmapSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapSlice::add(self : SortdistproxmapSlice, other : SortdistproxmapSlice) -> SortdistproxmapSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistproxmapSlice::copy(self : SortdistproxmapSlice) -> SortdistproxmapSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapSlice::fill(self : SortdistproxmapSlice, v : Double) -> SortdistproxmapSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistproxmapSlice::min(self : SortdistproxmapSlice) -> Double { @_common.min(self.data) }

pub fn SortdistproxmapSlice::max(self : SortdistproxmapSlice) -> Double { @_common.max(self.data) }

pub fn SortdistproxmapSlice::to_string(self : SortdistproxmapSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

