///===
/// extcore/image_filter_laplacian

pub(all) struct ImagefilterlaplacianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_laplacian_make_point(x : Double, y : Double) -> ImagefilterlaplacianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_laplacian_make_point3(x : Double, y : Double, z : Double) -> ImagefilterlaplacianPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefilterlaplacianPoint::x(self : ImagefilterlaplacianPoint) -> Double { self.x }

pub fn ImagefilterlaplacianPoint::y(self : ImagefilterlaplacianPoint) -> Double { self.y }

pub fn ImagefilterlaplacianPoint::z(self : ImagefilterlaplacianPoint) -> Double { self.z }

pub fn ImagefilterlaplacianPoint::label(self : ImagefilterlaplacianPoint) -> Int { self.label }

pub fn ImagefilterlaplacianPoint::dist(self : ImagefilterlaplacianPoint, other : ImagefilterlaplacianPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefilterlaplacianPoint::add(self : ImagefilterlaplacianPoint, other : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefilterlaplacianPoint::sub(self : ImagefilterlaplacianPoint, other : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefilterlaplacianPoint::scale(self : ImagefilterlaplacianPoint, s : Double) -> ImagefilterlaplacianPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefilterlaplacianPoint::dot(self : ImagefilterlaplacianPoint, other : ImagefilterlaplacianPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefilterlaplacianPoint::cross(self : ImagefilterlaplacianPoint, other : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefilterlaplacianPoint::norm(self : ImagefilterlaplacianPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefilterlaplacianPoint::normalize(self : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefilterlaplacianPoint::negate(self : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefilterlaplacianPoint::mid(self : ImagefilterlaplacianPoint, other : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefilterlaplacianPoint::lerp(self : ImagefilterlaplacianPoint, other : ImagefilterlaplacianPoint, t : Double) -> ImagefilterlaplacianPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefilterlaplacianPoint::to_string(self : ImagefilterlaplacianPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_laplacian_make_series(vals : Array[Double], name : String) -> ImagefilterlaplacianSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefilterlaplacianSeries::len(self : ImagefilterlaplacianSeries) -> Int { self.vals.length() }

pub fn ImagefilterlaplacianSeries::sum(self : ImagefilterlaplacianSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefilterlaplacianSeries::mean(self : ImagefilterlaplacianSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefilterlaplacianSeries::min(self : ImagefilterlaplacianSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefilterlaplacianSeries::max(self : ImagefilterlaplacianSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefilterlaplacianSeries::range(self : ImagefilterlaplacianSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefilterlaplacianSeries::variance(self : ImagefilterlaplacianSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefilterlaplacianSeries::std(self : ImagefilterlaplacianSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefilterlaplacianSeries::median(self : ImagefilterlaplacianSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefilterlaplacianSeries::scale(self : ImagefilterlaplacianSeries, f : Double) -> ImagefilterlaplacianSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefilterlaplacianSeries::add(self : ImagefilterlaplacianSeries, other : ImagefilterlaplacianSeries) -> ImagefilterlaplacianSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefilterlaplacianSeries::sub(self : ImagefilterlaplacianSeries, other : ImagefilterlaplacianSeries) -> ImagefilterlaplacianSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefilterlaplacianSeries::normalize(self : ImagefilterlaplacianSeries) -> ImagefilterlaplacianSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefilterlaplacianSeries::cumsum(self : ImagefilterlaplacianSeries) -> ImagefilterlaplacianSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefilterlaplacianSeries::to_string(self : ImagefilterlaplacianSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefilterlaplacianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_laplacian_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefilterlaplacianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_laplacian_matrix_identity(n : Int) -> ImagefilterlaplacianMatrix {
  let m = image_filter_laplacian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefilterlaplacianMatrix::get(self : ImagefilterlaplacianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefilterlaplacianMatrix::transpose(self : ImagefilterlaplacianMatrix) -> ImagefilterlaplacianMatrix {
  let result = image_filter_laplacian_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefilterlaplacianMatrix::add(self : ImagefilterlaplacianMatrix, other : ImagefilterlaplacianMatrix) -> ImagefilterlaplacianMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_filter_laplacian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefilterlaplacianMatrix::scale(self : ImagefilterlaplacianMatrix, s : Double) -> ImagefilterlaplacianMatrix {
  let result = image_filter_laplacian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefilterlaplacianMatrix::multiply(self : ImagefilterlaplacianMatrix, other : ImagefilterlaplacianMatrix) -> ImagefilterlaplacianMatrix {
  if self.cols != other.rows { return image_filter_laplacian_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_filter_laplacian_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefilterlaplacianMatrix::trace(self : ImagefilterlaplacianMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefilterlaplacianMatrix::det(self : ImagefilterlaplacianMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefilterlaplacianMatrix::norm(self : ImagefilterlaplacianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefilterlaplacianMatrix::to_string(self : ImagefilterlaplacianMatrix) -> String {
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

pub(all) struct ImagefilterlaplacianVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_laplacian_make_vector(comps : Array[Double]) -> ImagefilterlaplacianVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_laplacian_vector_zero(dim : Int) -> ImagefilterlaplacianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefilterlaplacianVector::add(self : ImagefilterlaplacianVector, other : ImagefilterlaplacianVector) -> ImagefilterlaplacianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefilterlaplacianVector::sub(self : ImagefilterlaplacianVector, other : ImagefilterlaplacianVector) -> ImagefilterlaplacianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefilterlaplacianVector::scale(self : ImagefilterlaplacianVector, s : Double) -> ImagefilterlaplacianVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefilterlaplacianVector::dot(self : ImagefilterlaplacianVector, other : ImagefilterlaplacianVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefilterlaplacianVector::norm(self : ImagefilterlaplacianVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefilterlaplacianVector::normalize(self : ImagefilterlaplacianVector) -> ImagefilterlaplacianVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefilterlaplacianVector::dist(self : ImagefilterlaplacianVector, other : ImagefilterlaplacianVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefilterlaplacianVector::to_string(self : ImagefilterlaplacianVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_laplacian_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_laplacian_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_laplacian_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_laplacian_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_laplacian_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_laplacian_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_laplacian_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_laplacian_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_laplacian_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_laplacian_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_laplacian_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_laplacian_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_laplacian_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_laplacian_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_laplacian_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_laplacian_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_laplacian_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_laplacian_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_laplacian_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_laplacian_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_laplacian_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_laplacian_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_laplacian_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_laplacian_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_laplacian_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_laplacian_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_laplacian_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_laplacian_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_laplacian_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefilterlaplacianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_frame_make(size : Int) -> ImagefilterlaplacianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_frame_len(s : ImagefilterlaplacianFrame) -> Int { s.size }

pub fn image_filter_laplacian_frame_get(s : ImagefilterlaplacianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_frame_set(s : ImagefilterlaplacianFrame, i : Int, v : Double) -> ImagefilterlaplacianFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_frame_sum(s : ImagefilterlaplacianFrame) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_frame_mean(s : ImagefilterlaplacianFrame) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_frame_scale(s : ImagefilterlaplacianFrame, f : Double) -> ImagefilterlaplacianFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_frame_add(a : ImagefilterlaplacianFrame, b : ImagefilterlaplacianFrame) -> ImagefilterlaplacianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_frame_copy(s : ImagefilterlaplacianFrame) -> ImagefilterlaplacianFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_frame_fill(s : ImagefilterlaplacianFrame, v : Double) -> ImagefilterlaplacianFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_frame_min(s : ImagefilterlaplacianFrame) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_frame_max(s : ImagefilterlaplacianFrame) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_frame_to_string(s : ImagefilterlaplacianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_table_make(size : Int) -> ImagefilterlaplacianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_table_len(s : ImagefilterlaplacianTable) -> Int { s.size }

pub fn image_filter_laplacian_table_get(s : ImagefilterlaplacianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_table_set(s : ImagefilterlaplacianTable, i : Int, v : Double) -> ImagefilterlaplacianTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_table_sum(s : ImagefilterlaplacianTable) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_table_mean(s : ImagefilterlaplacianTable) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_table_scale(s : ImagefilterlaplacianTable, f : Double) -> ImagefilterlaplacianTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_table_add(a : ImagefilterlaplacianTable, b : ImagefilterlaplacianTable) -> ImagefilterlaplacianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_table_copy(s : ImagefilterlaplacianTable) -> ImagefilterlaplacianTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_table_fill(s : ImagefilterlaplacianTable, v : Double) -> ImagefilterlaplacianTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_table_min(s : ImagefilterlaplacianTable) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_table_max(s : ImagefilterlaplacianTable) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_table_to_string(s : ImagefilterlaplacianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_graphn_make(size : Int) -> ImagefilterlaplacianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_graphn_len(s : ImagefilterlaplacianGraphN) -> Int { s.size }

pub fn image_filter_laplacian_graphn_get(s : ImagefilterlaplacianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_graphn_set(s : ImagefilterlaplacianGraphN, i : Int, v : Double) -> ImagefilterlaplacianGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_graphn_sum(s : ImagefilterlaplacianGraphN) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_graphn_mean(s : ImagefilterlaplacianGraphN) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_graphn_scale(s : ImagefilterlaplacianGraphN, f : Double) -> ImagefilterlaplacianGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_graphn_add(a : ImagefilterlaplacianGraphN, b : ImagefilterlaplacianGraphN) -> ImagefilterlaplacianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_graphn_copy(s : ImagefilterlaplacianGraphN) -> ImagefilterlaplacianGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_graphn_fill(s : ImagefilterlaplacianGraphN, v : Double) -> ImagefilterlaplacianGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_graphn_min(s : ImagefilterlaplacianGraphN) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_graphn_max(s : ImagefilterlaplacianGraphN) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_graphn_to_string(s : ImagefilterlaplacianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_node_make(size : Int) -> ImagefilterlaplacianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_node_len(s : ImagefilterlaplacianNode) -> Int { s.size }

pub fn image_filter_laplacian_node_get(s : ImagefilterlaplacianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_node_set(s : ImagefilterlaplacianNode, i : Int, v : Double) -> ImagefilterlaplacianNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_node_sum(s : ImagefilterlaplacianNode) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_node_mean(s : ImagefilterlaplacianNode) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_node_scale(s : ImagefilterlaplacianNode, f : Double) -> ImagefilterlaplacianNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_node_add(a : ImagefilterlaplacianNode, b : ImagefilterlaplacianNode) -> ImagefilterlaplacianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_node_copy(s : ImagefilterlaplacianNode) -> ImagefilterlaplacianNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_node_fill(s : ImagefilterlaplacianNode, v : Double) -> ImagefilterlaplacianNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_node_min(s : ImagefilterlaplacianNode) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_node_max(s : ImagefilterlaplacianNode) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_node_to_string(s : ImagefilterlaplacianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_edge_make(size : Int) -> ImagefilterlaplacianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_edge_len(s : ImagefilterlaplacianEdge) -> Int { s.size }

pub fn image_filter_laplacian_edge_get(s : ImagefilterlaplacianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_edge_set(s : ImagefilterlaplacianEdge, i : Int, v : Double) -> ImagefilterlaplacianEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_edge_sum(s : ImagefilterlaplacianEdge) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_edge_mean(s : ImagefilterlaplacianEdge) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_edge_scale(s : ImagefilterlaplacianEdge, f : Double) -> ImagefilterlaplacianEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_edge_add(a : ImagefilterlaplacianEdge, b : ImagefilterlaplacianEdge) -> ImagefilterlaplacianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_edge_copy(s : ImagefilterlaplacianEdge) -> ImagefilterlaplacianEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_edge_fill(s : ImagefilterlaplacianEdge, v : Double) -> ImagefilterlaplacianEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_edge_min(s : ImagefilterlaplacianEdge) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_edge_max(s : ImagefilterlaplacianEdge) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_edge_to_string(s : ImagefilterlaplacianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_path_make(size : Int) -> ImagefilterlaplacianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_path_len(s : ImagefilterlaplacianPath) -> Int { s.size }

pub fn image_filter_laplacian_path_get(s : ImagefilterlaplacianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_path_set(s : ImagefilterlaplacianPath, i : Int, v : Double) -> ImagefilterlaplacianPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_path_sum(s : ImagefilterlaplacianPath) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_path_mean(s : ImagefilterlaplacianPath) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_path_scale(s : ImagefilterlaplacianPath, f : Double) -> ImagefilterlaplacianPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_path_add(a : ImagefilterlaplacianPath, b : ImagefilterlaplacianPath) -> ImagefilterlaplacianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_path_copy(s : ImagefilterlaplacianPath) -> ImagefilterlaplacianPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_path_fill(s : ImagefilterlaplacianPath, v : Double) -> ImagefilterlaplacianPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_path_min(s : ImagefilterlaplacianPath) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_path_max(s : ImagefilterlaplacianPath) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_path_to_string(s : ImagefilterlaplacianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_cluster_make(size : Int) -> ImagefilterlaplacianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_cluster_len(s : ImagefilterlaplacianCluster) -> Int { s.size }

pub fn image_filter_laplacian_cluster_get(s : ImagefilterlaplacianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_cluster_set(s : ImagefilterlaplacianCluster, i : Int, v : Double) -> ImagefilterlaplacianCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_cluster_sum(s : ImagefilterlaplacianCluster) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_cluster_mean(s : ImagefilterlaplacianCluster) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_cluster_scale(s : ImagefilterlaplacianCluster, f : Double) -> ImagefilterlaplacianCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_cluster_add(a : ImagefilterlaplacianCluster, b : ImagefilterlaplacianCluster) -> ImagefilterlaplacianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_cluster_copy(s : ImagefilterlaplacianCluster) -> ImagefilterlaplacianCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_cluster_fill(s : ImagefilterlaplacianCluster, v : Double) -> ImagefilterlaplacianCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_cluster_min(s : ImagefilterlaplacianCluster) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_cluster_max(s : ImagefilterlaplacianCluster) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_cluster_to_string(s : ImagefilterlaplacianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_model_make(size : Int) -> ImagefilterlaplacianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_model_len(s : ImagefilterlaplacianModel) -> Int { s.size }

pub fn image_filter_laplacian_model_get(s : ImagefilterlaplacianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_model_set(s : ImagefilterlaplacianModel, i : Int, v : Double) -> ImagefilterlaplacianModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_model_sum(s : ImagefilterlaplacianModel) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_model_mean(s : ImagefilterlaplacianModel) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_model_scale(s : ImagefilterlaplacianModel, f : Double) -> ImagefilterlaplacianModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_model_add(a : ImagefilterlaplacianModel, b : ImagefilterlaplacianModel) -> ImagefilterlaplacianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_model_copy(s : ImagefilterlaplacianModel) -> ImagefilterlaplacianModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_model_fill(s : ImagefilterlaplacianModel, v : Double) -> ImagefilterlaplacianModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_model_min(s : ImagefilterlaplacianModel) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_model_max(s : ImagefilterlaplacianModel) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_model_to_string(s : ImagefilterlaplacianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_layer_make(size : Int) -> ImagefilterlaplacianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_layer_len(s : ImagefilterlaplacianLayer) -> Int { s.size }

pub fn image_filter_laplacian_layer_get(s : ImagefilterlaplacianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_layer_set(s : ImagefilterlaplacianLayer, i : Int, v : Double) -> ImagefilterlaplacianLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_layer_sum(s : ImagefilterlaplacianLayer) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_layer_mean(s : ImagefilterlaplacianLayer) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_layer_scale(s : ImagefilterlaplacianLayer, f : Double) -> ImagefilterlaplacianLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_layer_add(a : ImagefilterlaplacianLayer, b : ImagefilterlaplacianLayer) -> ImagefilterlaplacianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_layer_copy(s : ImagefilterlaplacianLayer) -> ImagefilterlaplacianLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_layer_fill(s : ImagefilterlaplacianLayer, v : Double) -> ImagefilterlaplacianLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_layer_min(s : ImagefilterlaplacianLayer) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_layer_max(s : ImagefilterlaplacianLayer) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_layer_to_string(s : ImagefilterlaplacianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_buffer_make(size : Int) -> ImagefilterlaplacianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_buffer_len(s : ImagefilterlaplacianBuffer) -> Int { s.size }

pub fn image_filter_laplacian_buffer_get(s : ImagefilterlaplacianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_buffer_set(s : ImagefilterlaplacianBuffer, i : Int, v : Double) -> ImagefilterlaplacianBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_buffer_sum(s : ImagefilterlaplacianBuffer) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_buffer_mean(s : ImagefilterlaplacianBuffer) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_buffer_scale(s : ImagefilterlaplacianBuffer, f : Double) -> ImagefilterlaplacianBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_buffer_add(a : ImagefilterlaplacianBuffer, b : ImagefilterlaplacianBuffer) -> ImagefilterlaplacianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_buffer_copy(s : ImagefilterlaplacianBuffer) -> ImagefilterlaplacianBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_buffer_fill(s : ImagefilterlaplacianBuffer, v : Double) -> ImagefilterlaplacianBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_buffer_min(s : ImagefilterlaplacianBuffer) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_buffer_max(s : ImagefilterlaplacianBuffer) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_buffer_to_string(s : ImagefilterlaplacianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_cursor_make(size : Int) -> ImagefilterlaplacianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_cursor_len(s : ImagefilterlaplacianCursor) -> Int { s.size }

pub fn image_filter_laplacian_cursor_get(s : ImagefilterlaplacianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_cursor_set(s : ImagefilterlaplacianCursor, i : Int, v : Double) -> ImagefilterlaplacianCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_cursor_sum(s : ImagefilterlaplacianCursor) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_cursor_mean(s : ImagefilterlaplacianCursor) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_cursor_scale(s : ImagefilterlaplacianCursor, f : Double) -> ImagefilterlaplacianCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_cursor_add(a : ImagefilterlaplacianCursor, b : ImagefilterlaplacianCursor) -> ImagefilterlaplacianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_cursor_copy(s : ImagefilterlaplacianCursor) -> ImagefilterlaplacianCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_cursor_fill(s : ImagefilterlaplacianCursor, v : Double) -> ImagefilterlaplacianCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_cursor_min(s : ImagefilterlaplacianCursor) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_cursor_max(s : ImagefilterlaplacianCursor) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_cursor_to_string(s : ImagefilterlaplacianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_view_make(size : Int) -> ImagefilterlaplacianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_view_len(s : ImagefilterlaplacianView) -> Int { s.size }

pub fn image_filter_laplacian_view_get(s : ImagefilterlaplacianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_view_set(s : ImagefilterlaplacianView, i : Int, v : Double) -> ImagefilterlaplacianView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_view_sum(s : ImagefilterlaplacianView) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_view_mean(s : ImagefilterlaplacianView) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_view_scale(s : ImagefilterlaplacianView, f : Double) -> ImagefilterlaplacianView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_view_add(a : ImagefilterlaplacianView, b : ImagefilterlaplacianView) -> ImagefilterlaplacianView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_view_copy(s : ImagefilterlaplacianView) -> ImagefilterlaplacianView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_view_fill(s : ImagefilterlaplacianView, v : Double) -> ImagefilterlaplacianView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_view_min(s : ImagefilterlaplacianView) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_view_max(s : ImagefilterlaplacianView) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_view_to_string(s : ImagefilterlaplacianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_range_make(size : Int) -> ImagefilterlaplacianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_range_len(s : ImagefilterlaplacianRange) -> Int { s.size }

pub fn image_filter_laplacian_range_get(s : ImagefilterlaplacianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_range_set(s : ImagefilterlaplacianRange, i : Int, v : Double) -> ImagefilterlaplacianRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_range_sum(s : ImagefilterlaplacianRange) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_range_mean(s : ImagefilterlaplacianRange) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_range_scale(s : ImagefilterlaplacianRange, f : Double) -> ImagefilterlaplacianRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_range_add(a : ImagefilterlaplacianRange, b : ImagefilterlaplacianRange) -> ImagefilterlaplacianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_range_copy(s : ImagefilterlaplacianRange) -> ImagefilterlaplacianRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_range_fill(s : ImagefilterlaplacianRange, v : Double) -> ImagefilterlaplacianRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_range_min(s : ImagefilterlaplacianRange) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_range_max(s : ImagefilterlaplacianRange) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_range_to_string(s : ImagefilterlaplacianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_slice_make(size : Int) -> ImagefilterlaplacianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_slice_len(s : ImagefilterlaplacianSlice) -> Int { s.size }

pub fn image_filter_laplacian_slice_get(s : ImagefilterlaplacianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_slice_set(s : ImagefilterlaplacianSlice, i : Int, v : Double) -> ImagefilterlaplacianSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_slice_sum(s : ImagefilterlaplacianSlice) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_slice_mean(s : ImagefilterlaplacianSlice) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_slice_scale(s : ImagefilterlaplacianSlice, f : Double) -> ImagefilterlaplacianSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_slice_add(a : ImagefilterlaplacianSlice, b : ImagefilterlaplacianSlice) -> ImagefilterlaplacianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_slice_copy(s : ImagefilterlaplacianSlice) -> ImagefilterlaplacianSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_slice_fill(s : ImagefilterlaplacianSlice, v : Double) -> ImagefilterlaplacianSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_slice_min(s : ImagefilterlaplacianSlice) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_slice_max(s : ImagefilterlaplacianSlice) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_slice_to_string(s : ImagefilterlaplacianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

