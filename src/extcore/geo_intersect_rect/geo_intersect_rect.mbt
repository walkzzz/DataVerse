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

pub fn geo_intersect_rect_frame_len(s : GeointersectrectFrame) -> Int { s.size }

pub fn geo_intersect_rect_frame_get(s : GeointersectrectFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_frame_set(s : GeointersectrectFrame, i : Int, v : Double) -> GeointersectrectFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_frame_sum(s : GeointersectrectFrame) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_rect_frame_mean(s : GeointersectrectFrame) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_rect_frame_scale(s : GeointersectrectFrame, f : Double) -> GeointersectrectFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_frame_add(a : GeointersectrectFrame, b : GeointersectrectFrame) -> GeointersectrectFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_rect_frame_copy(s : GeointersectrectFrame) -> GeointersectrectFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_frame_fill(s : GeointersectrectFrame, v : Double) -> GeointersectrectFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_frame_min(s : GeointersectrectFrame) -> Double { @_common.min(s.data) }

pub fn geo_intersect_rect_frame_max(s : GeointersectrectFrame) -> Double { @_common.max(s.data) }

pub fn geo_intersect_rect_frame_to_string(s : GeointersectrectFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_table_make(size : Int) -> GeointersectrectTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_table_len(s : GeointersectrectTable) -> Int { s.size }

pub fn geo_intersect_rect_table_get(s : GeointersectrectTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_table_set(s : GeointersectrectTable, i : Int, v : Double) -> GeointersectrectTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_table_sum(s : GeointersectrectTable) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_rect_table_mean(s : GeointersectrectTable) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_rect_table_scale(s : GeointersectrectTable, f : Double) -> GeointersectrectTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_table_add(a : GeointersectrectTable, b : GeointersectrectTable) -> GeointersectrectTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_rect_table_copy(s : GeointersectrectTable) -> GeointersectrectTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_table_fill(s : GeointersectrectTable, v : Double) -> GeointersectrectTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_table_min(s : GeointersectrectTable) -> Double { @_common.min(s.data) }

pub fn geo_intersect_rect_table_max(s : GeointersectrectTable) -> Double { @_common.max(s.data) }

pub fn geo_intersect_rect_table_to_string(s : GeointersectrectTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_graphn_make(size : Int) -> GeointersectrectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_graphn_len(s : GeointersectrectGraphN) -> Int { s.size }

pub fn geo_intersect_rect_graphn_get(s : GeointersectrectGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_graphn_set(s : GeointersectrectGraphN, i : Int, v : Double) -> GeointersectrectGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_graphn_sum(s : GeointersectrectGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_rect_graphn_mean(s : GeointersectrectGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_rect_graphn_scale(s : GeointersectrectGraphN, f : Double) -> GeointersectrectGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_graphn_add(a : GeointersectrectGraphN, b : GeointersectrectGraphN) -> GeointersectrectGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_rect_graphn_copy(s : GeointersectrectGraphN) -> GeointersectrectGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_graphn_fill(s : GeointersectrectGraphN, v : Double) -> GeointersectrectGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_graphn_min(s : GeointersectrectGraphN) -> Double { @_common.min(s.data) }

pub fn geo_intersect_rect_graphn_max(s : GeointersectrectGraphN) -> Double { @_common.max(s.data) }

pub fn geo_intersect_rect_graphn_to_string(s : GeointersectrectGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_node_make(size : Int) -> GeointersectrectNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_node_len(s : GeointersectrectNode) -> Int { s.size }

pub fn geo_intersect_rect_node_get(s : GeointersectrectNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_node_set(s : GeointersectrectNode, i : Int, v : Double) -> GeointersectrectNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_node_sum(s : GeointersectrectNode) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_rect_node_mean(s : GeointersectrectNode) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_rect_node_scale(s : GeointersectrectNode, f : Double) -> GeointersectrectNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_node_add(a : GeointersectrectNode, b : GeointersectrectNode) -> GeointersectrectNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_rect_node_copy(s : GeointersectrectNode) -> GeointersectrectNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_node_fill(s : GeointersectrectNode, v : Double) -> GeointersectrectNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_node_min(s : GeointersectrectNode) -> Double { @_common.min(s.data) }

pub fn geo_intersect_rect_node_max(s : GeointersectrectNode) -> Double { @_common.max(s.data) }

pub fn geo_intersect_rect_node_to_string(s : GeointersectrectNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_edge_make(size : Int) -> GeointersectrectEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_edge_len(s : GeointersectrectEdge) -> Int { s.size }

pub fn geo_intersect_rect_edge_get(s : GeointersectrectEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_edge_set(s : GeointersectrectEdge, i : Int, v : Double) -> GeointersectrectEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_edge_sum(s : GeointersectrectEdge) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_rect_edge_mean(s : GeointersectrectEdge) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_rect_edge_scale(s : GeointersectrectEdge, f : Double) -> GeointersectrectEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_edge_add(a : GeointersectrectEdge, b : GeointersectrectEdge) -> GeointersectrectEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_rect_edge_copy(s : GeointersectrectEdge) -> GeointersectrectEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_edge_fill(s : GeointersectrectEdge, v : Double) -> GeointersectrectEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_edge_min(s : GeointersectrectEdge) -> Double { @_common.min(s.data) }

pub fn geo_intersect_rect_edge_max(s : GeointersectrectEdge) -> Double { @_common.max(s.data) }

pub fn geo_intersect_rect_edge_to_string(s : GeointersectrectEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_path_make(size : Int) -> GeointersectrectPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_path_len(s : GeointersectrectPath) -> Int { s.size }

pub fn geo_intersect_rect_path_get(s : GeointersectrectPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_path_set(s : GeointersectrectPath, i : Int, v : Double) -> GeointersectrectPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_path_sum(s : GeointersectrectPath) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_rect_path_mean(s : GeointersectrectPath) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_rect_path_scale(s : GeointersectrectPath, f : Double) -> GeointersectrectPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_path_add(a : GeointersectrectPath, b : GeointersectrectPath) -> GeointersectrectPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_rect_path_copy(s : GeointersectrectPath) -> GeointersectrectPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_path_fill(s : GeointersectrectPath, v : Double) -> GeointersectrectPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_path_min(s : GeointersectrectPath) -> Double { @_common.min(s.data) }

pub fn geo_intersect_rect_path_max(s : GeointersectrectPath) -> Double { @_common.max(s.data) }

pub fn geo_intersect_rect_path_to_string(s : GeointersectrectPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_cluster_make(size : Int) -> GeointersectrectCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_cluster_len(s : GeointersectrectCluster) -> Int { s.size }

pub fn geo_intersect_rect_cluster_get(s : GeointersectrectCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_cluster_set(s : GeointersectrectCluster, i : Int, v : Double) -> GeointersectrectCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_cluster_sum(s : GeointersectrectCluster) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_rect_cluster_mean(s : GeointersectrectCluster) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_rect_cluster_scale(s : GeointersectrectCluster, f : Double) -> GeointersectrectCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_cluster_add(a : GeointersectrectCluster, b : GeointersectrectCluster) -> GeointersectrectCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_rect_cluster_copy(s : GeointersectrectCluster) -> GeointersectrectCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_cluster_fill(s : GeointersectrectCluster, v : Double) -> GeointersectrectCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_cluster_min(s : GeointersectrectCluster) -> Double { @_common.min(s.data) }

pub fn geo_intersect_rect_cluster_max(s : GeointersectrectCluster) -> Double { @_common.max(s.data) }

pub fn geo_intersect_rect_cluster_to_string(s : GeointersectrectCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_model_make(size : Int) -> GeointersectrectModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_model_len(s : GeointersectrectModel) -> Int { s.size }

pub fn geo_intersect_rect_model_get(s : GeointersectrectModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_model_set(s : GeointersectrectModel, i : Int, v : Double) -> GeointersectrectModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_model_sum(s : GeointersectrectModel) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_rect_model_mean(s : GeointersectrectModel) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_rect_model_scale(s : GeointersectrectModel, f : Double) -> GeointersectrectModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_model_add(a : GeointersectrectModel, b : GeointersectrectModel) -> GeointersectrectModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_rect_model_copy(s : GeointersectrectModel) -> GeointersectrectModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_model_fill(s : GeointersectrectModel, v : Double) -> GeointersectrectModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_model_min(s : GeointersectrectModel) -> Double { @_common.min(s.data) }

pub fn geo_intersect_rect_model_max(s : GeointersectrectModel) -> Double { @_common.max(s.data) }

pub fn geo_intersect_rect_model_to_string(s : GeointersectrectModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_layer_make(size : Int) -> GeointersectrectLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_layer_len(s : GeointersectrectLayer) -> Int { s.size }

pub fn geo_intersect_rect_layer_get(s : GeointersectrectLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_layer_set(s : GeointersectrectLayer, i : Int, v : Double) -> GeointersectrectLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_layer_sum(s : GeointersectrectLayer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_rect_layer_mean(s : GeointersectrectLayer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_rect_layer_scale(s : GeointersectrectLayer, f : Double) -> GeointersectrectLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_layer_add(a : GeointersectrectLayer, b : GeointersectrectLayer) -> GeointersectrectLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_rect_layer_copy(s : GeointersectrectLayer) -> GeointersectrectLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_layer_fill(s : GeointersectrectLayer, v : Double) -> GeointersectrectLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_layer_min(s : GeointersectrectLayer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_rect_layer_max(s : GeointersectrectLayer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_rect_layer_to_string(s : GeointersectrectLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_buffer_make(size : Int) -> GeointersectrectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_buffer_len(s : GeointersectrectBuffer) -> Int { s.size }

pub fn geo_intersect_rect_buffer_get(s : GeointersectrectBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_buffer_set(s : GeointersectrectBuffer, i : Int, v : Double) -> GeointersectrectBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_buffer_sum(s : GeointersectrectBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_rect_buffer_mean(s : GeointersectrectBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_rect_buffer_scale(s : GeointersectrectBuffer, f : Double) -> GeointersectrectBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_buffer_add(a : GeointersectrectBuffer, b : GeointersectrectBuffer) -> GeointersectrectBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_rect_buffer_copy(s : GeointersectrectBuffer) -> GeointersectrectBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_buffer_fill(s : GeointersectrectBuffer, v : Double) -> GeointersectrectBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_buffer_min(s : GeointersectrectBuffer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_rect_buffer_max(s : GeointersectrectBuffer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_rect_buffer_to_string(s : GeointersectrectBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_cursor_make(size : Int) -> GeointersectrectCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_cursor_len(s : GeointersectrectCursor) -> Int { s.size }

pub fn geo_intersect_rect_cursor_get(s : GeointersectrectCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_cursor_set(s : GeointersectrectCursor, i : Int, v : Double) -> GeointersectrectCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_cursor_sum(s : GeointersectrectCursor) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_rect_cursor_mean(s : GeointersectrectCursor) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_rect_cursor_scale(s : GeointersectrectCursor, f : Double) -> GeointersectrectCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_cursor_add(a : GeointersectrectCursor, b : GeointersectrectCursor) -> GeointersectrectCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_rect_cursor_copy(s : GeointersectrectCursor) -> GeointersectrectCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_cursor_fill(s : GeointersectrectCursor, v : Double) -> GeointersectrectCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_cursor_min(s : GeointersectrectCursor) -> Double { @_common.min(s.data) }

pub fn geo_intersect_rect_cursor_max(s : GeointersectrectCursor) -> Double { @_common.max(s.data) }

pub fn geo_intersect_rect_cursor_to_string(s : GeointersectrectCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_view_make(size : Int) -> GeointersectrectView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_view_len(s : GeointersectrectView) -> Int { s.size }

pub fn geo_intersect_rect_view_get(s : GeointersectrectView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_view_set(s : GeointersectrectView, i : Int, v : Double) -> GeointersectrectView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_view_sum(s : GeointersectrectView) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_rect_view_mean(s : GeointersectrectView) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_rect_view_scale(s : GeointersectrectView, f : Double) -> GeointersectrectView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_view_add(a : GeointersectrectView, b : GeointersectrectView) -> GeointersectrectView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_rect_view_copy(s : GeointersectrectView) -> GeointersectrectView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_view_fill(s : GeointersectrectView, v : Double) -> GeointersectrectView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_view_min(s : GeointersectrectView) -> Double { @_common.min(s.data) }

pub fn geo_intersect_rect_view_max(s : GeointersectrectView) -> Double { @_common.max(s.data) }

pub fn geo_intersect_rect_view_to_string(s : GeointersectrectView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_range_make(size : Int) -> GeointersectrectRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_range_len(s : GeointersectrectRange) -> Int { s.size }

pub fn geo_intersect_rect_range_get(s : GeointersectrectRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_range_set(s : GeointersectrectRange, i : Int, v : Double) -> GeointersectrectRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_range_sum(s : GeointersectrectRange) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_rect_range_mean(s : GeointersectrectRange) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_rect_range_scale(s : GeointersectrectRange, f : Double) -> GeointersectrectRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_range_add(a : GeointersectrectRange, b : GeointersectrectRange) -> GeointersectrectRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_rect_range_copy(s : GeointersectrectRange) -> GeointersectrectRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_range_fill(s : GeointersectrectRange, v : Double) -> GeointersectrectRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_range_min(s : GeointersectrectRange) -> Double { @_common.min(s.data) }

pub fn geo_intersect_rect_range_max(s : GeointersectrectRange) -> Double { @_common.max(s.data) }

pub fn geo_intersect_rect_range_to_string(s : GeointersectrectRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_slice_make(size : Int) -> GeointersectrectSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_slice_len(s : GeointersectrectSlice) -> Int { s.size }

pub fn geo_intersect_rect_slice_get(s : GeointersectrectSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_slice_set(s : GeointersectrectSlice, i : Int, v : Double) -> GeointersectrectSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_slice_sum(s : GeointersectrectSlice) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_rect_slice_mean(s : GeointersectrectSlice) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_rect_slice_scale(s : GeointersectrectSlice, f : Double) -> GeointersectrectSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_slice_add(a : GeointersectrectSlice, b : GeointersectrectSlice) -> GeointersectrectSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_rect_slice_copy(s : GeointersectrectSlice) -> GeointersectrectSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_slice_fill(s : GeointersectrectSlice, v : Double) -> GeointersectrectSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_rect_slice_min(s : GeointersectrectSlice) -> Double { @_common.min(s.data) }

pub fn geo_intersect_rect_slice_max(s : GeointersectrectSlice) -> Double { @_common.max(s.data) }

pub fn geo_intersect_rect_slice_to_string(s : GeointersectrectSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

