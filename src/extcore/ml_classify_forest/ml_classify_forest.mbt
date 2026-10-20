///===
/// extcore/ml_classify_forest

pub(all) struct MlclassifyforestPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_forest_make_point(x : Double, y : Double) -> MlclassifyforestPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_forest_make_point3(x : Double, y : Double, z : Double) -> MlclassifyforestPoint {
  { x, y, z, label: 0 }
}

pub fn MlclassifyforestPoint::x(self : MlclassifyforestPoint) -> Double { self.x }

pub fn MlclassifyforestPoint::y(self : MlclassifyforestPoint) -> Double { self.y }

pub fn MlclassifyforestPoint::z(self : MlclassifyforestPoint) -> Double { self.z }

pub fn MlclassifyforestPoint::label(self : MlclassifyforestPoint) -> Int { self.label }

pub fn MlclassifyforestPoint::dist(self : MlclassifyforestPoint, other : MlclassifyforestPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclassifyforestPoint::add(self : MlclassifyforestPoint, other : MlclassifyforestPoint) -> MlclassifyforestPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclassifyforestPoint::sub(self : MlclassifyforestPoint, other : MlclassifyforestPoint) -> MlclassifyforestPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclassifyforestPoint::scale(self : MlclassifyforestPoint, s : Double) -> MlclassifyforestPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclassifyforestPoint::dot(self : MlclassifyforestPoint, other : MlclassifyforestPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclassifyforestPoint::cross(self : MlclassifyforestPoint, other : MlclassifyforestPoint) -> MlclassifyforestPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclassifyforestPoint::norm(self : MlclassifyforestPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclassifyforestPoint::normalize(self : MlclassifyforestPoint) -> MlclassifyforestPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyforestPoint::negate(self : MlclassifyforestPoint) -> MlclassifyforestPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclassifyforestPoint::mid(self : MlclassifyforestPoint, other : MlclassifyforestPoint) -> MlclassifyforestPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclassifyforestPoint::lerp(self : MlclassifyforestPoint, other : MlclassifyforestPoint, t : Double) -> MlclassifyforestPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclassifyforestPoint::to_string(self : MlclassifyforestPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclassifyforestSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_forest_make_series(vals : Array[Double], name : String) -> MlclassifyforestSeries {
  { vals, name, meta: 0 }
}

pub fn MlclassifyforestSeries::len(self : MlclassifyforestSeries) -> Int { self.vals.length() }

pub fn MlclassifyforestSeries::sum(self : MlclassifyforestSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclassifyforestSeries::mean(self : MlclassifyforestSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclassifyforestSeries::min(self : MlclassifyforestSeries) -> Double { @_common.min(self.vals) }

pub fn MlclassifyforestSeries::max(self : MlclassifyforestSeries) -> Double { @_common.max(self.vals) }

pub fn MlclassifyforestSeries::range(self : MlclassifyforestSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclassifyforestSeries::variance(self : MlclassifyforestSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclassifyforestSeries::std(self : MlclassifyforestSeries) -> Double { @_common.std(self.vals) }

pub fn MlclassifyforestSeries::median(self : MlclassifyforestSeries) -> Double { @_common.median(self.vals) }

pub fn MlclassifyforestSeries::scale(self : MlclassifyforestSeries, f : Double) -> MlclassifyforestSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclassifyforestSeries::add(self : MlclassifyforestSeries, other : MlclassifyforestSeries) -> MlclassifyforestSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclassifyforestSeries::sub(self : MlclassifyforestSeries, other : MlclassifyforestSeries) -> MlclassifyforestSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclassifyforestSeries::normalize(self : MlclassifyforestSeries) -> MlclassifyforestSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclassifyforestSeries::cumsum(self : MlclassifyforestSeries) -> MlclassifyforestSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclassifyforestSeries::to_string(self : MlclassifyforestSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyforestMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_forest_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyforestMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_forest_matrix_identity(n : Int) -> MlclassifyforestMatrix {
  let m = ml_classify_forest_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclassifyforestMatrix::get(self : MlclassifyforestMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclassifyforestMatrix::transpose(self : MlclassifyforestMatrix) -> MlclassifyforestMatrix {
  let result = ml_classify_forest_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclassifyforestMatrix::add(self : MlclassifyforestMatrix, other : MlclassifyforestMatrix) -> MlclassifyforestMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_classify_forest_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclassifyforestMatrix::scale(self : MlclassifyforestMatrix, s : Double) -> MlclassifyforestMatrix {
  let result = ml_classify_forest_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclassifyforestMatrix::multiply(self : MlclassifyforestMatrix, other : MlclassifyforestMatrix) -> MlclassifyforestMatrix {
  if self.cols != other.rows { return ml_classify_forest_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_classify_forest_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclassifyforestMatrix::trace(self : MlclassifyforestMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclassifyforestMatrix::det(self : MlclassifyforestMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclassifyforestMatrix::norm(self : MlclassifyforestMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclassifyforestMatrix::to_string(self : MlclassifyforestMatrix) -> String {
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

pub(all) struct MlclassifyforestVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_forest_make_vector(comps : Array[Double]) -> MlclassifyforestVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_forest_vector_zero(dim : Int) -> MlclassifyforestVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclassifyforestVector::add(self : MlclassifyforestVector, other : MlclassifyforestVector) -> MlclassifyforestVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyforestVector::sub(self : MlclassifyforestVector, other : MlclassifyforestVector) -> MlclassifyforestVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyforestVector::scale(self : MlclassifyforestVector, s : Double) -> MlclassifyforestVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclassifyforestVector::dot(self : MlclassifyforestVector, other : MlclassifyforestVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclassifyforestVector::norm(self : MlclassifyforestVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclassifyforestVector::normalize(self : MlclassifyforestVector) -> MlclassifyforestVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyforestVector::dist(self : MlclassifyforestVector, other : MlclassifyforestVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclassifyforestVector::to_string(self : MlclassifyforestVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_forest_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_classify_forest_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_classify_forest_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_classify_forest_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_classify_forest_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_classify_forest_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_classify_forest_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_classify_forest_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_classify_forest_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_classify_forest_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_classify_forest_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_classify_forest_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_classify_forest_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_classify_forest_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_classify_forest_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_classify_forest_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_classify_forest_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_classify_forest_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_classify_forest_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_classify_forest_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_classify_forest_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_classify_forest_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_classify_forest_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_classify_forest_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_classify_forest_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_classify_forest_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_classify_forest_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_classify_forest_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_classify_forest_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclassifyforestFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_frame_make(size : Int) -> MlclassifyforestFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_frame_len(s : MlclassifyforestFrame) -> Int { s.size }

pub fn ml_classify_forest_frame_get(s : MlclassifyforestFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_frame_set(s : MlclassifyforestFrame, i : Int, v : Double) -> MlclassifyforestFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_frame_sum(s : MlclassifyforestFrame) -> Double { @_common.sum(s.data) }

pub fn ml_classify_forest_frame_mean(s : MlclassifyforestFrame) -> Double { @_common.mean(s.data) }

pub fn ml_classify_forest_frame_scale(s : MlclassifyforestFrame, f : Double) -> MlclassifyforestFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_frame_add(a : MlclassifyforestFrame, b : MlclassifyforestFrame) -> MlclassifyforestFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_forest_frame_copy(s : MlclassifyforestFrame) -> MlclassifyforestFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_frame_fill(s : MlclassifyforestFrame, v : Double) -> MlclassifyforestFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_frame_min(s : MlclassifyforestFrame) -> Double { @_common.min(s.data) }

pub fn ml_classify_forest_frame_max(s : MlclassifyforestFrame) -> Double { @_common.max(s.data) }

pub fn ml_classify_forest_frame_to_string(s : MlclassifyforestFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_table_make(size : Int) -> MlclassifyforestTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_table_len(s : MlclassifyforestTable) -> Int { s.size }

pub fn ml_classify_forest_table_get(s : MlclassifyforestTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_table_set(s : MlclassifyforestTable, i : Int, v : Double) -> MlclassifyforestTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_table_sum(s : MlclassifyforestTable) -> Double { @_common.sum(s.data) }

pub fn ml_classify_forest_table_mean(s : MlclassifyforestTable) -> Double { @_common.mean(s.data) }

pub fn ml_classify_forest_table_scale(s : MlclassifyforestTable, f : Double) -> MlclassifyforestTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_table_add(a : MlclassifyforestTable, b : MlclassifyforestTable) -> MlclassifyforestTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_forest_table_copy(s : MlclassifyforestTable) -> MlclassifyforestTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_table_fill(s : MlclassifyforestTable, v : Double) -> MlclassifyforestTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_table_min(s : MlclassifyforestTable) -> Double { @_common.min(s.data) }

pub fn ml_classify_forest_table_max(s : MlclassifyforestTable) -> Double { @_common.max(s.data) }

pub fn ml_classify_forest_table_to_string(s : MlclassifyforestTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_graphn_make(size : Int) -> MlclassifyforestGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_graphn_len(s : MlclassifyforestGraphN) -> Int { s.size }

pub fn ml_classify_forest_graphn_get(s : MlclassifyforestGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_graphn_set(s : MlclassifyforestGraphN, i : Int, v : Double) -> MlclassifyforestGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_graphn_sum(s : MlclassifyforestGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_classify_forest_graphn_mean(s : MlclassifyforestGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_classify_forest_graphn_scale(s : MlclassifyforestGraphN, f : Double) -> MlclassifyforestGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_graphn_add(a : MlclassifyforestGraphN, b : MlclassifyforestGraphN) -> MlclassifyforestGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_forest_graphn_copy(s : MlclassifyforestGraphN) -> MlclassifyforestGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_graphn_fill(s : MlclassifyforestGraphN, v : Double) -> MlclassifyforestGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_graphn_min(s : MlclassifyforestGraphN) -> Double { @_common.min(s.data) }

pub fn ml_classify_forest_graphn_max(s : MlclassifyforestGraphN) -> Double { @_common.max(s.data) }

pub fn ml_classify_forest_graphn_to_string(s : MlclassifyforestGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_node_make(size : Int) -> MlclassifyforestNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_node_len(s : MlclassifyforestNode) -> Int { s.size }

pub fn ml_classify_forest_node_get(s : MlclassifyforestNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_node_set(s : MlclassifyforestNode, i : Int, v : Double) -> MlclassifyforestNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_node_sum(s : MlclassifyforestNode) -> Double { @_common.sum(s.data) }

pub fn ml_classify_forest_node_mean(s : MlclassifyforestNode) -> Double { @_common.mean(s.data) }

pub fn ml_classify_forest_node_scale(s : MlclassifyforestNode, f : Double) -> MlclassifyforestNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_node_add(a : MlclassifyforestNode, b : MlclassifyforestNode) -> MlclassifyforestNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_forest_node_copy(s : MlclassifyforestNode) -> MlclassifyforestNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_node_fill(s : MlclassifyforestNode, v : Double) -> MlclassifyforestNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_node_min(s : MlclassifyforestNode) -> Double { @_common.min(s.data) }

pub fn ml_classify_forest_node_max(s : MlclassifyforestNode) -> Double { @_common.max(s.data) }

pub fn ml_classify_forest_node_to_string(s : MlclassifyforestNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_edge_make(size : Int) -> MlclassifyforestEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_edge_len(s : MlclassifyforestEdge) -> Int { s.size }

pub fn ml_classify_forest_edge_get(s : MlclassifyforestEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_edge_set(s : MlclassifyforestEdge, i : Int, v : Double) -> MlclassifyforestEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_edge_sum(s : MlclassifyforestEdge) -> Double { @_common.sum(s.data) }

pub fn ml_classify_forest_edge_mean(s : MlclassifyforestEdge) -> Double { @_common.mean(s.data) }

pub fn ml_classify_forest_edge_scale(s : MlclassifyforestEdge, f : Double) -> MlclassifyforestEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_edge_add(a : MlclassifyforestEdge, b : MlclassifyforestEdge) -> MlclassifyforestEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_forest_edge_copy(s : MlclassifyforestEdge) -> MlclassifyforestEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_edge_fill(s : MlclassifyforestEdge, v : Double) -> MlclassifyforestEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_edge_min(s : MlclassifyforestEdge) -> Double { @_common.min(s.data) }

pub fn ml_classify_forest_edge_max(s : MlclassifyforestEdge) -> Double { @_common.max(s.data) }

pub fn ml_classify_forest_edge_to_string(s : MlclassifyforestEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_path_make(size : Int) -> MlclassifyforestPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_path_len(s : MlclassifyforestPath) -> Int { s.size }

pub fn ml_classify_forest_path_get(s : MlclassifyforestPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_path_set(s : MlclassifyforestPath, i : Int, v : Double) -> MlclassifyforestPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_path_sum(s : MlclassifyforestPath) -> Double { @_common.sum(s.data) }

pub fn ml_classify_forest_path_mean(s : MlclassifyforestPath) -> Double { @_common.mean(s.data) }

pub fn ml_classify_forest_path_scale(s : MlclassifyforestPath, f : Double) -> MlclassifyforestPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_path_add(a : MlclassifyforestPath, b : MlclassifyforestPath) -> MlclassifyforestPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_forest_path_copy(s : MlclassifyforestPath) -> MlclassifyforestPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_path_fill(s : MlclassifyforestPath, v : Double) -> MlclassifyforestPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_path_min(s : MlclassifyforestPath) -> Double { @_common.min(s.data) }

pub fn ml_classify_forest_path_max(s : MlclassifyforestPath) -> Double { @_common.max(s.data) }

pub fn ml_classify_forest_path_to_string(s : MlclassifyforestPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_cluster_make(size : Int) -> MlclassifyforestCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_cluster_len(s : MlclassifyforestCluster) -> Int { s.size }

pub fn ml_classify_forest_cluster_get(s : MlclassifyforestCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_cluster_set(s : MlclassifyforestCluster, i : Int, v : Double) -> MlclassifyforestCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_cluster_sum(s : MlclassifyforestCluster) -> Double { @_common.sum(s.data) }

pub fn ml_classify_forest_cluster_mean(s : MlclassifyforestCluster) -> Double { @_common.mean(s.data) }

pub fn ml_classify_forest_cluster_scale(s : MlclassifyforestCluster, f : Double) -> MlclassifyforestCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_cluster_add(a : MlclassifyforestCluster, b : MlclassifyforestCluster) -> MlclassifyforestCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_forest_cluster_copy(s : MlclassifyforestCluster) -> MlclassifyforestCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_cluster_fill(s : MlclassifyforestCluster, v : Double) -> MlclassifyforestCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_cluster_min(s : MlclassifyforestCluster) -> Double { @_common.min(s.data) }

pub fn ml_classify_forest_cluster_max(s : MlclassifyforestCluster) -> Double { @_common.max(s.data) }

pub fn ml_classify_forest_cluster_to_string(s : MlclassifyforestCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_model_make(size : Int) -> MlclassifyforestModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_model_len(s : MlclassifyforestModel) -> Int { s.size }

pub fn ml_classify_forest_model_get(s : MlclassifyforestModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_model_set(s : MlclassifyforestModel, i : Int, v : Double) -> MlclassifyforestModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_model_sum(s : MlclassifyforestModel) -> Double { @_common.sum(s.data) }

pub fn ml_classify_forest_model_mean(s : MlclassifyforestModel) -> Double { @_common.mean(s.data) }

pub fn ml_classify_forest_model_scale(s : MlclassifyforestModel, f : Double) -> MlclassifyforestModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_model_add(a : MlclassifyforestModel, b : MlclassifyforestModel) -> MlclassifyforestModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_forest_model_copy(s : MlclassifyforestModel) -> MlclassifyforestModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_model_fill(s : MlclassifyforestModel, v : Double) -> MlclassifyforestModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_model_min(s : MlclassifyforestModel) -> Double { @_common.min(s.data) }

pub fn ml_classify_forest_model_max(s : MlclassifyforestModel) -> Double { @_common.max(s.data) }

pub fn ml_classify_forest_model_to_string(s : MlclassifyforestModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_layer_make(size : Int) -> MlclassifyforestLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_layer_len(s : MlclassifyforestLayer) -> Int { s.size }

pub fn ml_classify_forest_layer_get(s : MlclassifyforestLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_layer_set(s : MlclassifyforestLayer, i : Int, v : Double) -> MlclassifyforestLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_layer_sum(s : MlclassifyforestLayer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_forest_layer_mean(s : MlclassifyforestLayer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_forest_layer_scale(s : MlclassifyforestLayer, f : Double) -> MlclassifyforestLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_layer_add(a : MlclassifyforestLayer, b : MlclassifyforestLayer) -> MlclassifyforestLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_forest_layer_copy(s : MlclassifyforestLayer) -> MlclassifyforestLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_layer_fill(s : MlclassifyforestLayer, v : Double) -> MlclassifyforestLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_layer_min(s : MlclassifyforestLayer) -> Double { @_common.min(s.data) }

pub fn ml_classify_forest_layer_max(s : MlclassifyforestLayer) -> Double { @_common.max(s.data) }

pub fn ml_classify_forest_layer_to_string(s : MlclassifyforestLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_buffer_make(size : Int) -> MlclassifyforestBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_buffer_len(s : MlclassifyforestBuffer) -> Int { s.size }

pub fn ml_classify_forest_buffer_get(s : MlclassifyforestBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_buffer_set(s : MlclassifyforestBuffer, i : Int, v : Double) -> MlclassifyforestBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_buffer_sum(s : MlclassifyforestBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_forest_buffer_mean(s : MlclassifyforestBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_forest_buffer_scale(s : MlclassifyforestBuffer, f : Double) -> MlclassifyforestBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_buffer_add(a : MlclassifyforestBuffer, b : MlclassifyforestBuffer) -> MlclassifyforestBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_forest_buffer_copy(s : MlclassifyforestBuffer) -> MlclassifyforestBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_buffer_fill(s : MlclassifyforestBuffer, v : Double) -> MlclassifyforestBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_buffer_min(s : MlclassifyforestBuffer) -> Double { @_common.min(s.data) }

pub fn ml_classify_forest_buffer_max(s : MlclassifyforestBuffer) -> Double { @_common.max(s.data) }

pub fn ml_classify_forest_buffer_to_string(s : MlclassifyforestBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_cursor_make(size : Int) -> MlclassifyforestCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_cursor_len(s : MlclassifyforestCursor) -> Int { s.size }

pub fn ml_classify_forest_cursor_get(s : MlclassifyforestCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_cursor_set(s : MlclassifyforestCursor, i : Int, v : Double) -> MlclassifyforestCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_cursor_sum(s : MlclassifyforestCursor) -> Double { @_common.sum(s.data) }

pub fn ml_classify_forest_cursor_mean(s : MlclassifyforestCursor) -> Double { @_common.mean(s.data) }

pub fn ml_classify_forest_cursor_scale(s : MlclassifyforestCursor, f : Double) -> MlclassifyforestCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_cursor_add(a : MlclassifyforestCursor, b : MlclassifyforestCursor) -> MlclassifyforestCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_forest_cursor_copy(s : MlclassifyforestCursor) -> MlclassifyforestCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_cursor_fill(s : MlclassifyforestCursor, v : Double) -> MlclassifyforestCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_cursor_min(s : MlclassifyforestCursor) -> Double { @_common.min(s.data) }

pub fn ml_classify_forest_cursor_max(s : MlclassifyforestCursor) -> Double { @_common.max(s.data) }

pub fn ml_classify_forest_cursor_to_string(s : MlclassifyforestCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_view_make(size : Int) -> MlclassifyforestView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_view_len(s : MlclassifyforestView) -> Int { s.size }

pub fn ml_classify_forest_view_get(s : MlclassifyforestView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_view_set(s : MlclassifyforestView, i : Int, v : Double) -> MlclassifyforestView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_view_sum(s : MlclassifyforestView) -> Double { @_common.sum(s.data) }

pub fn ml_classify_forest_view_mean(s : MlclassifyforestView) -> Double { @_common.mean(s.data) }

pub fn ml_classify_forest_view_scale(s : MlclassifyforestView, f : Double) -> MlclassifyforestView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_view_add(a : MlclassifyforestView, b : MlclassifyforestView) -> MlclassifyforestView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_forest_view_copy(s : MlclassifyforestView) -> MlclassifyforestView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_view_fill(s : MlclassifyforestView, v : Double) -> MlclassifyforestView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_view_min(s : MlclassifyforestView) -> Double { @_common.min(s.data) }

pub fn ml_classify_forest_view_max(s : MlclassifyforestView) -> Double { @_common.max(s.data) }

pub fn ml_classify_forest_view_to_string(s : MlclassifyforestView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_range_make(size : Int) -> MlclassifyforestRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_range_len(s : MlclassifyforestRange) -> Int { s.size }

pub fn ml_classify_forest_range_get(s : MlclassifyforestRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_range_set(s : MlclassifyforestRange, i : Int, v : Double) -> MlclassifyforestRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_range_sum(s : MlclassifyforestRange) -> Double { @_common.sum(s.data) }

pub fn ml_classify_forest_range_mean(s : MlclassifyforestRange) -> Double { @_common.mean(s.data) }

pub fn ml_classify_forest_range_scale(s : MlclassifyforestRange, f : Double) -> MlclassifyforestRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_range_add(a : MlclassifyforestRange, b : MlclassifyforestRange) -> MlclassifyforestRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_forest_range_copy(s : MlclassifyforestRange) -> MlclassifyforestRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_range_fill(s : MlclassifyforestRange, v : Double) -> MlclassifyforestRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_range_min(s : MlclassifyforestRange) -> Double { @_common.min(s.data) }

pub fn ml_classify_forest_range_max(s : MlclassifyforestRange) -> Double { @_common.max(s.data) }

pub fn ml_classify_forest_range_to_string(s : MlclassifyforestRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_slice_make(size : Int) -> MlclassifyforestSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_slice_len(s : MlclassifyforestSlice) -> Int { s.size }

pub fn ml_classify_forest_slice_get(s : MlclassifyforestSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_slice_set(s : MlclassifyforestSlice, i : Int, v : Double) -> MlclassifyforestSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_slice_sum(s : MlclassifyforestSlice) -> Double { @_common.sum(s.data) }

pub fn ml_classify_forest_slice_mean(s : MlclassifyforestSlice) -> Double { @_common.mean(s.data) }

pub fn ml_classify_forest_slice_scale(s : MlclassifyforestSlice, f : Double) -> MlclassifyforestSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_slice_add(a : MlclassifyforestSlice, b : MlclassifyforestSlice) -> MlclassifyforestSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_forest_slice_copy(s : MlclassifyforestSlice) -> MlclassifyforestSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_slice_fill(s : MlclassifyforestSlice, v : Double) -> MlclassifyforestSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_forest_slice_min(s : MlclassifyforestSlice) -> Double { @_common.min(s.data) }

pub fn ml_classify_forest_slice_max(s : MlclassifyforestSlice) -> Double { @_common.max(s.data) }

pub fn ml_classify_forest_slice_to_string(s : MlclassifyforestSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

