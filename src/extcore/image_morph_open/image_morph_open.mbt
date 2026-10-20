///===
/// extcore/image_morph_open

pub(all) struct ImagemorphopenPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_open_make_point(x : Double, y : Double) -> ImagemorphopenPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_open_make_point3(x : Double, y : Double, z : Double) -> ImagemorphopenPoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphopenPoint::x(self : ImagemorphopenPoint) -> Double { self.x }

pub fn ImagemorphopenPoint::y(self : ImagemorphopenPoint) -> Double { self.y }

pub fn ImagemorphopenPoint::z(self : ImagemorphopenPoint) -> Double { self.z }

pub fn ImagemorphopenPoint::label(self : ImagemorphopenPoint) -> Int { self.label }

pub fn ImagemorphopenPoint::dist(self : ImagemorphopenPoint, other : ImagemorphopenPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphopenPoint::add(self : ImagemorphopenPoint, other : ImagemorphopenPoint) -> ImagemorphopenPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphopenPoint::sub(self : ImagemorphopenPoint, other : ImagemorphopenPoint) -> ImagemorphopenPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphopenPoint::scale(self : ImagemorphopenPoint, s : Double) -> ImagemorphopenPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphopenPoint::dot(self : ImagemorphopenPoint, other : ImagemorphopenPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphopenPoint::cross(self : ImagemorphopenPoint, other : ImagemorphopenPoint) -> ImagemorphopenPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphopenPoint::norm(self : ImagemorphopenPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphopenPoint::normalize(self : ImagemorphopenPoint) -> ImagemorphopenPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphopenPoint::negate(self : ImagemorphopenPoint) -> ImagemorphopenPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphopenPoint::mid(self : ImagemorphopenPoint, other : ImagemorphopenPoint) -> ImagemorphopenPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphopenPoint::lerp(self : ImagemorphopenPoint, other : ImagemorphopenPoint, t : Double) -> ImagemorphopenPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphopenPoint::to_string(self : ImagemorphopenPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphopenSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_open_make_series(vals : Array[Double], name : String) -> ImagemorphopenSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphopenSeries::len(self : ImagemorphopenSeries) -> Int { self.vals.length() }

pub fn ImagemorphopenSeries::sum(self : ImagemorphopenSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphopenSeries::mean(self : ImagemorphopenSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphopenSeries::min(self : ImagemorphopenSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphopenSeries::max(self : ImagemorphopenSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphopenSeries::range(self : ImagemorphopenSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphopenSeries::variance(self : ImagemorphopenSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphopenSeries::std(self : ImagemorphopenSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphopenSeries::median(self : ImagemorphopenSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphopenSeries::scale(self : ImagemorphopenSeries, f : Double) -> ImagemorphopenSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphopenSeries::add(self : ImagemorphopenSeries, other : ImagemorphopenSeries) -> ImagemorphopenSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphopenSeries::sub(self : ImagemorphopenSeries, other : ImagemorphopenSeries) -> ImagemorphopenSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphopenSeries::normalize(self : ImagemorphopenSeries) -> ImagemorphopenSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphopenSeries::cumsum(self : ImagemorphopenSeries) -> ImagemorphopenSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphopenSeries::to_string(self : ImagemorphopenSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphopenMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_open_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphopenMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_open_matrix_identity(n : Int) -> ImagemorphopenMatrix {
  let m = image_morph_open_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphopenMatrix::get(self : ImagemorphopenMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphopenMatrix::transpose(self : ImagemorphopenMatrix) -> ImagemorphopenMatrix {
  let result = image_morph_open_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphopenMatrix::add(self : ImagemorphopenMatrix, other : ImagemorphopenMatrix) -> ImagemorphopenMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_open_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphopenMatrix::scale(self : ImagemorphopenMatrix, s : Double) -> ImagemorphopenMatrix {
  let result = image_morph_open_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphopenMatrix::multiply(self : ImagemorphopenMatrix, other : ImagemorphopenMatrix) -> ImagemorphopenMatrix {
  if self.cols != other.rows { return image_morph_open_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_open_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagemorphopenMatrix::trace(self : ImagemorphopenMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphopenMatrix::det(self : ImagemorphopenMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphopenMatrix::norm(self : ImagemorphopenMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphopenMatrix::to_string(self : ImagemorphopenMatrix) -> String {
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

pub(all) struct ImagemorphopenVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_open_make_vector(comps : Array[Double]) -> ImagemorphopenVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_open_vector_zero(dim : Int) -> ImagemorphopenVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphopenVector::add(self : ImagemorphopenVector, other : ImagemorphopenVector) -> ImagemorphopenVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphopenVector::sub(self : ImagemorphopenVector, other : ImagemorphopenVector) -> ImagemorphopenVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphopenVector::scale(self : ImagemorphopenVector, s : Double) -> ImagemorphopenVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphopenVector::dot(self : ImagemorphopenVector, other : ImagemorphopenVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphopenVector::norm(self : ImagemorphopenVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphopenVector::normalize(self : ImagemorphopenVector) -> ImagemorphopenVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphopenVector::dist(self : ImagemorphopenVector, other : ImagemorphopenVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphopenVector::to_string(self : ImagemorphopenVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_open_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_morph_open_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_morph_open_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_morph_open_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_morph_open_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_morph_open_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_morph_open_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_morph_open_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_morph_open_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_morph_open_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_morph_open_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_morph_open_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_morph_open_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_morph_open_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_morph_open_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_morph_open_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_morph_open_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_morph_open_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_morph_open_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_morph_open_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_morph_open_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_morph_open_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_morph_open_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_morph_open_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_morph_open_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_morph_open_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_morph_open_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_morph_open_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_morph_open_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagemorphopenFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_frame_make(size : Int) -> ImagemorphopenFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_frame_len(s : ImagemorphopenFrame) -> Int { s.size }

pub fn image_morph_open_frame_get(s : ImagemorphopenFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_frame_set(s : ImagemorphopenFrame, i : Int, v : Double) -> ImagemorphopenFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_frame_sum(s : ImagemorphopenFrame) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_frame_mean(s : ImagemorphopenFrame) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_frame_scale(s : ImagemorphopenFrame, f : Double) -> ImagemorphopenFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_frame_add(a : ImagemorphopenFrame, b : ImagemorphopenFrame) -> ImagemorphopenFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_frame_copy(s : ImagemorphopenFrame) -> ImagemorphopenFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_frame_fill(s : ImagemorphopenFrame, v : Double) -> ImagemorphopenFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_frame_min(s : ImagemorphopenFrame) -> Double { @_common.min(s.data) }

pub fn image_morph_open_frame_max(s : ImagemorphopenFrame) -> Double { @_common.max(s.data) }

pub fn image_morph_open_frame_to_string(s : ImagemorphopenFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_table_make(size : Int) -> ImagemorphopenTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_table_len(s : ImagemorphopenTable) -> Int { s.size }

pub fn image_morph_open_table_get(s : ImagemorphopenTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_table_set(s : ImagemorphopenTable, i : Int, v : Double) -> ImagemorphopenTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_table_sum(s : ImagemorphopenTable) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_table_mean(s : ImagemorphopenTable) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_table_scale(s : ImagemorphopenTable, f : Double) -> ImagemorphopenTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_table_add(a : ImagemorphopenTable, b : ImagemorphopenTable) -> ImagemorphopenTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_table_copy(s : ImagemorphopenTable) -> ImagemorphopenTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_table_fill(s : ImagemorphopenTable, v : Double) -> ImagemorphopenTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_table_min(s : ImagemorphopenTable) -> Double { @_common.min(s.data) }

pub fn image_morph_open_table_max(s : ImagemorphopenTable) -> Double { @_common.max(s.data) }

pub fn image_morph_open_table_to_string(s : ImagemorphopenTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_graphn_make(size : Int) -> ImagemorphopenGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_graphn_len(s : ImagemorphopenGraphN) -> Int { s.size }

pub fn image_morph_open_graphn_get(s : ImagemorphopenGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_graphn_set(s : ImagemorphopenGraphN, i : Int, v : Double) -> ImagemorphopenGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_graphn_sum(s : ImagemorphopenGraphN) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_graphn_mean(s : ImagemorphopenGraphN) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_graphn_scale(s : ImagemorphopenGraphN, f : Double) -> ImagemorphopenGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_graphn_add(a : ImagemorphopenGraphN, b : ImagemorphopenGraphN) -> ImagemorphopenGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_graphn_copy(s : ImagemorphopenGraphN) -> ImagemorphopenGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_graphn_fill(s : ImagemorphopenGraphN, v : Double) -> ImagemorphopenGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_graphn_min(s : ImagemorphopenGraphN) -> Double { @_common.min(s.data) }

pub fn image_morph_open_graphn_max(s : ImagemorphopenGraphN) -> Double { @_common.max(s.data) }

pub fn image_morph_open_graphn_to_string(s : ImagemorphopenGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_node_make(size : Int) -> ImagemorphopenNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_node_len(s : ImagemorphopenNode) -> Int { s.size }

pub fn image_morph_open_node_get(s : ImagemorphopenNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_node_set(s : ImagemorphopenNode, i : Int, v : Double) -> ImagemorphopenNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_node_sum(s : ImagemorphopenNode) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_node_mean(s : ImagemorphopenNode) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_node_scale(s : ImagemorphopenNode, f : Double) -> ImagemorphopenNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_node_add(a : ImagemorphopenNode, b : ImagemorphopenNode) -> ImagemorphopenNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_node_copy(s : ImagemorphopenNode) -> ImagemorphopenNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_node_fill(s : ImagemorphopenNode, v : Double) -> ImagemorphopenNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_node_min(s : ImagemorphopenNode) -> Double { @_common.min(s.data) }

pub fn image_morph_open_node_max(s : ImagemorphopenNode) -> Double { @_common.max(s.data) }

pub fn image_morph_open_node_to_string(s : ImagemorphopenNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_edge_make(size : Int) -> ImagemorphopenEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_edge_len(s : ImagemorphopenEdge) -> Int { s.size }

pub fn image_morph_open_edge_get(s : ImagemorphopenEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_edge_set(s : ImagemorphopenEdge, i : Int, v : Double) -> ImagemorphopenEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_edge_sum(s : ImagemorphopenEdge) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_edge_mean(s : ImagemorphopenEdge) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_edge_scale(s : ImagemorphopenEdge, f : Double) -> ImagemorphopenEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_edge_add(a : ImagemorphopenEdge, b : ImagemorphopenEdge) -> ImagemorphopenEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_edge_copy(s : ImagemorphopenEdge) -> ImagemorphopenEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_edge_fill(s : ImagemorphopenEdge, v : Double) -> ImagemorphopenEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_edge_min(s : ImagemorphopenEdge) -> Double { @_common.min(s.data) }

pub fn image_morph_open_edge_max(s : ImagemorphopenEdge) -> Double { @_common.max(s.data) }

pub fn image_morph_open_edge_to_string(s : ImagemorphopenEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_path_make(size : Int) -> ImagemorphopenPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_path_len(s : ImagemorphopenPath) -> Int { s.size }

pub fn image_morph_open_path_get(s : ImagemorphopenPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_path_set(s : ImagemorphopenPath, i : Int, v : Double) -> ImagemorphopenPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_path_sum(s : ImagemorphopenPath) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_path_mean(s : ImagemorphopenPath) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_path_scale(s : ImagemorphopenPath, f : Double) -> ImagemorphopenPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_path_add(a : ImagemorphopenPath, b : ImagemorphopenPath) -> ImagemorphopenPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_path_copy(s : ImagemorphopenPath) -> ImagemorphopenPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_path_fill(s : ImagemorphopenPath, v : Double) -> ImagemorphopenPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_path_min(s : ImagemorphopenPath) -> Double { @_common.min(s.data) }

pub fn image_morph_open_path_max(s : ImagemorphopenPath) -> Double { @_common.max(s.data) }

pub fn image_morph_open_path_to_string(s : ImagemorphopenPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_cluster_make(size : Int) -> ImagemorphopenCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_cluster_len(s : ImagemorphopenCluster) -> Int { s.size }

pub fn image_morph_open_cluster_get(s : ImagemorphopenCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_cluster_set(s : ImagemorphopenCluster, i : Int, v : Double) -> ImagemorphopenCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_cluster_sum(s : ImagemorphopenCluster) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_cluster_mean(s : ImagemorphopenCluster) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_cluster_scale(s : ImagemorphopenCluster, f : Double) -> ImagemorphopenCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_cluster_add(a : ImagemorphopenCluster, b : ImagemorphopenCluster) -> ImagemorphopenCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_cluster_copy(s : ImagemorphopenCluster) -> ImagemorphopenCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_cluster_fill(s : ImagemorphopenCluster, v : Double) -> ImagemorphopenCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_cluster_min(s : ImagemorphopenCluster) -> Double { @_common.min(s.data) }

pub fn image_morph_open_cluster_max(s : ImagemorphopenCluster) -> Double { @_common.max(s.data) }

pub fn image_morph_open_cluster_to_string(s : ImagemorphopenCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_model_make(size : Int) -> ImagemorphopenModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_model_len(s : ImagemorphopenModel) -> Int { s.size }

pub fn image_morph_open_model_get(s : ImagemorphopenModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_model_set(s : ImagemorphopenModel, i : Int, v : Double) -> ImagemorphopenModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_model_sum(s : ImagemorphopenModel) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_model_mean(s : ImagemorphopenModel) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_model_scale(s : ImagemorphopenModel, f : Double) -> ImagemorphopenModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_model_add(a : ImagemorphopenModel, b : ImagemorphopenModel) -> ImagemorphopenModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_model_copy(s : ImagemorphopenModel) -> ImagemorphopenModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_model_fill(s : ImagemorphopenModel, v : Double) -> ImagemorphopenModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_model_min(s : ImagemorphopenModel) -> Double { @_common.min(s.data) }

pub fn image_morph_open_model_max(s : ImagemorphopenModel) -> Double { @_common.max(s.data) }

pub fn image_morph_open_model_to_string(s : ImagemorphopenModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_layer_make(size : Int) -> ImagemorphopenLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_layer_len(s : ImagemorphopenLayer) -> Int { s.size }

pub fn image_morph_open_layer_get(s : ImagemorphopenLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_layer_set(s : ImagemorphopenLayer, i : Int, v : Double) -> ImagemorphopenLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_layer_sum(s : ImagemorphopenLayer) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_layer_mean(s : ImagemorphopenLayer) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_layer_scale(s : ImagemorphopenLayer, f : Double) -> ImagemorphopenLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_layer_add(a : ImagemorphopenLayer, b : ImagemorphopenLayer) -> ImagemorphopenLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_layer_copy(s : ImagemorphopenLayer) -> ImagemorphopenLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_layer_fill(s : ImagemorphopenLayer, v : Double) -> ImagemorphopenLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_layer_min(s : ImagemorphopenLayer) -> Double { @_common.min(s.data) }

pub fn image_morph_open_layer_max(s : ImagemorphopenLayer) -> Double { @_common.max(s.data) }

pub fn image_morph_open_layer_to_string(s : ImagemorphopenLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_buffer_make(size : Int) -> ImagemorphopenBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_buffer_len(s : ImagemorphopenBuffer) -> Int { s.size }

pub fn image_morph_open_buffer_get(s : ImagemorphopenBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_buffer_set(s : ImagemorphopenBuffer, i : Int, v : Double) -> ImagemorphopenBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_buffer_sum(s : ImagemorphopenBuffer) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_buffer_mean(s : ImagemorphopenBuffer) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_buffer_scale(s : ImagemorphopenBuffer, f : Double) -> ImagemorphopenBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_buffer_add(a : ImagemorphopenBuffer, b : ImagemorphopenBuffer) -> ImagemorphopenBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_buffer_copy(s : ImagemorphopenBuffer) -> ImagemorphopenBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_buffer_fill(s : ImagemorphopenBuffer, v : Double) -> ImagemorphopenBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_buffer_min(s : ImagemorphopenBuffer) -> Double { @_common.min(s.data) }

pub fn image_morph_open_buffer_max(s : ImagemorphopenBuffer) -> Double { @_common.max(s.data) }

pub fn image_morph_open_buffer_to_string(s : ImagemorphopenBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_cursor_make(size : Int) -> ImagemorphopenCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_cursor_len(s : ImagemorphopenCursor) -> Int { s.size }

pub fn image_morph_open_cursor_get(s : ImagemorphopenCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_cursor_set(s : ImagemorphopenCursor, i : Int, v : Double) -> ImagemorphopenCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_cursor_sum(s : ImagemorphopenCursor) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_cursor_mean(s : ImagemorphopenCursor) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_cursor_scale(s : ImagemorphopenCursor, f : Double) -> ImagemorphopenCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_cursor_add(a : ImagemorphopenCursor, b : ImagemorphopenCursor) -> ImagemorphopenCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_cursor_copy(s : ImagemorphopenCursor) -> ImagemorphopenCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_cursor_fill(s : ImagemorphopenCursor, v : Double) -> ImagemorphopenCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_cursor_min(s : ImagemorphopenCursor) -> Double { @_common.min(s.data) }

pub fn image_morph_open_cursor_max(s : ImagemorphopenCursor) -> Double { @_common.max(s.data) }

pub fn image_morph_open_cursor_to_string(s : ImagemorphopenCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_view_make(size : Int) -> ImagemorphopenView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_view_len(s : ImagemorphopenView) -> Int { s.size }

pub fn image_morph_open_view_get(s : ImagemorphopenView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_view_set(s : ImagemorphopenView, i : Int, v : Double) -> ImagemorphopenView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_view_sum(s : ImagemorphopenView) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_view_mean(s : ImagemorphopenView) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_view_scale(s : ImagemorphopenView, f : Double) -> ImagemorphopenView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_view_add(a : ImagemorphopenView, b : ImagemorphopenView) -> ImagemorphopenView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_view_copy(s : ImagemorphopenView) -> ImagemorphopenView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_view_fill(s : ImagemorphopenView, v : Double) -> ImagemorphopenView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_view_min(s : ImagemorphopenView) -> Double { @_common.min(s.data) }

pub fn image_morph_open_view_max(s : ImagemorphopenView) -> Double { @_common.max(s.data) }

pub fn image_morph_open_view_to_string(s : ImagemorphopenView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_range_make(size : Int) -> ImagemorphopenRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_range_len(s : ImagemorphopenRange) -> Int { s.size }

pub fn image_morph_open_range_get(s : ImagemorphopenRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_range_set(s : ImagemorphopenRange, i : Int, v : Double) -> ImagemorphopenRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_range_sum(s : ImagemorphopenRange) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_range_mean(s : ImagemorphopenRange) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_range_scale(s : ImagemorphopenRange, f : Double) -> ImagemorphopenRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_range_add(a : ImagemorphopenRange, b : ImagemorphopenRange) -> ImagemorphopenRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_range_copy(s : ImagemorphopenRange) -> ImagemorphopenRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_range_fill(s : ImagemorphopenRange, v : Double) -> ImagemorphopenRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_range_min(s : ImagemorphopenRange) -> Double { @_common.min(s.data) }

pub fn image_morph_open_range_max(s : ImagemorphopenRange) -> Double { @_common.max(s.data) }

pub fn image_morph_open_range_to_string(s : ImagemorphopenRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_slice_make(size : Int) -> ImagemorphopenSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_slice_len(s : ImagemorphopenSlice) -> Int { s.size }

pub fn image_morph_open_slice_get(s : ImagemorphopenSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_slice_set(s : ImagemorphopenSlice, i : Int, v : Double) -> ImagemorphopenSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_slice_sum(s : ImagemorphopenSlice) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_slice_mean(s : ImagemorphopenSlice) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_slice_scale(s : ImagemorphopenSlice, f : Double) -> ImagemorphopenSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_slice_add(a : ImagemorphopenSlice, b : ImagemorphopenSlice) -> ImagemorphopenSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_slice_copy(s : ImagemorphopenSlice) -> ImagemorphopenSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_slice_fill(s : ImagemorphopenSlice, v : Double) -> ImagemorphopenSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_slice_min(s : ImagemorphopenSlice) -> Double { @_common.min(s.data) }

pub fn image_morph_open_slice_max(s : ImagemorphopenSlice) -> Double { @_common.max(s.data) }

pub fn image_morph_open_slice_to_string(s : ImagemorphopenSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

