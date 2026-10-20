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

pub fn GeointersecttriangleFrame::len(self : GeointersecttriangleFrame) -> Int { self.size }

pub fn GeointersecttriangleFrame::get(self : GeointersecttriangleFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersecttriangleFrame::set(self : GeointersecttriangleFrame, i : Int, v : Double) -> GeointersecttriangleFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleFrame::sum(self : GeointersecttriangleFrame) -> Double { @_common.sum(self.data) }

pub fn GeointersecttriangleFrame::mean(self : GeointersecttriangleFrame) -> Double { @_common.mean(self.data) }

pub fn GeointersecttriangleFrame::scale(self : GeointersecttriangleFrame, f : Double) -> GeointersecttriangleFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleFrame::add(self : GeointersecttriangleFrame, other : GeointersecttriangleFrame) -> GeointersecttriangleFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersecttriangleFrame::copy(self : GeointersecttriangleFrame) -> GeointersecttriangleFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleFrame::fill(self : GeointersecttriangleFrame, v : Double) -> GeointersecttriangleFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleFrame::min(self : GeointersecttriangleFrame) -> Double { @_common.min(self.data) }

pub fn GeointersecttriangleFrame::max(self : GeointersecttriangleFrame) -> Double { @_common.max(self.data) }

pub fn GeointersecttriangleFrame::to_string(self : GeointersecttriangleFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_table_make(size : Int) -> GeointersecttriangleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersecttriangleTable::len(self : GeointersecttriangleTable) -> Int { self.size }

pub fn GeointersecttriangleTable::get(self : GeointersecttriangleTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersecttriangleTable::set(self : GeointersecttriangleTable, i : Int, v : Double) -> GeointersecttriangleTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleTable::sum(self : GeointersecttriangleTable) -> Double { @_common.sum(self.data) }

pub fn GeointersecttriangleTable::mean(self : GeointersecttriangleTable) -> Double { @_common.mean(self.data) }

pub fn GeointersecttriangleTable::scale(self : GeointersecttriangleTable, f : Double) -> GeointersecttriangleTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleTable::add(self : GeointersecttriangleTable, other : GeointersecttriangleTable) -> GeointersecttriangleTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersecttriangleTable::copy(self : GeointersecttriangleTable) -> GeointersecttriangleTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleTable::fill(self : GeointersecttriangleTable, v : Double) -> GeointersecttriangleTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleTable::min(self : GeointersecttriangleTable) -> Double { @_common.min(self.data) }

pub fn GeointersecttriangleTable::max(self : GeointersecttriangleTable) -> Double { @_common.max(self.data) }

pub fn GeointersecttriangleTable::to_string(self : GeointersecttriangleTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_graphn_make(size : Int) -> GeointersecttriangleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersecttriangleGraphN::len(self : GeointersecttriangleGraphN) -> Int { self.size }

pub fn GeointersecttriangleGraphN::get(self : GeointersecttriangleGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersecttriangleGraphN::set(self : GeointersecttriangleGraphN, i : Int, v : Double) -> GeointersecttriangleGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleGraphN::sum(self : GeointersecttriangleGraphN) -> Double { @_common.sum(self.data) }

pub fn GeointersecttriangleGraphN::mean(self : GeointersecttriangleGraphN) -> Double { @_common.mean(self.data) }

pub fn GeointersecttriangleGraphN::scale(self : GeointersecttriangleGraphN, f : Double) -> GeointersecttriangleGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleGraphN::add(self : GeointersecttriangleGraphN, other : GeointersecttriangleGraphN) -> GeointersecttriangleGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersecttriangleGraphN::copy(self : GeointersecttriangleGraphN) -> GeointersecttriangleGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleGraphN::fill(self : GeointersecttriangleGraphN, v : Double) -> GeointersecttriangleGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleGraphN::min(self : GeointersecttriangleGraphN) -> Double { @_common.min(self.data) }

pub fn GeointersecttriangleGraphN::max(self : GeointersecttriangleGraphN) -> Double { @_common.max(self.data) }

pub fn GeointersecttriangleGraphN::to_string(self : GeointersecttriangleGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_node_make(size : Int) -> GeointersecttriangleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersecttriangleNode::len(self : GeointersecttriangleNode) -> Int { self.size }

pub fn GeointersecttriangleNode::get(self : GeointersecttriangleNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersecttriangleNode::set(self : GeointersecttriangleNode, i : Int, v : Double) -> GeointersecttriangleNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleNode::sum(self : GeointersecttriangleNode) -> Double { @_common.sum(self.data) }

pub fn GeointersecttriangleNode::mean(self : GeointersecttriangleNode) -> Double { @_common.mean(self.data) }

pub fn GeointersecttriangleNode::scale(self : GeointersecttriangleNode, f : Double) -> GeointersecttriangleNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleNode::add(self : GeointersecttriangleNode, other : GeointersecttriangleNode) -> GeointersecttriangleNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersecttriangleNode::copy(self : GeointersecttriangleNode) -> GeointersecttriangleNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleNode::fill(self : GeointersecttriangleNode, v : Double) -> GeointersecttriangleNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleNode::min(self : GeointersecttriangleNode) -> Double { @_common.min(self.data) }

pub fn GeointersecttriangleNode::max(self : GeointersecttriangleNode) -> Double { @_common.max(self.data) }

pub fn GeointersecttriangleNode::to_string(self : GeointersecttriangleNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_edge_make(size : Int) -> GeointersecttriangleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersecttriangleEdge::len(self : GeointersecttriangleEdge) -> Int { self.size }

pub fn GeointersecttriangleEdge::get(self : GeointersecttriangleEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersecttriangleEdge::set(self : GeointersecttriangleEdge, i : Int, v : Double) -> GeointersecttriangleEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleEdge::sum(self : GeointersecttriangleEdge) -> Double { @_common.sum(self.data) }

pub fn GeointersecttriangleEdge::mean(self : GeointersecttriangleEdge) -> Double { @_common.mean(self.data) }

pub fn GeointersecttriangleEdge::scale(self : GeointersecttriangleEdge, f : Double) -> GeointersecttriangleEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleEdge::add(self : GeointersecttriangleEdge, other : GeointersecttriangleEdge) -> GeointersecttriangleEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersecttriangleEdge::copy(self : GeointersecttriangleEdge) -> GeointersecttriangleEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleEdge::fill(self : GeointersecttriangleEdge, v : Double) -> GeointersecttriangleEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleEdge::min(self : GeointersecttriangleEdge) -> Double { @_common.min(self.data) }

pub fn GeointersecttriangleEdge::max(self : GeointersecttriangleEdge) -> Double { @_common.max(self.data) }

pub fn GeointersecttriangleEdge::to_string(self : GeointersecttriangleEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersecttrianglePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_path_make(size : Int) -> GeointersecttrianglePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersecttrianglePath::len(self : GeointersecttrianglePath) -> Int { self.size }

pub fn GeointersecttrianglePath::get(self : GeointersecttrianglePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersecttrianglePath::set(self : GeointersecttrianglePath, i : Int, v : Double) -> GeointersecttrianglePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersecttrianglePath::sum(self : GeointersecttrianglePath) -> Double { @_common.sum(self.data) }

pub fn GeointersecttrianglePath::mean(self : GeointersecttrianglePath) -> Double { @_common.mean(self.data) }

pub fn GeointersecttrianglePath::scale(self : GeointersecttrianglePath, f : Double) -> GeointersecttrianglePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersecttrianglePath::add(self : GeointersecttrianglePath, other : GeointersecttrianglePath) -> GeointersecttrianglePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersecttrianglePath::copy(self : GeointersecttrianglePath) -> GeointersecttrianglePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersecttrianglePath::fill(self : GeointersecttrianglePath, v : Double) -> GeointersecttrianglePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersecttrianglePath::min(self : GeointersecttrianglePath) -> Double { @_common.min(self.data) }

pub fn GeointersecttrianglePath::max(self : GeointersecttrianglePath) -> Double { @_common.max(self.data) }

pub fn GeointersecttrianglePath::to_string(self : GeointersecttrianglePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_cluster_make(size : Int) -> GeointersecttriangleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersecttriangleCluster::len(self : GeointersecttriangleCluster) -> Int { self.size }

pub fn GeointersecttriangleCluster::get(self : GeointersecttriangleCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersecttriangleCluster::set(self : GeointersecttriangleCluster, i : Int, v : Double) -> GeointersecttriangleCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleCluster::sum(self : GeointersecttriangleCluster) -> Double { @_common.sum(self.data) }

pub fn GeointersecttriangleCluster::mean(self : GeointersecttriangleCluster) -> Double { @_common.mean(self.data) }

pub fn GeointersecttriangleCluster::scale(self : GeointersecttriangleCluster, f : Double) -> GeointersecttriangleCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleCluster::add(self : GeointersecttriangleCluster, other : GeointersecttriangleCluster) -> GeointersecttriangleCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersecttriangleCluster::copy(self : GeointersecttriangleCluster) -> GeointersecttriangleCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleCluster::fill(self : GeointersecttriangleCluster, v : Double) -> GeointersecttriangleCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleCluster::min(self : GeointersecttriangleCluster) -> Double { @_common.min(self.data) }

pub fn GeointersecttriangleCluster::max(self : GeointersecttriangleCluster) -> Double { @_common.max(self.data) }

pub fn GeointersecttriangleCluster::to_string(self : GeointersecttriangleCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_model_make(size : Int) -> GeointersecttriangleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersecttriangleModel::len(self : GeointersecttriangleModel) -> Int { self.size }

pub fn GeointersecttriangleModel::get(self : GeointersecttriangleModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersecttriangleModel::set(self : GeointersecttriangleModel, i : Int, v : Double) -> GeointersecttriangleModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleModel::sum(self : GeointersecttriangleModel) -> Double { @_common.sum(self.data) }

pub fn GeointersecttriangleModel::mean(self : GeointersecttriangleModel) -> Double { @_common.mean(self.data) }

pub fn GeointersecttriangleModel::scale(self : GeointersecttriangleModel, f : Double) -> GeointersecttriangleModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleModel::add(self : GeointersecttriangleModel, other : GeointersecttriangleModel) -> GeointersecttriangleModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersecttriangleModel::copy(self : GeointersecttriangleModel) -> GeointersecttriangleModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleModel::fill(self : GeointersecttriangleModel, v : Double) -> GeointersecttriangleModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleModel::min(self : GeointersecttriangleModel) -> Double { @_common.min(self.data) }

pub fn GeointersecttriangleModel::max(self : GeointersecttriangleModel) -> Double { @_common.max(self.data) }

pub fn GeointersecttriangleModel::to_string(self : GeointersecttriangleModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_layer_make(size : Int) -> GeointersecttriangleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersecttriangleLayer::len(self : GeointersecttriangleLayer) -> Int { self.size }

pub fn GeointersecttriangleLayer::get(self : GeointersecttriangleLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersecttriangleLayer::set(self : GeointersecttriangleLayer, i : Int, v : Double) -> GeointersecttriangleLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleLayer::sum(self : GeointersecttriangleLayer) -> Double { @_common.sum(self.data) }

pub fn GeointersecttriangleLayer::mean(self : GeointersecttriangleLayer) -> Double { @_common.mean(self.data) }

pub fn GeointersecttriangleLayer::scale(self : GeointersecttriangleLayer, f : Double) -> GeointersecttriangleLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleLayer::add(self : GeointersecttriangleLayer, other : GeointersecttriangleLayer) -> GeointersecttriangleLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersecttriangleLayer::copy(self : GeointersecttriangleLayer) -> GeointersecttriangleLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleLayer::fill(self : GeointersecttriangleLayer, v : Double) -> GeointersecttriangleLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleLayer::min(self : GeointersecttriangleLayer) -> Double { @_common.min(self.data) }

pub fn GeointersecttriangleLayer::max(self : GeointersecttriangleLayer) -> Double { @_common.max(self.data) }

pub fn GeointersecttriangleLayer::to_string(self : GeointersecttriangleLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_buffer_make(size : Int) -> GeointersecttriangleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersecttriangleBuffer::len(self : GeointersecttriangleBuffer) -> Int { self.size }

pub fn GeointersecttriangleBuffer::get(self : GeointersecttriangleBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersecttriangleBuffer::set(self : GeointersecttriangleBuffer, i : Int, v : Double) -> GeointersecttriangleBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleBuffer::sum(self : GeointersecttriangleBuffer) -> Double { @_common.sum(self.data) }

pub fn GeointersecttriangleBuffer::mean(self : GeointersecttriangleBuffer) -> Double { @_common.mean(self.data) }

pub fn GeointersecttriangleBuffer::scale(self : GeointersecttriangleBuffer, f : Double) -> GeointersecttriangleBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleBuffer::add(self : GeointersecttriangleBuffer, other : GeointersecttriangleBuffer) -> GeointersecttriangleBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersecttriangleBuffer::copy(self : GeointersecttriangleBuffer) -> GeointersecttriangleBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleBuffer::fill(self : GeointersecttriangleBuffer, v : Double) -> GeointersecttriangleBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleBuffer::min(self : GeointersecttriangleBuffer) -> Double { @_common.min(self.data) }

pub fn GeointersecttriangleBuffer::max(self : GeointersecttriangleBuffer) -> Double { @_common.max(self.data) }

pub fn GeointersecttriangleBuffer::to_string(self : GeointersecttriangleBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_cursor_make(size : Int) -> GeointersecttriangleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersecttriangleCursor::len(self : GeointersecttriangleCursor) -> Int { self.size }

pub fn GeointersecttriangleCursor::get(self : GeointersecttriangleCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersecttriangleCursor::set(self : GeointersecttriangleCursor, i : Int, v : Double) -> GeointersecttriangleCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleCursor::sum(self : GeointersecttriangleCursor) -> Double { @_common.sum(self.data) }

pub fn GeointersecttriangleCursor::mean(self : GeointersecttriangleCursor) -> Double { @_common.mean(self.data) }

pub fn GeointersecttriangleCursor::scale(self : GeointersecttriangleCursor, f : Double) -> GeointersecttriangleCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleCursor::add(self : GeointersecttriangleCursor, other : GeointersecttriangleCursor) -> GeointersecttriangleCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersecttriangleCursor::copy(self : GeointersecttriangleCursor) -> GeointersecttriangleCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleCursor::fill(self : GeointersecttriangleCursor, v : Double) -> GeointersecttriangleCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleCursor::min(self : GeointersecttriangleCursor) -> Double { @_common.min(self.data) }

pub fn GeointersecttriangleCursor::max(self : GeointersecttriangleCursor) -> Double { @_common.max(self.data) }

pub fn GeointersecttriangleCursor::to_string(self : GeointersecttriangleCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_view_make(size : Int) -> GeointersecttriangleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersecttriangleView::len(self : GeointersecttriangleView) -> Int { self.size }

pub fn GeointersecttriangleView::get(self : GeointersecttriangleView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersecttriangleView::set(self : GeointersecttriangleView, i : Int, v : Double) -> GeointersecttriangleView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleView::sum(self : GeointersecttriangleView) -> Double { @_common.sum(self.data) }

pub fn GeointersecttriangleView::mean(self : GeointersecttriangleView) -> Double { @_common.mean(self.data) }

pub fn GeointersecttriangleView::scale(self : GeointersecttriangleView, f : Double) -> GeointersecttriangleView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleView::add(self : GeointersecttriangleView, other : GeointersecttriangleView) -> GeointersecttriangleView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersecttriangleView::copy(self : GeointersecttriangleView) -> GeointersecttriangleView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleView::fill(self : GeointersecttriangleView, v : Double) -> GeointersecttriangleView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleView::min(self : GeointersecttriangleView) -> Double { @_common.min(self.data) }

pub fn GeointersecttriangleView::max(self : GeointersecttriangleView) -> Double { @_common.max(self.data) }

pub fn GeointersecttriangleView::to_string(self : GeointersecttriangleView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_range_make(size : Int) -> GeointersecttriangleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersecttriangleRange::len(self : GeointersecttriangleRange) -> Int { self.size }

pub fn GeointersecttriangleRange::get(self : GeointersecttriangleRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersecttriangleRange::set(self : GeointersecttriangleRange, i : Int, v : Double) -> GeointersecttriangleRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleRange::sum(self : GeointersecttriangleRange) -> Double { @_common.sum(self.data) }

pub fn GeointersecttriangleRange::mean(self : GeointersecttriangleRange) -> Double { @_common.mean(self.data) }

pub fn GeointersecttriangleRange::scale(self : GeointersecttriangleRange, f : Double) -> GeointersecttriangleRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleRange::add(self : GeointersecttriangleRange, other : GeointersecttriangleRange) -> GeointersecttriangleRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersecttriangleRange::copy(self : GeointersecttriangleRange) -> GeointersecttriangleRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleRange::fill(self : GeointersecttriangleRange, v : Double) -> GeointersecttriangleRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleRange::min(self : GeointersecttriangleRange) -> Double { @_common.min(self.data) }

pub fn GeointersecttriangleRange::max(self : GeointersecttriangleRange) -> Double { @_common.max(self.data) }

pub fn GeointersecttriangleRange::to_string(self : GeointersecttriangleRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_slice_make(size : Int) -> GeointersecttriangleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersecttriangleSlice::len(self : GeointersecttriangleSlice) -> Int { self.size }

pub fn GeointersecttriangleSlice::get(self : GeointersecttriangleSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersecttriangleSlice::set(self : GeointersecttriangleSlice, i : Int, v : Double) -> GeointersecttriangleSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleSlice::sum(self : GeointersecttriangleSlice) -> Double { @_common.sum(self.data) }

pub fn GeointersecttriangleSlice::mean(self : GeointersecttriangleSlice) -> Double { @_common.mean(self.data) }

pub fn GeointersecttriangleSlice::scale(self : GeointersecttriangleSlice, f : Double) -> GeointersecttriangleSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleSlice::add(self : GeointersecttriangleSlice, other : GeointersecttriangleSlice) -> GeointersecttriangleSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersecttriangleSlice::copy(self : GeointersecttriangleSlice) -> GeointersecttriangleSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleSlice::fill(self : GeointersecttriangleSlice, v : Double) -> GeointersecttriangleSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersecttriangleSlice::min(self : GeointersecttriangleSlice) -> Double { @_common.min(self.data) }

pub fn GeointersecttriangleSlice::max(self : GeointersecttriangleSlice) -> Double { @_common.max(self.data) }

pub fn GeointersecttriangleSlice::to_string(self : GeointersecttriangleSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

