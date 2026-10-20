///===
/// extcore/image_morph_dilate

pub(all) struct ImagemorphdilatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_dilate_make_point(x : Double, y : Double) -> ImagemorphdilatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_dilate_make_point3(x : Double, y : Double, z : Double) -> ImagemorphdilatePoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphdilatePoint::x(self : ImagemorphdilatePoint) -> Double { self.x }

pub fn ImagemorphdilatePoint::y(self : ImagemorphdilatePoint) -> Double { self.y }

pub fn ImagemorphdilatePoint::z(self : ImagemorphdilatePoint) -> Double { self.z }

pub fn ImagemorphdilatePoint::label(self : ImagemorphdilatePoint) -> Int { self.label }

pub fn ImagemorphdilatePoint::dist(self : ImagemorphdilatePoint, other : ImagemorphdilatePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphdilatePoint::add(self : ImagemorphdilatePoint, other : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphdilatePoint::sub(self : ImagemorphdilatePoint, other : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphdilatePoint::scale(self : ImagemorphdilatePoint, s : Double) -> ImagemorphdilatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphdilatePoint::dot(self : ImagemorphdilatePoint, other : ImagemorphdilatePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphdilatePoint::cross(self : ImagemorphdilatePoint, other : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphdilatePoint::norm(self : ImagemorphdilatePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphdilatePoint::normalize(self : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphdilatePoint::negate(self : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphdilatePoint::mid(self : ImagemorphdilatePoint, other : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphdilatePoint::lerp(self : ImagemorphdilatePoint, other : ImagemorphdilatePoint, t : Double) -> ImagemorphdilatePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphdilatePoint::to_string(self : ImagemorphdilatePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphdilateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_dilate_make_series(vals : Array[Double], name : String) -> ImagemorphdilateSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphdilateSeries::len(self : ImagemorphdilateSeries) -> Int { self.vals.length() }

pub fn ImagemorphdilateSeries::sum(self : ImagemorphdilateSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphdilateSeries::mean(self : ImagemorphdilateSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphdilateSeries::min(self : ImagemorphdilateSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphdilateSeries::max(self : ImagemorphdilateSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphdilateSeries::range(self : ImagemorphdilateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphdilateSeries::variance(self : ImagemorphdilateSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphdilateSeries::std(self : ImagemorphdilateSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphdilateSeries::median(self : ImagemorphdilateSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphdilateSeries::scale(self : ImagemorphdilateSeries, f : Double) -> ImagemorphdilateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphdilateSeries::add(self : ImagemorphdilateSeries, other : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphdilateSeries::sub(self : ImagemorphdilateSeries, other : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphdilateSeries::normalize(self : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphdilateSeries::cumsum(self : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphdilateSeries::to_string(self : ImagemorphdilateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphdilateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_dilate_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphdilateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_dilate_matrix_identity(n : Int) -> ImagemorphdilateMatrix {
  let m = image_morph_dilate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphdilateMatrix::get(self : ImagemorphdilateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphdilateMatrix::transpose(self : ImagemorphdilateMatrix) -> ImagemorphdilateMatrix {
  let result = image_morph_dilate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphdilateMatrix::add(self : ImagemorphdilateMatrix, other : ImagemorphdilateMatrix) -> ImagemorphdilateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_dilate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphdilateMatrix::scale(self : ImagemorphdilateMatrix, s : Double) -> ImagemorphdilateMatrix {
  let result = image_morph_dilate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphdilateMatrix::multiply(self : ImagemorphdilateMatrix, other : ImagemorphdilateMatrix) -> ImagemorphdilateMatrix {
  if self.cols != other.rows { return image_morph_dilate_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_dilate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagemorphdilateMatrix::trace(self : ImagemorphdilateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphdilateMatrix::det(self : ImagemorphdilateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphdilateMatrix::norm(self : ImagemorphdilateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphdilateMatrix::to_string(self : ImagemorphdilateMatrix) -> String {
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

pub(all) struct ImagemorphdilateVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_dilate_make_vector(comps : Array[Double]) -> ImagemorphdilateVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_dilate_vector_zero(dim : Int) -> ImagemorphdilateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphdilateVector::add(self : ImagemorphdilateVector, other : ImagemorphdilateVector) -> ImagemorphdilateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphdilateVector::sub(self : ImagemorphdilateVector, other : ImagemorphdilateVector) -> ImagemorphdilateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphdilateVector::scale(self : ImagemorphdilateVector, s : Double) -> ImagemorphdilateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphdilateVector::dot(self : ImagemorphdilateVector, other : ImagemorphdilateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphdilateVector::norm(self : ImagemorphdilateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphdilateVector::normalize(self : ImagemorphdilateVector) -> ImagemorphdilateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphdilateVector::dist(self : ImagemorphdilateVector, other : ImagemorphdilateVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphdilateVector::to_string(self : ImagemorphdilateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_dilate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_morph_dilate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_morph_dilate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_morph_dilate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_morph_dilate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_morph_dilate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_morph_dilate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_morph_dilate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_morph_dilate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_morph_dilate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_morph_dilate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_morph_dilate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_morph_dilate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_morph_dilate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_morph_dilate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_morph_dilate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_morph_dilate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_morph_dilate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_morph_dilate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_morph_dilate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_morph_dilate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_morph_dilate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_morph_dilate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_morph_dilate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_morph_dilate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_morph_dilate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_morph_dilate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_morph_dilate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_morph_dilate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagemorphdilateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_frame_make(size : Int) -> ImagemorphdilateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_frame_len(s : ImagemorphdilateFrame) -> Int { s.size }

pub fn image_morph_dilate_frame_get(s : ImagemorphdilateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_frame_set(s : ImagemorphdilateFrame, i : Int, v : Double) -> ImagemorphdilateFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_frame_sum(s : ImagemorphdilateFrame) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_frame_mean(s : ImagemorphdilateFrame) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_frame_scale(s : ImagemorphdilateFrame, f : Double) -> ImagemorphdilateFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_frame_add(a : ImagemorphdilateFrame, b : ImagemorphdilateFrame) -> ImagemorphdilateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_frame_copy(s : ImagemorphdilateFrame) -> ImagemorphdilateFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_frame_fill(s : ImagemorphdilateFrame, v : Double) -> ImagemorphdilateFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_frame_min(s : ImagemorphdilateFrame) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_frame_max(s : ImagemorphdilateFrame) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_frame_to_string(s : ImagemorphdilateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_table_make(size : Int) -> ImagemorphdilateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_table_len(s : ImagemorphdilateTable) -> Int { s.size }

pub fn image_morph_dilate_table_get(s : ImagemorphdilateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_table_set(s : ImagemorphdilateTable, i : Int, v : Double) -> ImagemorphdilateTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_table_sum(s : ImagemorphdilateTable) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_table_mean(s : ImagemorphdilateTable) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_table_scale(s : ImagemorphdilateTable, f : Double) -> ImagemorphdilateTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_table_add(a : ImagemorphdilateTable, b : ImagemorphdilateTable) -> ImagemorphdilateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_table_copy(s : ImagemorphdilateTable) -> ImagemorphdilateTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_table_fill(s : ImagemorphdilateTable, v : Double) -> ImagemorphdilateTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_table_min(s : ImagemorphdilateTable) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_table_max(s : ImagemorphdilateTable) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_table_to_string(s : ImagemorphdilateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_graphn_make(size : Int) -> ImagemorphdilateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_graphn_len(s : ImagemorphdilateGraphN) -> Int { s.size }

pub fn image_morph_dilate_graphn_get(s : ImagemorphdilateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_graphn_set(s : ImagemorphdilateGraphN, i : Int, v : Double) -> ImagemorphdilateGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_graphn_sum(s : ImagemorphdilateGraphN) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_graphn_mean(s : ImagemorphdilateGraphN) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_graphn_scale(s : ImagemorphdilateGraphN, f : Double) -> ImagemorphdilateGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_graphn_add(a : ImagemorphdilateGraphN, b : ImagemorphdilateGraphN) -> ImagemorphdilateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_graphn_copy(s : ImagemorphdilateGraphN) -> ImagemorphdilateGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_graphn_fill(s : ImagemorphdilateGraphN, v : Double) -> ImagemorphdilateGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_graphn_min(s : ImagemorphdilateGraphN) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_graphn_max(s : ImagemorphdilateGraphN) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_graphn_to_string(s : ImagemorphdilateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_node_make(size : Int) -> ImagemorphdilateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_node_len(s : ImagemorphdilateNode) -> Int { s.size }

pub fn image_morph_dilate_node_get(s : ImagemorphdilateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_node_set(s : ImagemorphdilateNode, i : Int, v : Double) -> ImagemorphdilateNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_node_sum(s : ImagemorphdilateNode) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_node_mean(s : ImagemorphdilateNode) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_node_scale(s : ImagemorphdilateNode, f : Double) -> ImagemorphdilateNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_node_add(a : ImagemorphdilateNode, b : ImagemorphdilateNode) -> ImagemorphdilateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_node_copy(s : ImagemorphdilateNode) -> ImagemorphdilateNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_node_fill(s : ImagemorphdilateNode, v : Double) -> ImagemorphdilateNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_node_min(s : ImagemorphdilateNode) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_node_max(s : ImagemorphdilateNode) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_node_to_string(s : ImagemorphdilateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_edge_make(size : Int) -> ImagemorphdilateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_edge_len(s : ImagemorphdilateEdge) -> Int { s.size }

pub fn image_morph_dilate_edge_get(s : ImagemorphdilateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_edge_set(s : ImagemorphdilateEdge, i : Int, v : Double) -> ImagemorphdilateEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_edge_sum(s : ImagemorphdilateEdge) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_edge_mean(s : ImagemorphdilateEdge) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_edge_scale(s : ImagemorphdilateEdge, f : Double) -> ImagemorphdilateEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_edge_add(a : ImagemorphdilateEdge, b : ImagemorphdilateEdge) -> ImagemorphdilateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_edge_copy(s : ImagemorphdilateEdge) -> ImagemorphdilateEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_edge_fill(s : ImagemorphdilateEdge, v : Double) -> ImagemorphdilateEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_edge_min(s : ImagemorphdilateEdge) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_edge_max(s : ImagemorphdilateEdge) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_edge_to_string(s : ImagemorphdilateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_path_make(size : Int) -> ImagemorphdilatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_path_len(s : ImagemorphdilatePath) -> Int { s.size }

pub fn image_morph_dilate_path_get(s : ImagemorphdilatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_path_set(s : ImagemorphdilatePath, i : Int, v : Double) -> ImagemorphdilatePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_path_sum(s : ImagemorphdilatePath) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_path_mean(s : ImagemorphdilatePath) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_path_scale(s : ImagemorphdilatePath, f : Double) -> ImagemorphdilatePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_path_add(a : ImagemorphdilatePath, b : ImagemorphdilatePath) -> ImagemorphdilatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_path_copy(s : ImagemorphdilatePath) -> ImagemorphdilatePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_path_fill(s : ImagemorphdilatePath, v : Double) -> ImagemorphdilatePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_path_min(s : ImagemorphdilatePath) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_path_max(s : ImagemorphdilatePath) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_path_to_string(s : ImagemorphdilatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_cluster_make(size : Int) -> ImagemorphdilateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_cluster_len(s : ImagemorphdilateCluster) -> Int { s.size }

pub fn image_morph_dilate_cluster_get(s : ImagemorphdilateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_cluster_set(s : ImagemorphdilateCluster, i : Int, v : Double) -> ImagemorphdilateCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_cluster_sum(s : ImagemorphdilateCluster) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_cluster_mean(s : ImagemorphdilateCluster) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_cluster_scale(s : ImagemorphdilateCluster, f : Double) -> ImagemorphdilateCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_cluster_add(a : ImagemorphdilateCluster, b : ImagemorphdilateCluster) -> ImagemorphdilateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_cluster_copy(s : ImagemorphdilateCluster) -> ImagemorphdilateCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_cluster_fill(s : ImagemorphdilateCluster, v : Double) -> ImagemorphdilateCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_cluster_min(s : ImagemorphdilateCluster) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_cluster_max(s : ImagemorphdilateCluster) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_cluster_to_string(s : ImagemorphdilateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_model_make(size : Int) -> ImagemorphdilateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_model_len(s : ImagemorphdilateModel) -> Int { s.size }

pub fn image_morph_dilate_model_get(s : ImagemorphdilateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_model_set(s : ImagemorphdilateModel, i : Int, v : Double) -> ImagemorphdilateModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_model_sum(s : ImagemorphdilateModel) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_model_mean(s : ImagemorphdilateModel) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_model_scale(s : ImagemorphdilateModel, f : Double) -> ImagemorphdilateModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_model_add(a : ImagemorphdilateModel, b : ImagemorphdilateModel) -> ImagemorphdilateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_model_copy(s : ImagemorphdilateModel) -> ImagemorphdilateModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_model_fill(s : ImagemorphdilateModel, v : Double) -> ImagemorphdilateModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_model_min(s : ImagemorphdilateModel) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_model_max(s : ImagemorphdilateModel) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_model_to_string(s : ImagemorphdilateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_layer_make(size : Int) -> ImagemorphdilateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_layer_len(s : ImagemorphdilateLayer) -> Int { s.size }

pub fn image_morph_dilate_layer_get(s : ImagemorphdilateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_layer_set(s : ImagemorphdilateLayer, i : Int, v : Double) -> ImagemorphdilateLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_layer_sum(s : ImagemorphdilateLayer) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_layer_mean(s : ImagemorphdilateLayer) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_layer_scale(s : ImagemorphdilateLayer, f : Double) -> ImagemorphdilateLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_layer_add(a : ImagemorphdilateLayer, b : ImagemorphdilateLayer) -> ImagemorphdilateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_layer_copy(s : ImagemorphdilateLayer) -> ImagemorphdilateLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_layer_fill(s : ImagemorphdilateLayer, v : Double) -> ImagemorphdilateLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_layer_min(s : ImagemorphdilateLayer) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_layer_max(s : ImagemorphdilateLayer) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_layer_to_string(s : ImagemorphdilateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_buffer_make(size : Int) -> ImagemorphdilateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_buffer_len(s : ImagemorphdilateBuffer) -> Int { s.size }

pub fn image_morph_dilate_buffer_get(s : ImagemorphdilateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_buffer_set(s : ImagemorphdilateBuffer, i : Int, v : Double) -> ImagemorphdilateBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_buffer_sum(s : ImagemorphdilateBuffer) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_buffer_mean(s : ImagemorphdilateBuffer) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_buffer_scale(s : ImagemorphdilateBuffer, f : Double) -> ImagemorphdilateBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_buffer_add(a : ImagemorphdilateBuffer, b : ImagemorphdilateBuffer) -> ImagemorphdilateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_buffer_copy(s : ImagemorphdilateBuffer) -> ImagemorphdilateBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_buffer_fill(s : ImagemorphdilateBuffer, v : Double) -> ImagemorphdilateBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_buffer_min(s : ImagemorphdilateBuffer) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_buffer_max(s : ImagemorphdilateBuffer) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_buffer_to_string(s : ImagemorphdilateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_cursor_make(size : Int) -> ImagemorphdilateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_cursor_len(s : ImagemorphdilateCursor) -> Int { s.size }

pub fn image_morph_dilate_cursor_get(s : ImagemorphdilateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_cursor_set(s : ImagemorphdilateCursor, i : Int, v : Double) -> ImagemorphdilateCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_cursor_sum(s : ImagemorphdilateCursor) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_cursor_mean(s : ImagemorphdilateCursor) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_cursor_scale(s : ImagemorphdilateCursor, f : Double) -> ImagemorphdilateCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_cursor_add(a : ImagemorphdilateCursor, b : ImagemorphdilateCursor) -> ImagemorphdilateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_cursor_copy(s : ImagemorphdilateCursor) -> ImagemorphdilateCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_cursor_fill(s : ImagemorphdilateCursor, v : Double) -> ImagemorphdilateCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_cursor_min(s : ImagemorphdilateCursor) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_cursor_max(s : ImagemorphdilateCursor) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_cursor_to_string(s : ImagemorphdilateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_view_make(size : Int) -> ImagemorphdilateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_view_len(s : ImagemorphdilateView) -> Int { s.size }

pub fn image_morph_dilate_view_get(s : ImagemorphdilateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_view_set(s : ImagemorphdilateView, i : Int, v : Double) -> ImagemorphdilateView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_view_sum(s : ImagemorphdilateView) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_view_mean(s : ImagemorphdilateView) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_view_scale(s : ImagemorphdilateView, f : Double) -> ImagemorphdilateView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_view_add(a : ImagemorphdilateView, b : ImagemorphdilateView) -> ImagemorphdilateView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_view_copy(s : ImagemorphdilateView) -> ImagemorphdilateView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_view_fill(s : ImagemorphdilateView, v : Double) -> ImagemorphdilateView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_view_min(s : ImagemorphdilateView) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_view_max(s : ImagemorphdilateView) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_view_to_string(s : ImagemorphdilateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_range_make(size : Int) -> ImagemorphdilateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_range_len(s : ImagemorphdilateRange) -> Int { s.size }

pub fn image_morph_dilate_range_get(s : ImagemorphdilateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_range_set(s : ImagemorphdilateRange, i : Int, v : Double) -> ImagemorphdilateRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_range_sum(s : ImagemorphdilateRange) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_range_mean(s : ImagemorphdilateRange) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_range_scale(s : ImagemorphdilateRange, f : Double) -> ImagemorphdilateRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_range_add(a : ImagemorphdilateRange, b : ImagemorphdilateRange) -> ImagemorphdilateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_range_copy(s : ImagemorphdilateRange) -> ImagemorphdilateRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_range_fill(s : ImagemorphdilateRange, v : Double) -> ImagemorphdilateRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_range_min(s : ImagemorphdilateRange) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_range_max(s : ImagemorphdilateRange) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_range_to_string(s : ImagemorphdilateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_slice_make(size : Int) -> ImagemorphdilateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_slice_len(s : ImagemorphdilateSlice) -> Int { s.size }

pub fn image_morph_dilate_slice_get(s : ImagemorphdilateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_slice_set(s : ImagemorphdilateSlice, i : Int, v : Double) -> ImagemorphdilateSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_slice_sum(s : ImagemorphdilateSlice) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_slice_mean(s : ImagemorphdilateSlice) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_slice_scale(s : ImagemorphdilateSlice, f : Double) -> ImagemorphdilateSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_slice_add(a : ImagemorphdilateSlice, b : ImagemorphdilateSlice) -> ImagemorphdilateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_slice_copy(s : ImagemorphdilateSlice) -> ImagemorphdilateSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_slice_fill(s : ImagemorphdilateSlice, v : Double) -> ImagemorphdilateSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_slice_min(s : ImagemorphdilateSlice) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_slice_max(s : ImagemorphdilateSlice) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_slice_to_string(s : ImagemorphdilateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

