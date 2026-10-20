///===
/// extcore/geo_dist_geodesic

pub(all) struct GeodistgeodesicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_geodesic_make_point(x : Double, y : Double) -> GeodistgeodesicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_geodesic_make_point3(x : Double, y : Double, z : Double) -> GeodistgeodesicPoint {
  { x, y, z, label: 0 }
}

pub fn GeodistgeodesicPoint::x(self : GeodistgeodesicPoint) -> Double { self.x }

pub fn GeodistgeodesicPoint::y(self : GeodistgeodesicPoint) -> Double { self.y }

pub fn GeodistgeodesicPoint::z(self : GeodistgeodesicPoint) -> Double { self.z }

pub fn GeodistgeodesicPoint::label(self : GeodistgeodesicPoint) -> Int { self.label }

pub fn GeodistgeodesicPoint::dist(self : GeodistgeodesicPoint, other : GeodistgeodesicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodistgeodesicPoint::add(self : GeodistgeodesicPoint, other : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodistgeodesicPoint::sub(self : GeodistgeodesicPoint, other : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodistgeodesicPoint::scale(self : GeodistgeodesicPoint, s : Double) -> GeodistgeodesicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodistgeodesicPoint::dot(self : GeodistgeodesicPoint, other : GeodistgeodesicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodistgeodesicPoint::cross(self : GeodistgeodesicPoint, other : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodistgeodesicPoint::norm(self : GeodistgeodesicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodistgeodesicPoint::normalize(self : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistgeodesicPoint::negate(self : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodistgeodesicPoint::mid(self : GeodistgeodesicPoint, other : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodistgeodesicPoint::lerp(self : GeodistgeodesicPoint, other : GeodistgeodesicPoint, t : Double) -> GeodistgeodesicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodistgeodesicPoint::to_string(self : GeodistgeodesicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodistgeodesicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_geodesic_make_series(vals : Array[Double], name : String) -> GeodistgeodesicSeries {
  { vals, name, meta: 0 }
}

pub fn GeodistgeodesicSeries::len(self : GeodistgeodesicSeries) -> Int { self.vals.length() }

pub fn GeodistgeodesicSeries::sum(self : GeodistgeodesicSeries) -> Double { @_common.sum(self.vals) }

pub fn GeodistgeodesicSeries::mean(self : GeodistgeodesicSeries) -> Double { @_common.mean(self.vals) }

pub fn GeodistgeodesicSeries::min(self : GeodistgeodesicSeries) -> Double { @_common.min(self.vals) }

pub fn GeodistgeodesicSeries::max(self : GeodistgeodesicSeries) -> Double { @_common.max(self.vals) }

pub fn GeodistgeodesicSeries::range(self : GeodistgeodesicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodistgeodesicSeries::variance(self : GeodistgeodesicSeries) -> Double { @_common.variance(self.vals) }

pub fn GeodistgeodesicSeries::std(self : GeodistgeodesicSeries) -> Double { @_common.std(self.vals) }

pub fn GeodistgeodesicSeries::median(self : GeodistgeodesicSeries) -> Double { @_common.median(self.vals) }

pub fn GeodistgeodesicSeries::scale(self : GeodistgeodesicSeries, f : Double) -> GeodistgeodesicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodistgeodesicSeries::add(self : GeodistgeodesicSeries, other : GeodistgeodesicSeries) -> GeodistgeodesicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodistgeodesicSeries::sub(self : GeodistgeodesicSeries, other : GeodistgeodesicSeries) -> GeodistgeodesicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodistgeodesicSeries::normalize(self : GeodistgeodesicSeries) -> GeodistgeodesicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodistgeodesicSeries::cumsum(self : GeodistgeodesicSeries) -> GeodistgeodesicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodistgeodesicSeries::to_string(self : GeodistgeodesicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistgeodesicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_geodesic_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistgeodesicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_geodesic_matrix_identity(n : Int) -> GeodistgeodesicMatrix {
  let m = geo_dist_geodesic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodistgeodesicMatrix::get(self : GeodistgeodesicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodistgeodesicMatrix::transpose(self : GeodistgeodesicMatrix) -> GeodistgeodesicMatrix {
  let result = geo_dist_geodesic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodistgeodesicMatrix::add(self : GeodistgeodesicMatrix, other : GeodistgeodesicMatrix) -> GeodistgeodesicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_geodesic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodistgeodesicMatrix::scale(self : GeodistgeodesicMatrix, s : Double) -> GeodistgeodesicMatrix {
  let result = geo_dist_geodesic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodistgeodesicMatrix::multiply(self : GeodistgeodesicMatrix, other : GeodistgeodesicMatrix) -> GeodistgeodesicMatrix {
  if self.cols != other.rows { return geo_dist_geodesic_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_geodesic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeodistgeodesicMatrix::trace(self : GeodistgeodesicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodistgeodesicMatrix::det(self : GeodistgeodesicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodistgeodesicMatrix::norm(self : GeodistgeodesicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodistgeodesicMatrix::to_string(self : GeodistgeodesicMatrix) -> String {
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

pub(all) struct GeodistgeodesicVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_geodesic_make_vector(comps : Array[Double]) -> GeodistgeodesicVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_geodesic_vector_zero(dim : Int) -> GeodistgeodesicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodistgeodesicVector::add(self : GeodistgeodesicVector, other : GeodistgeodesicVector) -> GeodistgeodesicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistgeodesicVector::sub(self : GeodistgeodesicVector, other : GeodistgeodesicVector) -> GeodistgeodesicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistgeodesicVector::scale(self : GeodistgeodesicVector, s : Double) -> GeodistgeodesicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodistgeodesicVector::dot(self : GeodistgeodesicVector, other : GeodistgeodesicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodistgeodesicVector::norm(self : GeodistgeodesicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodistgeodesicVector::normalize(self : GeodistgeodesicVector) -> GeodistgeodesicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistgeodesicVector::dist(self : GeodistgeodesicVector, other : GeodistgeodesicVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodistgeodesicVector::to_string(self : GeodistgeodesicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_geodesic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_geodesic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_geodesic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_geodesic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_geodesic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_geodesic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_geodesic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_geodesic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_geodesic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_geodesic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_geodesic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_geodesic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_geodesic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_geodesic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_geodesic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_geodesic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_geodesic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_geodesic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_geodesic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_geodesic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_geodesic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_geodesic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_geodesic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_geodesic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_geodesic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_geodesic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_geodesic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_geodesic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_geodesic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistgeodesicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_frame_make(size : Int) -> GeodistgeodesicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgeodesicFrame::len(self : GeodistgeodesicFrame) -> Int { self.size }

pub fn GeodistgeodesicFrame::get(self : GeodistgeodesicFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgeodesicFrame::set(self : GeodistgeodesicFrame, i : Int, v : Double) -> GeodistgeodesicFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicFrame::sum(self : GeodistgeodesicFrame) -> Double { @_common.sum(self.data) }

pub fn GeodistgeodesicFrame::mean(self : GeodistgeodesicFrame) -> Double { @_common.mean(self.data) }

pub fn GeodistgeodesicFrame::scale(self : GeodistgeodesicFrame, f : Double) -> GeodistgeodesicFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicFrame::add(self : GeodistgeodesicFrame, other : GeodistgeodesicFrame) -> GeodistgeodesicFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgeodesicFrame::copy(self : GeodistgeodesicFrame) -> GeodistgeodesicFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicFrame::fill(self : GeodistgeodesicFrame, v : Double) -> GeodistgeodesicFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicFrame::min(self : GeodistgeodesicFrame) -> Double { @_common.min(self.data) }

pub fn GeodistgeodesicFrame::max(self : GeodistgeodesicFrame) -> Double { @_common.max(self.data) }

pub fn GeodistgeodesicFrame::to_string(self : GeodistgeodesicFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_table_make(size : Int) -> GeodistgeodesicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgeodesicTable::len(self : GeodistgeodesicTable) -> Int { self.size }

pub fn GeodistgeodesicTable::get(self : GeodistgeodesicTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgeodesicTable::set(self : GeodistgeodesicTable, i : Int, v : Double) -> GeodistgeodesicTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicTable::sum(self : GeodistgeodesicTable) -> Double { @_common.sum(self.data) }

pub fn GeodistgeodesicTable::mean(self : GeodistgeodesicTable) -> Double { @_common.mean(self.data) }

pub fn GeodistgeodesicTable::scale(self : GeodistgeodesicTable, f : Double) -> GeodistgeodesicTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicTable::add(self : GeodistgeodesicTable, other : GeodistgeodesicTable) -> GeodistgeodesicTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgeodesicTable::copy(self : GeodistgeodesicTable) -> GeodistgeodesicTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicTable::fill(self : GeodistgeodesicTable, v : Double) -> GeodistgeodesicTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicTable::min(self : GeodistgeodesicTable) -> Double { @_common.min(self.data) }

pub fn GeodistgeodesicTable::max(self : GeodistgeodesicTable) -> Double { @_common.max(self.data) }

pub fn GeodistgeodesicTable::to_string(self : GeodistgeodesicTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_graphn_make(size : Int) -> GeodistgeodesicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgeodesicGraphN::len(self : GeodistgeodesicGraphN) -> Int { self.size }

pub fn GeodistgeodesicGraphN::get(self : GeodistgeodesicGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgeodesicGraphN::set(self : GeodistgeodesicGraphN, i : Int, v : Double) -> GeodistgeodesicGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicGraphN::sum(self : GeodistgeodesicGraphN) -> Double { @_common.sum(self.data) }

pub fn GeodistgeodesicGraphN::mean(self : GeodistgeodesicGraphN) -> Double { @_common.mean(self.data) }

pub fn GeodistgeodesicGraphN::scale(self : GeodistgeodesicGraphN, f : Double) -> GeodistgeodesicGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicGraphN::add(self : GeodistgeodesicGraphN, other : GeodistgeodesicGraphN) -> GeodistgeodesicGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgeodesicGraphN::copy(self : GeodistgeodesicGraphN) -> GeodistgeodesicGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicGraphN::fill(self : GeodistgeodesicGraphN, v : Double) -> GeodistgeodesicGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicGraphN::min(self : GeodistgeodesicGraphN) -> Double { @_common.min(self.data) }

pub fn GeodistgeodesicGraphN::max(self : GeodistgeodesicGraphN) -> Double { @_common.max(self.data) }

pub fn GeodistgeodesicGraphN::to_string(self : GeodistgeodesicGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_node_make(size : Int) -> GeodistgeodesicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgeodesicNode::len(self : GeodistgeodesicNode) -> Int { self.size }

pub fn GeodistgeodesicNode::get(self : GeodistgeodesicNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgeodesicNode::set(self : GeodistgeodesicNode, i : Int, v : Double) -> GeodistgeodesicNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicNode::sum(self : GeodistgeodesicNode) -> Double { @_common.sum(self.data) }

pub fn GeodistgeodesicNode::mean(self : GeodistgeodesicNode) -> Double { @_common.mean(self.data) }

pub fn GeodistgeodesicNode::scale(self : GeodistgeodesicNode, f : Double) -> GeodistgeodesicNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicNode::add(self : GeodistgeodesicNode, other : GeodistgeodesicNode) -> GeodistgeodesicNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgeodesicNode::copy(self : GeodistgeodesicNode) -> GeodistgeodesicNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicNode::fill(self : GeodistgeodesicNode, v : Double) -> GeodistgeodesicNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicNode::min(self : GeodistgeodesicNode) -> Double { @_common.min(self.data) }

pub fn GeodistgeodesicNode::max(self : GeodistgeodesicNode) -> Double { @_common.max(self.data) }

pub fn GeodistgeodesicNode::to_string(self : GeodistgeodesicNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_edge_make(size : Int) -> GeodistgeodesicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgeodesicEdge::len(self : GeodistgeodesicEdge) -> Int { self.size }

pub fn GeodistgeodesicEdge::get(self : GeodistgeodesicEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgeodesicEdge::set(self : GeodistgeodesicEdge, i : Int, v : Double) -> GeodistgeodesicEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicEdge::sum(self : GeodistgeodesicEdge) -> Double { @_common.sum(self.data) }

pub fn GeodistgeodesicEdge::mean(self : GeodistgeodesicEdge) -> Double { @_common.mean(self.data) }

pub fn GeodistgeodesicEdge::scale(self : GeodistgeodesicEdge, f : Double) -> GeodistgeodesicEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicEdge::add(self : GeodistgeodesicEdge, other : GeodistgeodesicEdge) -> GeodistgeodesicEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgeodesicEdge::copy(self : GeodistgeodesicEdge) -> GeodistgeodesicEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicEdge::fill(self : GeodistgeodesicEdge, v : Double) -> GeodistgeodesicEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicEdge::min(self : GeodistgeodesicEdge) -> Double { @_common.min(self.data) }

pub fn GeodistgeodesicEdge::max(self : GeodistgeodesicEdge) -> Double { @_common.max(self.data) }

pub fn GeodistgeodesicEdge::to_string(self : GeodistgeodesicEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_path_make(size : Int) -> GeodistgeodesicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgeodesicPath::len(self : GeodistgeodesicPath) -> Int { self.size }

pub fn GeodistgeodesicPath::get(self : GeodistgeodesicPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgeodesicPath::set(self : GeodistgeodesicPath, i : Int, v : Double) -> GeodistgeodesicPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicPath::sum(self : GeodistgeodesicPath) -> Double { @_common.sum(self.data) }

pub fn GeodistgeodesicPath::mean(self : GeodistgeodesicPath) -> Double { @_common.mean(self.data) }

pub fn GeodistgeodesicPath::scale(self : GeodistgeodesicPath, f : Double) -> GeodistgeodesicPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicPath::add(self : GeodistgeodesicPath, other : GeodistgeodesicPath) -> GeodistgeodesicPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgeodesicPath::copy(self : GeodistgeodesicPath) -> GeodistgeodesicPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicPath::fill(self : GeodistgeodesicPath, v : Double) -> GeodistgeodesicPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicPath::min(self : GeodistgeodesicPath) -> Double { @_common.min(self.data) }

pub fn GeodistgeodesicPath::max(self : GeodistgeodesicPath) -> Double { @_common.max(self.data) }

pub fn GeodistgeodesicPath::to_string(self : GeodistgeodesicPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_cluster_make(size : Int) -> GeodistgeodesicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgeodesicCluster::len(self : GeodistgeodesicCluster) -> Int { self.size }

pub fn GeodistgeodesicCluster::get(self : GeodistgeodesicCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgeodesicCluster::set(self : GeodistgeodesicCluster, i : Int, v : Double) -> GeodistgeodesicCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicCluster::sum(self : GeodistgeodesicCluster) -> Double { @_common.sum(self.data) }

pub fn GeodistgeodesicCluster::mean(self : GeodistgeodesicCluster) -> Double { @_common.mean(self.data) }

pub fn GeodistgeodesicCluster::scale(self : GeodistgeodesicCluster, f : Double) -> GeodistgeodesicCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicCluster::add(self : GeodistgeodesicCluster, other : GeodistgeodesicCluster) -> GeodistgeodesicCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgeodesicCluster::copy(self : GeodistgeodesicCluster) -> GeodistgeodesicCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicCluster::fill(self : GeodistgeodesicCluster, v : Double) -> GeodistgeodesicCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicCluster::min(self : GeodistgeodesicCluster) -> Double { @_common.min(self.data) }

pub fn GeodistgeodesicCluster::max(self : GeodistgeodesicCluster) -> Double { @_common.max(self.data) }

pub fn GeodistgeodesicCluster::to_string(self : GeodistgeodesicCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_model_make(size : Int) -> GeodistgeodesicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgeodesicModel::len(self : GeodistgeodesicModel) -> Int { self.size }

pub fn GeodistgeodesicModel::get(self : GeodistgeodesicModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgeodesicModel::set(self : GeodistgeodesicModel, i : Int, v : Double) -> GeodistgeodesicModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicModel::sum(self : GeodistgeodesicModel) -> Double { @_common.sum(self.data) }

pub fn GeodistgeodesicModel::mean(self : GeodistgeodesicModel) -> Double { @_common.mean(self.data) }

pub fn GeodistgeodesicModel::scale(self : GeodistgeodesicModel, f : Double) -> GeodistgeodesicModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicModel::add(self : GeodistgeodesicModel, other : GeodistgeodesicModel) -> GeodistgeodesicModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgeodesicModel::copy(self : GeodistgeodesicModel) -> GeodistgeodesicModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicModel::fill(self : GeodistgeodesicModel, v : Double) -> GeodistgeodesicModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicModel::min(self : GeodistgeodesicModel) -> Double { @_common.min(self.data) }

pub fn GeodistgeodesicModel::max(self : GeodistgeodesicModel) -> Double { @_common.max(self.data) }

pub fn GeodistgeodesicModel::to_string(self : GeodistgeodesicModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_layer_make(size : Int) -> GeodistgeodesicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgeodesicLayer::len(self : GeodistgeodesicLayer) -> Int { self.size }

pub fn GeodistgeodesicLayer::get(self : GeodistgeodesicLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgeodesicLayer::set(self : GeodistgeodesicLayer, i : Int, v : Double) -> GeodistgeodesicLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicLayer::sum(self : GeodistgeodesicLayer) -> Double { @_common.sum(self.data) }

pub fn GeodistgeodesicLayer::mean(self : GeodistgeodesicLayer) -> Double { @_common.mean(self.data) }

pub fn GeodistgeodesicLayer::scale(self : GeodistgeodesicLayer, f : Double) -> GeodistgeodesicLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicLayer::add(self : GeodistgeodesicLayer, other : GeodistgeodesicLayer) -> GeodistgeodesicLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgeodesicLayer::copy(self : GeodistgeodesicLayer) -> GeodistgeodesicLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicLayer::fill(self : GeodistgeodesicLayer, v : Double) -> GeodistgeodesicLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicLayer::min(self : GeodistgeodesicLayer) -> Double { @_common.min(self.data) }

pub fn GeodistgeodesicLayer::max(self : GeodistgeodesicLayer) -> Double { @_common.max(self.data) }

pub fn GeodistgeodesicLayer::to_string(self : GeodistgeodesicLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_buffer_make(size : Int) -> GeodistgeodesicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgeodesicBuffer::len(self : GeodistgeodesicBuffer) -> Int { self.size }

pub fn GeodistgeodesicBuffer::get(self : GeodistgeodesicBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgeodesicBuffer::set(self : GeodistgeodesicBuffer, i : Int, v : Double) -> GeodistgeodesicBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicBuffer::sum(self : GeodistgeodesicBuffer) -> Double { @_common.sum(self.data) }

pub fn GeodistgeodesicBuffer::mean(self : GeodistgeodesicBuffer) -> Double { @_common.mean(self.data) }

pub fn GeodistgeodesicBuffer::scale(self : GeodistgeodesicBuffer, f : Double) -> GeodistgeodesicBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicBuffer::add(self : GeodistgeodesicBuffer, other : GeodistgeodesicBuffer) -> GeodistgeodesicBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgeodesicBuffer::copy(self : GeodistgeodesicBuffer) -> GeodistgeodesicBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicBuffer::fill(self : GeodistgeodesicBuffer, v : Double) -> GeodistgeodesicBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicBuffer::min(self : GeodistgeodesicBuffer) -> Double { @_common.min(self.data) }

pub fn GeodistgeodesicBuffer::max(self : GeodistgeodesicBuffer) -> Double { @_common.max(self.data) }

pub fn GeodistgeodesicBuffer::to_string(self : GeodistgeodesicBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_cursor_make(size : Int) -> GeodistgeodesicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgeodesicCursor::len(self : GeodistgeodesicCursor) -> Int { self.size }

pub fn GeodistgeodesicCursor::get(self : GeodistgeodesicCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgeodesicCursor::set(self : GeodistgeodesicCursor, i : Int, v : Double) -> GeodistgeodesicCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicCursor::sum(self : GeodistgeodesicCursor) -> Double { @_common.sum(self.data) }

pub fn GeodistgeodesicCursor::mean(self : GeodistgeodesicCursor) -> Double { @_common.mean(self.data) }

pub fn GeodistgeodesicCursor::scale(self : GeodistgeodesicCursor, f : Double) -> GeodistgeodesicCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicCursor::add(self : GeodistgeodesicCursor, other : GeodistgeodesicCursor) -> GeodistgeodesicCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgeodesicCursor::copy(self : GeodistgeodesicCursor) -> GeodistgeodesicCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicCursor::fill(self : GeodistgeodesicCursor, v : Double) -> GeodistgeodesicCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicCursor::min(self : GeodistgeodesicCursor) -> Double { @_common.min(self.data) }

pub fn GeodistgeodesicCursor::max(self : GeodistgeodesicCursor) -> Double { @_common.max(self.data) }

pub fn GeodistgeodesicCursor::to_string(self : GeodistgeodesicCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_view_make(size : Int) -> GeodistgeodesicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgeodesicView::len(self : GeodistgeodesicView) -> Int { self.size }

pub fn GeodistgeodesicView::get(self : GeodistgeodesicView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgeodesicView::set(self : GeodistgeodesicView, i : Int, v : Double) -> GeodistgeodesicView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicView::sum(self : GeodistgeodesicView) -> Double { @_common.sum(self.data) }

pub fn GeodistgeodesicView::mean(self : GeodistgeodesicView) -> Double { @_common.mean(self.data) }

pub fn GeodistgeodesicView::scale(self : GeodistgeodesicView, f : Double) -> GeodistgeodesicView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicView::add(self : GeodistgeodesicView, other : GeodistgeodesicView) -> GeodistgeodesicView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgeodesicView::copy(self : GeodistgeodesicView) -> GeodistgeodesicView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicView::fill(self : GeodistgeodesicView, v : Double) -> GeodistgeodesicView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicView::min(self : GeodistgeodesicView) -> Double { @_common.min(self.data) }

pub fn GeodistgeodesicView::max(self : GeodistgeodesicView) -> Double { @_common.max(self.data) }

pub fn GeodistgeodesicView::to_string(self : GeodistgeodesicView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_range_make(size : Int) -> GeodistgeodesicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgeodesicRange::len(self : GeodistgeodesicRange) -> Int { self.size }

pub fn GeodistgeodesicRange::get(self : GeodistgeodesicRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgeodesicRange::set(self : GeodistgeodesicRange, i : Int, v : Double) -> GeodistgeodesicRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicRange::sum(self : GeodistgeodesicRange) -> Double { @_common.sum(self.data) }

pub fn GeodistgeodesicRange::mean(self : GeodistgeodesicRange) -> Double { @_common.mean(self.data) }

pub fn GeodistgeodesicRange::scale(self : GeodistgeodesicRange, f : Double) -> GeodistgeodesicRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicRange::add(self : GeodistgeodesicRange, other : GeodistgeodesicRange) -> GeodistgeodesicRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgeodesicRange::copy(self : GeodistgeodesicRange) -> GeodistgeodesicRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicRange::fill(self : GeodistgeodesicRange, v : Double) -> GeodistgeodesicRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicRange::min(self : GeodistgeodesicRange) -> Double { @_common.min(self.data) }

pub fn GeodistgeodesicRange::max(self : GeodistgeodesicRange) -> Double { @_common.max(self.data) }

pub fn GeodistgeodesicRange::to_string(self : GeodistgeodesicRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_slice_make(size : Int) -> GeodistgeodesicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistgeodesicSlice::len(self : GeodistgeodesicSlice) -> Int { self.size }

pub fn GeodistgeodesicSlice::get(self : GeodistgeodesicSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistgeodesicSlice::set(self : GeodistgeodesicSlice, i : Int, v : Double) -> GeodistgeodesicSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicSlice::sum(self : GeodistgeodesicSlice) -> Double { @_common.sum(self.data) }

pub fn GeodistgeodesicSlice::mean(self : GeodistgeodesicSlice) -> Double { @_common.mean(self.data) }

pub fn GeodistgeodesicSlice::scale(self : GeodistgeodesicSlice, f : Double) -> GeodistgeodesicSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicSlice::add(self : GeodistgeodesicSlice, other : GeodistgeodesicSlice) -> GeodistgeodesicSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistgeodesicSlice::copy(self : GeodistgeodesicSlice) -> GeodistgeodesicSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicSlice::fill(self : GeodistgeodesicSlice, v : Double) -> GeodistgeodesicSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistgeodesicSlice::min(self : GeodistgeodesicSlice) -> Double { @_common.min(self.data) }

pub fn GeodistgeodesicSlice::max(self : GeodistgeodesicSlice) -> Double { @_common.max(self.data) }

pub fn GeodistgeodesicSlice::to_string(self : GeodistgeodesicSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

