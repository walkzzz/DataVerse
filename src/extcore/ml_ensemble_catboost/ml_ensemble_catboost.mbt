///===
/// extcore/ml_ensemble_catboost

pub(all) struct MlensemblecatboostPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_catboost_make_point(x : Double, y : Double) -> MlensemblecatboostPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_catboost_make_point3(x : Double, y : Double, z : Double) -> MlensemblecatboostPoint {
  { x, y, z, label: 0 }
}

pub fn MlensemblecatboostPoint::x(self : MlensemblecatboostPoint) -> Double { self.x }

pub fn MlensemblecatboostPoint::y(self : MlensemblecatboostPoint) -> Double { self.y }

pub fn MlensemblecatboostPoint::z(self : MlensemblecatboostPoint) -> Double { self.z }

pub fn MlensemblecatboostPoint::label(self : MlensemblecatboostPoint) -> Int { self.label }

pub fn MlensemblecatboostPoint::dist(self : MlensemblecatboostPoint, other : MlensemblecatboostPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensemblecatboostPoint::add(self : MlensemblecatboostPoint, other : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensemblecatboostPoint::sub(self : MlensemblecatboostPoint, other : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensemblecatboostPoint::scale(self : MlensemblecatboostPoint, s : Double) -> MlensemblecatboostPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensemblecatboostPoint::dot(self : MlensemblecatboostPoint, other : MlensemblecatboostPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensemblecatboostPoint::cross(self : MlensemblecatboostPoint, other : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensemblecatboostPoint::norm(self : MlensemblecatboostPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensemblecatboostPoint::normalize(self : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblecatboostPoint::negate(self : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensemblecatboostPoint::mid(self : MlensemblecatboostPoint, other : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensemblecatboostPoint::lerp(self : MlensemblecatboostPoint, other : MlensemblecatboostPoint, t : Double) -> MlensemblecatboostPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensemblecatboostPoint::to_string(self : MlensemblecatboostPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensemblecatboostSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_catboost_make_series(vals : Array[Double], name : String) -> MlensemblecatboostSeries {
  { vals, name, meta: 0 }
}

pub fn MlensemblecatboostSeries::len(self : MlensemblecatboostSeries) -> Int { self.vals.length() }

pub fn MlensemblecatboostSeries::sum(self : MlensemblecatboostSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensemblecatboostSeries::mean(self : MlensemblecatboostSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensemblecatboostSeries::min(self : MlensemblecatboostSeries) -> Double { @_common.min(self.vals) }

pub fn MlensemblecatboostSeries::max(self : MlensemblecatboostSeries) -> Double { @_common.max(self.vals) }

pub fn MlensemblecatboostSeries::range(self : MlensemblecatboostSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensemblecatboostSeries::variance(self : MlensemblecatboostSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensemblecatboostSeries::std(self : MlensemblecatboostSeries) -> Double { @_common.std(self.vals) }

pub fn MlensemblecatboostSeries::median(self : MlensemblecatboostSeries) -> Double { @_common.median(self.vals) }

pub fn MlensemblecatboostSeries::scale(self : MlensemblecatboostSeries, f : Double) -> MlensemblecatboostSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensemblecatboostSeries::add(self : MlensemblecatboostSeries, other : MlensemblecatboostSeries) -> MlensemblecatboostSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensemblecatboostSeries::sub(self : MlensemblecatboostSeries, other : MlensemblecatboostSeries) -> MlensemblecatboostSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensemblecatboostSeries::normalize(self : MlensemblecatboostSeries) -> MlensemblecatboostSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensemblecatboostSeries::cumsum(self : MlensemblecatboostSeries) -> MlensemblecatboostSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensemblecatboostSeries::to_string(self : MlensemblecatboostSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblecatboostMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_catboost_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblecatboostMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_catboost_matrix_identity(n : Int) -> MlensemblecatboostMatrix {
  let m = ml_ensemble_catboost_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensemblecatboostMatrix::get(self : MlensemblecatboostMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensemblecatboostMatrix::transpose(self : MlensemblecatboostMatrix) -> MlensemblecatboostMatrix {
  let result = ml_ensemble_catboost_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensemblecatboostMatrix::add(self : MlensemblecatboostMatrix, other : MlensemblecatboostMatrix) -> MlensemblecatboostMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_catboost_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensemblecatboostMatrix::scale(self : MlensemblecatboostMatrix, s : Double) -> MlensemblecatboostMatrix {
  let result = ml_ensemble_catboost_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensemblecatboostMatrix::multiply(self : MlensemblecatboostMatrix, other : MlensemblecatboostMatrix) -> MlensemblecatboostMatrix {
  if self.cols != other.rows { return ml_ensemble_catboost_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_catboost_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlensemblecatboostMatrix::trace(self : MlensemblecatboostMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensemblecatboostMatrix::det(self : MlensemblecatboostMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensemblecatboostMatrix::norm(self : MlensemblecatboostMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensemblecatboostMatrix::to_string(self : MlensemblecatboostMatrix) -> String {
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

pub(all) struct MlensemblecatboostVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_catboost_make_vector(comps : Array[Double]) -> MlensemblecatboostVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_catboost_vector_zero(dim : Int) -> MlensemblecatboostVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensemblecatboostVector::add(self : MlensemblecatboostVector, other : MlensemblecatboostVector) -> MlensemblecatboostVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblecatboostVector::sub(self : MlensemblecatboostVector, other : MlensemblecatboostVector) -> MlensemblecatboostVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblecatboostVector::scale(self : MlensemblecatboostVector, s : Double) -> MlensemblecatboostVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensemblecatboostVector::dot(self : MlensemblecatboostVector, other : MlensemblecatboostVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensemblecatboostVector::norm(self : MlensemblecatboostVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensemblecatboostVector::normalize(self : MlensemblecatboostVector) -> MlensemblecatboostVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblecatboostVector::dist(self : MlensemblecatboostVector, other : MlensemblecatboostVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensemblecatboostVector::to_string(self : MlensemblecatboostVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_catboost_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_ensemble_catboost_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_ensemble_catboost_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_ensemble_catboost_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_ensemble_catboost_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_ensemble_catboost_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_ensemble_catboost_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_ensemble_catboost_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_ensemble_catboost_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_ensemble_catboost_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_ensemble_catboost_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_ensemble_catboost_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_ensemble_catboost_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_ensemble_catboost_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_ensemble_catboost_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_ensemble_catboost_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_ensemble_catboost_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_ensemble_catboost_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_ensemble_catboost_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_ensemble_catboost_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_ensemble_catboost_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_ensemble_catboost_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_ensemble_catboost_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_ensemble_catboost_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_ensemble_catboost_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_ensemble_catboost_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_ensemble_catboost_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_ensemble_catboost_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_ensemble_catboost_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlensemblecatboostFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_frame_make(size : Int) -> MlensemblecatboostFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblecatboostFrame::len(self : MlensemblecatboostFrame) -> Int { self.size }

pub fn MlensemblecatboostFrame::get(self : MlensemblecatboostFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblecatboostFrame::set(self : MlensemblecatboostFrame, i : Int, v : Double) -> MlensemblecatboostFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostFrame::sum(self : MlensemblecatboostFrame) -> Double { @_common.sum(self.data) }

pub fn MlensemblecatboostFrame::mean(self : MlensemblecatboostFrame) -> Double { @_common.mean(self.data) }

pub fn MlensemblecatboostFrame::scale(self : MlensemblecatboostFrame, f : Double) -> MlensemblecatboostFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostFrame::add(self : MlensemblecatboostFrame, other : MlensemblecatboostFrame) -> MlensemblecatboostFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblecatboostFrame::copy(self : MlensemblecatboostFrame) -> MlensemblecatboostFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostFrame::fill(self : MlensemblecatboostFrame, v : Double) -> MlensemblecatboostFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostFrame::min(self : MlensemblecatboostFrame) -> Double { @_common.min(self.data) }

pub fn MlensemblecatboostFrame::max(self : MlensemblecatboostFrame) -> Double { @_common.max(self.data) }

pub fn MlensemblecatboostFrame::to_string(self : MlensemblecatboostFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_table_make(size : Int) -> MlensemblecatboostTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblecatboostTable::len(self : MlensemblecatboostTable) -> Int { self.size }

pub fn MlensemblecatboostTable::get(self : MlensemblecatboostTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblecatboostTable::set(self : MlensemblecatboostTable, i : Int, v : Double) -> MlensemblecatboostTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostTable::sum(self : MlensemblecatboostTable) -> Double { @_common.sum(self.data) }

pub fn MlensemblecatboostTable::mean(self : MlensemblecatboostTable) -> Double { @_common.mean(self.data) }

pub fn MlensemblecatboostTable::scale(self : MlensemblecatboostTable, f : Double) -> MlensemblecatboostTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostTable::add(self : MlensemblecatboostTable, other : MlensemblecatboostTable) -> MlensemblecatboostTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblecatboostTable::copy(self : MlensemblecatboostTable) -> MlensemblecatboostTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostTable::fill(self : MlensemblecatboostTable, v : Double) -> MlensemblecatboostTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostTable::min(self : MlensemblecatboostTable) -> Double { @_common.min(self.data) }

pub fn MlensemblecatboostTable::max(self : MlensemblecatboostTable) -> Double { @_common.max(self.data) }

pub fn MlensemblecatboostTable::to_string(self : MlensemblecatboostTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_graphn_make(size : Int) -> MlensemblecatboostGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblecatboostGraphN::len(self : MlensemblecatboostGraphN) -> Int { self.size }

pub fn MlensemblecatboostGraphN::get(self : MlensemblecatboostGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblecatboostGraphN::set(self : MlensemblecatboostGraphN, i : Int, v : Double) -> MlensemblecatboostGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostGraphN::sum(self : MlensemblecatboostGraphN) -> Double { @_common.sum(self.data) }

pub fn MlensemblecatboostGraphN::mean(self : MlensemblecatboostGraphN) -> Double { @_common.mean(self.data) }

pub fn MlensemblecatboostGraphN::scale(self : MlensemblecatboostGraphN, f : Double) -> MlensemblecatboostGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostGraphN::add(self : MlensemblecatboostGraphN, other : MlensemblecatboostGraphN) -> MlensemblecatboostGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblecatboostGraphN::copy(self : MlensemblecatboostGraphN) -> MlensemblecatboostGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostGraphN::fill(self : MlensemblecatboostGraphN, v : Double) -> MlensemblecatboostGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostGraphN::min(self : MlensemblecatboostGraphN) -> Double { @_common.min(self.data) }

pub fn MlensemblecatboostGraphN::max(self : MlensemblecatboostGraphN) -> Double { @_common.max(self.data) }

pub fn MlensemblecatboostGraphN::to_string(self : MlensemblecatboostGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_node_make(size : Int) -> MlensemblecatboostNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblecatboostNode::len(self : MlensemblecatboostNode) -> Int { self.size }

pub fn MlensemblecatboostNode::get(self : MlensemblecatboostNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblecatboostNode::set(self : MlensemblecatboostNode, i : Int, v : Double) -> MlensemblecatboostNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostNode::sum(self : MlensemblecatboostNode) -> Double { @_common.sum(self.data) }

pub fn MlensemblecatboostNode::mean(self : MlensemblecatboostNode) -> Double { @_common.mean(self.data) }

pub fn MlensemblecatboostNode::scale(self : MlensemblecatboostNode, f : Double) -> MlensemblecatboostNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostNode::add(self : MlensemblecatboostNode, other : MlensemblecatboostNode) -> MlensemblecatboostNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblecatboostNode::copy(self : MlensemblecatboostNode) -> MlensemblecatboostNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostNode::fill(self : MlensemblecatboostNode, v : Double) -> MlensemblecatboostNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostNode::min(self : MlensemblecatboostNode) -> Double { @_common.min(self.data) }

pub fn MlensemblecatboostNode::max(self : MlensemblecatboostNode) -> Double { @_common.max(self.data) }

pub fn MlensemblecatboostNode::to_string(self : MlensemblecatboostNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_edge_make(size : Int) -> MlensemblecatboostEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblecatboostEdge::len(self : MlensemblecatboostEdge) -> Int { self.size }

pub fn MlensemblecatboostEdge::get(self : MlensemblecatboostEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblecatboostEdge::set(self : MlensemblecatboostEdge, i : Int, v : Double) -> MlensemblecatboostEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostEdge::sum(self : MlensemblecatboostEdge) -> Double { @_common.sum(self.data) }

pub fn MlensemblecatboostEdge::mean(self : MlensemblecatboostEdge) -> Double { @_common.mean(self.data) }

pub fn MlensemblecatboostEdge::scale(self : MlensemblecatboostEdge, f : Double) -> MlensemblecatboostEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostEdge::add(self : MlensemblecatboostEdge, other : MlensemblecatboostEdge) -> MlensemblecatboostEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblecatboostEdge::copy(self : MlensemblecatboostEdge) -> MlensemblecatboostEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostEdge::fill(self : MlensemblecatboostEdge, v : Double) -> MlensemblecatboostEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostEdge::min(self : MlensemblecatboostEdge) -> Double { @_common.min(self.data) }

pub fn MlensemblecatboostEdge::max(self : MlensemblecatboostEdge) -> Double { @_common.max(self.data) }

pub fn MlensemblecatboostEdge::to_string(self : MlensemblecatboostEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_path_make(size : Int) -> MlensemblecatboostPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblecatboostPath::len(self : MlensemblecatboostPath) -> Int { self.size }

pub fn MlensemblecatboostPath::get(self : MlensemblecatboostPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblecatboostPath::set(self : MlensemblecatboostPath, i : Int, v : Double) -> MlensemblecatboostPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostPath::sum(self : MlensemblecatboostPath) -> Double { @_common.sum(self.data) }

pub fn MlensemblecatboostPath::mean(self : MlensemblecatboostPath) -> Double { @_common.mean(self.data) }

pub fn MlensemblecatboostPath::scale(self : MlensemblecatboostPath, f : Double) -> MlensemblecatboostPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostPath::add(self : MlensemblecatboostPath, other : MlensemblecatboostPath) -> MlensemblecatboostPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblecatboostPath::copy(self : MlensemblecatboostPath) -> MlensemblecatboostPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostPath::fill(self : MlensemblecatboostPath, v : Double) -> MlensemblecatboostPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostPath::min(self : MlensemblecatboostPath) -> Double { @_common.min(self.data) }

pub fn MlensemblecatboostPath::max(self : MlensemblecatboostPath) -> Double { @_common.max(self.data) }

pub fn MlensemblecatboostPath::to_string(self : MlensemblecatboostPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_cluster_make(size : Int) -> MlensemblecatboostCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblecatboostCluster::len(self : MlensemblecatboostCluster) -> Int { self.size }

pub fn MlensemblecatboostCluster::get(self : MlensemblecatboostCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblecatboostCluster::set(self : MlensemblecatboostCluster, i : Int, v : Double) -> MlensemblecatboostCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostCluster::sum(self : MlensemblecatboostCluster) -> Double { @_common.sum(self.data) }

pub fn MlensemblecatboostCluster::mean(self : MlensemblecatboostCluster) -> Double { @_common.mean(self.data) }

pub fn MlensemblecatboostCluster::scale(self : MlensemblecatboostCluster, f : Double) -> MlensemblecatboostCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostCluster::add(self : MlensemblecatboostCluster, other : MlensemblecatboostCluster) -> MlensemblecatboostCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblecatboostCluster::copy(self : MlensemblecatboostCluster) -> MlensemblecatboostCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostCluster::fill(self : MlensemblecatboostCluster, v : Double) -> MlensemblecatboostCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostCluster::min(self : MlensemblecatboostCluster) -> Double { @_common.min(self.data) }

pub fn MlensemblecatboostCluster::max(self : MlensemblecatboostCluster) -> Double { @_common.max(self.data) }

pub fn MlensemblecatboostCluster::to_string(self : MlensemblecatboostCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_model_make(size : Int) -> MlensemblecatboostModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblecatboostModel::len(self : MlensemblecatboostModel) -> Int { self.size }

pub fn MlensemblecatboostModel::get(self : MlensemblecatboostModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblecatboostModel::set(self : MlensemblecatboostModel, i : Int, v : Double) -> MlensemblecatboostModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostModel::sum(self : MlensemblecatboostModel) -> Double { @_common.sum(self.data) }

pub fn MlensemblecatboostModel::mean(self : MlensemblecatboostModel) -> Double { @_common.mean(self.data) }

pub fn MlensemblecatboostModel::scale(self : MlensemblecatboostModel, f : Double) -> MlensemblecatboostModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostModel::add(self : MlensemblecatboostModel, other : MlensemblecatboostModel) -> MlensemblecatboostModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblecatboostModel::copy(self : MlensemblecatboostModel) -> MlensemblecatboostModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostModel::fill(self : MlensemblecatboostModel, v : Double) -> MlensemblecatboostModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostModel::min(self : MlensemblecatboostModel) -> Double { @_common.min(self.data) }

pub fn MlensemblecatboostModel::max(self : MlensemblecatboostModel) -> Double { @_common.max(self.data) }

pub fn MlensemblecatboostModel::to_string(self : MlensemblecatboostModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_layer_make(size : Int) -> MlensemblecatboostLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblecatboostLayer::len(self : MlensemblecatboostLayer) -> Int { self.size }

pub fn MlensemblecatboostLayer::get(self : MlensemblecatboostLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblecatboostLayer::set(self : MlensemblecatboostLayer, i : Int, v : Double) -> MlensemblecatboostLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostLayer::sum(self : MlensemblecatboostLayer) -> Double { @_common.sum(self.data) }

pub fn MlensemblecatboostLayer::mean(self : MlensemblecatboostLayer) -> Double { @_common.mean(self.data) }

pub fn MlensemblecatboostLayer::scale(self : MlensemblecatboostLayer, f : Double) -> MlensemblecatboostLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostLayer::add(self : MlensemblecatboostLayer, other : MlensemblecatboostLayer) -> MlensemblecatboostLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblecatboostLayer::copy(self : MlensemblecatboostLayer) -> MlensemblecatboostLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostLayer::fill(self : MlensemblecatboostLayer, v : Double) -> MlensemblecatboostLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostLayer::min(self : MlensemblecatboostLayer) -> Double { @_common.min(self.data) }

pub fn MlensemblecatboostLayer::max(self : MlensemblecatboostLayer) -> Double { @_common.max(self.data) }

pub fn MlensemblecatboostLayer::to_string(self : MlensemblecatboostLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_buffer_make(size : Int) -> MlensemblecatboostBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblecatboostBuffer::len(self : MlensemblecatboostBuffer) -> Int { self.size }

pub fn MlensemblecatboostBuffer::get(self : MlensemblecatboostBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblecatboostBuffer::set(self : MlensemblecatboostBuffer, i : Int, v : Double) -> MlensemblecatboostBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostBuffer::sum(self : MlensemblecatboostBuffer) -> Double { @_common.sum(self.data) }

pub fn MlensemblecatboostBuffer::mean(self : MlensemblecatboostBuffer) -> Double { @_common.mean(self.data) }

pub fn MlensemblecatboostBuffer::scale(self : MlensemblecatboostBuffer, f : Double) -> MlensemblecatboostBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostBuffer::add(self : MlensemblecatboostBuffer, other : MlensemblecatboostBuffer) -> MlensemblecatboostBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblecatboostBuffer::copy(self : MlensemblecatboostBuffer) -> MlensemblecatboostBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostBuffer::fill(self : MlensemblecatboostBuffer, v : Double) -> MlensemblecatboostBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostBuffer::min(self : MlensemblecatboostBuffer) -> Double { @_common.min(self.data) }

pub fn MlensemblecatboostBuffer::max(self : MlensemblecatboostBuffer) -> Double { @_common.max(self.data) }

pub fn MlensemblecatboostBuffer::to_string(self : MlensemblecatboostBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_cursor_make(size : Int) -> MlensemblecatboostCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblecatboostCursor::len(self : MlensemblecatboostCursor) -> Int { self.size }

pub fn MlensemblecatboostCursor::get(self : MlensemblecatboostCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblecatboostCursor::set(self : MlensemblecatboostCursor, i : Int, v : Double) -> MlensemblecatboostCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostCursor::sum(self : MlensemblecatboostCursor) -> Double { @_common.sum(self.data) }

pub fn MlensemblecatboostCursor::mean(self : MlensemblecatboostCursor) -> Double { @_common.mean(self.data) }

pub fn MlensemblecatboostCursor::scale(self : MlensemblecatboostCursor, f : Double) -> MlensemblecatboostCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostCursor::add(self : MlensemblecatboostCursor, other : MlensemblecatboostCursor) -> MlensemblecatboostCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblecatboostCursor::copy(self : MlensemblecatboostCursor) -> MlensemblecatboostCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostCursor::fill(self : MlensemblecatboostCursor, v : Double) -> MlensemblecatboostCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostCursor::min(self : MlensemblecatboostCursor) -> Double { @_common.min(self.data) }

pub fn MlensemblecatboostCursor::max(self : MlensemblecatboostCursor) -> Double { @_common.max(self.data) }

pub fn MlensemblecatboostCursor::to_string(self : MlensemblecatboostCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_view_make(size : Int) -> MlensemblecatboostView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblecatboostView::len(self : MlensemblecatboostView) -> Int { self.size }

pub fn MlensemblecatboostView::get(self : MlensemblecatboostView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblecatboostView::set(self : MlensemblecatboostView, i : Int, v : Double) -> MlensemblecatboostView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostView::sum(self : MlensemblecatboostView) -> Double { @_common.sum(self.data) }

pub fn MlensemblecatboostView::mean(self : MlensemblecatboostView) -> Double { @_common.mean(self.data) }

pub fn MlensemblecatboostView::scale(self : MlensemblecatboostView, f : Double) -> MlensemblecatboostView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostView::add(self : MlensemblecatboostView, other : MlensemblecatboostView) -> MlensemblecatboostView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblecatboostView::copy(self : MlensemblecatboostView) -> MlensemblecatboostView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostView::fill(self : MlensemblecatboostView, v : Double) -> MlensemblecatboostView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostView::min(self : MlensemblecatboostView) -> Double { @_common.min(self.data) }

pub fn MlensemblecatboostView::max(self : MlensemblecatboostView) -> Double { @_common.max(self.data) }

pub fn MlensemblecatboostView::to_string(self : MlensemblecatboostView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_range_make(size : Int) -> MlensemblecatboostRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblecatboostRange::len(self : MlensemblecatboostRange) -> Int { self.size }

pub fn MlensemblecatboostRange::get(self : MlensemblecatboostRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblecatboostRange::set(self : MlensemblecatboostRange, i : Int, v : Double) -> MlensemblecatboostRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostRange::sum(self : MlensemblecatboostRange) -> Double { @_common.sum(self.data) }

pub fn MlensemblecatboostRange::mean(self : MlensemblecatboostRange) -> Double { @_common.mean(self.data) }

pub fn MlensemblecatboostRange::scale(self : MlensemblecatboostRange, f : Double) -> MlensemblecatboostRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostRange::add(self : MlensemblecatboostRange, other : MlensemblecatboostRange) -> MlensemblecatboostRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblecatboostRange::copy(self : MlensemblecatboostRange) -> MlensemblecatboostRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostRange::fill(self : MlensemblecatboostRange, v : Double) -> MlensemblecatboostRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostRange::min(self : MlensemblecatboostRange) -> Double { @_common.min(self.data) }

pub fn MlensemblecatboostRange::max(self : MlensemblecatboostRange) -> Double { @_common.max(self.data) }

pub fn MlensemblecatboostRange::to_string(self : MlensemblecatboostRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_slice_make(size : Int) -> MlensemblecatboostSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblecatboostSlice::len(self : MlensemblecatboostSlice) -> Int { self.size }

pub fn MlensemblecatboostSlice::get(self : MlensemblecatboostSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblecatboostSlice::set(self : MlensemblecatboostSlice, i : Int, v : Double) -> MlensemblecatboostSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostSlice::sum(self : MlensemblecatboostSlice) -> Double { @_common.sum(self.data) }

pub fn MlensemblecatboostSlice::mean(self : MlensemblecatboostSlice) -> Double { @_common.mean(self.data) }

pub fn MlensemblecatboostSlice::scale(self : MlensemblecatboostSlice, f : Double) -> MlensemblecatboostSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostSlice::add(self : MlensemblecatboostSlice, other : MlensemblecatboostSlice) -> MlensemblecatboostSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblecatboostSlice::copy(self : MlensemblecatboostSlice) -> MlensemblecatboostSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostSlice::fill(self : MlensemblecatboostSlice, v : Double) -> MlensemblecatboostSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblecatboostSlice::min(self : MlensemblecatboostSlice) -> Double { @_common.min(self.data) }

pub fn MlensemblecatboostSlice::max(self : MlensemblecatboostSlice) -> Double { @_common.max(self.data) }

pub fn MlensemblecatboostSlice::to_string(self : MlensemblecatboostSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

