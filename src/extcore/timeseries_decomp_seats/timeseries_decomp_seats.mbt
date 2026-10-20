///===
/// extcore/timeseries_decomp_seats

pub(all) struct TimeseriesdecompseatsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_seats_make_point(x : Double, y : Double) -> TimeseriesdecompseatsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_seats_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompseatsPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesdecompseatsPoint::x(self : TimeseriesdecompseatsPoint) -> Double { self.x }

pub fn TimeseriesdecompseatsPoint::y(self : TimeseriesdecompseatsPoint) -> Double { self.y }

pub fn TimeseriesdecompseatsPoint::z(self : TimeseriesdecompseatsPoint) -> Double { self.z }

pub fn TimeseriesdecompseatsPoint::label(self : TimeseriesdecompseatsPoint) -> Int { self.label }

pub fn TimeseriesdecompseatsPoint::dist(self : TimeseriesdecompseatsPoint, other : TimeseriesdecompseatsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesdecompseatsPoint::add(self : TimeseriesdecompseatsPoint, other : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesdecompseatsPoint::sub(self : TimeseriesdecompseatsPoint, other : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesdecompseatsPoint::scale(self : TimeseriesdecompseatsPoint, s : Double) -> TimeseriesdecompseatsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesdecompseatsPoint::dot(self : TimeseriesdecompseatsPoint, other : TimeseriesdecompseatsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesdecompseatsPoint::cross(self : TimeseriesdecompseatsPoint, other : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesdecompseatsPoint::norm(self : TimeseriesdecompseatsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesdecompseatsPoint::normalize(self : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompseatsPoint::negate(self : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesdecompseatsPoint::mid(self : TimeseriesdecompseatsPoint, other : TimeseriesdecompseatsPoint) -> TimeseriesdecompseatsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesdecompseatsPoint::lerp(self : TimeseriesdecompseatsPoint, other : TimeseriesdecompseatsPoint, t : Double) -> TimeseriesdecompseatsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesdecompseatsPoint::to_string(self : TimeseriesdecompseatsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_seats_make_series(vals : Array[Double], name : String) -> TimeseriesdecompseatsSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesdecompseatsSeries::len(self : TimeseriesdecompseatsSeries) -> Int { self.vals.length() }

pub fn TimeseriesdecompseatsSeries::sum(self : TimeseriesdecompseatsSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesdecompseatsSeries::mean(self : TimeseriesdecompseatsSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesdecompseatsSeries::min(self : TimeseriesdecompseatsSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesdecompseatsSeries::max(self : TimeseriesdecompseatsSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesdecompseatsSeries::range(self : TimeseriesdecompseatsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesdecompseatsSeries::variance(self : TimeseriesdecompseatsSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesdecompseatsSeries::std(self : TimeseriesdecompseatsSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesdecompseatsSeries::median(self : TimeseriesdecompseatsSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesdecompseatsSeries::scale(self : TimeseriesdecompseatsSeries, f : Double) -> TimeseriesdecompseatsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesdecompseatsSeries::add(self : TimeseriesdecompseatsSeries, other : TimeseriesdecompseatsSeries) -> TimeseriesdecompseatsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompseatsSeries::sub(self : TimeseriesdecompseatsSeries, other : TimeseriesdecompseatsSeries) -> TimeseriesdecompseatsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompseatsSeries::normalize(self : TimeseriesdecompseatsSeries) -> TimeseriesdecompseatsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesdecompseatsSeries::cumsum(self : TimeseriesdecompseatsSeries) -> TimeseriesdecompseatsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesdecompseatsSeries::to_string(self : TimeseriesdecompseatsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompseatsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_seats_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompseatsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_seats_matrix_identity(n : Int) -> TimeseriesdecompseatsMatrix {
  let m = timeseries_decomp_seats_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesdecompseatsMatrix::get(self : TimeseriesdecompseatsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesdecompseatsMatrix::transpose(self : TimeseriesdecompseatsMatrix) -> TimeseriesdecompseatsMatrix {
  let result = timeseries_decomp_seats_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesdecompseatsMatrix::add(self : TimeseriesdecompseatsMatrix, other : TimeseriesdecompseatsMatrix) -> TimeseriesdecompseatsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_seats_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesdecompseatsMatrix::scale(self : TimeseriesdecompseatsMatrix, s : Double) -> TimeseriesdecompseatsMatrix {
  let result = timeseries_decomp_seats_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesdecompseatsMatrix::multiply(self : TimeseriesdecompseatsMatrix, other : TimeseriesdecompseatsMatrix) -> TimeseriesdecompseatsMatrix {
  if self.cols != other.rows { return timeseries_decomp_seats_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_seats_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesdecompseatsMatrix::trace(self : TimeseriesdecompseatsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesdecompseatsMatrix::det(self : TimeseriesdecompseatsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesdecompseatsMatrix::norm(self : TimeseriesdecompseatsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesdecompseatsMatrix::to_string(self : TimeseriesdecompseatsMatrix) -> String {
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

pub(all) struct TimeseriesdecompseatsVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_seats_make_vector(comps : Array[Double]) -> TimeseriesdecompseatsVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_seats_vector_zero(dim : Int) -> TimeseriesdecompseatsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesdecompseatsVector::add(self : TimeseriesdecompseatsVector, other : TimeseriesdecompseatsVector) -> TimeseriesdecompseatsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompseatsVector::sub(self : TimeseriesdecompseatsVector, other : TimeseriesdecompseatsVector) -> TimeseriesdecompseatsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompseatsVector::scale(self : TimeseriesdecompseatsVector, s : Double) -> TimeseriesdecompseatsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesdecompseatsVector::dot(self : TimeseriesdecompseatsVector, other : TimeseriesdecompseatsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesdecompseatsVector::norm(self : TimeseriesdecompseatsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesdecompseatsVector::normalize(self : TimeseriesdecompseatsVector) -> TimeseriesdecompseatsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompseatsVector::dist(self : TimeseriesdecompseatsVector, other : TimeseriesdecompseatsVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesdecompseatsVector::to_string(self : TimeseriesdecompseatsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_seats_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_decomp_seats_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_decomp_seats_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_decomp_seats_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_decomp_seats_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_decomp_seats_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_decomp_seats_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_decomp_seats_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_decomp_seats_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_decomp_seats_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_decomp_seats_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_decomp_seats_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_decomp_seats_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_decomp_seats_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_decomp_seats_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_decomp_seats_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_decomp_seats_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_decomp_seats_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_decomp_seats_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_decomp_seats_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_decomp_seats_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_decomp_seats_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_decomp_seats_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_decomp_seats_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_decomp_seats_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_decomp_seats_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_decomp_seats_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_decomp_seats_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_decomp_seats_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesdecompseatsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_frame_make(size : Int) -> TimeseriesdecompseatsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_frame_len(s : TimeseriesdecompseatsFrame) -> Int { s.size }

pub fn timeseries_decomp_seats_frame_get(s : TimeseriesdecompseatsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_frame_set(s : TimeseriesdecompseatsFrame, i : Int, v : Double) -> TimeseriesdecompseatsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_frame_sum(s : TimeseriesdecompseatsFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_seats_frame_mean(s : TimeseriesdecompseatsFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_seats_frame_scale(s : TimeseriesdecompseatsFrame, f : Double) -> TimeseriesdecompseatsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_frame_add(a : TimeseriesdecompseatsFrame, b : TimeseriesdecompseatsFrame) -> TimeseriesdecompseatsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_seats_frame_copy(s : TimeseriesdecompseatsFrame) -> TimeseriesdecompseatsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_frame_fill(s : TimeseriesdecompseatsFrame, v : Double) -> TimeseriesdecompseatsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_frame_min(s : TimeseriesdecompseatsFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_seats_frame_max(s : TimeseriesdecompseatsFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_seats_frame_to_string(s : TimeseriesdecompseatsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_table_make(size : Int) -> TimeseriesdecompseatsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_table_len(s : TimeseriesdecompseatsTable) -> Int { s.size }

pub fn timeseries_decomp_seats_table_get(s : TimeseriesdecompseatsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_table_set(s : TimeseriesdecompseatsTable, i : Int, v : Double) -> TimeseriesdecompseatsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_table_sum(s : TimeseriesdecompseatsTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_seats_table_mean(s : TimeseriesdecompseatsTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_seats_table_scale(s : TimeseriesdecompseatsTable, f : Double) -> TimeseriesdecompseatsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_table_add(a : TimeseriesdecompseatsTable, b : TimeseriesdecompseatsTable) -> TimeseriesdecompseatsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_seats_table_copy(s : TimeseriesdecompseatsTable) -> TimeseriesdecompseatsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_table_fill(s : TimeseriesdecompseatsTable, v : Double) -> TimeseriesdecompseatsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_table_min(s : TimeseriesdecompseatsTable) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_seats_table_max(s : TimeseriesdecompseatsTable) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_seats_table_to_string(s : TimeseriesdecompseatsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_graphn_make(size : Int) -> TimeseriesdecompseatsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_graphn_len(s : TimeseriesdecompseatsGraphN) -> Int { s.size }

pub fn timeseries_decomp_seats_graphn_get(s : TimeseriesdecompseatsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_graphn_set(s : TimeseriesdecompseatsGraphN, i : Int, v : Double) -> TimeseriesdecompseatsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_graphn_sum(s : TimeseriesdecompseatsGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_seats_graphn_mean(s : TimeseriesdecompseatsGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_seats_graphn_scale(s : TimeseriesdecompseatsGraphN, f : Double) -> TimeseriesdecompseatsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_graphn_add(a : TimeseriesdecompseatsGraphN, b : TimeseriesdecompseatsGraphN) -> TimeseriesdecompseatsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_seats_graphn_copy(s : TimeseriesdecompseatsGraphN) -> TimeseriesdecompseatsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_graphn_fill(s : TimeseriesdecompseatsGraphN, v : Double) -> TimeseriesdecompseatsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_graphn_min(s : TimeseriesdecompseatsGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_seats_graphn_max(s : TimeseriesdecompseatsGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_seats_graphn_to_string(s : TimeseriesdecompseatsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_node_make(size : Int) -> TimeseriesdecompseatsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_node_len(s : TimeseriesdecompseatsNode) -> Int { s.size }

pub fn timeseries_decomp_seats_node_get(s : TimeseriesdecompseatsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_node_set(s : TimeseriesdecompseatsNode, i : Int, v : Double) -> TimeseriesdecompseatsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_node_sum(s : TimeseriesdecompseatsNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_seats_node_mean(s : TimeseriesdecompseatsNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_seats_node_scale(s : TimeseriesdecompseatsNode, f : Double) -> TimeseriesdecompseatsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_node_add(a : TimeseriesdecompseatsNode, b : TimeseriesdecompseatsNode) -> TimeseriesdecompseatsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_seats_node_copy(s : TimeseriesdecompseatsNode) -> TimeseriesdecompseatsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_node_fill(s : TimeseriesdecompseatsNode, v : Double) -> TimeseriesdecompseatsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_node_min(s : TimeseriesdecompseatsNode) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_seats_node_max(s : TimeseriesdecompseatsNode) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_seats_node_to_string(s : TimeseriesdecompseatsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_edge_make(size : Int) -> TimeseriesdecompseatsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_edge_len(s : TimeseriesdecompseatsEdge) -> Int { s.size }

pub fn timeseries_decomp_seats_edge_get(s : TimeseriesdecompseatsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_edge_set(s : TimeseriesdecompseatsEdge, i : Int, v : Double) -> TimeseriesdecompseatsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_edge_sum(s : TimeseriesdecompseatsEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_seats_edge_mean(s : TimeseriesdecompseatsEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_seats_edge_scale(s : TimeseriesdecompseatsEdge, f : Double) -> TimeseriesdecompseatsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_edge_add(a : TimeseriesdecompseatsEdge, b : TimeseriesdecompseatsEdge) -> TimeseriesdecompseatsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_seats_edge_copy(s : TimeseriesdecompseatsEdge) -> TimeseriesdecompseatsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_edge_fill(s : TimeseriesdecompseatsEdge, v : Double) -> TimeseriesdecompseatsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_edge_min(s : TimeseriesdecompseatsEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_seats_edge_max(s : TimeseriesdecompseatsEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_seats_edge_to_string(s : TimeseriesdecompseatsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_path_make(size : Int) -> TimeseriesdecompseatsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_path_len(s : TimeseriesdecompseatsPath) -> Int { s.size }

pub fn timeseries_decomp_seats_path_get(s : TimeseriesdecompseatsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_path_set(s : TimeseriesdecompseatsPath, i : Int, v : Double) -> TimeseriesdecompseatsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_path_sum(s : TimeseriesdecompseatsPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_seats_path_mean(s : TimeseriesdecompseatsPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_seats_path_scale(s : TimeseriesdecompseatsPath, f : Double) -> TimeseriesdecompseatsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_path_add(a : TimeseriesdecompseatsPath, b : TimeseriesdecompseatsPath) -> TimeseriesdecompseatsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_seats_path_copy(s : TimeseriesdecompseatsPath) -> TimeseriesdecompseatsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_path_fill(s : TimeseriesdecompseatsPath, v : Double) -> TimeseriesdecompseatsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_path_min(s : TimeseriesdecompseatsPath) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_seats_path_max(s : TimeseriesdecompseatsPath) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_seats_path_to_string(s : TimeseriesdecompseatsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_cluster_make(size : Int) -> TimeseriesdecompseatsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_cluster_len(s : TimeseriesdecompseatsCluster) -> Int { s.size }

pub fn timeseries_decomp_seats_cluster_get(s : TimeseriesdecompseatsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_cluster_set(s : TimeseriesdecompseatsCluster, i : Int, v : Double) -> TimeseriesdecompseatsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_cluster_sum(s : TimeseriesdecompseatsCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_seats_cluster_mean(s : TimeseriesdecompseatsCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_seats_cluster_scale(s : TimeseriesdecompseatsCluster, f : Double) -> TimeseriesdecompseatsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_cluster_add(a : TimeseriesdecompseatsCluster, b : TimeseriesdecompseatsCluster) -> TimeseriesdecompseatsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_seats_cluster_copy(s : TimeseriesdecompseatsCluster) -> TimeseriesdecompseatsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_cluster_fill(s : TimeseriesdecompseatsCluster, v : Double) -> TimeseriesdecompseatsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_cluster_min(s : TimeseriesdecompseatsCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_seats_cluster_max(s : TimeseriesdecompseatsCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_seats_cluster_to_string(s : TimeseriesdecompseatsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_model_make(size : Int) -> TimeseriesdecompseatsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_model_len(s : TimeseriesdecompseatsModel) -> Int { s.size }

pub fn timeseries_decomp_seats_model_get(s : TimeseriesdecompseatsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_model_set(s : TimeseriesdecompseatsModel, i : Int, v : Double) -> TimeseriesdecompseatsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_model_sum(s : TimeseriesdecompseatsModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_seats_model_mean(s : TimeseriesdecompseatsModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_seats_model_scale(s : TimeseriesdecompseatsModel, f : Double) -> TimeseriesdecompseatsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_model_add(a : TimeseriesdecompseatsModel, b : TimeseriesdecompseatsModel) -> TimeseriesdecompseatsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_seats_model_copy(s : TimeseriesdecompseatsModel) -> TimeseriesdecompseatsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_model_fill(s : TimeseriesdecompseatsModel, v : Double) -> TimeseriesdecompseatsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_model_min(s : TimeseriesdecompseatsModel) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_seats_model_max(s : TimeseriesdecompseatsModel) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_seats_model_to_string(s : TimeseriesdecompseatsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_layer_make(size : Int) -> TimeseriesdecompseatsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_layer_len(s : TimeseriesdecompseatsLayer) -> Int { s.size }

pub fn timeseries_decomp_seats_layer_get(s : TimeseriesdecompseatsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_layer_set(s : TimeseriesdecompseatsLayer, i : Int, v : Double) -> TimeseriesdecompseatsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_layer_sum(s : TimeseriesdecompseatsLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_seats_layer_mean(s : TimeseriesdecompseatsLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_seats_layer_scale(s : TimeseriesdecompseatsLayer, f : Double) -> TimeseriesdecompseatsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_layer_add(a : TimeseriesdecompseatsLayer, b : TimeseriesdecompseatsLayer) -> TimeseriesdecompseatsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_seats_layer_copy(s : TimeseriesdecompseatsLayer) -> TimeseriesdecompseatsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_layer_fill(s : TimeseriesdecompseatsLayer, v : Double) -> TimeseriesdecompseatsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_layer_min(s : TimeseriesdecompseatsLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_seats_layer_max(s : TimeseriesdecompseatsLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_seats_layer_to_string(s : TimeseriesdecompseatsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_buffer_make(size : Int) -> TimeseriesdecompseatsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_buffer_len(s : TimeseriesdecompseatsBuffer) -> Int { s.size }

pub fn timeseries_decomp_seats_buffer_get(s : TimeseriesdecompseatsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_buffer_set(s : TimeseriesdecompseatsBuffer, i : Int, v : Double) -> TimeseriesdecompseatsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_buffer_sum(s : TimeseriesdecompseatsBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_seats_buffer_mean(s : TimeseriesdecompseatsBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_seats_buffer_scale(s : TimeseriesdecompseatsBuffer, f : Double) -> TimeseriesdecompseatsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_buffer_add(a : TimeseriesdecompseatsBuffer, b : TimeseriesdecompseatsBuffer) -> TimeseriesdecompseatsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_seats_buffer_copy(s : TimeseriesdecompseatsBuffer) -> TimeseriesdecompseatsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_buffer_fill(s : TimeseriesdecompseatsBuffer, v : Double) -> TimeseriesdecompseatsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_buffer_min(s : TimeseriesdecompseatsBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_seats_buffer_max(s : TimeseriesdecompseatsBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_seats_buffer_to_string(s : TimeseriesdecompseatsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_cursor_make(size : Int) -> TimeseriesdecompseatsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_cursor_len(s : TimeseriesdecompseatsCursor) -> Int { s.size }

pub fn timeseries_decomp_seats_cursor_get(s : TimeseriesdecompseatsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_cursor_set(s : TimeseriesdecompseatsCursor, i : Int, v : Double) -> TimeseriesdecompseatsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_cursor_sum(s : TimeseriesdecompseatsCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_seats_cursor_mean(s : TimeseriesdecompseatsCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_seats_cursor_scale(s : TimeseriesdecompseatsCursor, f : Double) -> TimeseriesdecompseatsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_cursor_add(a : TimeseriesdecompseatsCursor, b : TimeseriesdecompseatsCursor) -> TimeseriesdecompseatsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_seats_cursor_copy(s : TimeseriesdecompseatsCursor) -> TimeseriesdecompseatsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_cursor_fill(s : TimeseriesdecompseatsCursor, v : Double) -> TimeseriesdecompseatsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_cursor_min(s : TimeseriesdecompseatsCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_seats_cursor_max(s : TimeseriesdecompseatsCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_seats_cursor_to_string(s : TimeseriesdecompseatsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_view_make(size : Int) -> TimeseriesdecompseatsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_view_len(s : TimeseriesdecompseatsView) -> Int { s.size }

pub fn timeseries_decomp_seats_view_get(s : TimeseriesdecompseatsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_view_set(s : TimeseriesdecompseatsView, i : Int, v : Double) -> TimeseriesdecompseatsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_view_sum(s : TimeseriesdecompseatsView) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_seats_view_mean(s : TimeseriesdecompseatsView) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_seats_view_scale(s : TimeseriesdecompseatsView, f : Double) -> TimeseriesdecompseatsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_view_add(a : TimeseriesdecompseatsView, b : TimeseriesdecompseatsView) -> TimeseriesdecompseatsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_seats_view_copy(s : TimeseriesdecompseatsView) -> TimeseriesdecompseatsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_view_fill(s : TimeseriesdecompseatsView, v : Double) -> TimeseriesdecompseatsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_view_min(s : TimeseriesdecompseatsView) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_seats_view_max(s : TimeseriesdecompseatsView) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_seats_view_to_string(s : TimeseriesdecompseatsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_range_make(size : Int) -> TimeseriesdecompseatsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_range_len(s : TimeseriesdecompseatsRange) -> Int { s.size }

pub fn timeseries_decomp_seats_range_get(s : TimeseriesdecompseatsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_range_set(s : TimeseriesdecompseatsRange, i : Int, v : Double) -> TimeseriesdecompseatsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_range_sum(s : TimeseriesdecompseatsRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_seats_range_mean(s : TimeseriesdecompseatsRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_seats_range_scale(s : TimeseriesdecompseatsRange, f : Double) -> TimeseriesdecompseatsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_range_add(a : TimeseriesdecompseatsRange, b : TimeseriesdecompseatsRange) -> TimeseriesdecompseatsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_seats_range_copy(s : TimeseriesdecompseatsRange) -> TimeseriesdecompseatsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_range_fill(s : TimeseriesdecompseatsRange, v : Double) -> TimeseriesdecompseatsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_range_min(s : TimeseriesdecompseatsRange) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_seats_range_max(s : TimeseriesdecompseatsRange) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_seats_range_to_string(s : TimeseriesdecompseatsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompseatsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_seats_slice_make(size : Int) -> TimeseriesdecompseatsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_seats_slice_len(s : TimeseriesdecompseatsSlice) -> Int { s.size }

pub fn timeseries_decomp_seats_slice_get(s : TimeseriesdecompseatsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_seats_slice_set(s : TimeseriesdecompseatsSlice, i : Int, v : Double) -> TimeseriesdecompseatsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_slice_sum(s : TimeseriesdecompseatsSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_seats_slice_mean(s : TimeseriesdecompseatsSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_seats_slice_scale(s : TimeseriesdecompseatsSlice, f : Double) -> TimeseriesdecompseatsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_slice_add(a : TimeseriesdecompseatsSlice, b : TimeseriesdecompseatsSlice) -> TimeseriesdecompseatsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_seats_slice_copy(s : TimeseriesdecompseatsSlice) -> TimeseriesdecompseatsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_slice_fill(s : TimeseriesdecompseatsSlice, v : Double) -> TimeseriesdecompseatsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_seats_slice_min(s : TimeseriesdecompseatsSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_seats_slice_max(s : TimeseriesdecompseatsSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_seats_slice_to_string(s : TimeseriesdecompseatsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

