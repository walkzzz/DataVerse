///===
/// extcore/geo_dist_manhattan

pub(all) struct GeodistmanhattanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_manhattan_make_point(x : Double, y : Double) -> GeodistmanhattanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_manhattan_make_point3(x : Double, y : Double, z : Double) -> GeodistmanhattanPoint {
  { x, y, z, label: 0 }
}

pub fn GeodistmanhattanPoint::x(self : GeodistmanhattanPoint) -> Double { self.x }

pub fn GeodistmanhattanPoint::y(self : GeodistmanhattanPoint) -> Double { self.y }

pub fn GeodistmanhattanPoint::z(self : GeodistmanhattanPoint) -> Double { self.z }

pub fn GeodistmanhattanPoint::label(self : GeodistmanhattanPoint) -> Int { self.label }

pub fn GeodistmanhattanPoint::dist(self : GeodistmanhattanPoint, other : GeodistmanhattanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodistmanhattanPoint::add(self : GeodistmanhattanPoint, other : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodistmanhattanPoint::sub(self : GeodistmanhattanPoint, other : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodistmanhattanPoint::scale(self : GeodistmanhattanPoint, s : Double) -> GeodistmanhattanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodistmanhattanPoint::dot(self : GeodistmanhattanPoint, other : GeodistmanhattanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodistmanhattanPoint::cross(self : GeodistmanhattanPoint, other : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodistmanhattanPoint::norm(self : GeodistmanhattanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodistmanhattanPoint::normalize(self : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistmanhattanPoint::negate(self : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodistmanhattanPoint::mid(self : GeodistmanhattanPoint, other : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodistmanhattanPoint::lerp(self : GeodistmanhattanPoint, other : GeodistmanhattanPoint, t : Double) -> GeodistmanhattanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodistmanhattanPoint::to_string(self : GeodistmanhattanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodistmanhattanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_manhattan_make_series(vals : Array[Double], name : String) -> GeodistmanhattanSeries {
  { vals, name, meta: 0 }
}

pub fn GeodistmanhattanSeries::len(self : GeodistmanhattanSeries) -> Int { self.vals.length() }

pub fn GeodistmanhattanSeries::sum(self : GeodistmanhattanSeries) -> Double { @_common.sum(self.vals) }

pub fn GeodistmanhattanSeries::mean(self : GeodistmanhattanSeries) -> Double { @_common.mean(self.vals) }

pub fn GeodistmanhattanSeries::min(self : GeodistmanhattanSeries) -> Double { @_common.min(self.vals) }

pub fn GeodistmanhattanSeries::max(self : GeodistmanhattanSeries) -> Double { @_common.max(self.vals) }

pub fn GeodistmanhattanSeries::range(self : GeodistmanhattanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodistmanhattanSeries::variance(self : GeodistmanhattanSeries) -> Double { @_common.variance(self.vals) }

pub fn GeodistmanhattanSeries::std(self : GeodistmanhattanSeries) -> Double { @_common.std(self.vals) }

pub fn GeodistmanhattanSeries::median(self : GeodistmanhattanSeries) -> Double { @_common.median(self.vals) }

pub fn GeodistmanhattanSeries::scale(self : GeodistmanhattanSeries, f : Double) -> GeodistmanhattanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodistmanhattanSeries::add(self : GeodistmanhattanSeries, other : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodistmanhattanSeries::sub(self : GeodistmanhattanSeries, other : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodistmanhattanSeries::normalize(self : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodistmanhattanSeries::cumsum(self : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodistmanhattanSeries::to_string(self : GeodistmanhattanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistmanhattanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_manhattan_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistmanhattanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_manhattan_matrix_identity(n : Int) -> GeodistmanhattanMatrix {
  let m = geo_dist_manhattan_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodistmanhattanMatrix::get(self : GeodistmanhattanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodistmanhattanMatrix::transpose(self : GeodistmanhattanMatrix) -> GeodistmanhattanMatrix {
  let result = geo_dist_manhattan_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodistmanhattanMatrix::add(self : GeodistmanhattanMatrix, other : GeodistmanhattanMatrix) -> GeodistmanhattanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_manhattan_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodistmanhattanMatrix::scale(self : GeodistmanhattanMatrix, s : Double) -> GeodistmanhattanMatrix {
  let result = geo_dist_manhattan_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodistmanhattanMatrix::multiply(self : GeodistmanhattanMatrix, other : GeodistmanhattanMatrix) -> GeodistmanhattanMatrix {
  if self.cols != other.rows { return geo_dist_manhattan_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_manhattan_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeodistmanhattanMatrix::trace(self : GeodistmanhattanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodistmanhattanMatrix::det(self : GeodistmanhattanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodistmanhattanMatrix::norm(self : GeodistmanhattanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodistmanhattanMatrix::to_string(self : GeodistmanhattanMatrix) -> String {
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

pub(all) struct GeodistmanhattanVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_manhattan_make_vector(comps : Array[Double]) -> GeodistmanhattanVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_manhattan_vector_zero(dim : Int) -> GeodistmanhattanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodistmanhattanVector::add(self : GeodistmanhattanVector, other : GeodistmanhattanVector) -> GeodistmanhattanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistmanhattanVector::sub(self : GeodistmanhattanVector, other : GeodistmanhattanVector) -> GeodistmanhattanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistmanhattanVector::scale(self : GeodistmanhattanVector, s : Double) -> GeodistmanhattanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodistmanhattanVector::dot(self : GeodistmanhattanVector, other : GeodistmanhattanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodistmanhattanVector::norm(self : GeodistmanhattanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodistmanhattanVector::normalize(self : GeodistmanhattanVector) -> GeodistmanhattanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistmanhattanVector::dist(self : GeodistmanhattanVector, other : GeodistmanhattanVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodistmanhattanVector::to_string(self : GeodistmanhattanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_manhattan_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_manhattan_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_manhattan_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_manhattan_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_manhattan_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_manhattan_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_manhattan_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_manhattan_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_manhattan_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_manhattan_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_manhattan_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_manhattan_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_manhattan_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_manhattan_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_manhattan_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_manhattan_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_manhattan_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_manhattan_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_manhattan_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_manhattan_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_manhattan_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_manhattan_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_manhattan_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_manhattan_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_manhattan_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_manhattan_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_manhattan_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_manhattan_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_manhattan_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistmanhattanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_frame_make(size : Int) -> GeodistmanhattanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_frame_len(s : GeodistmanhattanFrame) -> Int { s.size }

pub fn geo_dist_manhattan_frame_get(s : GeodistmanhattanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_frame_set(s : GeodistmanhattanFrame, i : Int, v : Double) -> GeodistmanhattanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_frame_sum(s : GeodistmanhattanFrame) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_frame_mean(s : GeodistmanhattanFrame) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_frame_scale(s : GeodistmanhattanFrame, f : Double) -> GeodistmanhattanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_frame_add(a : GeodistmanhattanFrame, b : GeodistmanhattanFrame) -> GeodistmanhattanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_frame_copy(s : GeodistmanhattanFrame) -> GeodistmanhattanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_frame_fill(s : GeodistmanhattanFrame, v : Double) -> GeodistmanhattanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_frame_min(s : GeodistmanhattanFrame) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_frame_max(s : GeodistmanhattanFrame) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_frame_to_string(s : GeodistmanhattanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_table_make(size : Int) -> GeodistmanhattanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_table_len(s : GeodistmanhattanTable) -> Int { s.size }

pub fn geo_dist_manhattan_table_get(s : GeodistmanhattanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_table_set(s : GeodistmanhattanTable, i : Int, v : Double) -> GeodistmanhattanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_table_sum(s : GeodistmanhattanTable) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_table_mean(s : GeodistmanhattanTable) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_table_scale(s : GeodistmanhattanTable, f : Double) -> GeodistmanhattanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_table_add(a : GeodistmanhattanTable, b : GeodistmanhattanTable) -> GeodistmanhattanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_table_copy(s : GeodistmanhattanTable) -> GeodistmanhattanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_table_fill(s : GeodistmanhattanTable, v : Double) -> GeodistmanhattanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_table_min(s : GeodistmanhattanTable) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_table_max(s : GeodistmanhattanTable) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_table_to_string(s : GeodistmanhattanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_graphn_make(size : Int) -> GeodistmanhattanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_graphn_len(s : GeodistmanhattanGraphN) -> Int { s.size }

pub fn geo_dist_manhattan_graphn_get(s : GeodistmanhattanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_graphn_set(s : GeodistmanhattanGraphN, i : Int, v : Double) -> GeodistmanhattanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_graphn_sum(s : GeodistmanhattanGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_graphn_mean(s : GeodistmanhattanGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_graphn_scale(s : GeodistmanhattanGraphN, f : Double) -> GeodistmanhattanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_graphn_add(a : GeodistmanhattanGraphN, b : GeodistmanhattanGraphN) -> GeodistmanhattanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_graphn_copy(s : GeodistmanhattanGraphN) -> GeodistmanhattanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_graphn_fill(s : GeodistmanhattanGraphN, v : Double) -> GeodistmanhattanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_graphn_min(s : GeodistmanhattanGraphN) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_graphn_max(s : GeodistmanhattanGraphN) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_graphn_to_string(s : GeodistmanhattanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_node_make(size : Int) -> GeodistmanhattanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_node_len(s : GeodistmanhattanNode) -> Int { s.size }

pub fn geo_dist_manhattan_node_get(s : GeodistmanhattanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_node_set(s : GeodistmanhattanNode, i : Int, v : Double) -> GeodistmanhattanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_node_sum(s : GeodistmanhattanNode) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_node_mean(s : GeodistmanhattanNode) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_node_scale(s : GeodistmanhattanNode, f : Double) -> GeodistmanhattanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_node_add(a : GeodistmanhattanNode, b : GeodistmanhattanNode) -> GeodistmanhattanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_node_copy(s : GeodistmanhattanNode) -> GeodistmanhattanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_node_fill(s : GeodistmanhattanNode, v : Double) -> GeodistmanhattanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_node_min(s : GeodistmanhattanNode) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_node_max(s : GeodistmanhattanNode) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_node_to_string(s : GeodistmanhattanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_edge_make(size : Int) -> GeodistmanhattanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_edge_len(s : GeodistmanhattanEdge) -> Int { s.size }

pub fn geo_dist_manhattan_edge_get(s : GeodistmanhattanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_edge_set(s : GeodistmanhattanEdge, i : Int, v : Double) -> GeodistmanhattanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_edge_sum(s : GeodistmanhattanEdge) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_edge_mean(s : GeodistmanhattanEdge) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_edge_scale(s : GeodistmanhattanEdge, f : Double) -> GeodistmanhattanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_edge_add(a : GeodistmanhattanEdge, b : GeodistmanhattanEdge) -> GeodistmanhattanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_edge_copy(s : GeodistmanhattanEdge) -> GeodistmanhattanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_edge_fill(s : GeodistmanhattanEdge, v : Double) -> GeodistmanhattanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_edge_min(s : GeodistmanhattanEdge) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_edge_max(s : GeodistmanhattanEdge) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_edge_to_string(s : GeodistmanhattanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_path_make(size : Int) -> GeodistmanhattanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_path_len(s : GeodistmanhattanPath) -> Int { s.size }

pub fn geo_dist_manhattan_path_get(s : GeodistmanhattanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_path_set(s : GeodistmanhattanPath, i : Int, v : Double) -> GeodistmanhattanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_path_sum(s : GeodistmanhattanPath) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_path_mean(s : GeodistmanhattanPath) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_path_scale(s : GeodistmanhattanPath, f : Double) -> GeodistmanhattanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_path_add(a : GeodistmanhattanPath, b : GeodistmanhattanPath) -> GeodistmanhattanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_path_copy(s : GeodistmanhattanPath) -> GeodistmanhattanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_path_fill(s : GeodistmanhattanPath, v : Double) -> GeodistmanhattanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_path_min(s : GeodistmanhattanPath) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_path_max(s : GeodistmanhattanPath) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_path_to_string(s : GeodistmanhattanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_cluster_make(size : Int) -> GeodistmanhattanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_cluster_len(s : GeodistmanhattanCluster) -> Int { s.size }

pub fn geo_dist_manhattan_cluster_get(s : GeodistmanhattanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_cluster_set(s : GeodistmanhattanCluster, i : Int, v : Double) -> GeodistmanhattanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_cluster_sum(s : GeodistmanhattanCluster) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_cluster_mean(s : GeodistmanhattanCluster) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_cluster_scale(s : GeodistmanhattanCluster, f : Double) -> GeodistmanhattanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_cluster_add(a : GeodistmanhattanCluster, b : GeodistmanhattanCluster) -> GeodistmanhattanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_cluster_copy(s : GeodistmanhattanCluster) -> GeodistmanhattanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_cluster_fill(s : GeodistmanhattanCluster, v : Double) -> GeodistmanhattanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_cluster_min(s : GeodistmanhattanCluster) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_cluster_max(s : GeodistmanhattanCluster) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_cluster_to_string(s : GeodistmanhattanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_model_make(size : Int) -> GeodistmanhattanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_model_len(s : GeodistmanhattanModel) -> Int { s.size }

pub fn geo_dist_manhattan_model_get(s : GeodistmanhattanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_model_set(s : GeodistmanhattanModel, i : Int, v : Double) -> GeodistmanhattanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_model_sum(s : GeodistmanhattanModel) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_model_mean(s : GeodistmanhattanModel) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_model_scale(s : GeodistmanhattanModel, f : Double) -> GeodistmanhattanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_model_add(a : GeodistmanhattanModel, b : GeodistmanhattanModel) -> GeodistmanhattanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_model_copy(s : GeodistmanhattanModel) -> GeodistmanhattanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_model_fill(s : GeodistmanhattanModel, v : Double) -> GeodistmanhattanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_model_min(s : GeodistmanhattanModel) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_model_max(s : GeodistmanhattanModel) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_model_to_string(s : GeodistmanhattanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_layer_make(size : Int) -> GeodistmanhattanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_layer_len(s : GeodistmanhattanLayer) -> Int { s.size }

pub fn geo_dist_manhattan_layer_get(s : GeodistmanhattanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_layer_set(s : GeodistmanhattanLayer, i : Int, v : Double) -> GeodistmanhattanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_layer_sum(s : GeodistmanhattanLayer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_layer_mean(s : GeodistmanhattanLayer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_layer_scale(s : GeodistmanhattanLayer, f : Double) -> GeodistmanhattanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_layer_add(a : GeodistmanhattanLayer, b : GeodistmanhattanLayer) -> GeodistmanhattanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_layer_copy(s : GeodistmanhattanLayer) -> GeodistmanhattanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_layer_fill(s : GeodistmanhattanLayer, v : Double) -> GeodistmanhattanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_layer_min(s : GeodistmanhattanLayer) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_layer_max(s : GeodistmanhattanLayer) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_layer_to_string(s : GeodistmanhattanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_buffer_make(size : Int) -> GeodistmanhattanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_buffer_len(s : GeodistmanhattanBuffer) -> Int { s.size }

pub fn geo_dist_manhattan_buffer_get(s : GeodistmanhattanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_buffer_set(s : GeodistmanhattanBuffer, i : Int, v : Double) -> GeodistmanhattanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_buffer_sum(s : GeodistmanhattanBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_buffer_mean(s : GeodistmanhattanBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_buffer_scale(s : GeodistmanhattanBuffer, f : Double) -> GeodistmanhattanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_buffer_add(a : GeodistmanhattanBuffer, b : GeodistmanhattanBuffer) -> GeodistmanhattanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_buffer_copy(s : GeodistmanhattanBuffer) -> GeodistmanhattanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_buffer_fill(s : GeodistmanhattanBuffer, v : Double) -> GeodistmanhattanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_buffer_min(s : GeodistmanhattanBuffer) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_buffer_max(s : GeodistmanhattanBuffer) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_buffer_to_string(s : GeodistmanhattanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_cursor_make(size : Int) -> GeodistmanhattanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_cursor_len(s : GeodistmanhattanCursor) -> Int { s.size }

pub fn geo_dist_manhattan_cursor_get(s : GeodistmanhattanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_cursor_set(s : GeodistmanhattanCursor, i : Int, v : Double) -> GeodistmanhattanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_cursor_sum(s : GeodistmanhattanCursor) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_cursor_mean(s : GeodistmanhattanCursor) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_cursor_scale(s : GeodistmanhattanCursor, f : Double) -> GeodistmanhattanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_cursor_add(a : GeodistmanhattanCursor, b : GeodistmanhattanCursor) -> GeodistmanhattanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_cursor_copy(s : GeodistmanhattanCursor) -> GeodistmanhattanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_cursor_fill(s : GeodistmanhattanCursor, v : Double) -> GeodistmanhattanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_cursor_min(s : GeodistmanhattanCursor) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_cursor_max(s : GeodistmanhattanCursor) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_cursor_to_string(s : GeodistmanhattanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_view_make(size : Int) -> GeodistmanhattanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_view_len(s : GeodistmanhattanView) -> Int { s.size }

pub fn geo_dist_manhattan_view_get(s : GeodistmanhattanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_view_set(s : GeodistmanhattanView, i : Int, v : Double) -> GeodistmanhattanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_view_sum(s : GeodistmanhattanView) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_view_mean(s : GeodistmanhattanView) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_view_scale(s : GeodistmanhattanView, f : Double) -> GeodistmanhattanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_view_add(a : GeodistmanhattanView, b : GeodistmanhattanView) -> GeodistmanhattanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_view_copy(s : GeodistmanhattanView) -> GeodistmanhattanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_view_fill(s : GeodistmanhattanView, v : Double) -> GeodistmanhattanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_view_min(s : GeodistmanhattanView) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_view_max(s : GeodistmanhattanView) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_view_to_string(s : GeodistmanhattanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_range_make(size : Int) -> GeodistmanhattanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_range_len(s : GeodistmanhattanRange) -> Int { s.size }

pub fn geo_dist_manhattan_range_get(s : GeodistmanhattanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_range_set(s : GeodistmanhattanRange, i : Int, v : Double) -> GeodistmanhattanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_range_sum(s : GeodistmanhattanRange) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_range_mean(s : GeodistmanhattanRange) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_range_scale(s : GeodistmanhattanRange, f : Double) -> GeodistmanhattanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_range_add(a : GeodistmanhattanRange, b : GeodistmanhattanRange) -> GeodistmanhattanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_range_copy(s : GeodistmanhattanRange) -> GeodistmanhattanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_range_fill(s : GeodistmanhattanRange, v : Double) -> GeodistmanhattanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_range_min(s : GeodistmanhattanRange) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_range_max(s : GeodistmanhattanRange) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_range_to_string(s : GeodistmanhattanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_slice_make(size : Int) -> GeodistmanhattanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_slice_len(s : GeodistmanhattanSlice) -> Int { s.size }

pub fn geo_dist_manhattan_slice_get(s : GeodistmanhattanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_slice_set(s : GeodistmanhattanSlice, i : Int, v : Double) -> GeodistmanhattanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_slice_sum(s : GeodistmanhattanSlice) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_slice_mean(s : GeodistmanhattanSlice) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_slice_scale(s : GeodistmanhattanSlice, f : Double) -> GeodistmanhattanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_slice_add(a : GeodistmanhattanSlice, b : GeodistmanhattanSlice) -> GeodistmanhattanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_slice_copy(s : GeodistmanhattanSlice) -> GeodistmanhattanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_slice_fill(s : GeodistmanhattanSlice, v : Double) -> GeodistmanhattanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_slice_min(s : GeodistmanhattanSlice) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_slice_max(s : GeodistmanhattanSlice) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_slice_to_string(s : GeodistmanhattanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

