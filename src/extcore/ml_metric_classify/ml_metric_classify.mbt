///===
/// extcore/ml_metric_classify

pub(all) struct MlmetricclassifyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_classify_make_point(x : Double, y : Double) -> MlmetricclassifyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_classify_make_point3(x : Double, y : Double, z : Double) -> MlmetricclassifyPoint {
  { x, y, z, label: 0 }
}

pub fn MlmetricclassifyPoint::x(self : MlmetricclassifyPoint) -> Double { self.x }

pub fn MlmetricclassifyPoint::y(self : MlmetricclassifyPoint) -> Double { self.y }

pub fn MlmetricclassifyPoint::z(self : MlmetricclassifyPoint) -> Double { self.z }

pub fn MlmetricclassifyPoint::label(self : MlmetricclassifyPoint) -> Int { self.label }

pub fn MlmetricclassifyPoint::dist(self : MlmetricclassifyPoint, other : MlmetricclassifyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlmetricclassifyPoint::add(self : MlmetricclassifyPoint, other : MlmetricclassifyPoint) -> MlmetricclassifyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlmetricclassifyPoint::sub(self : MlmetricclassifyPoint, other : MlmetricclassifyPoint) -> MlmetricclassifyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlmetricclassifyPoint::scale(self : MlmetricclassifyPoint, s : Double) -> MlmetricclassifyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlmetricclassifyPoint::dot(self : MlmetricclassifyPoint, other : MlmetricclassifyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlmetricclassifyPoint::cross(self : MlmetricclassifyPoint, other : MlmetricclassifyPoint) -> MlmetricclassifyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlmetricclassifyPoint::norm(self : MlmetricclassifyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlmetricclassifyPoint::normalize(self : MlmetricclassifyPoint) -> MlmetricclassifyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricclassifyPoint::negate(self : MlmetricclassifyPoint) -> MlmetricclassifyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlmetricclassifyPoint::mid(self : MlmetricclassifyPoint, other : MlmetricclassifyPoint) -> MlmetricclassifyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlmetricclassifyPoint::lerp(self : MlmetricclassifyPoint, other : MlmetricclassifyPoint, t : Double) -> MlmetricclassifyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlmetricclassifyPoint::to_string(self : MlmetricclassifyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlmetricclassifySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_classify_make_series(vals : Array[Double], name : String) -> MlmetricclassifySeries {
  { vals, name, meta: 0 }
}

pub fn MlmetricclassifySeries::len(self : MlmetricclassifySeries) -> Int { self.vals.length() }

pub fn MlmetricclassifySeries::sum(self : MlmetricclassifySeries) -> Double { @_common.sum(self.vals) }

pub fn MlmetricclassifySeries::mean(self : MlmetricclassifySeries) -> Double { @_common.mean(self.vals) }

pub fn MlmetricclassifySeries::min(self : MlmetricclassifySeries) -> Double { @_common.min(self.vals) }

pub fn MlmetricclassifySeries::max(self : MlmetricclassifySeries) -> Double { @_common.max(self.vals) }

pub fn MlmetricclassifySeries::range(self : MlmetricclassifySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlmetricclassifySeries::variance(self : MlmetricclassifySeries) -> Double { @_common.variance(self.vals) }

pub fn MlmetricclassifySeries::std(self : MlmetricclassifySeries) -> Double { @_common.std(self.vals) }

pub fn MlmetricclassifySeries::median(self : MlmetricclassifySeries) -> Double { @_common.median(self.vals) }

pub fn MlmetricclassifySeries::scale(self : MlmetricclassifySeries, f : Double) -> MlmetricclassifySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlmetricclassifySeries::add(self : MlmetricclassifySeries, other : MlmetricclassifySeries) -> MlmetricclassifySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlmetricclassifySeries::sub(self : MlmetricclassifySeries, other : MlmetricclassifySeries) -> MlmetricclassifySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlmetricclassifySeries::normalize(self : MlmetricclassifySeries) -> MlmetricclassifySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlmetricclassifySeries::cumsum(self : MlmetricclassifySeries) -> MlmetricclassifySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlmetricclassifySeries::to_string(self : MlmetricclassifySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricclassifyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_classify_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricclassifyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_classify_matrix_identity(n : Int) -> MlmetricclassifyMatrix {
  let m = ml_metric_classify_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlmetricclassifyMatrix::get(self : MlmetricclassifyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlmetricclassifyMatrix::transpose(self : MlmetricclassifyMatrix) -> MlmetricclassifyMatrix {
  let result = ml_metric_classify_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlmetricclassifyMatrix::add(self : MlmetricclassifyMatrix, other : MlmetricclassifyMatrix) -> MlmetricclassifyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_metric_classify_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlmetricclassifyMatrix::scale(self : MlmetricclassifyMatrix, s : Double) -> MlmetricclassifyMatrix {
  let result = ml_metric_classify_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlmetricclassifyMatrix::multiply(self : MlmetricclassifyMatrix, other : MlmetricclassifyMatrix) -> MlmetricclassifyMatrix {
  if self.cols != other.rows { return ml_metric_classify_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_metric_classify_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlmetricclassifyMatrix::trace(self : MlmetricclassifyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlmetricclassifyMatrix::det(self : MlmetricclassifyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlmetricclassifyMatrix::norm(self : MlmetricclassifyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlmetricclassifyMatrix::to_string(self : MlmetricclassifyMatrix) -> String {
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

pub(all) struct MlmetricclassifyVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_classify_make_vector(comps : Array[Double]) -> MlmetricclassifyVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_classify_vector_zero(dim : Int) -> MlmetricclassifyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlmetricclassifyVector::add(self : MlmetricclassifyVector, other : MlmetricclassifyVector) -> MlmetricclassifyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricclassifyVector::sub(self : MlmetricclassifyVector, other : MlmetricclassifyVector) -> MlmetricclassifyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricclassifyVector::scale(self : MlmetricclassifyVector, s : Double) -> MlmetricclassifyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlmetricclassifyVector::dot(self : MlmetricclassifyVector, other : MlmetricclassifyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlmetricclassifyVector::norm(self : MlmetricclassifyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlmetricclassifyVector::normalize(self : MlmetricclassifyVector) -> MlmetricclassifyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricclassifyVector::dist(self : MlmetricclassifyVector, other : MlmetricclassifyVector) -> Double {
  self.sub(other).norm()
}

pub fn MlmetricclassifyVector::to_string(self : MlmetricclassifyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_classify_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_classify_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_classify_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_classify_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_classify_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_classify_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_classify_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_classify_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_classify_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_classify_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_classify_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_classify_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_classify_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_classify_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_classify_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_classify_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_classify_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_classify_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_classify_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_classify_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_classify_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_classify_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_classify_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_classify_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_classify_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_classify_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_classify_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_classify_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_classify_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetricclassifyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_frame_make(size : Int) -> MlmetricclassifyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclassifyFrame::len(self : MlmetricclassifyFrame) -> Int { self.size }

pub fn MlmetricclassifyFrame::get(self : MlmetricclassifyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclassifyFrame::set(self : MlmetricclassifyFrame, i : Int, v : Double) -> MlmetricclassifyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyFrame::sum(self : MlmetricclassifyFrame) -> Double { @_common.sum(self.data) }

pub fn MlmetricclassifyFrame::mean(self : MlmetricclassifyFrame) -> Double { @_common.mean(self.data) }

pub fn MlmetricclassifyFrame::scale(self : MlmetricclassifyFrame, f : Double) -> MlmetricclassifyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyFrame::add(self : MlmetricclassifyFrame, other : MlmetricclassifyFrame) -> MlmetricclassifyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclassifyFrame::copy(self : MlmetricclassifyFrame) -> MlmetricclassifyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyFrame::fill(self : MlmetricclassifyFrame, v : Double) -> MlmetricclassifyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyFrame::min(self : MlmetricclassifyFrame) -> Double { @_common.min(self.data) }

pub fn MlmetricclassifyFrame::max(self : MlmetricclassifyFrame) -> Double { @_common.max(self.data) }

pub fn MlmetricclassifyFrame::to_string(self : MlmetricclassifyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_table_make(size : Int) -> MlmetricclassifyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclassifyTable::len(self : MlmetricclassifyTable) -> Int { self.size }

pub fn MlmetricclassifyTable::get(self : MlmetricclassifyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclassifyTable::set(self : MlmetricclassifyTable, i : Int, v : Double) -> MlmetricclassifyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyTable::sum(self : MlmetricclassifyTable) -> Double { @_common.sum(self.data) }

pub fn MlmetricclassifyTable::mean(self : MlmetricclassifyTable) -> Double { @_common.mean(self.data) }

pub fn MlmetricclassifyTable::scale(self : MlmetricclassifyTable, f : Double) -> MlmetricclassifyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyTable::add(self : MlmetricclassifyTable, other : MlmetricclassifyTable) -> MlmetricclassifyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclassifyTable::copy(self : MlmetricclassifyTable) -> MlmetricclassifyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyTable::fill(self : MlmetricclassifyTable, v : Double) -> MlmetricclassifyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyTable::min(self : MlmetricclassifyTable) -> Double { @_common.min(self.data) }

pub fn MlmetricclassifyTable::max(self : MlmetricclassifyTable) -> Double { @_common.max(self.data) }

pub fn MlmetricclassifyTable::to_string(self : MlmetricclassifyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_graphn_make(size : Int) -> MlmetricclassifyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclassifyGraphN::len(self : MlmetricclassifyGraphN) -> Int { self.size }

pub fn MlmetricclassifyGraphN::get(self : MlmetricclassifyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclassifyGraphN::set(self : MlmetricclassifyGraphN, i : Int, v : Double) -> MlmetricclassifyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyGraphN::sum(self : MlmetricclassifyGraphN) -> Double { @_common.sum(self.data) }

pub fn MlmetricclassifyGraphN::mean(self : MlmetricclassifyGraphN) -> Double { @_common.mean(self.data) }

pub fn MlmetricclassifyGraphN::scale(self : MlmetricclassifyGraphN, f : Double) -> MlmetricclassifyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyGraphN::add(self : MlmetricclassifyGraphN, other : MlmetricclassifyGraphN) -> MlmetricclassifyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclassifyGraphN::copy(self : MlmetricclassifyGraphN) -> MlmetricclassifyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyGraphN::fill(self : MlmetricclassifyGraphN, v : Double) -> MlmetricclassifyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyGraphN::min(self : MlmetricclassifyGraphN) -> Double { @_common.min(self.data) }

pub fn MlmetricclassifyGraphN::max(self : MlmetricclassifyGraphN) -> Double { @_common.max(self.data) }

pub fn MlmetricclassifyGraphN::to_string(self : MlmetricclassifyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_node_make(size : Int) -> MlmetricclassifyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclassifyNode::len(self : MlmetricclassifyNode) -> Int { self.size }

pub fn MlmetricclassifyNode::get(self : MlmetricclassifyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclassifyNode::set(self : MlmetricclassifyNode, i : Int, v : Double) -> MlmetricclassifyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyNode::sum(self : MlmetricclassifyNode) -> Double { @_common.sum(self.data) }

pub fn MlmetricclassifyNode::mean(self : MlmetricclassifyNode) -> Double { @_common.mean(self.data) }

pub fn MlmetricclassifyNode::scale(self : MlmetricclassifyNode, f : Double) -> MlmetricclassifyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyNode::add(self : MlmetricclassifyNode, other : MlmetricclassifyNode) -> MlmetricclassifyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclassifyNode::copy(self : MlmetricclassifyNode) -> MlmetricclassifyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyNode::fill(self : MlmetricclassifyNode, v : Double) -> MlmetricclassifyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyNode::min(self : MlmetricclassifyNode) -> Double { @_common.min(self.data) }

pub fn MlmetricclassifyNode::max(self : MlmetricclassifyNode) -> Double { @_common.max(self.data) }

pub fn MlmetricclassifyNode::to_string(self : MlmetricclassifyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_edge_make(size : Int) -> MlmetricclassifyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclassifyEdge::len(self : MlmetricclassifyEdge) -> Int { self.size }

pub fn MlmetricclassifyEdge::get(self : MlmetricclassifyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclassifyEdge::set(self : MlmetricclassifyEdge, i : Int, v : Double) -> MlmetricclassifyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyEdge::sum(self : MlmetricclassifyEdge) -> Double { @_common.sum(self.data) }

pub fn MlmetricclassifyEdge::mean(self : MlmetricclassifyEdge) -> Double { @_common.mean(self.data) }

pub fn MlmetricclassifyEdge::scale(self : MlmetricclassifyEdge, f : Double) -> MlmetricclassifyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyEdge::add(self : MlmetricclassifyEdge, other : MlmetricclassifyEdge) -> MlmetricclassifyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclassifyEdge::copy(self : MlmetricclassifyEdge) -> MlmetricclassifyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyEdge::fill(self : MlmetricclassifyEdge, v : Double) -> MlmetricclassifyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyEdge::min(self : MlmetricclassifyEdge) -> Double { @_common.min(self.data) }

pub fn MlmetricclassifyEdge::max(self : MlmetricclassifyEdge) -> Double { @_common.max(self.data) }

pub fn MlmetricclassifyEdge::to_string(self : MlmetricclassifyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_path_make(size : Int) -> MlmetricclassifyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclassifyPath::len(self : MlmetricclassifyPath) -> Int { self.size }

pub fn MlmetricclassifyPath::get(self : MlmetricclassifyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclassifyPath::set(self : MlmetricclassifyPath, i : Int, v : Double) -> MlmetricclassifyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyPath::sum(self : MlmetricclassifyPath) -> Double { @_common.sum(self.data) }

pub fn MlmetricclassifyPath::mean(self : MlmetricclassifyPath) -> Double { @_common.mean(self.data) }

pub fn MlmetricclassifyPath::scale(self : MlmetricclassifyPath, f : Double) -> MlmetricclassifyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyPath::add(self : MlmetricclassifyPath, other : MlmetricclassifyPath) -> MlmetricclassifyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclassifyPath::copy(self : MlmetricclassifyPath) -> MlmetricclassifyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyPath::fill(self : MlmetricclassifyPath, v : Double) -> MlmetricclassifyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyPath::min(self : MlmetricclassifyPath) -> Double { @_common.min(self.data) }

pub fn MlmetricclassifyPath::max(self : MlmetricclassifyPath) -> Double { @_common.max(self.data) }

pub fn MlmetricclassifyPath::to_string(self : MlmetricclassifyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_cluster_make(size : Int) -> MlmetricclassifyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclassifyCluster::len(self : MlmetricclassifyCluster) -> Int { self.size }

pub fn MlmetricclassifyCluster::get(self : MlmetricclassifyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclassifyCluster::set(self : MlmetricclassifyCluster, i : Int, v : Double) -> MlmetricclassifyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyCluster::sum(self : MlmetricclassifyCluster) -> Double { @_common.sum(self.data) }

pub fn MlmetricclassifyCluster::mean(self : MlmetricclassifyCluster) -> Double { @_common.mean(self.data) }

pub fn MlmetricclassifyCluster::scale(self : MlmetricclassifyCluster, f : Double) -> MlmetricclassifyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyCluster::add(self : MlmetricclassifyCluster, other : MlmetricclassifyCluster) -> MlmetricclassifyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclassifyCluster::copy(self : MlmetricclassifyCluster) -> MlmetricclassifyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyCluster::fill(self : MlmetricclassifyCluster, v : Double) -> MlmetricclassifyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyCluster::min(self : MlmetricclassifyCluster) -> Double { @_common.min(self.data) }

pub fn MlmetricclassifyCluster::max(self : MlmetricclassifyCluster) -> Double { @_common.max(self.data) }

pub fn MlmetricclassifyCluster::to_string(self : MlmetricclassifyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_model_make(size : Int) -> MlmetricclassifyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclassifyModel::len(self : MlmetricclassifyModel) -> Int { self.size }

pub fn MlmetricclassifyModel::get(self : MlmetricclassifyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclassifyModel::set(self : MlmetricclassifyModel, i : Int, v : Double) -> MlmetricclassifyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyModel::sum(self : MlmetricclassifyModel) -> Double { @_common.sum(self.data) }

pub fn MlmetricclassifyModel::mean(self : MlmetricclassifyModel) -> Double { @_common.mean(self.data) }

pub fn MlmetricclassifyModel::scale(self : MlmetricclassifyModel, f : Double) -> MlmetricclassifyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyModel::add(self : MlmetricclassifyModel, other : MlmetricclassifyModel) -> MlmetricclassifyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclassifyModel::copy(self : MlmetricclassifyModel) -> MlmetricclassifyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyModel::fill(self : MlmetricclassifyModel, v : Double) -> MlmetricclassifyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyModel::min(self : MlmetricclassifyModel) -> Double { @_common.min(self.data) }

pub fn MlmetricclassifyModel::max(self : MlmetricclassifyModel) -> Double { @_common.max(self.data) }

pub fn MlmetricclassifyModel::to_string(self : MlmetricclassifyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_layer_make(size : Int) -> MlmetricclassifyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclassifyLayer::len(self : MlmetricclassifyLayer) -> Int { self.size }

pub fn MlmetricclassifyLayer::get(self : MlmetricclassifyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclassifyLayer::set(self : MlmetricclassifyLayer, i : Int, v : Double) -> MlmetricclassifyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyLayer::sum(self : MlmetricclassifyLayer) -> Double { @_common.sum(self.data) }

pub fn MlmetricclassifyLayer::mean(self : MlmetricclassifyLayer) -> Double { @_common.mean(self.data) }

pub fn MlmetricclassifyLayer::scale(self : MlmetricclassifyLayer, f : Double) -> MlmetricclassifyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyLayer::add(self : MlmetricclassifyLayer, other : MlmetricclassifyLayer) -> MlmetricclassifyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclassifyLayer::copy(self : MlmetricclassifyLayer) -> MlmetricclassifyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyLayer::fill(self : MlmetricclassifyLayer, v : Double) -> MlmetricclassifyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyLayer::min(self : MlmetricclassifyLayer) -> Double { @_common.min(self.data) }

pub fn MlmetricclassifyLayer::max(self : MlmetricclassifyLayer) -> Double { @_common.max(self.data) }

pub fn MlmetricclassifyLayer::to_string(self : MlmetricclassifyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_buffer_make(size : Int) -> MlmetricclassifyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclassifyBuffer::len(self : MlmetricclassifyBuffer) -> Int { self.size }

pub fn MlmetricclassifyBuffer::get(self : MlmetricclassifyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclassifyBuffer::set(self : MlmetricclassifyBuffer, i : Int, v : Double) -> MlmetricclassifyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyBuffer::sum(self : MlmetricclassifyBuffer) -> Double { @_common.sum(self.data) }

pub fn MlmetricclassifyBuffer::mean(self : MlmetricclassifyBuffer) -> Double { @_common.mean(self.data) }

pub fn MlmetricclassifyBuffer::scale(self : MlmetricclassifyBuffer, f : Double) -> MlmetricclassifyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyBuffer::add(self : MlmetricclassifyBuffer, other : MlmetricclassifyBuffer) -> MlmetricclassifyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclassifyBuffer::copy(self : MlmetricclassifyBuffer) -> MlmetricclassifyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyBuffer::fill(self : MlmetricclassifyBuffer, v : Double) -> MlmetricclassifyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyBuffer::min(self : MlmetricclassifyBuffer) -> Double { @_common.min(self.data) }

pub fn MlmetricclassifyBuffer::max(self : MlmetricclassifyBuffer) -> Double { @_common.max(self.data) }

pub fn MlmetricclassifyBuffer::to_string(self : MlmetricclassifyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_cursor_make(size : Int) -> MlmetricclassifyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclassifyCursor::len(self : MlmetricclassifyCursor) -> Int { self.size }

pub fn MlmetricclassifyCursor::get(self : MlmetricclassifyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclassifyCursor::set(self : MlmetricclassifyCursor, i : Int, v : Double) -> MlmetricclassifyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyCursor::sum(self : MlmetricclassifyCursor) -> Double { @_common.sum(self.data) }

pub fn MlmetricclassifyCursor::mean(self : MlmetricclassifyCursor) -> Double { @_common.mean(self.data) }

pub fn MlmetricclassifyCursor::scale(self : MlmetricclassifyCursor, f : Double) -> MlmetricclassifyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyCursor::add(self : MlmetricclassifyCursor, other : MlmetricclassifyCursor) -> MlmetricclassifyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclassifyCursor::copy(self : MlmetricclassifyCursor) -> MlmetricclassifyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyCursor::fill(self : MlmetricclassifyCursor, v : Double) -> MlmetricclassifyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyCursor::min(self : MlmetricclassifyCursor) -> Double { @_common.min(self.data) }

pub fn MlmetricclassifyCursor::max(self : MlmetricclassifyCursor) -> Double { @_common.max(self.data) }

pub fn MlmetricclassifyCursor::to_string(self : MlmetricclassifyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_view_make(size : Int) -> MlmetricclassifyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclassifyView::len(self : MlmetricclassifyView) -> Int { self.size }

pub fn MlmetricclassifyView::get(self : MlmetricclassifyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclassifyView::set(self : MlmetricclassifyView, i : Int, v : Double) -> MlmetricclassifyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyView::sum(self : MlmetricclassifyView) -> Double { @_common.sum(self.data) }

pub fn MlmetricclassifyView::mean(self : MlmetricclassifyView) -> Double { @_common.mean(self.data) }

pub fn MlmetricclassifyView::scale(self : MlmetricclassifyView, f : Double) -> MlmetricclassifyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyView::add(self : MlmetricclassifyView, other : MlmetricclassifyView) -> MlmetricclassifyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclassifyView::copy(self : MlmetricclassifyView) -> MlmetricclassifyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyView::fill(self : MlmetricclassifyView, v : Double) -> MlmetricclassifyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyView::min(self : MlmetricclassifyView) -> Double { @_common.min(self.data) }

pub fn MlmetricclassifyView::max(self : MlmetricclassifyView) -> Double { @_common.max(self.data) }

pub fn MlmetricclassifyView::to_string(self : MlmetricclassifyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_range_make(size : Int) -> MlmetricclassifyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclassifyRange::len(self : MlmetricclassifyRange) -> Int { self.size }

pub fn MlmetricclassifyRange::get(self : MlmetricclassifyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclassifyRange::set(self : MlmetricclassifyRange, i : Int, v : Double) -> MlmetricclassifyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyRange::sum(self : MlmetricclassifyRange) -> Double { @_common.sum(self.data) }

pub fn MlmetricclassifyRange::mean(self : MlmetricclassifyRange) -> Double { @_common.mean(self.data) }

pub fn MlmetricclassifyRange::scale(self : MlmetricclassifyRange, f : Double) -> MlmetricclassifyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyRange::add(self : MlmetricclassifyRange, other : MlmetricclassifyRange) -> MlmetricclassifyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclassifyRange::copy(self : MlmetricclassifyRange) -> MlmetricclassifyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyRange::fill(self : MlmetricclassifyRange, v : Double) -> MlmetricclassifyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifyRange::min(self : MlmetricclassifyRange) -> Double { @_common.min(self.data) }

pub fn MlmetricclassifyRange::max(self : MlmetricclassifyRange) -> Double { @_common.max(self.data) }

pub fn MlmetricclassifyRange::to_string(self : MlmetricclassifyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_slice_make(size : Int) -> MlmetricclassifySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclassifySlice::len(self : MlmetricclassifySlice) -> Int { self.size }

pub fn MlmetricclassifySlice::get(self : MlmetricclassifySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclassifySlice::set(self : MlmetricclassifySlice, i : Int, v : Double) -> MlmetricclassifySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclassifySlice::sum(self : MlmetricclassifySlice) -> Double { @_common.sum(self.data) }

pub fn MlmetricclassifySlice::mean(self : MlmetricclassifySlice) -> Double { @_common.mean(self.data) }

pub fn MlmetricclassifySlice::scale(self : MlmetricclassifySlice, f : Double) -> MlmetricclassifySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifySlice::add(self : MlmetricclassifySlice, other : MlmetricclassifySlice) -> MlmetricclassifySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclassifySlice::copy(self : MlmetricclassifySlice) -> MlmetricclassifySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifySlice::fill(self : MlmetricclassifySlice, v : Double) -> MlmetricclassifySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclassifySlice::min(self : MlmetricclassifySlice) -> Double { @_common.min(self.data) }

pub fn MlmetricclassifySlice::max(self : MlmetricclassifySlice) -> Double { @_common.max(self.data) }

pub fn MlmetricclassifySlice::to_string(self : MlmetricclassifySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

