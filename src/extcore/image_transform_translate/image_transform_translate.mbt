///===
/// extcore/image_transform_translate

pub(all) struct ImagetransformtranslatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_translate_make_point(x : Double, y : Double) -> ImagetransformtranslatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_translate_make_point3(x : Double, y : Double, z : Double) -> ImagetransformtranslatePoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformtranslatePoint::x(self : ImagetransformtranslatePoint) -> Double { self.x }

pub fn ImagetransformtranslatePoint::y(self : ImagetransformtranslatePoint) -> Double { self.y }

pub fn ImagetransformtranslatePoint::z(self : ImagetransformtranslatePoint) -> Double { self.z }

pub fn ImagetransformtranslatePoint::label(self : ImagetransformtranslatePoint) -> Int { self.label }

pub fn ImagetransformtranslatePoint::dist(self : ImagetransformtranslatePoint, other : ImagetransformtranslatePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformtranslatePoint::add(self : ImagetransformtranslatePoint, other : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformtranslatePoint::sub(self : ImagetransformtranslatePoint, other : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformtranslatePoint::scale(self : ImagetransformtranslatePoint, s : Double) -> ImagetransformtranslatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformtranslatePoint::dot(self : ImagetransformtranslatePoint, other : ImagetransformtranslatePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformtranslatePoint::cross(self : ImagetransformtranslatePoint, other : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformtranslatePoint::norm(self : ImagetransformtranslatePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformtranslatePoint::normalize(self : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformtranslatePoint::negate(self : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformtranslatePoint::mid(self : ImagetransformtranslatePoint, other : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformtranslatePoint::lerp(self : ImagetransformtranslatePoint, other : ImagetransformtranslatePoint, t : Double) -> ImagetransformtranslatePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformtranslatePoint::to_string(self : ImagetransformtranslatePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformtranslateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_translate_make_series(vals : Array[Double], name : String) -> ImagetransformtranslateSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformtranslateSeries::len(self : ImagetransformtranslateSeries) -> Int { self.vals.length() }

pub fn ImagetransformtranslateSeries::sum(self : ImagetransformtranslateSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformtranslateSeries::mean(self : ImagetransformtranslateSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformtranslateSeries::min(self : ImagetransformtranslateSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformtranslateSeries::max(self : ImagetransformtranslateSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformtranslateSeries::range(self : ImagetransformtranslateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformtranslateSeries::variance(self : ImagetransformtranslateSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformtranslateSeries::std(self : ImagetransformtranslateSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformtranslateSeries::median(self : ImagetransformtranslateSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformtranslateSeries::scale(self : ImagetransformtranslateSeries, f : Double) -> ImagetransformtranslateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformtranslateSeries::add(self : ImagetransformtranslateSeries, other : ImagetransformtranslateSeries) -> ImagetransformtranslateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformtranslateSeries::sub(self : ImagetransformtranslateSeries, other : ImagetransformtranslateSeries) -> ImagetransformtranslateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformtranslateSeries::normalize(self : ImagetransformtranslateSeries) -> ImagetransformtranslateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformtranslateSeries::cumsum(self : ImagetransformtranslateSeries) -> ImagetransformtranslateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformtranslateSeries::to_string(self : ImagetransformtranslateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformtranslateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_translate_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformtranslateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_translate_matrix_identity(n : Int) -> ImagetransformtranslateMatrix {
  let m = image_transform_translate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformtranslateMatrix::get(self : ImagetransformtranslateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformtranslateMatrix::transpose(self : ImagetransformtranslateMatrix) -> ImagetransformtranslateMatrix {
  let result = image_transform_translate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformtranslateMatrix::add(self : ImagetransformtranslateMatrix, other : ImagetransformtranslateMatrix) -> ImagetransformtranslateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_translate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformtranslateMatrix::scale(self : ImagetransformtranslateMatrix, s : Double) -> ImagetransformtranslateMatrix {
  let result = image_transform_translate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformtranslateMatrix::multiply(self : ImagetransformtranslateMatrix, other : ImagetransformtranslateMatrix) -> ImagetransformtranslateMatrix {
  if self.cols != other.rows { return image_transform_translate_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_translate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagetransformtranslateMatrix::trace(self : ImagetransformtranslateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformtranslateMatrix::det(self : ImagetransformtranslateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformtranslateMatrix::norm(self : ImagetransformtranslateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformtranslateMatrix::to_string(self : ImagetransformtranslateMatrix) -> String {
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

pub(all) struct ImagetransformtranslateVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_translate_make_vector(comps : Array[Double]) -> ImagetransformtranslateVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_translate_vector_zero(dim : Int) -> ImagetransformtranslateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformtranslateVector::add(self : ImagetransformtranslateVector, other : ImagetransformtranslateVector) -> ImagetransformtranslateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformtranslateVector::sub(self : ImagetransformtranslateVector, other : ImagetransformtranslateVector) -> ImagetransformtranslateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformtranslateVector::scale(self : ImagetransformtranslateVector, s : Double) -> ImagetransformtranslateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformtranslateVector::dot(self : ImagetransformtranslateVector, other : ImagetransformtranslateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformtranslateVector::norm(self : ImagetransformtranslateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformtranslateVector::normalize(self : ImagetransformtranslateVector) -> ImagetransformtranslateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformtranslateVector::dist(self : ImagetransformtranslateVector, other : ImagetransformtranslateVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformtranslateVector::to_string(self : ImagetransformtranslateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_translate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_translate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_translate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_translate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_translate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_translate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_translate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_translate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_translate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_translate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_translate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_translate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_translate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_translate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_translate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_translate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_translate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_translate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_translate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_translate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_translate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_translate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_translate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_translate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_translate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_translate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_translate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_translate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_translate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformtranslateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_frame_make(size : Int) -> ImagetransformtranslateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_frame_len(s : ImagetransformtranslateFrame) -> Int { s.size }

pub fn image_transform_translate_frame_get(s : ImagetransformtranslateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_frame_set(s : ImagetransformtranslateFrame, i : Int, v : Double) -> ImagetransformtranslateFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_translate_frame_sum(s : ImagetransformtranslateFrame) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_frame_mean(s : ImagetransformtranslateFrame) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_frame_scale(s : ImagetransformtranslateFrame, f : Double) -> ImagetransformtranslateFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_frame_add(a : ImagetransformtranslateFrame, b : ImagetransformtranslateFrame) -> ImagetransformtranslateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_translate_frame_copy(s : ImagetransformtranslateFrame) -> ImagetransformtranslateFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_frame_fill(s : ImagetransformtranslateFrame, v : Double) -> ImagetransformtranslateFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_frame_min(s : ImagetransformtranslateFrame) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_frame_max(s : ImagetransformtranslateFrame) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_frame_to_string(s : ImagetransformtranslateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_table_make(size : Int) -> ImagetransformtranslateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_table_len(s : ImagetransformtranslateTable) -> Int { s.size }

pub fn image_transform_translate_table_get(s : ImagetransformtranslateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_table_set(s : ImagetransformtranslateTable, i : Int, v : Double) -> ImagetransformtranslateTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_translate_table_sum(s : ImagetransformtranslateTable) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_table_mean(s : ImagetransformtranslateTable) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_table_scale(s : ImagetransformtranslateTable, f : Double) -> ImagetransformtranslateTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_table_add(a : ImagetransformtranslateTable, b : ImagetransformtranslateTable) -> ImagetransformtranslateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_translate_table_copy(s : ImagetransformtranslateTable) -> ImagetransformtranslateTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_table_fill(s : ImagetransformtranslateTable, v : Double) -> ImagetransformtranslateTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_table_min(s : ImagetransformtranslateTable) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_table_max(s : ImagetransformtranslateTable) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_table_to_string(s : ImagetransformtranslateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_graphn_make(size : Int) -> ImagetransformtranslateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_graphn_len(s : ImagetransformtranslateGraphN) -> Int { s.size }

pub fn image_transform_translate_graphn_get(s : ImagetransformtranslateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_graphn_set(s : ImagetransformtranslateGraphN, i : Int, v : Double) -> ImagetransformtranslateGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_translate_graphn_sum(s : ImagetransformtranslateGraphN) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_graphn_mean(s : ImagetransformtranslateGraphN) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_graphn_scale(s : ImagetransformtranslateGraphN, f : Double) -> ImagetransformtranslateGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_graphn_add(a : ImagetransformtranslateGraphN, b : ImagetransformtranslateGraphN) -> ImagetransformtranslateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_translate_graphn_copy(s : ImagetransformtranslateGraphN) -> ImagetransformtranslateGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_graphn_fill(s : ImagetransformtranslateGraphN, v : Double) -> ImagetransformtranslateGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_graphn_min(s : ImagetransformtranslateGraphN) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_graphn_max(s : ImagetransformtranslateGraphN) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_graphn_to_string(s : ImagetransformtranslateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_node_make(size : Int) -> ImagetransformtranslateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_node_len(s : ImagetransformtranslateNode) -> Int { s.size }

pub fn image_transform_translate_node_get(s : ImagetransformtranslateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_node_set(s : ImagetransformtranslateNode, i : Int, v : Double) -> ImagetransformtranslateNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_translate_node_sum(s : ImagetransformtranslateNode) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_node_mean(s : ImagetransformtranslateNode) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_node_scale(s : ImagetransformtranslateNode, f : Double) -> ImagetransformtranslateNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_node_add(a : ImagetransformtranslateNode, b : ImagetransformtranslateNode) -> ImagetransformtranslateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_translate_node_copy(s : ImagetransformtranslateNode) -> ImagetransformtranslateNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_node_fill(s : ImagetransformtranslateNode, v : Double) -> ImagetransformtranslateNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_node_min(s : ImagetransformtranslateNode) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_node_max(s : ImagetransformtranslateNode) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_node_to_string(s : ImagetransformtranslateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_edge_make(size : Int) -> ImagetransformtranslateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_edge_len(s : ImagetransformtranslateEdge) -> Int { s.size }

pub fn image_transform_translate_edge_get(s : ImagetransformtranslateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_edge_set(s : ImagetransformtranslateEdge, i : Int, v : Double) -> ImagetransformtranslateEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_translate_edge_sum(s : ImagetransformtranslateEdge) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_edge_mean(s : ImagetransformtranslateEdge) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_edge_scale(s : ImagetransformtranslateEdge, f : Double) -> ImagetransformtranslateEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_edge_add(a : ImagetransformtranslateEdge, b : ImagetransformtranslateEdge) -> ImagetransformtranslateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_translate_edge_copy(s : ImagetransformtranslateEdge) -> ImagetransformtranslateEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_edge_fill(s : ImagetransformtranslateEdge, v : Double) -> ImagetransformtranslateEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_edge_min(s : ImagetransformtranslateEdge) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_edge_max(s : ImagetransformtranslateEdge) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_edge_to_string(s : ImagetransformtranslateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_path_make(size : Int) -> ImagetransformtranslatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_path_len(s : ImagetransformtranslatePath) -> Int { s.size }

pub fn image_transform_translate_path_get(s : ImagetransformtranslatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_path_set(s : ImagetransformtranslatePath, i : Int, v : Double) -> ImagetransformtranslatePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_translate_path_sum(s : ImagetransformtranslatePath) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_path_mean(s : ImagetransformtranslatePath) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_path_scale(s : ImagetransformtranslatePath, f : Double) -> ImagetransformtranslatePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_path_add(a : ImagetransformtranslatePath, b : ImagetransformtranslatePath) -> ImagetransformtranslatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_translate_path_copy(s : ImagetransformtranslatePath) -> ImagetransformtranslatePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_path_fill(s : ImagetransformtranslatePath, v : Double) -> ImagetransformtranslatePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_path_min(s : ImagetransformtranslatePath) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_path_max(s : ImagetransformtranslatePath) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_path_to_string(s : ImagetransformtranslatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_cluster_make(size : Int) -> ImagetransformtranslateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_cluster_len(s : ImagetransformtranslateCluster) -> Int { s.size }

pub fn image_transform_translate_cluster_get(s : ImagetransformtranslateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_cluster_set(s : ImagetransformtranslateCluster, i : Int, v : Double) -> ImagetransformtranslateCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_translate_cluster_sum(s : ImagetransformtranslateCluster) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_cluster_mean(s : ImagetransformtranslateCluster) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_cluster_scale(s : ImagetransformtranslateCluster, f : Double) -> ImagetransformtranslateCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_cluster_add(a : ImagetransformtranslateCluster, b : ImagetransformtranslateCluster) -> ImagetransformtranslateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_translate_cluster_copy(s : ImagetransformtranslateCluster) -> ImagetransformtranslateCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_cluster_fill(s : ImagetransformtranslateCluster, v : Double) -> ImagetransformtranslateCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_cluster_min(s : ImagetransformtranslateCluster) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_cluster_max(s : ImagetransformtranslateCluster) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_cluster_to_string(s : ImagetransformtranslateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_model_make(size : Int) -> ImagetransformtranslateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_model_len(s : ImagetransformtranslateModel) -> Int { s.size }

pub fn image_transform_translate_model_get(s : ImagetransformtranslateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_model_set(s : ImagetransformtranslateModel, i : Int, v : Double) -> ImagetransformtranslateModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_translate_model_sum(s : ImagetransformtranslateModel) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_model_mean(s : ImagetransformtranslateModel) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_model_scale(s : ImagetransformtranslateModel, f : Double) -> ImagetransformtranslateModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_model_add(a : ImagetransformtranslateModel, b : ImagetransformtranslateModel) -> ImagetransformtranslateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_translate_model_copy(s : ImagetransformtranslateModel) -> ImagetransformtranslateModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_model_fill(s : ImagetransformtranslateModel, v : Double) -> ImagetransformtranslateModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_model_min(s : ImagetransformtranslateModel) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_model_max(s : ImagetransformtranslateModel) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_model_to_string(s : ImagetransformtranslateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_layer_make(size : Int) -> ImagetransformtranslateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_layer_len(s : ImagetransformtranslateLayer) -> Int { s.size }

pub fn image_transform_translate_layer_get(s : ImagetransformtranslateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_layer_set(s : ImagetransformtranslateLayer, i : Int, v : Double) -> ImagetransformtranslateLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_translate_layer_sum(s : ImagetransformtranslateLayer) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_layer_mean(s : ImagetransformtranslateLayer) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_layer_scale(s : ImagetransformtranslateLayer, f : Double) -> ImagetransformtranslateLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_layer_add(a : ImagetransformtranslateLayer, b : ImagetransformtranslateLayer) -> ImagetransformtranslateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_translate_layer_copy(s : ImagetransformtranslateLayer) -> ImagetransformtranslateLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_layer_fill(s : ImagetransformtranslateLayer, v : Double) -> ImagetransformtranslateLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_layer_min(s : ImagetransformtranslateLayer) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_layer_max(s : ImagetransformtranslateLayer) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_layer_to_string(s : ImagetransformtranslateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_buffer_make(size : Int) -> ImagetransformtranslateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_buffer_len(s : ImagetransformtranslateBuffer) -> Int { s.size }

pub fn image_transform_translate_buffer_get(s : ImagetransformtranslateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_buffer_set(s : ImagetransformtranslateBuffer, i : Int, v : Double) -> ImagetransformtranslateBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_translate_buffer_sum(s : ImagetransformtranslateBuffer) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_buffer_mean(s : ImagetransformtranslateBuffer) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_buffer_scale(s : ImagetransformtranslateBuffer, f : Double) -> ImagetransformtranslateBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_buffer_add(a : ImagetransformtranslateBuffer, b : ImagetransformtranslateBuffer) -> ImagetransformtranslateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_translate_buffer_copy(s : ImagetransformtranslateBuffer) -> ImagetransformtranslateBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_buffer_fill(s : ImagetransformtranslateBuffer, v : Double) -> ImagetransformtranslateBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_buffer_min(s : ImagetransformtranslateBuffer) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_buffer_max(s : ImagetransformtranslateBuffer) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_buffer_to_string(s : ImagetransformtranslateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_cursor_make(size : Int) -> ImagetransformtranslateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_cursor_len(s : ImagetransformtranslateCursor) -> Int { s.size }

pub fn image_transform_translate_cursor_get(s : ImagetransformtranslateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_cursor_set(s : ImagetransformtranslateCursor, i : Int, v : Double) -> ImagetransformtranslateCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_translate_cursor_sum(s : ImagetransformtranslateCursor) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_cursor_mean(s : ImagetransformtranslateCursor) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_cursor_scale(s : ImagetransformtranslateCursor, f : Double) -> ImagetransformtranslateCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_cursor_add(a : ImagetransformtranslateCursor, b : ImagetransformtranslateCursor) -> ImagetransformtranslateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_translate_cursor_copy(s : ImagetransformtranslateCursor) -> ImagetransformtranslateCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_cursor_fill(s : ImagetransformtranslateCursor, v : Double) -> ImagetransformtranslateCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_cursor_min(s : ImagetransformtranslateCursor) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_cursor_max(s : ImagetransformtranslateCursor) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_cursor_to_string(s : ImagetransformtranslateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_view_make(size : Int) -> ImagetransformtranslateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_view_len(s : ImagetransformtranslateView) -> Int { s.size }

pub fn image_transform_translate_view_get(s : ImagetransformtranslateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_view_set(s : ImagetransformtranslateView, i : Int, v : Double) -> ImagetransformtranslateView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_translate_view_sum(s : ImagetransformtranslateView) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_view_mean(s : ImagetransformtranslateView) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_view_scale(s : ImagetransformtranslateView, f : Double) -> ImagetransformtranslateView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_view_add(a : ImagetransformtranslateView, b : ImagetransformtranslateView) -> ImagetransformtranslateView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_translate_view_copy(s : ImagetransformtranslateView) -> ImagetransformtranslateView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_view_fill(s : ImagetransformtranslateView, v : Double) -> ImagetransformtranslateView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_view_min(s : ImagetransformtranslateView) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_view_max(s : ImagetransformtranslateView) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_view_to_string(s : ImagetransformtranslateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_range_make(size : Int) -> ImagetransformtranslateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_range_len(s : ImagetransformtranslateRange) -> Int { s.size }

pub fn image_transform_translate_range_get(s : ImagetransformtranslateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_range_set(s : ImagetransformtranslateRange, i : Int, v : Double) -> ImagetransformtranslateRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_translate_range_sum(s : ImagetransformtranslateRange) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_range_mean(s : ImagetransformtranslateRange) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_range_scale(s : ImagetransformtranslateRange, f : Double) -> ImagetransformtranslateRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_range_add(a : ImagetransformtranslateRange, b : ImagetransformtranslateRange) -> ImagetransformtranslateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_translate_range_copy(s : ImagetransformtranslateRange) -> ImagetransformtranslateRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_range_fill(s : ImagetransformtranslateRange, v : Double) -> ImagetransformtranslateRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_range_min(s : ImagetransformtranslateRange) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_range_max(s : ImagetransformtranslateRange) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_range_to_string(s : ImagetransformtranslateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_slice_make(size : Int) -> ImagetransformtranslateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_slice_len(s : ImagetransformtranslateSlice) -> Int { s.size }

pub fn image_transform_translate_slice_get(s : ImagetransformtranslateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_slice_set(s : ImagetransformtranslateSlice, i : Int, v : Double) -> ImagetransformtranslateSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_translate_slice_sum(s : ImagetransformtranslateSlice) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_slice_mean(s : ImagetransformtranslateSlice) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_slice_scale(s : ImagetransformtranslateSlice, f : Double) -> ImagetransformtranslateSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_slice_add(a : ImagetransformtranslateSlice, b : ImagetransformtranslateSlice) -> ImagetransformtranslateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_translate_slice_copy(s : ImagetransformtranslateSlice) -> ImagetransformtranslateSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_slice_fill(s : ImagetransformtranslateSlice, v : Double) -> ImagetransformtranslateSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_translate_slice_min(s : ImagetransformtranslateSlice) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_slice_max(s : ImagetransformtranslateSlice) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_slice_to_string(s : ImagetransformtranslateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

