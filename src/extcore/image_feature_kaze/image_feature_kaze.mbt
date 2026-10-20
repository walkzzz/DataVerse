///===
/// extcore/image_feature_kaze

pub(all) struct ImagefeaturekazePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_kaze_make_point(x : Double, y : Double) -> ImagefeaturekazePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_kaze_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturekazePoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeaturekazePoint::x(self : ImagefeaturekazePoint) -> Double { self.x }

pub fn ImagefeaturekazePoint::y(self : ImagefeaturekazePoint) -> Double { self.y }

pub fn ImagefeaturekazePoint::z(self : ImagefeaturekazePoint) -> Double { self.z }

pub fn ImagefeaturekazePoint::label(self : ImagefeaturekazePoint) -> Int { self.label }

pub fn ImagefeaturekazePoint::dist(self : ImagefeaturekazePoint, other : ImagefeaturekazePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeaturekazePoint::add(self : ImagefeaturekazePoint, other : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeaturekazePoint::sub(self : ImagefeaturekazePoint, other : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeaturekazePoint::scale(self : ImagefeaturekazePoint, s : Double) -> ImagefeaturekazePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeaturekazePoint::dot(self : ImagefeaturekazePoint, other : ImagefeaturekazePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeaturekazePoint::cross(self : ImagefeaturekazePoint, other : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeaturekazePoint::norm(self : ImagefeaturekazePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeaturekazePoint::normalize(self : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturekazePoint::negate(self : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeaturekazePoint::mid(self : ImagefeaturekazePoint, other : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeaturekazePoint::lerp(self : ImagefeaturekazePoint, other : ImagefeaturekazePoint, t : Double) -> ImagefeaturekazePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeaturekazePoint::to_string(self : ImagefeaturekazePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeaturekazeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_kaze_make_series(vals : Array[Double], name : String) -> ImagefeaturekazeSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeaturekazeSeries::len(self : ImagefeaturekazeSeries) -> Int { self.vals.length() }

pub fn ImagefeaturekazeSeries::sum(self : ImagefeaturekazeSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeaturekazeSeries::mean(self : ImagefeaturekazeSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeaturekazeSeries::min(self : ImagefeaturekazeSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeaturekazeSeries::max(self : ImagefeaturekazeSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeaturekazeSeries::range(self : ImagefeaturekazeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeaturekazeSeries::variance(self : ImagefeaturekazeSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeaturekazeSeries::std(self : ImagefeaturekazeSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeaturekazeSeries::median(self : ImagefeaturekazeSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeaturekazeSeries::scale(self : ImagefeaturekazeSeries, f : Double) -> ImagefeaturekazeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeaturekazeSeries::add(self : ImagefeaturekazeSeries, other : ImagefeaturekazeSeries) -> ImagefeaturekazeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeaturekazeSeries::sub(self : ImagefeaturekazeSeries, other : ImagefeaturekazeSeries) -> ImagefeaturekazeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeaturekazeSeries::normalize(self : ImagefeaturekazeSeries) -> ImagefeaturekazeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeaturekazeSeries::cumsum(self : ImagefeaturekazeSeries) -> ImagefeaturekazeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeaturekazeSeries::to_string(self : ImagefeaturekazeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturekazeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_kaze_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturekazeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_kaze_matrix_identity(n : Int) -> ImagefeaturekazeMatrix {
  let m = image_feature_kaze_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeaturekazeMatrix::get(self : ImagefeaturekazeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeaturekazeMatrix::transpose(self : ImagefeaturekazeMatrix) -> ImagefeaturekazeMatrix {
  let result = image_feature_kaze_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeaturekazeMatrix::add(self : ImagefeaturekazeMatrix, other : ImagefeaturekazeMatrix) -> ImagefeaturekazeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_kaze_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeaturekazeMatrix::scale(self : ImagefeaturekazeMatrix, s : Double) -> ImagefeaturekazeMatrix {
  let result = image_feature_kaze_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeaturekazeMatrix::multiply(self : ImagefeaturekazeMatrix, other : ImagefeaturekazeMatrix) -> ImagefeaturekazeMatrix {
  if self.cols != other.rows { return image_feature_kaze_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_kaze_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefeaturekazeMatrix::trace(self : ImagefeaturekazeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeaturekazeMatrix::det(self : ImagefeaturekazeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeaturekazeMatrix::norm(self : ImagefeaturekazeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeaturekazeMatrix::to_string(self : ImagefeaturekazeMatrix) -> String {
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

pub(all) struct ImagefeaturekazeVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_kaze_make_vector(comps : Array[Double]) -> ImagefeaturekazeVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_kaze_vector_zero(dim : Int) -> ImagefeaturekazeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeaturekazeVector::add(self : ImagefeaturekazeVector, other : ImagefeaturekazeVector) -> ImagefeaturekazeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturekazeVector::sub(self : ImagefeaturekazeVector, other : ImagefeaturekazeVector) -> ImagefeaturekazeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturekazeVector::scale(self : ImagefeaturekazeVector, s : Double) -> ImagefeaturekazeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeaturekazeVector::dot(self : ImagefeaturekazeVector, other : ImagefeaturekazeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeaturekazeVector::norm(self : ImagefeaturekazeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeaturekazeVector::normalize(self : ImagefeaturekazeVector) -> ImagefeaturekazeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturekazeVector::dist(self : ImagefeaturekazeVector, other : ImagefeaturekazeVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeaturekazeVector::to_string(self : ImagefeaturekazeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_kaze_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_kaze_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_kaze_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_kaze_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_kaze_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_kaze_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_kaze_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_kaze_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_kaze_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_kaze_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_kaze_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_kaze_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_kaze_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_kaze_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_kaze_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_kaze_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_kaze_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_kaze_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_kaze_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_kaze_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_kaze_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_kaze_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_kaze_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_kaze_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_kaze_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_kaze_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_kaze_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_kaze_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_kaze_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeaturekazeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_frame_make(size : Int) -> ImagefeaturekazeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_frame_len(s : ImagefeaturekazeFrame) -> Int { s.size }

pub fn image_feature_kaze_frame_get(s : ImagefeaturekazeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_frame_set(s : ImagefeaturekazeFrame, i : Int, v : Double) -> ImagefeaturekazeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_frame_sum(s : ImagefeaturekazeFrame) -> Double { @_common.sum(s.data) }

pub fn image_feature_kaze_frame_mean(s : ImagefeaturekazeFrame) -> Double { @_common.mean(s.data) }

pub fn image_feature_kaze_frame_scale(s : ImagefeaturekazeFrame, f : Double) -> ImagefeaturekazeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_frame_add(a : ImagefeaturekazeFrame, b : ImagefeaturekazeFrame) -> ImagefeaturekazeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_kaze_frame_copy(s : ImagefeaturekazeFrame) -> ImagefeaturekazeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_frame_fill(s : ImagefeaturekazeFrame, v : Double) -> ImagefeaturekazeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_frame_min(s : ImagefeaturekazeFrame) -> Double { @_common.min(s.data) }

pub fn image_feature_kaze_frame_max(s : ImagefeaturekazeFrame) -> Double { @_common.max(s.data) }

pub fn image_feature_kaze_frame_to_string(s : ImagefeaturekazeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_table_make(size : Int) -> ImagefeaturekazeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_table_len(s : ImagefeaturekazeTable) -> Int { s.size }

pub fn image_feature_kaze_table_get(s : ImagefeaturekazeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_table_set(s : ImagefeaturekazeTable, i : Int, v : Double) -> ImagefeaturekazeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_table_sum(s : ImagefeaturekazeTable) -> Double { @_common.sum(s.data) }

pub fn image_feature_kaze_table_mean(s : ImagefeaturekazeTable) -> Double { @_common.mean(s.data) }

pub fn image_feature_kaze_table_scale(s : ImagefeaturekazeTable, f : Double) -> ImagefeaturekazeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_table_add(a : ImagefeaturekazeTable, b : ImagefeaturekazeTable) -> ImagefeaturekazeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_kaze_table_copy(s : ImagefeaturekazeTable) -> ImagefeaturekazeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_table_fill(s : ImagefeaturekazeTable, v : Double) -> ImagefeaturekazeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_table_min(s : ImagefeaturekazeTable) -> Double { @_common.min(s.data) }

pub fn image_feature_kaze_table_max(s : ImagefeaturekazeTable) -> Double { @_common.max(s.data) }

pub fn image_feature_kaze_table_to_string(s : ImagefeaturekazeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_graphn_make(size : Int) -> ImagefeaturekazeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_graphn_len(s : ImagefeaturekazeGraphN) -> Int { s.size }

pub fn image_feature_kaze_graphn_get(s : ImagefeaturekazeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_graphn_set(s : ImagefeaturekazeGraphN, i : Int, v : Double) -> ImagefeaturekazeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_graphn_sum(s : ImagefeaturekazeGraphN) -> Double { @_common.sum(s.data) }

pub fn image_feature_kaze_graphn_mean(s : ImagefeaturekazeGraphN) -> Double { @_common.mean(s.data) }

pub fn image_feature_kaze_graphn_scale(s : ImagefeaturekazeGraphN, f : Double) -> ImagefeaturekazeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_graphn_add(a : ImagefeaturekazeGraphN, b : ImagefeaturekazeGraphN) -> ImagefeaturekazeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_kaze_graphn_copy(s : ImagefeaturekazeGraphN) -> ImagefeaturekazeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_graphn_fill(s : ImagefeaturekazeGraphN, v : Double) -> ImagefeaturekazeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_graphn_min(s : ImagefeaturekazeGraphN) -> Double { @_common.min(s.data) }

pub fn image_feature_kaze_graphn_max(s : ImagefeaturekazeGraphN) -> Double { @_common.max(s.data) }

pub fn image_feature_kaze_graphn_to_string(s : ImagefeaturekazeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_node_make(size : Int) -> ImagefeaturekazeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_node_len(s : ImagefeaturekazeNode) -> Int { s.size }

pub fn image_feature_kaze_node_get(s : ImagefeaturekazeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_node_set(s : ImagefeaturekazeNode, i : Int, v : Double) -> ImagefeaturekazeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_node_sum(s : ImagefeaturekazeNode) -> Double { @_common.sum(s.data) }

pub fn image_feature_kaze_node_mean(s : ImagefeaturekazeNode) -> Double { @_common.mean(s.data) }

pub fn image_feature_kaze_node_scale(s : ImagefeaturekazeNode, f : Double) -> ImagefeaturekazeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_node_add(a : ImagefeaturekazeNode, b : ImagefeaturekazeNode) -> ImagefeaturekazeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_kaze_node_copy(s : ImagefeaturekazeNode) -> ImagefeaturekazeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_node_fill(s : ImagefeaturekazeNode, v : Double) -> ImagefeaturekazeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_node_min(s : ImagefeaturekazeNode) -> Double { @_common.min(s.data) }

pub fn image_feature_kaze_node_max(s : ImagefeaturekazeNode) -> Double { @_common.max(s.data) }

pub fn image_feature_kaze_node_to_string(s : ImagefeaturekazeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_edge_make(size : Int) -> ImagefeaturekazeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_edge_len(s : ImagefeaturekazeEdge) -> Int { s.size }

pub fn image_feature_kaze_edge_get(s : ImagefeaturekazeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_edge_set(s : ImagefeaturekazeEdge, i : Int, v : Double) -> ImagefeaturekazeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_edge_sum(s : ImagefeaturekazeEdge) -> Double { @_common.sum(s.data) }

pub fn image_feature_kaze_edge_mean(s : ImagefeaturekazeEdge) -> Double { @_common.mean(s.data) }

pub fn image_feature_kaze_edge_scale(s : ImagefeaturekazeEdge, f : Double) -> ImagefeaturekazeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_edge_add(a : ImagefeaturekazeEdge, b : ImagefeaturekazeEdge) -> ImagefeaturekazeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_kaze_edge_copy(s : ImagefeaturekazeEdge) -> ImagefeaturekazeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_edge_fill(s : ImagefeaturekazeEdge, v : Double) -> ImagefeaturekazeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_edge_min(s : ImagefeaturekazeEdge) -> Double { @_common.min(s.data) }

pub fn image_feature_kaze_edge_max(s : ImagefeaturekazeEdge) -> Double { @_common.max(s.data) }

pub fn image_feature_kaze_edge_to_string(s : ImagefeaturekazeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_path_make(size : Int) -> ImagefeaturekazePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_path_len(s : ImagefeaturekazePath) -> Int { s.size }

pub fn image_feature_kaze_path_get(s : ImagefeaturekazePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_path_set(s : ImagefeaturekazePath, i : Int, v : Double) -> ImagefeaturekazePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_path_sum(s : ImagefeaturekazePath) -> Double { @_common.sum(s.data) }

pub fn image_feature_kaze_path_mean(s : ImagefeaturekazePath) -> Double { @_common.mean(s.data) }

pub fn image_feature_kaze_path_scale(s : ImagefeaturekazePath, f : Double) -> ImagefeaturekazePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_path_add(a : ImagefeaturekazePath, b : ImagefeaturekazePath) -> ImagefeaturekazePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_kaze_path_copy(s : ImagefeaturekazePath) -> ImagefeaturekazePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_path_fill(s : ImagefeaturekazePath, v : Double) -> ImagefeaturekazePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_path_min(s : ImagefeaturekazePath) -> Double { @_common.min(s.data) }

pub fn image_feature_kaze_path_max(s : ImagefeaturekazePath) -> Double { @_common.max(s.data) }

pub fn image_feature_kaze_path_to_string(s : ImagefeaturekazePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_cluster_make(size : Int) -> ImagefeaturekazeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_cluster_len(s : ImagefeaturekazeCluster) -> Int { s.size }

pub fn image_feature_kaze_cluster_get(s : ImagefeaturekazeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_cluster_set(s : ImagefeaturekazeCluster, i : Int, v : Double) -> ImagefeaturekazeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_cluster_sum(s : ImagefeaturekazeCluster) -> Double { @_common.sum(s.data) }

pub fn image_feature_kaze_cluster_mean(s : ImagefeaturekazeCluster) -> Double { @_common.mean(s.data) }

pub fn image_feature_kaze_cluster_scale(s : ImagefeaturekazeCluster, f : Double) -> ImagefeaturekazeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_cluster_add(a : ImagefeaturekazeCluster, b : ImagefeaturekazeCluster) -> ImagefeaturekazeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_kaze_cluster_copy(s : ImagefeaturekazeCluster) -> ImagefeaturekazeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_cluster_fill(s : ImagefeaturekazeCluster, v : Double) -> ImagefeaturekazeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_cluster_min(s : ImagefeaturekazeCluster) -> Double { @_common.min(s.data) }

pub fn image_feature_kaze_cluster_max(s : ImagefeaturekazeCluster) -> Double { @_common.max(s.data) }

pub fn image_feature_kaze_cluster_to_string(s : ImagefeaturekazeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_model_make(size : Int) -> ImagefeaturekazeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_model_len(s : ImagefeaturekazeModel) -> Int { s.size }

pub fn image_feature_kaze_model_get(s : ImagefeaturekazeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_model_set(s : ImagefeaturekazeModel, i : Int, v : Double) -> ImagefeaturekazeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_model_sum(s : ImagefeaturekazeModel) -> Double { @_common.sum(s.data) }

pub fn image_feature_kaze_model_mean(s : ImagefeaturekazeModel) -> Double { @_common.mean(s.data) }

pub fn image_feature_kaze_model_scale(s : ImagefeaturekazeModel, f : Double) -> ImagefeaturekazeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_model_add(a : ImagefeaturekazeModel, b : ImagefeaturekazeModel) -> ImagefeaturekazeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_kaze_model_copy(s : ImagefeaturekazeModel) -> ImagefeaturekazeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_model_fill(s : ImagefeaturekazeModel, v : Double) -> ImagefeaturekazeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_model_min(s : ImagefeaturekazeModel) -> Double { @_common.min(s.data) }

pub fn image_feature_kaze_model_max(s : ImagefeaturekazeModel) -> Double { @_common.max(s.data) }

pub fn image_feature_kaze_model_to_string(s : ImagefeaturekazeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_layer_make(size : Int) -> ImagefeaturekazeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_layer_len(s : ImagefeaturekazeLayer) -> Int { s.size }

pub fn image_feature_kaze_layer_get(s : ImagefeaturekazeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_layer_set(s : ImagefeaturekazeLayer, i : Int, v : Double) -> ImagefeaturekazeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_layer_sum(s : ImagefeaturekazeLayer) -> Double { @_common.sum(s.data) }

pub fn image_feature_kaze_layer_mean(s : ImagefeaturekazeLayer) -> Double { @_common.mean(s.data) }

pub fn image_feature_kaze_layer_scale(s : ImagefeaturekazeLayer, f : Double) -> ImagefeaturekazeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_layer_add(a : ImagefeaturekazeLayer, b : ImagefeaturekazeLayer) -> ImagefeaturekazeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_kaze_layer_copy(s : ImagefeaturekazeLayer) -> ImagefeaturekazeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_layer_fill(s : ImagefeaturekazeLayer, v : Double) -> ImagefeaturekazeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_layer_min(s : ImagefeaturekazeLayer) -> Double { @_common.min(s.data) }

pub fn image_feature_kaze_layer_max(s : ImagefeaturekazeLayer) -> Double { @_common.max(s.data) }

pub fn image_feature_kaze_layer_to_string(s : ImagefeaturekazeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_buffer_make(size : Int) -> ImagefeaturekazeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_buffer_len(s : ImagefeaturekazeBuffer) -> Int { s.size }

pub fn image_feature_kaze_buffer_get(s : ImagefeaturekazeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_buffer_set(s : ImagefeaturekazeBuffer, i : Int, v : Double) -> ImagefeaturekazeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_buffer_sum(s : ImagefeaturekazeBuffer) -> Double { @_common.sum(s.data) }

pub fn image_feature_kaze_buffer_mean(s : ImagefeaturekazeBuffer) -> Double { @_common.mean(s.data) }

pub fn image_feature_kaze_buffer_scale(s : ImagefeaturekazeBuffer, f : Double) -> ImagefeaturekazeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_buffer_add(a : ImagefeaturekazeBuffer, b : ImagefeaturekazeBuffer) -> ImagefeaturekazeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_kaze_buffer_copy(s : ImagefeaturekazeBuffer) -> ImagefeaturekazeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_buffer_fill(s : ImagefeaturekazeBuffer, v : Double) -> ImagefeaturekazeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_buffer_min(s : ImagefeaturekazeBuffer) -> Double { @_common.min(s.data) }

pub fn image_feature_kaze_buffer_max(s : ImagefeaturekazeBuffer) -> Double { @_common.max(s.data) }

pub fn image_feature_kaze_buffer_to_string(s : ImagefeaturekazeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_cursor_make(size : Int) -> ImagefeaturekazeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_cursor_len(s : ImagefeaturekazeCursor) -> Int { s.size }

pub fn image_feature_kaze_cursor_get(s : ImagefeaturekazeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_cursor_set(s : ImagefeaturekazeCursor, i : Int, v : Double) -> ImagefeaturekazeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_cursor_sum(s : ImagefeaturekazeCursor) -> Double { @_common.sum(s.data) }

pub fn image_feature_kaze_cursor_mean(s : ImagefeaturekazeCursor) -> Double { @_common.mean(s.data) }

pub fn image_feature_kaze_cursor_scale(s : ImagefeaturekazeCursor, f : Double) -> ImagefeaturekazeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_cursor_add(a : ImagefeaturekazeCursor, b : ImagefeaturekazeCursor) -> ImagefeaturekazeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_kaze_cursor_copy(s : ImagefeaturekazeCursor) -> ImagefeaturekazeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_cursor_fill(s : ImagefeaturekazeCursor, v : Double) -> ImagefeaturekazeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_cursor_min(s : ImagefeaturekazeCursor) -> Double { @_common.min(s.data) }

pub fn image_feature_kaze_cursor_max(s : ImagefeaturekazeCursor) -> Double { @_common.max(s.data) }

pub fn image_feature_kaze_cursor_to_string(s : ImagefeaturekazeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_view_make(size : Int) -> ImagefeaturekazeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_view_len(s : ImagefeaturekazeView) -> Int { s.size }

pub fn image_feature_kaze_view_get(s : ImagefeaturekazeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_view_set(s : ImagefeaturekazeView, i : Int, v : Double) -> ImagefeaturekazeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_view_sum(s : ImagefeaturekazeView) -> Double { @_common.sum(s.data) }

pub fn image_feature_kaze_view_mean(s : ImagefeaturekazeView) -> Double { @_common.mean(s.data) }

pub fn image_feature_kaze_view_scale(s : ImagefeaturekazeView, f : Double) -> ImagefeaturekazeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_view_add(a : ImagefeaturekazeView, b : ImagefeaturekazeView) -> ImagefeaturekazeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_kaze_view_copy(s : ImagefeaturekazeView) -> ImagefeaturekazeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_view_fill(s : ImagefeaturekazeView, v : Double) -> ImagefeaturekazeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_view_min(s : ImagefeaturekazeView) -> Double { @_common.min(s.data) }

pub fn image_feature_kaze_view_max(s : ImagefeaturekazeView) -> Double { @_common.max(s.data) }

pub fn image_feature_kaze_view_to_string(s : ImagefeaturekazeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_range_make(size : Int) -> ImagefeaturekazeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_range_len(s : ImagefeaturekazeRange) -> Int { s.size }

pub fn image_feature_kaze_range_get(s : ImagefeaturekazeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_range_set(s : ImagefeaturekazeRange, i : Int, v : Double) -> ImagefeaturekazeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_range_sum(s : ImagefeaturekazeRange) -> Double { @_common.sum(s.data) }

pub fn image_feature_kaze_range_mean(s : ImagefeaturekazeRange) -> Double { @_common.mean(s.data) }

pub fn image_feature_kaze_range_scale(s : ImagefeaturekazeRange, f : Double) -> ImagefeaturekazeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_range_add(a : ImagefeaturekazeRange, b : ImagefeaturekazeRange) -> ImagefeaturekazeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_kaze_range_copy(s : ImagefeaturekazeRange) -> ImagefeaturekazeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_range_fill(s : ImagefeaturekazeRange, v : Double) -> ImagefeaturekazeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_range_min(s : ImagefeaturekazeRange) -> Double { @_common.min(s.data) }

pub fn image_feature_kaze_range_max(s : ImagefeaturekazeRange) -> Double { @_common.max(s.data) }

pub fn image_feature_kaze_range_to_string(s : ImagefeaturekazeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_slice_make(size : Int) -> ImagefeaturekazeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_slice_len(s : ImagefeaturekazeSlice) -> Int { s.size }

pub fn image_feature_kaze_slice_get(s : ImagefeaturekazeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_slice_set(s : ImagefeaturekazeSlice, i : Int, v : Double) -> ImagefeaturekazeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_slice_sum(s : ImagefeaturekazeSlice) -> Double { @_common.sum(s.data) }

pub fn image_feature_kaze_slice_mean(s : ImagefeaturekazeSlice) -> Double { @_common.mean(s.data) }

pub fn image_feature_kaze_slice_scale(s : ImagefeaturekazeSlice, f : Double) -> ImagefeaturekazeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_slice_add(a : ImagefeaturekazeSlice, b : ImagefeaturekazeSlice) -> ImagefeaturekazeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_kaze_slice_copy(s : ImagefeaturekazeSlice) -> ImagefeaturekazeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_slice_fill(s : ImagefeaturekazeSlice, v : Double) -> ImagefeaturekazeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_kaze_slice_min(s : ImagefeaturekazeSlice) -> Double { @_common.min(s.data) }

pub fn image_feature_kaze_slice_max(s : ImagefeaturekazeSlice) -> Double { @_common.max(s.data) }

pub fn image_feature_kaze_slice_to_string(s : ImagefeaturekazeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

