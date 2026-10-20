///===
/// extcore/timeseries_forecast_deepar

pub(all) struct TimeseriesforecastdeeparPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_deepar_make_point(x : Double, y : Double) -> TimeseriesforecastdeeparPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_deepar_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastdeeparPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecastdeeparPoint::x(self : TimeseriesforecastdeeparPoint) -> Double { self.x }

pub fn TimeseriesforecastdeeparPoint::y(self : TimeseriesforecastdeeparPoint) -> Double { self.y }

pub fn TimeseriesforecastdeeparPoint::z(self : TimeseriesforecastdeeparPoint) -> Double { self.z }

pub fn TimeseriesforecastdeeparPoint::label(self : TimeseriesforecastdeeparPoint) -> Int { self.label }

pub fn TimeseriesforecastdeeparPoint::dist(self : TimeseriesforecastdeeparPoint, other : TimeseriesforecastdeeparPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecastdeeparPoint::add(self : TimeseriesforecastdeeparPoint, other : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecastdeeparPoint::sub(self : TimeseriesforecastdeeparPoint, other : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecastdeeparPoint::scale(self : TimeseriesforecastdeeparPoint, s : Double) -> TimeseriesforecastdeeparPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecastdeeparPoint::dot(self : TimeseriesforecastdeeparPoint, other : TimeseriesforecastdeeparPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecastdeeparPoint::cross(self : TimeseriesforecastdeeparPoint, other : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecastdeeparPoint::norm(self : TimeseriesforecastdeeparPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecastdeeparPoint::normalize(self : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastdeeparPoint::negate(self : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecastdeeparPoint::mid(self : TimeseriesforecastdeeparPoint, other : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecastdeeparPoint::lerp(self : TimeseriesforecastdeeparPoint, other : TimeseriesforecastdeeparPoint, t : Double) -> TimeseriesforecastdeeparPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecastdeeparPoint::to_string(self : TimeseriesforecastdeeparPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_deepar_make_series(vals : Array[Double], name : String) -> TimeseriesforecastdeeparSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecastdeeparSeries::len(self : TimeseriesforecastdeeparSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecastdeeparSeries::sum(self : TimeseriesforecastdeeparSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecastdeeparSeries::mean(self : TimeseriesforecastdeeparSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecastdeeparSeries::min(self : TimeseriesforecastdeeparSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecastdeeparSeries::max(self : TimeseriesforecastdeeparSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecastdeeparSeries::range(self : TimeseriesforecastdeeparSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecastdeeparSeries::variance(self : TimeseriesforecastdeeparSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecastdeeparSeries::std(self : TimeseriesforecastdeeparSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecastdeeparSeries::median(self : TimeseriesforecastdeeparSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecastdeeparSeries::scale(self : TimeseriesforecastdeeparSeries, f : Double) -> TimeseriesforecastdeeparSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecastdeeparSeries::add(self : TimeseriesforecastdeeparSeries, other : TimeseriesforecastdeeparSeries) -> TimeseriesforecastdeeparSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastdeeparSeries::sub(self : TimeseriesforecastdeeparSeries, other : TimeseriesforecastdeeparSeries) -> TimeseriesforecastdeeparSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastdeeparSeries::normalize(self : TimeseriesforecastdeeparSeries) -> TimeseriesforecastdeeparSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecastdeeparSeries::cumsum(self : TimeseriesforecastdeeparSeries) -> TimeseriesforecastdeeparSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecastdeeparSeries::to_string(self : TimeseriesforecastdeeparSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastdeeparMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_deepar_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastdeeparMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_deepar_matrix_identity(n : Int) -> TimeseriesforecastdeeparMatrix {
  let m = timeseries_forecast_deepar_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecastdeeparMatrix::get(self : TimeseriesforecastdeeparMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecastdeeparMatrix::transpose(self : TimeseriesforecastdeeparMatrix) -> TimeseriesforecastdeeparMatrix {
  let result = timeseries_forecast_deepar_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecastdeeparMatrix::add(self : TimeseriesforecastdeeparMatrix, other : TimeseriesforecastdeeparMatrix) -> TimeseriesforecastdeeparMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_deepar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecastdeeparMatrix::scale(self : TimeseriesforecastdeeparMatrix, s : Double) -> TimeseriesforecastdeeparMatrix {
  let result = timeseries_forecast_deepar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecastdeeparMatrix::multiply(self : TimeseriesforecastdeeparMatrix, other : TimeseriesforecastdeeparMatrix) -> TimeseriesforecastdeeparMatrix {
  if self.cols != other.rows { return timeseries_forecast_deepar_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_deepar_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesforecastdeeparMatrix::trace(self : TimeseriesforecastdeeparMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecastdeeparMatrix::det(self : TimeseriesforecastdeeparMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecastdeeparMatrix::norm(self : TimeseriesforecastdeeparMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecastdeeparMatrix::to_string(self : TimeseriesforecastdeeparMatrix) -> String {
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

pub(all) struct TimeseriesforecastdeeparVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_deepar_make_vector(comps : Array[Double]) -> TimeseriesforecastdeeparVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_deepar_vector_zero(dim : Int) -> TimeseriesforecastdeeparVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecastdeeparVector::add(self : TimeseriesforecastdeeparVector, other : TimeseriesforecastdeeparVector) -> TimeseriesforecastdeeparVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastdeeparVector::sub(self : TimeseriesforecastdeeparVector, other : TimeseriesforecastdeeparVector) -> TimeseriesforecastdeeparVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastdeeparVector::scale(self : TimeseriesforecastdeeparVector, s : Double) -> TimeseriesforecastdeeparVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecastdeeparVector::dot(self : TimeseriesforecastdeeparVector, other : TimeseriesforecastdeeparVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecastdeeparVector::norm(self : TimeseriesforecastdeeparVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecastdeeparVector::normalize(self : TimeseriesforecastdeeparVector) -> TimeseriesforecastdeeparVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastdeeparVector::dist(self : TimeseriesforecastdeeparVector, other : TimeseriesforecastdeeparVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecastdeeparVector::to_string(self : TimeseriesforecastdeeparVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_deepar_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_deepar_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_deepar_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_deepar_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_deepar_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_deepar_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_deepar_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_deepar_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_deepar_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_deepar_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_deepar_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_deepar_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_deepar_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_deepar_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_deepar_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_deepar_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_deepar_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_deepar_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_deepar_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_deepar_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_deepar_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_deepar_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_deepar_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_deepar_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_deepar_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_deepar_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_deepar_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_deepar_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_deepar_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastdeeparFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_frame_make(size : Int) -> TimeseriesforecastdeeparFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_frame_len(s : TimeseriesforecastdeeparFrame) -> Int { s.size }

pub fn timeseries_forecast_deepar_frame_get(s : TimeseriesforecastdeeparFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_frame_set(s : TimeseriesforecastdeeparFrame, i : Int, v : Double) -> TimeseriesforecastdeeparFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_frame_sum(s : TimeseriesforecastdeeparFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_frame_mean(s : TimeseriesforecastdeeparFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_frame_scale(s : TimeseriesforecastdeeparFrame, f : Double) -> TimeseriesforecastdeeparFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_frame_add(a : TimeseriesforecastdeeparFrame, b : TimeseriesforecastdeeparFrame) -> TimeseriesforecastdeeparFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_frame_copy(s : TimeseriesforecastdeeparFrame) -> TimeseriesforecastdeeparFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_frame_fill(s : TimeseriesforecastdeeparFrame, v : Double) -> TimeseriesforecastdeeparFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_frame_min(s : TimeseriesforecastdeeparFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_frame_max(s : TimeseriesforecastdeeparFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_frame_to_string(s : TimeseriesforecastdeeparFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_table_make(size : Int) -> TimeseriesforecastdeeparTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_table_len(s : TimeseriesforecastdeeparTable) -> Int { s.size }

pub fn timeseries_forecast_deepar_table_get(s : TimeseriesforecastdeeparTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_table_set(s : TimeseriesforecastdeeparTable, i : Int, v : Double) -> TimeseriesforecastdeeparTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_table_sum(s : TimeseriesforecastdeeparTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_table_mean(s : TimeseriesforecastdeeparTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_table_scale(s : TimeseriesforecastdeeparTable, f : Double) -> TimeseriesforecastdeeparTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_table_add(a : TimeseriesforecastdeeparTable, b : TimeseriesforecastdeeparTable) -> TimeseriesforecastdeeparTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_table_copy(s : TimeseriesforecastdeeparTable) -> TimeseriesforecastdeeparTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_table_fill(s : TimeseriesforecastdeeparTable, v : Double) -> TimeseriesforecastdeeparTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_table_min(s : TimeseriesforecastdeeparTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_table_max(s : TimeseriesforecastdeeparTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_table_to_string(s : TimeseriesforecastdeeparTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_graphn_make(size : Int) -> TimeseriesforecastdeeparGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_graphn_len(s : TimeseriesforecastdeeparGraphN) -> Int { s.size }

pub fn timeseries_forecast_deepar_graphn_get(s : TimeseriesforecastdeeparGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_graphn_set(s : TimeseriesforecastdeeparGraphN, i : Int, v : Double) -> TimeseriesforecastdeeparGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_graphn_sum(s : TimeseriesforecastdeeparGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_graphn_mean(s : TimeseriesforecastdeeparGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_graphn_scale(s : TimeseriesforecastdeeparGraphN, f : Double) -> TimeseriesforecastdeeparGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_graphn_add(a : TimeseriesforecastdeeparGraphN, b : TimeseriesforecastdeeparGraphN) -> TimeseriesforecastdeeparGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_graphn_copy(s : TimeseriesforecastdeeparGraphN) -> TimeseriesforecastdeeparGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_graphn_fill(s : TimeseriesforecastdeeparGraphN, v : Double) -> TimeseriesforecastdeeparGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_graphn_min(s : TimeseriesforecastdeeparGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_graphn_max(s : TimeseriesforecastdeeparGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_graphn_to_string(s : TimeseriesforecastdeeparGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_node_make(size : Int) -> TimeseriesforecastdeeparNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_node_len(s : TimeseriesforecastdeeparNode) -> Int { s.size }

pub fn timeseries_forecast_deepar_node_get(s : TimeseriesforecastdeeparNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_node_set(s : TimeseriesforecastdeeparNode, i : Int, v : Double) -> TimeseriesforecastdeeparNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_node_sum(s : TimeseriesforecastdeeparNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_node_mean(s : TimeseriesforecastdeeparNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_node_scale(s : TimeseriesforecastdeeparNode, f : Double) -> TimeseriesforecastdeeparNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_node_add(a : TimeseriesforecastdeeparNode, b : TimeseriesforecastdeeparNode) -> TimeseriesforecastdeeparNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_node_copy(s : TimeseriesforecastdeeparNode) -> TimeseriesforecastdeeparNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_node_fill(s : TimeseriesforecastdeeparNode, v : Double) -> TimeseriesforecastdeeparNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_node_min(s : TimeseriesforecastdeeparNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_node_max(s : TimeseriesforecastdeeparNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_node_to_string(s : TimeseriesforecastdeeparNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_edge_make(size : Int) -> TimeseriesforecastdeeparEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_edge_len(s : TimeseriesforecastdeeparEdge) -> Int { s.size }

pub fn timeseries_forecast_deepar_edge_get(s : TimeseriesforecastdeeparEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_edge_set(s : TimeseriesforecastdeeparEdge, i : Int, v : Double) -> TimeseriesforecastdeeparEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_edge_sum(s : TimeseriesforecastdeeparEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_edge_mean(s : TimeseriesforecastdeeparEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_edge_scale(s : TimeseriesforecastdeeparEdge, f : Double) -> TimeseriesforecastdeeparEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_edge_add(a : TimeseriesforecastdeeparEdge, b : TimeseriesforecastdeeparEdge) -> TimeseriesforecastdeeparEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_edge_copy(s : TimeseriesforecastdeeparEdge) -> TimeseriesforecastdeeparEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_edge_fill(s : TimeseriesforecastdeeparEdge, v : Double) -> TimeseriesforecastdeeparEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_edge_min(s : TimeseriesforecastdeeparEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_edge_max(s : TimeseriesforecastdeeparEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_edge_to_string(s : TimeseriesforecastdeeparEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_path_make(size : Int) -> TimeseriesforecastdeeparPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_path_len(s : TimeseriesforecastdeeparPath) -> Int { s.size }

pub fn timeseries_forecast_deepar_path_get(s : TimeseriesforecastdeeparPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_path_set(s : TimeseriesforecastdeeparPath, i : Int, v : Double) -> TimeseriesforecastdeeparPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_path_sum(s : TimeseriesforecastdeeparPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_path_mean(s : TimeseriesforecastdeeparPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_path_scale(s : TimeseriesforecastdeeparPath, f : Double) -> TimeseriesforecastdeeparPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_path_add(a : TimeseriesforecastdeeparPath, b : TimeseriesforecastdeeparPath) -> TimeseriesforecastdeeparPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_path_copy(s : TimeseriesforecastdeeparPath) -> TimeseriesforecastdeeparPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_path_fill(s : TimeseriesforecastdeeparPath, v : Double) -> TimeseriesforecastdeeparPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_path_min(s : TimeseriesforecastdeeparPath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_path_max(s : TimeseriesforecastdeeparPath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_path_to_string(s : TimeseriesforecastdeeparPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_cluster_make(size : Int) -> TimeseriesforecastdeeparCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_cluster_len(s : TimeseriesforecastdeeparCluster) -> Int { s.size }

pub fn timeseries_forecast_deepar_cluster_get(s : TimeseriesforecastdeeparCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_cluster_set(s : TimeseriesforecastdeeparCluster, i : Int, v : Double) -> TimeseriesforecastdeeparCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_cluster_sum(s : TimeseriesforecastdeeparCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_cluster_mean(s : TimeseriesforecastdeeparCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_cluster_scale(s : TimeseriesforecastdeeparCluster, f : Double) -> TimeseriesforecastdeeparCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_cluster_add(a : TimeseriesforecastdeeparCluster, b : TimeseriesforecastdeeparCluster) -> TimeseriesforecastdeeparCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_cluster_copy(s : TimeseriesforecastdeeparCluster) -> TimeseriesforecastdeeparCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_cluster_fill(s : TimeseriesforecastdeeparCluster, v : Double) -> TimeseriesforecastdeeparCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_cluster_min(s : TimeseriesforecastdeeparCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_cluster_max(s : TimeseriesforecastdeeparCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_cluster_to_string(s : TimeseriesforecastdeeparCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_model_make(size : Int) -> TimeseriesforecastdeeparModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_model_len(s : TimeseriesforecastdeeparModel) -> Int { s.size }

pub fn timeseries_forecast_deepar_model_get(s : TimeseriesforecastdeeparModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_model_set(s : TimeseriesforecastdeeparModel, i : Int, v : Double) -> TimeseriesforecastdeeparModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_model_sum(s : TimeseriesforecastdeeparModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_model_mean(s : TimeseriesforecastdeeparModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_model_scale(s : TimeseriesforecastdeeparModel, f : Double) -> TimeseriesforecastdeeparModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_model_add(a : TimeseriesforecastdeeparModel, b : TimeseriesforecastdeeparModel) -> TimeseriesforecastdeeparModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_model_copy(s : TimeseriesforecastdeeparModel) -> TimeseriesforecastdeeparModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_model_fill(s : TimeseriesforecastdeeparModel, v : Double) -> TimeseriesforecastdeeparModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_model_min(s : TimeseriesforecastdeeparModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_model_max(s : TimeseriesforecastdeeparModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_model_to_string(s : TimeseriesforecastdeeparModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_layer_make(size : Int) -> TimeseriesforecastdeeparLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_layer_len(s : TimeseriesforecastdeeparLayer) -> Int { s.size }

pub fn timeseries_forecast_deepar_layer_get(s : TimeseriesforecastdeeparLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_layer_set(s : TimeseriesforecastdeeparLayer, i : Int, v : Double) -> TimeseriesforecastdeeparLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_layer_sum(s : TimeseriesforecastdeeparLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_layer_mean(s : TimeseriesforecastdeeparLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_layer_scale(s : TimeseriesforecastdeeparLayer, f : Double) -> TimeseriesforecastdeeparLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_layer_add(a : TimeseriesforecastdeeparLayer, b : TimeseriesforecastdeeparLayer) -> TimeseriesforecastdeeparLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_layer_copy(s : TimeseriesforecastdeeparLayer) -> TimeseriesforecastdeeparLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_layer_fill(s : TimeseriesforecastdeeparLayer, v : Double) -> TimeseriesforecastdeeparLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_layer_min(s : TimeseriesforecastdeeparLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_layer_max(s : TimeseriesforecastdeeparLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_layer_to_string(s : TimeseriesforecastdeeparLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_buffer_make(size : Int) -> TimeseriesforecastdeeparBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_buffer_len(s : TimeseriesforecastdeeparBuffer) -> Int { s.size }

pub fn timeseries_forecast_deepar_buffer_get(s : TimeseriesforecastdeeparBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_buffer_set(s : TimeseriesforecastdeeparBuffer, i : Int, v : Double) -> TimeseriesforecastdeeparBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_buffer_sum(s : TimeseriesforecastdeeparBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_buffer_mean(s : TimeseriesforecastdeeparBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_buffer_scale(s : TimeseriesforecastdeeparBuffer, f : Double) -> TimeseriesforecastdeeparBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_buffer_add(a : TimeseriesforecastdeeparBuffer, b : TimeseriesforecastdeeparBuffer) -> TimeseriesforecastdeeparBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_buffer_copy(s : TimeseriesforecastdeeparBuffer) -> TimeseriesforecastdeeparBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_buffer_fill(s : TimeseriesforecastdeeparBuffer, v : Double) -> TimeseriesforecastdeeparBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_buffer_min(s : TimeseriesforecastdeeparBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_buffer_max(s : TimeseriesforecastdeeparBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_buffer_to_string(s : TimeseriesforecastdeeparBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_cursor_make(size : Int) -> TimeseriesforecastdeeparCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_cursor_len(s : TimeseriesforecastdeeparCursor) -> Int { s.size }

pub fn timeseries_forecast_deepar_cursor_get(s : TimeseriesforecastdeeparCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_cursor_set(s : TimeseriesforecastdeeparCursor, i : Int, v : Double) -> TimeseriesforecastdeeparCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_cursor_sum(s : TimeseriesforecastdeeparCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_cursor_mean(s : TimeseriesforecastdeeparCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_cursor_scale(s : TimeseriesforecastdeeparCursor, f : Double) -> TimeseriesforecastdeeparCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_cursor_add(a : TimeseriesforecastdeeparCursor, b : TimeseriesforecastdeeparCursor) -> TimeseriesforecastdeeparCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_cursor_copy(s : TimeseriesforecastdeeparCursor) -> TimeseriesforecastdeeparCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_cursor_fill(s : TimeseriesforecastdeeparCursor, v : Double) -> TimeseriesforecastdeeparCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_cursor_min(s : TimeseriesforecastdeeparCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_cursor_max(s : TimeseriesforecastdeeparCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_cursor_to_string(s : TimeseriesforecastdeeparCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_view_make(size : Int) -> TimeseriesforecastdeeparView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_view_len(s : TimeseriesforecastdeeparView) -> Int { s.size }

pub fn timeseries_forecast_deepar_view_get(s : TimeseriesforecastdeeparView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_view_set(s : TimeseriesforecastdeeparView, i : Int, v : Double) -> TimeseriesforecastdeeparView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_view_sum(s : TimeseriesforecastdeeparView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_view_mean(s : TimeseriesforecastdeeparView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_view_scale(s : TimeseriesforecastdeeparView, f : Double) -> TimeseriesforecastdeeparView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_view_add(a : TimeseriesforecastdeeparView, b : TimeseriesforecastdeeparView) -> TimeseriesforecastdeeparView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_view_copy(s : TimeseriesforecastdeeparView) -> TimeseriesforecastdeeparView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_view_fill(s : TimeseriesforecastdeeparView, v : Double) -> TimeseriesforecastdeeparView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_view_min(s : TimeseriesforecastdeeparView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_view_max(s : TimeseriesforecastdeeparView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_view_to_string(s : TimeseriesforecastdeeparView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_range_make(size : Int) -> TimeseriesforecastdeeparRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_range_len(s : TimeseriesforecastdeeparRange) -> Int { s.size }

pub fn timeseries_forecast_deepar_range_get(s : TimeseriesforecastdeeparRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_range_set(s : TimeseriesforecastdeeparRange, i : Int, v : Double) -> TimeseriesforecastdeeparRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_range_sum(s : TimeseriesforecastdeeparRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_range_mean(s : TimeseriesforecastdeeparRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_range_scale(s : TimeseriesforecastdeeparRange, f : Double) -> TimeseriesforecastdeeparRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_range_add(a : TimeseriesforecastdeeparRange, b : TimeseriesforecastdeeparRange) -> TimeseriesforecastdeeparRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_range_copy(s : TimeseriesforecastdeeparRange) -> TimeseriesforecastdeeparRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_range_fill(s : TimeseriesforecastdeeparRange, v : Double) -> TimeseriesforecastdeeparRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_range_min(s : TimeseriesforecastdeeparRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_range_max(s : TimeseriesforecastdeeparRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_range_to_string(s : TimeseriesforecastdeeparRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_slice_make(size : Int) -> TimeseriesforecastdeeparSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_deepar_slice_len(s : TimeseriesforecastdeeparSlice) -> Int { s.size }

pub fn timeseries_forecast_deepar_slice_get(s : TimeseriesforecastdeeparSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_deepar_slice_set(s : TimeseriesforecastdeeparSlice, i : Int, v : Double) -> TimeseriesforecastdeeparSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_slice_sum(s : TimeseriesforecastdeeparSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_deepar_slice_mean(s : TimeseriesforecastdeeparSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_deepar_slice_scale(s : TimeseriesforecastdeeparSlice, f : Double) -> TimeseriesforecastdeeparSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_slice_add(a : TimeseriesforecastdeeparSlice, b : TimeseriesforecastdeeparSlice) -> TimeseriesforecastdeeparSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_deepar_slice_copy(s : TimeseriesforecastdeeparSlice) -> TimeseriesforecastdeeparSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_slice_fill(s : TimeseriesforecastdeeparSlice, v : Double) -> TimeseriesforecastdeeparSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_deepar_slice_min(s : TimeseriesforecastdeeparSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_deepar_slice_max(s : TimeseriesforecastdeeparSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_deepar_slice_to_string(s : TimeseriesforecastdeeparSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

