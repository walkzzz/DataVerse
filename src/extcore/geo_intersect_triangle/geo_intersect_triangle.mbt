///===
/// extcore/geo_intersect_triangle

pub(all) struct GeointersecttrianglePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_triangle_make_point(x : Double, y : Double) -> GeointersecttrianglePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_triangle_make_point3(x : Double, y : Double, z : Double) -> GeointersecttrianglePoint {
  { x, y, z, label: 0 }
}

pub fn GeointersecttrianglePoint::x(self : GeointersecttrianglePoint) -> Double { self.x }

pub fn GeointersecttrianglePoint::y(self : GeointersecttrianglePoint) -> Double { self.y }

pub fn GeointersecttrianglePoint::z(self : GeointersecttrianglePoint) -> Double { self.z }

pub fn GeointersecttrianglePoint::label(self : GeointersecttrianglePoint) -> Int { self.label }

pub fn GeointersecttrianglePoint::dist(self : GeointersecttrianglePoint, other : GeointersecttrianglePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersecttrianglePoint::add(self : GeointersecttrianglePoint, other : GeointersecttrianglePoint) -> GeointersecttrianglePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersecttrianglePoint::sub(self : GeointersecttrianglePoint, other : GeointersecttrianglePoint) -> GeointersecttrianglePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersecttrianglePoint::scale(self : GeointersecttrianglePoint, s : Double) -> GeointersecttrianglePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersecttrianglePoint::dot(self : GeointersecttrianglePoint, other : GeointersecttrianglePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersecttrianglePoint::cross(self : GeointersecttrianglePoint, other : GeointersecttrianglePoint) -> GeointersecttrianglePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersecttrianglePoint::norm(self : GeointersecttrianglePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersecttrianglePoint::normalize(self : GeointersecttrianglePoint) -> GeointersecttrianglePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersecttrianglePoint::negate(self : GeointersecttrianglePoint) -> GeointersecttrianglePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersecttrianglePoint::mid(self : GeointersecttrianglePoint, other : GeointersecttrianglePoint) -> GeointersecttrianglePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersecttrianglePoint::lerp(self : GeointersecttrianglePoint, other : GeointersecttrianglePoint, t : Double) -> GeointersecttrianglePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersecttrianglePoint::to_string(self : GeointersecttrianglePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersecttriangleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_triangle_make_series(vals : Array[Double], name : String) -> GeointersecttriangleSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersecttriangleSeries::len(self : GeointersecttriangleSeries) -> Int { self.vals.length() }

pub fn GeointersecttriangleSeries::sum(self : GeointersecttriangleSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersecttriangleSeries::mean(self : GeointersecttriangleSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersecttriangleSeries::min(self : GeointersecttriangleSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersecttriangleSeries::max(self : GeointersecttriangleSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersecttriangleSeries::range(self : GeointersecttriangleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersecttriangleSeries::variance(self : GeointersecttriangleSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersecttriangleSeries::std(self : GeointersecttriangleSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersecttriangleSeries::median(self : GeointersecttriangleSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersecttriangleSeries::scale(self : GeointersecttriangleSeries, f : Double) -> GeointersecttriangleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersecttriangleSeries::add(self : GeointersecttriangleSeries, other : GeointersecttriangleSeries) -> GeointersecttriangleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersecttriangleSeries::sub(self : GeointersecttriangleSeries, other : GeointersecttriangleSeries) -> GeointersecttriangleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersecttriangleSeries::normalize(self : GeointersecttriangleSeries) -> GeointersecttriangleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersecttriangleSeries::cumsum(self : GeointersecttriangleSeries) -> GeointersecttriangleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersecttriangleSeries::to_string(self : GeointersecttriangleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersecttriangleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_triangle_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersecttriangleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_triangle_matrix_identity(n : Int) -> GeointersecttriangleMatrix {
  let m = geo_intersect_triangle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersecttriangleMatrix::get(self : GeointersecttriangleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersecttriangleMatrix::transpose(self : GeointersecttriangleMatrix) -> GeointersecttriangleMatrix {
  let result = geo_intersect_triangle_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersecttriangleMatrix::add(self : GeointersecttriangleMatrix, other : GeointersecttriangleMatrix) -> GeointersecttriangleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_triangle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersecttriangleMatrix::scale(self : GeointersecttriangleMatrix, s : Double) -> GeointersecttriangleMatrix {
  let result = geo_intersect_triangle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersecttriangleMatrix::multiply(self : GeointersecttriangleMatrix, other : GeointersecttriangleMatrix) -> GeointersecttriangleMatrix {
  if self.cols != other.rows { return geo_intersect_triangle_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_triangle_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeointersecttriangleMatrix::trace(self : GeointersecttriangleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersecttriangleMatrix::det(self : GeointersecttriangleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersecttriangleMatrix::norm(self : GeointersecttriangleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersecttriangleMatrix::to_string(self : GeointersecttriangleMatrix) -> String {
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

pub(all) struct GeointersecttriangleVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_triangle_make_vector(comps : Array[Double]) -> GeointersecttriangleVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_triangle_vector_zero(dim : Int) -> GeointersecttriangleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersecttriangleVector::add(self : GeointersecttriangleVector, other : GeointersecttriangleVector) -> GeointersecttriangleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersecttriangleVector::sub(self : GeointersecttriangleVector, other : GeointersecttriangleVector) -> GeointersecttriangleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersecttriangleVector::scale(self : GeointersecttriangleVector, s : Double) -> GeointersecttriangleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersecttriangleVector::dot(self : GeointersecttriangleVector, other : GeointersecttriangleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersecttriangleVector::norm(self : GeointersecttriangleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersecttriangleVector::normalize(self : GeointersecttriangleVector) -> GeointersecttriangleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersecttriangleVector::dist(self : GeointersecttriangleVector, other : GeointersecttriangleVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersecttriangleVector::to_string(self : GeointersecttriangleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_triangle_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_intersect_triangle_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_intersect_triangle_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_intersect_triangle_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_intersect_triangle_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_intersect_triangle_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_intersect_triangle_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_intersect_triangle_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_intersect_triangle_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_intersect_triangle_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_intersect_triangle_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_intersect_triangle_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_intersect_triangle_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_intersect_triangle_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_intersect_triangle_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_intersect_triangle_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_intersect_triangle_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_intersect_triangle_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_intersect_triangle_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_intersect_triangle_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_intersect_triangle_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_intersect_triangle_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_intersect_triangle_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_intersect_triangle_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_intersect_triangle_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_intersect_triangle_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_intersect_triangle_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_intersect_triangle_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_intersect_triangle_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeointersecttriangleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_frame_make(size : Int) -> GeointersecttriangleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_frame_len(s : GeointersecttriangleFrame) -> Int { s.size }

pub fn geo_intersect_triangle_frame_get(s : GeointersecttriangleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_frame_set(s : GeointersecttriangleFrame, i : Int, v : Double) -> GeointersecttriangleFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_frame_sum(s : GeointersecttriangleFrame) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_triangle_frame_mean(s : GeointersecttriangleFrame) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_triangle_frame_scale(s : GeointersecttriangleFrame, f : Double) -> GeointersecttriangleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_frame_add(a : GeointersecttriangleFrame, b : GeointersecttriangleFrame) -> GeointersecttriangleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_triangle_frame_copy(s : GeointersecttriangleFrame) -> GeointersecttriangleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_frame_fill(s : GeointersecttriangleFrame, v : Double) -> GeointersecttriangleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_frame_min(s : GeointersecttriangleFrame) -> Double { @_common.min(s.data) }

pub fn geo_intersect_triangle_frame_max(s : GeointersecttriangleFrame) -> Double { @_common.max(s.data) }

pub fn geo_intersect_triangle_frame_to_string(s : GeointersecttriangleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_table_make(size : Int) -> GeointersecttriangleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_table_len(s : GeointersecttriangleTable) -> Int { s.size }

pub fn geo_intersect_triangle_table_get(s : GeointersecttriangleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_table_set(s : GeointersecttriangleTable, i : Int, v : Double) -> GeointersecttriangleTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_table_sum(s : GeointersecttriangleTable) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_triangle_table_mean(s : GeointersecttriangleTable) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_triangle_table_scale(s : GeointersecttriangleTable, f : Double) -> GeointersecttriangleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_table_add(a : GeointersecttriangleTable, b : GeointersecttriangleTable) -> GeointersecttriangleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_triangle_table_copy(s : GeointersecttriangleTable) -> GeointersecttriangleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_table_fill(s : GeointersecttriangleTable, v : Double) -> GeointersecttriangleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_table_min(s : GeointersecttriangleTable) -> Double { @_common.min(s.data) }

pub fn geo_intersect_triangle_table_max(s : GeointersecttriangleTable) -> Double { @_common.max(s.data) }

pub fn geo_intersect_triangle_table_to_string(s : GeointersecttriangleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_graphn_make(size : Int) -> GeointersecttriangleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_graphn_len(s : GeointersecttriangleGraphN) -> Int { s.size }

pub fn geo_intersect_triangle_graphn_get(s : GeointersecttriangleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_graphn_set(s : GeointersecttriangleGraphN, i : Int, v : Double) -> GeointersecttriangleGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_graphn_sum(s : GeointersecttriangleGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_triangle_graphn_mean(s : GeointersecttriangleGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_triangle_graphn_scale(s : GeointersecttriangleGraphN, f : Double) -> GeointersecttriangleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_graphn_add(a : GeointersecttriangleGraphN, b : GeointersecttriangleGraphN) -> GeointersecttriangleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_triangle_graphn_copy(s : GeointersecttriangleGraphN) -> GeointersecttriangleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_graphn_fill(s : GeointersecttriangleGraphN, v : Double) -> GeointersecttriangleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_graphn_min(s : GeointersecttriangleGraphN) -> Double { @_common.min(s.data) }

pub fn geo_intersect_triangle_graphn_max(s : GeointersecttriangleGraphN) -> Double { @_common.max(s.data) }

pub fn geo_intersect_triangle_graphn_to_string(s : GeointersecttriangleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_node_make(size : Int) -> GeointersecttriangleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_node_len(s : GeointersecttriangleNode) -> Int { s.size }

pub fn geo_intersect_triangle_node_get(s : GeointersecttriangleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_node_set(s : GeointersecttriangleNode, i : Int, v : Double) -> GeointersecttriangleNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_node_sum(s : GeointersecttriangleNode) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_triangle_node_mean(s : GeointersecttriangleNode) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_triangle_node_scale(s : GeointersecttriangleNode, f : Double) -> GeointersecttriangleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_node_add(a : GeointersecttriangleNode, b : GeointersecttriangleNode) -> GeointersecttriangleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_triangle_node_copy(s : GeointersecttriangleNode) -> GeointersecttriangleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_node_fill(s : GeointersecttriangleNode, v : Double) -> GeointersecttriangleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_node_min(s : GeointersecttriangleNode) -> Double { @_common.min(s.data) }

pub fn geo_intersect_triangle_node_max(s : GeointersecttriangleNode) -> Double { @_common.max(s.data) }

pub fn geo_intersect_triangle_node_to_string(s : GeointersecttriangleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_edge_make(size : Int) -> GeointersecttriangleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_edge_len(s : GeointersecttriangleEdge) -> Int { s.size }

pub fn geo_intersect_triangle_edge_get(s : GeointersecttriangleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_edge_set(s : GeointersecttriangleEdge, i : Int, v : Double) -> GeointersecttriangleEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_edge_sum(s : GeointersecttriangleEdge) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_triangle_edge_mean(s : GeointersecttriangleEdge) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_triangle_edge_scale(s : GeointersecttriangleEdge, f : Double) -> GeointersecttriangleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_edge_add(a : GeointersecttriangleEdge, b : GeointersecttriangleEdge) -> GeointersecttriangleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_triangle_edge_copy(s : GeointersecttriangleEdge) -> GeointersecttriangleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_edge_fill(s : GeointersecttriangleEdge, v : Double) -> GeointersecttriangleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_edge_min(s : GeointersecttriangleEdge) -> Double { @_common.min(s.data) }

pub fn geo_intersect_triangle_edge_max(s : GeointersecttriangleEdge) -> Double { @_common.max(s.data) }

pub fn geo_intersect_triangle_edge_to_string(s : GeointersecttriangleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttrianglePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_path_make(size : Int) -> GeointersecttrianglePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_path_len(s : GeointersecttrianglePath) -> Int { s.size }

pub fn geo_intersect_triangle_path_get(s : GeointersecttrianglePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_path_set(s : GeointersecttrianglePath, i : Int, v : Double) -> GeointersecttrianglePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_path_sum(s : GeointersecttrianglePath) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_triangle_path_mean(s : GeointersecttrianglePath) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_triangle_path_scale(s : GeointersecttrianglePath, f : Double) -> GeointersecttrianglePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_path_add(a : GeointersecttrianglePath, b : GeointersecttrianglePath) -> GeointersecttrianglePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_triangle_path_copy(s : GeointersecttrianglePath) -> GeointersecttrianglePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_path_fill(s : GeointersecttrianglePath, v : Double) -> GeointersecttrianglePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_path_min(s : GeointersecttrianglePath) -> Double { @_common.min(s.data) }

pub fn geo_intersect_triangle_path_max(s : GeointersecttrianglePath) -> Double { @_common.max(s.data) }

pub fn geo_intersect_triangle_path_to_string(s : GeointersecttrianglePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_cluster_make(size : Int) -> GeointersecttriangleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_cluster_len(s : GeointersecttriangleCluster) -> Int { s.size }

pub fn geo_intersect_triangle_cluster_get(s : GeointersecttriangleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_cluster_set(s : GeointersecttriangleCluster, i : Int, v : Double) -> GeointersecttriangleCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_cluster_sum(s : GeointersecttriangleCluster) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_triangle_cluster_mean(s : GeointersecttriangleCluster) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_triangle_cluster_scale(s : GeointersecttriangleCluster, f : Double) -> GeointersecttriangleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_cluster_add(a : GeointersecttriangleCluster, b : GeointersecttriangleCluster) -> GeointersecttriangleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_triangle_cluster_copy(s : GeointersecttriangleCluster) -> GeointersecttriangleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_cluster_fill(s : GeointersecttriangleCluster, v : Double) -> GeointersecttriangleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_cluster_min(s : GeointersecttriangleCluster) -> Double { @_common.min(s.data) }

pub fn geo_intersect_triangle_cluster_max(s : GeointersecttriangleCluster) -> Double { @_common.max(s.data) }

pub fn geo_intersect_triangle_cluster_to_string(s : GeointersecttriangleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_model_make(size : Int) -> GeointersecttriangleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_model_len(s : GeointersecttriangleModel) -> Int { s.size }

pub fn geo_intersect_triangle_model_get(s : GeointersecttriangleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_model_set(s : GeointersecttriangleModel, i : Int, v : Double) -> GeointersecttriangleModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_model_sum(s : GeointersecttriangleModel) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_triangle_model_mean(s : GeointersecttriangleModel) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_triangle_model_scale(s : GeointersecttriangleModel, f : Double) -> GeointersecttriangleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_model_add(a : GeointersecttriangleModel, b : GeointersecttriangleModel) -> GeointersecttriangleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_triangle_model_copy(s : GeointersecttriangleModel) -> GeointersecttriangleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_model_fill(s : GeointersecttriangleModel, v : Double) -> GeointersecttriangleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_model_min(s : GeointersecttriangleModel) -> Double { @_common.min(s.data) }

pub fn geo_intersect_triangle_model_max(s : GeointersecttriangleModel) -> Double { @_common.max(s.data) }

pub fn geo_intersect_triangle_model_to_string(s : GeointersecttriangleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_layer_make(size : Int) -> GeointersecttriangleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_layer_len(s : GeointersecttriangleLayer) -> Int { s.size }

pub fn geo_intersect_triangle_layer_get(s : GeointersecttriangleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_layer_set(s : GeointersecttriangleLayer, i : Int, v : Double) -> GeointersecttriangleLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_layer_sum(s : GeointersecttriangleLayer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_triangle_layer_mean(s : GeointersecttriangleLayer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_triangle_layer_scale(s : GeointersecttriangleLayer, f : Double) -> GeointersecttriangleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_layer_add(a : GeointersecttriangleLayer, b : GeointersecttriangleLayer) -> GeointersecttriangleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_triangle_layer_copy(s : GeointersecttriangleLayer) -> GeointersecttriangleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_layer_fill(s : GeointersecttriangleLayer, v : Double) -> GeointersecttriangleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_layer_min(s : GeointersecttriangleLayer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_triangle_layer_max(s : GeointersecttriangleLayer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_triangle_layer_to_string(s : GeointersecttriangleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_buffer_make(size : Int) -> GeointersecttriangleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_buffer_len(s : GeointersecttriangleBuffer) -> Int { s.size }

pub fn geo_intersect_triangle_buffer_get(s : GeointersecttriangleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_buffer_set(s : GeointersecttriangleBuffer, i : Int, v : Double) -> GeointersecttriangleBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_buffer_sum(s : GeointersecttriangleBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_triangle_buffer_mean(s : GeointersecttriangleBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_triangle_buffer_scale(s : GeointersecttriangleBuffer, f : Double) -> GeointersecttriangleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_buffer_add(a : GeointersecttriangleBuffer, b : GeointersecttriangleBuffer) -> GeointersecttriangleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_triangle_buffer_copy(s : GeointersecttriangleBuffer) -> GeointersecttriangleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_buffer_fill(s : GeointersecttriangleBuffer, v : Double) -> GeointersecttriangleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_buffer_min(s : GeointersecttriangleBuffer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_triangle_buffer_max(s : GeointersecttriangleBuffer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_triangle_buffer_to_string(s : GeointersecttriangleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_cursor_make(size : Int) -> GeointersecttriangleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_cursor_len(s : GeointersecttriangleCursor) -> Int { s.size }

pub fn geo_intersect_triangle_cursor_get(s : GeointersecttriangleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_cursor_set(s : GeointersecttriangleCursor, i : Int, v : Double) -> GeointersecttriangleCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_cursor_sum(s : GeointersecttriangleCursor) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_triangle_cursor_mean(s : GeointersecttriangleCursor) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_triangle_cursor_scale(s : GeointersecttriangleCursor, f : Double) -> GeointersecttriangleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_cursor_add(a : GeointersecttriangleCursor, b : GeointersecttriangleCursor) -> GeointersecttriangleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_triangle_cursor_copy(s : GeointersecttriangleCursor) -> GeointersecttriangleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_cursor_fill(s : GeointersecttriangleCursor, v : Double) -> GeointersecttriangleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_cursor_min(s : GeointersecttriangleCursor) -> Double { @_common.min(s.data) }

pub fn geo_intersect_triangle_cursor_max(s : GeointersecttriangleCursor) -> Double { @_common.max(s.data) }

pub fn geo_intersect_triangle_cursor_to_string(s : GeointersecttriangleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_view_make(size : Int) -> GeointersecttriangleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_view_len(s : GeointersecttriangleView) -> Int { s.size }

pub fn geo_intersect_triangle_view_get(s : GeointersecttriangleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_view_set(s : GeointersecttriangleView, i : Int, v : Double) -> GeointersecttriangleView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_view_sum(s : GeointersecttriangleView) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_triangle_view_mean(s : GeointersecttriangleView) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_triangle_view_scale(s : GeointersecttriangleView, f : Double) -> GeointersecttriangleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_view_add(a : GeointersecttriangleView, b : GeointersecttriangleView) -> GeointersecttriangleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_triangle_view_copy(s : GeointersecttriangleView) -> GeointersecttriangleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_view_fill(s : GeointersecttriangleView, v : Double) -> GeointersecttriangleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_view_min(s : GeointersecttriangleView) -> Double { @_common.min(s.data) }

pub fn geo_intersect_triangle_view_max(s : GeointersecttriangleView) -> Double { @_common.max(s.data) }

pub fn geo_intersect_triangle_view_to_string(s : GeointersecttriangleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_range_make(size : Int) -> GeointersecttriangleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_range_len(s : GeointersecttriangleRange) -> Int { s.size }

pub fn geo_intersect_triangle_range_get(s : GeointersecttriangleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_range_set(s : GeointersecttriangleRange, i : Int, v : Double) -> GeointersecttriangleRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_range_sum(s : GeointersecttriangleRange) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_triangle_range_mean(s : GeointersecttriangleRange) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_triangle_range_scale(s : GeointersecttriangleRange, f : Double) -> GeointersecttriangleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_range_add(a : GeointersecttriangleRange, b : GeointersecttriangleRange) -> GeointersecttriangleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_triangle_range_copy(s : GeointersecttriangleRange) -> GeointersecttriangleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_range_fill(s : GeointersecttriangleRange, v : Double) -> GeointersecttriangleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_range_min(s : GeointersecttriangleRange) -> Double { @_common.min(s.data) }

pub fn geo_intersect_triangle_range_max(s : GeointersecttriangleRange) -> Double { @_common.max(s.data) }

pub fn geo_intersect_triangle_range_to_string(s : GeointersecttriangleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_slice_make(size : Int) -> GeointersecttriangleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_slice_len(s : GeointersecttriangleSlice) -> Int { s.size }

pub fn geo_intersect_triangle_slice_get(s : GeointersecttriangleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_slice_set(s : GeointersecttriangleSlice, i : Int, v : Double) -> GeointersecttriangleSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_slice_sum(s : GeointersecttriangleSlice) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_triangle_slice_mean(s : GeointersecttriangleSlice) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_triangle_slice_scale(s : GeointersecttriangleSlice, f : Double) -> GeointersecttriangleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_slice_add(a : GeointersecttriangleSlice, b : GeointersecttriangleSlice) -> GeointersecttriangleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_triangle_slice_copy(s : GeointersecttriangleSlice) -> GeointersecttriangleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_slice_fill(s : GeointersecttriangleSlice, v : Double) -> GeointersecttriangleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_triangle_slice_min(s : GeointersecttriangleSlice) -> Double { @_common.min(s.data) }

pub fn geo_intersect_triangle_slice_max(s : GeointersecttriangleSlice) -> Double { @_common.max(s.data) }

pub fn geo_intersect_triangle_slice_to_string(s : GeointersecttriangleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

