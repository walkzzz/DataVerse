///===
/// extcore/ml_metric_interpret

pub(all) struct MlmetricinterpretPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_interpret_make_point(x : Double, y : Double) -> MlmetricinterpretPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_interpret_make_point3(x : Double, y : Double, z : Double) -> MlmetricinterpretPoint {
  { x, y, z, label: 0 }
}

pub fn MlmetricinterpretPoint::x(self : MlmetricinterpretPoint) -> Double { self.x }

pub fn MlmetricinterpretPoint::y(self : MlmetricinterpretPoint) -> Double { self.y }

pub fn MlmetricinterpretPoint::z(self : MlmetricinterpretPoint) -> Double { self.z }

pub fn MlmetricinterpretPoint::label(self : MlmetricinterpretPoint) -> Int { self.label }

pub fn MlmetricinterpretPoint::dist(self : MlmetricinterpretPoint, other : MlmetricinterpretPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlmetricinterpretPoint::add(self : MlmetricinterpretPoint, other : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlmetricinterpretPoint::sub(self : MlmetricinterpretPoint, other : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlmetricinterpretPoint::scale(self : MlmetricinterpretPoint, s : Double) -> MlmetricinterpretPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlmetricinterpretPoint::dot(self : MlmetricinterpretPoint, other : MlmetricinterpretPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlmetricinterpretPoint::cross(self : MlmetricinterpretPoint, other : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlmetricinterpretPoint::norm(self : MlmetricinterpretPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlmetricinterpretPoint::normalize(self : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricinterpretPoint::negate(self : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlmetricinterpretPoint::mid(self : MlmetricinterpretPoint, other : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlmetricinterpretPoint::lerp(self : MlmetricinterpretPoint, other : MlmetricinterpretPoint, t : Double) -> MlmetricinterpretPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlmetricinterpretPoint::to_string(self : MlmetricinterpretPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlmetricinterpretSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_interpret_make_series(vals : Array[Double], name : String) -> MlmetricinterpretSeries {
  { vals, name, meta: 0 }
}

pub fn MlmetricinterpretSeries::len(self : MlmetricinterpretSeries) -> Int { self.vals.length() }

pub fn MlmetricinterpretSeries::sum(self : MlmetricinterpretSeries) -> Double { @_common.sum(self.vals) }

pub fn MlmetricinterpretSeries::mean(self : MlmetricinterpretSeries) -> Double { @_common.mean(self.vals) }

pub fn MlmetricinterpretSeries::min(self : MlmetricinterpretSeries) -> Double { @_common.min(self.vals) }

pub fn MlmetricinterpretSeries::max(self : MlmetricinterpretSeries) -> Double { @_common.max(self.vals) }

pub fn MlmetricinterpretSeries::range(self : MlmetricinterpretSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlmetricinterpretSeries::variance(self : MlmetricinterpretSeries) -> Double { @_common.variance(self.vals) }

pub fn MlmetricinterpretSeries::std(self : MlmetricinterpretSeries) -> Double { @_common.std(self.vals) }

pub fn MlmetricinterpretSeries::median(self : MlmetricinterpretSeries) -> Double { @_common.median(self.vals) }

pub fn MlmetricinterpretSeries::scale(self : MlmetricinterpretSeries, f : Double) -> MlmetricinterpretSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlmetricinterpretSeries::add(self : MlmetricinterpretSeries, other : MlmetricinterpretSeries) -> MlmetricinterpretSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlmetricinterpretSeries::sub(self : MlmetricinterpretSeries, other : MlmetricinterpretSeries) -> MlmetricinterpretSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlmetricinterpretSeries::normalize(self : MlmetricinterpretSeries) -> MlmetricinterpretSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlmetricinterpretSeries::cumsum(self : MlmetricinterpretSeries) -> MlmetricinterpretSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlmetricinterpretSeries::to_string(self : MlmetricinterpretSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricinterpretMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_interpret_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricinterpretMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_interpret_matrix_identity(n : Int) -> MlmetricinterpretMatrix {
  let m = ml_metric_interpret_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlmetricinterpretMatrix::get(self : MlmetricinterpretMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlmetricinterpretMatrix::transpose(self : MlmetricinterpretMatrix) -> MlmetricinterpretMatrix {
  let result = ml_metric_interpret_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlmetricinterpretMatrix::add(self : MlmetricinterpretMatrix, other : MlmetricinterpretMatrix) -> MlmetricinterpretMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_metric_interpret_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlmetricinterpretMatrix::scale(self : MlmetricinterpretMatrix, s : Double) -> MlmetricinterpretMatrix {
  let result = ml_metric_interpret_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlmetricinterpretMatrix::multiply(self : MlmetricinterpretMatrix, other : MlmetricinterpretMatrix) -> MlmetricinterpretMatrix {
  if self.cols != other.rows { return ml_metric_interpret_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_metric_interpret_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlmetricinterpretMatrix::trace(self : MlmetricinterpretMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlmetricinterpretMatrix::det(self : MlmetricinterpretMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlmetricinterpretMatrix::norm(self : MlmetricinterpretMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlmetricinterpretMatrix::to_string(self : MlmetricinterpretMatrix) -> String {
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

pub(all) struct MlmetricinterpretVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_interpret_make_vector(comps : Array[Double]) -> MlmetricinterpretVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_interpret_vector_zero(dim : Int) -> MlmetricinterpretVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlmetricinterpretVector::add(self : MlmetricinterpretVector, other : MlmetricinterpretVector) -> MlmetricinterpretVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricinterpretVector::sub(self : MlmetricinterpretVector, other : MlmetricinterpretVector) -> MlmetricinterpretVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricinterpretVector::scale(self : MlmetricinterpretVector, s : Double) -> MlmetricinterpretVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlmetricinterpretVector::dot(self : MlmetricinterpretVector, other : MlmetricinterpretVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlmetricinterpretVector::norm(self : MlmetricinterpretVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlmetricinterpretVector::normalize(self : MlmetricinterpretVector) -> MlmetricinterpretVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricinterpretVector::dist(self : MlmetricinterpretVector, other : MlmetricinterpretVector) -> Double {
  self.sub(other).norm()
}

pub fn MlmetricinterpretVector::to_string(self : MlmetricinterpretVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_interpret_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_interpret_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_interpret_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_interpret_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_interpret_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_interpret_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_interpret_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_interpret_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_interpret_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_interpret_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_interpret_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_interpret_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_interpret_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_interpret_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_interpret_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_interpret_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_interpret_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_interpret_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_interpret_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_interpret_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_interpret_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_interpret_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_interpret_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_interpret_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_interpret_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_interpret_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_interpret_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_interpret_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_interpret_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetricinterpretFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_frame_make(size : Int) -> MlmetricinterpretFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricinterpretFrame::len(self : MlmetricinterpretFrame) -> Int { self.size }

pub fn MlmetricinterpretFrame::get(self : MlmetricinterpretFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricinterpretFrame::set(self : MlmetricinterpretFrame, i : Int, v : Double) -> MlmetricinterpretFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretFrame::sum(self : MlmetricinterpretFrame) -> Double { @_common.sum(self.data) }

pub fn MlmetricinterpretFrame::mean(self : MlmetricinterpretFrame) -> Double { @_common.mean(self.data) }

pub fn MlmetricinterpretFrame::scale(self : MlmetricinterpretFrame, f : Double) -> MlmetricinterpretFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretFrame::add(self : MlmetricinterpretFrame, other : MlmetricinterpretFrame) -> MlmetricinterpretFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricinterpretFrame::copy(self : MlmetricinterpretFrame) -> MlmetricinterpretFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretFrame::fill(self : MlmetricinterpretFrame, v : Double) -> MlmetricinterpretFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretFrame::min(self : MlmetricinterpretFrame) -> Double { @_common.min(self.data) }

pub fn MlmetricinterpretFrame::max(self : MlmetricinterpretFrame) -> Double { @_common.max(self.data) }

pub fn MlmetricinterpretFrame::to_string(self : MlmetricinterpretFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_table_make(size : Int) -> MlmetricinterpretTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricinterpretTable::len(self : MlmetricinterpretTable) -> Int { self.size }

pub fn MlmetricinterpretTable::get(self : MlmetricinterpretTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricinterpretTable::set(self : MlmetricinterpretTable, i : Int, v : Double) -> MlmetricinterpretTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretTable::sum(self : MlmetricinterpretTable) -> Double { @_common.sum(self.data) }

pub fn MlmetricinterpretTable::mean(self : MlmetricinterpretTable) -> Double { @_common.mean(self.data) }

pub fn MlmetricinterpretTable::scale(self : MlmetricinterpretTable, f : Double) -> MlmetricinterpretTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretTable::add(self : MlmetricinterpretTable, other : MlmetricinterpretTable) -> MlmetricinterpretTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricinterpretTable::copy(self : MlmetricinterpretTable) -> MlmetricinterpretTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretTable::fill(self : MlmetricinterpretTable, v : Double) -> MlmetricinterpretTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretTable::min(self : MlmetricinterpretTable) -> Double { @_common.min(self.data) }

pub fn MlmetricinterpretTable::max(self : MlmetricinterpretTable) -> Double { @_common.max(self.data) }

pub fn MlmetricinterpretTable::to_string(self : MlmetricinterpretTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_graphn_make(size : Int) -> MlmetricinterpretGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricinterpretGraphN::len(self : MlmetricinterpretGraphN) -> Int { self.size }

pub fn MlmetricinterpretGraphN::get(self : MlmetricinterpretGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricinterpretGraphN::set(self : MlmetricinterpretGraphN, i : Int, v : Double) -> MlmetricinterpretGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretGraphN::sum(self : MlmetricinterpretGraphN) -> Double { @_common.sum(self.data) }

pub fn MlmetricinterpretGraphN::mean(self : MlmetricinterpretGraphN) -> Double { @_common.mean(self.data) }

pub fn MlmetricinterpretGraphN::scale(self : MlmetricinterpretGraphN, f : Double) -> MlmetricinterpretGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretGraphN::add(self : MlmetricinterpretGraphN, other : MlmetricinterpretGraphN) -> MlmetricinterpretGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricinterpretGraphN::copy(self : MlmetricinterpretGraphN) -> MlmetricinterpretGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretGraphN::fill(self : MlmetricinterpretGraphN, v : Double) -> MlmetricinterpretGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretGraphN::min(self : MlmetricinterpretGraphN) -> Double { @_common.min(self.data) }

pub fn MlmetricinterpretGraphN::max(self : MlmetricinterpretGraphN) -> Double { @_common.max(self.data) }

pub fn MlmetricinterpretGraphN::to_string(self : MlmetricinterpretGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_node_make(size : Int) -> MlmetricinterpretNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricinterpretNode::len(self : MlmetricinterpretNode) -> Int { self.size }

pub fn MlmetricinterpretNode::get(self : MlmetricinterpretNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricinterpretNode::set(self : MlmetricinterpretNode, i : Int, v : Double) -> MlmetricinterpretNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretNode::sum(self : MlmetricinterpretNode) -> Double { @_common.sum(self.data) }

pub fn MlmetricinterpretNode::mean(self : MlmetricinterpretNode) -> Double { @_common.mean(self.data) }

pub fn MlmetricinterpretNode::scale(self : MlmetricinterpretNode, f : Double) -> MlmetricinterpretNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretNode::add(self : MlmetricinterpretNode, other : MlmetricinterpretNode) -> MlmetricinterpretNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricinterpretNode::copy(self : MlmetricinterpretNode) -> MlmetricinterpretNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretNode::fill(self : MlmetricinterpretNode, v : Double) -> MlmetricinterpretNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretNode::min(self : MlmetricinterpretNode) -> Double { @_common.min(self.data) }

pub fn MlmetricinterpretNode::max(self : MlmetricinterpretNode) -> Double { @_common.max(self.data) }

pub fn MlmetricinterpretNode::to_string(self : MlmetricinterpretNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_edge_make(size : Int) -> MlmetricinterpretEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricinterpretEdge::len(self : MlmetricinterpretEdge) -> Int { self.size }

pub fn MlmetricinterpretEdge::get(self : MlmetricinterpretEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricinterpretEdge::set(self : MlmetricinterpretEdge, i : Int, v : Double) -> MlmetricinterpretEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretEdge::sum(self : MlmetricinterpretEdge) -> Double { @_common.sum(self.data) }

pub fn MlmetricinterpretEdge::mean(self : MlmetricinterpretEdge) -> Double { @_common.mean(self.data) }

pub fn MlmetricinterpretEdge::scale(self : MlmetricinterpretEdge, f : Double) -> MlmetricinterpretEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretEdge::add(self : MlmetricinterpretEdge, other : MlmetricinterpretEdge) -> MlmetricinterpretEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricinterpretEdge::copy(self : MlmetricinterpretEdge) -> MlmetricinterpretEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretEdge::fill(self : MlmetricinterpretEdge, v : Double) -> MlmetricinterpretEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretEdge::min(self : MlmetricinterpretEdge) -> Double { @_common.min(self.data) }

pub fn MlmetricinterpretEdge::max(self : MlmetricinterpretEdge) -> Double { @_common.max(self.data) }

pub fn MlmetricinterpretEdge::to_string(self : MlmetricinterpretEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_path_make(size : Int) -> MlmetricinterpretPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricinterpretPath::len(self : MlmetricinterpretPath) -> Int { self.size }

pub fn MlmetricinterpretPath::get(self : MlmetricinterpretPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricinterpretPath::set(self : MlmetricinterpretPath, i : Int, v : Double) -> MlmetricinterpretPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretPath::sum(self : MlmetricinterpretPath) -> Double { @_common.sum(self.data) }

pub fn MlmetricinterpretPath::mean(self : MlmetricinterpretPath) -> Double { @_common.mean(self.data) }

pub fn MlmetricinterpretPath::scale(self : MlmetricinterpretPath, f : Double) -> MlmetricinterpretPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretPath::add(self : MlmetricinterpretPath, other : MlmetricinterpretPath) -> MlmetricinterpretPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricinterpretPath::copy(self : MlmetricinterpretPath) -> MlmetricinterpretPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretPath::fill(self : MlmetricinterpretPath, v : Double) -> MlmetricinterpretPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretPath::min(self : MlmetricinterpretPath) -> Double { @_common.min(self.data) }

pub fn MlmetricinterpretPath::max(self : MlmetricinterpretPath) -> Double { @_common.max(self.data) }

pub fn MlmetricinterpretPath::to_string(self : MlmetricinterpretPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_cluster_make(size : Int) -> MlmetricinterpretCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricinterpretCluster::len(self : MlmetricinterpretCluster) -> Int { self.size }

pub fn MlmetricinterpretCluster::get(self : MlmetricinterpretCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricinterpretCluster::set(self : MlmetricinterpretCluster, i : Int, v : Double) -> MlmetricinterpretCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretCluster::sum(self : MlmetricinterpretCluster) -> Double { @_common.sum(self.data) }

pub fn MlmetricinterpretCluster::mean(self : MlmetricinterpretCluster) -> Double { @_common.mean(self.data) }

pub fn MlmetricinterpretCluster::scale(self : MlmetricinterpretCluster, f : Double) -> MlmetricinterpretCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretCluster::add(self : MlmetricinterpretCluster, other : MlmetricinterpretCluster) -> MlmetricinterpretCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricinterpretCluster::copy(self : MlmetricinterpretCluster) -> MlmetricinterpretCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretCluster::fill(self : MlmetricinterpretCluster, v : Double) -> MlmetricinterpretCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretCluster::min(self : MlmetricinterpretCluster) -> Double { @_common.min(self.data) }

pub fn MlmetricinterpretCluster::max(self : MlmetricinterpretCluster) -> Double { @_common.max(self.data) }

pub fn MlmetricinterpretCluster::to_string(self : MlmetricinterpretCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_model_make(size : Int) -> MlmetricinterpretModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricinterpretModel::len(self : MlmetricinterpretModel) -> Int { self.size }

pub fn MlmetricinterpretModel::get(self : MlmetricinterpretModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricinterpretModel::set(self : MlmetricinterpretModel, i : Int, v : Double) -> MlmetricinterpretModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretModel::sum(self : MlmetricinterpretModel) -> Double { @_common.sum(self.data) }

pub fn MlmetricinterpretModel::mean(self : MlmetricinterpretModel) -> Double { @_common.mean(self.data) }

pub fn MlmetricinterpretModel::scale(self : MlmetricinterpretModel, f : Double) -> MlmetricinterpretModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretModel::add(self : MlmetricinterpretModel, other : MlmetricinterpretModel) -> MlmetricinterpretModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricinterpretModel::copy(self : MlmetricinterpretModel) -> MlmetricinterpretModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretModel::fill(self : MlmetricinterpretModel, v : Double) -> MlmetricinterpretModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretModel::min(self : MlmetricinterpretModel) -> Double { @_common.min(self.data) }

pub fn MlmetricinterpretModel::max(self : MlmetricinterpretModel) -> Double { @_common.max(self.data) }

pub fn MlmetricinterpretModel::to_string(self : MlmetricinterpretModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_layer_make(size : Int) -> MlmetricinterpretLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricinterpretLayer::len(self : MlmetricinterpretLayer) -> Int { self.size }

pub fn MlmetricinterpretLayer::get(self : MlmetricinterpretLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricinterpretLayer::set(self : MlmetricinterpretLayer, i : Int, v : Double) -> MlmetricinterpretLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretLayer::sum(self : MlmetricinterpretLayer) -> Double { @_common.sum(self.data) }

pub fn MlmetricinterpretLayer::mean(self : MlmetricinterpretLayer) -> Double { @_common.mean(self.data) }

pub fn MlmetricinterpretLayer::scale(self : MlmetricinterpretLayer, f : Double) -> MlmetricinterpretLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretLayer::add(self : MlmetricinterpretLayer, other : MlmetricinterpretLayer) -> MlmetricinterpretLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricinterpretLayer::copy(self : MlmetricinterpretLayer) -> MlmetricinterpretLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretLayer::fill(self : MlmetricinterpretLayer, v : Double) -> MlmetricinterpretLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretLayer::min(self : MlmetricinterpretLayer) -> Double { @_common.min(self.data) }

pub fn MlmetricinterpretLayer::max(self : MlmetricinterpretLayer) -> Double { @_common.max(self.data) }

pub fn MlmetricinterpretLayer::to_string(self : MlmetricinterpretLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_buffer_make(size : Int) -> MlmetricinterpretBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricinterpretBuffer::len(self : MlmetricinterpretBuffer) -> Int { self.size }

pub fn MlmetricinterpretBuffer::get(self : MlmetricinterpretBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricinterpretBuffer::set(self : MlmetricinterpretBuffer, i : Int, v : Double) -> MlmetricinterpretBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretBuffer::sum(self : MlmetricinterpretBuffer) -> Double { @_common.sum(self.data) }

pub fn MlmetricinterpretBuffer::mean(self : MlmetricinterpretBuffer) -> Double { @_common.mean(self.data) }

pub fn MlmetricinterpretBuffer::scale(self : MlmetricinterpretBuffer, f : Double) -> MlmetricinterpretBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretBuffer::add(self : MlmetricinterpretBuffer, other : MlmetricinterpretBuffer) -> MlmetricinterpretBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricinterpretBuffer::copy(self : MlmetricinterpretBuffer) -> MlmetricinterpretBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretBuffer::fill(self : MlmetricinterpretBuffer, v : Double) -> MlmetricinterpretBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretBuffer::min(self : MlmetricinterpretBuffer) -> Double { @_common.min(self.data) }

pub fn MlmetricinterpretBuffer::max(self : MlmetricinterpretBuffer) -> Double { @_common.max(self.data) }

pub fn MlmetricinterpretBuffer::to_string(self : MlmetricinterpretBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_cursor_make(size : Int) -> MlmetricinterpretCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricinterpretCursor::len(self : MlmetricinterpretCursor) -> Int { self.size }

pub fn MlmetricinterpretCursor::get(self : MlmetricinterpretCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricinterpretCursor::set(self : MlmetricinterpretCursor, i : Int, v : Double) -> MlmetricinterpretCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretCursor::sum(self : MlmetricinterpretCursor) -> Double { @_common.sum(self.data) }

pub fn MlmetricinterpretCursor::mean(self : MlmetricinterpretCursor) -> Double { @_common.mean(self.data) }

pub fn MlmetricinterpretCursor::scale(self : MlmetricinterpretCursor, f : Double) -> MlmetricinterpretCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretCursor::add(self : MlmetricinterpretCursor, other : MlmetricinterpretCursor) -> MlmetricinterpretCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricinterpretCursor::copy(self : MlmetricinterpretCursor) -> MlmetricinterpretCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretCursor::fill(self : MlmetricinterpretCursor, v : Double) -> MlmetricinterpretCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretCursor::min(self : MlmetricinterpretCursor) -> Double { @_common.min(self.data) }

pub fn MlmetricinterpretCursor::max(self : MlmetricinterpretCursor) -> Double { @_common.max(self.data) }

pub fn MlmetricinterpretCursor::to_string(self : MlmetricinterpretCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_view_make(size : Int) -> MlmetricinterpretView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricinterpretView::len(self : MlmetricinterpretView) -> Int { self.size }

pub fn MlmetricinterpretView::get(self : MlmetricinterpretView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricinterpretView::set(self : MlmetricinterpretView, i : Int, v : Double) -> MlmetricinterpretView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretView::sum(self : MlmetricinterpretView) -> Double { @_common.sum(self.data) }

pub fn MlmetricinterpretView::mean(self : MlmetricinterpretView) -> Double { @_common.mean(self.data) }

pub fn MlmetricinterpretView::scale(self : MlmetricinterpretView, f : Double) -> MlmetricinterpretView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretView::add(self : MlmetricinterpretView, other : MlmetricinterpretView) -> MlmetricinterpretView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricinterpretView::copy(self : MlmetricinterpretView) -> MlmetricinterpretView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretView::fill(self : MlmetricinterpretView, v : Double) -> MlmetricinterpretView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretView::min(self : MlmetricinterpretView) -> Double { @_common.min(self.data) }

pub fn MlmetricinterpretView::max(self : MlmetricinterpretView) -> Double { @_common.max(self.data) }

pub fn MlmetricinterpretView::to_string(self : MlmetricinterpretView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_range_make(size : Int) -> MlmetricinterpretRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricinterpretRange::len(self : MlmetricinterpretRange) -> Int { self.size }

pub fn MlmetricinterpretRange::get(self : MlmetricinterpretRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricinterpretRange::set(self : MlmetricinterpretRange, i : Int, v : Double) -> MlmetricinterpretRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretRange::sum(self : MlmetricinterpretRange) -> Double { @_common.sum(self.data) }

pub fn MlmetricinterpretRange::mean(self : MlmetricinterpretRange) -> Double { @_common.mean(self.data) }

pub fn MlmetricinterpretRange::scale(self : MlmetricinterpretRange, f : Double) -> MlmetricinterpretRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretRange::add(self : MlmetricinterpretRange, other : MlmetricinterpretRange) -> MlmetricinterpretRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricinterpretRange::copy(self : MlmetricinterpretRange) -> MlmetricinterpretRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretRange::fill(self : MlmetricinterpretRange, v : Double) -> MlmetricinterpretRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretRange::min(self : MlmetricinterpretRange) -> Double { @_common.min(self.data) }

pub fn MlmetricinterpretRange::max(self : MlmetricinterpretRange) -> Double { @_common.max(self.data) }

pub fn MlmetricinterpretRange::to_string(self : MlmetricinterpretRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_slice_make(size : Int) -> MlmetricinterpretSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricinterpretSlice::len(self : MlmetricinterpretSlice) -> Int { self.size }

pub fn MlmetricinterpretSlice::get(self : MlmetricinterpretSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricinterpretSlice::set(self : MlmetricinterpretSlice, i : Int, v : Double) -> MlmetricinterpretSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretSlice::sum(self : MlmetricinterpretSlice) -> Double { @_common.sum(self.data) }

pub fn MlmetricinterpretSlice::mean(self : MlmetricinterpretSlice) -> Double { @_common.mean(self.data) }

pub fn MlmetricinterpretSlice::scale(self : MlmetricinterpretSlice, f : Double) -> MlmetricinterpretSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretSlice::add(self : MlmetricinterpretSlice, other : MlmetricinterpretSlice) -> MlmetricinterpretSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricinterpretSlice::copy(self : MlmetricinterpretSlice) -> MlmetricinterpretSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretSlice::fill(self : MlmetricinterpretSlice, v : Double) -> MlmetricinterpretSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricinterpretSlice::min(self : MlmetricinterpretSlice) -> Double { @_common.min(self.data) }

pub fn MlmetricinterpretSlice::max(self : MlmetricinterpretSlice) -> Double { @_common.max(self.data) }

pub fn MlmetricinterpretSlice::to_string(self : MlmetricinterpretSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

