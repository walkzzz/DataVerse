///===
/// extcore/image_morph_gradient

pub(all) struct ImagemorphgradientPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_gradient_make_point(x : Double, y : Double) -> ImagemorphgradientPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_gradient_make_point3(x : Double, y : Double, z : Double) -> ImagemorphgradientPoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphgradientPoint::x(self : ImagemorphgradientPoint) -> Double { self.x }

pub fn ImagemorphgradientPoint::y(self : ImagemorphgradientPoint) -> Double { self.y }

pub fn ImagemorphgradientPoint::z(self : ImagemorphgradientPoint) -> Double { self.z }

pub fn ImagemorphgradientPoint::label(self : ImagemorphgradientPoint) -> Int { self.label }

pub fn ImagemorphgradientPoint::dist(self : ImagemorphgradientPoint, other : ImagemorphgradientPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphgradientPoint::add(self : ImagemorphgradientPoint, other : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphgradientPoint::sub(self : ImagemorphgradientPoint, other : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphgradientPoint::scale(self : ImagemorphgradientPoint, s : Double) -> ImagemorphgradientPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphgradientPoint::dot(self : ImagemorphgradientPoint, other : ImagemorphgradientPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphgradientPoint::cross(self : ImagemorphgradientPoint, other : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphgradientPoint::norm(self : ImagemorphgradientPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphgradientPoint::normalize(self : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphgradientPoint::negate(self : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphgradientPoint::mid(self : ImagemorphgradientPoint, other : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphgradientPoint::lerp(self : ImagemorphgradientPoint, other : ImagemorphgradientPoint, t : Double) -> ImagemorphgradientPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphgradientPoint::to_string(self : ImagemorphgradientPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphgradientSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_gradient_make_series(vals : Array[Double], name : String) -> ImagemorphgradientSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphgradientSeries::len(self : ImagemorphgradientSeries) -> Int { self.vals.length() }

pub fn ImagemorphgradientSeries::sum(self : ImagemorphgradientSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphgradientSeries::mean(self : ImagemorphgradientSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphgradientSeries::min(self : ImagemorphgradientSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphgradientSeries::max(self : ImagemorphgradientSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphgradientSeries::range(self : ImagemorphgradientSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphgradientSeries::variance(self : ImagemorphgradientSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphgradientSeries::std(self : ImagemorphgradientSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphgradientSeries::median(self : ImagemorphgradientSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphgradientSeries::scale(self : ImagemorphgradientSeries, f : Double) -> ImagemorphgradientSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphgradientSeries::add(self : ImagemorphgradientSeries, other : ImagemorphgradientSeries) -> ImagemorphgradientSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphgradientSeries::sub(self : ImagemorphgradientSeries, other : ImagemorphgradientSeries) -> ImagemorphgradientSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphgradientSeries::normalize(self : ImagemorphgradientSeries) -> ImagemorphgradientSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphgradientSeries::cumsum(self : ImagemorphgradientSeries) -> ImagemorphgradientSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphgradientSeries::to_string(self : ImagemorphgradientSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphgradientMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_gradient_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphgradientMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_gradient_matrix_identity(n : Int) -> ImagemorphgradientMatrix {
  let m = image_morph_gradient_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphgradientMatrix::get(self : ImagemorphgradientMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphgradientMatrix::transpose(self : ImagemorphgradientMatrix) -> ImagemorphgradientMatrix {
  let result = image_morph_gradient_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphgradientMatrix::add(self : ImagemorphgradientMatrix, other : ImagemorphgradientMatrix) -> ImagemorphgradientMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_gradient_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphgradientMatrix::scale(self : ImagemorphgradientMatrix, s : Double) -> ImagemorphgradientMatrix {
  let result = image_morph_gradient_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphgradientMatrix::multiply(self : ImagemorphgradientMatrix, other : ImagemorphgradientMatrix) -> ImagemorphgradientMatrix {
  if self.cols != other.rows { return image_morph_gradient_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_gradient_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagemorphgradientMatrix::trace(self : ImagemorphgradientMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphgradientMatrix::det(self : ImagemorphgradientMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphgradientMatrix::norm(self : ImagemorphgradientMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphgradientMatrix::to_string(self : ImagemorphgradientMatrix) -> String {
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

pub(all) struct ImagemorphgradientVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_gradient_make_vector(comps : Array[Double]) -> ImagemorphgradientVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_gradient_vector_zero(dim : Int) -> ImagemorphgradientVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphgradientVector::add(self : ImagemorphgradientVector, other : ImagemorphgradientVector) -> ImagemorphgradientVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphgradientVector::sub(self : ImagemorphgradientVector, other : ImagemorphgradientVector) -> ImagemorphgradientVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphgradientVector::scale(self : ImagemorphgradientVector, s : Double) -> ImagemorphgradientVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphgradientVector::dot(self : ImagemorphgradientVector, other : ImagemorphgradientVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphgradientVector::norm(self : ImagemorphgradientVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphgradientVector::normalize(self : ImagemorphgradientVector) -> ImagemorphgradientVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphgradientVector::dist(self : ImagemorphgradientVector, other : ImagemorphgradientVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphgradientVector::to_string(self : ImagemorphgradientVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_gradient_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_morph_gradient_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_morph_gradient_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_morph_gradient_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_morph_gradient_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_morph_gradient_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_morph_gradient_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_morph_gradient_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_morph_gradient_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_morph_gradient_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_morph_gradient_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_morph_gradient_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_morph_gradient_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_morph_gradient_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_morph_gradient_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_morph_gradient_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_morph_gradient_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_morph_gradient_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_morph_gradient_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_morph_gradient_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_morph_gradient_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_morph_gradient_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_morph_gradient_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_morph_gradient_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_morph_gradient_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_morph_gradient_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_morph_gradient_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_morph_gradient_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_morph_gradient_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagemorphgradientFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_frame_make(size : Int) -> ImagemorphgradientFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_frame_len(s : ImagemorphgradientFrame) -> Int { s.size }

pub fn image_morph_gradient_frame_get(s : ImagemorphgradientFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_frame_set(s : ImagemorphgradientFrame, i : Int, v : Double) -> ImagemorphgradientFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_frame_sum(s : ImagemorphgradientFrame) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_frame_mean(s : ImagemorphgradientFrame) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_frame_scale(s : ImagemorphgradientFrame, f : Double) -> ImagemorphgradientFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_frame_add(a : ImagemorphgradientFrame, b : ImagemorphgradientFrame) -> ImagemorphgradientFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_frame_copy(s : ImagemorphgradientFrame) -> ImagemorphgradientFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_frame_fill(s : ImagemorphgradientFrame, v : Double) -> ImagemorphgradientFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_frame_min(s : ImagemorphgradientFrame) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_frame_max(s : ImagemorphgradientFrame) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_frame_to_string(s : ImagemorphgradientFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_table_make(size : Int) -> ImagemorphgradientTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_table_len(s : ImagemorphgradientTable) -> Int { s.size }

pub fn image_morph_gradient_table_get(s : ImagemorphgradientTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_table_set(s : ImagemorphgradientTable, i : Int, v : Double) -> ImagemorphgradientTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_table_sum(s : ImagemorphgradientTable) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_table_mean(s : ImagemorphgradientTable) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_table_scale(s : ImagemorphgradientTable, f : Double) -> ImagemorphgradientTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_table_add(a : ImagemorphgradientTable, b : ImagemorphgradientTable) -> ImagemorphgradientTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_table_copy(s : ImagemorphgradientTable) -> ImagemorphgradientTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_table_fill(s : ImagemorphgradientTable, v : Double) -> ImagemorphgradientTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_table_min(s : ImagemorphgradientTable) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_table_max(s : ImagemorphgradientTable) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_table_to_string(s : ImagemorphgradientTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_graphn_make(size : Int) -> ImagemorphgradientGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_graphn_len(s : ImagemorphgradientGraphN) -> Int { s.size }

pub fn image_morph_gradient_graphn_get(s : ImagemorphgradientGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_graphn_set(s : ImagemorphgradientGraphN, i : Int, v : Double) -> ImagemorphgradientGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_graphn_sum(s : ImagemorphgradientGraphN) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_graphn_mean(s : ImagemorphgradientGraphN) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_graphn_scale(s : ImagemorphgradientGraphN, f : Double) -> ImagemorphgradientGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_graphn_add(a : ImagemorphgradientGraphN, b : ImagemorphgradientGraphN) -> ImagemorphgradientGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_graphn_copy(s : ImagemorphgradientGraphN) -> ImagemorphgradientGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_graphn_fill(s : ImagemorphgradientGraphN, v : Double) -> ImagemorphgradientGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_graphn_min(s : ImagemorphgradientGraphN) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_graphn_max(s : ImagemorphgradientGraphN) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_graphn_to_string(s : ImagemorphgradientGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_node_make(size : Int) -> ImagemorphgradientNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_node_len(s : ImagemorphgradientNode) -> Int { s.size }

pub fn image_morph_gradient_node_get(s : ImagemorphgradientNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_node_set(s : ImagemorphgradientNode, i : Int, v : Double) -> ImagemorphgradientNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_node_sum(s : ImagemorphgradientNode) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_node_mean(s : ImagemorphgradientNode) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_node_scale(s : ImagemorphgradientNode, f : Double) -> ImagemorphgradientNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_node_add(a : ImagemorphgradientNode, b : ImagemorphgradientNode) -> ImagemorphgradientNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_node_copy(s : ImagemorphgradientNode) -> ImagemorphgradientNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_node_fill(s : ImagemorphgradientNode, v : Double) -> ImagemorphgradientNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_node_min(s : ImagemorphgradientNode) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_node_max(s : ImagemorphgradientNode) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_node_to_string(s : ImagemorphgradientNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_edge_make(size : Int) -> ImagemorphgradientEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_edge_len(s : ImagemorphgradientEdge) -> Int { s.size }

pub fn image_morph_gradient_edge_get(s : ImagemorphgradientEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_edge_set(s : ImagemorphgradientEdge, i : Int, v : Double) -> ImagemorphgradientEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_edge_sum(s : ImagemorphgradientEdge) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_edge_mean(s : ImagemorphgradientEdge) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_edge_scale(s : ImagemorphgradientEdge, f : Double) -> ImagemorphgradientEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_edge_add(a : ImagemorphgradientEdge, b : ImagemorphgradientEdge) -> ImagemorphgradientEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_edge_copy(s : ImagemorphgradientEdge) -> ImagemorphgradientEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_edge_fill(s : ImagemorphgradientEdge, v : Double) -> ImagemorphgradientEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_edge_min(s : ImagemorphgradientEdge) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_edge_max(s : ImagemorphgradientEdge) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_edge_to_string(s : ImagemorphgradientEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_path_make(size : Int) -> ImagemorphgradientPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_path_len(s : ImagemorphgradientPath) -> Int { s.size }

pub fn image_morph_gradient_path_get(s : ImagemorphgradientPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_path_set(s : ImagemorphgradientPath, i : Int, v : Double) -> ImagemorphgradientPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_path_sum(s : ImagemorphgradientPath) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_path_mean(s : ImagemorphgradientPath) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_path_scale(s : ImagemorphgradientPath, f : Double) -> ImagemorphgradientPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_path_add(a : ImagemorphgradientPath, b : ImagemorphgradientPath) -> ImagemorphgradientPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_path_copy(s : ImagemorphgradientPath) -> ImagemorphgradientPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_path_fill(s : ImagemorphgradientPath, v : Double) -> ImagemorphgradientPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_path_min(s : ImagemorphgradientPath) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_path_max(s : ImagemorphgradientPath) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_path_to_string(s : ImagemorphgradientPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_cluster_make(size : Int) -> ImagemorphgradientCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_cluster_len(s : ImagemorphgradientCluster) -> Int { s.size }

pub fn image_morph_gradient_cluster_get(s : ImagemorphgradientCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_cluster_set(s : ImagemorphgradientCluster, i : Int, v : Double) -> ImagemorphgradientCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cluster_sum(s : ImagemorphgradientCluster) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_cluster_mean(s : ImagemorphgradientCluster) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_cluster_scale(s : ImagemorphgradientCluster, f : Double) -> ImagemorphgradientCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cluster_add(a : ImagemorphgradientCluster, b : ImagemorphgradientCluster) -> ImagemorphgradientCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_cluster_copy(s : ImagemorphgradientCluster) -> ImagemorphgradientCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cluster_fill(s : ImagemorphgradientCluster, v : Double) -> ImagemorphgradientCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cluster_min(s : ImagemorphgradientCluster) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_cluster_max(s : ImagemorphgradientCluster) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_cluster_to_string(s : ImagemorphgradientCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_model_make(size : Int) -> ImagemorphgradientModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_model_len(s : ImagemorphgradientModel) -> Int { s.size }

pub fn image_morph_gradient_model_get(s : ImagemorphgradientModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_model_set(s : ImagemorphgradientModel, i : Int, v : Double) -> ImagemorphgradientModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_model_sum(s : ImagemorphgradientModel) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_model_mean(s : ImagemorphgradientModel) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_model_scale(s : ImagemorphgradientModel, f : Double) -> ImagemorphgradientModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_model_add(a : ImagemorphgradientModel, b : ImagemorphgradientModel) -> ImagemorphgradientModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_model_copy(s : ImagemorphgradientModel) -> ImagemorphgradientModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_model_fill(s : ImagemorphgradientModel, v : Double) -> ImagemorphgradientModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_model_min(s : ImagemorphgradientModel) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_model_max(s : ImagemorphgradientModel) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_model_to_string(s : ImagemorphgradientModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_layer_make(size : Int) -> ImagemorphgradientLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_layer_len(s : ImagemorphgradientLayer) -> Int { s.size }

pub fn image_morph_gradient_layer_get(s : ImagemorphgradientLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_layer_set(s : ImagemorphgradientLayer, i : Int, v : Double) -> ImagemorphgradientLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_layer_sum(s : ImagemorphgradientLayer) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_layer_mean(s : ImagemorphgradientLayer) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_layer_scale(s : ImagemorphgradientLayer, f : Double) -> ImagemorphgradientLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_layer_add(a : ImagemorphgradientLayer, b : ImagemorphgradientLayer) -> ImagemorphgradientLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_layer_copy(s : ImagemorphgradientLayer) -> ImagemorphgradientLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_layer_fill(s : ImagemorphgradientLayer, v : Double) -> ImagemorphgradientLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_layer_min(s : ImagemorphgradientLayer) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_layer_max(s : ImagemorphgradientLayer) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_layer_to_string(s : ImagemorphgradientLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_buffer_make(size : Int) -> ImagemorphgradientBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_buffer_len(s : ImagemorphgradientBuffer) -> Int { s.size }

pub fn image_morph_gradient_buffer_get(s : ImagemorphgradientBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_buffer_set(s : ImagemorphgradientBuffer, i : Int, v : Double) -> ImagemorphgradientBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_buffer_sum(s : ImagemorphgradientBuffer) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_buffer_mean(s : ImagemorphgradientBuffer) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_buffer_scale(s : ImagemorphgradientBuffer, f : Double) -> ImagemorphgradientBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_buffer_add(a : ImagemorphgradientBuffer, b : ImagemorphgradientBuffer) -> ImagemorphgradientBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_buffer_copy(s : ImagemorphgradientBuffer) -> ImagemorphgradientBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_buffer_fill(s : ImagemorphgradientBuffer, v : Double) -> ImagemorphgradientBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_buffer_min(s : ImagemorphgradientBuffer) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_buffer_max(s : ImagemorphgradientBuffer) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_buffer_to_string(s : ImagemorphgradientBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_cursor_make(size : Int) -> ImagemorphgradientCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_cursor_len(s : ImagemorphgradientCursor) -> Int { s.size }

pub fn image_morph_gradient_cursor_get(s : ImagemorphgradientCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_cursor_set(s : ImagemorphgradientCursor, i : Int, v : Double) -> ImagemorphgradientCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cursor_sum(s : ImagemorphgradientCursor) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_cursor_mean(s : ImagemorphgradientCursor) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_cursor_scale(s : ImagemorphgradientCursor, f : Double) -> ImagemorphgradientCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cursor_add(a : ImagemorphgradientCursor, b : ImagemorphgradientCursor) -> ImagemorphgradientCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_cursor_copy(s : ImagemorphgradientCursor) -> ImagemorphgradientCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cursor_fill(s : ImagemorphgradientCursor, v : Double) -> ImagemorphgradientCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cursor_min(s : ImagemorphgradientCursor) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_cursor_max(s : ImagemorphgradientCursor) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_cursor_to_string(s : ImagemorphgradientCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_view_make(size : Int) -> ImagemorphgradientView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_view_len(s : ImagemorphgradientView) -> Int { s.size }

pub fn image_morph_gradient_view_get(s : ImagemorphgradientView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_view_set(s : ImagemorphgradientView, i : Int, v : Double) -> ImagemorphgradientView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_view_sum(s : ImagemorphgradientView) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_view_mean(s : ImagemorphgradientView) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_view_scale(s : ImagemorphgradientView, f : Double) -> ImagemorphgradientView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_view_add(a : ImagemorphgradientView, b : ImagemorphgradientView) -> ImagemorphgradientView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_view_copy(s : ImagemorphgradientView) -> ImagemorphgradientView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_view_fill(s : ImagemorphgradientView, v : Double) -> ImagemorphgradientView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_view_min(s : ImagemorphgradientView) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_view_max(s : ImagemorphgradientView) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_view_to_string(s : ImagemorphgradientView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_range_make(size : Int) -> ImagemorphgradientRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_range_len(s : ImagemorphgradientRange) -> Int { s.size }

pub fn image_morph_gradient_range_get(s : ImagemorphgradientRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_range_set(s : ImagemorphgradientRange, i : Int, v : Double) -> ImagemorphgradientRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_range_sum(s : ImagemorphgradientRange) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_range_mean(s : ImagemorphgradientRange) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_range_scale(s : ImagemorphgradientRange, f : Double) -> ImagemorphgradientRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_range_add(a : ImagemorphgradientRange, b : ImagemorphgradientRange) -> ImagemorphgradientRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_range_copy(s : ImagemorphgradientRange) -> ImagemorphgradientRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_range_fill(s : ImagemorphgradientRange, v : Double) -> ImagemorphgradientRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_range_min(s : ImagemorphgradientRange) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_range_max(s : ImagemorphgradientRange) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_range_to_string(s : ImagemorphgradientRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_slice_make(size : Int) -> ImagemorphgradientSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_slice_len(s : ImagemorphgradientSlice) -> Int { s.size }

pub fn image_morph_gradient_slice_get(s : ImagemorphgradientSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_slice_set(s : ImagemorphgradientSlice, i : Int, v : Double) -> ImagemorphgradientSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_slice_sum(s : ImagemorphgradientSlice) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_slice_mean(s : ImagemorphgradientSlice) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_slice_scale(s : ImagemorphgradientSlice, f : Double) -> ImagemorphgradientSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_slice_add(a : ImagemorphgradientSlice, b : ImagemorphgradientSlice) -> ImagemorphgradientSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_slice_copy(s : ImagemorphgradientSlice) -> ImagemorphgradientSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_slice_fill(s : ImagemorphgradientSlice, v : Double) -> ImagemorphgradientSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_slice_min(s : ImagemorphgradientSlice) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_slice_max(s : ImagemorphgradientSlice) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_slice_to_string(s : ImagemorphgradientSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

