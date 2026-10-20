///===
/// extcore/image_feature_blob

pub(all) struct ImagefeatureblobPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_blob_make_point(x : Double, y : Double) -> ImagefeatureblobPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_blob_make_point3(x : Double, y : Double, z : Double) -> ImagefeatureblobPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeatureblobPoint::x(self : ImagefeatureblobPoint) -> Double { self.x }

pub fn ImagefeatureblobPoint::y(self : ImagefeatureblobPoint) -> Double { self.y }

pub fn ImagefeatureblobPoint::z(self : ImagefeatureblobPoint) -> Double { self.z }

pub fn ImagefeatureblobPoint::label(self : ImagefeatureblobPoint) -> Int { self.label }

pub fn ImagefeatureblobPoint::dist(self : ImagefeatureblobPoint, other : ImagefeatureblobPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeatureblobPoint::add(self : ImagefeatureblobPoint, other : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeatureblobPoint::sub(self : ImagefeatureblobPoint, other : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeatureblobPoint::scale(self : ImagefeatureblobPoint, s : Double) -> ImagefeatureblobPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeatureblobPoint::dot(self : ImagefeatureblobPoint, other : ImagefeatureblobPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeatureblobPoint::cross(self : ImagefeatureblobPoint, other : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeatureblobPoint::norm(self : ImagefeatureblobPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeatureblobPoint::normalize(self : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeatureblobPoint::negate(self : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeatureblobPoint::mid(self : ImagefeatureblobPoint, other : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeatureblobPoint::lerp(self : ImagefeatureblobPoint, other : ImagefeatureblobPoint, t : Double) -> ImagefeatureblobPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeatureblobPoint::to_string(self : ImagefeatureblobPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeatureblobSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_blob_make_series(vals : Array[Double], name : String) -> ImagefeatureblobSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeatureblobSeries::len(self : ImagefeatureblobSeries) -> Int { self.vals.length() }

pub fn ImagefeatureblobSeries::sum(self : ImagefeatureblobSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeatureblobSeries::mean(self : ImagefeatureblobSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeatureblobSeries::min(self : ImagefeatureblobSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeatureblobSeries::max(self : ImagefeatureblobSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeatureblobSeries::range(self : ImagefeatureblobSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeatureblobSeries::variance(self : ImagefeatureblobSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeatureblobSeries::std(self : ImagefeatureblobSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeatureblobSeries::median(self : ImagefeatureblobSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeatureblobSeries::scale(self : ImagefeatureblobSeries, f : Double) -> ImagefeatureblobSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeatureblobSeries::add(self : ImagefeatureblobSeries, other : ImagefeatureblobSeries) -> ImagefeatureblobSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeatureblobSeries::sub(self : ImagefeatureblobSeries, other : ImagefeatureblobSeries) -> ImagefeatureblobSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeatureblobSeries::normalize(self : ImagefeatureblobSeries) -> ImagefeatureblobSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeatureblobSeries::cumsum(self : ImagefeatureblobSeries) -> ImagefeatureblobSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeatureblobSeries::to_string(self : ImagefeatureblobSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeatureblobMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_blob_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeatureblobMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_blob_matrix_identity(n : Int) -> ImagefeatureblobMatrix {
  let m = image_feature_blob_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeatureblobMatrix::get(self : ImagefeatureblobMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeatureblobMatrix::transpose(self : ImagefeatureblobMatrix) -> ImagefeatureblobMatrix {
  let result = image_feature_blob_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeatureblobMatrix::add(self : ImagefeatureblobMatrix, other : ImagefeatureblobMatrix) -> ImagefeatureblobMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_blob_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeatureblobMatrix::scale(self : ImagefeatureblobMatrix, s : Double) -> ImagefeatureblobMatrix {
  let result = image_feature_blob_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeatureblobMatrix::multiply(self : ImagefeatureblobMatrix, other : ImagefeatureblobMatrix) -> ImagefeatureblobMatrix {
  if self.cols != other.rows { return image_feature_blob_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_blob_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefeatureblobMatrix::trace(self : ImagefeatureblobMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeatureblobMatrix::det(self : ImagefeatureblobMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeatureblobMatrix::norm(self : ImagefeatureblobMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeatureblobMatrix::to_string(self : ImagefeatureblobMatrix) -> String {
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

pub(all) struct ImagefeatureblobVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_blob_make_vector(comps : Array[Double]) -> ImagefeatureblobVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_blob_vector_zero(dim : Int) -> ImagefeatureblobVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeatureblobVector::add(self : ImagefeatureblobVector, other : ImagefeatureblobVector) -> ImagefeatureblobVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeatureblobVector::sub(self : ImagefeatureblobVector, other : ImagefeatureblobVector) -> ImagefeatureblobVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeatureblobVector::scale(self : ImagefeatureblobVector, s : Double) -> ImagefeatureblobVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeatureblobVector::dot(self : ImagefeatureblobVector, other : ImagefeatureblobVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeatureblobVector::norm(self : ImagefeatureblobVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeatureblobVector::normalize(self : ImagefeatureblobVector) -> ImagefeatureblobVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeatureblobVector::dist(self : ImagefeatureblobVector, other : ImagefeatureblobVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeatureblobVector::to_string(self : ImagefeatureblobVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_blob_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_blob_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_blob_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_blob_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_blob_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_blob_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_blob_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_blob_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_blob_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_blob_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_blob_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_blob_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_blob_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_blob_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_blob_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_blob_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_blob_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_blob_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_blob_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_blob_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_blob_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_blob_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_blob_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_blob_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_blob_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_blob_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_blob_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_blob_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_blob_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeatureblobFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_frame_make(size : Int) -> ImagefeatureblobFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureblobFrame::len(self : ImagefeatureblobFrame) -> Int { self.size }

pub fn ImagefeatureblobFrame::get(self : ImagefeatureblobFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureblobFrame::set(self : ImagefeatureblobFrame, i : Int, v : Double) -> ImagefeatureblobFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobFrame::sum(self : ImagefeatureblobFrame) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureblobFrame::mean(self : ImagefeatureblobFrame) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureblobFrame::scale(self : ImagefeatureblobFrame, f : Double) -> ImagefeatureblobFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobFrame::add(self : ImagefeatureblobFrame, other : ImagefeatureblobFrame) -> ImagefeatureblobFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureblobFrame::copy(self : ImagefeatureblobFrame) -> ImagefeatureblobFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobFrame::fill(self : ImagefeatureblobFrame, v : Double) -> ImagefeatureblobFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobFrame::min(self : ImagefeatureblobFrame) -> Double { @_common.min(self.data) }

pub fn ImagefeatureblobFrame::max(self : ImagefeatureblobFrame) -> Double { @_common.max(self.data) }

pub fn ImagefeatureblobFrame::to_string(self : ImagefeatureblobFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_table_make(size : Int) -> ImagefeatureblobTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureblobTable::len(self : ImagefeatureblobTable) -> Int { self.size }

pub fn ImagefeatureblobTable::get(self : ImagefeatureblobTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureblobTable::set(self : ImagefeatureblobTable, i : Int, v : Double) -> ImagefeatureblobTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobTable::sum(self : ImagefeatureblobTable) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureblobTable::mean(self : ImagefeatureblobTable) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureblobTable::scale(self : ImagefeatureblobTable, f : Double) -> ImagefeatureblobTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobTable::add(self : ImagefeatureblobTable, other : ImagefeatureblobTable) -> ImagefeatureblobTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureblobTable::copy(self : ImagefeatureblobTable) -> ImagefeatureblobTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobTable::fill(self : ImagefeatureblobTable, v : Double) -> ImagefeatureblobTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobTable::min(self : ImagefeatureblobTable) -> Double { @_common.min(self.data) }

pub fn ImagefeatureblobTable::max(self : ImagefeatureblobTable) -> Double { @_common.max(self.data) }

pub fn ImagefeatureblobTable::to_string(self : ImagefeatureblobTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_graphn_make(size : Int) -> ImagefeatureblobGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureblobGraphN::len(self : ImagefeatureblobGraphN) -> Int { self.size }

pub fn ImagefeatureblobGraphN::get(self : ImagefeatureblobGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureblobGraphN::set(self : ImagefeatureblobGraphN, i : Int, v : Double) -> ImagefeatureblobGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobGraphN::sum(self : ImagefeatureblobGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureblobGraphN::mean(self : ImagefeatureblobGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureblobGraphN::scale(self : ImagefeatureblobGraphN, f : Double) -> ImagefeatureblobGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobGraphN::add(self : ImagefeatureblobGraphN, other : ImagefeatureblobGraphN) -> ImagefeatureblobGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureblobGraphN::copy(self : ImagefeatureblobGraphN) -> ImagefeatureblobGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobGraphN::fill(self : ImagefeatureblobGraphN, v : Double) -> ImagefeatureblobGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobGraphN::min(self : ImagefeatureblobGraphN) -> Double { @_common.min(self.data) }

pub fn ImagefeatureblobGraphN::max(self : ImagefeatureblobGraphN) -> Double { @_common.max(self.data) }

pub fn ImagefeatureblobGraphN::to_string(self : ImagefeatureblobGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_node_make(size : Int) -> ImagefeatureblobNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureblobNode::len(self : ImagefeatureblobNode) -> Int { self.size }

pub fn ImagefeatureblobNode::get(self : ImagefeatureblobNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureblobNode::set(self : ImagefeatureblobNode, i : Int, v : Double) -> ImagefeatureblobNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobNode::sum(self : ImagefeatureblobNode) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureblobNode::mean(self : ImagefeatureblobNode) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureblobNode::scale(self : ImagefeatureblobNode, f : Double) -> ImagefeatureblobNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobNode::add(self : ImagefeatureblobNode, other : ImagefeatureblobNode) -> ImagefeatureblobNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureblobNode::copy(self : ImagefeatureblobNode) -> ImagefeatureblobNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobNode::fill(self : ImagefeatureblobNode, v : Double) -> ImagefeatureblobNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobNode::min(self : ImagefeatureblobNode) -> Double { @_common.min(self.data) }

pub fn ImagefeatureblobNode::max(self : ImagefeatureblobNode) -> Double { @_common.max(self.data) }

pub fn ImagefeatureblobNode::to_string(self : ImagefeatureblobNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_edge_make(size : Int) -> ImagefeatureblobEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureblobEdge::len(self : ImagefeatureblobEdge) -> Int { self.size }

pub fn ImagefeatureblobEdge::get(self : ImagefeatureblobEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureblobEdge::set(self : ImagefeatureblobEdge, i : Int, v : Double) -> ImagefeatureblobEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobEdge::sum(self : ImagefeatureblobEdge) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureblobEdge::mean(self : ImagefeatureblobEdge) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureblobEdge::scale(self : ImagefeatureblobEdge, f : Double) -> ImagefeatureblobEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobEdge::add(self : ImagefeatureblobEdge, other : ImagefeatureblobEdge) -> ImagefeatureblobEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureblobEdge::copy(self : ImagefeatureblobEdge) -> ImagefeatureblobEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobEdge::fill(self : ImagefeatureblobEdge, v : Double) -> ImagefeatureblobEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobEdge::min(self : ImagefeatureblobEdge) -> Double { @_common.min(self.data) }

pub fn ImagefeatureblobEdge::max(self : ImagefeatureblobEdge) -> Double { @_common.max(self.data) }

pub fn ImagefeatureblobEdge::to_string(self : ImagefeatureblobEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_path_make(size : Int) -> ImagefeatureblobPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureblobPath::len(self : ImagefeatureblobPath) -> Int { self.size }

pub fn ImagefeatureblobPath::get(self : ImagefeatureblobPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureblobPath::set(self : ImagefeatureblobPath, i : Int, v : Double) -> ImagefeatureblobPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobPath::sum(self : ImagefeatureblobPath) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureblobPath::mean(self : ImagefeatureblobPath) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureblobPath::scale(self : ImagefeatureblobPath, f : Double) -> ImagefeatureblobPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobPath::add(self : ImagefeatureblobPath, other : ImagefeatureblobPath) -> ImagefeatureblobPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureblobPath::copy(self : ImagefeatureblobPath) -> ImagefeatureblobPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobPath::fill(self : ImagefeatureblobPath, v : Double) -> ImagefeatureblobPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobPath::min(self : ImagefeatureblobPath) -> Double { @_common.min(self.data) }

pub fn ImagefeatureblobPath::max(self : ImagefeatureblobPath) -> Double { @_common.max(self.data) }

pub fn ImagefeatureblobPath::to_string(self : ImagefeatureblobPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_cluster_make(size : Int) -> ImagefeatureblobCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureblobCluster::len(self : ImagefeatureblobCluster) -> Int { self.size }

pub fn ImagefeatureblobCluster::get(self : ImagefeatureblobCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureblobCluster::set(self : ImagefeatureblobCluster, i : Int, v : Double) -> ImagefeatureblobCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobCluster::sum(self : ImagefeatureblobCluster) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureblobCluster::mean(self : ImagefeatureblobCluster) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureblobCluster::scale(self : ImagefeatureblobCluster, f : Double) -> ImagefeatureblobCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobCluster::add(self : ImagefeatureblobCluster, other : ImagefeatureblobCluster) -> ImagefeatureblobCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureblobCluster::copy(self : ImagefeatureblobCluster) -> ImagefeatureblobCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobCluster::fill(self : ImagefeatureblobCluster, v : Double) -> ImagefeatureblobCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobCluster::min(self : ImagefeatureblobCluster) -> Double { @_common.min(self.data) }

pub fn ImagefeatureblobCluster::max(self : ImagefeatureblobCluster) -> Double { @_common.max(self.data) }

pub fn ImagefeatureblobCluster::to_string(self : ImagefeatureblobCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_model_make(size : Int) -> ImagefeatureblobModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureblobModel::len(self : ImagefeatureblobModel) -> Int { self.size }

pub fn ImagefeatureblobModel::get(self : ImagefeatureblobModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureblobModel::set(self : ImagefeatureblobModel, i : Int, v : Double) -> ImagefeatureblobModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobModel::sum(self : ImagefeatureblobModel) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureblobModel::mean(self : ImagefeatureblobModel) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureblobModel::scale(self : ImagefeatureblobModel, f : Double) -> ImagefeatureblobModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobModel::add(self : ImagefeatureblobModel, other : ImagefeatureblobModel) -> ImagefeatureblobModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureblobModel::copy(self : ImagefeatureblobModel) -> ImagefeatureblobModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobModel::fill(self : ImagefeatureblobModel, v : Double) -> ImagefeatureblobModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobModel::min(self : ImagefeatureblobModel) -> Double { @_common.min(self.data) }

pub fn ImagefeatureblobModel::max(self : ImagefeatureblobModel) -> Double { @_common.max(self.data) }

pub fn ImagefeatureblobModel::to_string(self : ImagefeatureblobModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_layer_make(size : Int) -> ImagefeatureblobLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureblobLayer::len(self : ImagefeatureblobLayer) -> Int { self.size }

pub fn ImagefeatureblobLayer::get(self : ImagefeatureblobLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureblobLayer::set(self : ImagefeatureblobLayer, i : Int, v : Double) -> ImagefeatureblobLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobLayer::sum(self : ImagefeatureblobLayer) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureblobLayer::mean(self : ImagefeatureblobLayer) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureblobLayer::scale(self : ImagefeatureblobLayer, f : Double) -> ImagefeatureblobLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobLayer::add(self : ImagefeatureblobLayer, other : ImagefeatureblobLayer) -> ImagefeatureblobLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureblobLayer::copy(self : ImagefeatureblobLayer) -> ImagefeatureblobLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobLayer::fill(self : ImagefeatureblobLayer, v : Double) -> ImagefeatureblobLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobLayer::min(self : ImagefeatureblobLayer) -> Double { @_common.min(self.data) }

pub fn ImagefeatureblobLayer::max(self : ImagefeatureblobLayer) -> Double { @_common.max(self.data) }

pub fn ImagefeatureblobLayer::to_string(self : ImagefeatureblobLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_buffer_make(size : Int) -> ImagefeatureblobBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureblobBuffer::len(self : ImagefeatureblobBuffer) -> Int { self.size }

pub fn ImagefeatureblobBuffer::get(self : ImagefeatureblobBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureblobBuffer::set(self : ImagefeatureblobBuffer, i : Int, v : Double) -> ImagefeatureblobBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobBuffer::sum(self : ImagefeatureblobBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureblobBuffer::mean(self : ImagefeatureblobBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureblobBuffer::scale(self : ImagefeatureblobBuffer, f : Double) -> ImagefeatureblobBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobBuffer::add(self : ImagefeatureblobBuffer, other : ImagefeatureblobBuffer) -> ImagefeatureblobBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureblobBuffer::copy(self : ImagefeatureblobBuffer) -> ImagefeatureblobBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobBuffer::fill(self : ImagefeatureblobBuffer, v : Double) -> ImagefeatureblobBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobBuffer::min(self : ImagefeatureblobBuffer) -> Double { @_common.min(self.data) }

pub fn ImagefeatureblobBuffer::max(self : ImagefeatureblobBuffer) -> Double { @_common.max(self.data) }

pub fn ImagefeatureblobBuffer::to_string(self : ImagefeatureblobBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_cursor_make(size : Int) -> ImagefeatureblobCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureblobCursor::len(self : ImagefeatureblobCursor) -> Int { self.size }

pub fn ImagefeatureblobCursor::get(self : ImagefeatureblobCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureblobCursor::set(self : ImagefeatureblobCursor, i : Int, v : Double) -> ImagefeatureblobCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobCursor::sum(self : ImagefeatureblobCursor) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureblobCursor::mean(self : ImagefeatureblobCursor) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureblobCursor::scale(self : ImagefeatureblobCursor, f : Double) -> ImagefeatureblobCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobCursor::add(self : ImagefeatureblobCursor, other : ImagefeatureblobCursor) -> ImagefeatureblobCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureblobCursor::copy(self : ImagefeatureblobCursor) -> ImagefeatureblobCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobCursor::fill(self : ImagefeatureblobCursor, v : Double) -> ImagefeatureblobCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobCursor::min(self : ImagefeatureblobCursor) -> Double { @_common.min(self.data) }

pub fn ImagefeatureblobCursor::max(self : ImagefeatureblobCursor) -> Double { @_common.max(self.data) }

pub fn ImagefeatureblobCursor::to_string(self : ImagefeatureblobCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_view_make(size : Int) -> ImagefeatureblobView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureblobView::len(self : ImagefeatureblobView) -> Int { self.size }

pub fn ImagefeatureblobView::get(self : ImagefeatureblobView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureblobView::set(self : ImagefeatureblobView, i : Int, v : Double) -> ImagefeatureblobView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobView::sum(self : ImagefeatureblobView) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureblobView::mean(self : ImagefeatureblobView) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureblobView::scale(self : ImagefeatureblobView, f : Double) -> ImagefeatureblobView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobView::add(self : ImagefeatureblobView, other : ImagefeatureblobView) -> ImagefeatureblobView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureblobView::copy(self : ImagefeatureblobView) -> ImagefeatureblobView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobView::fill(self : ImagefeatureblobView, v : Double) -> ImagefeatureblobView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobView::min(self : ImagefeatureblobView) -> Double { @_common.min(self.data) }

pub fn ImagefeatureblobView::max(self : ImagefeatureblobView) -> Double { @_common.max(self.data) }

pub fn ImagefeatureblobView::to_string(self : ImagefeatureblobView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_range_make(size : Int) -> ImagefeatureblobRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureblobRange::len(self : ImagefeatureblobRange) -> Int { self.size }

pub fn ImagefeatureblobRange::get(self : ImagefeatureblobRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureblobRange::set(self : ImagefeatureblobRange, i : Int, v : Double) -> ImagefeatureblobRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobRange::sum(self : ImagefeatureblobRange) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureblobRange::mean(self : ImagefeatureblobRange) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureblobRange::scale(self : ImagefeatureblobRange, f : Double) -> ImagefeatureblobRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobRange::add(self : ImagefeatureblobRange, other : ImagefeatureblobRange) -> ImagefeatureblobRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureblobRange::copy(self : ImagefeatureblobRange) -> ImagefeatureblobRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobRange::fill(self : ImagefeatureblobRange, v : Double) -> ImagefeatureblobRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobRange::min(self : ImagefeatureblobRange) -> Double { @_common.min(self.data) }

pub fn ImagefeatureblobRange::max(self : ImagefeatureblobRange) -> Double { @_common.max(self.data) }

pub fn ImagefeatureblobRange::to_string(self : ImagefeatureblobRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_slice_make(size : Int) -> ImagefeatureblobSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeatureblobSlice::len(self : ImagefeatureblobSlice) -> Int { self.size }

pub fn ImagefeatureblobSlice::get(self : ImagefeatureblobSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeatureblobSlice::set(self : ImagefeatureblobSlice, i : Int, v : Double) -> ImagefeatureblobSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobSlice::sum(self : ImagefeatureblobSlice) -> Double { @_common.sum(self.data) }

pub fn ImagefeatureblobSlice::mean(self : ImagefeatureblobSlice) -> Double { @_common.mean(self.data) }

pub fn ImagefeatureblobSlice::scale(self : ImagefeatureblobSlice, f : Double) -> ImagefeatureblobSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobSlice::add(self : ImagefeatureblobSlice, other : ImagefeatureblobSlice) -> ImagefeatureblobSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeatureblobSlice::copy(self : ImagefeatureblobSlice) -> ImagefeatureblobSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobSlice::fill(self : ImagefeatureblobSlice, v : Double) -> ImagefeatureblobSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeatureblobSlice::min(self : ImagefeatureblobSlice) -> Double { @_common.min(self.data) }

pub fn ImagefeatureblobSlice::max(self : ImagefeatureblobSlice) -> Double { @_common.max(self.data) }

pub fn ImagefeatureblobSlice::to_string(self : ImagefeatureblobSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

