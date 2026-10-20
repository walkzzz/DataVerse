///===
/// extcore/ml_classify_naive_bayes

pub(all) struct MlclassifynaivebayesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_naive_bayes_make_point(x : Double, y : Double) -> MlclassifynaivebayesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_naive_bayes_make_point3(x : Double, y : Double, z : Double) -> MlclassifynaivebayesPoint {
  { x, y, z, label: 0 }
}

pub fn MlclassifynaivebayesPoint::x(self : MlclassifynaivebayesPoint) -> Double { self.x }

pub fn MlclassifynaivebayesPoint::y(self : MlclassifynaivebayesPoint) -> Double { self.y }

pub fn MlclassifynaivebayesPoint::z(self : MlclassifynaivebayesPoint) -> Double { self.z }

pub fn MlclassifynaivebayesPoint::label(self : MlclassifynaivebayesPoint) -> Int { self.label }

pub fn MlclassifynaivebayesPoint::dist(self : MlclassifynaivebayesPoint, other : MlclassifynaivebayesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclassifynaivebayesPoint::add(self : MlclassifynaivebayesPoint, other : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclassifynaivebayesPoint::sub(self : MlclassifynaivebayesPoint, other : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclassifynaivebayesPoint::scale(self : MlclassifynaivebayesPoint, s : Double) -> MlclassifynaivebayesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclassifynaivebayesPoint::dot(self : MlclassifynaivebayesPoint, other : MlclassifynaivebayesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclassifynaivebayesPoint::cross(self : MlclassifynaivebayesPoint, other : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclassifynaivebayesPoint::norm(self : MlclassifynaivebayesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclassifynaivebayesPoint::normalize(self : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifynaivebayesPoint::negate(self : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclassifynaivebayesPoint::mid(self : MlclassifynaivebayesPoint, other : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclassifynaivebayesPoint::lerp(self : MlclassifynaivebayesPoint, other : MlclassifynaivebayesPoint, t : Double) -> MlclassifynaivebayesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclassifynaivebayesPoint::to_string(self : MlclassifynaivebayesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_naive_bayes_make_series(vals : Array[Double], name : String) -> MlclassifynaivebayesSeries {
  { vals, name, meta: 0 }
}

pub fn MlclassifynaivebayesSeries::len(self : MlclassifynaivebayesSeries) -> Int { self.vals.length() }

pub fn MlclassifynaivebayesSeries::sum(self : MlclassifynaivebayesSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclassifynaivebayesSeries::mean(self : MlclassifynaivebayesSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclassifynaivebayesSeries::min(self : MlclassifynaivebayesSeries) -> Double { @_common.min(self.vals) }

pub fn MlclassifynaivebayesSeries::max(self : MlclassifynaivebayesSeries) -> Double { @_common.max(self.vals) }

pub fn MlclassifynaivebayesSeries::range(self : MlclassifynaivebayesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclassifynaivebayesSeries::variance(self : MlclassifynaivebayesSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclassifynaivebayesSeries::std(self : MlclassifynaivebayesSeries) -> Double { @_common.std(self.vals) }

pub fn MlclassifynaivebayesSeries::median(self : MlclassifynaivebayesSeries) -> Double { @_common.median(self.vals) }

pub fn MlclassifynaivebayesSeries::scale(self : MlclassifynaivebayesSeries, f : Double) -> MlclassifynaivebayesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclassifynaivebayesSeries::add(self : MlclassifynaivebayesSeries, other : MlclassifynaivebayesSeries) -> MlclassifynaivebayesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclassifynaivebayesSeries::sub(self : MlclassifynaivebayesSeries, other : MlclassifynaivebayesSeries) -> MlclassifynaivebayesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclassifynaivebayesSeries::normalize(self : MlclassifynaivebayesSeries) -> MlclassifynaivebayesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclassifynaivebayesSeries::cumsum(self : MlclassifynaivebayesSeries) -> MlclassifynaivebayesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclassifynaivebayesSeries::to_string(self : MlclassifynaivebayesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifynaivebayesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_naive_bayes_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifynaivebayesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_naive_bayes_matrix_identity(n : Int) -> MlclassifynaivebayesMatrix {
  let m = ml_classify_naive_bayes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclassifynaivebayesMatrix::get(self : MlclassifynaivebayesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclassifynaivebayesMatrix::transpose(self : MlclassifynaivebayesMatrix) -> MlclassifynaivebayesMatrix {
  let result = ml_classify_naive_bayes_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclassifynaivebayesMatrix::add(self : MlclassifynaivebayesMatrix, other : MlclassifynaivebayesMatrix) -> MlclassifynaivebayesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_classify_naive_bayes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclassifynaivebayesMatrix::scale(self : MlclassifynaivebayesMatrix, s : Double) -> MlclassifynaivebayesMatrix {
  let result = ml_classify_naive_bayes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclassifynaivebayesMatrix::multiply(self : MlclassifynaivebayesMatrix, other : MlclassifynaivebayesMatrix) -> MlclassifynaivebayesMatrix {
  if self.cols != other.rows { return ml_classify_naive_bayes_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_classify_naive_bayes_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclassifynaivebayesMatrix::trace(self : MlclassifynaivebayesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclassifynaivebayesMatrix::det(self : MlclassifynaivebayesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclassifynaivebayesMatrix::norm(self : MlclassifynaivebayesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclassifynaivebayesMatrix::to_string(self : MlclassifynaivebayesMatrix) -> String {
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

pub(all) struct MlclassifynaivebayesVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_naive_bayes_make_vector(comps : Array[Double]) -> MlclassifynaivebayesVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_naive_bayes_vector_zero(dim : Int) -> MlclassifynaivebayesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclassifynaivebayesVector::add(self : MlclassifynaivebayesVector, other : MlclassifynaivebayesVector) -> MlclassifynaivebayesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifynaivebayesVector::sub(self : MlclassifynaivebayesVector, other : MlclassifynaivebayesVector) -> MlclassifynaivebayesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifynaivebayesVector::scale(self : MlclassifynaivebayesVector, s : Double) -> MlclassifynaivebayesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclassifynaivebayesVector::dot(self : MlclassifynaivebayesVector, other : MlclassifynaivebayesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclassifynaivebayesVector::norm(self : MlclassifynaivebayesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclassifynaivebayesVector::normalize(self : MlclassifynaivebayesVector) -> MlclassifynaivebayesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifynaivebayesVector::dist(self : MlclassifynaivebayesVector, other : MlclassifynaivebayesVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclassifynaivebayesVector::to_string(self : MlclassifynaivebayesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_naive_bayes_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_classify_naive_bayes_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_classify_naive_bayes_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_classify_naive_bayes_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_classify_naive_bayes_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_classify_naive_bayes_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_classify_naive_bayes_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_classify_naive_bayes_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_classify_naive_bayes_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_classify_naive_bayes_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_classify_naive_bayes_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_classify_naive_bayes_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_classify_naive_bayes_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_classify_naive_bayes_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_classify_naive_bayes_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_classify_naive_bayes_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_classify_naive_bayes_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_classify_naive_bayes_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_classify_naive_bayes_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_classify_naive_bayes_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_classify_naive_bayes_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_classify_naive_bayes_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_classify_naive_bayes_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_classify_naive_bayes_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_classify_naive_bayes_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_classify_naive_bayes_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_classify_naive_bayes_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_classify_naive_bayes_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_classify_naive_bayes_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclassifynaivebayesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_frame_make(size : Int) -> MlclassifynaivebayesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_frame_len(s : MlclassifynaivebayesFrame) -> Int { s.size }

pub fn ml_classify_naive_bayes_frame_get(s : MlclassifynaivebayesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_frame_set(s : MlclassifynaivebayesFrame, i : Int, v : Double) -> MlclassifynaivebayesFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_frame_sum(s : MlclassifynaivebayesFrame) -> Double { @_common.sum(s.data) }

pub fn ml_classify_naive_bayes_frame_mean(s : MlclassifynaivebayesFrame) -> Double { @_common.mean(s.data) }

pub fn ml_classify_naive_bayes_frame_scale(s : MlclassifynaivebayesFrame, f : Double) -> MlclassifynaivebayesFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_frame_add(a : MlclassifynaivebayesFrame, b : MlclassifynaivebayesFrame) -> MlclassifynaivebayesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_naive_bayes_frame_copy(s : MlclassifynaivebayesFrame) -> MlclassifynaivebayesFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_frame_fill(s : MlclassifynaivebayesFrame, v : Double) -> MlclassifynaivebayesFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_frame_min(s : MlclassifynaivebayesFrame) -> Double { @_common.min(s.data) }

pub fn ml_classify_naive_bayes_frame_max(s : MlclassifynaivebayesFrame) -> Double { @_common.max(s.data) }

pub fn ml_classify_naive_bayes_frame_to_string(s : MlclassifynaivebayesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_table_make(size : Int) -> MlclassifynaivebayesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_table_len(s : MlclassifynaivebayesTable) -> Int { s.size }

pub fn ml_classify_naive_bayes_table_get(s : MlclassifynaivebayesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_table_set(s : MlclassifynaivebayesTable, i : Int, v : Double) -> MlclassifynaivebayesTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_table_sum(s : MlclassifynaivebayesTable) -> Double { @_common.sum(s.data) }

pub fn ml_classify_naive_bayes_table_mean(s : MlclassifynaivebayesTable) -> Double { @_common.mean(s.data) }

pub fn ml_classify_naive_bayes_table_scale(s : MlclassifynaivebayesTable, f : Double) -> MlclassifynaivebayesTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_table_add(a : MlclassifynaivebayesTable, b : MlclassifynaivebayesTable) -> MlclassifynaivebayesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_naive_bayes_table_copy(s : MlclassifynaivebayesTable) -> MlclassifynaivebayesTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_table_fill(s : MlclassifynaivebayesTable, v : Double) -> MlclassifynaivebayesTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_table_min(s : MlclassifynaivebayesTable) -> Double { @_common.min(s.data) }

pub fn ml_classify_naive_bayes_table_max(s : MlclassifynaivebayesTable) -> Double { @_common.max(s.data) }

pub fn ml_classify_naive_bayes_table_to_string(s : MlclassifynaivebayesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_graphn_make(size : Int) -> MlclassifynaivebayesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_graphn_len(s : MlclassifynaivebayesGraphN) -> Int { s.size }

pub fn ml_classify_naive_bayes_graphn_get(s : MlclassifynaivebayesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_graphn_set(s : MlclassifynaivebayesGraphN, i : Int, v : Double) -> MlclassifynaivebayesGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_graphn_sum(s : MlclassifynaivebayesGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_classify_naive_bayes_graphn_mean(s : MlclassifynaivebayesGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_classify_naive_bayes_graphn_scale(s : MlclassifynaivebayesGraphN, f : Double) -> MlclassifynaivebayesGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_graphn_add(a : MlclassifynaivebayesGraphN, b : MlclassifynaivebayesGraphN) -> MlclassifynaivebayesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_naive_bayes_graphn_copy(s : MlclassifynaivebayesGraphN) -> MlclassifynaivebayesGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_graphn_fill(s : MlclassifynaivebayesGraphN, v : Double) -> MlclassifynaivebayesGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_graphn_min(s : MlclassifynaivebayesGraphN) -> Double { @_common.min(s.data) }

pub fn ml_classify_naive_bayes_graphn_max(s : MlclassifynaivebayesGraphN) -> Double { @_common.max(s.data) }

pub fn ml_classify_naive_bayes_graphn_to_string(s : MlclassifynaivebayesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_node_make(size : Int) -> MlclassifynaivebayesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_node_len(s : MlclassifynaivebayesNode) -> Int { s.size }

pub fn ml_classify_naive_bayes_node_get(s : MlclassifynaivebayesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_node_set(s : MlclassifynaivebayesNode, i : Int, v : Double) -> MlclassifynaivebayesNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_node_sum(s : MlclassifynaivebayesNode) -> Double { @_common.sum(s.data) }

pub fn ml_classify_naive_bayes_node_mean(s : MlclassifynaivebayesNode) -> Double { @_common.mean(s.data) }

pub fn ml_classify_naive_bayes_node_scale(s : MlclassifynaivebayesNode, f : Double) -> MlclassifynaivebayesNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_node_add(a : MlclassifynaivebayesNode, b : MlclassifynaivebayesNode) -> MlclassifynaivebayesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_naive_bayes_node_copy(s : MlclassifynaivebayesNode) -> MlclassifynaivebayesNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_node_fill(s : MlclassifynaivebayesNode, v : Double) -> MlclassifynaivebayesNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_node_min(s : MlclassifynaivebayesNode) -> Double { @_common.min(s.data) }

pub fn ml_classify_naive_bayes_node_max(s : MlclassifynaivebayesNode) -> Double { @_common.max(s.data) }

pub fn ml_classify_naive_bayes_node_to_string(s : MlclassifynaivebayesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_edge_make(size : Int) -> MlclassifynaivebayesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_edge_len(s : MlclassifynaivebayesEdge) -> Int { s.size }

pub fn ml_classify_naive_bayes_edge_get(s : MlclassifynaivebayesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_edge_set(s : MlclassifynaivebayesEdge, i : Int, v : Double) -> MlclassifynaivebayesEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_edge_sum(s : MlclassifynaivebayesEdge) -> Double { @_common.sum(s.data) }

pub fn ml_classify_naive_bayes_edge_mean(s : MlclassifynaivebayesEdge) -> Double { @_common.mean(s.data) }

pub fn ml_classify_naive_bayes_edge_scale(s : MlclassifynaivebayesEdge, f : Double) -> MlclassifynaivebayesEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_edge_add(a : MlclassifynaivebayesEdge, b : MlclassifynaivebayesEdge) -> MlclassifynaivebayesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_naive_bayes_edge_copy(s : MlclassifynaivebayesEdge) -> MlclassifynaivebayesEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_edge_fill(s : MlclassifynaivebayesEdge, v : Double) -> MlclassifynaivebayesEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_edge_min(s : MlclassifynaivebayesEdge) -> Double { @_common.min(s.data) }

pub fn ml_classify_naive_bayes_edge_max(s : MlclassifynaivebayesEdge) -> Double { @_common.max(s.data) }

pub fn ml_classify_naive_bayes_edge_to_string(s : MlclassifynaivebayesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_path_make(size : Int) -> MlclassifynaivebayesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_path_len(s : MlclassifynaivebayesPath) -> Int { s.size }

pub fn ml_classify_naive_bayes_path_get(s : MlclassifynaivebayesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_path_set(s : MlclassifynaivebayesPath, i : Int, v : Double) -> MlclassifynaivebayesPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_path_sum(s : MlclassifynaivebayesPath) -> Double { @_common.sum(s.data) }

pub fn ml_classify_naive_bayes_path_mean(s : MlclassifynaivebayesPath) -> Double { @_common.mean(s.data) }

pub fn ml_classify_naive_bayes_path_scale(s : MlclassifynaivebayesPath, f : Double) -> MlclassifynaivebayesPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_path_add(a : MlclassifynaivebayesPath, b : MlclassifynaivebayesPath) -> MlclassifynaivebayesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_naive_bayes_path_copy(s : MlclassifynaivebayesPath) -> MlclassifynaivebayesPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_path_fill(s : MlclassifynaivebayesPath, v : Double) -> MlclassifynaivebayesPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_path_min(s : MlclassifynaivebayesPath) -> Double { @_common.min(s.data) }

pub fn ml_classify_naive_bayes_path_max(s : MlclassifynaivebayesPath) -> Double { @_common.max(s.data) }

pub fn ml_classify_naive_bayes_path_to_string(s : MlclassifynaivebayesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_cluster_make(size : Int) -> MlclassifynaivebayesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_cluster_len(s : MlclassifynaivebayesCluster) -> Int { s.size }

pub fn ml_classify_naive_bayes_cluster_get(s : MlclassifynaivebayesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_cluster_set(s : MlclassifynaivebayesCluster, i : Int, v : Double) -> MlclassifynaivebayesCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_cluster_sum(s : MlclassifynaivebayesCluster) -> Double { @_common.sum(s.data) }

pub fn ml_classify_naive_bayes_cluster_mean(s : MlclassifynaivebayesCluster) -> Double { @_common.mean(s.data) }

pub fn ml_classify_naive_bayes_cluster_scale(s : MlclassifynaivebayesCluster, f : Double) -> MlclassifynaivebayesCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_cluster_add(a : MlclassifynaivebayesCluster, b : MlclassifynaivebayesCluster) -> MlclassifynaivebayesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_naive_bayes_cluster_copy(s : MlclassifynaivebayesCluster) -> MlclassifynaivebayesCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_cluster_fill(s : MlclassifynaivebayesCluster, v : Double) -> MlclassifynaivebayesCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_cluster_min(s : MlclassifynaivebayesCluster) -> Double { @_common.min(s.data) }

pub fn ml_classify_naive_bayes_cluster_max(s : MlclassifynaivebayesCluster) -> Double { @_common.max(s.data) }

pub fn ml_classify_naive_bayes_cluster_to_string(s : MlclassifynaivebayesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_model_make(size : Int) -> MlclassifynaivebayesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_model_len(s : MlclassifynaivebayesModel) -> Int { s.size }

pub fn ml_classify_naive_bayes_model_get(s : MlclassifynaivebayesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_model_set(s : MlclassifynaivebayesModel, i : Int, v : Double) -> MlclassifynaivebayesModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_model_sum(s : MlclassifynaivebayesModel) -> Double { @_common.sum(s.data) }

pub fn ml_classify_naive_bayes_model_mean(s : MlclassifynaivebayesModel) -> Double { @_common.mean(s.data) }

pub fn ml_classify_naive_bayes_model_scale(s : MlclassifynaivebayesModel, f : Double) -> MlclassifynaivebayesModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_model_add(a : MlclassifynaivebayesModel, b : MlclassifynaivebayesModel) -> MlclassifynaivebayesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_naive_bayes_model_copy(s : MlclassifynaivebayesModel) -> MlclassifynaivebayesModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_model_fill(s : MlclassifynaivebayesModel, v : Double) -> MlclassifynaivebayesModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_model_min(s : MlclassifynaivebayesModel) -> Double { @_common.min(s.data) }

pub fn ml_classify_naive_bayes_model_max(s : MlclassifynaivebayesModel) -> Double { @_common.max(s.data) }

pub fn ml_classify_naive_bayes_model_to_string(s : MlclassifynaivebayesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_layer_make(size : Int) -> MlclassifynaivebayesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_layer_len(s : MlclassifynaivebayesLayer) -> Int { s.size }

pub fn ml_classify_naive_bayes_layer_get(s : MlclassifynaivebayesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_layer_set(s : MlclassifynaivebayesLayer, i : Int, v : Double) -> MlclassifynaivebayesLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_layer_sum(s : MlclassifynaivebayesLayer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_naive_bayes_layer_mean(s : MlclassifynaivebayesLayer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_naive_bayes_layer_scale(s : MlclassifynaivebayesLayer, f : Double) -> MlclassifynaivebayesLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_layer_add(a : MlclassifynaivebayesLayer, b : MlclassifynaivebayesLayer) -> MlclassifynaivebayesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_naive_bayes_layer_copy(s : MlclassifynaivebayesLayer) -> MlclassifynaivebayesLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_layer_fill(s : MlclassifynaivebayesLayer, v : Double) -> MlclassifynaivebayesLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_layer_min(s : MlclassifynaivebayesLayer) -> Double { @_common.min(s.data) }

pub fn ml_classify_naive_bayes_layer_max(s : MlclassifynaivebayesLayer) -> Double { @_common.max(s.data) }

pub fn ml_classify_naive_bayes_layer_to_string(s : MlclassifynaivebayesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_buffer_make(size : Int) -> MlclassifynaivebayesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_buffer_len(s : MlclassifynaivebayesBuffer) -> Int { s.size }

pub fn ml_classify_naive_bayes_buffer_get(s : MlclassifynaivebayesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_buffer_set(s : MlclassifynaivebayesBuffer, i : Int, v : Double) -> MlclassifynaivebayesBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_buffer_sum(s : MlclassifynaivebayesBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_naive_bayes_buffer_mean(s : MlclassifynaivebayesBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_naive_bayes_buffer_scale(s : MlclassifynaivebayesBuffer, f : Double) -> MlclassifynaivebayesBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_buffer_add(a : MlclassifynaivebayesBuffer, b : MlclassifynaivebayesBuffer) -> MlclassifynaivebayesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_naive_bayes_buffer_copy(s : MlclassifynaivebayesBuffer) -> MlclassifynaivebayesBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_buffer_fill(s : MlclassifynaivebayesBuffer, v : Double) -> MlclassifynaivebayesBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_buffer_min(s : MlclassifynaivebayesBuffer) -> Double { @_common.min(s.data) }

pub fn ml_classify_naive_bayes_buffer_max(s : MlclassifynaivebayesBuffer) -> Double { @_common.max(s.data) }

pub fn ml_classify_naive_bayes_buffer_to_string(s : MlclassifynaivebayesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_cursor_make(size : Int) -> MlclassifynaivebayesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_cursor_len(s : MlclassifynaivebayesCursor) -> Int { s.size }

pub fn ml_classify_naive_bayes_cursor_get(s : MlclassifynaivebayesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_cursor_set(s : MlclassifynaivebayesCursor, i : Int, v : Double) -> MlclassifynaivebayesCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_cursor_sum(s : MlclassifynaivebayesCursor) -> Double { @_common.sum(s.data) }

pub fn ml_classify_naive_bayes_cursor_mean(s : MlclassifynaivebayesCursor) -> Double { @_common.mean(s.data) }

pub fn ml_classify_naive_bayes_cursor_scale(s : MlclassifynaivebayesCursor, f : Double) -> MlclassifynaivebayesCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_cursor_add(a : MlclassifynaivebayesCursor, b : MlclassifynaivebayesCursor) -> MlclassifynaivebayesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_naive_bayes_cursor_copy(s : MlclassifynaivebayesCursor) -> MlclassifynaivebayesCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_cursor_fill(s : MlclassifynaivebayesCursor, v : Double) -> MlclassifynaivebayesCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_cursor_min(s : MlclassifynaivebayesCursor) -> Double { @_common.min(s.data) }

pub fn ml_classify_naive_bayes_cursor_max(s : MlclassifynaivebayesCursor) -> Double { @_common.max(s.data) }

pub fn ml_classify_naive_bayes_cursor_to_string(s : MlclassifynaivebayesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_view_make(size : Int) -> MlclassifynaivebayesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_view_len(s : MlclassifynaivebayesView) -> Int { s.size }

pub fn ml_classify_naive_bayes_view_get(s : MlclassifynaivebayesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_view_set(s : MlclassifynaivebayesView, i : Int, v : Double) -> MlclassifynaivebayesView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_view_sum(s : MlclassifynaivebayesView) -> Double { @_common.sum(s.data) }

pub fn ml_classify_naive_bayes_view_mean(s : MlclassifynaivebayesView) -> Double { @_common.mean(s.data) }

pub fn ml_classify_naive_bayes_view_scale(s : MlclassifynaivebayesView, f : Double) -> MlclassifynaivebayesView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_view_add(a : MlclassifynaivebayesView, b : MlclassifynaivebayesView) -> MlclassifynaivebayesView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_naive_bayes_view_copy(s : MlclassifynaivebayesView) -> MlclassifynaivebayesView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_view_fill(s : MlclassifynaivebayesView, v : Double) -> MlclassifynaivebayesView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_view_min(s : MlclassifynaivebayesView) -> Double { @_common.min(s.data) }

pub fn ml_classify_naive_bayes_view_max(s : MlclassifynaivebayesView) -> Double { @_common.max(s.data) }

pub fn ml_classify_naive_bayes_view_to_string(s : MlclassifynaivebayesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_range_make(size : Int) -> MlclassifynaivebayesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_range_len(s : MlclassifynaivebayesRange) -> Int { s.size }

pub fn ml_classify_naive_bayes_range_get(s : MlclassifynaivebayesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_range_set(s : MlclassifynaivebayesRange, i : Int, v : Double) -> MlclassifynaivebayesRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_range_sum(s : MlclassifynaivebayesRange) -> Double { @_common.sum(s.data) }

pub fn ml_classify_naive_bayes_range_mean(s : MlclassifynaivebayesRange) -> Double { @_common.mean(s.data) }

pub fn ml_classify_naive_bayes_range_scale(s : MlclassifynaivebayesRange, f : Double) -> MlclassifynaivebayesRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_range_add(a : MlclassifynaivebayesRange, b : MlclassifynaivebayesRange) -> MlclassifynaivebayesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_naive_bayes_range_copy(s : MlclassifynaivebayesRange) -> MlclassifynaivebayesRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_range_fill(s : MlclassifynaivebayesRange, v : Double) -> MlclassifynaivebayesRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_range_min(s : MlclassifynaivebayesRange) -> Double { @_common.min(s.data) }

pub fn ml_classify_naive_bayes_range_max(s : MlclassifynaivebayesRange) -> Double { @_common.max(s.data) }

pub fn ml_classify_naive_bayes_range_to_string(s : MlclassifynaivebayesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_slice_make(size : Int) -> MlclassifynaivebayesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_slice_len(s : MlclassifynaivebayesSlice) -> Int { s.size }

pub fn ml_classify_naive_bayes_slice_get(s : MlclassifynaivebayesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_slice_set(s : MlclassifynaivebayesSlice, i : Int, v : Double) -> MlclassifynaivebayesSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_slice_sum(s : MlclassifynaivebayesSlice) -> Double { @_common.sum(s.data) }

pub fn ml_classify_naive_bayes_slice_mean(s : MlclassifynaivebayesSlice) -> Double { @_common.mean(s.data) }

pub fn ml_classify_naive_bayes_slice_scale(s : MlclassifynaivebayesSlice, f : Double) -> MlclassifynaivebayesSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_slice_add(a : MlclassifynaivebayesSlice, b : MlclassifynaivebayesSlice) -> MlclassifynaivebayesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_naive_bayes_slice_copy(s : MlclassifynaivebayesSlice) -> MlclassifynaivebayesSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_slice_fill(s : MlclassifynaivebayesSlice, v : Double) -> MlclassifynaivebayesSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_naive_bayes_slice_min(s : MlclassifynaivebayesSlice) -> Double { @_common.min(s.data) }

pub fn ml_classify_naive_bayes_slice_max(s : MlclassifynaivebayesSlice) -> Double { @_common.max(s.data) }

pub fn ml_classify_naive_bayes_slice_to_string(s : MlclassifynaivebayesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

