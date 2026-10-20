///===
/// extcore/geo_buffer_polygon

pub(all) struct GeobufferpolygonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_polygon_make_point(x : Double, y : Double) -> GeobufferpolygonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_polygon_make_point3(x : Double, y : Double, z : Double) -> GeobufferpolygonPoint {
  { x, y, z, label: 0 }
}

pub fn GeobufferpolygonPoint::x(self : GeobufferpolygonPoint) -> Double { self.x }

pub fn GeobufferpolygonPoint::y(self : GeobufferpolygonPoint) -> Double { self.y }

pub fn GeobufferpolygonPoint::z(self : GeobufferpolygonPoint) -> Double { self.z }

pub fn GeobufferpolygonPoint::label(self : GeobufferpolygonPoint) -> Int { self.label }

pub fn GeobufferpolygonPoint::dist(self : GeobufferpolygonPoint, other : GeobufferpolygonPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobufferpolygonPoint::add(self : GeobufferpolygonPoint, other : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobufferpolygonPoint::sub(self : GeobufferpolygonPoint, other : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobufferpolygonPoint::scale(self : GeobufferpolygonPoint, s : Double) -> GeobufferpolygonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobufferpolygonPoint::dot(self : GeobufferpolygonPoint, other : GeobufferpolygonPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobufferpolygonPoint::cross(self : GeobufferpolygonPoint, other : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobufferpolygonPoint::norm(self : GeobufferpolygonPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobufferpolygonPoint::normalize(self : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobufferpolygonPoint::negate(self : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobufferpolygonPoint::mid(self : GeobufferpolygonPoint, other : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobufferpolygonPoint::lerp(self : GeobufferpolygonPoint, other : GeobufferpolygonPoint, t : Double) -> GeobufferpolygonPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobufferpolygonPoint::to_string(self : GeobufferpolygonPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobufferpolygonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_polygon_make_series(vals : Array[Double], name : String) -> GeobufferpolygonSeries {
  { vals, name, meta: 0 }
}

pub fn GeobufferpolygonSeries::len(self : GeobufferpolygonSeries) -> Int { self.vals.length() }

pub fn GeobufferpolygonSeries::sum(self : GeobufferpolygonSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobufferpolygonSeries::mean(self : GeobufferpolygonSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobufferpolygonSeries::min(self : GeobufferpolygonSeries) -> Double { @_common.min(self.vals) }

pub fn GeobufferpolygonSeries::max(self : GeobufferpolygonSeries) -> Double { @_common.max(self.vals) }

pub fn GeobufferpolygonSeries::range(self : GeobufferpolygonSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobufferpolygonSeries::variance(self : GeobufferpolygonSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobufferpolygonSeries::std(self : GeobufferpolygonSeries) -> Double { @_common.std(self.vals) }

pub fn GeobufferpolygonSeries::median(self : GeobufferpolygonSeries) -> Double { @_common.median(self.vals) }

pub fn GeobufferpolygonSeries::scale(self : GeobufferpolygonSeries, f : Double) -> GeobufferpolygonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobufferpolygonSeries::add(self : GeobufferpolygonSeries, other : GeobufferpolygonSeries) -> GeobufferpolygonSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobufferpolygonSeries::sub(self : GeobufferpolygonSeries, other : GeobufferpolygonSeries) -> GeobufferpolygonSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobufferpolygonSeries::normalize(self : GeobufferpolygonSeries) -> GeobufferpolygonSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobufferpolygonSeries::cumsum(self : GeobufferpolygonSeries) -> GeobufferpolygonSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobufferpolygonSeries::to_string(self : GeobufferpolygonSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobufferpolygonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_polygon_make_matrix(rows : Int, cols : Int, val : Double) -> GeobufferpolygonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_polygon_matrix_identity(n : Int) -> GeobufferpolygonMatrix {
  let m = geo_buffer_polygon_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobufferpolygonMatrix::get(self : GeobufferpolygonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobufferpolygonMatrix::transpose(self : GeobufferpolygonMatrix) -> GeobufferpolygonMatrix {
  let result = geo_buffer_polygon_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobufferpolygonMatrix::add(self : GeobufferpolygonMatrix, other : GeobufferpolygonMatrix) -> GeobufferpolygonMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_polygon_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobufferpolygonMatrix::scale(self : GeobufferpolygonMatrix, s : Double) -> GeobufferpolygonMatrix {
  let result = geo_buffer_polygon_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobufferpolygonMatrix::multiply(self : GeobufferpolygonMatrix, other : GeobufferpolygonMatrix) -> GeobufferpolygonMatrix {
  if self.cols != other.rows { return geo_buffer_polygon_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_polygon_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeobufferpolygonMatrix::trace(self : GeobufferpolygonMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobufferpolygonMatrix::det(self : GeobufferpolygonMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobufferpolygonMatrix::norm(self : GeobufferpolygonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobufferpolygonMatrix::to_string(self : GeobufferpolygonMatrix) -> String {
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

pub(all) struct GeobufferpolygonVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_polygon_make_vector(comps : Array[Double]) -> GeobufferpolygonVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_polygon_vector_zero(dim : Int) -> GeobufferpolygonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobufferpolygonVector::add(self : GeobufferpolygonVector, other : GeobufferpolygonVector) -> GeobufferpolygonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobufferpolygonVector::sub(self : GeobufferpolygonVector, other : GeobufferpolygonVector) -> GeobufferpolygonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobufferpolygonVector::scale(self : GeobufferpolygonVector, s : Double) -> GeobufferpolygonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobufferpolygonVector::dot(self : GeobufferpolygonVector, other : GeobufferpolygonVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobufferpolygonVector::norm(self : GeobufferpolygonVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobufferpolygonVector::normalize(self : GeobufferpolygonVector) -> GeobufferpolygonVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobufferpolygonVector::dist(self : GeobufferpolygonVector, other : GeobufferpolygonVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobufferpolygonVector::to_string(self : GeobufferpolygonVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_polygon_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_buffer_polygon_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_buffer_polygon_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_buffer_polygon_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_buffer_polygon_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_buffer_polygon_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_buffer_polygon_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_buffer_polygon_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_buffer_polygon_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_buffer_polygon_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_buffer_polygon_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_buffer_polygon_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_buffer_polygon_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_buffer_polygon_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_buffer_polygon_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_buffer_polygon_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_buffer_polygon_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_buffer_polygon_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_buffer_polygon_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_buffer_polygon_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_buffer_polygon_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_buffer_polygon_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_buffer_polygon_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_buffer_polygon_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_buffer_polygon_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_buffer_polygon_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_buffer_polygon_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_buffer_polygon_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_buffer_polygon_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeobufferpolygonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_frame_make(size : Int) -> GeobufferpolygonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferpolygonFrame::len(self : GeobufferpolygonFrame) -> Int { self.size }

pub fn GeobufferpolygonFrame::get(self : GeobufferpolygonFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferpolygonFrame::set(self : GeobufferpolygonFrame, i : Int, v : Double) -> GeobufferpolygonFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonFrame::sum(self : GeobufferpolygonFrame) -> Double { @_common.sum(self.data) }

pub fn GeobufferpolygonFrame::mean(self : GeobufferpolygonFrame) -> Double { @_common.mean(self.data) }

pub fn GeobufferpolygonFrame::scale(self : GeobufferpolygonFrame, f : Double) -> GeobufferpolygonFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonFrame::add(self : GeobufferpolygonFrame, other : GeobufferpolygonFrame) -> GeobufferpolygonFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferpolygonFrame::copy(self : GeobufferpolygonFrame) -> GeobufferpolygonFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonFrame::fill(self : GeobufferpolygonFrame, v : Double) -> GeobufferpolygonFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonFrame::min(self : GeobufferpolygonFrame) -> Double { @_common.min(self.data) }

pub fn GeobufferpolygonFrame::max(self : GeobufferpolygonFrame) -> Double { @_common.max(self.data) }

pub fn GeobufferpolygonFrame::to_string(self : GeobufferpolygonFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_table_make(size : Int) -> GeobufferpolygonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferpolygonTable::len(self : GeobufferpolygonTable) -> Int { self.size }

pub fn GeobufferpolygonTable::get(self : GeobufferpolygonTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferpolygonTable::set(self : GeobufferpolygonTable, i : Int, v : Double) -> GeobufferpolygonTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonTable::sum(self : GeobufferpolygonTable) -> Double { @_common.sum(self.data) }

pub fn GeobufferpolygonTable::mean(self : GeobufferpolygonTable) -> Double { @_common.mean(self.data) }

pub fn GeobufferpolygonTable::scale(self : GeobufferpolygonTable, f : Double) -> GeobufferpolygonTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonTable::add(self : GeobufferpolygonTable, other : GeobufferpolygonTable) -> GeobufferpolygonTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferpolygonTable::copy(self : GeobufferpolygonTable) -> GeobufferpolygonTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonTable::fill(self : GeobufferpolygonTable, v : Double) -> GeobufferpolygonTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonTable::min(self : GeobufferpolygonTable) -> Double { @_common.min(self.data) }

pub fn GeobufferpolygonTable::max(self : GeobufferpolygonTable) -> Double { @_common.max(self.data) }

pub fn GeobufferpolygonTable::to_string(self : GeobufferpolygonTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_graphn_make(size : Int) -> GeobufferpolygonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferpolygonGraphN::len(self : GeobufferpolygonGraphN) -> Int { self.size }

pub fn GeobufferpolygonGraphN::get(self : GeobufferpolygonGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferpolygonGraphN::set(self : GeobufferpolygonGraphN, i : Int, v : Double) -> GeobufferpolygonGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonGraphN::sum(self : GeobufferpolygonGraphN) -> Double { @_common.sum(self.data) }

pub fn GeobufferpolygonGraphN::mean(self : GeobufferpolygonGraphN) -> Double { @_common.mean(self.data) }

pub fn GeobufferpolygonGraphN::scale(self : GeobufferpolygonGraphN, f : Double) -> GeobufferpolygonGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonGraphN::add(self : GeobufferpolygonGraphN, other : GeobufferpolygonGraphN) -> GeobufferpolygonGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferpolygonGraphN::copy(self : GeobufferpolygonGraphN) -> GeobufferpolygonGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonGraphN::fill(self : GeobufferpolygonGraphN, v : Double) -> GeobufferpolygonGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonGraphN::min(self : GeobufferpolygonGraphN) -> Double { @_common.min(self.data) }

pub fn GeobufferpolygonGraphN::max(self : GeobufferpolygonGraphN) -> Double { @_common.max(self.data) }

pub fn GeobufferpolygonGraphN::to_string(self : GeobufferpolygonGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_node_make(size : Int) -> GeobufferpolygonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferpolygonNode::len(self : GeobufferpolygonNode) -> Int { self.size }

pub fn GeobufferpolygonNode::get(self : GeobufferpolygonNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferpolygonNode::set(self : GeobufferpolygonNode, i : Int, v : Double) -> GeobufferpolygonNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonNode::sum(self : GeobufferpolygonNode) -> Double { @_common.sum(self.data) }

pub fn GeobufferpolygonNode::mean(self : GeobufferpolygonNode) -> Double { @_common.mean(self.data) }

pub fn GeobufferpolygonNode::scale(self : GeobufferpolygonNode, f : Double) -> GeobufferpolygonNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonNode::add(self : GeobufferpolygonNode, other : GeobufferpolygonNode) -> GeobufferpolygonNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferpolygonNode::copy(self : GeobufferpolygonNode) -> GeobufferpolygonNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonNode::fill(self : GeobufferpolygonNode, v : Double) -> GeobufferpolygonNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonNode::min(self : GeobufferpolygonNode) -> Double { @_common.min(self.data) }

pub fn GeobufferpolygonNode::max(self : GeobufferpolygonNode) -> Double { @_common.max(self.data) }

pub fn GeobufferpolygonNode::to_string(self : GeobufferpolygonNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_edge_make(size : Int) -> GeobufferpolygonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferpolygonEdge::len(self : GeobufferpolygonEdge) -> Int { self.size }

pub fn GeobufferpolygonEdge::get(self : GeobufferpolygonEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferpolygonEdge::set(self : GeobufferpolygonEdge, i : Int, v : Double) -> GeobufferpolygonEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonEdge::sum(self : GeobufferpolygonEdge) -> Double { @_common.sum(self.data) }

pub fn GeobufferpolygonEdge::mean(self : GeobufferpolygonEdge) -> Double { @_common.mean(self.data) }

pub fn GeobufferpolygonEdge::scale(self : GeobufferpolygonEdge, f : Double) -> GeobufferpolygonEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonEdge::add(self : GeobufferpolygonEdge, other : GeobufferpolygonEdge) -> GeobufferpolygonEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferpolygonEdge::copy(self : GeobufferpolygonEdge) -> GeobufferpolygonEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonEdge::fill(self : GeobufferpolygonEdge, v : Double) -> GeobufferpolygonEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonEdge::min(self : GeobufferpolygonEdge) -> Double { @_common.min(self.data) }

pub fn GeobufferpolygonEdge::max(self : GeobufferpolygonEdge) -> Double { @_common.max(self.data) }

pub fn GeobufferpolygonEdge::to_string(self : GeobufferpolygonEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_path_make(size : Int) -> GeobufferpolygonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferpolygonPath::len(self : GeobufferpolygonPath) -> Int { self.size }

pub fn GeobufferpolygonPath::get(self : GeobufferpolygonPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferpolygonPath::set(self : GeobufferpolygonPath, i : Int, v : Double) -> GeobufferpolygonPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonPath::sum(self : GeobufferpolygonPath) -> Double { @_common.sum(self.data) }

pub fn GeobufferpolygonPath::mean(self : GeobufferpolygonPath) -> Double { @_common.mean(self.data) }

pub fn GeobufferpolygonPath::scale(self : GeobufferpolygonPath, f : Double) -> GeobufferpolygonPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonPath::add(self : GeobufferpolygonPath, other : GeobufferpolygonPath) -> GeobufferpolygonPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferpolygonPath::copy(self : GeobufferpolygonPath) -> GeobufferpolygonPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonPath::fill(self : GeobufferpolygonPath, v : Double) -> GeobufferpolygonPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonPath::min(self : GeobufferpolygonPath) -> Double { @_common.min(self.data) }

pub fn GeobufferpolygonPath::max(self : GeobufferpolygonPath) -> Double { @_common.max(self.data) }

pub fn GeobufferpolygonPath::to_string(self : GeobufferpolygonPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_cluster_make(size : Int) -> GeobufferpolygonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferpolygonCluster::len(self : GeobufferpolygonCluster) -> Int { self.size }

pub fn GeobufferpolygonCluster::get(self : GeobufferpolygonCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferpolygonCluster::set(self : GeobufferpolygonCluster, i : Int, v : Double) -> GeobufferpolygonCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonCluster::sum(self : GeobufferpolygonCluster) -> Double { @_common.sum(self.data) }

pub fn GeobufferpolygonCluster::mean(self : GeobufferpolygonCluster) -> Double { @_common.mean(self.data) }

pub fn GeobufferpolygonCluster::scale(self : GeobufferpolygonCluster, f : Double) -> GeobufferpolygonCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonCluster::add(self : GeobufferpolygonCluster, other : GeobufferpolygonCluster) -> GeobufferpolygonCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferpolygonCluster::copy(self : GeobufferpolygonCluster) -> GeobufferpolygonCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonCluster::fill(self : GeobufferpolygonCluster, v : Double) -> GeobufferpolygonCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonCluster::min(self : GeobufferpolygonCluster) -> Double { @_common.min(self.data) }

pub fn GeobufferpolygonCluster::max(self : GeobufferpolygonCluster) -> Double { @_common.max(self.data) }

pub fn GeobufferpolygonCluster::to_string(self : GeobufferpolygonCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_model_make(size : Int) -> GeobufferpolygonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferpolygonModel::len(self : GeobufferpolygonModel) -> Int { self.size }

pub fn GeobufferpolygonModel::get(self : GeobufferpolygonModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferpolygonModel::set(self : GeobufferpolygonModel, i : Int, v : Double) -> GeobufferpolygonModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonModel::sum(self : GeobufferpolygonModel) -> Double { @_common.sum(self.data) }

pub fn GeobufferpolygonModel::mean(self : GeobufferpolygonModel) -> Double { @_common.mean(self.data) }

pub fn GeobufferpolygonModel::scale(self : GeobufferpolygonModel, f : Double) -> GeobufferpolygonModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonModel::add(self : GeobufferpolygonModel, other : GeobufferpolygonModel) -> GeobufferpolygonModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferpolygonModel::copy(self : GeobufferpolygonModel) -> GeobufferpolygonModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonModel::fill(self : GeobufferpolygonModel, v : Double) -> GeobufferpolygonModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonModel::min(self : GeobufferpolygonModel) -> Double { @_common.min(self.data) }

pub fn GeobufferpolygonModel::max(self : GeobufferpolygonModel) -> Double { @_common.max(self.data) }

pub fn GeobufferpolygonModel::to_string(self : GeobufferpolygonModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_layer_make(size : Int) -> GeobufferpolygonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferpolygonLayer::len(self : GeobufferpolygonLayer) -> Int { self.size }

pub fn GeobufferpolygonLayer::get(self : GeobufferpolygonLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferpolygonLayer::set(self : GeobufferpolygonLayer, i : Int, v : Double) -> GeobufferpolygonLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonLayer::sum(self : GeobufferpolygonLayer) -> Double { @_common.sum(self.data) }

pub fn GeobufferpolygonLayer::mean(self : GeobufferpolygonLayer) -> Double { @_common.mean(self.data) }

pub fn GeobufferpolygonLayer::scale(self : GeobufferpolygonLayer, f : Double) -> GeobufferpolygonLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonLayer::add(self : GeobufferpolygonLayer, other : GeobufferpolygonLayer) -> GeobufferpolygonLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferpolygonLayer::copy(self : GeobufferpolygonLayer) -> GeobufferpolygonLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonLayer::fill(self : GeobufferpolygonLayer, v : Double) -> GeobufferpolygonLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonLayer::min(self : GeobufferpolygonLayer) -> Double { @_common.min(self.data) }

pub fn GeobufferpolygonLayer::max(self : GeobufferpolygonLayer) -> Double { @_common.max(self.data) }

pub fn GeobufferpolygonLayer::to_string(self : GeobufferpolygonLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_buffer_make(size : Int) -> GeobufferpolygonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferpolygonBuffer::len(self : GeobufferpolygonBuffer) -> Int { self.size }

pub fn GeobufferpolygonBuffer::get(self : GeobufferpolygonBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferpolygonBuffer::set(self : GeobufferpolygonBuffer, i : Int, v : Double) -> GeobufferpolygonBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonBuffer::sum(self : GeobufferpolygonBuffer) -> Double { @_common.sum(self.data) }

pub fn GeobufferpolygonBuffer::mean(self : GeobufferpolygonBuffer) -> Double { @_common.mean(self.data) }

pub fn GeobufferpolygonBuffer::scale(self : GeobufferpolygonBuffer, f : Double) -> GeobufferpolygonBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonBuffer::add(self : GeobufferpolygonBuffer, other : GeobufferpolygonBuffer) -> GeobufferpolygonBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferpolygonBuffer::copy(self : GeobufferpolygonBuffer) -> GeobufferpolygonBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonBuffer::fill(self : GeobufferpolygonBuffer, v : Double) -> GeobufferpolygonBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonBuffer::min(self : GeobufferpolygonBuffer) -> Double { @_common.min(self.data) }

pub fn GeobufferpolygonBuffer::max(self : GeobufferpolygonBuffer) -> Double { @_common.max(self.data) }

pub fn GeobufferpolygonBuffer::to_string(self : GeobufferpolygonBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_cursor_make(size : Int) -> GeobufferpolygonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferpolygonCursor::len(self : GeobufferpolygonCursor) -> Int { self.size }

pub fn GeobufferpolygonCursor::get(self : GeobufferpolygonCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferpolygonCursor::set(self : GeobufferpolygonCursor, i : Int, v : Double) -> GeobufferpolygonCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonCursor::sum(self : GeobufferpolygonCursor) -> Double { @_common.sum(self.data) }

pub fn GeobufferpolygonCursor::mean(self : GeobufferpolygonCursor) -> Double { @_common.mean(self.data) }

pub fn GeobufferpolygonCursor::scale(self : GeobufferpolygonCursor, f : Double) -> GeobufferpolygonCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonCursor::add(self : GeobufferpolygonCursor, other : GeobufferpolygonCursor) -> GeobufferpolygonCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferpolygonCursor::copy(self : GeobufferpolygonCursor) -> GeobufferpolygonCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonCursor::fill(self : GeobufferpolygonCursor, v : Double) -> GeobufferpolygonCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonCursor::min(self : GeobufferpolygonCursor) -> Double { @_common.min(self.data) }

pub fn GeobufferpolygonCursor::max(self : GeobufferpolygonCursor) -> Double { @_common.max(self.data) }

pub fn GeobufferpolygonCursor::to_string(self : GeobufferpolygonCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_view_make(size : Int) -> GeobufferpolygonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferpolygonView::len(self : GeobufferpolygonView) -> Int { self.size }

pub fn GeobufferpolygonView::get(self : GeobufferpolygonView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferpolygonView::set(self : GeobufferpolygonView, i : Int, v : Double) -> GeobufferpolygonView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonView::sum(self : GeobufferpolygonView) -> Double { @_common.sum(self.data) }

pub fn GeobufferpolygonView::mean(self : GeobufferpolygonView) -> Double { @_common.mean(self.data) }

pub fn GeobufferpolygonView::scale(self : GeobufferpolygonView, f : Double) -> GeobufferpolygonView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonView::add(self : GeobufferpolygonView, other : GeobufferpolygonView) -> GeobufferpolygonView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferpolygonView::copy(self : GeobufferpolygonView) -> GeobufferpolygonView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonView::fill(self : GeobufferpolygonView, v : Double) -> GeobufferpolygonView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonView::min(self : GeobufferpolygonView) -> Double { @_common.min(self.data) }

pub fn GeobufferpolygonView::max(self : GeobufferpolygonView) -> Double { @_common.max(self.data) }

pub fn GeobufferpolygonView::to_string(self : GeobufferpolygonView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_range_make(size : Int) -> GeobufferpolygonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferpolygonRange::len(self : GeobufferpolygonRange) -> Int { self.size }

pub fn GeobufferpolygonRange::get(self : GeobufferpolygonRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferpolygonRange::set(self : GeobufferpolygonRange, i : Int, v : Double) -> GeobufferpolygonRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonRange::sum(self : GeobufferpolygonRange) -> Double { @_common.sum(self.data) }

pub fn GeobufferpolygonRange::mean(self : GeobufferpolygonRange) -> Double { @_common.mean(self.data) }

pub fn GeobufferpolygonRange::scale(self : GeobufferpolygonRange, f : Double) -> GeobufferpolygonRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonRange::add(self : GeobufferpolygonRange, other : GeobufferpolygonRange) -> GeobufferpolygonRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferpolygonRange::copy(self : GeobufferpolygonRange) -> GeobufferpolygonRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonRange::fill(self : GeobufferpolygonRange, v : Double) -> GeobufferpolygonRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonRange::min(self : GeobufferpolygonRange) -> Double { @_common.min(self.data) }

pub fn GeobufferpolygonRange::max(self : GeobufferpolygonRange) -> Double { @_common.max(self.data) }

pub fn GeobufferpolygonRange::to_string(self : GeobufferpolygonRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_slice_make(size : Int) -> GeobufferpolygonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferpolygonSlice::len(self : GeobufferpolygonSlice) -> Int { self.size }

pub fn GeobufferpolygonSlice::get(self : GeobufferpolygonSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferpolygonSlice::set(self : GeobufferpolygonSlice, i : Int, v : Double) -> GeobufferpolygonSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonSlice::sum(self : GeobufferpolygonSlice) -> Double { @_common.sum(self.data) }

pub fn GeobufferpolygonSlice::mean(self : GeobufferpolygonSlice) -> Double { @_common.mean(self.data) }

pub fn GeobufferpolygonSlice::scale(self : GeobufferpolygonSlice, f : Double) -> GeobufferpolygonSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonSlice::add(self : GeobufferpolygonSlice, other : GeobufferpolygonSlice) -> GeobufferpolygonSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferpolygonSlice::copy(self : GeobufferpolygonSlice) -> GeobufferpolygonSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonSlice::fill(self : GeobufferpolygonSlice, v : Double) -> GeobufferpolygonSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferpolygonSlice::min(self : GeobufferpolygonSlice) -> Double { @_common.min(self.data) }

pub fn GeobufferpolygonSlice::max(self : GeobufferpolygonSlice) -> Double { @_common.max(self.data) }

pub fn GeobufferpolygonSlice::to_string(self : GeobufferpolygonSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

