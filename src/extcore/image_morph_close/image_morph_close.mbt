///===
/// extcore/image_morph_close

pub(all) struct ImagemorphclosePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_close_make_point(x : Double, y : Double) -> ImagemorphclosePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_close_make_point3(x : Double, y : Double, z : Double) -> ImagemorphclosePoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphclosePoint::x(self : ImagemorphclosePoint) -> Double { self.x }

pub fn ImagemorphclosePoint::y(self : ImagemorphclosePoint) -> Double { self.y }

pub fn ImagemorphclosePoint::z(self : ImagemorphclosePoint) -> Double { self.z }

pub fn ImagemorphclosePoint::label(self : ImagemorphclosePoint) -> Int { self.label }

pub fn ImagemorphclosePoint::dist(self : ImagemorphclosePoint, other : ImagemorphclosePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphclosePoint::add(self : ImagemorphclosePoint, other : ImagemorphclosePoint) -> ImagemorphclosePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphclosePoint::sub(self : ImagemorphclosePoint, other : ImagemorphclosePoint) -> ImagemorphclosePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphclosePoint::scale(self : ImagemorphclosePoint, s : Double) -> ImagemorphclosePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphclosePoint::dot(self : ImagemorphclosePoint, other : ImagemorphclosePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphclosePoint::cross(self : ImagemorphclosePoint, other : ImagemorphclosePoint) -> ImagemorphclosePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphclosePoint::norm(self : ImagemorphclosePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphclosePoint::normalize(self : ImagemorphclosePoint) -> ImagemorphclosePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphclosePoint::negate(self : ImagemorphclosePoint) -> ImagemorphclosePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphclosePoint::mid(self : ImagemorphclosePoint, other : ImagemorphclosePoint) -> ImagemorphclosePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphclosePoint::lerp(self : ImagemorphclosePoint, other : ImagemorphclosePoint, t : Double) -> ImagemorphclosePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphclosePoint::to_string(self : ImagemorphclosePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphcloseSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_close_make_series(vals : Array[Double], name : String) -> ImagemorphcloseSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphcloseSeries::len(self : ImagemorphcloseSeries) -> Int { self.vals.length() }

pub fn ImagemorphcloseSeries::sum(self : ImagemorphcloseSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphcloseSeries::mean(self : ImagemorphcloseSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphcloseSeries::min(self : ImagemorphcloseSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphcloseSeries::max(self : ImagemorphcloseSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphcloseSeries::range(self : ImagemorphcloseSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphcloseSeries::variance(self : ImagemorphcloseSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphcloseSeries::std(self : ImagemorphcloseSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphcloseSeries::median(self : ImagemorphcloseSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphcloseSeries::scale(self : ImagemorphcloseSeries, f : Double) -> ImagemorphcloseSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphcloseSeries::add(self : ImagemorphcloseSeries, other : ImagemorphcloseSeries) -> ImagemorphcloseSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphcloseSeries::sub(self : ImagemorphcloseSeries, other : ImagemorphcloseSeries) -> ImagemorphcloseSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphcloseSeries::normalize(self : ImagemorphcloseSeries) -> ImagemorphcloseSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphcloseSeries::cumsum(self : ImagemorphcloseSeries) -> ImagemorphcloseSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphcloseSeries::to_string(self : ImagemorphcloseSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphcloseMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_close_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphcloseMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_close_matrix_identity(n : Int) -> ImagemorphcloseMatrix {
  let m = image_morph_close_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphcloseMatrix::get(self : ImagemorphcloseMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphcloseMatrix::transpose(self : ImagemorphcloseMatrix) -> ImagemorphcloseMatrix {
  let result = image_morph_close_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphcloseMatrix::add(self : ImagemorphcloseMatrix, other : ImagemorphcloseMatrix) -> ImagemorphcloseMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_close_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphcloseMatrix::scale(self : ImagemorphcloseMatrix, s : Double) -> ImagemorphcloseMatrix {
  let result = image_morph_close_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphcloseMatrix::multiply(self : ImagemorphcloseMatrix, other : ImagemorphcloseMatrix) -> ImagemorphcloseMatrix {
  if self.cols != other.rows { return image_morph_close_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_close_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagemorphcloseMatrix::trace(self : ImagemorphcloseMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphcloseMatrix::det(self : ImagemorphcloseMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphcloseMatrix::norm(self : ImagemorphcloseMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphcloseMatrix::to_string(self : ImagemorphcloseMatrix) -> String {
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

pub(all) struct ImagemorphcloseVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_close_make_vector(comps : Array[Double]) -> ImagemorphcloseVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_close_vector_zero(dim : Int) -> ImagemorphcloseVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphcloseVector::add(self : ImagemorphcloseVector, other : ImagemorphcloseVector) -> ImagemorphcloseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphcloseVector::sub(self : ImagemorphcloseVector, other : ImagemorphcloseVector) -> ImagemorphcloseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphcloseVector::scale(self : ImagemorphcloseVector, s : Double) -> ImagemorphcloseVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphcloseVector::dot(self : ImagemorphcloseVector, other : ImagemorphcloseVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphcloseVector::norm(self : ImagemorphcloseVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphcloseVector::normalize(self : ImagemorphcloseVector) -> ImagemorphcloseVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphcloseVector::dist(self : ImagemorphcloseVector, other : ImagemorphcloseVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphcloseVector::to_string(self : ImagemorphcloseVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_close_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_morph_close_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_morph_close_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_morph_close_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_morph_close_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_morph_close_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_morph_close_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_morph_close_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_morph_close_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_morph_close_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_morph_close_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_morph_close_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_morph_close_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_morph_close_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_morph_close_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_morph_close_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_morph_close_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_morph_close_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_morph_close_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_morph_close_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_morph_close_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_morph_close_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_morph_close_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_morph_close_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_morph_close_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_morph_close_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_morph_close_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_morph_close_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_morph_close_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagemorphcloseFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_frame_make(size : Int) -> ImagemorphcloseFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_frame_len(s : ImagemorphcloseFrame) -> Int { s.size }

pub fn image_morph_close_frame_get(s : ImagemorphcloseFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_frame_set(s : ImagemorphcloseFrame, i : Int, v : Double) -> ImagemorphcloseFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_close_frame_sum(s : ImagemorphcloseFrame) -> Double { @_common.sum(s.data) }

pub fn image_morph_close_frame_mean(s : ImagemorphcloseFrame) -> Double { @_common.mean(s.data) }

pub fn image_morph_close_frame_scale(s : ImagemorphcloseFrame, f : Double) -> ImagemorphcloseFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_close_frame_add(a : ImagemorphcloseFrame, b : ImagemorphcloseFrame) -> ImagemorphcloseFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_close_frame_copy(s : ImagemorphcloseFrame) -> ImagemorphcloseFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_close_frame_fill(s : ImagemorphcloseFrame, v : Double) -> ImagemorphcloseFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_close_frame_min(s : ImagemorphcloseFrame) -> Double { @_common.min(s.data) }

pub fn image_morph_close_frame_max(s : ImagemorphcloseFrame) -> Double { @_common.max(s.data) }

pub fn image_morph_close_frame_to_string(s : ImagemorphcloseFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_table_make(size : Int) -> ImagemorphcloseTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_table_len(s : ImagemorphcloseTable) -> Int { s.size }

pub fn image_morph_close_table_get(s : ImagemorphcloseTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_table_set(s : ImagemorphcloseTable, i : Int, v : Double) -> ImagemorphcloseTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_close_table_sum(s : ImagemorphcloseTable) -> Double { @_common.sum(s.data) }

pub fn image_morph_close_table_mean(s : ImagemorphcloseTable) -> Double { @_common.mean(s.data) }

pub fn image_morph_close_table_scale(s : ImagemorphcloseTable, f : Double) -> ImagemorphcloseTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_close_table_add(a : ImagemorphcloseTable, b : ImagemorphcloseTable) -> ImagemorphcloseTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_close_table_copy(s : ImagemorphcloseTable) -> ImagemorphcloseTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_close_table_fill(s : ImagemorphcloseTable, v : Double) -> ImagemorphcloseTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_close_table_min(s : ImagemorphcloseTable) -> Double { @_common.min(s.data) }

pub fn image_morph_close_table_max(s : ImagemorphcloseTable) -> Double { @_common.max(s.data) }

pub fn image_morph_close_table_to_string(s : ImagemorphcloseTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_graphn_make(size : Int) -> ImagemorphcloseGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_graphn_len(s : ImagemorphcloseGraphN) -> Int { s.size }

pub fn image_morph_close_graphn_get(s : ImagemorphcloseGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_graphn_set(s : ImagemorphcloseGraphN, i : Int, v : Double) -> ImagemorphcloseGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_close_graphn_sum(s : ImagemorphcloseGraphN) -> Double { @_common.sum(s.data) }

pub fn image_morph_close_graphn_mean(s : ImagemorphcloseGraphN) -> Double { @_common.mean(s.data) }

pub fn image_morph_close_graphn_scale(s : ImagemorphcloseGraphN, f : Double) -> ImagemorphcloseGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_close_graphn_add(a : ImagemorphcloseGraphN, b : ImagemorphcloseGraphN) -> ImagemorphcloseGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_close_graphn_copy(s : ImagemorphcloseGraphN) -> ImagemorphcloseGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_close_graphn_fill(s : ImagemorphcloseGraphN, v : Double) -> ImagemorphcloseGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_close_graphn_min(s : ImagemorphcloseGraphN) -> Double { @_common.min(s.data) }

pub fn image_morph_close_graphn_max(s : ImagemorphcloseGraphN) -> Double { @_common.max(s.data) }

pub fn image_morph_close_graphn_to_string(s : ImagemorphcloseGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_node_make(size : Int) -> ImagemorphcloseNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_node_len(s : ImagemorphcloseNode) -> Int { s.size }

pub fn image_morph_close_node_get(s : ImagemorphcloseNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_node_set(s : ImagemorphcloseNode, i : Int, v : Double) -> ImagemorphcloseNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_close_node_sum(s : ImagemorphcloseNode) -> Double { @_common.sum(s.data) }

pub fn image_morph_close_node_mean(s : ImagemorphcloseNode) -> Double { @_common.mean(s.data) }

pub fn image_morph_close_node_scale(s : ImagemorphcloseNode, f : Double) -> ImagemorphcloseNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_close_node_add(a : ImagemorphcloseNode, b : ImagemorphcloseNode) -> ImagemorphcloseNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_close_node_copy(s : ImagemorphcloseNode) -> ImagemorphcloseNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_close_node_fill(s : ImagemorphcloseNode, v : Double) -> ImagemorphcloseNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_close_node_min(s : ImagemorphcloseNode) -> Double { @_common.min(s.data) }

pub fn image_morph_close_node_max(s : ImagemorphcloseNode) -> Double { @_common.max(s.data) }

pub fn image_morph_close_node_to_string(s : ImagemorphcloseNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_edge_make(size : Int) -> ImagemorphcloseEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_edge_len(s : ImagemorphcloseEdge) -> Int { s.size }

pub fn image_morph_close_edge_get(s : ImagemorphcloseEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_edge_set(s : ImagemorphcloseEdge, i : Int, v : Double) -> ImagemorphcloseEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_close_edge_sum(s : ImagemorphcloseEdge) -> Double { @_common.sum(s.data) }

pub fn image_morph_close_edge_mean(s : ImagemorphcloseEdge) -> Double { @_common.mean(s.data) }

pub fn image_morph_close_edge_scale(s : ImagemorphcloseEdge, f : Double) -> ImagemorphcloseEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_close_edge_add(a : ImagemorphcloseEdge, b : ImagemorphcloseEdge) -> ImagemorphcloseEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_close_edge_copy(s : ImagemorphcloseEdge) -> ImagemorphcloseEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_close_edge_fill(s : ImagemorphcloseEdge, v : Double) -> ImagemorphcloseEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_close_edge_min(s : ImagemorphcloseEdge) -> Double { @_common.min(s.data) }

pub fn image_morph_close_edge_max(s : ImagemorphcloseEdge) -> Double { @_common.max(s.data) }

pub fn image_morph_close_edge_to_string(s : ImagemorphcloseEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphclosePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_path_make(size : Int) -> ImagemorphclosePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_path_len(s : ImagemorphclosePath) -> Int { s.size }

pub fn image_morph_close_path_get(s : ImagemorphclosePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_path_set(s : ImagemorphclosePath, i : Int, v : Double) -> ImagemorphclosePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_close_path_sum(s : ImagemorphclosePath) -> Double { @_common.sum(s.data) }

pub fn image_morph_close_path_mean(s : ImagemorphclosePath) -> Double { @_common.mean(s.data) }

pub fn image_morph_close_path_scale(s : ImagemorphclosePath, f : Double) -> ImagemorphclosePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_close_path_add(a : ImagemorphclosePath, b : ImagemorphclosePath) -> ImagemorphclosePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_close_path_copy(s : ImagemorphclosePath) -> ImagemorphclosePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_close_path_fill(s : ImagemorphclosePath, v : Double) -> ImagemorphclosePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_close_path_min(s : ImagemorphclosePath) -> Double { @_common.min(s.data) }

pub fn image_morph_close_path_max(s : ImagemorphclosePath) -> Double { @_common.max(s.data) }

pub fn image_morph_close_path_to_string(s : ImagemorphclosePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_cluster_make(size : Int) -> ImagemorphcloseCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_cluster_len(s : ImagemorphcloseCluster) -> Int { s.size }

pub fn image_morph_close_cluster_get(s : ImagemorphcloseCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_cluster_set(s : ImagemorphcloseCluster, i : Int, v : Double) -> ImagemorphcloseCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_close_cluster_sum(s : ImagemorphcloseCluster) -> Double { @_common.sum(s.data) }

pub fn image_morph_close_cluster_mean(s : ImagemorphcloseCluster) -> Double { @_common.mean(s.data) }

pub fn image_morph_close_cluster_scale(s : ImagemorphcloseCluster, f : Double) -> ImagemorphcloseCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_close_cluster_add(a : ImagemorphcloseCluster, b : ImagemorphcloseCluster) -> ImagemorphcloseCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_close_cluster_copy(s : ImagemorphcloseCluster) -> ImagemorphcloseCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_close_cluster_fill(s : ImagemorphcloseCluster, v : Double) -> ImagemorphcloseCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_close_cluster_min(s : ImagemorphcloseCluster) -> Double { @_common.min(s.data) }

pub fn image_morph_close_cluster_max(s : ImagemorphcloseCluster) -> Double { @_common.max(s.data) }

pub fn image_morph_close_cluster_to_string(s : ImagemorphcloseCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_model_make(size : Int) -> ImagemorphcloseModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_model_len(s : ImagemorphcloseModel) -> Int { s.size }

pub fn image_morph_close_model_get(s : ImagemorphcloseModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_model_set(s : ImagemorphcloseModel, i : Int, v : Double) -> ImagemorphcloseModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_close_model_sum(s : ImagemorphcloseModel) -> Double { @_common.sum(s.data) }

pub fn image_morph_close_model_mean(s : ImagemorphcloseModel) -> Double { @_common.mean(s.data) }

pub fn image_morph_close_model_scale(s : ImagemorphcloseModel, f : Double) -> ImagemorphcloseModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_close_model_add(a : ImagemorphcloseModel, b : ImagemorphcloseModel) -> ImagemorphcloseModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_close_model_copy(s : ImagemorphcloseModel) -> ImagemorphcloseModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_close_model_fill(s : ImagemorphcloseModel, v : Double) -> ImagemorphcloseModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_close_model_min(s : ImagemorphcloseModel) -> Double { @_common.min(s.data) }

pub fn image_morph_close_model_max(s : ImagemorphcloseModel) -> Double { @_common.max(s.data) }

pub fn image_morph_close_model_to_string(s : ImagemorphcloseModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_layer_make(size : Int) -> ImagemorphcloseLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_layer_len(s : ImagemorphcloseLayer) -> Int { s.size }

pub fn image_morph_close_layer_get(s : ImagemorphcloseLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_layer_set(s : ImagemorphcloseLayer, i : Int, v : Double) -> ImagemorphcloseLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_close_layer_sum(s : ImagemorphcloseLayer) -> Double { @_common.sum(s.data) }

pub fn image_morph_close_layer_mean(s : ImagemorphcloseLayer) -> Double { @_common.mean(s.data) }

pub fn image_morph_close_layer_scale(s : ImagemorphcloseLayer, f : Double) -> ImagemorphcloseLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_close_layer_add(a : ImagemorphcloseLayer, b : ImagemorphcloseLayer) -> ImagemorphcloseLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_close_layer_copy(s : ImagemorphcloseLayer) -> ImagemorphcloseLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_close_layer_fill(s : ImagemorphcloseLayer, v : Double) -> ImagemorphcloseLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_close_layer_min(s : ImagemorphcloseLayer) -> Double { @_common.min(s.data) }

pub fn image_morph_close_layer_max(s : ImagemorphcloseLayer) -> Double { @_common.max(s.data) }

pub fn image_morph_close_layer_to_string(s : ImagemorphcloseLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_buffer_make(size : Int) -> ImagemorphcloseBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_buffer_len(s : ImagemorphcloseBuffer) -> Int { s.size }

pub fn image_morph_close_buffer_get(s : ImagemorphcloseBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_buffer_set(s : ImagemorphcloseBuffer, i : Int, v : Double) -> ImagemorphcloseBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_close_buffer_sum(s : ImagemorphcloseBuffer) -> Double { @_common.sum(s.data) }

pub fn image_morph_close_buffer_mean(s : ImagemorphcloseBuffer) -> Double { @_common.mean(s.data) }

pub fn image_morph_close_buffer_scale(s : ImagemorphcloseBuffer, f : Double) -> ImagemorphcloseBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_close_buffer_add(a : ImagemorphcloseBuffer, b : ImagemorphcloseBuffer) -> ImagemorphcloseBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_close_buffer_copy(s : ImagemorphcloseBuffer) -> ImagemorphcloseBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_close_buffer_fill(s : ImagemorphcloseBuffer, v : Double) -> ImagemorphcloseBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_close_buffer_min(s : ImagemorphcloseBuffer) -> Double { @_common.min(s.data) }

pub fn image_morph_close_buffer_max(s : ImagemorphcloseBuffer) -> Double { @_common.max(s.data) }

pub fn image_morph_close_buffer_to_string(s : ImagemorphcloseBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_cursor_make(size : Int) -> ImagemorphcloseCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_cursor_len(s : ImagemorphcloseCursor) -> Int { s.size }

pub fn image_morph_close_cursor_get(s : ImagemorphcloseCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_cursor_set(s : ImagemorphcloseCursor, i : Int, v : Double) -> ImagemorphcloseCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_close_cursor_sum(s : ImagemorphcloseCursor) -> Double { @_common.sum(s.data) }

pub fn image_morph_close_cursor_mean(s : ImagemorphcloseCursor) -> Double { @_common.mean(s.data) }

pub fn image_morph_close_cursor_scale(s : ImagemorphcloseCursor, f : Double) -> ImagemorphcloseCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_close_cursor_add(a : ImagemorphcloseCursor, b : ImagemorphcloseCursor) -> ImagemorphcloseCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_close_cursor_copy(s : ImagemorphcloseCursor) -> ImagemorphcloseCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_close_cursor_fill(s : ImagemorphcloseCursor, v : Double) -> ImagemorphcloseCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_close_cursor_min(s : ImagemorphcloseCursor) -> Double { @_common.min(s.data) }

pub fn image_morph_close_cursor_max(s : ImagemorphcloseCursor) -> Double { @_common.max(s.data) }

pub fn image_morph_close_cursor_to_string(s : ImagemorphcloseCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_view_make(size : Int) -> ImagemorphcloseView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_view_len(s : ImagemorphcloseView) -> Int { s.size }

pub fn image_morph_close_view_get(s : ImagemorphcloseView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_view_set(s : ImagemorphcloseView, i : Int, v : Double) -> ImagemorphcloseView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_close_view_sum(s : ImagemorphcloseView) -> Double { @_common.sum(s.data) }

pub fn image_morph_close_view_mean(s : ImagemorphcloseView) -> Double { @_common.mean(s.data) }

pub fn image_morph_close_view_scale(s : ImagemorphcloseView, f : Double) -> ImagemorphcloseView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_close_view_add(a : ImagemorphcloseView, b : ImagemorphcloseView) -> ImagemorphcloseView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_close_view_copy(s : ImagemorphcloseView) -> ImagemorphcloseView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_close_view_fill(s : ImagemorphcloseView, v : Double) -> ImagemorphcloseView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_close_view_min(s : ImagemorphcloseView) -> Double { @_common.min(s.data) }

pub fn image_morph_close_view_max(s : ImagemorphcloseView) -> Double { @_common.max(s.data) }

pub fn image_morph_close_view_to_string(s : ImagemorphcloseView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_range_make(size : Int) -> ImagemorphcloseRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_range_len(s : ImagemorphcloseRange) -> Int { s.size }

pub fn image_morph_close_range_get(s : ImagemorphcloseRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_range_set(s : ImagemorphcloseRange, i : Int, v : Double) -> ImagemorphcloseRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_close_range_sum(s : ImagemorphcloseRange) -> Double { @_common.sum(s.data) }

pub fn image_morph_close_range_mean(s : ImagemorphcloseRange) -> Double { @_common.mean(s.data) }

pub fn image_morph_close_range_scale(s : ImagemorphcloseRange, f : Double) -> ImagemorphcloseRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_close_range_add(a : ImagemorphcloseRange, b : ImagemorphcloseRange) -> ImagemorphcloseRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_close_range_copy(s : ImagemorphcloseRange) -> ImagemorphcloseRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_close_range_fill(s : ImagemorphcloseRange, v : Double) -> ImagemorphcloseRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_close_range_min(s : ImagemorphcloseRange) -> Double { @_common.min(s.data) }

pub fn image_morph_close_range_max(s : ImagemorphcloseRange) -> Double { @_common.max(s.data) }

pub fn image_morph_close_range_to_string(s : ImagemorphcloseRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_slice_make(size : Int) -> ImagemorphcloseSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_slice_len(s : ImagemorphcloseSlice) -> Int { s.size }

pub fn image_morph_close_slice_get(s : ImagemorphcloseSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_slice_set(s : ImagemorphcloseSlice, i : Int, v : Double) -> ImagemorphcloseSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_close_slice_sum(s : ImagemorphcloseSlice) -> Double { @_common.sum(s.data) }

pub fn image_morph_close_slice_mean(s : ImagemorphcloseSlice) -> Double { @_common.mean(s.data) }

pub fn image_morph_close_slice_scale(s : ImagemorphcloseSlice, f : Double) -> ImagemorphcloseSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_close_slice_add(a : ImagemorphcloseSlice, b : ImagemorphcloseSlice) -> ImagemorphcloseSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_close_slice_copy(s : ImagemorphcloseSlice) -> ImagemorphcloseSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_close_slice_fill(s : ImagemorphcloseSlice, v : Double) -> ImagemorphcloseSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_close_slice_min(s : ImagemorphcloseSlice) -> Double { @_common.min(s.data) }

pub fn image_morph_close_slice_max(s : ImagemorphcloseSlice) -> Double { @_common.max(s.data) }

pub fn image_morph_close_slice_to_string(s : ImagemorphcloseSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

