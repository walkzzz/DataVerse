///===
/// extcore/image_transform_affine

pub(all) struct ImagetransformaffinePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_affine_make_point(x : Double, y : Double) -> ImagetransformaffinePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_affine_make_point3(x : Double, y : Double, z : Double) -> ImagetransformaffinePoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformaffinePoint::x(self : ImagetransformaffinePoint) -> Double { self.x }

pub fn ImagetransformaffinePoint::y(self : ImagetransformaffinePoint) -> Double { self.y }

pub fn ImagetransformaffinePoint::z(self : ImagetransformaffinePoint) -> Double { self.z }

pub fn ImagetransformaffinePoint::label(self : ImagetransformaffinePoint) -> Int { self.label }

pub fn ImagetransformaffinePoint::dist(self : ImagetransformaffinePoint, other : ImagetransformaffinePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformaffinePoint::add(self : ImagetransformaffinePoint, other : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformaffinePoint::sub(self : ImagetransformaffinePoint, other : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformaffinePoint::scale(self : ImagetransformaffinePoint, s : Double) -> ImagetransformaffinePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformaffinePoint::dot(self : ImagetransformaffinePoint, other : ImagetransformaffinePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformaffinePoint::cross(self : ImagetransformaffinePoint, other : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformaffinePoint::norm(self : ImagetransformaffinePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformaffinePoint::normalize(self : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformaffinePoint::negate(self : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformaffinePoint::mid(self : ImagetransformaffinePoint, other : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformaffinePoint::lerp(self : ImagetransformaffinePoint, other : ImagetransformaffinePoint, t : Double) -> ImagetransformaffinePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformaffinePoint::to_string(self : ImagetransformaffinePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformaffineSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_affine_make_series(vals : Array[Double], name : String) -> ImagetransformaffineSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformaffineSeries::len(self : ImagetransformaffineSeries) -> Int { self.vals.length() }

pub fn ImagetransformaffineSeries::sum(self : ImagetransformaffineSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformaffineSeries::mean(self : ImagetransformaffineSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformaffineSeries::min(self : ImagetransformaffineSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformaffineSeries::max(self : ImagetransformaffineSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformaffineSeries::range(self : ImagetransformaffineSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformaffineSeries::variance(self : ImagetransformaffineSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformaffineSeries::std(self : ImagetransformaffineSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformaffineSeries::median(self : ImagetransformaffineSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformaffineSeries::scale(self : ImagetransformaffineSeries, f : Double) -> ImagetransformaffineSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformaffineSeries::add(self : ImagetransformaffineSeries, other : ImagetransformaffineSeries) -> ImagetransformaffineSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformaffineSeries::sub(self : ImagetransformaffineSeries, other : ImagetransformaffineSeries) -> ImagetransformaffineSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformaffineSeries::normalize(self : ImagetransformaffineSeries) -> ImagetransformaffineSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformaffineSeries::cumsum(self : ImagetransformaffineSeries) -> ImagetransformaffineSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformaffineSeries::to_string(self : ImagetransformaffineSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformaffineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_affine_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformaffineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_affine_matrix_identity(n : Int) -> ImagetransformaffineMatrix {
  let m = image_transform_affine_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformaffineMatrix::get(self : ImagetransformaffineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformaffineMatrix::transpose(self : ImagetransformaffineMatrix) -> ImagetransformaffineMatrix {
  let result = image_transform_affine_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformaffineMatrix::add(self : ImagetransformaffineMatrix, other : ImagetransformaffineMatrix) -> ImagetransformaffineMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_affine_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformaffineMatrix::scale(self : ImagetransformaffineMatrix, s : Double) -> ImagetransformaffineMatrix {
  let result = image_transform_affine_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformaffineMatrix::multiply(self : ImagetransformaffineMatrix, other : ImagetransformaffineMatrix) -> ImagetransformaffineMatrix {
  if self.cols != other.rows { return image_transform_affine_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_affine_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagetransformaffineMatrix::trace(self : ImagetransformaffineMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformaffineMatrix::det(self : ImagetransformaffineMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformaffineMatrix::norm(self : ImagetransformaffineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformaffineMatrix::to_string(self : ImagetransformaffineMatrix) -> String {
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

pub(all) struct ImagetransformaffineVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_affine_make_vector(comps : Array[Double]) -> ImagetransformaffineVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_affine_vector_zero(dim : Int) -> ImagetransformaffineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformaffineVector::add(self : ImagetransformaffineVector, other : ImagetransformaffineVector) -> ImagetransformaffineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformaffineVector::sub(self : ImagetransformaffineVector, other : ImagetransformaffineVector) -> ImagetransformaffineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformaffineVector::scale(self : ImagetransformaffineVector, s : Double) -> ImagetransformaffineVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformaffineVector::dot(self : ImagetransformaffineVector, other : ImagetransformaffineVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformaffineVector::norm(self : ImagetransformaffineVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformaffineVector::normalize(self : ImagetransformaffineVector) -> ImagetransformaffineVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformaffineVector::dist(self : ImagetransformaffineVector, other : ImagetransformaffineVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformaffineVector::to_string(self : ImagetransformaffineVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_affine_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_affine_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_affine_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_affine_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_affine_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_affine_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_affine_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_affine_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_affine_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_affine_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_affine_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_affine_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_affine_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_affine_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_affine_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_affine_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_affine_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_affine_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_affine_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_affine_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_affine_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_affine_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_affine_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_affine_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_affine_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_affine_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_affine_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_affine_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_affine_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformaffineFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_frame_make(size : Int) -> ImagetransformaffineFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformaffineFrame::len(self : ImagetransformaffineFrame) -> Int { self.size }

pub fn ImagetransformaffineFrame::get(self : ImagetransformaffineFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformaffineFrame::set(self : ImagetransformaffineFrame, i : Int, v : Double) -> ImagetransformaffineFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineFrame::sum(self : ImagetransformaffineFrame) -> Double { @_common.sum(self.data) }

pub fn ImagetransformaffineFrame::mean(self : ImagetransformaffineFrame) -> Double { @_common.mean(self.data) }

pub fn ImagetransformaffineFrame::scale(self : ImagetransformaffineFrame, f : Double) -> ImagetransformaffineFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineFrame::add(self : ImagetransformaffineFrame, other : ImagetransformaffineFrame) -> ImagetransformaffineFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformaffineFrame::copy(self : ImagetransformaffineFrame) -> ImagetransformaffineFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineFrame::fill(self : ImagetransformaffineFrame, v : Double) -> ImagetransformaffineFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineFrame::min(self : ImagetransformaffineFrame) -> Double { @_common.min(self.data) }

pub fn ImagetransformaffineFrame::max(self : ImagetransformaffineFrame) -> Double { @_common.max(self.data) }

pub fn ImagetransformaffineFrame::to_string(self : ImagetransformaffineFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_table_make(size : Int) -> ImagetransformaffineTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformaffineTable::len(self : ImagetransformaffineTable) -> Int { self.size }

pub fn ImagetransformaffineTable::get(self : ImagetransformaffineTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformaffineTable::set(self : ImagetransformaffineTable, i : Int, v : Double) -> ImagetransformaffineTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineTable::sum(self : ImagetransformaffineTable) -> Double { @_common.sum(self.data) }

pub fn ImagetransformaffineTable::mean(self : ImagetransformaffineTable) -> Double { @_common.mean(self.data) }

pub fn ImagetransformaffineTable::scale(self : ImagetransformaffineTable, f : Double) -> ImagetransformaffineTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineTable::add(self : ImagetransformaffineTable, other : ImagetransformaffineTable) -> ImagetransformaffineTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformaffineTable::copy(self : ImagetransformaffineTable) -> ImagetransformaffineTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineTable::fill(self : ImagetransformaffineTable, v : Double) -> ImagetransformaffineTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineTable::min(self : ImagetransformaffineTable) -> Double { @_common.min(self.data) }

pub fn ImagetransformaffineTable::max(self : ImagetransformaffineTable) -> Double { @_common.max(self.data) }

pub fn ImagetransformaffineTable::to_string(self : ImagetransformaffineTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_graphn_make(size : Int) -> ImagetransformaffineGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformaffineGraphN::len(self : ImagetransformaffineGraphN) -> Int { self.size }

pub fn ImagetransformaffineGraphN::get(self : ImagetransformaffineGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformaffineGraphN::set(self : ImagetransformaffineGraphN, i : Int, v : Double) -> ImagetransformaffineGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineGraphN::sum(self : ImagetransformaffineGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagetransformaffineGraphN::mean(self : ImagetransformaffineGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagetransformaffineGraphN::scale(self : ImagetransformaffineGraphN, f : Double) -> ImagetransformaffineGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineGraphN::add(self : ImagetransformaffineGraphN, other : ImagetransformaffineGraphN) -> ImagetransformaffineGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformaffineGraphN::copy(self : ImagetransformaffineGraphN) -> ImagetransformaffineGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineGraphN::fill(self : ImagetransformaffineGraphN, v : Double) -> ImagetransformaffineGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineGraphN::min(self : ImagetransformaffineGraphN) -> Double { @_common.min(self.data) }

pub fn ImagetransformaffineGraphN::max(self : ImagetransformaffineGraphN) -> Double { @_common.max(self.data) }

pub fn ImagetransformaffineGraphN::to_string(self : ImagetransformaffineGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_node_make(size : Int) -> ImagetransformaffineNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformaffineNode::len(self : ImagetransformaffineNode) -> Int { self.size }

pub fn ImagetransformaffineNode::get(self : ImagetransformaffineNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformaffineNode::set(self : ImagetransformaffineNode, i : Int, v : Double) -> ImagetransformaffineNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineNode::sum(self : ImagetransformaffineNode) -> Double { @_common.sum(self.data) }

pub fn ImagetransformaffineNode::mean(self : ImagetransformaffineNode) -> Double { @_common.mean(self.data) }

pub fn ImagetransformaffineNode::scale(self : ImagetransformaffineNode, f : Double) -> ImagetransformaffineNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineNode::add(self : ImagetransformaffineNode, other : ImagetransformaffineNode) -> ImagetransformaffineNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformaffineNode::copy(self : ImagetransformaffineNode) -> ImagetransformaffineNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineNode::fill(self : ImagetransformaffineNode, v : Double) -> ImagetransformaffineNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineNode::min(self : ImagetransformaffineNode) -> Double { @_common.min(self.data) }

pub fn ImagetransformaffineNode::max(self : ImagetransformaffineNode) -> Double { @_common.max(self.data) }

pub fn ImagetransformaffineNode::to_string(self : ImagetransformaffineNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_edge_make(size : Int) -> ImagetransformaffineEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformaffineEdge::len(self : ImagetransformaffineEdge) -> Int { self.size }

pub fn ImagetransformaffineEdge::get(self : ImagetransformaffineEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformaffineEdge::set(self : ImagetransformaffineEdge, i : Int, v : Double) -> ImagetransformaffineEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineEdge::sum(self : ImagetransformaffineEdge) -> Double { @_common.sum(self.data) }

pub fn ImagetransformaffineEdge::mean(self : ImagetransformaffineEdge) -> Double { @_common.mean(self.data) }

pub fn ImagetransformaffineEdge::scale(self : ImagetransformaffineEdge, f : Double) -> ImagetransformaffineEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineEdge::add(self : ImagetransformaffineEdge, other : ImagetransformaffineEdge) -> ImagetransformaffineEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformaffineEdge::copy(self : ImagetransformaffineEdge) -> ImagetransformaffineEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineEdge::fill(self : ImagetransformaffineEdge, v : Double) -> ImagetransformaffineEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineEdge::min(self : ImagetransformaffineEdge) -> Double { @_common.min(self.data) }

pub fn ImagetransformaffineEdge::max(self : ImagetransformaffineEdge) -> Double { @_common.max(self.data) }

pub fn ImagetransformaffineEdge::to_string(self : ImagetransformaffineEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffinePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_path_make(size : Int) -> ImagetransformaffinePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformaffinePath::len(self : ImagetransformaffinePath) -> Int { self.size }

pub fn ImagetransformaffinePath::get(self : ImagetransformaffinePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformaffinePath::set(self : ImagetransformaffinePath, i : Int, v : Double) -> ImagetransformaffinePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformaffinePath::sum(self : ImagetransformaffinePath) -> Double { @_common.sum(self.data) }

pub fn ImagetransformaffinePath::mean(self : ImagetransformaffinePath) -> Double { @_common.mean(self.data) }

pub fn ImagetransformaffinePath::scale(self : ImagetransformaffinePath, f : Double) -> ImagetransformaffinePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffinePath::add(self : ImagetransformaffinePath, other : ImagetransformaffinePath) -> ImagetransformaffinePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformaffinePath::copy(self : ImagetransformaffinePath) -> ImagetransformaffinePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffinePath::fill(self : ImagetransformaffinePath, v : Double) -> ImagetransformaffinePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffinePath::min(self : ImagetransformaffinePath) -> Double { @_common.min(self.data) }

pub fn ImagetransformaffinePath::max(self : ImagetransformaffinePath) -> Double { @_common.max(self.data) }

pub fn ImagetransformaffinePath::to_string(self : ImagetransformaffinePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_cluster_make(size : Int) -> ImagetransformaffineCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformaffineCluster::len(self : ImagetransformaffineCluster) -> Int { self.size }

pub fn ImagetransformaffineCluster::get(self : ImagetransformaffineCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformaffineCluster::set(self : ImagetransformaffineCluster, i : Int, v : Double) -> ImagetransformaffineCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineCluster::sum(self : ImagetransformaffineCluster) -> Double { @_common.sum(self.data) }

pub fn ImagetransformaffineCluster::mean(self : ImagetransformaffineCluster) -> Double { @_common.mean(self.data) }

pub fn ImagetransformaffineCluster::scale(self : ImagetransformaffineCluster, f : Double) -> ImagetransformaffineCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineCluster::add(self : ImagetransformaffineCluster, other : ImagetransformaffineCluster) -> ImagetransformaffineCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformaffineCluster::copy(self : ImagetransformaffineCluster) -> ImagetransformaffineCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineCluster::fill(self : ImagetransformaffineCluster, v : Double) -> ImagetransformaffineCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineCluster::min(self : ImagetransformaffineCluster) -> Double { @_common.min(self.data) }

pub fn ImagetransformaffineCluster::max(self : ImagetransformaffineCluster) -> Double { @_common.max(self.data) }

pub fn ImagetransformaffineCluster::to_string(self : ImagetransformaffineCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_model_make(size : Int) -> ImagetransformaffineModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformaffineModel::len(self : ImagetransformaffineModel) -> Int { self.size }

pub fn ImagetransformaffineModel::get(self : ImagetransformaffineModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformaffineModel::set(self : ImagetransformaffineModel, i : Int, v : Double) -> ImagetransformaffineModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineModel::sum(self : ImagetransformaffineModel) -> Double { @_common.sum(self.data) }

pub fn ImagetransformaffineModel::mean(self : ImagetransformaffineModel) -> Double { @_common.mean(self.data) }

pub fn ImagetransformaffineModel::scale(self : ImagetransformaffineModel, f : Double) -> ImagetransformaffineModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineModel::add(self : ImagetransformaffineModel, other : ImagetransformaffineModel) -> ImagetransformaffineModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformaffineModel::copy(self : ImagetransformaffineModel) -> ImagetransformaffineModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineModel::fill(self : ImagetransformaffineModel, v : Double) -> ImagetransformaffineModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineModel::min(self : ImagetransformaffineModel) -> Double { @_common.min(self.data) }

pub fn ImagetransformaffineModel::max(self : ImagetransformaffineModel) -> Double { @_common.max(self.data) }

pub fn ImagetransformaffineModel::to_string(self : ImagetransformaffineModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_layer_make(size : Int) -> ImagetransformaffineLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformaffineLayer::len(self : ImagetransformaffineLayer) -> Int { self.size }

pub fn ImagetransformaffineLayer::get(self : ImagetransformaffineLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformaffineLayer::set(self : ImagetransformaffineLayer, i : Int, v : Double) -> ImagetransformaffineLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineLayer::sum(self : ImagetransformaffineLayer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformaffineLayer::mean(self : ImagetransformaffineLayer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformaffineLayer::scale(self : ImagetransformaffineLayer, f : Double) -> ImagetransformaffineLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineLayer::add(self : ImagetransformaffineLayer, other : ImagetransformaffineLayer) -> ImagetransformaffineLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformaffineLayer::copy(self : ImagetransformaffineLayer) -> ImagetransformaffineLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineLayer::fill(self : ImagetransformaffineLayer, v : Double) -> ImagetransformaffineLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineLayer::min(self : ImagetransformaffineLayer) -> Double { @_common.min(self.data) }

pub fn ImagetransformaffineLayer::max(self : ImagetransformaffineLayer) -> Double { @_common.max(self.data) }

pub fn ImagetransformaffineLayer::to_string(self : ImagetransformaffineLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_buffer_make(size : Int) -> ImagetransformaffineBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformaffineBuffer::len(self : ImagetransformaffineBuffer) -> Int { self.size }

pub fn ImagetransformaffineBuffer::get(self : ImagetransformaffineBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformaffineBuffer::set(self : ImagetransformaffineBuffer, i : Int, v : Double) -> ImagetransformaffineBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineBuffer::sum(self : ImagetransformaffineBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagetransformaffineBuffer::mean(self : ImagetransformaffineBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagetransformaffineBuffer::scale(self : ImagetransformaffineBuffer, f : Double) -> ImagetransformaffineBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineBuffer::add(self : ImagetransformaffineBuffer, other : ImagetransformaffineBuffer) -> ImagetransformaffineBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformaffineBuffer::copy(self : ImagetransformaffineBuffer) -> ImagetransformaffineBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineBuffer::fill(self : ImagetransformaffineBuffer, v : Double) -> ImagetransformaffineBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineBuffer::min(self : ImagetransformaffineBuffer) -> Double { @_common.min(self.data) }

pub fn ImagetransformaffineBuffer::max(self : ImagetransformaffineBuffer) -> Double { @_common.max(self.data) }

pub fn ImagetransformaffineBuffer::to_string(self : ImagetransformaffineBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_cursor_make(size : Int) -> ImagetransformaffineCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformaffineCursor::len(self : ImagetransformaffineCursor) -> Int { self.size }

pub fn ImagetransformaffineCursor::get(self : ImagetransformaffineCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformaffineCursor::set(self : ImagetransformaffineCursor, i : Int, v : Double) -> ImagetransformaffineCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineCursor::sum(self : ImagetransformaffineCursor) -> Double { @_common.sum(self.data) }

pub fn ImagetransformaffineCursor::mean(self : ImagetransformaffineCursor) -> Double { @_common.mean(self.data) }

pub fn ImagetransformaffineCursor::scale(self : ImagetransformaffineCursor, f : Double) -> ImagetransformaffineCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineCursor::add(self : ImagetransformaffineCursor, other : ImagetransformaffineCursor) -> ImagetransformaffineCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformaffineCursor::copy(self : ImagetransformaffineCursor) -> ImagetransformaffineCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineCursor::fill(self : ImagetransformaffineCursor, v : Double) -> ImagetransformaffineCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineCursor::min(self : ImagetransformaffineCursor) -> Double { @_common.min(self.data) }

pub fn ImagetransformaffineCursor::max(self : ImagetransformaffineCursor) -> Double { @_common.max(self.data) }

pub fn ImagetransformaffineCursor::to_string(self : ImagetransformaffineCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_view_make(size : Int) -> ImagetransformaffineView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformaffineView::len(self : ImagetransformaffineView) -> Int { self.size }

pub fn ImagetransformaffineView::get(self : ImagetransformaffineView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformaffineView::set(self : ImagetransformaffineView, i : Int, v : Double) -> ImagetransformaffineView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineView::sum(self : ImagetransformaffineView) -> Double { @_common.sum(self.data) }

pub fn ImagetransformaffineView::mean(self : ImagetransformaffineView) -> Double { @_common.mean(self.data) }

pub fn ImagetransformaffineView::scale(self : ImagetransformaffineView, f : Double) -> ImagetransformaffineView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineView::add(self : ImagetransformaffineView, other : ImagetransformaffineView) -> ImagetransformaffineView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformaffineView::copy(self : ImagetransformaffineView) -> ImagetransformaffineView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineView::fill(self : ImagetransformaffineView, v : Double) -> ImagetransformaffineView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineView::min(self : ImagetransformaffineView) -> Double { @_common.min(self.data) }

pub fn ImagetransformaffineView::max(self : ImagetransformaffineView) -> Double { @_common.max(self.data) }

pub fn ImagetransformaffineView::to_string(self : ImagetransformaffineView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_range_make(size : Int) -> ImagetransformaffineRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformaffineRange::len(self : ImagetransformaffineRange) -> Int { self.size }

pub fn ImagetransformaffineRange::get(self : ImagetransformaffineRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformaffineRange::set(self : ImagetransformaffineRange, i : Int, v : Double) -> ImagetransformaffineRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineRange::sum(self : ImagetransformaffineRange) -> Double { @_common.sum(self.data) }

pub fn ImagetransformaffineRange::mean(self : ImagetransformaffineRange) -> Double { @_common.mean(self.data) }

pub fn ImagetransformaffineRange::scale(self : ImagetransformaffineRange, f : Double) -> ImagetransformaffineRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineRange::add(self : ImagetransformaffineRange, other : ImagetransformaffineRange) -> ImagetransformaffineRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformaffineRange::copy(self : ImagetransformaffineRange) -> ImagetransformaffineRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineRange::fill(self : ImagetransformaffineRange, v : Double) -> ImagetransformaffineRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineRange::min(self : ImagetransformaffineRange) -> Double { @_common.min(self.data) }

pub fn ImagetransformaffineRange::max(self : ImagetransformaffineRange) -> Double { @_common.max(self.data) }

pub fn ImagetransformaffineRange::to_string(self : ImagetransformaffineRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_slice_make(size : Int) -> ImagetransformaffineSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagetransformaffineSlice::len(self : ImagetransformaffineSlice) -> Int { self.size }

pub fn ImagetransformaffineSlice::get(self : ImagetransformaffineSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagetransformaffineSlice::set(self : ImagetransformaffineSlice, i : Int, v : Double) -> ImagetransformaffineSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineSlice::sum(self : ImagetransformaffineSlice) -> Double { @_common.sum(self.data) }

pub fn ImagetransformaffineSlice::mean(self : ImagetransformaffineSlice) -> Double { @_common.mean(self.data) }

pub fn ImagetransformaffineSlice::scale(self : ImagetransformaffineSlice, f : Double) -> ImagetransformaffineSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineSlice::add(self : ImagetransformaffineSlice, other : ImagetransformaffineSlice) -> ImagetransformaffineSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagetransformaffineSlice::copy(self : ImagetransformaffineSlice) -> ImagetransformaffineSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineSlice::fill(self : ImagetransformaffineSlice, v : Double) -> ImagetransformaffineSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagetransformaffineSlice::min(self : ImagetransformaffineSlice) -> Double { @_common.min(self.data) }

pub fn ImagetransformaffineSlice::max(self : ImagetransformaffineSlice) -> Double { @_common.max(self.data) }

pub fn ImagetransformaffineSlice::to_string(self : ImagetransformaffineSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

