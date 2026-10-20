///===
/// extcore/geo_intersect_rect

pub(all) struct GeointersectrectPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_rect_make_point(x : Double, y : Double) -> GeointersectrectPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_rect_make_point3(x : Double, y : Double, z : Double) -> GeointersectrectPoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectrectPoint::x(self : GeointersectrectPoint) -> Double { self.x }

pub fn GeointersectrectPoint::y(self : GeointersectrectPoint) -> Double { self.y }

pub fn GeointersectrectPoint::z(self : GeointersectrectPoint) -> Double { self.z }

pub fn GeointersectrectPoint::label(self : GeointersectrectPoint) -> Int { self.label }

pub fn GeointersectrectPoint::dist(self : GeointersectrectPoint, other : GeointersectrectPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectrectPoint::add(self : GeointersectrectPoint, other : GeointersectrectPoint) -> GeointersectrectPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectrectPoint::sub(self : GeointersectrectPoint, other : GeointersectrectPoint) -> GeointersectrectPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectrectPoint::scale(self : GeointersectrectPoint, s : Double) -> GeointersectrectPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectrectPoint::dot(self : GeointersectrectPoint, other : GeointersectrectPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectrectPoint::cross(self : GeointersectrectPoint, other : GeointersectrectPoint) -> GeointersectrectPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectrectPoint::norm(self : GeointersectrectPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectrectPoint::normalize(self : GeointersectrectPoint) -> GeointersectrectPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectrectPoint::negate(self : GeointersectrectPoint) -> GeointersectrectPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectrectPoint::mid(self : GeointersectrectPoint, other : GeointersectrectPoint) -> GeointersectrectPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectrectPoint::lerp(self : GeointersectrectPoint, other : GeointersectrectPoint, t : Double) -> GeointersectrectPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectrectPoint::to_string(self : GeointersectrectPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectrectSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_rect_make_series(vals : Array[Double], name : String) -> GeointersectrectSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectrectSeries::len(self : GeointersectrectSeries) -> Int { self.vals.length() }

pub fn GeointersectrectSeries::sum(self : GeointersectrectSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectrectSeries::mean(self : GeointersectrectSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectrectSeries::min(self : GeointersectrectSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectrectSeries::max(self : GeointersectrectSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectrectSeries::range(self : GeointersectrectSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectrectSeries::variance(self : GeointersectrectSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectrectSeries::std(self : GeointersectrectSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectrectSeries::median(self : GeointersectrectSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectrectSeries::scale(self : GeointersectrectSeries, f : Double) -> GeointersectrectSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectrectSeries::add(self : GeointersectrectSeries, other : GeointersectrectSeries) -> GeointersectrectSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectrectSeries::sub(self : GeointersectrectSeries, other : GeointersectrectSeries) -> GeointersectrectSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectrectSeries::normalize(self : GeointersectrectSeries) -> GeointersectrectSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectrectSeries::cumsum(self : GeointersectrectSeries) -> GeointersectrectSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectrectSeries::to_string(self : GeointersectrectSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectrectMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_rect_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectrectMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_rect_matrix_identity(n : Int) -> GeointersectrectMatrix {
  let m = geo_intersect_rect_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectrectMatrix::get(self : GeointersectrectMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectrectMatrix::transpose(self : GeointersectrectMatrix) -> GeointersectrectMatrix {
  let result = geo_intersect_rect_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectrectMatrix::add(self : GeointersectrectMatrix, other : GeointersectrectMatrix) -> GeointersectrectMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_rect_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectrectMatrix::scale(self : GeointersectrectMatrix, s : Double) -> GeointersectrectMatrix {
  let result = geo_intersect_rect_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectrectMatrix::multiply(self : GeointersectrectMatrix, other : GeointersectrectMatrix) -> GeointersectrectMatrix {
  if self.cols != other.rows { return geo_intersect_rect_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_rect_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeointersectrectMatrix::trace(self : GeointersectrectMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectrectMatrix::det(self : GeointersectrectMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectrectMatrix::norm(self : GeointersectrectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectrectMatrix::to_string(self : GeointersectrectMatrix) -> String {
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

pub(all) struct GeointersectrectVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_rect_make_vector(comps : Array[Double]) -> GeointersectrectVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_rect_vector_zero(dim : Int) -> GeointersectrectVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectrectVector::add(self : GeointersectrectVector, other : GeointersectrectVector) -> GeointersectrectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectrectVector::sub(self : GeointersectrectVector, other : GeointersectrectVector) -> GeointersectrectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectrectVector::scale(self : GeointersectrectVector, s : Double) -> GeointersectrectVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectrectVector::dot(self : GeointersectrectVector, other : GeointersectrectVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectrectVector::norm(self : GeointersectrectVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectrectVector::normalize(self : GeointersectrectVector) -> GeointersectrectVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectrectVector::dist(self : GeointersectrectVector, other : GeointersectrectVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectrectVector::to_string(self : GeointersectrectVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_rect_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_intersect_rect_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_intersect_rect_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_intersect_rect_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_intersect_rect_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_intersect_rect_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_intersect_rect_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_intersect_rect_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_intersect_rect_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_intersect_rect_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_intersect_rect_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_intersect_rect_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_intersect_rect_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_intersect_rect_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_intersect_rect_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_intersect_rect_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_intersect_rect_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_intersect_rect_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_intersect_rect_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_intersect_rect_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_intersect_rect_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_intersect_rect_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_intersect_rect_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_intersect_rect_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_intersect_rect_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_intersect_rect_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_intersect_rect_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_intersect_rect_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_intersect_rect_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeointersectrectFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_frame_make(size : Int) -> GeointersectrectFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrectFrame::len(self : GeointersectrectFrame) -> Int { self.size }

pub fn GeointersectrectFrame::get(self : GeointersectrectFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrectFrame::set(self : GeointersectrectFrame, i : Int, v : Double) -> GeointersectrectFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrectFrame::sum(self : GeointersectrectFrame) -> Double { @_common.sum(self.data) }

pub fn GeointersectrectFrame::mean(self : GeointersectrectFrame) -> Double { @_common.mean(self.data) }

pub fn GeointersectrectFrame::scale(self : GeointersectrectFrame, f : Double) -> GeointersectrectFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrectFrame::add(self : GeointersectrectFrame, other : GeointersectrectFrame) -> GeointersectrectFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrectFrame::copy(self : GeointersectrectFrame) -> GeointersectrectFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrectFrame::fill(self : GeointersectrectFrame, v : Double) -> GeointersectrectFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrectFrame::min(self : GeointersectrectFrame) -> Double { @_common.min(self.data) }

pub fn GeointersectrectFrame::max(self : GeointersectrectFrame) -> Double { @_common.max(self.data) }

pub fn GeointersectrectFrame::to_string(self : GeointersectrectFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrectTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_table_make(size : Int) -> GeointersectrectTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrectTable::len(self : GeointersectrectTable) -> Int { self.size }

pub fn GeointersectrectTable::get(self : GeointersectrectTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrectTable::set(self : GeointersectrectTable, i : Int, v : Double) -> GeointersectrectTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrectTable::sum(self : GeointersectrectTable) -> Double { @_common.sum(self.data) }

pub fn GeointersectrectTable::mean(self : GeointersectrectTable) -> Double { @_common.mean(self.data) }

pub fn GeointersectrectTable::scale(self : GeointersectrectTable, f : Double) -> GeointersectrectTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrectTable::add(self : GeointersectrectTable, other : GeointersectrectTable) -> GeointersectrectTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrectTable::copy(self : GeointersectrectTable) -> GeointersectrectTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrectTable::fill(self : GeointersectrectTable, v : Double) -> GeointersectrectTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrectTable::min(self : GeointersectrectTable) -> Double { @_common.min(self.data) }

pub fn GeointersectrectTable::max(self : GeointersectrectTable) -> Double { @_common.max(self.data) }

pub fn GeointersectrectTable::to_string(self : GeointersectrectTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrectGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_graphn_make(size : Int) -> GeointersectrectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrectGraphN::len(self : GeointersectrectGraphN) -> Int { self.size }

pub fn GeointersectrectGraphN::get(self : GeointersectrectGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrectGraphN::set(self : GeointersectrectGraphN, i : Int, v : Double) -> GeointersectrectGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrectGraphN::sum(self : GeointersectrectGraphN) -> Double { @_common.sum(self.data) }

pub fn GeointersectrectGraphN::mean(self : GeointersectrectGraphN) -> Double { @_common.mean(self.data) }

pub fn GeointersectrectGraphN::scale(self : GeointersectrectGraphN, f : Double) -> GeointersectrectGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrectGraphN::add(self : GeointersectrectGraphN, other : GeointersectrectGraphN) -> GeointersectrectGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrectGraphN::copy(self : GeointersectrectGraphN) -> GeointersectrectGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrectGraphN::fill(self : GeointersectrectGraphN, v : Double) -> GeointersectrectGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrectGraphN::min(self : GeointersectrectGraphN) -> Double { @_common.min(self.data) }

pub fn GeointersectrectGraphN::max(self : GeointersectrectGraphN) -> Double { @_common.max(self.data) }

pub fn GeointersectrectGraphN::to_string(self : GeointersectrectGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrectNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_node_make(size : Int) -> GeointersectrectNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrectNode::len(self : GeointersectrectNode) -> Int { self.size }

pub fn GeointersectrectNode::get(self : GeointersectrectNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrectNode::set(self : GeointersectrectNode, i : Int, v : Double) -> GeointersectrectNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrectNode::sum(self : GeointersectrectNode) -> Double { @_common.sum(self.data) }

pub fn GeointersectrectNode::mean(self : GeointersectrectNode) -> Double { @_common.mean(self.data) }

pub fn GeointersectrectNode::scale(self : GeointersectrectNode, f : Double) -> GeointersectrectNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrectNode::add(self : GeointersectrectNode, other : GeointersectrectNode) -> GeointersectrectNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrectNode::copy(self : GeointersectrectNode) -> GeointersectrectNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrectNode::fill(self : GeointersectrectNode, v : Double) -> GeointersectrectNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrectNode::min(self : GeointersectrectNode) -> Double { @_common.min(self.data) }

pub fn GeointersectrectNode::max(self : GeointersectrectNode) -> Double { @_common.max(self.data) }

pub fn GeointersectrectNode::to_string(self : GeointersectrectNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrectEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_edge_make(size : Int) -> GeointersectrectEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrectEdge::len(self : GeointersectrectEdge) -> Int { self.size }

pub fn GeointersectrectEdge::get(self : GeointersectrectEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrectEdge::set(self : GeointersectrectEdge, i : Int, v : Double) -> GeointersectrectEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrectEdge::sum(self : GeointersectrectEdge) -> Double { @_common.sum(self.data) }

pub fn GeointersectrectEdge::mean(self : GeointersectrectEdge) -> Double { @_common.mean(self.data) }

pub fn GeointersectrectEdge::scale(self : GeointersectrectEdge, f : Double) -> GeointersectrectEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrectEdge::add(self : GeointersectrectEdge, other : GeointersectrectEdge) -> GeointersectrectEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrectEdge::copy(self : GeointersectrectEdge) -> GeointersectrectEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrectEdge::fill(self : GeointersectrectEdge, v : Double) -> GeointersectrectEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrectEdge::min(self : GeointersectrectEdge) -> Double { @_common.min(self.data) }

pub fn GeointersectrectEdge::max(self : GeointersectrectEdge) -> Double { @_common.max(self.data) }

pub fn GeointersectrectEdge::to_string(self : GeointersectrectEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrectPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_path_make(size : Int) -> GeointersectrectPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrectPath::len(self : GeointersectrectPath) -> Int { self.size }

pub fn GeointersectrectPath::get(self : GeointersectrectPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrectPath::set(self : GeointersectrectPath, i : Int, v : Double) -> GeointersectrectPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrectPath::sum(self : GeointersectrectPath) -> Double { @_common.sum(self.data) }

pub fn GeointersectrectPath::mean(self : GeointersectrectPath) -> Double { @_common.mean(self.data) }

pub fn GeointersectrectPath::scale(self : GeointersectrectPath, f : Double) -> GeointersectrectPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrectPath::add(self : GeointersectrectPath, other : GeointersectrectPath) -> GeointersectrectPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrectPath::copy(self : GeointersectrectPath) -> GeointersectrectPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrectPath::fill(self : GeointersectrectPath, v : Double) -> GeointersectrectPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrectPath::min(self : GeointersectrectPath) -> Double { @_common.min(self.data) }

pub fn GeointersectrectPath::max(self : GeointersectrectPath) -> Double { @_common.max(self.data) }

pub fn GeointersectrectPath::to_string(self : GeointersectrectPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrectCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_cluster_make(size : Int) -> GeointersectrectCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrectCluster::len(self : GeointersectrectCluster) -> Int { self.size }

pub fn GeointersectrectCluster::get(self : GeointersectrectCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrectCluster::set(self : GeointersectrectCluster, i : Int, v : Double) -> GeointersectrectCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrectCluster::sum(self : GeointersectrectCluster) -> Double { @_common.sum(self.data) }

pub fn GeointersectrectCluster::mean(self : GeointersectrectCluster) -> Double { @_common.mean(self.data) }

pub fn GeointersectrectCluster::scale(self : GeointersectrectCluster, f : Double) -> GeointersectrectCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrectCluster::add(self : GeointersectrectCluster, other : GeointersectrectCluster) -> GeointersectrectCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrectCluster::copy(self : GeointersectrectCluster) -> GeointersectrectCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrectCluster::fill(self : GeointersectrectCluster, v : Double) -> GeointersectrectCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrectCluster::min(self : GeointersectrectCluster) -> Double { @_common.min(self.data) }

pub fn GeointersectrectCluster::max(self : GeointersectrectCluster) -> Double { @_common.max(self.data) }

pub fn GeointersectrectCluster::to_string(self : GeointersectrectCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrectModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_model_make(size : Int) -> GeointersectrectModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrectModel::len(self : GeointersectrectModel) -> Int { self.size }

pub fn GeointersectrectModel::get(self : GeointersectrectModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrectModel::set(self : GeointersectrectModel, i : Int, v : Double) -> GeointersectrectModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrectModel::sum(self : GeointersectrectModel) -> Double { @_common.sum(self.data) }

pub fn GeointersectrectModel::mean(self : GeointersectrectModel) -> Double { @_common.mean(self.data) }

pub fn GeointersectrectModel::scale(self : GeointersectrectModel, f : Double) -> GeointersectrectModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrectModel::add(self : GeointersectrectModel, other : GeointersectrectModel) -> GeointersectrectModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrectModel::copy(self : GeointersectrectModel) -> GeointersectrectModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrectModel::fill(self : GeointersectrectModel, v : Double) -> GeointersectrectModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrectModel::min(self : GeointersectrectModel) -> Double { @_common.min(self.data) }

pub fn GeointersectrectModel::max(self : GeointersectrectModel) -> Double { @_common.max(self.data) }

pub fn GeointersectrectModel::to_string(self : GeointersectrectModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrectLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_layer_make(size : Int) -> GeointersectrectLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrectLayer::len(self : GeointersectrectLayer) -> Int { self.size }

pub fn GeointersectrectLayer::get(self : GeointersectrectLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrectLayer::set(self : GeointersectrectLayer, i : Int, v : Double) -> GeointersectrectLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrectLayer::sum(self : GeointersectrectLayer) -> Double { @_common.sum(self.data) }

pub fn GeointersectrectLayer::mean(self : GeointersectrectLayer) -> Double { @_common.mean(self.data) }

pub fn GeointersectrectLayer::scale(self : GeointersectrectLayer, f : Double) -> GeointersectrectLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrectLayer::add(self : GeointersectrectLayer, other : GeointersectrectLayer) -> GeointersectrectLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrectLayer::copy(self : GeointersectrectLayer) -> GeointersectrectLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrectLayer::fill(self : GeointersectrectLayer, v : Double) -> GeointersectrectLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrectLayer::min(self : GeointersectrectLayer) -> Double { @_common.min(self.data) }

pub fn GeointersectrectLayer::max(self : GeointersectrectLayer) -> Double { @_common.max(self.data) }

pub fn GeointersectrectLayer::to_string(self : GeointersectrectLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrectBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_buffer_make(size : Int) -> GeointersectrectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrectBuffer::len(self : GeointersectrectBuffer) -> Int { self.size }

pub fn GeointersectrectBuffer::get(self : GeointersectrectBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrectBuffer::set(self : GeointersectrectBuffer, i : Int, v : Double) -> GeointersectrectBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrectBuffer::sum(self : GeointersectrectBuffer) -> Double { @_common.sum(self.data) }

pub fn GeointersectrectBuffer::mean(self : GeointersectrectBuffer) -> Double { @_common.mean(self.data) }

pub fn GeointersectrectBuffer::scale(self : GeointersectrectBuffer, f : Double) -> GeointersectrectBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrectBuffer::add(self : GeointersectrectBuffer, other : GeointersectrectBuffer) -> GeointersectrectBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrectBuffer::copy(self : GeointersectrectBuffer) -> GeointersectrectBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrectBuffer::fill(self : GeointersectrectBuffer, v : Double) -> GeointersectrectBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrectBuffer::min(self : GeointersectrectBuffer) -> Double { @_common.min(self.data) }

pub fn GeointersectrectBuffer::max(self : GeointersectrectBuffer) -> Double { @_common.max(self.data) }

pub fn GeointersectrectBuffer::to_string(self : GeointersectrectBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrectCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_cursor_make(size : Int) -> GeointersectrectCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrectCursor::len(self : GeointersectrectCursor) -> Int { self.size }

pub fn GeointersectrectCursor::get(self : GeointersectrectCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrectCursor::set(self : GeointersectrectCursor, i : Int, v : Double) -> GeointersectrectCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrectCursor::sum(self : GeointersectrectCursor) -> Double { @_common.sum(self.data) }

pub fn GeointersectrectCursor::mean(self : GeointersectrectCursor) -> Double { @_common.mean(self.data) }

pub fn GeointersectrectCursor::scale(self : GeointersectrectCursor, f : Double) -> GeointersectrectCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrectCursor::add(self : GeointersectrectCursor, other : GeointersectrectCursor) -> GeointersectrectCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrectCursor::copy(self : GeointersectrectCursor) -> GeointersectrectCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrectCursor::fill(self : GeointersectrectCursor, v : Double) -> GeointersectrectCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrectCursor::min(self : GeointersectrectCursor) -> Double { @_common.min(self.data) }

pub fn GeointersectrectCursor::max(self : GeointersectrectCursor) -> Double { @_common.max(self.data) }

pub fn GeointersectrectCursor::to_string(self : GeointersectrectCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrectView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_view_make(size : Int) -> GeointersectrectView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrectView::len(self : GeointersectrectView) -> Int { self.size }

pub fn GeointersectrectView::get(self : GeointersectrectView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrectView::set(self : GeointersectrectView, i : Int, v : Double) -> GeointersectrectView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrectView::sum(self : GeointersectrectView) -> Double { @_common.sum(self.data) }

pub fn GeointersectrectView::mean(self : GeointersectrectView) -> Double { @_common.mean(self.data) }

pub fn GeointersectrectView::scale(self : GeointersectrectView, f : Double) -> GeointersectrectView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrectView::add(self : GeointersectrectView, other : GeointersectrectView) -> GeointersectrectView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrectView::copy(self : GeointersectrectView) -> GeointersectrectView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrectView::fill(self : GeointersectrectView, v : Double) -> GeointersectrectView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrectView::min(self : GeointersectrectView) -> Double { @_common.min(self.data) }

pub fn GeointersectrectView::max(self : GeointersectrectView) -> Double { @_common.max(self.data) }

pub fn GeointersectrectView::to_string(self : GeointersectrectView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrectRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_range_make(size : Int) -> GeointersectrectRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrectRange::len(self : GeointersectrectRange) -> Int { self.size }

pub fn GeointersectrectRange::get(self : GeointersectrectRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrectRange::set(self : GeointersectrectRange, i : Int, v : Double) -> GeointersectrectRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrectRange::sum(self : GeointersectrectRange) -> Double { @_common.sum(self.data) }

pub fn GeointersectrectRange::mean(self : GeointersectrectRange) -> Double { @_common.mean(self.data) }

pub fn GeointersectrectRange::scale(self : GeointersectrectRange, f : Double) -> GeointersectrectRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrectRange::add(self : GeointersectrectRange, other : GeointersectrectRange) -> GeointersectrectRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrectRange::copy(self : GeointersectrectRange) -> GeointersectrectRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrectRange::fill(self : GeointersectrectRange, v : Double) -> GeointersectrectRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrectRange::min(self : GeointersectrectRange) -> Double { @_common.min(self.data) }

pub fn GeointersectrectRange::max(self : GeointersectrectRange) -> Double { @_common.max(self.data) }

pub fn GeointersectrectRange::to_string(self : GeointersectrectRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrectSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_slice_make(size : Int) -> GeointersectrectSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrectSlice::len(self : GeointersectrectSlice) -> Int { self.size }

pub fn GeointersectrectSlice::get(self : GeointersectrectSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrectSlice::set(self : GeointersectrectSlice, i : Int, v : Double) -> GeointersectrectSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrectSlice::sum(self : GeointersectrectSlice) -> Double { @_common.sum(self.data) }

pub fn GeointersectrectSlice::mean(self : GeointersectrectSlice) -> Double { @_common.mean(self.data) }

pub fn GeointersectrectSlice::scale(self : GeointersectrectSlice, f : Double) -> GeointersectrectSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrectSlice::add(self : GeointersectrectSlice, other : GeointersectrectSlice) -> GeointersectrectSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrectSlice::copy(self : GeointersectrectSlice) -> GeointersectrectSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrectSlice::fill(self : GeointersectrectSlice, v : Double) -> GeointersectrectSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrectSlice::min(self : GeointersectrectSlice) -> Double { @_common.min(self.data) }

pub fn GeointersectrectSlice::max(self : GeointersectrectSlice) -> Double { @_common.max(self.data) }

pub fn GeointersectrectSlice::to_string(self : GeointersectrectSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

