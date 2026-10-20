///===
/// extcore/image_feature_mser

pub(all) struct ImagefeaturemserPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_mser_make_point(x : Double, y : Double) -> ImagefeaturemserPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_mser_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturemserPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeaturemserPoint::x(self : ImagefeaturemserPoint) -> Double { self.x }

pub fn ImagefeaturemserPoint::y(self : ImagefeaturemserPoint) -> Double { self.y }

pub fn ImagefeaturemserPoint::z(self : ImagefeaturemserPoint) -> Double { self.z }

pub fn ImagefeaturemserPoint::label(self : ImagefeaturemserPoint) -> Int { self.label }

pub fn ImagefeaturemserPoint::dist(self : ImagefeaturemserPoint, other : ImagefeaturemserPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeaturemserPoint::add(self : ImagefeaturemserPoint, other : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeaturemserPoint::sub(self : ImagefeaturemserPoint, other : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeaturemserPoint::scale(self : ImagefeaturemserPoint, s : Double) -> ImagefeaturemserPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeaturemserPoint::dot(self : ImagefeaturemserPoint, other : ImagefeaturemserPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeaturemserPoint::cross(self : ImagefeaturemserPoint, other : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeaturemserPoint::norm(self : ImagefeaturemserPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeaturemserPoint::normalize(self : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturemserPoint::negate(self : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeaturemserPoint::mid(self : ImagefeaturemserPoint, other : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeaturemserPoint::lerp(self : ImagefeaturemserPoint, other : ImagefeaturemserPoint, t : Double) -> ImagefeaturemserPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeaturemserPoint::to_string(self : ImagefeaturemserPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeaturemserSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_mser_make_series(vals : Array[Double], name : String) -> ImagefeaturemserSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeaturemserSeries::len(self : ImagefeaturemserSeries) -> Int { self.vals.length() }

pub fn ImagefeaturemserSeries::sum(self : ImagefeaturemserSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeaturemserSeries::mean(self : ImagefeaturemserSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeaturemserSeries::min(self : ImagefeaturemserSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeaturemserSeries::max(self : ImagefeaturemserSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeaturemserSeries::range(self : ImagefeaturemserSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeaturemserSeries::variance(self : ImagefeaturemserSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeaturemserSeries::std(self : ImagefeaturemserSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeaturemserSeries::median(self : ImagefeaturemserSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeaturemserSeries::scale(self : ImagefeaturemserSeries, f : Double) -> ImagefeaturemserSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeaturemserSeries::add(self : ImagefeaturemserSeries, other : ImagefeaturemserSeries) -> ImagefeaturemserSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeaturemserSeries::sub(self : ImagefeaturemserSeries, other : ImagefeaturemserSeries) -> ImagefeaturemserSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeaturemserSeries::normalize(self : ImagefeaturemserSeries) -> ImagefeaturemserSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeaturemserSeries::cumsum(self : ImagefeaturemserSeries) -> ImagefeaturemserSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeaturemserSeries::to_string(self : ImagefeaturemserSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturemserMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_mser_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturemserMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_mser_matrix_identity(n : Int) -> ImagefeaturemserMatrix {
  let m = image_feature_mser_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeaturemserMatrix::get(self : ImagefeaturemserMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeaturemserMatrix::transpose(self : ImagefeaturemserMatrix) -> ImagefeaturemserMatrix {
  let result = image_feature_mser_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeaturemserMatrix::add(self : ImagefeaturemserMatrix, other : ImagefeaturemserMatrix) -> ImagefeaturemserMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_mser_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeaturemserMatrix::scale(self : ImagefeaturemserMatrix, s : Double) -> ImagefeaturemserMatrix {
  let result = image_feature_mser_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeaturemserMatrix::multiply(self : ImagefeaturemserMatrix, other : ImagefeaturemserMatrix) -> ImagefeaturemserMatrix {
  if self.cols != other.rows { return image_feature_mser_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_mser_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefeaturemserMatrix::trace(self : ImagefeaturemserMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeaturemserMatrix::det(self : ImagefeaturemserMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeaturemserMatrix::norm(self : ImagefeaturemserMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeaturemserMatrix::to_string(self : ImagefeaturemserMatrix) -> String {
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

pub(all) struct ImagefeaturemserVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_mser_make_vector(comps : Array[Double]) -> ImagefeaturemserVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_mser_vector_zero(dim : Int) -> ImagefeaturemserVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeaturemserVector::add(self : ImagefeaturemserVector, other : ImagefeaturemserVector) -> ImagefeaturemserVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturemserVector::sub(self : ImagefeaturemserVector, other : ImagefeaturemserVector) -> ImagefeaturemserVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturemserVector::scale(self : ImagefeaturemserVector, s : Double) -> ImagefeaturemserVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeaturemserVector::dot(self : ImagefeaturemserVector, other : ImagefeaturemserVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeaturemserVector::norm(self : ImagefeaturemserVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeaturemserVector::normalize(self : ImagefeaturemserVector) -> ImagefeaturemserVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturemserVector::dist(self : ImagefeaturemserVector, other : ImagefeaturemserVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeaturemserVector::to_string(self : ImagefeaturemserVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_mser_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_mser_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_mser_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_mser_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_mser_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_mser_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_mser_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_mser_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_mser_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_mser_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_mser_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_mser_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_mser_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_mser_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_mser_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_mser_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_mser_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_mser_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_mser_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_mser_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_mser_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_mser_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_mser_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_mser_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_mser_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_mser_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_mser_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_mser_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_mser_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeaturemserFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_frame_make(size : Int) -> ImagefeaturemserFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturemserFrame::len(self : ImagefeaturemserFrame) -> Int { self.size }

pub fn ImagefeaturemserFrame::get(self : ImagefeaturemserFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturemserFrame::set(self : ImagefeaturemserFrame, i : Int, v : Double) -> ImagefeaturemserFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserFrame::sum(self : ImagefeaturemserFrame) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturemserFrame::mean(self : ImagefeaturemserFrame) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturemserFrame::scale(self : ImagefeaturemserFrame, f : Double) -> ImagefeaturemserFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserFrame::add(self : ImagefeaturemserFrame, other : ImagefeaturemserFrame) -> ImagefeaturemserFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturemserFrame::copy(self : ImagefeaturemserFrame) -> ImagefeaturemserFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserFrame::fill(self : ImagefeaturemserFrame, v : Double) -> ImagefeaturemserFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserFrame::min(self : ImagefeaturemserFrame) -> Double { @_common.min(self.data) }

pub fn ImagefeaturemserFrame::max(self : ImagefeaturemserFrame) -> Double { @_common.max(self.data) }

pub fn ImagefeaturemserFrame::to_string(self : ImagefeaturemserFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_table_make(size : Int) -> ImagefeaturemserTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturemserTable::len(self : ImagefeaturemserTable) -> Int { self.size }

pub fn ImagefeaturemserTable::get(self : ImagefeaturemserTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturemserTable::set(self : ImagefeaturemserTable, i : Int, v : Double) -> ImagefeaturemserTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserTable::sum(self : ImagefeaturemserTable) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturemserTable::mean(self : ImagefeaturemserTable) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturemserTable::scale(self : ImagefeaturemserTable, f : Double) -> ImagefeaturemserTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserTable::add(self : ImagefeaturemserTable, other : ImagefeaturemserTable) -> ImagefeaturemserTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturemserTable::copy(self : ImagefeaturemserTable) -> ImagefeaturemserTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserTable::fill(self : ImagefeaturemserTable, v : Double) -> ImagefeaturemserTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserTable::min(self : ImagefeaturemserTable) -> Double { @_common.min(self.data) }

pub fn ImagefeaturemserTable::max(self : ImagefeaturemserTable) -> Double { @_common.max(self.data) }

pub fn ImagefeaturemserTable::to_string(self : ImagefeaturemserTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_graphn_make(size : Int) -> ImagefeaturemserGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturemserGraphN::len(self : ImagefeaturemserGraphN) -> Int { self.size }

pub fn ImagefeaturemserGraphN::get(self : ImagefeaturemserGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturemserGraphN::set(self : ImagefeaturemserGraphN, i : Int, v : Double) -> ImagefeaturemserGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserGraphN::sum(self : ImagefeaturemserGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturemserGraphN::mean(self : ImagefeaturemserGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturemserGraphN::scale(self : ImagefeaturemserGraphN, f : Double) -> ImagefeaturemserGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserGraphN::add(self : ImagefeaturemserGraphN, other : ImagefeaturemserGraphN) -> ImagefeaturemserGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturemserGraphN::copy(self : ImagefeaturemserGraphN) -> ImagefeaturemserGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserGraphN::fill(self : ImagefeaturemserGraphN, v : Double) -> ImagefeaturemserGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserGraphN::min(self : ImagefeaturemserGraphN) -> Double { @_common.min(self.data) }

pub fn ImagefeaturemserGraphN::max(self : ImagefeaturemserGraphN) -> Double { @_common.max(self.data) }

pub fn ImagefeaturemserGraphN::to_string(self : ImagefeaturemserGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_node_make(size : Int) -> ImagefeaturemserNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturemserNode::len(self : ImagefeaturemserNode) -> Int { self.size }

pub fn ImagefeaturemserNode::get(self : ImagefeaturemserNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturemserNode::set(self : ImagefeaturemserNode, i : Int, v : Double) -> ImagefeaturemserNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserNode::sum(self : ImagefeaturemserNode) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturemserNode::mean(self : ImagefeaturemserNode) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturemserNode::scale(self : ImagefeaturemserNode, f : Double) -> ImagefeaturemserNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserNode::add(self : ImagefeaturemserNode, other : ImagefeaturemserNode) -> ImagefeaturemserNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturemserNode::copy(self : ImagefeaturemserNode) -> ImagefeaturemserNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserNode::fill(self : ImagefeaturemserNode, v : Double) -> ImagefeaturemserNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserNode::min(self : ImagefeaturemserNode) -> Double { @_common.min(self.data) }

pub fn ImagefeaturemserNode::max(self : ImagefeaturemserNode) -> Double { @_common.max(self.data) }

pub fn ImagefeaturemserNode::to_string(self : ImagefeaturemserNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_edge_make(size : Int) -> ImagefeaturemserEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturemserEdge::len(self : ImagefeaturemserEdge) -> Int { self.size }

pub fn ImagefeaturemserEdge::get(self : ImagefeaturemserEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturemserEdge::set(self : ImagefeaturemserEdge, i : Int, v : Double) -> ImagefeaturemserEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserEdge::sum(self : ImagefeaturemserEdge) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturemserEdge::mean(self : ImagefeaturemserEdge) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturemserEdge::scale(self : ImagefeaturemserEdge, f : Double) -> ImagefeaturemserEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserEdge::add(self : ImagefeaturemserEdge, other : ImagefeaturemserEdge) -> ImagefeaturemserEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturemserEdge::copy(self : ImagefeaturemserEdge) -> ImagefeaturemserEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserEdge::fill(self : ImagefeaturemserEdge, v : Double) -> ImagefeaturemserEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserEdge::min(self : ImagefeaturemserEdge) -> Double { @_common.min(self.data) }

pub fn ImagefeaturemserEdge::max(self : ImagefeaturemserEdge) -> Double { @_common.max(self.data) }

pub fn ImagefeaturemserEdge::to_string(self : ImagefeaturemserEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_path_make(size : Int) -> ImagefeaturemserPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturemserPath::len(self : ImagefeaturemserPath) -> Int { self.size }

pub fn ImagefeaturemserPath::get(self : ImagefeaturemserPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturemserPath::set(self : ImagefeaturemserPath, i : Int, v : Double) -> ImagefeaturemserPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserPath::sum(self : ImagefeaturemserPath) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturemserPath::mean(self : ImagefeaturemserPath) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturemserPath::scale(self : ImagefeaturemserPath, f : Double) -> ImagefeaturemserPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserPath::add(self : ImagefeaturemserPath, other : ImagefeaturemserPath) -> ImagefeaturemserPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturemserPath::copy(self : ImagefeaturemserPath) -> ImagefeaturemserPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserPath::fill(self : ImagefeaturemserPath, v : Double) -> ImagefeaturemserPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserPath::min(self : ImagefeaturemserPath) -> Double { @_common.min(self.data) }

pub fn ImagefeaturemserPath::max(self : ImagefeaturemserPath) -> Double { @_common.max(self.data) }

pub fn ImagefeaturemserPath::to_string(self : ImagefeaturemserPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_cluster_make(size : Int) -> ImagefeaturemserCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturemserCluster::len(self : ImagefeaturemserCluster) -> Int { self.size }

pub fn ImagefeaturemserCluster::get(self : ImagefeaturemserCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturemserCluster::set(self : ImagefeaturemserCluster, i : Int, v : Double) -> ImagefeaturemserCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserCluster::sum(self : ImagefeaturemserCluster) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturemserCluster::mean(self : ImagefeaturemserCluster) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturemserCluster::scale(self : ImagefeaturemserCluster, f : Double) -> ImagefeaturemserCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserCluster::add(self : ImagefeaturemserCluster, other : ImagefeaturemserCluster) -> ImagefeaturemserCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturemserCluster::copy(self : ImagefeaturemserCluster) -> ImagefeaturemserCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserCluster::fill(self : ImagefeaturemserCluster, v : Double) -> ImagefeaturemserCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserCluster::min(self : ImagefeaturemserCluster) -> Double { @_common.min(self.data) }

pub fn ImagefeaturemserCluster::max(self : ImagefeaturemserCluster) -> Double { @_common.max(self.data) }

pub fn ImagefeaturemserCluster::to_string(self : ImagefeaturemserCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_model_make(size : Int) -> ImagefeaturemserModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturemserModel::len(self : ImagefeaturemserModel) -> Int { self.size }

pub fn ImagefeaturemserModel::get(self : ImagefeaturemserModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturemserModel::set(self : ImagefeaturemserModel, i : Int, v : Double) -> ImagefeaturemserModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserModel::sum(self : ImagefeaturemserModel) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturemserModel::mean(self : ImagefeaturemserModel) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturemserModel::scale(self : ImagefeaturemserModel, f : Double) -> ImagefeaturemserModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserModel::add(self : ImagefeaturemserModel, other : ImagefeaturemserModel) -> ImagefeaturemserModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturemserModel::copy(self : ImagefeaturemserModel) -> ImagefeaturemserModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserModel::fill(self : ImagefeaturemserModel, v : Double) -> ImagefeaturemserModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserModel::min(self : ImagefeaturemserModel) -> Double { @_common.min(self.data) }

pub fn ImagefeaturemserModel::max(self : ImagefeaturemserModel) -> Double { @_common.max(self.data) }

pub fn ImagefeaturemserModel::to_string(self : ImagefeaturemserModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_layer_make(size : Int) -> ImagefeaturemserLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturemserLayer::len(self : ImagefeaturemserLayer) -> Int { self.size }

pub fn ImagefeaturemserLayer::get(self : ImagefeaturemserLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturemserLayer::set(self : ImagefeaturemserLayer, i : Int, v : Double) -> ImagefeaturemserLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserLayer::sum(self : ImagefeaturemserLayer) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturemserLayer::mean(self : ImagefeaturemserLayer) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturemserLayer::scale(self : ImagefeaturemserLayer, f : Double) -> ImagefeaturemserLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserLayer::add(self : ImagefeaturemserLayer, other : ImagefeaturemserLayer) -> ImagefeaturemserLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturemserLayer::copy(self : ImagefeaturemserLayer) -> ImagefeaturemserLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserLayer::fill(self : ImagefeaturemserLayer, v : Double) -> ImagefeaturemserLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserLayer::min(self : ImagefeaturemserLayer) -> Double { @_common.min(self.data) }

pub fn ImagefeaturemserLayer::max(self : ImagefeaturemserLayer) -> Double { @_common.max(self.data) }

pub fn ImagefeaturemserLayer::to_string(self : ImagefeaturemserLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_buffer_make(size : Int) -> ImagefeaturemserBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturemserBuffer::len(self : ImagefeaturemserBuffer) -> Int { self.size }

pub fn ImagefeaturemserBuffer::get(self : ImagefeaturemserBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturemserBuffer::set(self : ImagefeaturemserBuffer, i : Int, v : Double) -> ImagefeaturemserBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserBuffer::sum(self : ImagefeaturemserBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturemserBuffer::mean(self : ImagefeaturemserBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturemserBuffer::scale(self : ImagefeaturemserBuffer, f : Double) -> ImagefeaturemserBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserBuffer::add(self : ImagefeaturemserBuffer, other : ImagefeaturemserBuffer) -> ImagefeaturemserBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturemserBuffer::copy(self : ImagefeaturemserBuffer) -> ImagefeaturemserBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserBuffer::fill(self : ImagefeaturemserBuffer, v : Double) -> ImagefeaturemserBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserBuffer::min(self : ImagefeaturemserBuffer) -> Double { @_common.min(self.data) }

pub fn ImagefeaturemserBuffer::max(self : ImagefeaturemserBuffer) -> Double { @_common.max(self.data) }

pub fn ImagefeaturemserBuffer::to_string(self : ImagefeaturemserBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_cursor_make(size : Int) -> ImagefeaturemserCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturemserCursor::len(self : ImagefeaturemserCursor) -> Int { self.size }

pub fn ImagefeaturemserCursor::get(self : ImagefeaturemserCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturemserCursor::set(self : ImagefeaturemserCursor, i : Int, v : Double) -> ImagefeaturemserCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserCursor::sum(self : ImagefeaturemserCursor) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturemserCursor::mean(self : ImagefeaturemserCursor) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturemserCursor::scale(self : ImagefeaturemserCursor, f : Double) -> ImagefeaturemserCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserCursor::add(self : ImagefeaturemserCursor, other : ImagefeaturemserCursor) -> ImagefeaturemserCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturemserCursor::copy(self : ImagefeaturemserCursor) -> ImagefeaturemserCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserCursor::fill(self : ImagefeaturemserCursor, v : Double) -> ImagefeaturemserCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserCursor::min(self : ImagefeaturemserCursor) -> Double { @_common.min(self.data) }

pub fn ImagefeaturemserCursor::max(self : ImagefeaturemserCursor) -> Double { @_common.max(self.data) }

pub fn ImagefeaturemserCursor::to_string(self : ImagefeaturemserCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_view_make(size : Int) -> ImagefeaturemserView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturemserView::len(self : ImagefeaturemserView) -> Int { self.size }

pub fn ImagefeaturemserView::get(self : ImagefeaturemserView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturemserView::set(self : ImagefeaturemserView, i : Int, v : Double) -> ImagefeaturemserView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserView::sum(self : ImagefeaturemserView) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturemserView::mean(self : ImagefeaturemserView) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturemserView::scale(self : ImagefeaturemserView, f : Double) -> ImagefeaturemserView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserView::add(self : ImagefeaturemserView, other : ImagefeaturemserView) -> ImagefeaturemserView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturemserView::copy(self : ImagefeaturemserView) -> ImagefeaturemserView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserView::fill(self : ImagefeaturemserView, v : Double) -> ImagefeaturemserView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserView::min(self : ImagefeaturemserView) -> Double { @_common.min(self.data) }

pub fn ImagefeaturemserView::max(self : ImagefeaturemserView) -> Double { @_common.max(self.data) }

pub fn ImagefeaturemserView::to_string(self : ImagefeaturemserView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_range_make(size : Int) -> ImagefeaturemserRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturemserRange::len(self : ImagefeaturemserRange) -> Int { self.size }

pub fn ImagefeaturemserRange::get(self : ImagefeaturemserRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturemserRange::set(self : ImagefeaturemserRange, i : Int, v : Double) -> ImagefeaturemserRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserRange::sum(self : ImagefeaturemserRange) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturemserRange::mean(self : ImagefeaturemserRange) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturemserRange::scale(self : ImagefeaturemserRange, f : Double) -> ImagefeaturemserRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserRange::add(self : ImagefeaturemserRange, other : ImagefeaturemserRange) -> ImagefeaturemserRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturemserRange::copy(self : ImagefeaturemserRange) -> ImagefeaturemserRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserRange::fill(self : ImagefeaturemserRange, v : Double) -> ImagefeaturemserRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserRange::min(self : ImagefeaturemserRange) -> Double { @_common.min(self.data) }

pub fn ImagefeaturemserRange::max(self : ImagefeaturemserRange) -> Double { @_common.max(self.data) }

pub fn ImagefeaturemserRange::to_string(self : ImagefeaturemserRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_slice_make(size : Int) -> ImagefeaturemserSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefeaturemserSlice::len(self : ImagefeaturemserSlice) -> Int { self.size }

pub fn ImagefeaturemserSlice::get(self : ImagefeaturemserSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefeaturemserSlice::set(self : ImagefeaturemserSlice, i : Int, v : Double) -> ImagefeaturemserSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserSlice::sum(self : ImagefeaturemserSlice) -> Double { @_common.sum(self.data) }

pub fn ImagefeaturemserSlice::mean(self : ImagefeaturemserSlice) -> Double { @_common.mean(self.data) }

pub fn ImagefeaturemserSlice::scale(self : ImagefeaturemserSlice, f : Double) -> ImagefeaturemserSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserSlice::add(self : ImagefeaturemserSlice, other : ImagefeaturemserSlice) -> ImagefeaturemserSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefeaturemserSlice::copy(self : ImagefeaturemserSlice) -> ImagefeaturemserSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserSlice::fill(self : ImagefeaturemserSlice, v : Double) -> ImagefeaturemserSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefeaturemserSlice::min(self : ImagefeaturemserSlice) -> Double { @_common.min(self.data) }

pub fn ImagefeaturemserSlice::max(self : ImagefeaturemserSlice) -> Double { @_common.max(self.data) }

pub fn ImagefeaturemserSlice::to_string(self : ImagefeaturemserSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

