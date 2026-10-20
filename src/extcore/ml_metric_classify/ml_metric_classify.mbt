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

pub fn ml_metric_classify_frame_len(s : MlmetricclassifyFrame) -> Int { s.size }

pub fn ml_metric_classify_frame_get(s : MlmetricclassifyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_frame_set(s : MlmetricclassifyFrame, i : Int, v : Double) -> MlmetricclassifyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_frame_sum(s : MlmetricclassifyFrame) -> Double { @_common.sum(s.data) }

pub fn ml_metric_classify_frame_mean(s : MlmetricclassifyFrame) -> Double { @_common.mean(s.data) }

pub fn ml_metric_classify_frame_scale(s : MlmetricclassifyFrame, f : Double) -> MlmetricclassifyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_frame_add(a : MlmetricclassifyFrame, b : MlmetricclassifyFrame) -> MlmetricclassifyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_classify_frame_copy(s : MlmetricclassifyFrame) -> MlmetricclassifyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_frame_fill(s : MlmetricclassifyFrame, v : Double) -> MlmetricclassifyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_frame_min(s : MlmetricclassifyFrame) -> Double { @_common.min(s.data) }

pub fn ml_metric_classify_frame_max(s : MlmetricclassifyFrame) -> Double { @_common.max(s.data) }

pub fn ml_metric_classify_frame_to_string(s : MlmetricclassifyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_table_make(size : Int) -> MlmetricclassifyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_table_len(s : MlmetricclassifyTable) -> Int { s.size }

pub fn ml_metric_classify_table_get(s : MlmetricclassifyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_table_set(s : MlmetricclassifyTable, i : Int, v : Double) -> MlmetricclassifyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_table_sum(s : MlmetricclassifyTable) -> Double { @_common.sum(s.data) }

pub fn ml_metric_classify_table_mean(s : MlmetricclassifyTable) -> Double { @_common.mean(s.data) }

pub fn ml_metric_classify_table_scale(s : MlmetricclassifyTable, f : Double) -> MlmetricclassifyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_table_add(a : MlmetricclassifyTable, b : MlmetricclassifyTable) -> MlmetricclassifyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_classify_table_copy(s : MlmetricclassifyTable) -> MlmetricclassifyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_table_fill(s : MlmetricclassifyTable, v : Double) -> MlmetricclassifyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_table_min(s : MlmetricclassifyTable) -> Double { @_common.min(s.data) }

pub fn ml_metric_classify_table_max(s : MlmetricclassifyTable) -> Double { @_common.max(s.data) }

pub fn ml_metric_classify_table_to_string(s : MlmetricclassifyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_graphn_make(size : Int) -> MlmetricclassifyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_graphn_len(s : MlmetricclassifyGraphN) -> Int { s.size }

pub fn ml_metric_classify_graphn_get(s : MlmetricclassifyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_graphn_set(s : MlmetricclassifyGraphN, i : Int, v : Double) -> MlmetricclassifyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_graphn_sum(s : MlmetricclassifyGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_metric_classify_graphn_mean(s : MlmetricclassifyGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_metric_classify_graphn_scale(s : MlmetricclassifyGraphN, f : Double) -> MlmetricclassifyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_graphn_add(a : MlmetricclassifyGraphN, b : MlmetricclassifyGraphN) -> MlmetricclassifyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_classify_graphn_copy(s : MlmetricclassifyGraphN) -> MlmetricclassifyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_graphn_fill(s : MlmetricclassifyGraphN, v : Double) -> MlmetricclassifyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_graphn_min(s : MlmetricclassifyGraphN) -> Double { @_common.min(s.data) }

pub fn ml_metric_classify_graphn_max(s : MlmetricclassifyGraphN) -> Double { @_common.max(s.data) }

pub fn ml_metric_classify_graphn_to_string(s : MlmetricclassifyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_node_make(size : Int) -> MlmetricclassifyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_node_len(s : MlmetricclassifyNode) -> Int { s.size }

pub fn ml_metric_classify_node_get(s : MlmetricclassifyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_node_set(s : MlmetricclassifyNode, i : Int, v : Double) -> MlmetricclassifyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_node_sum(s : MlmetricclassifyNode) -> Double { @_common.sum(s.data) }

pub fn ml_metric_classify_node_mean(s : MlmetricclassifyNode) -> Double { @_common.mean(s.data) }

pub fn ml_metric_classify_node_scale(s : MlmetricclassifyNode, f : Double) -> MlmetricclassifyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_node_add(a : MlmetricclassifyNode, b : MlmetricclassifyNode) -> MlmetricclassifyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_classify_node_copy(s : MlmetricclassifyNode) -> MlmetricclassifyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_node_fill(s : MlmetricclassifyNode, v : Double) -> MlmetricclassifyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_node_min(s : MlmetricclassifyNode) -> Double { @_common.min(s.data) }

pub fn ml_metric_classify_node_max(s : MlmetricclassifyNode) -> Double { @_common.max(s.data) }

pub fn ml_metric_classify_node_to_string(s : MlmetricclassifyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_edge_make(size : Int) -> MlmetricclassifyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_edge_len(s : MlmetricclassifyEdge) -> Int { s.size }

pub fn ml_metric_classify_edge_get(s : MlmetricclassifyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_edge_set(s : MlmetricclassifyEdge, i : Int, v : Double) -> MlmetricclassifyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_edge_sum(s : MlmetricclassifyEdge) -> Double { @_common.sum(s.data) }

pub fn ml_metric_classify_edge_mean(s : MlmetricclassifyEdge) -> Double { @_common.mean(s.data) }

pub fn ml_metric_classify_edge_scale(s : MlmetricclassifyEdge, f : Double) -> MlmetricclassifyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_edge_add(a : MlmetricclassifyEdge, b : MlmetricclassifyEdge) -> MlmetricclassifyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_classify_edge_copy(s : MlmetricclassifyEdge) -> MlmetricclassifyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_edge_fill(s : MlmetricclassifyEdge, v : Double) -> MlmetricclassifyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_edge_min(s : MlmetricclassifyEdge) -> Double { @_common.min(s.data) }

pub fn ml_metric_classify_edge_max(s : MlmetricclassifyEdge) -> Double { @_common.max(s.data) }

pub fn ml_metric_classify_edge_to_string(s : MlmetricclassifyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_path_make(size : Int) -> MlmetricclassifyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_path_len(s : MlmetricclassifyPath) -> Int { s.size }

pub fn ml_metric_classify_path_get(s : MlmetricclassifyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_path_set(s : MlmetricclassifyPath, i : Int, v : Double) -> MlmetricclassifyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_path_sum(s : MlmetricclassifyPath) -> Double { @_common.sum(s.data) }

pub fn ml_metric_classify_path_mean(s : MlmetricclassifyPath) -> Double { @_common.mean(s.data) }

pub fn ml_metric_classify_path_scale(s : MlmetricclassifyPath, f : Double) -> MlmetricclassifyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_path_add(a : MlmetricclassifyPath, b : MlmetricclassifyPath) -> MlmetricclassifyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_classify_path_copy(s : MlmetricclassifyPath) -> MlmetricclassifyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_path_fill(s : MlmetricclassifyPath, v : Double) -> MlmetricclassifyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_path_min(s : MlmetricclassifyPath) -> Double { @_common.min(s.data) }

pub fn ml_metric_classify_path_max(s : MlmetricclassifyPath) -> Double { @_common.max(s.data) }

pub fn ml_metric_classify_path_to_string(s : MlmetricclassifyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_cluster_make(size : Int) -> MlmetricclassifyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_cluster_len(s : MlmetricclassifyCluster) -> Int { s.size }

pub fn ml_metric_classify_cluster_get(s : MlmetricclassifyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_cluster_set(s : MlmetricclassifyCluster, i : Int, v : Double) -> MlmetricclassifyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_cluster_sum(s : MlmetricclassifyCluster) -> Double { @_common.sum(s.data) }

pub fn ml_metric_classify_cluster_mean(s : MlmetricclassifyCluster) -> Double { @_common.mean(s.data) }

pub fn ml_metric_classify_cluster_scale(s : MlmetricclassifyCluster, f : Double) -> MlmetricclassifyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_cluster_add(a : MlmetricclassifyCluster, b : MlmetricclassifyCluster) -> MlmetricclassifyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_classify_cluster_copy(s : MlmetricclassifyCluster) -> MlmetricclassifyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_cluster_fill(s : MlmetricclassifyCluster, v : Double) -> MlmetricclassifyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_cluster_min(s : MlmetricclassifyCluster) -> Double { @_common.min(s.data) }

pub fn ml_metric_classify_cluster_max(s : MlmetricclassifyCluster) -> Double { @_common.max(s.data) }

pub fn ml_metric_classify_cluster_to_string(s : MlmetricclassifyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_model_make(size : Int) -> MlmetricclassifyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_model_len(s : MlmetricclassifyModel) -> Int { s.size }

pub fn ml_metric_classify_model_get(s : MlmetricclassifyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_model_set(s : MlmetricclassifyModel, i : Int, v : Double) -> MlmetricclassifyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_model_sum(s : MlmetricclassifyModel) -> Double { @_common.sum(s.data) }

pub fn ml_metric_classify_model_mean(s : MlmetricclassifyModel) -> Double { @_common.mean(s.data) }

pub fn ml_metric_classify_model_scale(s : MlmetricclassifyModel, f : Double) -> MlmetricclassifyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_model_add(a : MlmetricclassifyModel, b : MlmetricclassifyModel) -> MlmetricclassifyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_classify_model_copy(s : MlmetricclassifyModel) -> MlmetricclassifyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_model_fill(s : MlmetricclassifyModel, v : Double) -> MlmetricclassifyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_model_min(s : MlmetricclassifyModel) -> Double { @_common.min(s.data) }

pub fn ml_metric_classify_model_max(s : MlmetricclassifyModel) -> Double { @_common.max(s.data) }

pub fn ml_metric_classify_model_to_string(s : MlmetricclassifyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_layer_make(size : Int) -> MlmetricclassifyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_layer_len(s : MlmetricclassifyLayer) -> Int { s.size }

pub fn ml_metric_classify_layer_get(s : MlmetricclassifyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_layer_set(s : MlmetricclassifyLayer, i : Int, v : Double) -> MlmetricclassifyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_layer_sum(s : MlmetricclassifyLayer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_classify_layer_mean(s : MlmetricclassifyLayer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_classify_layer_scale(s : MlmetricclassifyLayer, f : Double) -> MlmetricclassifyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_layer_add(a : MlmetricclassifyLayer, b : MlmetricclassifyLayer) -> MlmetricclassifyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_classify_layer_copy(s : MlmetricclassifyLayer) -> MlmetricclassifyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_layer_fill(s : MlmetricclassifyLayer, v : Double) -> MlmetricclassifyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_layer_min(s : MlmetricclassifyLayer) -> Double { @_common.min(s.data) }

pub fn ml_metric_classify_layer_max(s : MlmetricclassifyLayer) -> Double { @_common.max(s.data) }

pub fn ml_metric_classify_layer_to_string(s : MlmetricclassifyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_buffer_make(size : Int) -> MlmetricclassifyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_buffer_len(s : MlmetricclassifyBuffer) -> Int { s.size }

pub fn ml_metric_classify_buffer_get(s : MlmetricclassifyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_buffer_set(s : MlmetricclassifyBuffer, i : Int, v : Double) -> MlmetricclassifyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_buffer_sum(s : MlmetricclassifyBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_classify_buffer_mean(s : MlmetricclassifyBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_classify_buffer_scale(s : MlmetricclassifyBuffer, f : Double) -> MlmetricclassifyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_buffer_add(a : MlmetricclassifyBuffer, b : MlmetricclassifyBuffer) -> MlmetricclassifyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_classify_buffer_copy(s : MlmetricclassifyBuffer) -> MlmetricclassifyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_buffer_fill(s : MlmetricclassifyBuffer, v : Double) -> MlmetricclassifyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_buffer_min(s : MlmetricclassifyBuffer) -> Double { @_common.min(s.data) }

pub fn ml_metric_classify_buffer_max(s : MlmetricclassifyBuffer) -> Double { @_common.max(s.data) }

pub fn ml_metric_classify_buffer_to_string(s : MlmetricclassifyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_cursor_make(size : Int) -> MlmetricclassifyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_cursor_len(s : MlmetricclassifyCursor) -> Int { s.size }

pub fn ml_metric_classify_cursor_get(s : MlmetricclassifyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_cursor_set(s : MlmetricclassifyCursor, i : Int, v : Double) -> MlmetricclassifyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_cursor_sum(s : MlmetricclassifyCursor) -> Double { @_common.sum(s.data) }

pub fn ml_metric_classify_cursor_mean(s : MlmetricclassifyCursor) -> Double { @_common.mean(s.data) }

pub fn ml_metric_classify_cursor_scale(s : MlmetricclassifyCursor, f : Double) -> MlmetricclassifyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_cursor_add(a : MlmetricclassifyCursor, b : MlmetricclassifyCursor) -> MlmetricclassifyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_classify_cursor_copy(s : MlmetricclassifyCursor) -> MlmetricclassifyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_cursor_fill(s : MlmetricclassifyCursor, v : Double) -> MlmetricclassifyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_cursor_min(s : MlmetricclassifyCursor) -> Double { @_common.min(s.data) }

pub fn ml_metric_classify_cursor_max(s : MlmetricclassifyCursor) -> Double { @_common.max(s.data) }

pub fn ml_metric_classify_cursor_to_string(s : MlmetricclassifyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_view_make(size : Int) -> MlmetricclassifyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_view_len(s : MlmetricclassifyView) -> Int { s.size }

pub fn ml_metric_classify_view_get(s : MlmetricclassifyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_view_set(s : MlmetricclassifyView, i : Int, v : Double) -> MlmetricclassifyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_view_sum(s : MlmetricclassifyView) -> Double { @_common.sum(s.data) }

pub fn ml_metric_classify_view_mean(s : MlmetricclassifyView) -> Double { @_common.mean(s.data) }

pub fn ml_metric_classify_view_scale(s : MlmetricclassifyView, f : Double) -> MlmetricclassifyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_view_add(a : MlmetricclassifyView, b : MlmetricclassifyView) -> MlmetricclassifyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_classify_view_copy(s : MlmetricclassifyView) -> MlmetricclassifyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_view_fill(s : MlmetricclassifyView, v : Double) -> MlmetricclassifyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_view_min(s : MlmetricclassifyView) -> Double { @_common.min(s.data) }

pub fn ml_metric_classify_view_max(s : MlmetricclassifyView) -> Double { @_common.max(s.data) }

pub fn ml_metric_classify_view_to_string(s : MlmetricclassifyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_range_make(size : Int) -> MlmetricclassifyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_range_len(s : MlmetricclassifyRange) -> Int { s.size }

pub fn ml_metric_classify_range_get(s : MlmetricclassifyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_range_set(s : MlmetricclassifyRange, i : Int, v : Double) -> MlmetricclassifyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_range_sum(s : MlmetricclassifyRange) -> Double { @_common.sum(s.data) }

pub fn ml_metric_classify_range_mean(s : MlmetricclassifyRange) -> Double { @_common.mean(s.data) }

pub fn ml_metric_classify_range_scale(s : MlmetricclassifyRange, f : Double) -> MlmetricclassifyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_range_add(a : MlmetricclassifyRange, b : MlmetricclassifyRange) -> MlmetricclassifyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_classify_range_copy(s : MlmetricclassifyRange) -> MlmetricclassifyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_range_fill(s : MlmetricclassifyRange, v : Double) -> MlmetricclassifyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_range_min(s : MlmetricclassifyRange) -> Double { @_common.min(s.data) }

pub fn ml_metric_classify_range_max(s : MlmetricclassifyRange) -> Double { @_common.max(s.data) }

pub fn ml_metric_classify_range_to_string(s : MlmetricclassifyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_slice_make(size : Int) -> MlmetricclassifySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_slice_len(s : MlmetricclassifySlice) -> Int { s.size }

pub fn ml_metric_classify_slice_get(s : MlmetricclassifySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_slice_set(s : MlmetricclassifySlice, i : Int, v : Double) -> MlmetricclassifySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_slice_sum(s : MlmetricclassifySlice) -> Double { @_common.sum(s.data) }

pub fn ml_metric_classify_slice_mean(s : MlmetricclassifySlice) -> Double { @_common.mean(s.data) }

pub fn ml_metric_classify_slice_scale(s : MlmetricclassifySlice, f : Double) -> MlmetricclassifySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_slice_add(a : MlmetricclassifySlice, b : MlmetricclassifySlice) -> MlmetricclassifySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_classify_slice_copy(s : MlmetricclassifySlice) -> MlmetricclassifySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_slice_fill(s : MlmetricclassifySlice, v : Double) -> MlmetricclassifySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_classify_slice_min(s : MlmetricclassifySlice) -> Double { @_common.min(s.data) }

pub fn ml_metric_classify_slice_max(s : MlmetricclassifySlice) -> Double { @_common.max(s.data) }

pub fn ml_metric_classify_slice_to_string(s : MlmetricclassifySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

